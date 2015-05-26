Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 11D591A1855
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 10:23:16 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v2 16/21] cxl: Configure PSL for kernel contexts and merge code
Date: Tue, 26 May 2015 10:20:13 +1000
Message-Id: <1432599618-26844-17-git-send-email-mikey@neuling.org>
In-Reply-To: <1432599618-26844-1-git-send-email-mikey@neuling.org>
References: <1432599618-26844-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This updates AFU directed and dedicated modes for contexts attached to the
kernel.

The SR (similar to the MSR in the core) calculation is getting
quite complex and is duplicated in AFU directed and dedicated
modes.  This patch also merges this SR calculation for these modes.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/native.c | 63 ++++++++++++++++++++++++++---------------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 615ccbf..a4b40d7 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -430,9 +430,30 @@ err:
 #define set_endian(sr) ((sr) &= ~(CXL_PSL_SR_An_LE))
 #endif
 
+static u64 calculate_sr(struct cxl_context *ctx)
+{
+	u64 sr = 0;
+
+	if (ctx->master)
+		sr |= CXL_PSL_SR_An_MP;
+	if (mfspr(SPRN_LPCR) & LPCR_TC)
+		sr |= CXL_PSL_SR_An_TC;
+	if (ctx->kernel) {
+		sr |= CXL_PSL_SR_An_R | (mfmsr() & MSR_SF);
+		sr |= CXL_PSL_SR_An_HV;
+	} else {
+		sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
+		set_endian(sr);
+		sr &= ~(CXL_PSL_SR_An_HV);
+		if (!test_tsk_thread_flag(current, TIF_32BIT))
+			sr |= CXL_PSL_SR_An_SF;
+	}
+	return sr;
+}
+
 static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 {
-	u64 sr;
+	u32 pid;
 	int r, result;
 
 	cxl_assign_psn_space(ctx);
@@ -442,22 +463,13 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 	ctx->elem->haurp = 0; /* disable */
 	ctx->elem->sdr = cpu_to_be64(mfspr(SPRN_SDR1));
 
-	sr = 0;
-	if (ctx->master)
-		sr |= CXL_PSL_SR_An_MP;
-	if (mfspr(SPRN_LPCR) & LPCR_TC)
-		sr |= CXL_PSL_SR_An_TC;
-	/* HV=0, PR=1, R=1 for userspace
-	 * For kernel contexts: this would need to change
-	 */
-	sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
-	set_endian(sr);
-	sr &= ~(CXL_PSL_SR_An_HV);
-	if (!test_tsk_thread_flag(current, TIF_32BIT))
-		sr |= CXL_PSL_SR_An_SF;
-	ctx->elem->common.pid = cpu_to_be32(current->pid);
+	pid = current->pid;
+	if (ctx->kernel)
+		pid = 0;
 	ctx->elem->common.tid = 0;
-	ctx->elem->sr = cpu_to_be64(sr);
+	ctx->elem->common.pid = cpu_to_be32(pid);
+
+	ctx->elem->sr = cpu_to_be64(calculate_sr(ctx));
 
 	ctx->elem->common.csrp = 0; /* disable */
 	ctx->elem->common.aurp0 = 0; /* disable */
@@ -530,20 +542,15 @@ static int activate_dedicated_process(struct cxl_afu *afu)
 static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
 {
 	struct cxl_afu *afu = ctx->afu;
-	u64 sr;
+	u64 pid;
 	int rc;
 
-	sr = 0;
-	set_endian(sr);
-	if (ctx->master)
-		sr |= CXL_PSL_SR_An_MP;
-	if (mfspr(SPRN_LPCR) & LPCR_TC)
-		sr |= CXL_PSL_SR_An_TC;
-	sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
-	if (!test_tsk_thread_flag(current, TIF_32BIT))
-		sr |= CXL_PSL_SR_An_SF;
-	cxl_p2n_write(afu, CXL_PSL_PID_TID_An, (u64)current->pid << 32);
-	cxl_p1n_write(afu, CXL_PSL_SR_An, sr);
+	pid = (u64)current->pid << 32;
+	if (ctx->kernel)
+		pid = 0;
+	cxl_p2n_write(afu, CXL_PSL_PID_TID_An, pid);
+
+	cxl_p1n_write(afu, CXL_PSL_SR_An, calculate_sr(ctx));
 
 	if ((rc = cxl_write_sstp(afu, ctx->sstp0, ctx->sstp1)))
 		return rc;
-- 
2.1.0
