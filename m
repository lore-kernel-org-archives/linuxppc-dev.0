Return-Path: <jk@ozlabs.org>
To: <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Tue, 05 Jun 2007 09:25:59 +0800
Subject: [PATCH] spufs: don't yield nosched context
Message-Id: <1181006759.895317.924309156325.qpush@pokey>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org, hch@lst.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Christoph Hellwig <hch@lst.de>

Nosched context sould never be scheduled out, thus we must not
deactivate them in spu_yield ever.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---

Paulus - this is also a contender for 2.6.22 bugfixes.

---

 arch/powerpc/platforms/cell/spufs/sched.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/sched.c
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/sched.c
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/sched.c
@@ -430,9 +430,11 @@ void spu_deactivate(struct spu_context *
  */
 void spu_yield(struct spu_context *ctx)
 {
-	mutex_lock(&ctx->state_mutex);
-	__spu_deactivate(ctx, 0, MAX_PRIO);
-	mutex_unlock(&ctx->state_mutex);
+	if (!(ctx->flags & SPU_CREATE_NOSCHED)) {
+		mutex_lock(&ctx->state_mutex);
+		__spu_deactivate(ctx, 0, MAX_PRIO);
+		mutex_unlock(&ctx->state_mutex);
+	}
 }
 
 void spu_sched_tick(struct work_struct *work)
