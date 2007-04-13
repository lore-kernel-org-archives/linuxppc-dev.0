Return-Path: <jk@ozlabs.org>
To: <cbe-oss-dev@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 13 Apr 2007 11:48:59 +1000
Subject: [PATCH 2/4] spufs: Minor cleanup of spu_wait
Message-Id: <1176428939.306624.199053139724.qpush@pokey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the loop in spu_wait to be a little more straightforward.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

 arch/powerpc/platforms/cell/spufs/spufs.h |   13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/spufs.h
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/spufs.h
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -218,14 +218,13 @@ extern char *isolated_loader;
 		prepare_to_wait(&(wq), &__wait, TASK_INTERRUPTIBLE);	\
 		if (condition)						\
 			break;						\
-		if (!signal_pending(current)) {				\
-			spu_release(ctx);				\
-			schedule();					\
-			spu_acquire(ctx);				\
-			continue;					\
+		if (signal_pending(current)) {				\
+			__ret = -ERESTARTSYS;				\
+			break;						\
 		}							\
-		__ret = -ERESTARTSYS;					\
-		break;							\
+		spu_release(ctx);					\
+		schedule();						\
+		spu_acquire(ctx);					\
 	}								\
 	finish_wait(&(wq), &__wait);					\
 	__ret;								\
