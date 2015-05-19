Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 141831A0627
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:23:23 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Subject: [PATCH 15/19] cxl: Configure PSL for kernel contexts
Date: Tue, 19 May 2015 21:22:32 +1000
Message-Id: <1432034556-32400-16-git-send-email-mikey@neuling.org>
In-Reply-To: <1432034556-32400-1-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com,
 Daniel Axtens <dja@axtens.net>
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

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 drivers/misc/cxl/native.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index f643bb1..55078f6 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -433,6 +433,7 @@ err:
 static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 {
 	u64 sr;
+	u32 pid;
 	int r, result;
 
 	assign_psn_space(ctx);
@@ -447,15 +448,19 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 		sr |= CXL_PSL_SR_An_MP;
 	if (mfspr(SPRN_LPCR) & LPCR_TC)
 		sr |= CXL_PSL_SR_An_TC;
-	/* HV=0, PR=1, R=1 for userspace
-	 * For kernel contexts: this would need to change
-	 */
-	sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
-	set_endian(sr);
-	sr &= ~(CXL_PSL_SR_An_HV);
-	if (!test_tsk_thread_flag(current, TIF_32BIT))
-		sr |= CXL_PSL_SR_An_SF;
-	ctx->elem->common.pid = cpu_to_be32(current->pid);
+
+	if (ctx->kernel) {
+		sr |= CXL_PSL_SR_An_R | (mfmsr() & MSR_SF) | CXL_PSL_SR_An_HV;
+		pid = 0;
+	} else {
+		sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
+		set_endian(sr);
+		sr &= ~(CXL_PSL_SR_An_HV);
+		if (!test_tsk_thread_flag(current, TIF_32BIT))
+			sr |= CXL_PSL_SR_An_SF;
+		pid = current->pid;
+	}
+	ctx->elem->common.pid = cpu_to_be32(pid);
 	ctx->elem->common.tid = 0;
 	ctx->elem->sr = cpu_to_be64(sr);
 
@@ -530,7 +535,7 @@ static int activate_dedicated_process(struct cxl_afu *afu)
 static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
 {
 	struct cxl_afu *afu = ctx->afu;
-	u64 sr;
+	u64 sr, pid;
 	int rc;
 
 	sr = 0;
@@ -539,10 +544,17 @@ static int attach_dedicated(struct cxl_context *ctx, u64 wed, u64 amr)
 		sr |= CXL_PSL_SR_An_MP;
 	if (mfspr(SPRN_LPCR) & LPCR_TC)
 		sr |= CXL_PSL_SR_An_TC;
-	sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
-	if (!test_tsk_thread_flag(current, TIF_32BIT))
-		sr |= CXL_PSL_SR_An_SF;
-	cxl_p2n_write(afu, CXL_PSL_PID_TID_An, (u64)current->pid << 32);
+
+	if (ctx->kernel) {
+		sr |= CXL_PSL_SR_An_R | (mfmsr() & MSR_SF) | CXL_PSL_SR_An_HV;
+		pid = 0;
+	} else { /* User space */
+		sr |= CXL_PSL_SR_An_PR | CXL_PSL_SR_An_R;
+		if (!test_tsk_thread_flag(current, TIF_32BIT))
+			sr |= CXL_PSL_SR_An_SF;
+		pid = (u64)current->pid << 32;
+	}
+	cxl_p2n_write(afu, CXL_PSL_PID_TID_An, pid);
 	cxl_p1n_write(afu, CXL_PSL_SR_An, sr);
 
 	if ((rc = cxl_write_sstp(afu, ctx->sstp0, ctx->sstp1)))
-- 
2.1.0
