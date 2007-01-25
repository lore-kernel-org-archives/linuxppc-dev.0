Return-Path: <michael@ozlabs.org>
To: linux-pci@atrey.karlin.mff.cuni.cz
From: Michael Ellerman <michael@ellerman.id.au>
Date: Thu, 25 Jan 2007 19:34:16 +1100
Subject: [RFC/PATCH 14/16] MPIC MSI backend
In-Reply-To: <1169714047.65693.647693675533.qpush@cradle>
Message-Id: <20070125083417.69895DE3C5@ozlabs.org>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, "David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
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

 drivers/pci/msi/Makefile     |    1 
 drivers/pci/msi/mpic_htmsi.c |  190 +++++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/msi.h    |    3 
 3 files changed, 194 insertions(+)

Index: msi/drivers/pci/msi/Makefile
===================================================================
--- msi.orig/drivers/pci/msi/Makefile
+++ msi/drivers/pci/msi/Makefile
@@ -4,6 +4,7 @@
 
 obj-y			+= core.o raw.o
 obj-$(CONFIG_PPC_RTAS)	+= rtas.o
+obj-$(CONFIG_MPIC)	+= mpic_htmsi.o
 
 ifeq ($(CONFIG_PCI_MSI_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
Index: msi/drivers/pci/msi/mpic_htmsi.c
===================================================================
--- /dev/null
+++ msi/drivers/pci/msi/mpic_htmsi.c
@@ -0,0 +1,190 @@
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
+#include <linux/msi-ops.h>
+#include <asm/msi.h>
+#include <asm/mpic.h>
+#include <asm/prom.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
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
+		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
+		if (virq == NO_IRQ) {
+			msi_debug("failed mapping hwirq 0x%lx for %s\n", hwirq,
+				  pci_name(pdev));
+			goto out_free;
+		}
+
+		/* FIXME should we save the existing type */
+		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
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
+static struct msi_ops mpic_htmsi_ops = {
+	.check = htmsi_check,
+	.alloc = htmsi_alloc,
+	.free = htmsi_free,
+	.enable = msi_raw_enable,
+	.disable = msi_raw_disable,
+	.setup_msi_msg = htmsi_setup_msi_msg,
+};
+
+static struct msi_ops *htmsi_get_msi_ops(struct pci_dev *pdev)
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
Index: msi/include/asm-powerpc/msi.h
===================================================================
--- msi.orig/include/asm-powerpc/msi.h
+++ msi/include/asm-powerpc/msi.h
@@ -20,10 +20,13 @@ static inline struct msi_ops *arch_get_m
 	return NULL;
 }
 
+struct mpic;
 #ifdef CONFIG_PCI_MSI
+extern int mpic_htmsi_init(struct mpic *mpic);
 extern int msi_rtas_init(void);
 #else
 static inline int msi_rtas_init(void) { return -1; };
+static inline int mpic_htmsi_init(struct mpic *mpic) { return -1; }
 #endif
 
 #endif /* __ASM_POWERPC_MSI_H */
