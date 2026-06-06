#!/usr/bin/env bash
set -euo pipefail

dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
uv="$dir/ultraviolet"
patch="$dir/ultraviolet.patch"
repo="https://github.com/titaniumnetwork-dev/Ultraviolet.git"

if [ ! -d "$uv/.git" ]; then
  git clone --quiet "$repo" "$uv"
fi

cd "$uv"
git fetch --quiet origin
git clean -fdx -e node_modules >/dev/null
git apply --whitespace=nowarn "$patch"
pnpm install --ignore-scripts --ignore-workspace --silent
pnpm build