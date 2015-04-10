Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 09E991A04DD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 11:52:11 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/pasemi: Only the build the pasemi MSI code for
 PASEMI=y
Date: Fri, 10 Apr 2015 11:52:06 +1000
Message-Id: <1428630726-12905-1-git-send-email-mpe@ellerman.id.au>
Cc: Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pasemi MSI code is currently always built when MPIC=y && PCI_MSI=y.
It should not have any effect on other platforms, because it immediately
checks the MPIC's compatible property for "pasemi,pwrficient-openpic".

However it's odd that it's still built even when PASEMI=n. It also
needn't be in sysdev, as it's only used by pasemi. So move it into
platforms/pasemi, whereby it will only be built for PASEMI=y.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/pasemi/Makefile |   1 +
 arch/powerpc/platforms/pasemi/msi.c    | 165 ++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/Makefile           |   2 +-
 arch/powerpc/sysdev/mpic.h             |  10 +-
 arch/powerpc/sysdev/mpic_pasemi_msi.c  | 167 ---------------------------------
 5 files changed, 172 insertions(+), 173 deletions(-)
 create mode 100644 arch/powerpc/platforms/pasemi/msi.c
 delete mode 100644 arch/powerpc/sysdev/mpic_pasemi_msi.c

diff --git a/arch/powerpc/platforms/pasemi/Makefile b/arch/powerpc/platforms/pasemi/Makefile
index 8e8d4cae5ebe..60b4e0fd9808 100644
--- a/arch/powerpc/platforms/pasemi/Makefile
+++ b/arch/powerpc/platforms/pasemi/Makefile
@@ -1,2 +1,3 @@
 obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o dma_lib.o misc.o
 obj-$(CONFIG_PPC_PASEMI_MDIO)	+= gpio_mdio.o
+obj-$(CONFIG_PCI_MSI)		+= msi.o
diff --git a/arch/powerpc/platforms/pasemi/msi.c b/arch/powerpc/platforms/pasemi/msi.c
new file mode 100644
index 000000000000..0b3706604543
--- /dev/null
+++ b/arch/powerpc/platforms/pasemi/msi.c
@@ -0,0 +1,165 @@
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
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include <asm/mpic.h>
+#include <asm/prom.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+#include <asm/msi_bitmap.h>
+
+#include <sysdev/mpic.h>
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
+static void mpic_pasemi_msi_mask_irq(struct irq_data *data)
+{
+	pr_debug("mpic_pasemi_msi_mask_irq %d\n", data->irq);
+	pci_msi_mask_irq(data);
+	mpic_mask_irq(data);
+}
+
+static void mpic_pasemi_msi_unmask_irq(struct irq_data *data)
+{
+	pr_debug("mpic_pasemi_msi_unmask_irq %d\n", data->irq);
+	mpic_unmask_irq(data);
+	pci_msi_unmask_irq(data);
+}
+
+static struct irq_chip mpic_pasemi_msi_chip = {
+	.irq_shutdown		= mpic_pasemi_msi_mask_irq,
+	.irq_mask		= mpic_pasemi_msi_mask_irq,
+	.irq_unmask		= mpic_pasemi_msi_unmask_irq,
+	.irq_eoi		= mpic_end_irq,
+	.irq_set_type		= mpic_set_irq_type,
+	.irq_set_affinity	= mpic_set_affinity,
+	.name			= "PASEMI-MSI",
+};
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
+		irq_set_msi_desc(entry->irq, NULL);
+		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap,
+				       virq_to_hw(entry->irq), ALLOC_CHUNK);
+		irq_dispose_mapping(entry->irq);
+	}
+
+	return;
+}
+
+static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
+{
+	unsigned int virq;
+	struct msi_desc *entry;
+	struct msi_msg msg;
+	int hwirq;
+
+	if (type == PCI_CAP_ID_MSIX)
+		pr_debug("pasemi_msi: MSI-X untested, trying anyway\n");
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
+		hwirq = msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap,
+						ALLOC_CHUNK);
+		if (hwirq < 0) {
+			pr_debug("pasemi_msi: failed allocating hwirq\n");
+			return hwirq;
+		}
+
+		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
+		if (virq == NO_IRQ) {
+			pr_debug("pasemi_msi: failed mapping hwirq 0x%x\n",
+				  hwirq);
+			msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq,
+					       ALLOC_CHUNK);
+			return -ENOSPC;
+		}
+
+		/* Vector on MSI is really an offset, the hardware adds
+		 * it to the value written at the magic address. So set
+		 * it to 0 to remain sane.
+		 */
+		mpic_set_vector(virq, 0);
+
+		irq_set_msi_desc(virq, entry);
+		irq_set_chip(virq, &mpic_pasemi_msi_chip);
+		irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
+
+		pr_debug("pasemi_msi: allocated virq 0x%x (hw 0x%x) " \
+			 "addr 0x%x\n", virq, hwirq, msg.address_lo);
+
+		/* Likewise, the device writes [0...511] into the target
+		 * register to generate MSI [512...1023]
+		 */
+		msg.data = hwirq-0x200;
+		pci_write_msi_msg(virq, &msg);
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
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f7cb2a1b01fa..5b492a6438ff 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -2,7 +2,7 @@ subdir-ccflags-$(CONFIG_PPC_WERROR) := -Werror
 
 ccflags-$(CONFIG_PPC64)		:= $(NO_MINIMAL_TOC)
 
-mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
+mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
 obj-$(CONFIG_MPIC_TIMER)        += mpic_timer.o
 obj-$(CONFIG_FSL_MPIC_TIMER_WAKEUP)	+= fsl_mpic_timer_wakeup.o
diff --git a/arch/powerpc/sysdev/mpic.h b/arch/powerpc/sysdev/mpic.h
index 24bf07a63924..32971a41853b 100644
--- a/arch/powerpc/sysdev/mpic.h
+++ b/arch/powerpc/sysdev/mpic.h
@@ -15,7 +15,6 @@
 extern void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq);
 extern int mpic_msi_init_allocator(struct mpic *mpic);
 extern int mpic_u3msi_init(struct mpic *mpic);
-extern int mpic_pasemi_msi_init(struct mpic *mpic);
 #else
 static inline void mpic_msi_reserve_hwirq(struct mpic *mpic,
 					  irq_hw_number_t hwirq)
@@ -27,11 +26,12 @@ static inline int mpic_u3msi_init(struct mpic *mpic)
 {
 	return -1;
 }
+#endif
 
-static inline int mpic_pasemi_msi_init(struct mpic *mpic)
-{
-	return -1;
-}
+#if defined(CONFIG_PCI_MSI) && defined(CONFIG_PPC_PASEMI)
+int mpic_pasemi_msi_init(struct mpic *mpic);
+#else
+static inline int mpic_pasemi_msi_init(struct mpic *mpic) { return -1; }
 #endif
 
 extern int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type);
diff --git a/arch/powerpc/sysdev/mpic_pasemi_msi.c b/arch/powerpc/sysdev/mpic_pasemi_msi.c
deleted file mode 100644
index a3f660eed6de..000000000000
--- a/arch/powerpc/sysdev/mpic_pasemi_msi.c
+++ /dev/null
@@ -1,167 +0,0 @@
-/*
- * Copyright 2007, Olof Johansson, PA Semi
- *
- * Based on arch/powerpc/sysdev/mpic_u3msi.c:
- *
- * Copyright 2006, Segher Boessenkool, IBM Corporation.
- * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; version 2 of the
- * License.
- *
- */
-
-#undef DEBUG
-
-#include <linux/irq.h>
-#include <linux/msi.h>
-#include <asm/mpic.h>
-#include <asm/prom.h>
-#include <asm/hw_irq.h>
-#include <asm/ppc-pci.h>
-#include <asm/msi_bitmap.h>
-
-#include "mpic.h"
-
-/* Allocate 16 interrupts per device, to give an alignment of 16,
- * since that's the size of the grouping w.r.t. affinity. If someone
- * needs more than 32 MSI's down the road we'll have to rethink this,
- * but it should be OK for now.
- */
-#define ALLOC_CHUNK 16
-
-#define PASEMI_MSI_ADDR 0xfc080000
-
-/* A bit ugly, can we get this from the pci_dev somehow? */
-static struct mpic *msi_mpic;
-
-
-static void mpic_pasemi_msi_mask_irq(struct irq_data *data)
-{
-	pr_debug("mpic_pasemi_msi_mask_irq %d\n", data->irq);
-	pci_msi_mask_irq(data);
-	mpic_mask_irq(data);
-}
-
-static void mpic_pasemi_msi_unmask_irq(struct irq_data *data)
-{
-	pr_debug("mpic_pasemi_msi_unmask_irq %d\n", data->irq);
-	mpic_unmask_irq(data);
-	pci_msi_unmask_irq(data);
-}
-
-static struct irq_chip mpic_pasemi_msi_chip = {
-	.irq_shutdown		= mpic_pasemi_msi_mask_irq,
-	.irq_mask		= mpic_pasemi_msi_mask_irq,
-	.irq_unmask		= mpic_pasemi_msi_unmask_irq,
-	.irq_eoi		= mpic_end_irq,
-	.irq_set_type		= mpic_set_irq_type,
-	.irq_set_affinity	= mpic_set_affinity,
-	.name			= "PASEMI-MSI",
-};
-
-static void pasemi_msi_teardown_msi_irqs(struct pci_dev *pdev)
-{
-	struct msi_desc *entry;
-
-	pr_debug("pasemi_msi_teardown_msi_irqs, pdev %p\n", pdev);
-
-	list_for_each_entry(entry, &pdev->msi_list, list) {
-		if (entry->irq == NO_IRQ)
-			continue;
-
-		irq_set_msi_desc(entry->irq, NULL);
-		msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap,
-				       virq_to_hw(entry->irq), ALLOC_CHUNK);
-		irq_dispose_mapping(entry->irq);
-	}
-
-	return;
-}
-
-static int pasemi_msi_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
-{
-	unsigned int virq;
-	struct msi_desc *entry;
-	struct msi_msg msg;
-	int hwirq;
-
-	if (type == PCI_CAP_ID_MSIX)
-		pr_debug("pasemi_msi: MSI-X untested, trying anyway\n");
-	pr_debug("pasemi_msi_setup_msi_irqs, pdev %p nvec %d type %d\n",
-		 pdev, nvec, type);
-
-	msg.address_hi = 0;
-	msg.address_lo = PASEMI_MSI_ADDR;
-
-	list_for_each_entry(entry, &pdev->msi_list, list) {
-		/* Allocate 16 interrupts for now, since that's the grouping for
-		 * affinity. This can be changed later if it turns out 32 is too
-		 * few MSIs for someone, but restrictions will apply to how the
-		 * sources can be changed independently.
-		 */
-		hwirq = msi_bitmap_alloc_hwirqs(&msi_mpic->msi_bitmap,
-						ALLOC_CHUNK);
-		if (hwirq < 0) {
-			pr_debug("pasemi_msi: failed allocating hwirq\n");
-			return hwirq;
-		}
-
-		virq = irq_create_mapping(msi_mpic->irqhost, hwirq);
-		if (virq == NO_IRQ) {
-			pr_debug("pasemi_msi: failed mapping hwirq 0x%x\n",
-				  hwirq);
-			msi_bitmap_free_hwirqs(&msi_mpic->msi_bitmap, hwirq,
-					       ALLOC_CHUNK);
-			return -ENOSPC;
-		}
-
-		/* Vector on MSI is really an offset, the hardware adds
-		 * it to the value written at the magic address. So set
-		 * it to 0 to remain sane.
-		 */
-		mpic_set_vector(virq, 0);
-
-		irq_set_msi_desc(virq, entry);
-		irq_set_chip(virq, &mpic_pasemi_msi_chip);
-		irq_set_irq_type(virq, IRQ_TYPE_EDGE_RISING);
-
-		pr_debug("pasemi_msi: allocated virq 0x%x (hw 0x%x) " \
-			 "addr 0x%x\n", virq, hwirq, msg.address_lo);
-
-		/* Likewise, the device writes [0...511] into the target
-		 * register to generate MSI [512...1023]
-		 */
-		msg.data = hwirq-0x200;
-		pci_write_msi_msg(virq, &msg);
-	}
-
-	return 0;
-}
-
-int mpic_pasemi_msi_init(struct mpic *mpic)
-{
-	int rc;
-
-	if (!mpic->irqhost->of_node ||
-	    !of_device_is_compatible(mpic->irqhost->of_node,
-				     "pasemi,pwrficient-openpic"))
-		return -ENODEV;
-
-	rc = mpic_msi_init_allocator(mpic);
-	if (rc) {
-		pr_debug("pasemi_msi: Error allocating bitmap!\n");
-		return rc;
-	}
-
-	pr_debug("pasemi_msi: Registering PA Semi MPIC MSI callbacks\n");
-
-	msi_mpic = mpic;
-	WARN_ON(ppc_md.setup_msi_irqs);
-	ppc_md.setup_msi_irqs = pasemi_msi_setup_msi_irqs;
-	ppc_md.teardown_msi_irqs = pasemi_msi_teardown_msi_irqs;
-
-	return 0;
-}
-- 
2.1.0
