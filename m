Return-Path: <michael@ozlabs.org>
To: Greg Kroah-Hartman <greg@kroah.com>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 11 Jan 2007 22:25:21 +1100
Subject: [PATCH 5/7] MPIC MSI backend
In-Reply-To: <1168514716.63474.857278133999.qpush@cradle>
Message-Id: <20070111112507.064D3DDF7B@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Olof Johannsson <olof@lixom.net>, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPIC MSI backend. Based on code from Segher, heavily hacked by me.
Renamed to mpic_htmsi, as it only deals with MSI over Hypertransport.

We properly discover the HT magic address by reading the config space.
Now we have an irq allocator we can support > 1 MSI, and we don't reuse
the LSI.

Tested, succesfully getting MSIs from the tg3 via HT/PCI-X on a JS21
running SLOF. Successive insmod/rmmods working too.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/sysdev/Makefile     |    2 
 arch/powerpc/sysdev/mpic.h       |    7 +
 arch/powerpc/sysdev/mpic_htmsi.c |  191 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 1 deletion(-)

Index: msi/arch/powerpc/sysdev/Makefile
===================================================================
--- msi.orig/arch/powerpc/sysdev/Makefile
+++ msi/arch/powerpc/sysdev/Makefile
@@ -3,7 +3,7 @@ EXTRA_CFLAGS			+= -mno-minimal-toc
 endif
 
 mpic-obj-y			:= mpic.o
-mpic-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o
+mpic-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_htmsi.o
 obj-$(CONFIG_MPIC)		+= $(mpic-obj-y)
 
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
Index: msi/arch/powerpc/sysdev/mpic.h
===================================================================
--- msi.orig/arch/powerpc/sysdev/mpic.h
+++ msi/arch/powerpc/sysdev/mpic.h
@@ -15,11 +15,18 @@
 #include <asm/msi.h>
 
 #ifdef CONFIG_PCI_MSI
+extern int mpic_htmsi_init(struct mpic *mpic);
+
 extern int mpic_msi_init_allocator(struct mpic *mpic);
 extern void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq);
 extern irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num);
 extern void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num);
 #else
+static inline int mpic_htmsi_init(struct mpic *mpic)
+{
+	return -1;
+}
+
 static inline void mpic_msi_reserve_hwirq(struct mpic *mpic,
 					  irq_hw_number_t hwirq)
 {
Index: msi/arch/powerpc/sysdev/mpic_htmsi.c
===================================================================
--- /dev/null
+++ msi/arch/powerpc/sysdev/mpic_htmsi.c
@@ -0,0 +1,191 @@
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
+#include <asm/msi.h>
+#include <asm/mpic.h>
+#include <asm/prom.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+
+#include "mpic.h"
+
+/* XXX Do we ever need > 1 of these? void * msi_ops.data perhaps ? */
+static struct mpic *msi_mpic;
+
+static unsigned int find_ht_msi_capability(struct pci_dev *pdev)
+{
+	unsigned int pos = pci_find_capability(pdev, PCI_CAP_ID_HT);
+	u8 subcap, ttl = 48;
+
+	while (pos && ttl--) {
+		pci_read_config_byte(pdev, pos + 3, &subcap);
+		if ((subcap & 0xF8) == HT_CAPTYPE_MSI_MAPPING)
+			return pos;
+		pos = pci_find_next_capability(pdev, pos, PCI_CAP_ID_HT);
+	}
+
+	return 0;
+}
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
+		pos = find_ht_msi_capability(bus->self);
+		if (pos)
+			return read_ht_magic_addr(bus->self, pos);
+	}
+
+	return 0;
+}
+
+static int htmsi_check(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	if (type == PCI_CAP_ID_MSIX) {
+		msi_debug("MSI-X unsupported for %s\n", pci_name(pdev));
+		return 1;
+	}
+
+	/* If we can't find a magic address then MSI ain't gonna work */
+	if (find_ht_magic_addr(pdev) == 0) {
+		msi_debug("no magic address found for %s\n", pci_name(pdev));
+		return 1;
+	}
+
+	return 0;
+}
+
+static void htmsi_free(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	irq_hw_number_t hwirq;
+	int i;
+
+	hwirq = irq_map[entries[0].vector].hwirq;
+
+	for (i = 0; i < num; i++) {
+		irq_dispose_mapping(entries[i].vector);
+		entries[i].vector = NO_IRQ;
+	}
+
+	msi_debug("freeing %d hwirqs for msi at offset 0x%lx\n", num, hwirq);
+	mpic_msi_free_hwirqs(msi_mpic, hwirq, num);
+
+	return;
+}
+
+static int htmsi_alloc(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	int i;
+	irq_hw_number_t hwirq;
+	unsigned int virq;
+
+	hwirq = mpic_msi_alloc_hwirqs(msi_mpic, num);
+	if (hwirq < 0) {
+		msi_debug("failed allocating %d hwirqs for %s\n", num,
+			  pci_name(pdev));
+		return -1;
+	}
+
+	for (i = 0; i < num; i++) {
+		/* FIXME should we save the existing type */
+		set_irq_type(hwirq, IRQ_TYPE_EDGE_RISING);
+
+		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
+		if (virq == NO_IRQ) {
+			msi_debug("failed mapping hwirq 0x%lx for %s\n", hwirq,
+				  pci_name(pdev));
+			goto out_free;
+		}
+
+		entries[i].vector = virq;
+		hwirq++;
+	}
+
+	return 0;
+
+ out_free:
+	htmsi_free(pdev, num, entries, type);
+	return -1;
+}
+
+static int htmsi_setup_msi_msg(struct pci_dev *pdev,
+		struct msix_entry *entry, struct msi_msg *msg, int type)
+{
+	u64 addr;
+
+	addr = find_ht_magic_addr(pdev);
+	msg->address_lo = addr & 0xFFFFFFFF;
+	msg->address_hi = addr >> 32;
+	msg->data = irq_map[entry->vector].hwirq;
+
+	msi_debug("allocated irq %d at 0x%lx for %s\n", entry->vector,
+			addr, pci_name(pdev));
+
+	return 0;
+}
+
+static struct ppc_msi_ops mpic_htmsi_ops = {
+	.check = htmsi_check,
+	.alloc = htmsi_alloc,
+	.free = htmsi_free,
+	.enable = msi_raw_enable,
+	.disable = msi_raw_disable,
+	.setup_msi_msg = htmsi_setup_msi_msg,
+};
+
+static struct ppc_msi_ops *htmsi_get_msi_ops(struct pci_dev *pdev)
+{
+	return &mpic_htmsi_ops;
+}
+
+int mpic_htmsi_init(struct mpic *mpic)
+{
+	int rc;
+
+	rc = mpic_msi_init_allocator(mpic);
+	if (rc) {
+		pr_debug("mpic_htmsi_init: Error allocating bitmap!\n");
+		return rc;
+	}
+
+	msi_mpic = mpic;
+
+	pr_debug("mpic_htmsi_init: Registering MPIC MSI ops.\n");
+	ppc_md.get_msi_ops = htmsi_get_msi_ops;
+
+	return 0;
+}
