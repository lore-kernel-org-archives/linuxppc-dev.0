Return-Path: <B31939@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe005.messaging.microsoft.com [216.32.180.31])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 400882C02C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 17:15:49 +1000 (EST)
Received: from mail208-va3 (localhost [127.0.0.1])	by
 mail208-va3-R.bigfish.com (Postfix) with ESMTP id 57C50720BCB	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 07:15:45 +0000 (UTC)
Received: from VA3EHSMHS020.bigfish.com (unknown [10.7.14.241])	by
 mail208-va3.bigfish.com (Postfix) with ESMTP id 75781D40084	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2013 07:15:43 +0000 (UTC)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/5] powerpc/fsl_msi: add MSIIR1 support for MPIC v4.3
Date: Fri, 14 Jun 2013 15:15:56 +0800
Message-ID: <1371194159-17332-2-git-send-email-Minghuan.Lian@freescale.com>
In-Reply-To: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
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

MPIC controller v4.3 provides MSIIR1 to index 16 MSI registers.
MSIIR can only index 8 MSI registers. MSIIR1 uses different bits
definition than MSIIR. This patch adds ibs_shift and srs_shift to
indicate the bits definition of the MSIIR and MSIIR1, so the same
code can handle the MSIIR and MSIIR1 simultaneously.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 62 ++++++++++++++++++++++++++++++++++---------
 arch/powerpc/sysdev/fsl_msi.h |  4 ++-
 2 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index ab02db3..34510b7 100644
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
 
 	rc = msi_bitmap_alloc(&msi_data->bitmap, NR_MSI_IRQS,
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
+	for (hwirq = 0; hwirq < NR_MSI_IRQS; hwirq++)
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
 
@@ -368,7 +387,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 {
 	const struct of_device_id *match;
 	struct fsl_msi *msi;
-	struct resource res;
+	struct resource res, msiir;
 	int err, i, j, irq_index, count;
 	int rc;
 	const u32 *p;
@@ -421,10 +440,29 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 		}
 		msi->msiir_offset =
 			features->msiir_offset + (res.start & 0xfffff);
+
+		/*
+		 * First read the MSIIR/MSIIR1 offset from dts
+		 * If failure use the hardcode MSIIR offset
+		 */
+		if (of_address_to_resource(dev->dev.of_node, 1, &msiir))
+			msi->msiir_offset = features->msiir_offset +
+					    (res.start & MSIIR_OFFSET_MASK);
+		else
+			msi->msiir_offset = msiir.start & MSIIR_OFFSET_MASK;
 	}
 
 	msi->feature = features->fsl_pic_ip;
 
+	if (of_device_is_compatible(dev->dev.of_node, "fsl,mpic-msi-v4.3")) {
+		msi->srs_shift = MSIIR1_SRS_SHIFT;
+		msi->ibs_shift = MSIIR1_IBS_SHIFT;
+
+	} else {
+		msi->srs_shift = MSIIR_SRS_SHIFT;
+		msi->ibs_shift = MSIIR_IBS_SHIFT;
+	}
+
 	/*
 	 * Remember the phandle, so that we can match with any PCI nodes
 	 * that have an "fsl,msi" property.
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 8225f86..43a9d99 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -16,7 +16,7 @@
 #include <linux/of.h>
 #include <asm/msi_bitmap.h>
 
-#define NR_MSI_REG		8
+#define NR_MSI_REG		16
 #define IRQS_PER_MSI_REG	32
 #define NR_MSI_IRQS	(NR_MSI_REG * IRQS_PER_MSI_REG)
 
@@ -31,6 +31,8 @@ struct fsl_msi {
 	unsigned long cascade_irq;
 
 	u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
+	u32 ibs_shift; /* Shift of interrupt bit select */
+	u32 srs_shift; /* Shift of the shared interrupt register select */
 	void __iomem *msi_regs;
 	u32 feature;
 	int msi_virqs[NR_MSI_REG];
-- 
1.8.1.2
