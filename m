Return-Path: <felix@linux.vnet.ibm.com>
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4dNF6PS8zDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 00:11:57 +1000 (AEST)
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Wed, 11 May 2016 15:11:53 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id 41DD717D80CF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 15:12:03 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4BEB5B311403608
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 14:11:05 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4BEB420030158
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 May 2016 08:11:05 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, imunsie@au1.ibm.com, mikey@neuling.org,
 Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH] cxl: Refine slice error debug messages.
Date: Wed, 11 May 2016 16:10:53 +0200
Message-Id: <1462975853-28904-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---

 drivers/misc/cxl/cxl.h    | 15 +++++++++++++++
 drivers/misc/cxl/guest.c  | 11 ++++++++---
 drivers/misc/cxl/irq.c    | 27 +++++++++++++++++++++++++++
 drivers/misc/cxl/native.c | 27 ++++++++++++++++++---------
 4 files changed, 68 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 73dc2a3..a904f86 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -191,6 +191,18 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_PSL_ID_An_F	(1ull << (63-31))
 #define CXL_PSL_ID_An_L	(1ull << (63-30))
 
+/****** CXL_PSL_SERR_An ****************************************************/
+#define CXL_PSL_SERR_An_afuto	(1ull << (63-0))
+#define CXL_PSL_SERR_An_afudis	(1ull << (63-1))
+#define CXL_PSL_SERR_An_afuov	(1ull << (63-2))
+#define CXL_PSL_SERR_An_badsrc	(1ull << (63-3))
+#define CXL_PSL_SERR_An_badctx	(1ull << (63-4))
+#define CXL_PSL_SERR_An_llcmdis	(1ull << (63-5))
+#define CXL_PSL_SERR_An_llcmdto	(1ull << (63-6))
+#define CXL_PSL_SERR_An_afupar	(1ull << (63-7))
+#define CXL_PSL_SERR_An_afudup	(1ull << (63-8))
+#define CXL_PSL_SERR_An_AE	(1ull << (63-30))
+
 /****** CXL_PSL_SCNTL_An ****************************************************/
 #define CXL_PSL_SCNTL_An_CR          (0x1ull << (63-15))
 /* Programming Modes: */
@@ -884,4 +896,7 @@ extern const struct cxl_backend_ops *cxl_ops;
 
 /* check if the given pci_dev is on the the cxl vphb bus */
 bool cxl_pci_is_vphb_device(struct pci_dev *dev);
+
+/* decode AFU error bits in the PSL register PSL_SERR_An */
+void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr);
 #endif
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index 8213372..9de113c 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -193,15 +193,20 @@ static irqreturn_t guest_slice_irq_err(int irq, void *data)
 {
 	struct cxl_afu *afu = data;
 	int rc;
-	u64 serr;
+	u64 serr, afu_error, dsisr;
 
-	WARN(irq, "CXL SLICE ERROR interrupt %i\n", irq);
+	dev_crit(&afu->dev,
+		 "PSL Slice error received. Check AFU for root cause\n");
 	rc = cxl_h_get_fn_error_interrupt(afu->guest->handle, &serr);
 	if (rc) {
 		dev_crit(&afu->dev, "Couldn't read PSL_SERR_An: %d\n", rc);
 		return IRQ_HANDLED;
 	}
-	dev_crit(&afu->dev, "PSL_SERR_An: 0x%.16llx\n", serr);
+	afu_error = cxl_p2n_read(afu, CXL_AFU_ERR_An);
+	dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
+	cxl_afu_decode_psl_serr(afu, serr);
+	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
+	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
 
 	rc = cxl_h_ack_fn_error_interrupt(afu->guest->handle, serr);
 	if (rc)
diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 8def455..9e63734 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -374,3 +374,30 @@ void afu_release_irqs(struct cxl_context *ctx, void *cookie)
 
 	ctx->irq_count = 0;
 }
+
+void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr)
+{
+	dev_crit(&afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
+	if (serr & CXL_PSL_SERR_An_afuto)
+		dev_crit(&afu->dev, "AFU MMIO Timeout\n");
+	if (serr & CXL_PSL_SERR_An_afudis)
+		dev_crit(&afu->dev,
+			 "MMIO targeted Accelerator that was not enabled\n");
+	if (serr & CXL_PSL_SERR_An_afuov)
+		dev_crit(&afu->dev, "AFU CTAG Overflow\n");
+	if (serr & CXL_PSL_SERR_An_badsrc)
+		dev_crit(&afu->dev, "Bad Interrupt Source\n");
+	if (serr & CXL_PSL_SERR_An_badctx)
+		dev_crit(&afu->dev, "Bad Context Handle\n");
+	if (serr & CXL_PSL_SERR_An_llcmdis)
+		dev_crit(&afu->dev, "LLCMD to Disabled AFU\n");
+	if (serr & CXL_PSL_SERR_An_llcmdto)
+		dev_crit(&afu->dev, "LLCMD Timeout to AFU\n");
+	if (serr & CXL_PSL_SERR_An_afupar)
+		dev_crit(&afu->dev, "AFU MMIO Parity Error\n");
+	if (serr & CXL_PSL_SERR_An_afudup)
+		dev_crit(&afu->dev, "AFU MMIO Duplicate CTAG Error\n");
+	if (serr & CXL_PSL_SERR_An_AE)
+		dev_crit(&afu->dev,
+			 "AFU asserted JDONE with JERROR in AFU Directed Mode\n");
+}
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index ecf7557..46b6ee1 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -738,20 +738,25 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
 static irqreturn_t native_handle_psl_slice_error(struct cxl_context *ctx,
 						u64 dsisr, u64 errstat)
 {
-	u64 fir1, fir2, fir_slice, serr, afu_debug;
+	u64 fir1, fir2, fir_slice, serr, afu_debug, afu_error;
 
 	fir1 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR1);
 	fir2 = cxl_p1_read(ctx->afu->adapter, CXL_PSL_FIR2);
 	fir_slice = cxl_p1n_read(ctx->afu, CXL_PSL_FIR_SLICE_An);
 	serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
 	afu_debug = cxl_p1n_read(ctx->afu, CXL_AFU_DEBUG_An);
+	afu_error = cxl_p2n_read(ctx->afu, CXL_AFU_ERR_An);
 
+	dev_crit(&ctx->afu->dev,
+		 "PSL Slice error received. Check AFU for root cause\n");
 	dev_crit(&ctx->afu->dev, "PSL ERROR STATUS: 0x%016llx\n", errstat);
 	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%016llx\n", fir1);
 	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
-	dev_crit(&ctx->afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
+	cxl_afu_decode_psl_serr(ctx->afu, serr);
 	dev_crit(&ctx->afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
-	dev_crit(&ctx->afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
+	dev_crit(&ctx->afu->dev, "PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
+	dev_crit(&ctx->afu->dev, "AFU_ERR_An: 0x%016llx\n", afu_error);
+	dev_crit(&ctx->afu->dev, "PSL_DSISR_An: 0x%016llx\n", dsisr);
 
 	dev_crit(&ctx->afu->dev, "STOPPING CXL TRACE\n");
 	cxl_stop_trace(ctx->afu->adapter);
@@ -830,18 +835,22 @@ void native_irq_wait(struct cxl_context *ctx)
 static irqreturn_t native_slice_irq_err(int irq, void *data)
 {
 	struct cxl_afu *afu = data;
-	u64 fir_slice, errstat, serr, afu_debug;
-
-	WARN(irq, "CXL SLICE ERROR interrupt %i\n", irq);
+	u64 fir_slice, errstat, serr, afu_debug, afu_error, dsisr;
 
 	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
 	fir_slice = cxl_p1n_read(afu, CXL_PSL_FIR_SLICE_An);
 	errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
 	afu_debug = cxl_p1n_read(afu, CXL_AFU_DEBUG_An);
-	dev_crit(&afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
+	afu_error = cxl_p2n_read(afu, CXL_AFU_ERR_An);
+	dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
+	dev_crit(&afu->dev,
+		 "PSL Slice error received. Check AFU for root cause\n");
+	cxl_afu_decode_psl_serr(afu, serr);
 	dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
-	dev_crit(&afu->dev, "CXL_PSL_ErrStat_An: 0x%016llx\n", errstat);
-	dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
+	dev_crit(&afu->dev, "PSL_ErrStat_An: 0x%016llx\n", errstat);
+	dev_crit(&afu->dev, "PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
+	dev_crit(&afu->dev, "AFU_ERR_An: 0x%016llx\n", afu_error);
+	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%016llx\n", dsisr);
 
 	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
 
-- 
2.1.0
