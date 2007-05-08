Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 08 May 2007 12:58:37 +1000
Subject: [PATCH 7/7] MPIC U3/U4 MSI backend
In-Reply-To: <1178593113.675058.404575641543.qpush@cradle>
Message-Id: <20070508025843.0D93ADDEFD@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPIC U3/U4 MSI backend. Based on code from Segher, heavily hacked by me.
This only deals with MSI on U3/U4 MPICs, aka. CPC 9x5.

If we find a U3/U4 then we enable this backend, ie. take over the ppc_md
MSI hooks. We might need more elaborate logic in future to decide which
backend is enabled.

We need our own irq_chip so that we can do MSI masking/unmasking on
the device itself. We also need to mask explicitly on shutdown to make
sure we don't get bitten by lazy-disable semantics.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/sysdev/Makefile     |    2 
 arch/powerpc/sysdev/mpic.c       |   14 +-
 arch/powerpc/sysdev/mpic.h       |   11 ++
 arch/powerpc/sysdev/mpic_u3msi.c |  186 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 206 insertions(+), 7 deletions(-)

Index: msi-new/arch/powerpc/sysdev/Makefile
===================================================================
--- msi-new.orig/arch/powerpc/sysdev/Makefile
+++ msi-new/arch/powerpc/sysdev/Makefile
@@ -2,7 +2,7 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS			+= -mno-minimal-toc
 endif
 
-mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o
+mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
 
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
Index: msi-new/arch/powerpc/sysdev/mpic.c
===================================================================
--- msi-new.orig/arch/powerpc/sysdev/mpic.c
+++ msi-new/arch/powerpc/sysdev/mpic.c
@@ -606,7 +606,7 @@ static irqreturn_t mpic_ipi_action(int i
  */
 
 
-static void mpic_unmask_irq(unsigned int irq)
+void mpic_unmask_irq(unsigned int irq)
 {
 	unsigned int loops = 100000;
 	struct mpic *mpic = mpic_from_irq(irq);
@@ -626,7 +626,7 @@ static void mpic_unmask_irq(unsigned int
 	} while(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK);
 }
 
-static void mpic_mask_irq(unsigned int irq)
+void mpic_mask_irq(unsigned int irq)
 {
 	unsigned int loops = 100000;
 	struct mpic *mpic = mpic_from_irq(irq);
@@ -647,7 +647,7 @@ static void mpic_mask_irq(unsigned int i
 	} while(!(mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI)) & MPIC_VECPRI_MASK));
 }
 
-static void mpic_end_irq(unsigned int irq)
+void mpic_end_irq(unsigned int irq)
 {
 	struct mpic *mpic = mpic_from_irq(irq);
 
@@ -780,7 +780,7 @@ static unsigned int mpic_type_to_vecpri(
 	}
 }
 
-static int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
+int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
 {
 	struct mpic *mpic = mpic_from_irq(virq);
 	unsigned int src = mpic_irq_to_hw(virq);
@@ -1191,8 +1191,10 @@ void __init mpic_init(struct mpic *mpic)
 
 	/* Do the HT PIC fixups on U3 broken mpic */
 	DBG("MPIC flags: %x\n", mpic->flags);
-	if ((mpic->flags & MPIC_U3_HT_IRQS) && (mpic->flags & MPIC_PRIMARY))
- 		mpic_scan_ht_pics(mpic);
+	if ((mpic->flags & MPIC_U3_HT_IRQS) && (mpic->flags & MPIC_PRIMARY)) {
+		mpic_scan_ht_pics(mpic);
+		mpic_u3msi_init(mpic);
+	}
 
 	for (i = 0; i < mpic->num_sources; i++) {
 		/* start with vector = source number, and masked */
Index: msi-new/arch/powerpc/sysdev/mpic.h
===================================================================
--- msi-new.orig/arch/powerpc/sysdev/mpic.h
+++ msi-new/arch/powerpc/sysdev/mpic.h
@@ -16,12 +16,23 @@ extern void mpic_msi_reserve_hwirq(struc
 extern int mpic_msi_init_allocator(struct mpic *mpic);
 extern irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num);
 extern void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num);
+extern int mpic_u3msi_init(struct mpic *mpic);
 #else
 static inline void mpic_msi_reserve_hwirq(struct mpic *mpic,
 					  irq_hw_number_t hwirq)
 {
 	return;
 }
+
+static inline int mpic_u3msi_init(struct mpic *mpic)
+{
+	return -1;
+}
 #endif
 
+extern int mpic_set_irq_type(unsigned int virq, unsigned int flow_type);
+extern void mpic_end_irq(unsigned int irq);
+extern void mpic_mask_irq(unsigned int irq);
+extern void mpic_unmask_irq(unsigned int irq);
+
 #endif /* _POWERPC_SYSDEV_MPIC_H */
Index: msi-new/arch/powerpc/sysdev/mpic_u3msi.c
===================================================================
--- /dev/null
+++ msi-new/arch/powerpc/sysdev/mpic_u3msi.c
@@ -0,0 +1,186 @@
+/*
+ * Copyright 2006, Segher Boessenkool, IBM Corporation.
+ * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/irq.h>
+#include <linux/bootmem.h>
+#include <linux/msi.h>
+#include <asm/mpic.h>
+#include <asm/prom.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+
+#include "mpic.h"
+
+/* A bit ugly, can we get this from the pci_dev somehow? */
+static struct mpic *msi_mpic;
+
+static void mpic_u3msi_mask_irq(unsigned int irq)
+{
+	mask_msi_irq(irq);
+	mpic_mask_irq(irq);
+}
+
+static void mpic_u3msi_unmask_irq(unsigned int irq)
+{
+	mpic_unmask_irq(irq);
+	unmask_msi_irq(irq);
+}
+
+static struct irq_chip mpic_u3msi_chip = {
+	.shutdown	= mpic_u3msi_mask_irq,
+	.mask		= mpic_u3msi_mask_irq,
+	.unmask		= mpic_u3msi_unmask_irq,
+	.eoi		= mpic_end_irq,
+	.set_type	= mpic_set_irq_type,
+	.typename	= "MPIC-U3MSI",
+};
+
+static u64 read_ht_magic_addr(struct pci_dev *pdev, unsigned int pos)
+{
+	u8 flags;
+	u32 tmp;
+	u64 addr;
+
+	pci_read_config_byte(pdev, pos + HT_MSI_FLAGS, &flags);
+
+	if (flags & HT_MSI_FLAGS_FIXED)
+		return HT_MSI_FIXED_ADDR;
+
+	pci_read_config_dword(pdev, pos + HT_MSI_ADDR_LO, &tmp);
+	addr = tmp & HT_MSI_ADDR_LO_MASK;
+	pci_read_config_dword(pdev, pos + HT_MSI_ADDR_HI, &tmp);
+	addr = addr | ((u64)tmp << 32);
+
+	return addr;
+}
+
+static u64 find_ht_magic_addr(struct pci_dev *pdev)
+{
+	struct pci_bus *bus;
+	unsigned int pos;
+
+	for (bus = pdev->bus; bus; bus = bus->parent) {
+		pos = pci_find_ht_capability(bus->self, HT_CAPTYPE_MSI_MAPPING);
+		if (pos)
+			return read_ht_magic_addr(bus->self, pos);
+	}
+
+	return 0;
+}
+
+static int u3msi_msi_check_device(struct pci_dev *pdev, int nvec, int type)
+{
+	if (type == PCI_CAP_ID_MSIX)
+		pr_debug("u3msi: MSI-X untested, trying anyway.\n");
+
+	/* If we can't find a magic address then MSI ain't gonna work */
+	if (find_ht_magic_addr(pdev) == 0) {
+		pr_debug("u3msi: no magic address found for %s\n",
+			 pci_name(pdev));
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static void u3msi_teardown_msi_irqs(struct pci_dev *pdev)
+{
+	struct msi_desc *entry;
+
+        list_for_each_entry(entry, &pdev->msi_list, list) {
+		if (entry->irq == NO_IRQ)
+			continue;
+
+		set_irq_msi(entry->irq, NULL);
+		mpic_msi_free_hwirqs(msi_mpic, virq_to_hw(entry->irq), 1);
+		irq_dispose_mapping(entry->irq);
+	}
+
+	return;
+}
+
+static void u3msi_compose_msi_msg(struct pci_dev *pdev, int virq,
+				  struct msi_msg *msg)
+{
+	u64 addr;
+
+	addr = find_ht_magic_addr(pdev);
+	msg->address_lo = addr & 0xFFFFFFFF;
+	msg->address_hi = addr >> 32;
+	msg->data = virq_to_hw(virq);
+
+	pr_debug("u3msi: allocated virq 0x%x (hw 0x%lx) at address 0x%lx\n",
+		 virq, virq_to_hw(virq), addr);
+}
+
+static int u3msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	irq_hw_number_t hwirq;
+	int rc;
+	unsigned int virq;
+	struct msi_desc *entry;
+	struct msi_msg msg;
+
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, 1);
+		if (hwirq < 0) {
+			rc = hwirq;
+			pr_debug("u3msi: failed allocating hwirq\n");
+			goto out_free;
+		}
+
+		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
+		if (virq == NO_IRQ) {
+			pr_debug("u3msi: failed mapping hwirq 0x%lx\n", hwirq);
+			mpic_msi_free_hwirqs(msi_mpic, hwirq, 1);
+			rc = -ENOSPC;
+			goto out_free;
+		}
+
+		set_irq_msi(virq, entry);
+		set_irq_chip(virq, &mpic_u3msi_chip);
+		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
+
+		u3msi_compose_msi_msg(pdev, virq, &msg);
+		write_msi_msg(virq, &msg);
+
+		hwirq++;
+	}
+
+	return 0;
+
+ out_free:
+	u3msi_teardown_msi_irqs(pdev);
+	return rc;
+}
+
+int mpic_u3msi_init(struct mpic *mpic)
+{
+	int rc;
+
+	rc = mpic_msi_init_allocator(mpic);
+	if (rc) {
+		pr_debug("u3msi: Error allocating bitmap!\n");
+		return rc;
+	}
+
+	pr_debug("u3msi: Registering MPIC U3 MSI callbacks.\n");
+
+	BUG_ON(msi_mpic);
+	msi_mpic = mpic;
+
+	WARN_ON(ppc_md.setup_msi_irqs);
+	ppc_md.setup_msi_irqs = u3msi_setup_msi_irqs;
+	ppc_md.teardown_msi_irqs = u3msi_teardown_msi_irqs;
+	ppc_md.msi_check_device = u3msi_msi_check_device;
+
+	return 0;
+}
