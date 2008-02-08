Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 3/4] spufs: no need to have a runnable SPU for libassist update
Message-Id: <1202446241.802135.705426782144.3.gpush@pokey>
In-Reply-To: <1202446241.799868.442184577655.0.gpush@pokey>
To: Paul Mackerras <paulus@samba.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 08 Feb 2008 15:50:41 +1100
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Luke Browning <lukebr@linux.vnet.ibm.com>

We don't need to update the libassist statistic with the context in a
runnable state, so do it after spu_disable_spu().

Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
Acked-by: Christoph Hellwig <hch@lst.de>

---
 arch/powerpc/platforms/cell/spufs/run.c |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index e9c61a1..f401e51 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -395,16 +395,14 @@ long spufs_run_spu(struct spu_context *ctx, u32 *npc, u32 *event)
 				      SPU_STATUS_STOPPED_BY_HALT |
 				       SPU_STATUS_SINGLE_STEP)));
 
-	if ((status & SPU_STATUS_STOPPED_BY_STOP) &&
-	    (((status >> SPU_STOP_STATUS_SHIFT) & 0x3f00) == 0x2100) &&
-	    (ctx->state == SPU_STATE_RUNNABLE))
-		ctx->stats.libassist++;
-
-
 	spu_disable_spu(ctx);
 	ret = spu_run_fini(ctx, npc, &status);
 	spu_yield(ctx);
 
+	if ((status & SPU_STATUS_STOPPED_BY_STOP) &&
+	    (((status >> SPU_STOP_STATUS_SHIFT) & 0x3f00) == 0x2100))
+		ctx->stats.libassist++;
+
 	if ((ret == 0) ||
 	    ((ret == -ERESTARTSYS) &&
 	     ((status & SPU_STATUS_STOPPED_BY_HALT) ||
