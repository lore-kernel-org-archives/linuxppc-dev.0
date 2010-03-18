Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93A0FB7D1D
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 01:53:21 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/fsl: Add multiple MSI bank support
Date: Thu, 18 Mar 2010 09:53:13 -0500
Message-Id: <1268923993-26689-1-git-send-email-galak@kernel.crashing.org>
Cc: Lan Chunhe-B25806 <B25806@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Lan Chunhe-B25806 <B25806@freescale.com>

Freescale QorIQ P4080 has three MSI banks and the original code
can not work well. This patch adds multiple MSI banks support for
Freescale processor.

Signed-off-by: Lan Chunhe-B25806 <b25806@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c |   42 ++++++++++++++++++++++++++--------------
 1 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 4108713..5c7e68d 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2009 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2007-2010 Freescale Semiconductor, Inc. All rights reserved.
  *
  * Author: Tony Li <tony.li@freescale.com>
  *	   Jason Jin <Jason.jin@freescale.com>
@@ -29,7 +29,6 @@ struct fsl_msi_feature {
 	u32 msiir_offset;
 };
 
-static struct fsl_msi *fsl_msi;
 
 static inline u32 fsl_msi_read(u32 __iomem *base, unsigned int reg)
 {
@@ -54,10 +53,12 @@ static struct irq_chip fsl_msi_chip = {
 static int fsl_msi_host_map(struct irq_host *h, unsigned int virq,
 				irq_hw_number_t hw)
 {
+	struct fsl_msi *msi_data = h->host_data;
 	struct irq_chip *chip = &fsl_msi_chip;
 
 	get_irq_desc(virq)->status |= IRQ_TYPE_EDGE_FALLING;
 
+	set_irq_chip_data(virq, msi_data);
 	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
 
 	return 0;
@@ -96,11 +97,12 @@ static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int type)
 static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 {
 	struct msi_desc *entry;
-	struct fsl_msi *msi_data = fsl_msi;
+	struct fsl_msi *msi_data;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
 		if (entry->irq == NO_IRQ)
 			continue;
+		msi_data = get_irq_chip_data(entry->irq);
 		set_irq_msi(entry->irq, NULL);
 		msi_bitmap_free_hwirqs(&msi_data->bitmap,
 				       virq_to_hw(entry->irq), 1);
@@ -111,9 +113,10 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 }
 
 static int fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
-				  struct msi_msg *msg)
+				struct msi_msg *msg,
+				struct fsl_msi *fsl_msi_data)
 {
-	struct fsl_msi *msi_data = fsl_msi;
+	struct fsl_msi *msi_data = fsl_msi_data;
 
 	if ((msi_data->feature & FSL_PIC_IP_MASK) == FSL_PIC_IP_VMPIC) {
 		const u32* reg;
@@ -146,9 +149,13 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
-	struct fsl_msi *msi_data = fsl_msi;
+	struct fsl_msi *msi_data;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
+		if (entry->irq == NO_IRQ)
+			continue;
+		msi_data = get_irq_chip_data(entry->irq);
+
 		hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
 		if (hwirq < 0) {
 			rc = hwirq;
@@ -168,7 +175,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		}
 		set_irq_msi(virq, entry);
 
-		rc = fsl_compose_msi_msg(pdev, hwirq, &msg);
+		rc = fsl_compose_msi_msg(pdev, hwirq, &msg, msi_data);
 		if (rc < 0)
 			goto out_free;
 		write_msi_msg(virq, &msg);
@@ -182,7 +189,7 @@ out_free:
 static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int cascade_irq;
-	struct fsl_msi *msi_data = fsl_msi;
+	struct fsl_msi *msi_data = get_irq_chip_data(irq);
 	int msir_index = -1;
 	u32 msir_value = 0;
 	u32 intr_index;
@@ -207,7 +214,7 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		cascade_irq = NO_IRQ;
 
 	desc->status |= IRQ_INPROGRESS;
-	switch (fsl_msi->feature & FSL_PIC_IP_MASK) {
+	switch (msi_data->feature & FSL_PIC_IP_MASK) {
 	case FSL_PIC_IP_MPIC:
 		msir_value = fsl_msi_read(msi_data->msi_regs,
 			msir_index * 0x10);
@@ -327,15 +334,20 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
 		if (virt_msir != NO_IRQ) {
 			set_irq_data(virt_msir, (void *)i);
 			set_irq_chained_handler(virt_msir, fsl_msi_cascade);
+			set_irq_chip_data(virt_msir, msi);
 		}
 	}
 
-	fsl_msi = msi;
-
-	WARN_ON(ppc_md.setup_msi_irqs);
-	ppc_md.setup_msi_irqs = fsl_setup_msi_irqs;
-	ppc_md.teardown_msi_irqs = fsl_teardown_msi_irqs;
-	ppc_md.msi_check_device = fsl_msi_check_device;
+	/* The multiple setting ppc_md.setup_msi_irqs will not harm things */
+	if (!ppc_md.setup_msi_irqs) {
+		ppc_md.setup_msi_irqs = fsl_setup_msi_irqs;
+		ppc_md.teardown_msi_irqs = fsl_teardown_msi_irqs;
+		ppc_md.msi_check_device = fsl_msi_check_device;
+	} else if (ppc_md.setup_msi_irqs != fsl_setup_msi_irqs) {
+		dev_err(&dev->dev, "Different MSI driver already installed!\n");
+		err = -EBUSY; /* or some other error code */
+		goto error_out;
+	}
 	return 0;
 error_out:
 	kfree(msi);
-- 
1.6.0.6
