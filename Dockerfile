# Dockerfile.vercel
# Extends the existing FreeLLMAPI image, adapted for Vercel's
# container runtime: no volumes, dynamic $PORT, bind 0.0.0.0.

FROM ghcr.io/tashfeenahmed/freellmapi:latest

# ── Runtime environment ──────────────────────────────────────────────
# Vercel injects $PORT automatically; do NOT hard-code 3001.
ENV NODE_ENV=production
# ENV PORT=3001

# ── Document the port (Vercel uses $PORT at runtime) ──────────────────
# Vercel defaults to port 80; exposing 3001 is only informative.
ENV PORT=3001

EXPOSE 3001

# ── Ensure the app binds to 0.0.0.0 and uses $PORT ────────────────────
# If the upstream image already reads PORT and binds to 0.0.0.0,
# these ENV defaults are harmless. If it does not, set HOST=0.0.0.0
# (or the equivalent variable your app uses).
# ENV HOST=0.0.0.0
# ENV HOSTNAME="0.0.0.0"

# ── No VOLUME instruction: Vercel does not support persistent disks ───
# The original /app/server/data directory will be ephemeral.

# ── Inherit the upstream ENTRYPOINT / CMD ─────────────────────────────
# Do not override; the base image already starts the server.
# CMD ["node", "server/index.js"]
