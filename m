Return-Path: <imunsie@au1.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r05Kr6FBPzDqDW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:54:08 +1000 (AEST)
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Wed, 4 May 2016 14:54:08 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9749F2CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 May 2016 14:54:05 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u444rw4k917764
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:54:05 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u444rWwu010033
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2016 14:53:32 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, mikey <mikey@neuling.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Frederic Barrat <frederic.barrat@fr.ibm.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] cxl: Ensure PSL interrupt is configured for contexts with no
 AFU IRQs
Date: Wed,  4 May 2016 14:52:58 +1000
Message-Id: <1462337578-15883-1-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

In the cxl kernel API, it is possible to create a context and start it
without allocating any interrupts. Since we assign or allocate the PSL
interrupt when allocating AFU interrupts this will lead to a situation
where we start the context with no means to take any faults.

The user API is not affected as it always goes through the cxl interrupt
allocation code paths and will have the PSL interrupt allocated or
assigned, even if no AFU interrupts were requested.

This checks that at least one interrupt is configured at the time of
attach, and if not it will assign the multiplexed PSL interrupt for
powernv, or allocate a single interrupt for PowerVM.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/guest.c  | 12 ++++++++++++
 drivers/misc/cxl/native.c |  9 +++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index c0cdf3c..04f6dff 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -552,6 +552,17 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 
 	elem->common.sstp0  = cpu_to_be64(ctx->sstp0);
 	elem->common.sstp1  = cpu_to_be64(ctx->sstp1);
+
+	/*
+	 * Ensure we have at least one interrupt allocated to take faults for
+	 * kernel contexts that may not have allocated any AFU IRQs at all:
+	 */
+	if (ctx->irqs.range[0] == 0) {
+		rc = afu_register_irqs(ctx, 0);
+		if (rc)
+			goto out_free;
+	}
+
 	for (r = 0; r < CXL_IRQ_RANGES; r++) {
 		for (i = 0; i < ctx->irqs.range[r]; i++) {
 			if (r == 0 && i == 0) {
@@ -597,6 +608,7 @@ static int attach_afu_directed(struct cxl_context *ctx, u64 wed, u64 amr)
 		enable_afu_irqs(ctx);
 	}
 
+out_free:
 	free_page((u64)elem);
 	return rc;
 }
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index f933129..5b51183 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -527,6 +527,15 @@ static int attach_afu_directed(struct cxl_context *ctx, bool real_mode, u64 wed,
 	ctx->elem->common.sstp0 = cpu_to_be64(ctx->sstp0);
 	ctx->elem->common.sstp1 = cpu_to_be64(ctx->sstp1);
 
+	/*
+	 * Ensure we have the multiplexed PSL interrupt set up to take faults
+	 * for kernel contexts that may not have allocated any AFU IRQs at all:
+	 */
+	if (ctx->irqs.range[0] == 0) {
+		ctx->irqs.offset[0] = ctx->afu->native->psl_hwirq;
+		ctx->irqs.range[0] = 1;
+	}
+
 	for (r = 0; r < CXL_IRQ_RANGES; r++) {
 		ctx->elem->ivte_offsets[r] = cpu_to_be16(ctx->irqs.offset[r]);
 		ctx->elem->ivte_ranges[r] = cpu_to_be16(ctx->irqs.range[r]);
-- 
2.1.4
