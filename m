Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <michael@ellerman.id.au>
Date: Tue, 08 May 2007 12:58:36 +1000
Subject: [PATCH 6/7] MPIC MSI allocator
In-Reply-To: <1178593113.675058.404575641543.qpush@cradle>
Message-Id: <20070508025842.52107DDF01@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To support MSI on MPIC we need a way to reserve and allocate hardware irq
numbers, this patch implements an allocator for that purpose.

New firmware platforms must define a "msi-available-ranges" property on their
MPIC node for MSI to work. For U3/U4 we do a best-guess setup.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---

 arch/powerpc/sysdev/Makefile   |    4 
 arch/powerpc/sysdev/mpic.c     |    4 
 arch/powerpc/sysdev/mpic.h     |   27 ++++++
 arch/powerpc/sysdev/mpic_msi.c |  183 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/mpic.h     |    5 +
 5 files changed, 222 insertions(+), 1 deletion(-)

Index: msi-new/arch/powerpc/sysdev/Makefile
===================================================================
--- msi-new.orig/arch/powerpc/sysdev/Makefile
+++ msi-new/arch/powerpc/sysdev/Makefile
@@ -2,7 +2,9 @@ ifeq ($(CONFIG_PPC64),y)
 EXTRA_CFLAGS			+= -mno-minimal-toc
 endif
 
-obj-$(CONFIG_MPIC)		+= mpic.o
+mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o
+obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
+
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_PPC_DCR)		+= dcr.o
Index: msi-new/arch/powerpc/sysdev/mpic.c
===================================================================
--- msi-new.orig/arch/powerpc/sysdev/mpic.c
+++ msi-new/arch/powerpc/sysdev/mpic.c
@@ -36,6 +36,8 @@
 #include <asm/mpic.h>
 #include <asm/smp.h>
 
+#include "mpic.h"
+
 #ifdef DEBUG
 #define DBG(fmt...) printk(fmt)
 #else
@@ -879,6 +881,8 @@ static int mpic_host_map(struct irq_host
 	if (hw >= mpic->irq_count)
 		return -EINVAL;
 
+	mpic_msi_reserve_hwirq(mpic, hw);
+
 	/* Default chip */
 	chip = &mpic->hc_irq;
 
Index: msi-new/arch/powerpc/sysdev/mpic.h
===================================================================
--- /dev/null
+++ msi-new/arch/powerpc/sysdev/mpic.h
@@ -0,0 +1,27 @@
+#ifndef _POWERPC_SYSDEV_MPIC_H
+#define _POWERPC_SYSDEV_MPIC_H
+
+/*
+ * Copyright 2006-2007, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#ifdef CONFIG_PCI_MSI
+extern void mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq);
+extern int mpic_msi_init_allocator(struct mpic *mpic);
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
Index: msi-new/arch/powerpc/sysdev/mpic_msi.c
===================================================================
--- /dev/null
+++ msi-new/arch/powerpc/sysdev/mpic_msi.c
@@ -0,0 +1,183 @@
+/*
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
+#include <linux/bitmap.h>
+#include <linux/msi.h>
+#include <asm/mpic.h>
+#include <asm/prom.h>
+#include <asm/hw_irq.h>
+#include <asm/ppc-pci.h>
+
+
+static void __mpic_msi_reserve_hwirq(struct mpic *mpic, irq_hw_number_t hwirq)
+{
+	pr_debug("mpic: reserving hwirq 0x%lx\n", hwirq);
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
+	pr_debug("mpic: allocated 0x%x (2^%d) at offset 0x%x\n",
+		 num, order, offset);
+
+	return offset;
+}
+
+void mpic_msi_free_hwirqs(struct mpic *mpic, int offset, int num)
+{
+	unsigned long flags;
+	int order = get_count_order(num);
+
+	pr_debug("mpic: freeing 0x%x (2^%d) at offset 0x%x\n",
+		 num, order, offset);
+
+	spin_lock_irqsave(&mpic->bitmap_lock, flags);
+	bitmap_release_region(mpic->hwirq_bitmap, offset, order);
+	spin_unlock_irqrestore(&mpic->bitmap_lock, flags);
+}
+
+#ifdef CONFIG_MPIC_U3_HT_IRQS
+static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic)
+{
+	irq_hw_number_t hwirq;
+	struct irq_host_ops *ops = mpic->irqhost->ops;
+	struct device_node *np;
+	int flags, index, i;
+	struct of_irq oirq;
+
+	pr_debug("mpic: found U3, guessing msi allocator setup\n");
+
+	/* Reserve source numbers we know are reserved in the HW */
+	for (i = 0;   i < 8;   i++)
+		__mpic_msi_reserve_hwirq(mpic, i);
+
+	for (i = 42;  i < 46;  i++)
+		__mpic_msi_reserve_hwirq(mpic, i);
+
+	for (i = 100; i < 105; i++)
+		__mpic_msi_reserve_hwirq(mpic, i);
+
+	np = NULL;
+	while ((np = of_find_all_nodes(np))) {
+		pr_debug("mpic: mapping hwirqs for %s\n", np->full_name);
+
+		index = 0;
+		while (of_irq_map_one(np, index++, &oirq) == 0) {
+			ops->xlate(mpic->irqhost, NULL, oirq.specifier,
+						oirq.size, &hwirq, &flags);
+			__mpic_msi_reserve_hwirq(mpic, hwirq);
+		}
+	}
+
+	return 0;
+}
+#else
+static int mpic_msi_reserve_u3_hwirqs(struct mpic *mpic)
+{
+	return -1;
+}
+#endif
+
+static int mpic_msi_reserve_dt_hwirqs(struct mpic *mpic)
+{
+	int i, len;
+	const u32 *p;
+
+	p = of_get_property(mpic->of_node, "msi-available-ranges", &len);
+	if (!p) {
+		pr_debug("mpic: no msi-available-ranges property found on %s\n",
+			  mpic->of_node->full_name);
+		return -ENODEV;
+	}
+
+	if (len % 8 != 0) {
+		printk(KERN_WARNING "mpic: Malformed msi-available-ranges "
+		       "property on %s\n", mpic->of_node->full_name);
+		return -EINVAL;
+	}
+
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
+	int rc, size;
+
+	BUG_ON(mpic->hwirq_bitmap);
+	spin_lock_init(&mpic->bitmap_lock);
+
+	size = BITS_TO_LONGS(mpic->irq_count) * sizeof(long);
+	pr_debug("mpic: allocator bitmap size is 0x%x bytes\n", size);
+
+	if (mem_init_done)
+		mpic->hwirq_bitmap = kmalloc(size, GFP_KERNEL);
+	else
+		mpic->hwirq_bitmap = alloc_bootmem(size);
+
+	if (!mpic->hwirq_bitmap) {
+		pr_debug("mpic: ENOMEM allocating allocator bitmap!\n");
+		return -ENOMEM;
+	}
+
+	memset(mpic->hwirq_bitmap, 0, size);
+
+	rc = mpic_msi_reserve_dt_hwirqs(mpic);
+	if (rc) {
+		if (mpic->flags & MPIC_U3_HT_IRQS)
+			rc = mpic_msi_reserve_u3_hwirqs(mpic);
+
+		if (rc)
+			goto out_free;
+	}
+
+	return 0;
+
+ out_free:
+	if (mem_init_done)
+		kfree(mpic->hwirq_bitmap);
+
+	mpic->hwirq_bitmap = NULL;
+	return rc;
+}
Index: msi-new/include/asm-powerpc/mpic.h
===================================================================
--- msi-new.orig/include/asm-powerpc/mpic.h
+++ msi-new/include/asm-powerpc/mpic.h
@@ -292,6 +292,11 @@ struct mpic
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
