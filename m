Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C40E67B6F
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 17:57:17 +1000 (EST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k9I85DAu014504
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Oct 2006 03:05:14 -0500
Subject: [PATCH/RFC] Refactor powerpc DMA ops
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 18 Oct 2006 17:57:05 +1000
Message-Id: <1161158225.23947.22.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch completely refactors DMA operations for 64 bits powerpc. 32 bits
is untouched for now (though also untested yet thus I might still have broken
something :). The patch is definitely not yet ready for upstream as some
platforms will still not build/run. It works for powermac and pseries as it
is though (not ebus yet though).

The basic idea is to define an auxilliary structure (struct device_ext) that
can be attached to any struct device in the system. We use the "firmware_data"
pointer to reference it for now, though I kept that very isolated so I can
change it in the future, especially if I get my way with Greg KH and add a
sysdata pointer to struct device instead.

This structure holds the optional OF device node pointer, the DMA ops and
associated void *data (to be used by the ops, typically, the iommu table
pointer for machines with more than one), and a numa node id (if useful)
to constraint consistent memory allocs.

The old vio, pci-iommu and pci-direct DMA ops are gone. They are now replaced
by a set of generic iommu and direct DMA ops (non PCI specific) that can be
used by bus types.

In the case of busses we control completely, like vio, the bus layer will
fill up this structure and all is easy (see the changes to vio.c, ebus will
get a similar treatement as soon as I get to it).

In the case of "foreign" busses like PCI, what I've done is that I create
the data structure in the PCI fixup code (which is run after discovery but
before the struct device is actually registered with the core, as PCI keeps
those two steps separate) and use the old ppc_md. callbacks that I renamed
for consistency, to setup the iommu table pointer if necessary. By default
the dma_ops are set to the content of a global pci_dma_ops that your platform
can set. So if you have no iommu, you can just set that dma_direct_ops and
not implement any of the callbacks.

I need to add a similar callback (or a pair, not sure yet) to handle the
platform and of_platform busses. In fact, I'm not yet sure wether I'll make
the existing pair of callbacks more generic and take a struct device * instead
of pci_device * (and thus rename it again)... though it's unclear what to do
with the one taking a pci_bus as an argument. Also the current implementation
for pSeries is very PCI centric, but I can just test the bus type in there and
make sure it only ever does anything on PCI. So at first, I think I'll just
add a separate callback for of_platform devices.

So it's all here for comments. I hope to have a more polished/finished/tested
version tomorrow or friday but I'm posting it as-is for reviews anyway since
I might have overlooked additional possible cleanups.

Cheers,
Ben.


Index: linux-cell/include/asm-powerpc/device_ext.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/include/asm-powerpc/device_ext.h	2006-10-18 17:34:55.000000000 +1000
@@ -0,0 +1,43 @@
+#ifndef _POWERPC_DEVICE_EXT_H
+#define _POWERPC_DEVICE_EXT_H
+#ifdef __KERNEL__
+
+struct dma_mapping_ops;
+struct device_node;
+
+/*
+ * Auxilliary data structure that can be attached to any struct device
+ * in the system. (Currently using firmware_data, though I'd like to
+ * see a system_data in there instead).
+ *
+ * The structure can be wrapped within a bus-type specific data structure.
+ *
+ * There are no strict lifetime rules for this structure, it's entirely up
+ * to the bus to manage it's lifetime.
+ */
+struct device_ext {
+	/* Optional pointer to an OF device node */
+	struct device_node	*of_node;
+
+	/* DMA operations on that device */
+	struct dma_mapping_ops	*dma_ops;
+	void			*dma_data;
+
+	/* NUMA node if applicable */
+	int			numa_node;
+};
+
+/* Provide accessors in case we move it to some other field */
+static inline struct device_ext *device_get_ext(const struct device *dev)
+{
+	return dev->firmware_data;
+}
+
+static inline void device_set_ext(struct device *dev, struct device_ext *ext)
+{
+	dev->firmware_data = ext;
+}
+
+
+#endif /* __KERNEL__ */
+#endif /* _POWERPC_DEVICE_EXT_H */
Index: linux-cell/arch/powerpc/kernel/dma_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/dma_64.c	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/dma_64.c	2006-10-18 17:34:55.000000000 +1000
@@ -13,49 +13,55 @@
 #include <asm/ibmebus.h>
 #include <asm/scatterlist.h>
 #include <asm/bug.h>
+#include <asm/device_ext.h>
+#include <asm/iommu.h>
+#include <asm/abs_addr.h>
+
+/*
+ * Top level DMA callbacks
+ */
 
 static struct dma_mapping_ops *get_dma_ops(struct device *dev)
 {
-#ifdef CONFIG_PCI
-	if (dev->bus == &pci_bus_type)
-		return &pci_dma_ops;
-#endif
-#ifdef CONFIG_IBMVIO
-	if (dev->bus == &vio_bus_type)
-		return &vio_dma_ops;
-#endif
-#ifdef CONFIG_IBMEBUS
-	if (dev->bus == &ibmebus_bus_type)
-		return &ibmebus_dma_ops;
-#endif
-	return NULL;
+	struct device_ext *dext;
+
+	/* --> If we ever want to handle ISA devices passing NULL here,
+	 * do it right there.
+	 */
+
+	dext = device_get_ext(dev);
+
+	if (unlikely(dext == NULL))
+		return NULL;
+	return dext->dma_ops;
 }
 
 int dma_supported(struct device *dev, u64 mask)
 {
 	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	BUG_ON(!dma_ops);
-
+	if (unlikely(dma_ops == NULL))
+		return 0;
+	if (dma_ops->dma_supported == NULL)
+		return 1;
 	return dma_ops->dma_supported(dev, mask);
 }
 EXPORT_SYMBOL(dma_supported);
 
 int dma_set_mask(struct device *dev, u64 dma_mask)
 {
-#ifdef CONFIG_PCI
-	if (dev->bus == &pci_bus_type)
-		return pci_set_dma_mask(to_pci_dev(dev), dma_mask);
-#endif
-#ifdef CONFIG_IBMVIO
-	if (dev->bus == &vio_bus_type)
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	if (unlikely(dma_ops == NULL))
 		return -EIO;
-#endif /* CONFIG_IBMVIO */
-#ifdef CONFIG_IBMEBUS
-	if (dev->bus == &ibmebus_bus_type)
+
+	if (dma_ops->set_dma_mask != NULL)
+		return dma_ops->set_dma_mask(dev, dma_mask);
+
+	if (!dev->dma_mask || !dma_supported(dev, *dev->dma_mask))
 		return -EIO;
-#endif
-	BUG();
+
+	*dev->dma_mask = dma_mask;
 	return 0;
 }
 EXPORT_SYMBOL(dma_set_mask);
@@ -149,3 +155,196 @@ void dma_unmap_sg(struct device *dev, st
 	dma_ops->unmap_sg(dev, sg, nhwentries, direction);
 }
 EXPORT_SYMBOL(dma_unmap_sg);
+
+
+/*
+ * Generic iommu implementation
+ */
+
+static inline unsigned long device_to_mask(struct device *dev)
+{
+	if (dev->dma_mask && *dev->dma_mask)
+		return *dev->dma_mask;
+	/* Assume devices without mask can take 32 bit addresses */
+	return 0xfffffffful;
+}
+
+
+/* Allocates a contiguous real buffer and creates mappings over it.
+ * Returns the virtual address of the buffer and sets dma_handle
+ * to the dma address (mapping) of the first page.
+ */
+static void *dma_iommu_alloc_coherent(struct device *dev, size_t size,
+				      dma_addr_t *dma_handle, gfp_t flag)
+{
+	struct device_ext *dext = device_get_ext(dev);
+
+	if (unlikely(dext == NULL))
+		return NULL;
+	return iommu_alloc_coherent(dext->dma_data, size, dma_handle,
+				    device_to_mask(dev), flag,
+				    dext->numa_node);
+}
+
+static void dma_iommu_free_coherent(struct device *dev, size_t size,
+				    void *vaddr, dma_addr_t dma_handle)
+{
+	struct device_ext *dext = device_get_ext(dev);
+
+	if (unlikely(dext == NULL))
+		return;
+	iommu_free_coherent(dext->dma_data, size, vaddr, dma_handle);
+}
+
+/* Creates TCEs for a user provided buffer.  The user buffer must be
+ * contiguous real kernel storage (not vmalloc).  The address of the buffer
+ * passed here is the kernel (virtual) address of the buffer.  The buffer
+ * need not be page aligned, the dma_addr_t returned will point to the same
+ * byte within the page as vaddr.
+ */
+static dma_addr_t dma_iommu_map_single(struct device *dev, void *vaddr,
+				       size_t size,
+				       enum dma_data_direction direction)
+{
+	struct device_ext *dext = device_get_ext(dev);
+
+	if (unlikely(dext == NULL))
+		return DMA_ERROR_CODE;
+	return iommu_map_single(dext->dma_data, vaddr, size,
+			        device_to_mask(dev), direction);
+}
+
+
+static void dma_iommu_unmap_single(struct device *dev, dma_addr_t dma_handle,
+				   size_t size,
+				   enum dma_data_direction direction)
+{
+	struct device_ext *dext = device_get_ext(dev);
+
+	if (unlikely(dext == NULL))
+		return;
+	iommu_unmap_single(dext->dma_data, dma_handle, size, direction);
+}
+
+
+static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
+			    int nelems, enum dma_data_direction direction)
+{
+	struct device_ext *dext = device_get_ext(dev);
+
+	if (unlikely(dext == NULL))
+		return -ENXIO;
+	return iommu_map_sg(dext->dma_data, sglist, nelems,
+			    device_to_mask(dev), direction);
+}
+
+static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
+		int nelems, enum dma_data_direction direction)
+{
+	struct device_ext *dext = device_get_ext(dev);
+
+	if (unlikely(dext == NULL))
+		return;
+	iommu_unmap_sg(dext->dma_data, sglist, nelems, direction);
+}
+
+/* We support DMA to/from any memory page via the iommu */
+static int dma_iommu_dma_supported(struct device *dev, u64 mask)
+{
+	struct device_ext *dext = device_get_ext(dev);
+	struct iommu_table *tbl = dext->dma_data;
+
+	if (!tbl || tbl->it_offset > mask) {
+		printk(KERN_INFO "Warning: IOMMU table offset too big for device mask\n");
+		if (tbl)
+			printk(KERN_INFO "mask: 0x%08lx, table offset: 0x%08lx\n",
+				mask, tbl->it_offset);
+		else
+			printk(KERN_INFO "mask: 0x%08lx, table unavailable\n",
+				mask);
+		return 0;
+	} else
+		return 1;
+}
+
+struct dma_mapping_ops dma_iommu_ops = {
+	.alloc_coherent	= dma_iommu_alloc_coherent,
+	.free_coherent	= dma_iommu_free_coherent,
+	.map_single	= dma_iommu_map_single,
+	.unmap_single	= dma_iommu_unmap_single,
+	.map_sg		= dma_iommu_map_sg,
+	.unmap_sg	= dma_iommu_unmap_sg,
+	.dma_supported	= dma_iommu_dma_supported,
+};
+
+
+/*
+ * Generic direct DMA implementation
+ */
+
+static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
+				       dma_addr_t *dma_handle, gfp_t flag)
+{
+	void *ret;
+
+	/* TODO: Maybe use the numa node here too ? */
+	ret = (void *)__get_free_pages(flag, get_order(size));
+	if (ret != NULL) {
+		memset(ret, 0, size);
+		*dma_handle = virt_to_abs(ret);
+	}
+	return ret;
+}
+
+static void dma_direct_free_coherent(struct device *dev, size_t size,
+				     void *vaddr, dma_addr_t dma_handle)
+{
+	free_pages((unsigned long)vaddr, get_order(size));
+}
+
+static dma_addr_t dma_direct_map_single(struct device *dev, void *ptr,
+					size_t size,
+					enum dma_data_direction direction)
+{
+	return virt_to_abs(ptr);
+}
+
+static void dma_direct_unmap_single(struct device *dev, dma_addr_t dma_addr,
+				    size_t size,
+				    enum dma_data_direction direction)
+{
+}
+
+static int dma_direct_map_sg(struct device *dev, struct scatterlist *sg,
+			     int nents, enum dma_data_direction direction)
+{
+	int i;
+
+	for (i = 0; i < nents; i++, sg++) {
+		sg->dma_address = page_to_phys(sg->page) + sg->offset;
+		sg->dma_length = sg->length;
+	}
+
+	return nents;
+}
+
+static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction direction)
+{
+}
+
+static int dma_direct_dma_supported(struct device *dev, u64 mask)
+{
+	return mask < 0x100000000ull;
+}
+
+struct dma_mapping_ops dma_direct_ops = {
+	.alloc_coherent	= dma_direct_alloc_coherent,
+	.free_coherent	= dma_direct_free_coherent,
+	.map_single	= dma_direct_map_single,
+	.unmap_single	= dma_direct_unmap_single,
+	.map_sg		= dma_direct_map_sg,
+	.unmap_sg	= dma_direct_unmap_sg,
+	.dma_supported	= dma_direct_dma_supported,
+};
+
Index: linux-cell/arch/powerpc/kernel/iommu.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/iommu.c	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/iommu.c	2006-10-18 17:34:55.000000000 +1000
@@ -247,9 +247,9 @@ static void iommu_free(struct iommu_tabl
 	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 }
 
-int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
-		struct scatterlist *sglist, int nelems,
-		unsigned long mask, enum dma_data_direction direction)
+int iommu_map_sg(struct iommu_table *tbl, struct scatterlist *sglist,
+		 int nelems, unsigned long mask,
+		 enum dma_data_direction direction)
 {
 	dma_addr_t dma_next = 0, dma_addr;
 	unsigned long flags;
Index: linux-cell/arch/powerpc/kernel/pci_direct_iommu.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_direct_iommu.c	2006-10-18 17:33:45.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,98 +0,0 @@
-/*
- * Support for DMA from PCI devices to main memory on
- * machines without an iommu or with directly addressable
- * RAM (typically a pmac with 2Gb of RAM or less)
- *
- * Copyright (C) 2003 Benjamin Herrenschmidt (benh@kernel.crashing.org)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/kernel.h>
-#include <linux/pci.h>
-#include <linux/delay.h>
-#include <linux/string.h>
-#include <linux/init.h>
-#include <linux/bootmem.h>
-#include <linux/mm.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/sections.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/pci-bridge.h>
-#include <asm/machdep.h>
-#include <asm/pmac_feature.h>
-#include <asm/abs_addr.h>
-#include <asm/ppc-pci.h>
-
-static void *pci_direct_alloc_coherent(struct device *hwdev, size_t size,
-				   dma_addr_t *dma_handle, gfp_t flag)
-{
-	void *ret;
-
-	ret = (void *)__get_free_pages(flag, get_order(size));
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_abs(ret);
-	}
-	return ret;
-}
-
-static void pci_direct_free_coherent(struct device *hwdev, size_t size,
-				 void *vaddr, dma_addr_t dma_handle)
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-}
-
-static dma_addr_t pci_direct_map_single(struct device *hwdev, void *ptr,
-		size_t size, enum dma_data_direction direction)
-{
-	return virt_to_abs(ptr);
-}
-
-static void pci_direct_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
-		size_t size, enum dma_data_direction direction)
-{
-}
-
-static int pci_direct_map_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
-{
-	int i;
-
-	for (i = 0; i < nents; i++, sg++) {
-		sg->dma_address = page_to_phys(sg->page) + sg->offset;
-		sg->dma_length = sg->length;
-	}
-
-	return nents;
-}
-
-static void pci_direct_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
-{
-}
-
-static int pci_direct_dma_supported(struct device *dev, u64 mask)
-{
-	return mask < 0x100000000ull;
-}
-
-static struct dma_mapping_ops pci_direct_ops = {
-	.alloc_coherent = pci_direct_alloc_coherent,
-	.free_coherent = pci_direct_free_coherent,
-	.map_single = pci_direct_map_single,
-	.unmap_single = pci_direct_unmap_single,
-	.map_sg = pci_direct_map_sg,
-	.unmap_sg = pci_direct_unmap_sg,
-	.dma_supported = pci_direct_dma_supported,
-};
-
-void __init pci_direct_iommu_init(void)
-{
-	pci_dma_ops = pci_direct_ops;
-}
Index: linux-cell/arch/powerpc/kernel/pci_iommu.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_iommu.c	2006-10-18 17:33:45.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,164 +0,0 @@
-/*
- * Copyright (C) 2001 Mike Corrigan & Dave Engebretsen, IBM Corporation
- *
- * Rewrite, cleanup, new allocation schemes:
- * Copyright (C) 2004 Olof Johansson, IBM Corporation
- *
- * Dynamic DMA mapping support, platform-independent parts.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-
-#include <linux/init.h>
-#include <linux/types.h>
-#include <linux/slab.h>
-#include <linux/mm.h>
-#include <linux/spinlock.h>
-#include <linux/string.h>
-#include <linux/pci.h>
-#include <linux/dma-mapping.h>
-#include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/iommu.h>
-#include <asm/pci-bridge.h>
-#include <asm/machdep.h>
-#include <asm/ppc-pci.h>
-
-/*
- * We can use ->sysdata directly and avoid the extra work in
- * pci_device_to_OF_node since ->sysdata will have been initialised
- * in the iommu init code for all devices.
- */
-#define PCI_GET_DN(dev) ((struct device_node *)((dev)->sysdata))
-
-static inline struct iommu_table *device_to_table(struct device *hwdev)
-{
-	struct pci_dev *pdev;
-
-	if (!hwdev) {
-		pdev = ppc64_isabridge_dev;
-		if (!pdev)
-			return NULL;
-	} else
-		pdev = to_pci_dev(hwdev);
-
-	return PCI_DN(PCI_GET_DN(pdev))->iommu_table;
-}
-
-
-static inline unsigned long device_to_mask(struct device *hwdev)
-{
-	struct pci_dev *pdev;
-
-	if (!hwdev) {
-		pdev = ppc64_isabridge_dev;
-		if (!pdev) /* This is the best guess we can do */
-			return 0xfffffffful;
-	} else
-		pdev = to_pci_dev(hwdev);
-
-	if (pdev->dma_mask)
-		return pdev->dma_mask;
-
-	/* Assume devices without mask can take 32 bit addresses */
-	return 0xfffffffful;
-}
-
-
-/* Allocates a contiguous real buffer and creates mappings over it.
- * Returns the virtual address of the buffer and sets dma_handle
- * to the dma address (mapping) of the first page.
- */
-static void *pci_iommu_alloc_coherent(struct device *hwdev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flag)
-{
-	return iommu_alloc_coherent(device_to_table(hwdev), size, dma_handle,
-			device_to_mask(hwdev), flag,
-			pcibus_to_node(to_pci_dev(hwdev)->bus));
-}
-
-static void pci_iommu_free_coherent(struct device *hwdev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle)
-{
-	iommu_free_coherent(device_to_table(hwdev), size, vaddr, dma_handle);
-}
-
-/* Creates TCEs for a user provided buffer.  The user buffer must be 
- * contiguous real kernel storage (not vmalloc).  The address of the buffer
- * passed here is the kernel (virtual) address of the buffer.  The buffer
- * need not be page aligned, the dma_addr_t returned will point to the same
- * byte within the page as vaddr.
- */
-static dma_addr_t pci_iommu_map_single(struct device *hwdev, void *vaddr,
-		size_t size, enum dma_data_direction direction)
-{
-	return iommu_map_single(device_to_table(hwdev), vaddr, size,
-			        device_to_mask(hwdev), direction);
-}
-
-
-static void pci_iommu_unmap_single(struct device *hwdev, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction)
-{
-	iommu_unmap_single(device_to_table(hwdev), dma_handle, size, direction);
-}
-
-
-static int pci_iommu_map_sg(struct device *pdev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
-{
-	return iommu_map_sg(pdev, device_to_table(pdev), sglist,
-			nelems, device_to_mask(pdev), direction);
-}
-
-static void pci_iommu_unmap_sg(struct device *pdev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
-{
-	iommu_unmap_sg(device_to_table(pdev), sglist, nelems, direction);
-}
-
-/* We support DMA to/from any memory page via the iommu */
-static int pci_iommu_dma_supported(struct device *dev, u64 mask)
-{
-	struct iommu_table *tbl = device_to_table(dev);
-
-	if (!tbl || tbl->it_offset > mask) {
-		printk(KERN_INFO "Warning: IOMMU table offset too big for device mask\n");
-		if (tbl)
-			printk(KERN_INFO "mask: 0x%08lx, table offset: 0x%08lx\n",
-				mask, tbl->it_offset);
-		else
-			printk(KERN_INFO "mask: 0x%08lx, table unavailable\n",
-				mask);
-		return 0;
-	} else
-		return 1;
-}
-
-struct dma_mapping_ops pci_iommu_ops = {
-	.alloc_coherent = pci_iommu_alloc_coherent,
-	.free_coherent = pci_iommu_free_coherent,
-	.map_single = pci_iommu_map_single,
-	.unmap_single = pci_iommu_unmap_single,
-	.map_sg = pci_iommu_map_sg,
-	.unmap_sg = pci_iommu_unmap_sg,
-	.dma_supported = pci_iommu_dma_supported,
-};
-
-void pci_iommu_init(void)
-{
-	pci_dma_ops = pci_iommu_ops;
-}
Index: linux-cell/include/asm-powerpc/dma-mapping.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/dma-mapping.h	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/include/asm-powerpc/dma-mapping.h	2006-10-18 17:34:55.000000000 +1000
@@ -65,6 +65,33 @@ extern int dma_map_sg(struct device *dev
 extern void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 		int nhwentries, enum dma_data_direction direction);
 
+/*
+ * DMA operations are abstracted for G5 vs. i/pSeries, PCI vs. VIO
+ */
+struct dma_mapping_ops {
+	void *		(*alloc_coherent)(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t flag);
+	void		(*free_coherent)(struct device *dev, size_t size,
+				void *vaddr, dma_addr_t dma_handle);
+	dma_addr_t	(*map_single)(struct device *dev, void *ptr,
+				size_t size, enum dma_data_direction direction);
+	void		(*unmap_single)(struct device *dev, dma_addr_t dma_addr,
+				size_t size, enum dma_data_direction direction);
+	int		(*map_sg)(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction direction);
+	void		(*unmap_sg)(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction direction);
+	int		(*dma_supported)(struct device *dev, u64 mask);
+	int		(*dac_dma_supported)(struct device *dev, u64 mask);
+	int		(*set_dma_mask)(struct device *dev, u64 dma_mask);
+};
+
+/*
+ * Available generic sets of operations
+ */
+extern struct dma_mapping_ops dma_iommu_ops;
+extern struct dma_mapping_ops dma_direct_ops;
+
 #else /* CONFIG_PPC64 */
 
 #define dma_supported(dev, mask)	(1)
@@ -261,25 +288,5 @@ static inline void dma_cache_sync(void *
 	__dma_sync(vaddr, size, (int)direction);
 }
 
-/*
- * DMA operations are abstracted for G5 vs. i/pSeries, PCI vs. VIO
- */
-struct dma_mapping_ops {
-	void *		(*alloc_coherent)(struct device *dev, size_t size,
-				dma_addr_t *dma_handle, gfp_t flag);
-	void		(*free_coherent)(struct device *dev, size_t size,
-				void *vaddr, dma_addr_t dma_handle);
-	dma_addr_t	(*map_single)(struct device *dev, void *ptr,
-				size_t size, enum dma_data_direction direction);
-	void		(*unmap_single)(struct device *dev, dma_addr_t dma_addr,
-				size_t size, enum dma_data_direction direction);
-	int		(*map_sg)(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction);
-	void		(*unmap_sg)(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction);
-	int		(*dma_supported)(struct device *dev, u64 mask);
-	int		(*dac_dma_supported)(struct device *dev, u64 mask);
-};
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
Index: linux-cell/include/asm-powerpc/iommu.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/iommu.h	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/include/asm-powerpc/iommu.h	2006-10-18 17:34:55.000000000 +1000
@@ -69,22 +69,22 @@ extern void iommu_free_table(struct devi
 extern struct iommu_table *iommu_init_table(struct iommu_table * tbl,
 					    int nid);
 
-extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
-		struct scatterlist *sglist, int nelems, unsigned long mask,
-		enum dma_data_direction direction);
+extern int iommu_map_sg(struct iommu_table *tbl, struct scatterlist *sglist,
+			int nelems, unsigned long mask,
+			enum dma_data_direction direction);
 extern void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction);
+			   int nelems, enum dma_data_direction direction);
 
 extern void *iommu_alloc_coherent(struct iommu_table *tbl, size_t size,
-		dma_addr_t *dma_handle, unsigned long mask,
-		gfp_t flag, int node);
+				  dma_addr_t *dma_handle, unsigned long mask,
+				  gfp_t flag, int node);
 extern void iommu_free_coherent(struct iommu_table *tbl, size_t size,
-		void *vaddr, dma_addr_t dma_handle);
+				void *vaddr, dma_addr_t dma_handle);
 extern dma_addr_t iommu_map_single(struct iommu_table *tbl, void *vaddr,
-		size_t size, unsigned long mask,
-		enum dma_data_direction direction);
+				   size_t size, unsigned long mask,
+				   enum dma_data_direction direction);
 extern void iommu_unmap_single(struct iommu_table *tbl, dma_addr_t dma_handle,
-		size_t size, enum dma_data_direction direction);
+			       size_t size, enum dma_data_direction direction);
 
 extern void iommu_init_early_pSeries(void);
 extern void iommu_init_early_iSeries(void);
Index: linux-cell/arch/powerpc/kernel/vio.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/vio.c	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/vio.c	2006-10-18 17:34:55.000000000 +1000
@@ -81,15 +81,15 @@ static struct iommu_table *vio_build_iom
 		struct iommu_table *tbl;
 		unsigned long offset, size;
 
-		dma_window = get_property(dev->dev.platform_data,
-				"ibm,my-dma-window", NULL);
+		dma_window = get_property(dev->dext.of_node,
+					  "ibm,my-dma-window", NULL);
 		if (!dma_window)
 			return NULL;
 
 		tbl = kmalloc(sizeof(*tbl), GFP_KERNEL);
 
-		of_parse_dma_window(dev->dev.platform_data, dma_window,
-				&tbl->it_index, &offset, &size);
+		of_parse_dma_window(dev->dext.of_node, dma_window,
+				    &tbl->it_index, &offset, &size);
 
 		/* TCE table size - measured in tce entries */
 		tbl->it_size = size >> PAGE_SHIFT;
@@ -115,9 +115,11 @@ static struct iommu_table *vio_build_iom
 static const struct vio_device_id *vio_match_device(
 		const struct vio_device_id *ids, const struct vio_dev *dev)
 {
+	struct device_ext *dext = device_get_ext(&dev->dev);
+
 	while (ids->type[0] != '\0') {
 		if ((strncmp(dev->type, ids->type, strlen(ids->type)) == 0) &&
-		    device_is_compatible(dev->dev.platform_data, ids->compat))
+		    device_is_compatible(dext->of_node, ids->compat))
 			return ids;
 		ids++;
 	}
@@ -198,9 +200,11 @@ EXPORT_SYMBOL(vio_unregister_driver);
 /* vio_dev refcount hit 0 */
 static void __devinit vio_dev_release(struct device *dev)
 {
-	if (dev->platform_data) {
+	struct device_ext *dext = device_get_ext(dev);
+
+	if (dext && dext->of_node) {
 		/* XXX free TCE table */
-		of_node_put(dev->platform_data);
+		of_node_put(dext->of_node);
 	}
 	kfree(to_vio_dev(dev));
 }
@@ -210,7 +214,7 @@ static void __devinit vio_dev_release(st
  * @of_node:	The OF node for this device.
  *
  * Creates and initializes a vio_dev structure from the data in
- * of_node (dev.platform_data) and adds it to the list of virtual devices.
+ * of_node and adds it to the list of virtual devices.
  * Returns a pointer to the created vio_dev or NULL if node has
  * NULL device_type or compatible fields.
  */
@@ -240,8 +244,6 @@ struct vio_dev * __devinit vio_register_
 	if (viodev == NULL)
 		return NULL;
 
-	viodev->dev.platform_data = of_node_get(of_node);
-
 	viodev->irq = irq_of_parse_and_map(of_node, 0);
 
 	snprintf(viodev->dev.bus_id, BUS_ID_SIZE, "%x", *unit_address);
@@ -254,7 +256,10 @@ struct vio_dev * __devinit vio_register_
 		if (unit_address != NULL)
 			viodev->unit_address = *unit_address;
 	}
-	viodev->iommu_table = vio_build_iommu_table(viodev);
+	device_set_ext(&viodev->dev, &viodev->dext);
+	viodev->dext.of_node = of_node_get(of_node);
+	viodev->dext.dma_ops = &dma_iommu_ops;
+	viodev->dext.dma_data = vio_build_iommu_table(viodev);
 
 	/* init generic 'struct device' fields: */
 	viodev->dev.parent = &vio_bus_device.dev;
@@ -282,13 +287,16 @@ static int __init vio_bus_init(void)
 	int err;
 	struct device_node *node_vroot;
 
+	device_set_ext(&vio_bus_device.dev, &vio_bus_device.dext);
+
 #ifdef CONFIG_PPC_ISERIES
 	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
 		iommu_vio_init();
-		vio_bus_device.iommu_table = &vio_iommu_table;
+		vio_bus_device.dext.dma_ops = &dma_iommu_ops;
+		vio_bus_device.dext.dma_data = &vio_iommu_table;
 		iSeries_vio_dev = &vio_bus_device.dev;
 	}
-#endif
+#endif /* CONFIG_PPC_ISERIES */
 
 	err = bus_register(&vio_bus_type);
 	if (err) {
@@ -336,7 +344,8 @@ static ssize_t name_show(struct device *
 static ssize_t devspec_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	struct device_node *of_node = dev->platform_data;
+	struct device_ext *dext = device_get_ext(dev);
+	struct device_node *of_node = dext->of_node;
 
 	return sprintf(buf, "%s\n", of_node ? of_node->full_name : "none");
 }
@@ -353,62 +362,6 @@ void __devinit vio_unregister_device(str
 }
 EXPORT_SYMBOL(vio_unregister_device);
 
-static dma_addr_t vio_map_single(struct device *dev, void *vaddr,
-			  size_t size, enum dma_data_direction direction)
-{
-	return iommu_map_single(to_vio_dev(dev)->iommu_table, vaddr, size,
-			~0ul, direction);
-}
-
-static void vio_unmap_single(struct device *dev, dma_addr_t dma_handle,
-		      size_t size, enum dma_data_direction direction)
-{
-	iommu_unmap_single(to_vio_dev(dev)->iommu_table, dma_handle, size,
-			direction);
-}
-
-static int vio_map_sg(struct device *dev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
-{
-	return iommu_map_sg(dev, to_vio_dev(dev)->iommu_table, sglist,
-			nelems, ~0ul, direction);
-}
-
-static void vio_unmap_sg(struct device *dev, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction)
-{
-	iommu_unmap_sg(to_vio_dev(dev)->iommu_table, sglist, nelems, direction);
-}
-
-static void *vio_alloc_coherent(struct device *dev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flag)
-{
-	return iommu_alloc_coherent(to_vio_dev(dev)->iommu_table, size,
-			dma_handle, ~0ul, flag, -1);
-}
-
-static void vio_free_coherent(struct device *dev, size_t size,
-			 void *vaddr, dma_addr_t dma_handle)
-{
-	iommu_free_coherent(to_vio_dev(dev)->iommu_table, size, vaddr,
-			dma_handle);
-}
-
-static int vio_dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
-struct dma_mapping_ops vio_dma_ops = {
-	.alloc_coherent = vio_alloc_coherent,
-	.free_coherent = vio_free_coherent,
-	.map_single = vio_map_single,
-	.unmap_single = vio_unmap_single,
-	.map_sg = vio_map_sg,
-	.unmap_sg = vio_unmap_sg,
-	.dma_supported = vio_dma_supported,
-};
-
 static int vio_bus_match(struct device *dev, struct device_driver *drv)
 {
 	const struct vio_dev *vio_dev = to_vio_dev(dev);
@@ -422,13 +375,17 @@ static int vio_hotplug(struct device *de
 			char *buffer, int buffer_size)
 {
 	const struct vio_dev *vio_dev = to_vio_dev(dev);
-	struct device_node *dn = dev->platform_data;
+	struct device_ext *dext = device_get_ext(dev);
+	struct device_node *dn;
 	const char *cp;
 	int length;
 
 	if (!num_envp)
 		return -ENOMEM;
+	if (!dext)
+		return -ENODEV;
 
+	dn = dext->of_node;
 	if (!dn)
 		return -ENODEV;
 	cp = get_property(dn, "compatible", &length);
@@ -465,7 +422,9 @@ struct bus_type vio_bus_type = {
 */
 const void *vio_get_attribute(struct vio_dev *vdev, char *which, int *length)
 {
-	return get_property(vdev->dev.platform_data, which, length);
+	struct device_ext *dext = device_get_ext(&vdev->dev);
+
+	return get_property(dext->of_node, which, length);
 }
 EXPORT_SYMBOL(vio_get_attribute);
 
Index: linux-cell/include/asm-powerpc/vio.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/vio.h	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/include/asm-powerpc/vio.h	2006-10-18 17:34:55.000000000 +1000
@@ -23,6 +23,7 @@
 
 #include <asm/hvcall.h>
 #include <asm/scatterlist.h>
+#include <asm/device_ext.h>
 
 /*
  * Architecture-specific constants for drivers to
@@ -45,12 +46,12 @@ struct iommu_table;
  * The vio_dev structure is used to describe virtual I/O devices.
  */
 struct vio_dev {
-	struct iommu_table *iommu_table;     /* vio_map_* uses this */
 	const char *name;
 	const char *type;
 	uint32_t unit_address;
 	unsigned int irq;
 	struct device dev;
+	struct device_ext dext;
 };
 
 struct vio_driver {
Index: linux-cell/arch/powerpc/kernel/pci_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/pci_64.c	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/pci_64.c	2006-10-18 17:34:55.000000000 +1000
@@ -31,6 +31,7 @@
 #include <asm/machdep.h>
 #include <asm/ppc-pci.h>
 #include <asm/firmware.h>
+#include <asm/device_ext.h>
 
 #ifdef DEBUG
 #include <asm/udbg.h>
@@ -63,7 +64,7 @@ void iSeries_pcibios_init(void);
 
 LIST_HEAD(hose_list);
 
-struct dma_mapping_ops pci_dma_ops;
+struct dma_mapping_ops *pci_dma_ops;
 EXPORT_SYMBOL(pci_dma_ops);
 
 int global_phb_number;		/* Global phb counter */
@@ -1207,15 +1208,43 @@ void __devinit pcibios_fixup_device_reso
 }
 EXPORT_SYMBOL(pcibios_fixup_device_resources);
 
+void __devinit pcibios_setup_new_device(struct pci_dev *dev)
+{
+	struct device_ext *dext;
+
+	if (device_get_ext(&dev->dev) != NULL)
+		return;
+
+	dext = kzalloc(sizeof(struct device_ext), GFP_KERNEL);
+	if (dext == NULL) {
+		printk(KERN_ERR "Failed to allocate device extension"
+		       " for PCI device %s\n", pci_name(dev));
+		return;
+	}
+	device_set_ext(&dev->dev, dext);
+	dext->of_node = pci_device_to_OF_node(dev);
+	printk("PCI device %s OF node: %s\n", pci_name(dev),
+	       dext->of_node ? dext->of_node->full_name : "<none>");
+	dext->dma_ops = pci_dma_ops;
+
+#ifdef CONFIG_NUMA
+	dext->numa_node = pcibus_to_node(dev->bus);
+#endif
+	if (ppc_md.pci_dma_dev_setup)
+		ppc_md.pci_dma_dev_setup(dev);
+}
+EXPORT_SYMBOL(pcibios_setup_new_device);
 
 static void __devinit do_bus_setup(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
-	ppc_md.iommu_bus_setup(bus);
+	if (ppc_md.pci_dma_bus_setup)
+		ppc_md.pci_dma_bus_setup(bus);
 
-	list_for_each_entry(dev, &bus->devices, bus_list)
-		ppc_md.iommu_dev_setup(dev);
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+		pcibios_setup_new_device(dev);
+	}
 
 	if (ppc_md.irq_bus_setup)
 		ppc_md.irq_bus_setup(bus);
@@ -1419,3 +1448,25 @@ int pcibus_to_node(struct pci_bus *bus)
 }
 EXPORT_SYMBOL(pcibus_to_node);
 #endif
+
+int pci_platform_notify(struct device * dev)
+{
+	return 0;
+}
+
+int pci_platform_notify_remove(struct device * dev)
+{
+	struct device_ext *dext = device_get_ext(dev);
+
+	DBG("%s:%s platform notify remove !\n",
+	    dev_driver_string(dev), dev->bus_id);
+
+	if (dev->bus != &pci_bus_type)
+		return 0;
+
+	device_set_ext(dev, NULL);
+	mb();
+	kfree(dext);
+
+	return 0;
+}
Index: linux-cell/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup_64.c	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup_64.c	2006-10-18 17:34:55.000000000 +1000
@@ -33,6 +33,7 @@
 #include <linux/serial.h>
 #include <linux/serial_8250.h>
 #include <linux/bootmem.h>
+#include <linux/pci.h>
 #include <asm/io.h>
 #include <asm/kdump.h>
 #include <asm/prom.h>
@@ -533,6 +534,10 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 
+#ifdef CONFIG_PCI
+	platform_notify = pci_platform_notify;
+	platform_notify_remove = pci_platform_notify_remove;
+#endif
 	ppc_md.setup_arch();
 
 	paging_init();
Index: linux-cell/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/pseries/iommu.c	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/pseries/iommu.c	2006-10-18 17:34:55.000000000 +1000
@@ -44,6 +44,7 @@
 #include <asm/tce.h>
 #include <asm/ppc-pci.h>
 #include <asm/udbg.h>
+#include <asm/device_ext.h>
 
 #include "plpar_wrappers.h"
 
@@ -329,7 +330,7 @@ static void iommu_table_setparms_lpar(st
 	tbl->it_size = size >> PAGE_SHIFT;
 }
 
-static void iommu_bus_setup_pSeries(struct pci_bus *bus)
+static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 {
 	struct device_node *dn;
 	struct iommu_table *tbl;
@@ -338,10 +339,9 @@ static void iommu_bus_setup_pSeries(stru
 	struct pci_dn *pci;
 	int children;
 
-	DBG("iommu_bus_setup_pSeries, bus %p, bus->self %p\n", bus, bus->self);
-
 	dn = pci_bus_to_OF_node(bus);
-	pci = PCI_DN(dn);
+
+	DBG("pci_dma_bus_setup_pSeries: setting up bus %s\n", dn->full_name);
 
 	if (bus->self) {
 		/* This is not a root bus, any setup will be done for the
@@ -349,6 +349,7 @@ static void iommu_bus_setup_pSeries(stru
 		 */
 		return;
 	}
+	pci = PCI_DN(dn);
 
 	/* Check if the ISA bus on the system is under
 	 * this PHB.
@@ -410,17 +411,17 @@ static void iommu_bus_setup_pSeries(stru
 }
 
 
-static void iommu_bus_setup_pSeriesLP(struct pci_bus *bus)
+static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 {
 	struct iommu_table *tbl;
 	struct device_node *dn, *pdn;
 	struct pci_dn *ppci;
 	const void *dma_window = NULL;
 
-	DBG("iommu_bus_setup_pSeriesLP, bus %p, bus->self %p\n", bus, bus->self);
-
 	dn = pci_bus_to_OF_node(bus);
 
+	DBG("pci_dma_bus_setup_pSeriesLP: setting up bus %s\n", dn->full_name);
+
 	/* Find nearest ibm,dma-window, walking up the device tree */
 	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
 		dma_window = get_property(pdn, "ibm,dma-window", NULL);
@@ -429,11 +430,15 @@ static void iommu_bus_setup_pSeriesLP(st
 	}
 
 	if (dma_window == NULL) {
-		DBG("iommu_bus_setup_pSeriesLP: bus %s seems to have no ibm,dma-window property\n", dn->full_name);
+		DBG("  no ibm,dma-window property !\n");
 		return;
 	}
 
 	ppci = PCI_DN(pdn);
+
+	DBG("  parent is %s, iommu_table: 0x%p\n",
+	    pdn->full_name, ppci->iommu_table);
+
 	if (!ppci->iommu_table) {
 		/* Bussubno hasn't been copied yet.
 		 * Do it now because iommu_table_setparms_lpar needs it.
@@ -447,6 +452,7 @@ static void iommu_bus_setup_pSeriesLP(st
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
 
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
+		DBG("  created table: %p\n", ppci->iommu_table);
 	}
 
 	if (pdn != dn)
@@ -454,27 +460,34 @@ static void iommu_bus_setup_pSeriesLP(st
 }
 
 
-static void iommu_dev_setup_pSeries(struct pci_dev *dev)
+static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 {
-	struct device_node *dn, *mydn;
+	struct device_ext *dext = device_get_ext(&dev->dev);
+	struct device_node *dn;
 	struct iommu_table *tbl;
 
-	DBG("iommu_dev_setup_pSeries, dev %p (%s)\n", dev, pci_name(dev));
+	DBG("pci_dma_dev_setup_pSeries: %s\n", pci_name(dev));
+
+	if (dext == NULL) {
+		printk(KERN_ERR "iommu: Attempt to setup PCI dev %s "
+		       "with no device extension !", pci_name(dev));
+		return;
+	}
 
-	mydn = dn = pci_device_to_OF_node(dev);
+	dn = dext->of_node;
 
 	/* If we're the direct child of a root bus, then we need to allocate
 	 * an iommu table ourselves. The bus setup code should have setup
 	 * the window sizes already.
 	 */
 	if (!dev->bus->self) {
+		struct pci_controller *phb = PCI_DN(dn)->phb;
+
 		DBG(" --> first child, no bridge. Allocating iommu table.\n");
 		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   PCI_DN(dn)->phb->node);
-		iommu_table_setparms(PCI_DN(dn)->phb, dn, tbl);
-		PCI_DN(dn)->iommu_table = iommu_init_table(tbl,
-						PCI_DN(dn)->phb->node);
-
+				   phb->node);
+		iommu_table_setparms(phb, dn, tbl);
+		dext->dma_data = iommu_init_table(tbl, phb->node);
 		return;
 	}
 
@@ -485,11 +498,11 @@ static void iommu_dev_setup_pSeries(stru
 	while (dn && PCI_DN(dn) && PCI_DN(dn)->iommu_table == NULL)
 		dn = dn->parent;
 
-	if (dn && PCI_DN(dn)) {
-		PCI_DN(mydn)->iommu_table = PCI_DN(dn)->iommu_table;
-	} else {
-		DBG("iommu_dev_setup_pSeries, dev %p (%s) has no iommu table\n", dev, pci_name(dev));
-	}
+	if (dn && PCI_DN(dn))
+		dext->dma_data = PCI_DN(dn)->iommu_table;
+	else
+		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
+		       pci_name(dev));
 }
 
 static int iommu_reconfig_notifier(struct notifier_block *nb, unsigned long action, void *node)
@@ -515,14 +528,21 @@ static struct notifier_block iommu_recon
 	.notifier_call = iommu_reconfig_notifier,
 };
 
-static void iommu_dev_setup_pSeriesLP(struct pci_dev *dev)
+static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 {
+	struct device_ext *dext = device_get_ext(&dev->dev);
 	struct device_node *pdn, *dn;
 	struct iommu_table *tbl;
 	const void *dma_window = NULL;
 	struct pci_dn *pci;
 
-	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s)\n", dev, pci_name(dev));
+	DBG("pci_dma_dev_setup_pSeriesLP: %s\n", pci_name(dev));
+
+	if (dext == NULL) {
+		printk(KERN_ERR "iommu: Attempt to setup PCI dev %s "
+		       "with no device extension !", pci_name(dev));
+		return;
+	}
 
 	/* dev setup for LPAR is a little tricky, since the device tree might
 	 * contain the dma-window properties per-device and not neccesarily
@@ -531,6 +551,7 @@ static void iommu_dev_setup_pSeriesLP(st
 	 * already allocated.
 	 */
 	dn = pci_device_to_OF_node(dev);
+	DBG("  node is %s\n", dn->full_name);
 
 	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
 	     pdn = pdn->parent) {
@@ -539,16 +560,17 @@ static void iommu_dev_setup_pSeriesLP(st
 			break;
 	}
 
+	DBG("  parent is %s\n", pdn->full_name);
+
 	/* Check for parent == NULL so we don't try to setup the empty EADS
 	 * slots on POWER4 machines.
 	 */
 	if (dma_window == NULL || pdn->parent == NULL) {
-		DBG("No dma window for device, linking to parent\n");
-		PCI_DN(dn)->iommu_table = PCI_DN(pdn)->iommu_table;
+		DBG("  no dma window for device, linking to parent\n");
+		dext->dma_data = PCI_DN(pdn)->iommu_table;
 		return;
-	} else {
-		DBG("Found DMA window, allocating table\n");
 	}
+	DBG("  found DMA window, table: %p\n", pci->iommu_table);
 
 	pci = PCI_DN(pdn);
 	if (!pci->iommu_table) {
@@ -561,24 +583,20 @@ static void iommu_dev_setup_pSeriesLP(st
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
 
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
+		DBG("  created table: %p\n", pci->iommu_table);
 	}
 
-	if (pdn != dn)
-		PCI_DN(dn)->iommu_table = pci->iommu_table;
+	dext->dma_data = pci->iommu_table;
 }
 
-static void iommu_bus_setup_null(struct pci_bus *b) { }
-static void iommu_dev_setup_null(struct pci_dev *d) { }
-
 /* These are called very early. */
 void iommu_init_early_pSeries(void)
 {
 	if (of_chosen && get_property(of_chosen, "linux,iommu-off", NULL)) {
 		/* Direct I/O, IOMMU off */
-		ppc_md.iommu_dev_setup = iommu_dev_setup_null;
-		ppc_md.iommu_bus_setup = iommu_bus_setup_null;
-		pci_direct_iommu_init();
-
+		ppc_md.pci_dma_dev_setup = NULL;
+		ppc_md.pci_dma_bus_setup = NULL;
+		pci_dma_ops = &dma_direct_ops;
 		return;
 	}
 
@@ -591,19 +609,19 @@ void iommu_init_early_pSeries(void)
 			ppc_md.tce_free	 = tce_free_pSeriesLP;
 		}
 		ppc_md.tce_get   = tce_get_pSeriesLP;
-		ppc_md.iommu_bus_setup = iommu_bus_setup_pSeriesLP;
-		ppc_md.iommu_dev_setup = iommu_dev_setup_pSeriesLP;
+		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_pSeriesLP;
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
 	} else {
 		ppc_md.tce_build = tce_build_pSeries;
 		ppc_md.tce_free  = tce_free_pSeries;
 		ppc_md.tce_get   = tce_get_pseries;
-		ppc_md.iommu_bus_setup = iommu_bus_setup_pSeries;
-		ppc_md.iommu_dev_setup = iommu_dev_setup_pSeries;
+		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_pSeries;
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_pSeries;
 	}
 
 
 	pSeries_reconfig_notifier_register(&iommu_reconfig_nb);
 
-	pci_iommu_init();
+	pci_dma_ops = &dma_iommu_ops;
 }
 
Index: linux-cell/arch/powerpc/platforms/pseries/pci_dlpar.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/pseries/pci_dlpar.c	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/pseries/pci_dlpar.c	2006-10-18 17:34:55.000000000 +1000
@@ -93,8 +93,8 @@ pcibios_fixup_new_pci_devices(struct pci
 		if (list_empty(&dev->global_list)) {
 			int i;
 
-			/* Need to setup IOMMU tables */
-			ppc_md.iommu_dev_setup(dev);
+			/* Create device extension and setup iommu table */
+			pcibios_setup_new_device(dev);
 
 			if(fix_bus)
 				pcibios_fixup_device_resources(dev, bus);
Index: linux-cell/arch/powerpc/sysdev/dart_iommu.c
===================================================================
--- linux-cell.orig/arch/powerpc/sysdev/dart_iommu.c	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/arch/powerpc/sysdev/dart_iommu.c	2006-10-18 17:34:55.000000000 +1000
@@ -45,6 +45,7 @@
 #include <asm/cacheflush.h>
 #include <asm/lmb.h>
 #include <asm/ppc-pci.h>
+#include <asm/device_ext.h>
 
 #include "dart.h"
 
@@ -295,24 +296,23 @@ static void iommu_table_dart_setup(void)
 	set_bit(iommu_table_dart.it_size - 1, iommu_table_dart.it_map);
 }
 
-static void iommu_dev_setup_dart(struct pci_dev *dev)
+static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 {
-	struct device_node *dn;
+	struct device_ext *dext = device_get_ext(&dev->dev);
+
+	if (dext == NULL) {
+		printk(KERN_ERR "dart: Attempt to setup PCI dev %s "
+		       "with no device extension !", pci_name(dev));
+		return;
+	}
 
 	/* We only have one iommu table on the mac for now, which makes
 	 * things simple. Setup all PCI devices to point to this table
-	 *
-	 * We must use pci_device_to_OF_node() to make sure that
-	 * we get the real "final" pointer to the device in the
-	 * pci_dev sysdata and not the temporary PHB one
 	 */
-	dn = pci_device_to_OF_node(dev);
-
-	if (dn)
-		PCI_DN(dn)->iommu_table = &iommu_table_dart;
+	dext->dma_data = &iommu_table_dart;
 }
 
-static void iommu_bus_setup_dart(struct pci_bus *bus)
+static void pci_dma_bus_setup_dart(struct pci_bus *bus)
 {
 	struct device_node *dn;
 
@@ -327,9 +327,6 @@ static void iommu_bus_setup_dart(struct 
 		PCI_DN(dn)->iommu_table = &iommu_table_dart;
 }
 
-static void iommu_dev_setup_null(struct pci_dev *dev) { }
-static void iommu_bus_setup_null(struct pci_bus *bus) { }
-
 void iommu_init_early_dart(void)
 {
 	struct device_node *dn;
@@ -350,22 +347,21 @@ void iommu_init_early_dart(void)
 
 	/* Initialize the DART HW */
 	if (dart_init(dn) == 0) {
-		ppc_md.iommu_dev_setup = iommu_dev_setup_dart;
-		ppc_md.iommu_bus_setup = iommu_bus_setup_dart;
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_dart;
+		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_dart;
 
 		/* Setup pci_dma ops */
-		pci_iommu_init();
-
+		pci_dma_ops = &dma_iommu_ops;
 		return;
 	}
 
  bail:
 	/* If init failed, use direct iommu and null setup functions */
-	ppc_md.iommu_dev_setup = iommu_dev_setup_null;
-	ppc_md.iommu_bus_setup = iommu_bus_setup_null;
+	ppc_md.pci_dma_dev_setup = NULL;
+	ppc_md.pci_dma_bus_setup = NULL;
 
 	/* Setup pci_dma ops */
-	pci_direct_iommu_init();
+	pci_dma_ops = &dma_direct_ops;
 }
 
 
Index: linux-cell/include/asm-powerpc/machdep.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/machdep.h	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/include/asm-powerpc/machdep.h	2006-10-18 17:34:55.000000000 +1000
@@ -84,8 +84,8 @@ struct machdep_calls {
 	unsigned long	(*tce_get)(struct iommu_table *tbl,
 				    long index);
 	void		(*tce_flush)(struct iommu_table *tbl);
-	void		(*iommu_dev_setup)(struct pci_dev *dev);
-	void		(*iommu_bus_setup)(struct pci_bus *bus);
+	void		(*pci_dma_dev_setup)(struct pci_dev *dev);
+	void		(*pci_dma_bus_setup)(struct pci_bus *bus);
 	void		(*irq_bus_setup)(struct pci_bus *bus);
 #endif /* CONFIG_PPC64 */
 
Index: linux-cell/include/asm-powerpc/pci-bridge.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pci-bridge.h	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/include/asm-powerpc/pci-bridge.h	2006-10-18 17:34:55.000000000 +1000
@@ -161,6 +161,9 @@ static inline unsigned long pci_address_
 }
 #endif
 
+extern int pci_platform_notify(struct device * dev);
+extern int pci_platform_notify_remove(struct device * dev);
+
 /* Return values for ppc_md.pci_probe_mode function */
 #define PCI_PROBE_NONE		-1	/* Don't look at this bus at all */
 #define PCI_PROBE_NORMAL	0	/* Do normal PCI probing */
Index: linux-cell/include/asm-powerpc/pci.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/pci.h	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/include/asm-powerpc/pci.h	2006-10-18 17:34:55.000000000 +1000
@@ -76,15 +76,15 @@ static inline int pcibios_prep_mwi(struc
 	return 0;
 }
 
-extern struct dma_mapping_ops pci_dma_ops;
+extern struct dma_mapping_ops *pci_dma_ops;
 
 /* For DAC DMA, we currently don't support it by default, but
  * we let 64-bit platforms override this.
  */
 static inline int pci_dac_dma_supported(struct pci_dev *hwdev,u64 mask)
 {
-	if (pci_dma_ops.dac_dma_supported)
-		return pci_dma_ops.dac_dma_supported(&hwdev->dev, mask);
+	if (pci_dma_ops && pci_dma_ops->dac_dma_supported)
+		return pci_dma_ops->dac_dma_supported(&hwdev->dev, mask);
 	return 0;
 }
 
@@ -216,6 +216,8 @@ extern int remap_bus_range(struct pci_bu
 extern void pcibios_fixup_device_resources(struct pci_dev *dev,
 			struct pci_bus *bus);
 
+extern void pcibios_setup_new_device(struct pci_dev *dev);
+
 extern void pcibios_claim_one_bus(struct pci_bus *b);
 
 extern struct pci_controller *init_phb_dynamic(struct device_node *dn);
Index: linux-cell/arch/powerpc/kernel/Makefile
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/Makefile	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/Makefile	2006-10-18 17:34:55.000000000 +1000
@@ -64,8 +64,7 @@ obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_s
 module-$(CONFIG_PPC64)		+= module_64.o
 obj-$(CONFIG_MODULES)		+= $(module-y)
 
-pci64-$(CONFIG_PPC64)		+= pci_64.o pci_dn.o pci_iommu.o \
-				   pci_direct_iommu.o iomap.o
+pci64-$(CONFIG_PPC64)		+= pci_64.o pci_dn.o iomap.o
 pci32-$(CONFIG_PPC32)		:= pci_32.o
 obj-$(CONFIG_PCI)		+= $(pci64-y) $(pci32-y)
 kexec-$(CONFIG_PPC64)		:= machine_kexec_64.o
Index: linux-cell/drivers/net/ibmveth.c
===================================================================
--- linux-cell.orig/drivers/net/ibmveth.c	2006-10-18 17:33:45.000000000 +1000
+++ linux-cell/drivers/net/ibmveth.c	2006-10-18 17:34:55.000000000 +1000
@@ -945,7 +945,7 @@ static int __devinit ibmveth_probe(struc
 	int rc, i;
 	struct net_device *netdev;
 	struct ibmveth_adapter *adapter = NULL;
-
+	struct device_ext *dext;
 	unsigned char *mac_addr_p;
 	unsigned int *mcastFilterSize_p;
 
@@ -998,7 +998,12 @@ static int __devinit ibmveth_probe(struc
 	adapter->mac_addr = 0;
 	memcpy(&adapter->mac_addr, mac_addr_p, 6);
 
-	adapter->liobn = dev->iommu_table->it_index;
+	dext = device_get_ext(&dev->dev);
+	if (dext && dext->dma_data) {
+		struct iommu_table *tbl = dext->dma_data;
+		adapter->liobn = tbl->it_index;
+	} else
+		adapter->liobn = 0;
 
 	netdev->irq = dev->irq;
 	netdev->open               = ibmveth_open;
