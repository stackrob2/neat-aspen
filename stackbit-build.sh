#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://e9fcae35.ngrok.io/project/5dea14e1281b594503ef0029/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://e9fcae35.ngrok.io/pull/5dea14e1281b594503ef0029 
fi
curl -s -X POST https://e9fcae35.ngrok.io/project/5dea14e1281b594503ef0029/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://e9fcae35.ngrok.io/project/5dea14e1281b594503ef0029/webhook/build/publish > /dev/null
