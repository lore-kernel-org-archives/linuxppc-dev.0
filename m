Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjnkX5mCWzDqnx
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:22:44 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u64DIho2058143
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 09:22:42 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23x9mcwaxg-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jul 2016 09:22:42 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Mon, 4 Jul 2016 23:22:39 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 1FAF62CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 23:22:37 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u64DMbRe11993484
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:37 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u64DMaDt015087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jul 2016 23:22:36 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 01/14] powerpc/powernv: Split cxl code out into a separate file
Date: Mon,  4 Jul 2016 23:21:59 +1000
In-Reply-To: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
References: <1467638532-9250-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1467638532-9250-2-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The support for using the Mellanox CX4 in cxl mode will require
additions to the PHB code. In preparation for this, move the existing
cxl code out of pci-ioda.c into a separate pci-cxl.c file to keep things
more organised.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
---
 arch/powerpc/platforms/powernv/Makefile   |   1 +
 arch/powerpc/platforms/powernv/pci-cxl.c  | 163 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 159 +----------------------------
 arch/powerpc/platforms/powernv/pci.h      |   6 ++
 4 files changed, 173 insertions(+), 156 deletions(-)
 create mode 100644 arch/powerpc/platforms/powernv/pci-cxl.c

diff --git a/arch/powerpc/platforms/powernv/Makefile b/arch/powerpc/platforms/powernv/Makefile
index cd9711e..b5d98cb 100644
--- a/arch/powerpc/platforms/powernv/Makefile
+++ b/arch/powerpc/platforms/powernv/Makefile
@@ -6,6 +6,7 @@ obj-y			+= opal-kmsg.o
 
 obj-$(CONFIG_SMP)	+= smp.o subcore.o subcore-asm.o
 obj-$(CONFIG_PCI)	+= pci.o pci-ioda.o npu-dma.o
+obj-$(CONFIG_CXL_BASE)	+= pci-cxl.o
 obj-$(CONFIG_EEH)	+= eeh-powernv.o
 obj-$(CONFIG_PPC_SCOM)	+= opal-xscom.o
 obj-$(CONFIG_MEMORY_FAILURE)	+= opal-memory-errors.o
diff --git a/arch/powerpc/platforms/powernv/pci-cxl.c b/arch/powerpc/platforms/powernv/pci-cxl.c
new file mode 100644
index 0000000..ea8171f
--- /dev/null
+++ b/arch/powerpc/platforms/powernv/pci-cxl.c
@@ -0,0 +1,163 @@
+/*
+ * Copyright 2015 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/pnv-pci.h>
+#include <asm/opal.h>
+
+#include "pci.h"
+
+struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	return of_node_get(hose->dn);
+}
+EXPORT_SYMBOL(pnv_pci_get_phb_node);
+
+int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pnv_ioda_pe *pe;
+	int rc;
+
+	pe = pnv_ioda_get_pe(dev);
+	if (!pe)
+		return -ENODEV;
+
+	pe_info(pe, "Switching PHB to CXL\n");
+
+	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, mode, pe->pe_number);
+	if (rc == OPAL_UNSUPPORTED)
+		dev_err(&dev->dev, "Required cxl mode not supported by firmware - update skiboot\n");
+	else if (rc)
+		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
+
+	return rc;
+}
+EXPORT_SYMBOL(pnv_phb_to_cxl_mode);
+
+/* Find PHB for cxl dev and allocate MSI hwirqs?
+ * Returns the absolute hardware IRQ number
+ */
+int pnv_cxl_alloc_hwirqs(struct pci_dev *dev, int num)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	int hwirq = msi_bitmap_alloc_hwirqs(&phb->msi_bmp, num);
+
+	if (hwirq < 0) {
+		dev_warn(&dev->dev, "Failed to find a free MSI\n");
+		return -ENOSPC;
+	}
+
+	return phb->msi_base + hwirq;
+}
+EXPORT_SYMBOL(pnv_cxl_alloc_hwirqs);
+
+void pnv_cxl_release_hwirqs(struct pci_dev *dev, int hwirq, int num)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq - phb->msi_base, num);
+}
+EXPORT_SYMBOL(pnv_cxl_release_hwirqs);
+
+void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
+				  struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	int i, hwirq;
+
+	for (i = 1; i < CXL_IRQ_RANGES; i++) {
+		if (!irqs->range[i])
+			continue;
+		pr_devel("cxl release irq range 0x%x: offset: 0x%lx  limit: %ld\n",
+			 i, irqs->offset[i],
+			 irqs->range[i]);
+		hwirq = irqs->offset[i] - phb->msi_base;
+		msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq,
+				       irqs->range[i]);
+	}
+}
+EXPORT_SYMBOL(pnv_cxl_release_hwirq_ranges);
+
+int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
+			       struct pci_dev *dev, int num)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	int i, hwirq, try;
+
+	memset(irqs, 0, sizeof(struct cxl_irq_ranges));
+
+	/* 0 is reserved for the multiplexed PSL DSI interrupt */
+	for (i = 1; i < CXL_IRQ_RANGES && num; i++) {
+		try = num;
+		while (try) {
+			hwirq = msi_bitmap_alloc_hwirqs(&phb->msi_bmp, try);
+			if (hwirq >= 0)
+				break;
+			try /= 2;
+		}
+		if (!try)
+			goto fail;
+
+		irqs->offset[i] = phb->msi_base + hwirq;
+		irqs->range[i] = try;
+		pr_devel("cxl alloc irq range 0x%x: offset: 0x%lx  limit: %li\n",
+			 i, irqs->offset[i], irqs->range[i]);
+		num -= try;
+	}
+	if (num)
+		goto fail;
+
+	return 0;
+fail:
+	pnv_cxl_release_hwirq_ranges(irqs, dev);
+	return -ENOSPC;
+}
+EXPORT_SYMBOL(pnv_cxl_alloc_hwirq_ranges);
+
+int pnv_cxl_get_irq_count(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
+	return phb->msi_bmp.irq_count;
+}
+EXPORT_SYMBOL(pnv_cxl_get_irq_count);
+
+int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
+			   unsigned int virq)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	unsigned int xive_num = hwirq - phb->msi_base;
+	struct pnv_ioda_pe *pe;
+	int rc;
+
+	if (!(pe = pnv_ioda_get_pe(dev)))
+		return -ENODEV;
+
+	/* Assign XIVE to PE */
+	rc = opal_pci_set_xive_pe(phb->opal_id, pe->pe_number, xive_num);
+	if (rc) {
+		pe_warn(pe, "%s: OPAL error %d setting msi_base 0x%x "
+			"hwirq 0x%x XIVE 0x%x PE\n",
+			pci_name(dev), rc, phb->msi_base, hwirq, xive_num);
+		return -EIO;
+	}
+	pnv_set_msi_irq_chip(phb, virq);
+
+	return 0;
+}
+EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 2115ed7..e0d8103 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -595,7 +595,7 @@ static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
  * but in the meantime, we need to protect them to avoid warnings
  */
 #ifdef CONFIG_PCI_MSI
-static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
+struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -2700,7 +2700,7 @@ static void pnv_ioda2_msi_eoi(struct irq_data *d)
 }
 
 
-static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
+void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
 {
 	struct irq_data *idata;
 	struct irq_chip *ichip;
@@ -2722,159 +2722,6 @@ static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
 	irq_set_chip(virq, &phb->ioda.irq_chip);
 }
 
-#ifdef CONFIG_CXL_BASE
-
-struct device_node *pnv_pci_get_phb_node(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-
-	return of_node_get(hose->dn);
-}
-EXPORT_SYMBOL(pnv_pci_get_phb_node);
-
-int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	struct pnv_ioda_pe *pe;
-	int rc;
-
-	pe = pnv_ioda_get_pe(dev);
-	if (!pe)
-		return -ENODEV;
-
-	pe_info(pe, "Switching PHB to CXL\n");
-
-	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, mode, pe->pe_number);
-	if (rc == OPAL_UNSUPPORTED)
-		dev_err(&dev->dev, "Required cxl mode not supported by firmware - update skiboot\n");
-	else if (rc)
-		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
-
-	return rc;
-}
-EXPORT_SYMBOL(pnv_phb_to_cxl_mode);
-
-/* Find PHB for cxl dev and allocate MSI hwirqs?
- * Returns the absolute hardware IRQ number
- */
-int pnv_cxl_alloc_hwirqs(struct pci_dev *dev, int num)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	int hwirq = msi_bitmap_alloc_hwirqs(&phb->msi_bmp, num);
-
-	if (hwirq < 0) {
-		dev_warn(&dev->dev, "Failed to find a free MSI\n");
-		return -ENOSPC;
-	}
-
-	return phb->msi_base + hwirq;
-}
-EXPORT_SYMBOL(pnv_cxl_alloc_hwirqs);
-
-void pnv_cxl_release_hwirqs(struct pci_dev *dev, int hwirq, int num)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-
-	msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq - phb->msi_base, num);
-}
-EXPORT_SYMBOL(pnv_cxl_release_hwirqs);
-
-void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
-				  struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	int i, hwirq;
-
-	for (i = 1; i < CXL_IRQ_RANGES; i++) {
-		if (!irqs->range[i])
-			continue;
-		pr_devel("cxl release irq range 0x%x: offset: 0x%lx  limit: %ld\n",
-			 i, irqs->offset[i],
-			 irqs->range[i]);
-		hwirq = irqs->offset[i] - phb->msi_base;
-		msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq,
-				       irqs->range[i]);
-	}
-}
-EXPORT_SYMBOL(pnv_cxl_release_hwirq_ranges);
-
-int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
-			       struct pci_dev *dev, int num)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	int i, hwirq, try;
-
-	memset(irqs, 0, sizeof(struct cxl_irq_ranges));
-
-	/* 0 is reserved for the multiplexed PSL DSI interrupt */
-	for (i = 1; i < CXL_IRQ_RANGES && num; i++) {
-		try = num;
-		while (try) {
-			hwirq = msi_bitmap_alloc_hwirqs(&phb->msi_bmp, try);
-			if (hwirq >= 0)
-				break;
-			try /= 2;
-		}
-		if (!try)
-			goto fail;
-
-		irqs->offset[i] = phb->msi_base + hwirq;
-		irqs->range[i] = try;
-		pr_devel("cxl alloc irq range 0x%x: offset: 0x%lx  limit: %li\n",
-			 i, irqs->offset[i], irqs->range[i]);
-		num -= try;
-	}
-	if (num)
-		goto fail;
-
-	return 0;
-fail:
-	pnv_cxl_release_hwirq_ranges(irqs, dev);
-	return -ENOSPC;
-}
-EXPORT_SYMBOL(pnv_cxl_alloc_hwirq_ranges);
-
-int pnv_cxl_get_irq_count(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-
-	return phb->msi_bmp.irq_count;
-}
-EXPORT_SYMBOL(pnv_cxl_get_irq_count);
-
-int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
-			   unsigned int virq)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	unsigned int xive_num = hwirq - phb->msi_base;
-	struct pnv_ioda_pe *pe;
-	int rc;
-
-	if (!(pe = pnv_ioda_get_pe(dev)))
-		return -ENODEV;
-
-	/* Assign XIVE to PE */
-	rc = opal_pci_set_xive_pe(phb->opal_id, pe->pe_number, xive_num);
-	if (rc) {
-		pe_warn(pe, "%s: OPAL error %d setting msi_base 0x%x "
-			"hwirq 0x%x XIVE 0x%x PE\n",
-			pci_name(dev), rc, phb->msi_base, hwirq, xive_num);
-		return -EIO;
-	}
-	set_msi_irq_chip(phb, virq);
-
-	return 0;
-}
-EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
-#endif
-
 static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				  unsigned int hwirq, unsigned int virq,
 				  unsigned int is_64, struct msi_msg *msg)
@@ -2931,7 +2778,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 	}
 	msg->data = be32_to_cpu(data);
 
-	set_msi_irq_chip(phb, virq);
+	pnv_set_msi_irq_chip(phb, virq);
 
 	pr_devel("%s: %s-bit MSI on hwirq %x (xive #%d),"
 		 " address=%x_%08x data=%x PE# %d\n",
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3a97990..49c2997 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -1,6 +1,10 @@
 #ifndef __POWERNV_PCI_H
 #define __POWERNV_PCI_H
 
+#include <linux/iommu.h>
+#include <asm/iommu.h>
+#include <asm/msi_bitmap.h>
+
 struct pci_dn;
 
 enum pnv_phb_type {
@@ -212,6 +216,8 @@ extern void pnv_pci_dma_dev_setup(struct pci_dev *pdev);
 extern void pnv_pci_dma_bus_setup(struct pci_bus *bus);
 extern int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type);
 extern void pnv_teardown_msi_irqs(struct pci_dev *pdev);
+extern struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev);
+extern void pnv_set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq);
 
 extern void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...);
-- 
2.8.1
