Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 2/4] spufs: update SPU_Status[CISHP] in backing runcntl write
Message-Id: <1202446241.801608.714016806018.2.gpush@pokey>
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

From: Masato Noguchi <Masato.Noguchi@jp.sony.com>

Currently, the kernel may fail to restart a SPE context which
has stopped and been swapped out.

This patch changes spu_backing_runcntl_write to emulate the real
SPU_Status register exactly.  When the SPU Run Control register
is written with SPU_RunCntl[Run] set to '1', the physical SPU
automatically sets SPU_Status[R] and clears SPU_Status[CISHP].

Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spufs/backing_ops.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/platforms/cell/spufs/backing_ops.c b/arch/powerpc/platforms/cell/spufs/backing_ops.c
index 50d98a1..64eb15b 100644
--- a/arch/powerpc/platforms/cell/spufs/backing_ops.c
+++ b/arch/powerpc/platforms/cell/spufs/backing_ops.c
@@ -288,6 +288,12 @@ static void spu_backing_runcntl_write(struct spu_context *ctx, u32 val)
 	spin_lock(&ctx->csa.register_lock);
 	ctx->csa.prob.spu_runcntl_RW = val;
 	if (val & SPU_RUNCNTL_RUNNABLE) {
+		ctx->csa.prob.spu_status_R &=
+			~SPU_STATUS_STOPPED_BY_STOP &
+			~SPU_STATUS_STOPPED_BY_HALT &
+			~SPU_STATUS_SINGLE_STEP &
+			~SPU_STATUS_INVALID_INSTR &
+			~SPU_STATUS_INVALID_CH;
 		ctx->csa.prob.spu_status_R |= SPU_STATUS_RUNNING;
 	} else {
 		ctx->csa.prob.spu_status_R &= ~SPU_STATUS_RUNNING;
