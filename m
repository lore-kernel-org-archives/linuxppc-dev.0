Return-Path: <jk@ozlabs.org>
To: <cbe-oss-dev@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 13 Apr 2007 11:48:58 +1000
Subject: [PATCH 1/4] spufs: clean up logic in spu_reacquire_runnable
Message-Id: <1176428938.598660.69304866740.qpush@pokey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

spu_reacquire_runnable has an overly-complex way of calculating its
return value. This change fixes it.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

 arch/powerpc/platforms/cell/spufs/run.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/run.c
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/run.c
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/run.c
@@ -200,9 +200,7 @@ static inline int spu_reacquire_runnable
 		       SPU_STATUS_STOPPED_BY_HALT)) {
 		return *status;
 	}
-	if ((ret = spu_run_init(ctx, npc)) != 0)
-		return ret;
-	return 0;
+	return spu_run_init(ctx, npc);
 }
 
 /*
