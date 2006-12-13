Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Wed, 13 Dec 2006 21:40:03 +1100
Subject: [PATCH 6/9] MPIC MSI allocator
In-Reply-To: <1166006370.90082.476088563252.qpush@cradle>
Message-Id: <20061213104007.4B8F967DA9@ozlabs.org>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To support MSI on MPIC we need a way to reserve and allocate hardware irq
numbers, this patch implements an allocator for that. It looks like we'll
end up with several backends based on the MPIC, so the allocator is attached
to the struct mpic, not the msi backend.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/sysdev/Makefile   |    5 +
 arch/powerpc/sysdev/mpic.c     |    4 +
 arch/powerpc/sysdev/mpic.h     |   30 +++++++
 arch/powerpc/sysdev/mpic_msi.c |  160 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/mpic.h     |    5 +
 5 files changed, 203 insertions(+), 1 deletion(-)

Index: msi/arch/powerpc/sysdev/Makefile
===================================================================
--- msi.orig/arch/powerpc/sysdev/Makefile
+++ msi/arch/powerpc/sysdev/Makefile
@@ -2,7 +2,10 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS			+= -mno-minimal-toc
 endif
 
-obj-$(CONFIG_MPIC)		+= mpic.o
+mpic-obj-y			:= mpic.o
+mpic-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o
+obj-$(CONFIG_MPIC)		+= $(mpic-obj-y)
+
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o dcr-low.o
Index: msi/arch/powerpc/sysdev/mpic.c
===================================================================
--- msi.orig/arch/powerpc/sysdev/mpic.c
+++ msi/arch/powerpc/sysdev/mpic.c
@@ -36,6 +36,8 @@
 #include <asm/mpic.h>
 #include <asm/smp.h>
 
+#include "mpic.h"
+
 #ifdef DEBUG
 #define DBG(fmt...) printk(fmt)
 #else
@@ -825,6 +827,8 @@ static int mpic_host_map(struct irq_host
 	if (hw >= mpic->irq_count)
 		return -EINVAL;
 
+	mpic_msi_reserve_hwirq(mpic, hw);
+
 	/* Default chip */
 	chip = &mpic->hc_irq;
 
Index: msi/arch/powerpc/sysdev/mpic.h
===================================================================
--- /dev/null
+++ msi/arch/powerpc/sysdev/mpic.h
@@ -0,0 +1,30 @@
+#ifndef _POWERPC_SYSDEV_MPIC_H
+#define _POWERPC_SYSDEV_MPIC_H
+
+/*
+ * Copyright (C) 2006 Michael Ellerman, IBM Corp.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/bitmap.h>
+#include <asm/msi.h>
+
+#ifdef CONFIG_PCI_MSI
+extern int mpic_msi_init_allocator(struct mpic *mpic);
+extern void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq);
+extern irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num);
+extern void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num);
+#else
+static inline void mpic_msi_reserve_hwirq(struct mpic *mpic,
+					  irq_hw_number_t hwirq)
+{
+	return;
+}
+#endif
+
+#endif /* _POWERPC_SYSDEV_MPIC_H */
Index: msi/arch/powerpc/sysdev/mpic_msi.c
===================================================================
--- /dev/null
+++ msi/arch/powerpc/sysdev/mpic_msi.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) 2006 Michael Ellerman, IBM Corp.
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
+#include <linux/bitops.h>
+#include <asm/msi.h>
+#include <asm/mpic.h>
+#include <asm/prom.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+
+
+static void __mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq)
+{
+	msi_debug("reserving hwirq 0x%lx\n", hwirq);
+
+	if (hwirq > mpic->irq_count) {
+		WARN_ON(1);
+		return;
+	}
+
+	bitmap_allocate_region(mpic->hwirq_bitmap, hwirq, 0);
+}
+
+void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq)
+{
+	unsigned long flags;
+
+	/* The mpic calls this even when there is no allocator setup */
+	if (!mpic->hwirq_bitmap)
+		return;
+
+	spin_lock_irqsave(&mpic->bitmap_lock, flags);
+	__mpic_msi_reserve_hwirq(mpic, hwirq);
+	spin_unlock_irqrestore(&mpic->bitmap_lock, flags);
+}
+
+irq_hw_number_t mpic_msi_alloc_hwirqs(struct mpic *mpic, int num)
+{
+	unsigned long flags;
+	int offset, order = get_count_order(num);
+
+	spin_lock_irqsave(&mpic->bitmap_lock, flags);
+	/*
+	 * This is fast, but stricter than we need. We might want to add
+	 * a fallback routine which does a linear search with no alignment.
+	 */
+	offset = bitmap_find_free_region(mpic->hwirq_bitmap, mpic->irq_count,
+					 order);
+	spin_unlock_irqrestore(&mpic->bitmap_lock, flags);
+
+	msi_debug("allocated %d (2^%d) at offset %d\n", num, order, offset);
+
+	return offset;
+}
+
+void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num)
+{
+	unsigned long flags;
+	int order = get_count_order(num);
+
+	msi_debug("freeing %d (2^%d) at offset %d\n", num, order, offset);
+
+	spin_lock_irqsave(&mpic->bitmap_lock, flags);
+	bitmap_release_region(mpic->hwirq_bitmap, offset, order);
+	spin_unlock_irqrestore(&mpic->bitmap_lock, flags);
+}
+
+static void mpic_msi_auto_reserve_hwirqs(struct mpic *mpic)
+{
+	irq_hw_number_t hwirq;
+	struct irq_host_ops *ops = mpic->irqhost->ops;
+	struct device_node *np;
+	int flags, index, i;
+	struct of_irq oirq;
+
+	/* Reserve source numbers we know are reserved in the HW */
+	for (i = 0;   i < 8;   i++)
+		__mpic_msi_reserve_hwirq(mpic, i);
+	for (i = 42;  i < 26;  i++)
+		__mpic_msi_reserve_hwirq(mpic, i);
+	for (i = 100; i < 105; i++)
+		__mpic_msi_reserve_hwirq(mpic, i);
+
+	np = NULL;
+	while ((np = of_find_all_nodes(np))) {
+		msi_debug("mapping hwirqs for %s\n", np->full_name);
+
+		index = 0;
+		while (of_irq_map_one(np, index++, &oirq) == 0) {
+			ops->xlate(mpic->irqhost, NULL, oirq.specifier,
+						oirq.size, &hwirq, &flags);
+			__mpic_msi_reserve_hwirq(mpic, hwirq);
+		}
+	}
+}
+
+static int mpic_msi_reserve_dt_hwirqs(struct mpic *mpic)
+{
+	int i, len;
+	const u32 *p;
+
+	p = get_property(mpic->of_node, "msi-available", &len);
+	if (!p) {
+		msi_debug("no msi-available property found on %s\n",
+			  mpic->of_node->full_name);
+		return -ENODEV;
+	}
+
+	if (len % 8 != 0) {
+		printk(KERN_WARNING "Malformed msi-available property on %s\n",
+		       mpic->of_node->full_name);
+		return -EINVAL;
+	}
+
+	/* By default everything is reserved */
+	bitmap_allocate_region(mpic->hwirq_bitmap, 0,
+			       get_count_order(mpic->irq_count));
+
+	/* Format is: (<u32 start> <u32 count>)+ */
+	len /= sizeof(u32);
+	for (i = 0; i < len / 2; i++, p += 2)
+		mpic_msi_free_hwirqs(mpic, *p, *(p + 1));
+
+	return 0;
+}
+
+int mpic_msi_init_allocator(struct mpic *mpic)
+{
+	int size = mpic->irq_count / 8;
+
+	BUG_ON(mpic->hwirq_bitmap);
+
+	msi_debug("allocator bitmap size is 0x%x bytes\n", size);
+
+	if (mem_init_done)
+		mpic->hwirq_bitmap = kmalloc(size, GFP_KERNEL);
+	else
+		mpic->hwirq_bitmap = alloc_bootmem(size);
+
+	if (!mpic->hwirq_bitmap) {
+		msi_debug("no mem allocating allocator bitmap!\n");
+		return -ENOMEM;
+	}
+
+	memset(mpic->hwirq_bitmap, 0, size);
+
+	if (mpic_msi_reserve_dt_hwirqs(mpic))
+		mpic_msi_auto_reserve_hwirqs(mpic);
+
+	return 0;
+}
Index: msi/include/asm-powerpc/mpic.h
===================================================================
--- msi.orig/include/asm-powerpc/mpic.h
+++ msi/include/asm-powerpc/mpic.h
@@ -300,6 +300,11 @@ struct mpic
 	u32			*hw_set;
 #endif
 
+#ifdef CONFIG_PCI_MSI
+	spinlock_t		bitmap_lock;
+	unsigned long		*hwirq_bitmap;
+#endif
+
 	/* link */
 	struct mpic		*next;
 };
