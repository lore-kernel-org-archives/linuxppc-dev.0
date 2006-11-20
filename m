Return-Path: <arnd@arndb.de>
Message-Id: <20061120180523.820143000@arndb.de>
References: <20061120174454.067872000@arndb.de>
Date: Mon, 20 Nov 2006 18:45:04 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: [PATCH 10/22] spufs: fix missing stop-and-signal
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

When there is pending signals, current spufs_run_spu() always returns 
-ERESTARTSYS and it is called again automatically.
But, if spe already stopped by stop-and-signal or halt instruction,
returning -ERESTARTSYS makes stop-and-signal/halt lost and 
spu run over the end-point.

For your convenience, I attached a sample code to restage this bug.
If there is no bug, printed NPC will be 0x4000.

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 run.c |   28 ++++++++++++++++++----------
 1 files changed, 18 insertions(+), 10 deletions(-)


Index: linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/run.c
@@ -79,13 +79,7 @@ static inline int spu_run_fini(struct sp
 
 	if (signal_pending(current))
 		ret = -ERESTARTSYS;
-	if (unlikely(current->ptrace & PT_PTRACED)) {
-		if ((*status & SPU_STATUS_STOPPED_BY_STOP)
-		    && (*status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
-			force_sig(SIGTRAP, current);
-			ret = -ERESTARTSYS;
-		}
-	}
+
 	return ret;
 }
 
@@ -232,7 +226,7 @@ long spufs_run_spu(struct file *file, st
 		if (unlikely(ctx->state != SPU_STATE_RUNNABLE)) {
 			ret = spu_reacquire_runnable(ctx, npc, &status);
 			if (ret)
-				goto out;
+				goto out2;
 			continue;
 		}
 		ret = spu_process_events(ctx);
@@ -242,10 +236,24 @@ long spufs_run_spu(struct file *file, st
 
 	ctx->ops->runcntl_stop(ctx);
 	ret = spu_run_fini(ctx, npc, &status);
-	if (!ret)
-		ret = status;
 	spu_yield(ctx);
 
+out2:
+	if ((ret == 0) ||
+	    ((ret == -ERESTARTSYS) &&
+	     ((status & SPU_STATUS_STOPPED_BY_HALT) ||
+	      ((status & SPU_STATUS_STOPPED_BY_STOP) &&
+	       (status >> SPU_STOP_STATUS_SHIFT != 0x2104)))))
+		ret = status;
+
+	if (unlikely(current->ptrace & PT_PTRACED)) {
+		if ((status & SPU_STATUS_STOPPED_BY_STOP)
+		    && (status >> SPU_STOP_STATUS_SHIFT) == 0x3fff) {
+			force_sig(SIGTRAP, current);
+			ret = -ERESTARTSYS;
+		}
+	}
+
 out:
 	*event = ctx->event_return;
 	up(&ctx->run_sema);

--
