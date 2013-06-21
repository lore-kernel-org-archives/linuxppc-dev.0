Return-Path: <B31939@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83DE22C0089
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 20:58:59 +1000 (EST)
Received: from mail93-co1 (localhost [127.0.0.1])	by mail93-co1-R.bigfish.com
 (Postfix) with ESMTP id B11D08C00A9	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 21 Jun 2013 10:58:54 +0000 (UTC)
Received: from CO1EHSMHS032.bigfish.com (unknown [10.243.78.244])	by
 mail93-co1.bigfish.com (Postfix) with ESMTP id 03F9E7000E5	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2013 10:58:53 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/3 v2] powerpc/fsl_msi: add MSIIR1 support for MPIC v4.3
Date: Fri, 21 Jun 2013 18:59:14 +0800
Message-ID: <1371812354-1962-3-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1371812354-1962-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1371812354-1962-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Minghuan Lian <Minghuan.Lian@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original MPIC MSI bank contains 8 registers, MPIC v4.3 MSI bank
contains 16 registers, and this patch adds NR_MSI_REG_MAX and
NR_MSI_IRQS_MAX to describe the maximum capability of MSI bank.
MPIC v4.3 provides MSIIR1 to index these 16 MSI registers. MSIIR1
uses different bits definition than MSIIR. This patch adds
ibs_shift and srs_shift to indicate the bits definition of the
MSIIR and MSIIR1, so the same code can handle the MSIIR and MSIIR1
simultaneously.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
v2 log:
1. remove 'msiregs' support.

 arch/powerpc/sysdev/fsl_msi.c | 132 ++++++++++++++++++++++++++++++------------
 arch/powerpc/sysdev/fsl_msi.h |  10 +++-
 2 files changed, 101 insertions(+), 41 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index ab02db3..76d453e 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -28,6 +28,18 @@
 #include "fsl_msi.h"
 #include "fsl_pci.h"
 
+#define MSIIR_OFFSET_MASK	0xfffff
+#define MSIIR_IBS_SHIFT		0
+#define MSIIR_SRS_SHIFT		5
+#define MSIIR1_IBS_SHIFT	4
+#define MSIIR1_SRS_SHIFT	0
+#define MSI_SRS_MASK		0xf
+#define MSI_IBS_MASK		0x1f
+
+#define msi_hwirq(msi, msir_index, intr_index) \
+		((msir_index) << (msi)->srs_shift | \
+		 ((intr_index) << (msi)->ibs_shift))
+
 static LIST_HEAD(msi_head);
 
 struct fsl_msi_feature {
@@ -80,18 +92,19 @@ static const struct irq_domain_ops fsl_msi_host_ops = {
 
 static int fsl_msi_init_allocator(struct fsl_msi *msi_data)
 {
-	int rc;
+	int rc, hwirq;
 
-	rc = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
+	rc = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS_MAX,
 			      msi_data->irqhost->of_node);
 	if (rc)
 		return rc;
 
-	rc = msi_bitmap_reserve_dt_hwirqs(&msi_data->bitmap);
-	if (rc < 0) {
-		msi_bitmap_free(&msi_data->bitmap);
-		return rc;
-	}
+	/*
+	 * Reserve all the hwirqs
+	 * The available hwirqs will be released in fsl_msi_setup_hwirq()
+	 */
+	for (hwirq = 0; hwirq < NR_MSI_IRQS_MAX; hwirq++)
+		msi_bitmap_reserve_hwirq(&msi_data->bitmap, hwirq);
 
 	return 0;
 }
@@ -144,8 +157,9 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 
 	msg->data = hwirq;
 
-	pr_debug("%s: allocated srs: %d, ibs: %d\n",
-		__func__, hwirq / IRQS_PER_MSI_REG, hwirq % IRQS_PER_MSI_REG);
+	pr_debug("%s: allocated srs: %d, ibs: %d\n", __func__,
+		 (hwirq >> msi_data->srs_shift) & MSI_SRS_MASK,
+		 (hwirq >> msi_data->ibs_shift) & MSI_IBS_MASK);
 }
 
 static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
@@ -255,7 +269,7 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 
 	msir_index = cascade_data->index;
 
-	if (msir_index >= NR_MSI_REG)
+	if (msir_index >= NR_MSI_REG_MAX)
 		cascade_irq = NO_IRQ;
 
 	irqd_set_chained_irq_inprogress(idata);
@@ -285,8 +299,8 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		intr_index = ffs(msir_value) - 1;
 
 		cascade_irq = irq_linear_revmap(msi_data->irqhost,
-				msir_index * IRQS_PER_MSI_REG +
-					intr_index + have_shift);
+				msi_hwirq(msi_data, msir_index,
+					  intr_index + have_shift));
 		if (cascade_irq != NO_IRQ)
 			generic_handle_irq(cascade_irq);
 		have_shift += intr_index + 1;
@@ -316,7 +330,7 @@ static int fsl_of_msi_remove(struct platform_device *ofdev)
 
 	if (msi->list.prev != NULL)
 		list_del(&msi->list);
-	for (i = 0; i < NR_MSI_REG; i++) {
+	for (i = 0; i < NR_MSI_REG_MAX; i++) {
 		virq = msi->msi_virqs[i];
 		if (virq != NO_IRQ) {
 			cascade_data = irq_get_handler_data(virq);
@@ -339,7 +353,7 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 			       int offset, int irq_index)
 {
 	struct fsl_msi_cascade_data *cascade_data = NULL;
-	int virt_msir;
+	int virt_msir, i;
 
 	virt_msir = irq_of_parse_and_map(dev->dev.of_node, irq_index);
 	if (virt_msir == NO_IRQ) {
@@ -360,6 +374,11 @@ static int fsl_msi_setup_hwirq(struct fsl_msi *msi, struct platform_device *dev,
 	irq_set_handler_data(virt_msir, cascade_data);
 	irq_set_chained_handler(virt_msir, fsl_msi_cascade);
 
+	/* Release the hwirqs corresponding to this MSI register */
+	for (i = 0; i < IRQS_PER_MSI_REG; i++)
+		msi_bitmap_free_hwirqs(&msi->bitmap,
+				       msi_hwirq(msi, offset, i), 1);
+
 	return 0;
 }
 
@@ -368,14 +387,13 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 {
 	const struct of_device_id *match;
 	struct fsl_msi *msi;
-	struct resource res;
+	struct resource res, msiir;
 	int err, i, j, irq_index, count;
 	int rc;
 	const u32 *p;
 	const struct fsl_msi_feature *features;
 	int len;
 	u32 offset;
-	static const u32 all_avail[] = { 0, NR_MSI_IRQS };
 
 	match = of_match_device(fsl_of_msi_ids, &dev->dev);
 	if (!match)
@@ -392,7 +410,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	platform_set_drvdata(dev, msi);
 
 	msi->irqhost = irq_domain_add_linear(dev->dev.of_node,
-				      NR_MSI_IRQS, &fsl_msi_host_ops, msi);
+				      NR_MSI_IRQS_MAX, &fsl_msi_host_ops, msi);
 
 	if (msi->irqhost == NULL) {
 		dev_err(&dev->dev, "No memory for MSI irqhost\n");
@@ -421,6 +439,16 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 		}
 		msi->msiir_offset =
 			features->msiir_offset + (res.start & 0xfffff);
+
+		/*
+		 * First read the MSIIR/MSIIR1 offset from dts
+		 * On failure use the hardcode MSIIR offset
+		 */
+		if (of_address_to_resource(dev->dev.of_node, 1, &msiir))
+			msi->msiir_offset = features->msiir_offset +
+					    (res.start & MSIIR_OFFSET_MASK);
+		else
+			msi->msiir_offset = msiir.start & MSIIR_OFFSET_MASK;
 	}
 
 	msi->feature = features->fsl_pic_ip;
@@ -438,35 +466,59 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	}
 
 	p = of_get_property(dev->dev.of_node, "msi-available-ranges", &len);
-	if (p && len % (2 * sizeof(u32)) != 0) {
-		dev_err(&dev->dev, "%s: Malformed msi-available-ranges property\n",
-			__func__);
-		err = -EINVAL;
-		goto error_out;
-	}
 
-	if (!p) {
-		p = all_avail;
-		len = sizeof(all_avail);
-	}
+	if (of_device_is_compatible(dev->dev.of_node, "fsl,mpic-msi-v4.3")) {
+		msi->srs_shift = MSIIR1_SRS_SHIFT;
+		msi->ibs_shift = MSIIR1_IBS_SHIFT;
+		if (p)
+			dev_warn(&dev->dev, "%s: dose not support msi-available-ranges property\n",
+				__func__);
+
+		for (irq_index = 0; irq_index < NR_MSI_REG_MSIIR1;
+		     irq_index++) {
+			err = fsl_msi_setup_hwirq(msi, dev,
+						  irq_index, irq_index);
+			if (err)
+				goto error_out;
+		}
+	} else {
+		const u32 all_avail[] = { 0,
+					  NR_MSI_REG_MSIIR * IRQS_PER_MSI_REG};
+
+		msi->srs_shift = MSIIR_SRS_SHIFT;
+		msi->ibs_shift = MSIIR_IBS_SHIFT;
 
-	for (irq_index = 0, i = 0; i < len / (2 * sizeof(u32)); i++) {
-		if (p[i * 2] % IRQS_PER_MSI_REG ||
-		    p[i * 2 + 1] % IRQS_PER_MSI_REG) {
-			printk(KERN_WARNING "%s: %s: msi available range of %u at %u is not IRQ-aligned\n",
-			       __func__, dev->dev.of_node->full_name,
-			       p[i * 2 + 1], p[i * 2]);
+		if (p && len % (2 * sizeof(u32)) != 0) {
+			dev_err(&dev->dev, "%s: Malformed msi-available-ranges property\n",
+				__func__);
 			err = -EINVAL;
 			goto error_out;
 		}
 
-		offset = p[i * 2] / IRQS_PER_MSI_REG;
-		count = p[i * 2 + 1] / IRQS_PER_MSI_REG;
+		if (!p) {
+			p = all_avail;
+			len = sizeof(all_avail);
+		}
 
-		for (j = 0; j < count; j++, irq_index++) {
-			err = fsl_msi_setup_hwirq(msi, dev, offset + j, irq_index);
-			if (err)
+		for (irq_index = 0, i = 0; i < len / (2 * sizeof(u32)); i++) {
+			if (p[i * 2] % IRQS_PER_MSI_REG ||
+			    p[i * 2 + 1] % IRQS_PER_MSI_REG) {
+				pr_warn("%s: %s: msi available range of %u at %u is not IRQ-aligned\n",
+				       __func__, dev->dev.of_node->full_name,
+				       p[i * 2 + 1], p[i * 2]);
+				err = -EINVAL;
 				goto error_out;
+			}
+
+			offset = p[i * 2] / IRQS_PER_MSI_REG;
+			count = p[i * 2 + 1] / IRQS_PER_MSI_REG;
+
+			for (j = 0; j < count; j++, irq_index++) {
+				err = fsl_msi_setup_hwirq(msi, dev, offset + j,
+							  irq_index);
+				if (err)
+					goto error_out;
+			}
 		}
 	}
 
@@ -509,6 +561,10 @@ static const struct of_device_id fsl_of_msi_ids[] = {
 		.data = &mpic_msi_feature,
 	},
 	{
+		.compatible = "fsl,mpic-msi-v4.3",
+		.data = &mpic_msi_feature,
+	},
+	{
 		.compatible = "fsl,ipic-msi",
 		.data = &ipic_msi_feature,
 	},
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 8225f86..df9aa9f 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -16,9 +16,11 @@
 #include <linux/of.h>
 #include <asm/msi_bitmap.h>
 
-#define NR_MSI_REG		8
+#define NR_MSI_REG_MSIIR	8  /* MSIIR can index 8 MSI registers */
+#define NR_MSI_REG_MSIIR1	16 /* MSIIR1 can index 16 MSI registers */
+#define NR_MSI_REG_MAX		NR_MSI_REG_MSIIR1
 #define IRQS_PER_MSI_REG	32
-#define NR_MSI_IRQS	(NR_MSI_REG * IRQS_PER_MSI_REG)
+#define NR_MSI_IRQS_MAX	(NR_MSI_REG_MAX * IRQS_PER_MSI_REG)
 
 #define FSL_PIC_IP_MASK   0x0000000F
 #define FSL_PIC_IP_MPIC   0x00000001
@@ -31,9 +33,11 @@ struct fsl_msi {
 	unsigned long cascade_irq;
 
 	u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
+	u32 ibs_shift; /* Shift of interrupt bit select */
+	u32 srs_shift; /* Shift of the shared interrupt register select */
 	void __iomem *msi_regs;
 	u32 feature;
-	int msi_virqs[NR_MSI_REG];
+	int msi_virqs[NR_MSI_REG_MAX];
 
 	struct msi_bitmap bitmap;
 
-- 
1.8.1.2
