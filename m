Return-Path: <felix@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkLhx1DgLzDqpT
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 21:08:16 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u65B3gnA017509
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 07:08:14 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x6gk0kuv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jul 2016 07:08:13 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <felix@linux.vnet.ibm.com>;
 Tue, 5 Jul 2016 12:08:11 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 34B9E1B08069
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 12:09:27 +0100 (BST)
Received: from d06av08.portsmouth.uk.ibm.com (d06av08.portsmouth.uk.ibm.com
 [9.149.37.249])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u65B89Bs54132806
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 11:08:09 GMT
Received: from d06av08.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av08.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u65B88LX002762
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2016 05:08:09 -0600
From: Philippe Bergheaud <felix@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 mikey@neuling.org, Philippe Bergheaud <felix@linux.vnet.ibm.com>
Subject: [PATCH v3] cxl: Refine slice error debug messages
Date: Tue,  5 Jul 2016 13:08:06 +0200
Message-Id: <1467716886-20991-1-git-send-email-felix@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PSL Slice Error Register (PSL_SERR_An) reports implementation
dependent AFU errors, in the form of a bitmap. The PSL_SERR_An
register content is printed in the form of hex dump debug message.

This patch decodes the PSL_ERR_An register contents, and prints a
specific error message for each possible error bit. It also dumps
the secondary registers AFU_ERR_An and PSL_DSISR_An, that may
contain extra debug information.

This patch also removes the large WARN message that used to report
the cxl slice error interrupt, and replaces it by a short informative
message, that draws attention to AFU implementation errors.

Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
---
Changes since v1:
  - Rebased on Ian's patch
    "cxl: Abstract the differences between the PSL and XSL"

Changes since v2:
  - Added description

 drivers/misc/cxl/cxl.h    | 15 +++++++++++++++
 drivers/misc/cxl/guest.c  |  9 ++++++---
 drivers/misc/cxl/irq.c    | 29 +++++++++++++++++++++++++++++
 drivers/misc/cxl/native.c | 12 +++++++-----
 4 files changed, 57 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 7745252..d928a8c 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -188,6 +188,18 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
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
@@ -905,4 +917,7 @@ extern const struct cxl_backend_ops *cxl_ops;
 
 /* check if the given pci_dev is on the the cxl vphb bus */
 bool cxl_pci_is_vphb_device(struct pci_dev *dev);
+
+/* decode AFU error bits in the PSL register PSL_SERR_An */
+void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr);
 #endif
diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
index bc8d0b9..d516d0a 100644
--- a/drivers/misc/cxl/guest.c
+++ b/drivers/misc/cxl/guest.c
@@ -196,15 +196,18 @@ static irqreturn_t guest_slice_irq_err(int irq, void *data)
 {
 	struct cxl_afu *afu = data;
 	int rc;
-	u64 serr;
+	u64 serr, afu_error, dsisr;
 
-	WARN(irq, "CXL SLICE ERROR interrupt %i\n", irq);
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
index 8def455..40fffe4 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -374,3 +374,32 @@ void afu_release_irqs(struct cxl_context *ctx, void *cookie)
 
 	ctx->irq_count = 0;
 }
+
+void cxl_afu_decode_psl_serr(struct cxl_afu *afu, u64 serr)
+{
+	dev_crit(&afu->dev,
+		 "PSL Slice error received. Check AFU for root cause.\n");
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
index d867326..c4d8815 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -767,7 +767,7 @@ void cxl_native_psl_irq_dump_regs(struct cxl_context *ctx)
 	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
 	if (ctx->afu->adapter->native->sl_ops->register_serr_irq) {
 		serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
-		dev_crit(&ctx->afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
+		cxl_afu_decode_psl_serr(ctx->afu, serr);
 	}
 	dev_crit(&ctx->afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
 	dev_crit(&ctx->afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
@@ -861,21 +861,23 @@ void native_irq_wait(struct cxl_context *ctx)
 static irqreturn_t native_slice_irq_err(int irq, void *data)
 {
 	struct cxl_afu *afu = data;
-	u64 fir_slice, errstat, serr, afu_debug;
+	u64 fir_slice, errstat, serr, afu_debug, afu_error, dsisr;
 
 	/*
 	 * slice err interrupt is only used with full PSL (no XSL)
 	 */
-	WARN(irq, "CXL SLICE ERROR interrupt %i\n", irq);
-
 	serr = cxl_p1n_read(afu, CXL_PSL_SERR_An);
 	fir_slice = cxl_p1n_read(afu, CXL_PSL_FIR_SLICE_An);
 	errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
 	afu_debug = cxl_p1n_read(afu, CXL_AFU_DEBUG_An);
-	dev_crit(&afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
+	afu_error = cxl_p2n_read(afu, CXL_AFU_ERR_An);
+	dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
+	cxl_afu_decode_psl_serr(afu, serr);
 	dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
 	dev_crit(&afu->dev, "CXL_PSL_ErrStat_An: 0x%016llx\n", errstat);
 	dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
+	dev_crit(&afu->dev, "AFU_ERR_An: 0x%.16llx\n", afu_error);
+	dev_crit(&afu->dev, "PSL_DSISR_An: 0x%.16llx\n", dsisr);
 
 	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
 
-- 
2.8.0
