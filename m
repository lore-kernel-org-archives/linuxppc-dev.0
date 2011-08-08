Return-Path: <xenidis@gmail.com>
Received: from mail-pz0-f46.google.com (mail-pz0-f46.google.com
	[209.85.210.46]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 55006B72C0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Aug 2011 08:14:38 +1000 (EST)
Received: by pzk32 with SMTP id 32so5059381pzk.33
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 08 Aug 2011 15:14:35 -0700 (PDT)
Sender: "xenidis@gmail.com" <xenidis@gmail.com>
From: Jimi Xenidis <jimix@pobox.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc: poweren: pci-msi: Add MSI support for PCI on
	PowerEN
Date: Mon,  8 Aug 2011 17:30:55 -0500
Message-Id: <1312842655-21526-3-git-send-email-jimix@pobox.com>
In-Reply-To: <1312842655-21526-1-git-send-email-jimix@pobox.com>
References: <1312842655-21526-1-git-send-email-jimix@pobox.com>
Cc: Michael Ellerman <michael@ellerman.id.au>, Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

Based on a patch by Michael Ellerman <michael@ellerman.id.au>

Patch was simply forward ported upstream.

Jimi Xenidis <jimix@pobox.com>
---
 arch/powerpc/platforms/wsp/Makefile |    1 +
 arch/powerpc/platforms/wsp/ics.c    |   48 ++++++++++++++++
 arch/powerpc/platforms/wsp/ics.h    |    5 ++
 arch/powerpc/platforms/wsp/msi.c    |  102 +++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/wsp/msi.h    |   19 +++++++
 5 files changed, 175 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/wsp/msi.c
 create mode 100644 arch/powerpc/platforms/wsp/msi.h

diff --git a/arch/powerpc/platforms/wsp/Makefile b/arch/powerpc/platforms/wsp/Makefile
index 84519f8..a1486b4 100644
--- a/arch/powerpc/platforms/wsp/Makefile
+++ b/arch/powerpc/platforms/wsp/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_PPC_PSR2)		+= psr2.o opb_pic.o
 obj-$(CONFIG_PPC_WSP)		+= scom_wsp.o
 obj-$(CONFIG_SMP)		+= smp.o scom_smp.o
 obj-$(CONFIG_PCI)		+= wsp_pci.o
+obj-$(CONFIG_PCI_MSI)		+= msi.o
\ No newline at end of file
diff --git a/arch/powerpc/platforms/wsp/ics.c b/arch/powerpc/platforms/wsp/ics.c
index e53bd9e..5768743 100644
--- a/arch/powerpc/platforms/wsp/ics.c
+++ b/arch/powerpc/platforms/wsp/ics.c
@@ -710,3 +710,51 @@ void __init wsp_init_irq(void)
 	/* We need to patch our irq chip's EOI to point to the right ICP */
 	wsp_irq_chip.irq_eoi = icp_ops->eoi;
 }
+
+#ifdef CONFIG_PCI_MSI
+static void wsp_ics_msi_unmask_irq(struct irq_data *d)
+{
+	wsp_chip_unmask_irq(d);
+	unmask_msi_irq(d);
+}
+
+static unsigned int wsp_ics_msi_startup(struct irq_data *d)
+{
+	wsp_ics_msi_unmask_irq(d);
+	return 0;
+}
+
+static void wsp_ics_msi_mask_irq(struct irq_data *d)
+{
+	mask_msi_irq(d);
+	wsp_chip_mask_irq(d);
+}
+
+/*
+ * we do it this way because we reassinge default EOI handling in
+ * irq_init() above
+ */
+static void wsp_ics_eoi(struct irq_data *data)
+{
+	wsp_irq_chip.irq_eoi(data);
+}
+
+static struct irq_chip wsp_ics_msi = {
+	.name = "WSP ICS MSI",
+	.irq_startup = wsp_ics_msi_startup,
+	.irq_mask = wsp_ics_msi_mask_irq,
+	.irq_unmask = wsp_ics_msi_unmask_irq,
+	.irq_eoi = wsp_ics_eoi,
+	.irq_set_affinity = wsp_chip_set_affinity
+};
+
+void wsp_ics_set_msi_chip(unsigned int irq)
+{
+	irq_set_chip(irq, &wsp_ics_msi);
+}
+
+void wsp_ics_set_std_chip(unsigned int irq)
+{
+	irq_set_chip(irq, &wsp_irq_chip);
+}
+#endif /* CONFIG_PCI_MSI */
diff --git a/arch/powerpc/platforms/wsp/ics.h b/arch/powerpc/platforms/wsp/ics.h
index e34d531..07b644e 100644
--- a/arch/powerpc/platforms/wsp/ics.h
+++ b/arch/powerpc/platforms/wsp/ics.h
@@ -17,4 +17,9 @@ extern void wsp_init_irq(void);
 extern int wsp_ics_alloc_irq(struct device_node *dn, int num);
 extern void wsp_ics_free_irq(struct device_node *dn, unsigned int irq);
 
+#ifdef CONFIG_PCI_MSI
+extern void wsp_ics_set_msi_chip(unsigned int irq);
+extern void wsp_ics_set_std_chip(unsigned int irq);
+#endif /* CONFIG_PCI_MSI */
+
 #endif /* __ICS_H */
diff --git a/arch/powerpc/platforms/wsp/msi.c b/arch/powerpc/platforms/wsp/msi.c
new file mode 100644
index 0000000..380882f
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/msi.c
@@ -0,0 +1,102 @@
+/*
+ * Copyright 2011 Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/msi.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+
+#include "msi.h"
+#include "ics.h"
+#include "wsp_pci.h"
+
+/* Magic addresses for 32 & 64-bit MSIs with hardcoded MVE 0 */
+#define MSI_ADDR_32		0xFFFF0000ul
+#define MSI_ADDR_64		0x1000000000000000ul
+
+int wsp_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
+{
+	struct pci_controller *phb;
+	struct msi_desc *entry;
+	struct msi_msg msg;
+	unsigned int virq;
+	int hwirq;
+
+	phb = pci_bus_to_host(dev->bus);
+	if (!phb)
+		return -ENOENT;
+
+	entry = list_first_entry(&dev->msi_list, struct msi_desc, list);
+	if (entry->msi_attrib.is_64) {
+		msg.address_lo = 0;
+		msg.address_hi = MSI_ADDR_64 >> 32;
+	} else {
+		msg.address_lo = MSI_ADDR_32;
+		msg.address_hi = 0;
+	}
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		hwirq = wsp_ics_alloc_irq(phb->dn, 1);
+		if (hwirq < 0) {
+			dev_warn(&dev->dev, "wsp_msi: hwirq alloc failed!\n");
+			return hwirq;
+		}
+
+		virq = irq_create_mapping(NULL, hwirq);
+		if (virq == NO_IRQ) {
+			dev_warn(&dev->dev, "wsp_msi: virq alloc failed!\n");
+			return -1;
+		}
+
+		dev_dbg(&dev->dev, "wsp_msi: allocated irq %#x/%#x\n",
+			hwirq, virq);
+
+		wsp_ics_set_msi_chip(virq);
+		irq_set_msi_desc(virq, entry);
+		msg.data = hwirq & XIVE_ADDR_MASK;
+		write_msi_msg(virq, &msg);
+	}
+
+	return 0;
+}
+
+void wsp_teardown_msi_irqs(struct pci_dev *dev)
+{
+	struct pci_controller *phb;
+	struct msi_desc *entry;
+	int hwirq;
+
+	phb = pci_bus_to_host(dev->bus);
+
+	dev_dbg(&dev->dev, "wsp_msi: tearing down msi irqs\n");
+
+	list_for_each_entry(entry, &dev->msi_list, list) {
+		if (entry->irq == NO_IRQ)
+			continue;
+
+		irq_set_msi_desc(entry->irq, NULL);
+		wsp_ics_set_std_chip(entry->irq);
+
+		hwirq = virq_to_hw(entry->irq);
+		/* In this order to avoid racing with irq_create_mapping() */
+		irq_dispose_mapping(entry->irq);
+		wsp_ics_free_irq(phb->dn, hwirq);
+	}
+}
+
+void wsp_setup_phb_msi(struct pci_controller *phb)
+{
+	/* Create a single MVE at offset 0 that matches everything */
+	out_be64(phb->cfg_data + PCIE_REG_IODA_ADDR, PCIE_REG_IODA_AD_TBL_MVT);
+	out_be64(phb->cfg_data + PCIE_REG_IODA_DATA0, 1ull << 63);
+
+	ppc_md.setup_msi_irqs = wsp_setup_msi_irqs;
+	ppc_md.teardown_msi_irqs = wsp_teardown_msi_irqs;
+}
diff --git a/arch/powerpc/platforms/wsp/msi.h b/arch/powerpc/platforms/wsp/msi.h
new file mode 100644
index 0000000..0ab27b7
--- /dev/null
+++ b/arch/powerpc/platforms/wsp/msi.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright 2011 Michael Ellerman, IBM Corp.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __WSP_MSI_H
+#define __WSP_MSI_H
+
+#ifdef CONFIG_PCI_MSI
+extern void wsp_setup_phb_msi(struct pci_controller *phb);
+#else
+static inline void wsp_setup_phb_msi(struct pci_controller *phb) { }
+#endif
+
+#endif /* __WSP_MSI_H */
-- 
1.7.0.4
