Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6225C1A16F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Oct 2014 19:55:27 +1100 (EST)
From: Michael Neuling <mikey@neuling.org>
To: greg@kroah.com, arnd@arndb.de, mpe@ellerman.id.au, benh@kernel.crashing.org
Subject: [PATCH v4 08/16] powerpc/powerpc: Add new PCIe functions for
 allocating cxl interrupts
Date: Wed,  8 Oct 2014 19:54:57 +1100
Message-Id: <1412758505-23495-9-git-send-email-mikey@neuling.org>
In-Reply-To: <1412758505-23495-1-git-send-email-mikey@neuling.org>
References: <1412758505-23495-1-git-send-email-mikey@neuling.org>
Cc: cbe-oss-dev@lists.ozlabs.org, mikey@neuling.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, imunsie@au.ibm.com,
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
 arch/powerpc/include/asm/pnv-pci.h        |  31 ++++++
 arch/powerpc/platforms/powernv/pci-ioda.c | 154 ++++++++++++++++++++++++++++++
 2 files changed, 185 insertions(+)
 create mode 100644 arch/powerpc/include/asm/pnv-pci.h

diff --git a/arch/powerpc/include/asm/pnv-pci.h b/arch/powerpc/include/asm/pnv-pci.h
new file mode 100644
index 0000000..f09a22f
--- /dev/null
+++ b/arch/powerpc/include/asm/pnv-pci.h
@@ -0,0 +1,31 @@
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
+int pnv_cxl_get_irq_count(struct pci_dev *dev);
+struct device_node *pnv_pci_to_phb_node(struct pci_dev *dev);
+
+#ifdef CONFIG_CXL_BASE
+int pnv_cxl_alloc_hwirq_ranges(struct cxl_irq_ranges *irqs,
+			       struct pci_dev *dev, int num);
+void pnv_cxl_release_hwirq_ranges(struct cxl_irq_ranges *irqs,
+				  struct pci_dev *dev);
+#endif
+
+#endif
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index baf3de6..2dfc857 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -37,6 +37,9 @@
 #include <asm/xics.h>
 #include <asm/debug.h>
 #include <asm/firmware.h>
+#include <asm/pnv-pci.h>
+
+#include <misc/cxl.h>
 
 #include "powernv.h"
 #include "pci.h"
@@ -1329,6 +1332,157 @@ static void set_msi_irq_chip(struct pnv_phb *phb, unsigned int virq)
 	irq_set_chip(virq, &phb->ioda.irq_chip);
 }
 
+#ifdef CONFIG_CXL_BASE
+
+struct device_node *pnv_pci_to_phb_node(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+
+	return hose->dn;
+}
+EXPORT_SYMBOL(pnv_pci_to_phb_node);
+
+int pnv_phb_to_cxl(struct pci_dev *dev)
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
+	rc = opal_pci_set_phb_cxl_mode(phb->opal_id, 1, pe->pe_number);
+	if (rc)
+		dev_err(&dev->dev, "opal_pci_set_phb_cxl_mode failed: %i\n", rc);
+
+	return rc;
+}
+EXPORT_SYMBOL(pnv_phb_to_cxl);
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
