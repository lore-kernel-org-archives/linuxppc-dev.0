Return-Path: <linux@rasmusvillemoes.dk>
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com
 [IPv6:2a00:1450:4010:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE5F81A09BF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 21:28:09 +1000 (AEST)
Received: by lazv15 with SMTP id v15so2816371laz.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 04:28:06 -0700 (PDT)
From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
To: Ian Munsie <imunsie@au1.ibm.com>,
	Michael Neuling <mikey@neuling.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Joe Perches <joe@perches.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] cxl: use more common format specifier
Date: Thu, 11 Jun 2015 13:27:52 +0200
Message-Id: <1434022072-31754-2-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1434022072-31754-1-git-send-email-linux@rasmusvillemoes.dk>
References: <1424751969-sup-7377@delenn.ozlabs.ibm.com>
 <1434022072-31754-1-git-send-email-linux@rasmusvillemoes.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A precision of 16 (%.16llx) has the same effect as a field width of 16
along with passing the 0 flag (%016llx), but the latter is much more
common in the kernel tree. Update cxl to use that.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
So, maybe this on top?

 drivers/misc/cxl/irq.c    | 32 ++++++++++++++++----------------
 drivers/misc/cxl/native.c | 10 +++++-----
 drivers/misc/cxl/pci.c    | 10 +++++-----
 drivers/misc/cxl/trace.h  | 10 +++++-----
 4 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/cxl/irq.c b/drivers/misc/cxl/irq.c
index 4b73f4b9e7f1..f1bd3e6e6109 100644
--- a/drivers/misc/cxl/irq.c
+++ b/drivers/misc/cxl/irq.c
@@ -30,12 +30,12 @@ static irqreturn_t handle_psl_slice_error(struct cxl_context *ctx, u64 dsisr, u6
 	serr = cxl_p1n_read(ctx->afu, CXL_PSL_SERR_An);
 	afu_debug = cxl_p1n_read(ctx->afu, CXL_AFU_DEBUG_An);
 
-	dev_crit(&ctx->afu->dev, "PSL ERROR STATUS: 0x%.16llx\n", errstat);
-	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%.16llx\n", fir1);
-	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%.16llx\n", fir2);
-	dev_crit(&ctx->afu->dev, "PSL_SERR_An: 0x%.16llx\n", serr);
-	dev_crit(&ctx->afu->dev, "PSL_FIR_SLICE_An: 0x%.16llx\n", fir_slice);
-	dev_crit(&ctx->afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%.16llx\n", afu_debug);
+	dev_crit(&ctx->afu->dev, "PSL ERROR STATUS: 0x%016llx\n", errstat);
+	dev_crit(&ctx->afu->dev, "PSL_FIR1: 0x%016llx\n", fir1);
+	dev_crit(&ctx->afu->dev, "PSL_FIR2: 0x%016llx\n", fir2);
+	dev_crit(&ctx->afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
+	dev_crit(&ctx->afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
+	dev_crit(&ctx->afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
 
 	dev_crit(&ctx->afu->dev, "STOPPING CXL TRACE\n");
 	cxl_stop_trace(ctx->afu->adapter);
@@ -54,10 +54,10 @@ irqreturn_t cxl_slice_irq_err(int irq, void *data)
 	fir_slice = cxl_p1n_read(afu, CXL_PSL_FIR_SLICE_An);
 	errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
 	afu_debug = cxl_p1n_read(afu, CXL_AFU_DEBUG_An);
-	dev_crit(&afu->dev, "PSL_SERR_An: 0x%.16llx\n", serr);
-	dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%.16llx\n", fir_slice);
-	dev_crit(&afu->dev, "CXL_PSL_ErrStat_An: 0x%.16llx\n", errstat);
-	dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%.16llx\n", afu_debug);
+	dev_crit(&afu->dev, "PSL_SERR_An: 0x%016llx\n", serr);
+	dev_crit(&afu->dev, "PSL_FIR_SLICE_An: 0x%016llx\n", fir_slice);
+	dev_crit(&afu->dev, "CXL_PSL_ErrStat_An: 0x%016llx\n", errstat);
+	dev_crit(&afu->dev, "CXL_PSL_AFU_DEBUG_An: 0x%016llx\n", afu_debug);
 
 	cxl_p1n_write(afu, CXL_PSL_SERR_An, serr);
 
@@ -72,7 +72,7 @@ static irqreturn_t cxl_irq_err(int irq, void *data)
 	WARN(1, "CXL ERROR interrupt %i\n", irq);
 
 	err_ivte = cxl_p1_read(adapter, CXL_PSL_ErrIVTE);
-	dev_crit(&adapter->dev, "PSL_ErrIVTE: 0x%.16llx\n", err_ivte);
+	dev_crit(&adapter->dev, "PSL_ErrIVTE: 0x%016llx\n", err_ivte);
 
 	dev_crit(&adapter->dev, "STOPPING CXL TRACE\n");
 	cxl_stop_trace(adapter);
@@ -80,7 +80,7 @@ static irqreturn_t cxl_irq_err(int irq, void *data)
 	fir1 = cxl_p1_read(adapter, CXL_PSL_FIR1);
 	fir2 = cxl_p1_read(adapter, CXL_PSL_FIR2);
 
-	dev_crit(&adapter->dev, "PSL_FIR1: 0x%.16llx\nPSL_FIR2: 0x%.16llx\n", fir1, fir2);
+	dev_crit(&adapter->dev, "PSL_FIR1: 0x%016llx\nPSL_FIR2: 0x%016llx\n", fir1, fir2);
 
 	return IRQ_HANDLED;
 }
@@ -147,7 +147,7 @@ static irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
 	if (dsisr & CXL_PSL_DSISR_An_PE)
 		return handle_psl_slice_error(ctx, dsisr, irq_info->errstat);
 	if (dsisr & CXL_PSL_DSISR_An_AE) {
-		pr_devel("CXL interrupt: AFU Error 0x%.16llx\n", irq_info->afu_err);
+		pr_devel("CXL interrupt: AFU Error 0x%016llx\n", irq_info->afu_err);
 
 		if (ctx->pending_afu_err) {
 			/*
@@ -158,7 +158,7 @@ static irqreturn_t cxl_irq(int irq, void *data, struct cxl_irq_info *irq_info)
 			 * probably best that we log them somewhere:
 			 */
 			dev_err_ratelimited(&ctx->afu->dev, "CXL AFU Error "
-					    "undelivered to pe %i: 0x%.16llx\n",
+					    "undelivered to pe %i: 0x%016llx\n",
 					    ctx->pe, irq_info->afu_err);
 		} else {
 			spin_lock(&ctx->lock);
@@ -211,8 +211,8 @@ static irqreturn_t cxl_irq_multiplexed(int irq, void *data)
 	}
 	rcu_read_unlock();
 
-	WARN(1, "Unable to demultiplex CXL PSL IRQ for PE %i DSISR %.16llx DAR"
-		" %.16llx\n(Possible AFU HW issue - was a term/remove acked"
+	WARN(1, "Unable to demultiplex CXL PSL IRQ for PE %i DSISR %016llx DAR"
+		" %016llx\n(Possible AFU HW issue - was a term/remove acked"
 		" with outstanding transactions?)\n", ph, irq_info.dsisr,
 		irq_info.dar);
 	return fail_psl_irq(afu, &irq_info);
diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 29185fc61276..d1d678f0d3dd 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -41,7 +41,7 @@ static int afu_control(struct cxl_afu *afu, u64 command,
 			rc = -EBUSY;
 			goto out;
 		}
-		pr_devel_ratelimited("AFU control... (0x%.16llx)\n",
+		pr_devel_ratelimited("AFU control... (0x%016llx)\n",
 				     AFU_Cntl | command);
 		cpu_relax();
 		AFU_Cntl = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
@@ -120,13 +120,13 @@ int cxl_psl_purge(struct cxl_afu *afu)
 			goto out;
 		}
 		dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
-		pr_devel_ratelimited("PSL purging... PSL_CNTL: 0x%.16llx  PSL_DSISR: 0x%.16llx\n", PSL_CNTL, dsisr);
+		pr_devel_ratelimited("PSL purging... PSL_CNTL: 0x%016llx  PSL_DSISR: 0x%016llx\n", PSL_CNTL, dsisr);
 		if (dsisr & CXL_PSL_DSISR_TRANS) {
 			dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
-			dev_notice(&afu->dev, "PSL purge terminating pending translation, DSISR: 0x%.16llx, DAR: 0x%.16llx\n", dsisr, dar);
+			dev_notice(&afu->dev, "PSL purge terminating pending translation, DSISR: 0x%016llx, DAR: 0x%016llx\n", dsisr, dar);
 			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
 		} else if (dsisr) {
-			dev_notice(&afu->dev, "PSL purge acknowledging pending non-translation fault, DSISR: 0x%.16llx\n", dsisr);
+			dev_notice(&afu->dev, "PSL purge acknowledging pending non-translation fault, DSISR: 0x%016llx\n", dsisr);
 			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_A);
 		} else {
 			cpu_relax();
@@ -677,7 +677,7 @@ static void recover_psl_err(struct cxl_afu *afu, u64 errstat)
 {
 	u64 dsisr;
 
-	pr_devel("RECOVERING FROM PSL ERROR... (0x%.16llx)\n", errstat);
+	pr_devel("RECOVERING FROM PSL ERROR... (0x%016llx)\n", errstat);
 
 	/* Clear PSL_DSISR[PE] */
 	dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
index 1ef01647265f..97ec0c7e1285 100644
--- a/drivers/misc/cxl/pci.c
+++ b/drivers/misc/cxl/pci.c
@@ -630,7 +630,7 @@ static int sanitise_afu_regs(struct cxl_afu *afu)
 	 */
 	reg = cxl_p2n_read(afu, CXL_AFU_Cntl_An);
 	if ((reg & CXL_AFU_Cntl_An_ES_MASK) != CXL_AFU_Cntl_An_ES_Disabled) {
-		dev_warn(&afu->dev, "WARNING: AFU was not disabled: %#.16llx\n", reg);
+		dev_warn(&afu->dev, "WARNING: AFU was not disabled: %#016llx\n", reg);
 		if (cxl_afu_reset(afu))
 			return -EIO;
 		if (cxl_afu_disable(afu))
@@ -651,7 +651,7 @@ static int sanitise_afu_regs(struct cxl_afu *afu)
 	cxl_p2n_write(afu, CXL_SSTP0_An, 0x0000000000000000);
 	reg = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
 	if (reg) {
-		dev_warn(&afu->dev, "AFU had pending DSISR: %#.16llx\n", reg);
+		dev_warn(&afu->dev, "AFU had pending DSISR: %#016llx\n", reg);
 		if (reg & CXL_PSL_DSISR_TRANS)
 			cxl_p2n_write(afu, CXL_PSL_TFC_An, CXL_PSL_TFC_An_AE);
 		else
@@ -660,12 +660,12 @@ static int sanitise_afu_regs(struct cxl_afu *afu)
 	reg = cxl_p1n_read(afu, CXL_PSL_SERR_An);
 	if (reg) {
 		if (reg & ~0xffff)
-			dev_warn(&afu->dev, "AFU had pending SERR: %#.16llx\n", reg);
+			dev_warn(&afu->dev, "AFU had pending SERR: %#016llx\n", reg);
 		cxl_p1n_write(afu, CXL_PSL_SERR_An, reg & ~0xffff);
 	}
 	reg = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
 	if (reg) {
-		dev_warn(&afu->dev, "AFU had pending error status: %#.16llx\n", reg);
+		dev_warn(&afu->dev, "AFU had pending error status: %#016llx\n", reg);
 		cxl_p2n_write(afu, CXL_PSL_ErrStat_An, reg);
 	}
 
@@ -818,7 +818,7 @@ static int cxl_map_adapter_regs(struct cxl *adapter, struct pci_dev *dev)
 	if (pci_request_region(dev, 0, "priv 1 regs"))
 		goto err2;
 
-	pr_devel("cxl_map_adapter_regs: p1: %#.16llx %#llx, p2: %#.16llx %#llx",
+	pr_devel("cxl_map_adapter_regs: p1: %#016llx %#llx, p2: %#016llx %#llx",
 			p1_base(dev), p1_size(dev), p2_base(dev), p2_size(dev));
 
 	if (!(adapter->p1_mmio = ioremap(p1_base(dev), p1_size(dev))))
diff --git a/drivers/misc/cxl/trace.h b/drivers/misc/cxl/trace.h
index ae434d87887e..6e1e2adfba8e 100644
--- a/drivers/misc/cxl/trace.h
+++ b/drivers/misc/cxl/trace.h
@@ -105,7 +105,7 @@ TRACE_EVENT(cxl_attach,
 		__entry->num_interrupts = num_interrupts;
 	),
 
-	TP_printk("afu%i.%i pid=%i pe=%i wed=0x%.16llx irqs=%i amr=0x%llx",
+	TP_printk("afu%i.%i pid=%i pe=%i wed=0x%016llx irqs=%i amr=0x%llx",
 		__entry->card,
 		__entry->afu,
 		__entry->pid,
@@ -177,7 +177,7 @@ TRACE_EVENT(cxl_psl_irq,
 		__entry->dar = dar;
 	),
 
-	TP_printk("afu%i.%i pe=%i irq=%i dsisr=%s dar=0x%.16llx",
+	TP_printk("afu%i.%i pe=%i irq=%i dsisr=%s dar=0x%016llx",
 		__entry->card,
 		__entry->afu,
 		__entry->pe,
@@ -233,7 +233,7 @@ TRACE_EVENT(cxl_ste_miss,
 		__entry->dar = dar;
 	),
 
-	TP_printk("afu%i.%i pe=%i dar=0x%.16llx",
+	TP_printk("afu%i.%i pe=%i dar=0x%016llx",
 		__entry->card,
 		__entry->afu,
 		__entry->pe,
@@ -264,7 +264,7 @@ TRACE_EVENT(cxl_ste_write,
 		__entry->v = v;
 	),
 
-	TP_printk("afu%i.%i pe=%i SSTE[%i] E=0x%.16llx V=0x%.16llx",
+	TP_printk("afu%i.%i pe=%i SSTE[%i] E=0x%016llx V=0x%016llx",
 		__entry->card,
 		__entry->afu,
 		__entry->pe,
@@ -295,7 +295,7 @@ TRACE_EVENT(cxl_pte_miss,
 		__entry->dar = dar;
 	),
 
-	TP_printk("afu%i.%i pe=%i dsisr=%s dar=0x%.16llx",
+	TP_printk("afu%i.%i pe=%i dsisr=%s dar=0x%016llx",
 		__entry->card,
 		__entry->afu,
 		__entry->pe,
-- 
2.1.3
