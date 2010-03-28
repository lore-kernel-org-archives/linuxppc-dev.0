Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5BAA3B7CB6
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 10:00:02 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3] powerpc/fsl: Add multiple MSI bank support
Date: Sun, 28 Mar 2010 17:59:53 -0500
Message-Id: <1269817193-2445-1-git-send-email-galak@kernel.crashing.org>
Cc: Lan Chunhe-B25806 <B25806@freescale.com>, timur@freescale.com
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
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
v3:
* Fixed whitespace issues

v2:
* Dropped check in fsl_setup_msi_irqs for NO_IRQ per Michael E's comments
* if ppc_md.setup_msi_irqs is already set treat as a -ENODEV, removed comment

 arch/powerpc/sysdev/fsl_msi.c |   40 +++++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index e094367..afbcc12 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2007-2008 Freescale Semiconductor, Inc. All rights reserved.
+ * Copyright (C) 2007-2010 Freescale Semiconductor, Inc.
  *
  * Author: Tony Li <tony.li@freescale.com>
  *	   Jason Jin <Jason.jin@freescale.com>
@@ -28,7 +28,6 @@ struct fsl_msi_feature {
 	u32 msiir_offset;
 };
 
-static struct fsl_msi *fsl_msi;
 
 static inline u32 fsl_msi_read(u32 __iomem *base, unsigned int reg)
 {
@@ -53,10 +52,12 @@ static struct irq_chip fsl_msi_chip = {
 static int fsl_msi_host_map(struct irq_host *h, unsigned int virq,
 				irq_hw_number_t hw)
 {
+	struct fsl_msi *msi_data = h->host_data;
 	struct irq_chip *chip = &fsl_msi_chip;
 
 	irq_to_desc(virq)->status |= IRQ_TYPE_EDGE_FALLING;
 
+	set_irq_chip_data(virq, msi_data);
 	set_irq_chip_and_handler(virq, chip, handle_edge_irq);
 
 	return 0;
@@ -95,11 +96,12 @@ static int fsl_msi_check_device(struct pci_dev *pdev, int nvec, int type)
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
@@ -110,9 +112,10 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 }
 
 static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
-				  struct msi_msg *msg)
+				struct msi_msg *msg,
+				struct fsl_msi *fsl_msi_data)
 {
-	struct fsl_msi *msi_data = fsl_msi;
+	struct fsl_msi *msi_data = fsl_msi_data;
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	u32 base = 0;
 
@@ -133,9 +136,11 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
-	struct fsl_msi *msi_data = fsl_msi;
+	struct fsl_msi *msi_data;
 
 	list_for_each_entry(entry, &pdev->msi_list, list) {
+		msi_data = get_irq_chip_data(entry->irq);
+
 		hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
 		if (hwirq < 0) {
 			rc = hwirq;
@@ -155,7 +160,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		}
 		set_irq_msi(virq, entry);
 
-		fsl_compose_msi_msg(pdev, hwirq, &msg);
+		fsl_compose_msi_msg(pdev, hwirq, &msg, msi_data);
 		write_msi_msg(virq, &msg);
 	}
 	return 0;
@@ -167,7 +172,7 @@ out_free:
 static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 {
 	unsigned int cascade_irq;
-	struct fsl_msi *msi_data = fsl_msi;
+	struct fsl_msi *msi_data = get_irq_chip_data(irq);
 	int msir_index = -1;
 	u32 msir_value = 0;
 	u32 intr_index;
@@ -192,7 +197,7 @@ static void fsl_msi_cascade(unsigned int irq, struct irq_desc *desc)
 		cascade_irq = NO_IRQ;
 
 	desc->status |= IRQ_INPROGRESS;
-	switch (fsl_msi->feature & FSL_PIC_IP_MASK) {
+	switch (msi_data->feature & FSL_PIC_IP_MASK) {
 	case FSL_PIC_IP_MPIC:
 		msir_value = fsl_msi_read(msi_data->msi_regs,
 			msir_index * 0x10);
@@ -306,15 +311,20 @@ static int __devinit fsl_of_msi_probe(struct of_device *dev,
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
+		err = -ENODEV;
+		goto error_out;
+	}
 	return 0;
 error_out:
 	kfree(msi);
-- 
1.6.0.6
