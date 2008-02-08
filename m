Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 4/4] spufs: fix timing dependent false return from
	spufs_run_spu
Message-Id: <1202446241.802632.835156785521.4.gpush@pokey>
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

Stop bits are only valid when the running bit is not set. Status bits carry
over from one invocation of spufs_run_spu() to another, so the RUNNING bit
gets added to the previous state of the register which may have been a remote
library call.  In this case, it looks like another library routine should be
invoked, but the spe is actually running.

This fixes a problem with a testcase that exercises the scheduler.

Signed-off-by: Luke Browning <lukebrowning@us.ibm.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/run.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index f401e51..fca22e1 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -53,7 +53,7 @@ int spu_stopped(struct spu_context *ctx, u32 *stat)
 
 	stopped = SPU_STATUS_INVALID_INSTR | SPU_STATUS_SINGLE_STEP |
 		SPU_STATUS_STOPPED_BY_HALT | SPU_STATUS_STOPPED_BY_STOP;
-	if (*stat & stopped)
+	if (!(*stat & SPU_STATUS_RUNNING) && (*stat & stopped))
 		return 1;
 
 	dsisr = ctx->csa.dsisr;
