Return-Path: <michael@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Fri, 29 Sep 2006 10:16:56 +1000
Subject: [PATCH] Preliminary MPIC MSI backend
In-Reply-To: <1159486661.25820.1.camel@localhost.localdomain>
Message-Id: <20060929001657.6EFE667B8F@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A pretty hackish MPIC backend, just enough to flesh out the design.
Based on code from Segher.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/kernel/Makefile   |    1 
 arch/powerpc/kernel/msi-mpic.c |   92 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

Index: to-merge/arch/powerpc/kernel/Makefile
===================================================================
--- to-merge.orig/arch/powerpc/kernel/Makefile
+++ to-merge/arch/powerpc/kernel/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32
 
 msiobj-y			:= msi.o
 msiobj-$(CONFIG_PPC_PSERIES)	+= msi-rtas.o
+msiobj-$(CONFIG_PPC_PMAC)	+= msi-mpic.o
 obj-$(CONFIG_PCI_MSI)		+= $(msiobj-y)
 
 kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
Index: to-merge/arch/powerpc/kernel/msi-mpic.c
===================================================================
--- /dev/null
+++ to-merge/arch/powerpc/kernel/msi-mpic.c
@@ -0,0 +1,92 @@
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
+#define DEBUG 1
+
+#include <linux/irq.h>
+#include <asm/msi.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+
+static int msi_mpic_check(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	/* The irq allocator needs more work to support MSI-X/multi-MSI */
+	if (type == PCI_CAP_ID_MSIX || num != 1)
+		return 1;
+
+	return 0;
+}
+
+static void msi_mpic_free(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	int i;
+
+	for (i = 0; i < num; i++)
+		irq_dispose_mapping(entries[i].vector);
+}
+
+static int msi_mpic_alloc(struct pci_dev *pdev, int num,
+			struct msix_entry *entries, int type)
+{
+	irq_hw_number_t hwirq;
+	unsigned int virq;
+
+	/* We need a smarter allocator for MSI-X/multi-MSI */
+	hwirq = irq_map[pdev->irq].hwirq;
+	hwirq += 100;
+
+	virq = irq_create_mapping(NULL, hwirq);
+	if (virq == NO_IRQ) {
+		pr_debug("msi_mpic_alloc: Failed mapping hwirq %lu\n", hwirq);
+		return -1;
+	}
+
+	set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
+	entries[0].vector = virq;
+
+	return 0;
+}
+
+static int msi_mpic_setup_msi_msg(struct pci_dev *pdev,
+		struct msix_entry *entry, struct msi_msg *msg, int type)
+{
+	msg->address_lo = 0xfee00000;	/* XXX What is this value? */
+	msg->address_hi = 0;
+	msg->data = pdev->irq | 0x8000;
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
+static int msi_mpic_init(void)
+{
+	/* XXX Do this in mpic_init ? */
+	pr_debug("mpic_msi_init: Registering MPIC MSI ops.\n");
+	ppc_md.get_msi_ops = mpic_get_msi_ops;
+
+	return 0;
+}
+__initcall(msi_mpic_init);
