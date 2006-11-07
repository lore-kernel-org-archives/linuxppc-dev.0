Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 07 Nov 2006 18:21:24 +1100
Subject: [RFC/PATCH 6/7] MPIC MSI backend
In-Reply-To: <1162884080.585336.70559261997.qpush@cradle>
Message-Id: <20061107072126.C586067CD6@ozlabs.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Greg Kroah-Hartman <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPIC MSI backend. Based on code from Segher, heavily hacked by me.
This version discovers the magic address by reading the config space.
Still slightly hacky in that we reuse pdev->irq, pending an irq
allocator for MPIC.

Tested, succesfully getting MSIs from the tg3 via HT/PCI-X on a JS21
running SLOF.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/msi-mpic.c |  138 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/msi.h      |    2 
 2 files changed, 140 insertions(+)

Index: msi/arch/powerpc/kernel/msi-mpic.c
===================================================================
--- /dev/null
+++ msi/arch/powerpc/kernel/msi-mpic.c
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2006 Segher Boessenkool, IBM Corp.
+ * Copyright (C) 2006 Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#undef DEBUG
+
+#include <linux/irq.h>
+#include <asm/msi.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+
+static unsigned int find_ht_msi_capability(struct pci_dev *pdev)
+{
+	u8 subcap;
+	unsigned int pos = pci_find_capability(pdev, PCI_CAP_ID_HT);
+
+	while (pos) {
+		pci_read_config_byte(pdev, pos + HT_SUBCAP_OFFSET, &subcap);
+		if (subcap == HT_CAPTYPE_MSI_MAPPING)
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
+static int msi_mpic_check(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	/* We need an irq allocator before we can support multi-MSI & MSI-X */
+	if (num != 1 || type == PCI_CAP_ID_MSIX) {
+		msi_debug("precondition failure for %s\n", pci_name(pdev));
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
+static void msi_mpic_free(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	/* We borrowed the LSI irq, so don't unmap it! */
+	return;
+}
+
+static int msi_mpic_alloc(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	/* For now we reuse the assigned LSI, this is a hack. */
+	set_irq_type(pdev->irq, IRQ_TYPE_EDGE_RISING);
+	entries[0].vector = pdev->irq;
+
+	return 0;
+}
+
+static int msi_mpic_setup_msi_msg(struct pci_dev *pdev,
+		struct msix_entry *entry, struct msi_msg *msg, int type)
+{
+	u64 addr;
+
+	addr = find_ht_magic_addr(pdev);
+	msg->address_lo = addr & 0xFFFFFFFF;
+	msg->address_hi = addr >> 32;
+	msg->data = irq_map[pdev->irq].hwirq;
+
+	msi_debug("allocated irq %d at 0x%lx for %s\n", pdev->irq,
+			addr, pci_name(pdev));
+
+	return 0;
+}
+
+static struct ppc_msi_ops mpic_msi_ops = {
+	.check = msi_mpic_check,
+	.alloc = msi_mpic_alloc,
+	.free = msi_mpic_free,
+	.enable = msi_raw_enable,
+	.disable = msi_raw_disable,
+	.setup_msi_msg = msi_mpic_setup_msi_msg,
+};
+
+static struct ppc_msi_ops *mpic_get_msi_ops(struct pci_dev *pdev)
+{
+	return &mpic_msi_ops;
+}
+
+int msi_mpic_init(void)
+{
+	pr_debug("mpic_msi_init: Registering MPIC MSI ops.\n");
+	ppc_md.get_msi_ops = mpic_get_msi_ops;
+
+	return 0;
+}
Index: msi/include/asm-powerpc/msi.h
===================================================================
--- msi.orig/include/asm-powerpc/msi.h
+++ msi/include/asm-powerpc/msi.h
@@ -170,8 +170,10 @@ extern void msi_raw_disable(struct pci_d
 
 #ifdef CONFIG_PCI_MSI
 extern int msi_rtas_init(void);
+extern int msi_mpic_init(void);
 #else
 static inline int msi_rtas_init(void) { return -1; };
+static inline int msi_mpic_init(void) { return -1; };
 #endif
 
 #endif /* __ASSEMBLY__ */
