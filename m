Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 11959DDED5
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 17:39:38 +1100 (EST)
Date: Wed, 12 Dec 2007 00:44:46 -0600
From: Olof Johansson <olof@lixom.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] [POWERPC] pasemi: Implement MSI support
Message-ID: <20071212064446.GB786@lixom.net>
References: <20071212063406.GA786@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071212063406.GA786@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[POWERPC] pasemi: Implement MSI support

Implement MSI support for PA Semi PWRficient platforms. MSI is done
through a special range of sources on the openpic controller, and they're
unfortunately breaking the usual concepts of how sources are programmed:

* The source is calculated as 512 + the value written into the MSI
  register
* The vector for this source is added to the source and reported
  through IACK

This means that for simplicity, it makes much more sense to just set the
vector to 0 for the source, since that's really the vector we expect to
see from IACK.

Also, the affinity/priority registers will affect 16 sources at a
time. To avoid most (simple) users from being limited by this, allocate
16 sources per device but use only one. This means that there's a total
of 32 sources.

If we get usage scenarions that need more sources, the allocator should
probably be revised to take an alignment argument and size, not just do
natural alignment.

Finally, since I'm already touching the MPIC names on pasemi, rename
the base one from the somewhat odd " PAS-OPIC  " to "PASEMI-OPIC".


Signed-off-by: Olof Johansson <olof@lixom.net>

---

Oops, fixed the CONFIG_PCI_MSI=n prototype to be static inline instead
of extern.

 arch/powerpc/platforms/pasemi/setup.c |    2 
 arch/powerpc/sysdev/Makefile          |    2 
 arch/powerpc/sysdev/mpic.c            |   20 +++
 arch/powerpc/sysdev/mpic.h            |    7 +
 arch/powerpc/sysdev/mpic_pasemi_msi.c |  172 ++++++++++++++++++++++++++++++++++
 5 files changed, 201 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 6d7d068..b5dfd42 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -223,7 +223,7 @@ static __init void pas_init_IRQ(void)
 
 	mpic = mpic_alloc(mpic_node, openpic_addr,
 			  MPIC_PRIMARY|MPIC_LARGE_VECTORS,
-			  0, 0, " PAS-OPIC  ");
+			  0, 0, "PASEMI-OPIC");
 	BUG_ON(!mpic);
 
 	mpic_assign_isu(mpic, 0, openpic_addr + 0x10000);
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 99a77d7..85cf8c6 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -2,7 +2,7 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS			+= -mno-minimal-toc
 endif
 
-mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o
+mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
 
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index e479388..aebf025 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -842,6 +842,24 @@ int mpic_set_irq_type(unsigned int virq, unsigned int flow_type)
 	return 0;
 }
 
+void mpic_set_vector(unsigned int virq, unsigned int vector)
+{
+	struct mpic *mpic = mpic_from_irq(virq);
+	unsigned int src = mpic_irq_to_hw(virq);
+	unsigned int vecpri;
+
+	DBG("mpic: set_vector(mpic:@%p,virq:%d,src:%d,vector:0x%x)\n",
+	    mpic, virq, src, vector);
+
+	if (src >= mpic->irq_count)
+		return;
+
+	vecpri = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
+	vecpri = vecpri & ~MPIC_INFO(VECPRI_VECTOR_MASK);
+	vecpri |= vector;
+	mpic_irq_write(src, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
+}
+
 static struct irq_chip mpic_irq_chip = {
 	.mask		= mpic_mask_irq,
 	.unmask		= mpic_unmask_irq,
@@ -1230,6 +1248,8 @@ void __init mpic_init(struct mpic *mpic)
 		mpic_u3msi_init(mpic);
 	}
 
+	mpic_pasemi_msi_init(mpic);
+
 	for (i = 0; i < mpic->num_sources; i++) {
 		/* start with vector = source number, and masked */
 		u32 vecpri = MPIC_VECPRI_MASK | i |
diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
index 1cb6bd8..4783c6e 100644
--- a/arch/powerpc/sysdev/mpic.h
+++ b/arch/powerpc/sysdev/mpic.h
@@ -17,6 +17,7 @@ extern int mpic_msi_init_allocator(struct mpic *mpic);
 extern irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num);
 extern void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num);
 extern int mpic_u3msi_init(struct mpic *mpic);
+extern int mpic_pasemi_msi_init(struct mpic *mpic);
 #else
 static inline void mpic_msi_reserve_hwirq(struct mpic *mpic,
 					  irq_hw_number_t hwirq)
@@ -28,9 +29,15 @@ static inline int mpic_u3msi_init(struct mpic *mpic)
 {
 	return -1;
 }
+
+static inline int mpic_pasemi_msi_init(struct mpic *mpic)
+{
+	return -1;
+}
 #endif
 
 extern int mpic_set_irq_type(unsigned int virq, unsigned int flow_type);
+extern void mpic_set_vector(unsigned int virq, unsigned int vector);
 extern void mpic_end_irq(unsigned int irq);
 extern void mpic_mask_irq(unsigned int irq);
 extern void mpic_unmask_irq(unsigned int irq);
diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
new file mode 100644
index 0000000..d6bfda3
--- /dev/null
+++ b/arch/powerpc/sysdev/mpic_pasemi_msi.c
@@ -0,0 +1,172 @@
+/*
+ * Copyright 2007, Olof Johansson, PA Semi
+ *
+ * Based on arch/powerpc/sysdev/mpic_u3msi.c:
+ *
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
+#undef DEBUG
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
+/* Allocate 16 interrupts per device, to give an alignment of 16,
+ * since that's the size of the grouping w.r.t. affinity. If someone
+ * needs more than 32 MSI's down the road we'll have to rethink this,
+ * but it should be OK for now.
+ */
+#define ALLOC_CHUNK 16
+
+#define PASEMI_MSI_ADDR 0xfc080000
+
+/* A bit ugly, can we get this from the pci_dev somehow? */
+static struct mpic *msi_mpic;
+
+
+static void mpic_pasemi_msi_mask_irq(unsigned int irq)
+{
+	pr_debug("mpic_pasemi_msi_mask_irq %d\n", irq);
+	mask_msi_irq(irq);
+	mpic_mask_irq(irq);
+}
+
+static void mpic_pasemi_msi_unmask_irq(unsigned int irq)
+{
+	pr_debug("mpic_pasemi_msi_unmask_irq %d\n", irq);
+	mpic_unmask_irq(irq);
+	unmask_msi_irq(irq);
+}
+
+static struct irq_chip mpic_pasemi_msi_chip = {
+	.shutdown	= mpic_pasemi_msi_mask_irq,
+	.mask		= mpic_pasemi_msi_mask_irq,
+	.unmask		= mpic_pasemi_msi_unmask_irq,
+	.eoi		= mpic_end_irq,
+	.set_type	= mpic_set_irq_type,
+	.set_affinity	= mpic_set_affinity,
+	.typename	= "PASEMI-MSI ",
+};
+
+static int pasemi_msi_check_device(struct pci_dev *pdev, int nvec, int type)
+{
+	if (type == PCI_CAP_ID_MSIX)
+		pr_debug("pasemi_msi: MSI-X untested, trying anyway\n");
+
+	return 0;
+}
+
+static void pasemi_msi_teardown_msi_irqs(struct pci_dev *pdev)
+{
+	struct msi_desc *entry;
+
+	pr_debug("pasemi_msi_teardown_msi_irqs, pdev %p\n", pdev);
+
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		if (entry->irq == NO_IRQ)
+			continue;
+
+		set_irq_msi(entry->irq, NULL);
+		mpic_msi_free_hwirqs(msi_mpic, virq_to_hw(entry->irq),
+				     ALLOC_CHUNK);
+		irq_dispose_mapping(entry->irq);
+	}
+
+	return;
+}
+
+static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	irq_hw_number_t hwirq;
+	unsigned int virq;
+	struct msi_desc *entry;
+	struct msi_msg msg;
+	u64 addr;
+
+	pr_debug("pasemi_msi_setup_msi_irqs, pdev %p nvec %d type %d\n",
+		 pdev, nvec, type);
+
+	msg.address_hi = 0;
+	msg.address_lo = PASEMI_MSI_ADDR;
+
+	list_for_each_entry(entry, &pdev->msi_list, list) {
+		/* Allocate 16 interrupts for now, since that's the grouping for
+		 * affinity. This can be changed later if it turns out 32 is too
+		 * few MSIs for someone, but restrictions will apply to how the
+		 * sources can be changed independently.
+		 */
+		hwirq = mpic_msi_alloc_hwirqs(msi_mpic, ALLOC_CHUNK);
+		if (hwirq < 0) {
+			pr_debug("pasemi_msi: failed allocating hwirq\n");
+			return hwirq;
+		}
+
+		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
+		if (virq == NO_IRQ) {
+			pr_debug("pasemi_msi: failed mapping hwirq 0x%lx\n", hwirq);
+			mpic_msi_free_hwirqs(msi_mpic, hwirq, ALLOC_CHUNK);
+			return -ENOSPC;
+		}
+
+		/* Vector on MSI is really an offset, the hardware adds
+		 * it to the value written at the magic address. So set
+		 * it to 0 to remain sane.
+		 */
+		mpic_set_vector(virq, 0);
+
+		set_irq_msi(virq, entry);
+		set_irq_chip(virq, &mpic_pasemi_msi_chip);
+		set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
+
+		pr_debug("pasemi_msi: allocated virq 0x%x (hw 0x%lx) addr 0x%lx\n",
+			  virq, hwirq, addr);
+
+		/* Likewise, the device writes [0...511] into the target
+		 * register to generate MSI [512...1023]
+		 */
+		msg.data = hwirq-0x200;
+		write_msi_msg(virq, &msg);
+	}
+
+	return 0;
+}
+
+int mpic_pasemi_msi_init(struct mpic *mpic)
+{
+	int rc;
+
+	if (!mpic->irqhost->of_node ||
+	    !of_device_is_compatible(mpic->irqhost->of_node,
+				     "pasemi,pwrficient-openpic"))
+		return -ENODEV;
+
+	rc = mpic_msi_init_allocator(mpic);
+	if (rc) {
+		pr_debug("pasemi_msi: Error allocating bitmap!\n");
+		return rc;
+	}
+
+	pr_debug("pasemi_msi: Registering PA Semi MPIC MSI callbacks\n");
+
+	msi_mpic = mpic;
+	WARN_ON(ppc_md.setup_msi_irqs);
+	ppc_md.setup_msi_irqs = pasemi_msi_setup_msi_irqs;
+	ppc_md.teardown_msi_irqs = pasemi_msi_teardown_msi_irqs;
+	ppc_md.msi_check_device = pasemi_msi_check_device;
+
+	return 0;
+}
