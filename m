Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH] powerpc/spufs: Initialize ctx->stats.tstamp correctly
Message-Id: <1235461477.530323.779245448843.1.gpush@pingu>
To: Ben Herrenschmidt <benh@kernel.crashing.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 24 Feb 2009 18:44:37 +1100
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Arnd Bergmann <arnd@arndb.de>

spuctx_switch_state() warns if ktime goes backwards, but it
sometimes compares an uninitialized value, which showed that
the data was unreliable when we actually saw the warning.

Initialize it to the current time in order to get correct data.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
Ben - another spufs patch for 2.6.30

---
 arch/powerpc/platforms/cell/spufs/context.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/context.c b/arch/powerpc/platforms/cell/spufs/context.c
index 6653ddb..db5398c 100644
--- a/arch/powerpc/platforms/cell/spufs/context.c
+++ b/arch/powerpc/platforms/cell/spufs/context.c
@@ -35,6 +35,8 @@ atomic_t nr_spu_contexts = ATOMIC_INIT(0);
 struct spu_context *alloc_spu_context(struct spu_gang *gang)
 {
 	struct spu_context *ctx;
+	struct timespec ts;
+
 	ctx = kzalloc(sizeof *ctx, GFP_KERNEL);
 	if (!ctx)
 		goto out;
@@ -64,6 +66,8 @@ struct spu_context *alloc_spu_context(struct spu_gang *gang)
 	__spu_update_sched_info(ctx);
 	spu_set_timeslice(ctx);
 	ctx->stats.util_state = SPU_UTIL_IDLE_LOADED;
+	ktime_get_ts(&ts);
+	ctx->stats.tstamp = timespec_to_ns(&ts);
 
 	atomic_inc(&nr_spu_contexts);
 	goto out;
