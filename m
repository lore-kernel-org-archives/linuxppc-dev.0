Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:37 +1000
Subject: [PATCH 3/21] spufs: Add support for SPU single stepping
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051542.43B6CDDE27@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds support for SPU single stepping. The single
step bit is set in the SPU when the current process is
being single-stepped via ptrace. The spu then stops and
returns with a specific flag set and the syscall exit code
will generate the SIGTRAP.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
--- 

 arch/powerpc/platforms/cell/spufs/run.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

Index: linux-cell/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/run.c	2007-05-25 13:00:31.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spufs/run.c	2007-05-25 13:14:54.000000000 +1000
@@ -142,8 +142,12 @@ static int spu_run_init(struct spu_conte
 			runcntl = SPU_RUNCNTL_RUNNABLE;
 		ctx->ops->runcntl_write(ctx, runcntl);
 	} else {
+		unsigned long mode = SPU_PRIVCNTL_MODE_NORMAL;
 		spu_start_tick(ctx);
 		ctx->ops->npc_write(ctx, *npc);
+		if (test_thread_flag(TIF_SINGLESTEP))
+			mode = SPU_PRIVCNTL_MODE_SINGLE_STEP;
+		out_be64(&ctx->spu->priv2->spu_privcntl_RW, mode);
 		ctx->ops->runcntl_write(ctx, SPU_RUNCNTL_RUNNABLE);
 	}
 
@@ -334,7 +338,8 @@ long spufs_run_spu(struct file *file, st
 		ret = spu_process_events(ctx);
 
 	} while (!ret && !(status & (SPU_STATUS_STOPPED_BY_STOP |
-				      SPU_STATUS_STOPPED_BY_HALT)));
+				      SPU_STATUS_STOPPED_BY_HALT |
+				       SPU_STATUS_SINGLE_STEP)));
 
 	ctx->ops->master_stop(ctx);
 	ret = spu_run_fini(ctx, npc, &status);
@@ -344,10 +349,15 @@ out2:
 	if ((ret == 0) ||
 	    ((ret == -ERESTARTSYS) &&
 	     ((status & SPU_STATUS_STOPPED_BY_HALT) ||
+	      (status & SPU_STATUS_SINGLE_STEP) ||
 	      ((status & SPU_STATUS_STOPPED_BY_STOP) &&
 	       (status >> SPU_STOP_STATUS_SHIFT != 0x2104)))))
 		ret = status;
 
+	/* Note: we don't need to force_sig SIGTRAP on single-step
+	 * since we have TIF_SINGLESTEP set, thus the kernel will do
+	 * it upon return from the syscall anyawy
+	 */
 	if ((status & SPU_STATUS_STOPPED_BY_STOP)
 	    && (status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
 		force_sig(SIGTRAP, current);
