Return-Path: <michael@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
Message-Id: <708d89df09e003c62ecc1371982d964d2d1b3fae.1217977742.git.michael@ellerman.id.au>
In-Reply-To: <b3997f77b701a0886df6eb3a5e4446d4dc538483.1217977742.git.michael@ellerman.id.au>
References: <b3997f77b701a0886df6eb3a5e4446d4dc538483.1217977742.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 2/4] powerpc: Split-out common MSI bitmap logic into
	msi_bitmap.c
Date: Wed,  6 Aug 2008 09:10:01 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are now two almost identical implementations of an MSI bitmap
allocator, one in mpic_msi.c and the other in fsl_msi.c.

Merge them together and put the result in msi_bitmap.c. Some of the
MPIC bits will remain to provide a nicer interface for the MPIC users.

In the process we fix two buglets. The first is that the allocation
routines, now msi_bitmap_alloc_hwirqs(), returned an unsigned result,
even though they use -1 to indicate allocation failure. Although all
the callers were checking correctly, it is much better for the routine
to just return an int. At least until someone wants > ~2 billion MSIs.

The second buglet is that the device tree reservation logic only
allowed power-of-two reservations. AFAICT that didn't effect any existing
code but it's nicer if we can reserve arbitrary irqs from MSI use.

We also add some selftests, which exposed the two buglets and now test
for them, as well as some basic sanity tests. The tests are only built
when CONFIG_DEBUG_KERNEL=y.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug            |    5 +
 arch/powerpc/include/asm/msi_bitmap.h |   35 +++++
 arch/powerpc/sysdev/Kconfig           |    6 +
 arch/powerpc/sysdev/Makefile          |    1 +
 arch/powerpc/sysdev/msi_bitmap.c      |  247 +++++++++++++++++++++++++++++++++
 5 files changed, 294 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 4ebc52a..15eb278 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -51,6 +51,11 @@ config FTR_FIXUP_SELFTEST
 	depends on DEBUG_KERNEL
 	default n
 
+config MSI_BITMAP_SELFTEST
+	bool "Run self-tests of the MSI bitmap code."
+	depends on DEBUG_KERNEL
+	default n
+
 config XMON
 	bool "Include xmon kernel debugger"
 	depends on DEBUG_KERNEL
diff --git a/arch/powerpc/include/asm/msi_bitmap.h b/arch/powerpc/include/asm/msi_bitmap.h
new file mode 100644
index 0000000..97ac3f4
--- /dev/null
+++ b/arch/powerpc/include/asm/msi_bitmap.h
@@ -0,0 +1,35 @@
+#ifndef _POWERPC_SYSDEV_MSI_BITMAP_H
+#define _POWERPC_SYSDEV_MSI_BITMAP_H
+
+/*
+ * Copyright 2008, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/of.h>
+#include <asm/irq.h>
+
+struct msi_bitmap {
+	struct device_node	*of_node;
+	unsigned long		*bitmap;
+	spinlock_t		lock;
+	unsigned int		irq_count;
+};
+
+int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num);
+void msi_bitmap_free_hwirqs(struct msi_bitmap *bmp, unsigned int offset,
+			    unsigned int num);
+void msi_bitmap_reserve_hwirq(struct msi_bitmap *bmp, unsigned int hwirq);
+
+int msi_bitmap_reserve_dt_hwirqs(struct msi_bitmap *bmp);
+
+int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
+		     struct device_node *of_node);
+void msi_bitmap_free(struct msi_bitmap *bmp);
+
+#endif /* _POWERPC_SYSDEV_MSI_BITMAP_H */
diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
index 72fb35b..3965828 100644
--- a/arch/powerpc/sysdev/Kconfig
+++ b/arch/powerpc/sysdev/Kconfig
@@ -6,3 +6,9 @@ config PPC4xx_PCI_EXPRESS
 	bool
 	depends on PCI && 4xx
 	default n
+
+config PPC_MSI_BITMAP
+	bool
+	depends on PCI_MSI
+	default y if MPIC
+	default y if FSL_PCI
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index a90054b..b6c269e 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -5,6 +5,7 @@ endif
 mpic-msi-obj-$(CONFIG_PCI_MSI)	+= mpic_msi.o mpic_u3msi.o mpic_pasemi_msi.o
 obj-$(CONFIG_MPIC)		+= mpic.o $(mpic-msi-obj-y)
 fsl-msi-obj-$(CONFIG_PCI_MSI)	+= fsl_msi.o
+obj-$(CONFIG_PPC_MSI_BITMAP)	+= msi_bitmap.o
 
 obj-$(CONFIG_PPC_MPC106)	+= grackle.o
 obj-$(CONFIG_PPC_DCR_NATIVE)	+= dcr-low.o
diff --git a/arch/powerpc/sysdev/msi_bitmap.c b/arch/powerpc/sysdev/msi_bitmap.c
new file mode 100644
index 0000000..f84217b
--- /dev/null
+++ b/arch/powerpc/sysdev/msi_bitmap.c
@@ -0,0 +1,247 @@
+/*
+ * Copyright 2006-2008, Michael Ellerman, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; version 2 of the
+ * License.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/bitmap.h>
+#include <asm/msi_bitmap.h>
+
+int msi_bitmap_alloc_hwirqs(struct msi_bitmap *bmp, int num)
+{
+	unsigned long flags;
+	int offset, order = get_count_order(num);
+
+	spin_lock_irqsave(&bmp->lock, flags);
+	/*
+	 * This is fast, but stricter than we need. We might want to add
+	 * a fallback routine which does a linear search with no alignment.
+	 */
+	offset = bitmap_find_free_region(bmp->bitmap, bmp->irq_count, order);
+	spin_unlock_irqrestore(&bmp->lock, flags);
+
+	pr_debug("msi_bitmap: allocated 0x%x (2^%d) at offset 0x%x\n",
+		 num, order, offset);
+
+	return offset;
+}
+
+void msi_bitmap_free_hwirqs(struct msi_bitmap *bmp, unsigned int offset,
+			    unsigned int num)
+{
+	unsigned long flags;
+	int order = get_count_order(num);
+
+	pr_debug("msi_bitmap: freeing 0x%x (2^%d) at offset 0x%x\n",
+		 num, order, offset);
+
+	spin_lock_irqsave(&bmp->lock, flags);
+	bitmap_release_region(bmp->bitmap, offset, order);
+	spin_unlock_irqrestore(&bmp->lock, flags);
+}
+
+void msi_bitmap_reserve_hwirq(struct msi_bitmap *bmp, unsigned int hwirq)
+{
+	unsigned long flags;
+
+	pr_debug("msi_bitmap: reserving hwirq 0x%x\n", hwirq);
+
+	spin_lock_irqsave(&bmp->lock, flags);
+	bitmap_allocate_region(bmp->bitmap, hwirq, 0);
+	spin_unlock_irqrestore(&bmp->lock, flags);
+}
+
+/**
+ * msi_bitmap_reserve_dt_hwirqs - Reserve irqs specified in the device tree.
+ * @bmp: pointer to the MSI bitmap.
+ *
+ * Looks in the device tree to see if there is a property specifying which
+ * irqs can be used for MSI. If found those irqs reserved in the device tree
+ * are reserved in the bitmap.
+ *
+ * Returns 0 for success, < 0 if there was an error, and > 0 if no property
+ * was found in the device tree.
+ **/
+int msi_bitmap_reserve_dt_hwirqs(struct msi_bitmap *bmp)
+{
+	int i, j, len;
+	const u32 *p;
+
+	if (!bmp->of_node)
+		return 1;
+
+	p = of_get_property(bmp->of_node, "msi-available-ranges", &len);
+	if (!p) {
+		pr_debug("msi_bitmap: no msi-available-ranges property " \
+			 "found on %s\n", bmp->of_node->full_name);
+		return 1;
+	}
+
+	if (len % (2 * sizeof(u32)) != 0) {
+		printk(KERN_WARNING "msi_bitmap: Malformed msi-available-ranges"
+		       " property on %s\n", bmp->of_node->full_name);
+		return -EINVAL;
+	}
+
+	bitmap_allocate_region(bmp->bitmap, 0, get_count_order(bmp->irq_count));
+
+	spin_lock(&bmp->lock);
+
+	/* Format is: (<u32 start> <u32 count>)+ */
+	len /= 2 * sizeof(u32);
+	for (i = 0; i < len; i++, p += 2) {
+		for (j = 0; j < *(p + 1); j++)
+			bitmap_release_region(bmp->bitmap, *p + j, 0);
+	}
+
+	spin_unlock(&bmp->lock);
+
+	return 0;
+}
+
+int msi_bitmap_alloc(struct msi_bitmap *bmp, unsigned int irq_count,
+		     struct device_node *of_node)
+{
+	int size;
+
+	if (!irq_count)
+		return -EINVAL;
+
+	size = BITS_TO_LONGS(irq_count) * sizeof(long);
+	pr_debug("msi_bitmap: allocator bitmap size is 0x%x bytes\n", size);
+
+	bmp->bitmap = zalloc_maybe_bootmem(size, GFP_KERNEL);
+	if (!bmp->bitmap) {
+		pr_debug("msi_bitmap: ENOMEM allocating allocator bitmap!\n");
+		return -ENOMEM;
+	}
+
+	/* We zalloc'ed the bitmap, so all irqs are free by default */
+	spin_lock_init(&bmp->lock);
+	bmp->of_node = of_node_get(of_node);
+	bmp->irq_count = irq_count;
+
+	return 0;
+}
+
+void msi_bitmap_free(struct msi_bitmap *bmp)
+{
+	/* we can't free the bitmap we don't know if it's bootmem etc. */
+	of_node_put(bmp->of_node);
+	bmp->bitmap = NULL;
+}
+
+#ifdef CONFIG_MSI_BITMAP_SELFTEST
+
+#define check(x)	\
+	if (!(x)) printk("msi_bitmap: test failed at line %d\n", __LINE__);
+
+void test_basics(void)
+{
+	struct msi_bitmap bmp;
+	int i, size = 512;
+
+	/* Can't allocate a bitmap of 0 irqs */
+	check(msi_bitmap_alloc(&bmp, 0, NULL) != 0);
+
+	/* of_node may be NULL */
+	check(0 == msi_bitmap_alloc(&bmp, size, NULL));
+
+	/* Should all be free by default */
+	check(0 == bitmap_find_free_region(bmp.bitmap, size,
+					   get_count_order(size)));
+	bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
+
+	/* With no node, there's no msi-available-ranges, so expect > 0 */
+	check(msi_bitmap_reserve_dt_hwirqs(&bmp) > 0);
+
+	/* Should all still be free */
+	check(0 == bitmap_find_free_region(bmp.bitmap, size,
+					   get_count_order(size)));
+	bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
+
+	/* Check we can fill it up and then no more */
+	for (i = 0; i < size; i++)
+		check(msi_bitmap_alloc_hwirqs(&bmp, 1) >= 0);
+
+	check(msi_bitmap_alloc_hwirqs(&bmp, 1) < 0);
+
+	/* Should all be allocated */
+	check(bitmap_find_free_region(bmp.bitmap, size, 0) < 0);
+
+	/* And if we free one we can then allocate another */
+	msi_bitmap_free_hwirqs(&bmp, size / 2, 1);
+	check(msi_bitmap_alloc_hwirqs(&bmp, 1) == size / 2);
+
+	msi_bitmap_free(&bmp);
+
+	/* Clients may check bitmap == NULL for "not-allocated" */
+	check(bmp.bitmap == NULL);
+
+	kfree(bmp.bitmap);
+}
+
+void test_of_node(void)
+{
+	u32 prop_data[] = { 10, 10, 25, 3, 40, 1, 100, 100, 200, 20 };
+	const char *expected_str = "0-9,20-24,28-39,41-99,220-255";
+	char *prop_name = "msi-available-ranges";
+	char *node_name = "/fakenode";
+	struct device_node of_node;
+	struct property prop;
+	struct msi_bitmap bmp;
+	int size = 256;
+	DECLARE_BITMAP(expected, size);
+
+	/* There should really be a struct device_node allocator */
+	memset(&of_node, 0, sizeof(of_node));
+	kref_init(&of_node.kref);
+	of_node.full_name = node_name;
+
+	check(0 == msi_bitmap_alloc(&bmp, size, &of_node));
+
+	/* No msi-available-ranges, so expect > 0 */
+	check(msi_bitmap_reserve_dt_hwirqs(&bmp) > 0);
+
+	/* Should all still be free */
+	check(0 == bitmap_find_free_region(bmp.bitmap, size,
+					   get_count_order(size)));
+	bitmap_release_region(bmp.bitmap, 0, get_count_order(size));
+
+	/* Now create a fake msi-available-ranges property */
+
+	/* There should really .. oh whatever */
+	memset(&prop, 0, sizeof(prop));
+	prop.name = prop_name;
+	prop.value = &prop_data;
+	prop.length = sizeof(prop_data);
+
+	of_node.properties = &prop;
+
+	/* msi-available-ranges, so expect == 0 */
+	check(msi_bitmap_reserve_dt_hwirqs(&bmp) == 0);
+
+	/* Check we got the expected result */
+	check(0 == bitmap_parselist(expected_str, expected, size));
+	check(bitmap_equal(expected, bmp.bitmap, size));
+
+	msi_bitmap_free(&bmp);
+	kfree(bmp.bitmap);
+}
+
+int msi_bitmap_selftest(void)
+{
+	printk(KERN_DEBUG "Running MSI bitmap self-tests ...\n");
+
+	test_basics();
+	test_of_node();
+
+	return 0;
+}
+late_initcall(msi_bitmap_selftest);
+#endif /* CONFIG_MSI_BITMAP_SELFTEST */
-- 
1.5.5
