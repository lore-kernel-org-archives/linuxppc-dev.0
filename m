Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7F6DA1A0940
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 18:27:20 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH 07/15] powerpc/powerpc: Add new PCIe functions for allocating
 cxl interrupts
Date: Thu, 18 Sep 2014 18:26:52 +1000
Message-Id: <1411028820-29933-8-git-send-email-mikey@neuling.org>
In-Reply-To: <1411028820-29933-1-git-send-email-mikey@neuling.org>
References: <1411028820-29933-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org, imunsie@au.ibm.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, jk@ozlabs.org,
 anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

This adds a number of functions for allocating IRQs under powernv PCIe for cxl.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/pnv-pci.h        |  27 +++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 186 ++++++++++++++++++++++++++++++
 2 files changed, 213 insertions(+)
 create mode 100644 arch/powerpc/include/asm/pnv-pci.h

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
new file mode 100644
index 0000000..71717b5
--- /dev/null
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright 2014 IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef _ASM_PNV_PCI_H
+#define _ASM_PNV_PCI_H
+
+#include <linux/pci.h>
+#include <misc/cxl.h>
+
+int pnv_phb_to_cxl(struct pci_dev *dev);
+int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
+			   unsigned int virq);
+int pnv_cxl_alloc_hwirqs(struct pci_dev *dev, int num);
+void pnv_cxl_release_hwirqs(struct pci_dev *dev, int hwirq, int num);
+int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
+			       struct pci_dev *dev, int num);
+void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
+				  struct pci_dev *dev);
+int pnv_cxl_get_irq_count(struct pci_dev *dev);
+
+#endif
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 194f90a..80919f8 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -38,6 +38,8 @@
 #include <asm/debug.h>
 #include <asm/firmware.h>
 
+#include <misc/cxl.h>
+
 #include "powernv.h"
 #include "pci.h"
 
@@ -503,6 +505,163 @@ static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 		return NULL;
 	return &phb->ioda.pe_array[pdn->pe_number];
 }
+
+struct device_node *pnv_pci_to_phb_node(struct pci_dev *dev)
+{
+	struct device_node *np;
+	struct property *prop = NULL;
+
+	np = of_node_get(pci_device_to_OF_node(dev));
+
+	/* Scan up the tree looking for the PHB node */
+	while (np) {
+		if ((prop = of_find_property(np, "ibm,opal-phbid", NULL)))
+			break;
+		np = of_get_next_parent(np);
+	}
+
+	if (!prop) {
+		of_node_put(np);
+		return NULL;
+	}
+
+	return np;
+}
+EXPORT_SYMBOL(pnv_pci_to_phb_node);
+
+#ifdef CONFIG_CXL_BASE
+int pnv_phb_to_cxl(struct pci_dev *dev)
+{
+	struct device_node *np;
+	struct pnv_ioda_pe *pe;
+	const u64 *prop64;
+	u64 phb_id;
+	int rc;
+
+	dev_info(&dev->dev, "switch PHB to CXL\n");
+
+	if (!(np = pnv_pci_to_phb_node(dev)))
+		return -ENODEV;
+
+	prop64 = of_get_property(np, "ibm,opal-phbid", NULL);
+
+	phb_id = be64_to_cpup(prop64);
+	dev_info(&dev->dev, "PHB-ID  : 0x%016llx\n", phb_id);
+
+	if (!(pe = pnv_ioda_get_pe(dev))) {
+		rc = -ENODEV;
+		goto out;
+	}
+	dev_info(&dev->dev, "     pe : %i\n", pe->pe_number);
+
+	if ((rc = opal_pci_set_phb_cxl_mode(phb_id, 1, pe->pe_number)))
+		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
+
+out:
+	of_node_put(np);
+	return rc;
+}
+EXPORT_SYMBOL(pnv_phb_to_cxl);
+
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
+
+int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
+			       struct pci_dev *dev, int num)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	int range = 0;
+	int hwirq;
+	int try;
+
+	memset(irqs, 0, sizeof(struct cxl_irq_ranges));
+
+	for (range = 1; range < CXL_IRQ_RANGES && num; range++) {
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
+		irqs->offset[range] = phb->msi_base + hwirq;
+		irqs->range[range] = try;
+		pr_devel("cxl alloc irq range 0x%x: offset: 0x%lx  limit: %li\n",
+			 range, irqs->offset[range], irqs->range[range]);
+		num -= try;
+	}
+	if (num)
+		goto fail;
+
+	return 0;
+fail:
+	for (range--; range >= 0; range--) {
+		hwirq = irqs->offset[range] - phb->msi_base;
+		msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq,
+				       irqs->range[range]);
+		irqs->range[range] = 0;
+	}
+	return -ENOSPC;
+}
+EXPORT_SYMBOL(pnv_cxl_alloc_hwirq_ranges);
+
+void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
+				  struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	int range = 0;
+	int hwirq;
+
+	for (range = 0; range < 4; range++) {
+		hwirq = irqs->offset[range] - phb->msi_base;
+		if (irqs->range[range]) {
+			pr_devel("cxl release irq range 0x%x: offset: 0x%lx  limit: %ld\n",
+				 range, irqs->offset[range],
+				 irqs->range[range]);
+			msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq,
+					       irqs->range[range]);
+		}
+	}
+}
+EXPORT_SYMBOL(pnv_cxl_release_hwirq_ranges);
+
+int pnv_cxl_get_irq_count(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+        struct pnv_phb *phb = hose->private_data;
+
+	return phb->msi_bmp.irq_count;
+}
+EXPORT_SYMBOL(pnv_cxl_get_irq_count);
+
+#endif /* CONFIG_CXL_BASE */
 #endif /* CONFIG_PCI_MSI */
 
 static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
@@ -1330,6 +1489,33 @@ static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
 	}
 }
 
+#ifdef CONFIG_CXL_BASE
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
+		pr_warn("%s: OPAL error %d setting msi_base 0x%x hwirq 0x%x XIVE 0x%x PE\n",
+			pci_name(dev), rc, phb->msi_base, hwirq, xive_num);
+		return -EIO;
+	}
+	set_msi_irq_chip(phb, virq);
+
+	return 0;
+}
+EXPORT_SYMBOL(pnv_cxl_ioda_msi_setup);
+#endif
+
 static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
 				  unsigned int hwirq, unsigned int virq,
 				  unsigned int is_64, struct msi_msg *msg)
-- 
1.9.1
