Return-Path: <linas@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EC014679F0
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 10:25:44 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9O0PgeE014110
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 20:25:42 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9O0Pfxc418630
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 18:25:41 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9O0Pfdx011130
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Oct 2006 18:25:41 -0600
Date: Mon, 23 Oct 2006 19:25:40 -0500
To: linuxppc-dev@ozlabs.org
Subject: [RFC]: map 4K iommu pages even on 64K largepage systems.
Message-ID: <20061024002540.GA6360@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Subject: [RFC]: map 4K iommu pages even on 64K largepage systems.

The 10Gigabit ethernet device drivers appear to be able to chew
up all 256MB of TCE mappings on pSeries systems, as evidenced by
numerous error messages:

 iommu_alloc failed, tbl c0000000010d5c48 vaddr c0000000d875eff0 npages 1

Some experimentaiton indicates that this is essentially because
one 1500 byte ethernet MTU gets mapped as a 64K DMA region when
the large 64K pages are enabled. Thus, it doesn't take much to
exhaust all of the available DMA mappings for a high-speed card.

This patch changes the iommu allocator to work with its own 
unique, distinct page size. Although the patch is long, its
actually quite simple: it just #defines  distinct IOMMU_PAGE_SIZE
and then uses this in al the places tha matter.

The patch boots on pseries, untested in other places.

Haven't yet thought if this is a good long-term solution or not,
whether this kind of thing is desirable or not.  That's why its 
an RFC.  Comments?

--linas

Cc: Olof Johansson <olof@lixom.net>

----
 arch/powerpc/kernel/iommu.c            |   63 ++++++++++++++++++---------------
 arch/powerpc/kernel/vio.c              |    4 +-
 arch/powerpc/platforms/pseries/iommu.c |   13 +++---
 include/asm-powerpc/iommu.h            |   27 +++++++++++++-
 include/asm-powerpc/tce.h              |    4 +-
 5 files changed, 74 insertions(+), 37 deletions(-)

Index: linux-2.6.19-rc1-git11/arch/powerpc/kernel/iommu.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/arch/powerpc/kernel/iommu.c	2006-10-13 11:54:00.000000000 -0500
+++ linux-2.6.19-rc1-git11/arch/powerpc/kernel/iommu.c	2006-10-23 18:41:38.000000000 -0500
@@ -47,6 +47,15 @@ static int novmerge = 0;
 static int novmerge = 1;
 #endif
 
+static inline unsigned long
+iommu_num_pages(unsigned long vaddr, unsigned long slen)
+{
+	unsigned long npages;
+	npages = IOMMU_PAGE_ALIGN(vaddr + slen) - (vaddr & IOMMU_PAGE_MASK);
+	npages >>= IOMMU_PAGE_SHIFT;
+	return npages;
+}
+
 static int __init setup_iommu(char *str)
 {
 	if (!strcmp(str, "novmerge"))
@@ -178,10 +187,10 @@ static dma_addr_t iommu_alloc(struct iom
 	}
 
 	entry += tbl->it_offset;	/* Offset into real TCE table */
-	ret = entry << PAGE_SHIFT;	/* Set the return dma address */
+	ret = entry << IOMMU_PAGE_SHIFT;	/* Set the return dma address */
 
 	/* Put the TCEs in the HW table */
-	ppc_md.tce_build(tbl, entry, npages, (unsigned long)page & PAGE_MASK,
+	ppc_md.tce_build(tbl, entry, npages, (unsigned long)page & IOMMU_PAGE_MASK,
 			 direction);
 
 
@@ -203,7 +212,7 @@ static void __iommu_free(struct iommu_ta
 	unsigned long entry, free_entry;
 	unsigned long i;
 
-	entry = dma_addr >> PAGE_SHIFT;
+	entry = dma_addr >> IOMMU_PAGE_SHIFT;
 	free_entry = entry - tbl->it_offset;
 
 	if (((free_entry + npages) > tbl->it_size) ||
@@ -270,7 +279,7 @@ int iommu_map_sg(struct device *dev, str
 	/* Init first segment length for backout at failure */
 	outs->dma_length = 0;
 
-	DBG("mapping %d elements:\n", nelems);
+	DBG("sg mapping %d elements:\n", nelems);
 
 	spin_lock_irqsave(&(tbl->it_lock), flags);
 
@@ -285,9 +294,8 @@ int iommu_map_sg(struct device *dev, str
 		}
 		/* Allocate iommu entries for that segment */
 		vaddr = (unsigned long)page_address(s->page) + s->offset;
-		npages = PAGE_ALIGN(vaddr + slen) - (vaddr & PAGE_MASK);
-		npages >>= PAGE_SHIFT;
-		entry = iommu_range_alloc(tbl, npages, &handle, mask >> PAGE_SHIFT, 0);
+		npages = iommu_num_pages(vaddr, slen);
+		entry = iommu_range_alloc(tbl, npages, &handle, mask >> IOMMU_PAGE_SHIFT, 0);
 
 		DBG("  - vaddr: %lx, size: %lx\n", vaddr, slen);
 
@@ -301,14 +309,14 @@ int iommu_map_sg(struct device *dev, str
 
 		/* Convert entry to a dma_addr_t */
 		entry += tbl->it_offset;
-		dma_addr = entry << PAGE_SHIFT;
-		dma_addr |= s->offset;
+		dma_addr = entry << IOMMU_PAGE_SHIFT;
+		dma_addr |= (s->offset & ~IOMMU_PAGE_MASK);
 
-		DBG("  - %lx pages, entry: %lx, dma_addr: %lx\n",
+		DBG("  - %lu pages, entry: %lx, dma_addr: %lx\n",
 			    npages, entry, dma_addr);
 
 		/* Insert into HW table */
-		ppc_md.tce_build(tbl, entry, npages, vaddr & PAGE_MASK, direction);
+		ppc_md.tce_build(tbl, entry, npages, vaddr & IOMMU_PAGE_MASK, direction);
 
 		/* If we are in an open segment, try merging */
 		if (segstart != s) {
@@ -323,7 +331,7 @@ int iommu_map_sg(struct device *dev, str
 				DBG("    can't merge, new segment.\n");
 			} else {
 				outs->dma_length += s->length;
-				DBG("    merged, new len: %lx\n", outs->dma_length);
+				DBG("    merged, new len: %ux\n", outs->dma_length);
 			}
 		}
 
@@ -367,9 +375,8 @@ int iommu_map_sg(struct device *dev, str
 		if (s->dma_length != 0) {
 			unsigned long vaddr, npages;
 
-			vaddr = s->dma_address & PAGE_MASK;
-			npages = (PAGE_ALIGN(s->dma_address + s->dma_length) - vaddr)
-				>> PAGE_SHIFT;
+			vaddr = s->dma_address & IOMMU_PAGE_MASK;
+			npages = iommu_num_pages(s->dma_address, s->dma_length);
 			__iommu_free(tbl, vaddr, npages);
 			s->dma_address = DMA_ERROR_CODE;
 			s->dma_length = 0;
@@ -398,8 +405,7 @@ void iommu_unmap_sg(struct iommu_table *
 
 		if (sglist->dma_length == 0)
 			break;
-		npages = (PAGE_ALIGN(dma_handle + sglist->dma_length)
-			  - (dma_handle & PAGE_MASK)) >> PAGE_SHIFT;
+		npages = iommu_num_pages(dma_handle,sglist->dma_length);
 		__iommu_free(tbl, dma_handle, npages);
 		sglist++;
 	}
@@ -532,12 +538,11 @@ dma_addr_t iommu_map_single(struct iommu
 	BUG_ON(direction == DMA_NONE);
 
 	uaddr = (unsigned long)vaddr;
-	npages = PAGE_ALIGN(uaddr + size) - (uaddr & PAGE_MASK);
-	npages >>= PAGE_SHIFT;
+	npages = iommu_num_pages(uaddr, size);
 
 	if (tbl) {
 		dma_handle = iommu_alloc(tbl, vaddr, npages, direction,
-					 mask >> PAGE_SHIFT, 0);
+					 mask >> IOMMU_PAGE_SHIFT, 0);
 		if (dma_handle == DMA_ERROR_CODE) {
 			if (printk_ratelimit())  {
 				printk(KERN_INFO "iommu_alloc failed, "
@@ -545,7 +550,7 @@ dma_addr_t iommu_map_single(struct iommu
 						tbl, vaddr, npages);
 			}
 		} else
-			dma_handle |= (uaddr & ~PAGE_MASK);
+			dma_handle |= (uaddr & ~IOMMU_PAGE_MASK);
 	}
 
 	return dma_handle;
@@ -557,8 +562,8 @@ void iommu_unmap_single(struct iommu_tab
 	BUG_ON(direction == DMA_NONE);
 
 	if (tbl)
-		iommu_free(tbl, dma_handle, (PAGE_ALIGN(dma_handle + size) -
-					(dma_handle & PAGE_MASK)) >> PAGE_SHIFT);
+		iommu_free(tbl, dma_handle, (IOMMU_PAGE_ALIGN(dma_handle + size) -
+					(dma_handle & IOMMU_PAGE_MASK)) >> IOMMU_PAGE_SHIFT);
 }
 
 /* Allocates a contiguous real buffer and creates mappings over it.
@@ -571,6 +576,7 @@ void *iommu_alloc_coherent(struct iommu_
 	void *ret = NULL;
 	dma_addr_t mapping;
 	unsigned int npages, order;
+	unsigned int nio_pages, io_order;
 	struct page *page;
 
 	size = PAGE_ALIGN(size);
@@ -598,8 +604,10 @@ void *iommu_alloc_coherent(struct iommu_
 	memset(ret, 0, size);
 
 	/* Set up tces to cover the allocated range */
-	mapping = iommu_alloc(tbl, ret, npages, DMA_BIDIRECTIONAL,
-			      mask >> PAGE_SHIFT, order);
+	nio_pages = size >> IOMMU_PAGE_SHIFT;
+	io_order = get_iommu_order(size);
+	mapping = iommu_alloc(tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
+			      mask >> IOMMU_PAGE_SHIFT, io_order);
 	if (mapping == DMA_ERROR_CODE) {
 		free_pages((unsigned long)ret, order);
 		return NULL;
@@ -614,9 +622,10 @@ void iommu_free_coherent(struct iommu_ta
 	unsigned int npages;
 
 	if (tbl) {
-		size = PAGE_ALIGN(size);
-		npages = size >> PAGE_SHIFT;
+		size = IOMMU_PAGE_ALIGN(size);
+		npages = size >> IOMMU_PAGE_SHIFT;
 		iommu_free(tbl, dma_handle, npages);
+		size = PAGE_ALIGN(size);
 		free_pages((unsigned long)vaddr, get_order(size));
 	}
 }
Index: linux-2.6.19-rc1-git11/include/asm-powerpc/iommu.h
===================================================================
--- linux-2.6.19-rc1-git11.orig/include/asm-powerpc/iommu.h	2006-09-19 22:42:06.000000000 -0500
+++ linux-2.6.19-rc1-git11/include/asm-powerpc/iommu.h	2006-10-23 18:28:21.000000000 -0500
@@ -23,16 +23,41 @@
 #ifdef __KERNEL__
 
 #include <asm/types.h>
+#include <linux/compiler.h>
 #include <linux/spinlock.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 
+#define IOMMU_PAGE_SHIFT      12
+#define IOMMU_PAGE_SIZE       (ASM_CONST(1) << IOMMU_PAGE_SHIFT)
+#define IOMMU_PAGE_MASK       (~((1 << IOMMU_PAGE_SHIFT) - 1))
+#define IOMMU_PAGE_ALIGN(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE)
+
+#ifndef __ASSEMBLY__
+
+/* Pure 2^n version of get_order */
+static __inline__ __attribute_const__ int get_iommu_order(unsigned long size)
+{
+	int order;
+
+	size = (size - 1) >> (IOMMU_PAGE_SHIFT - 1);
+	order = -1;
+	do {
+		size >>= 1;
+		order++;
+	} while (size);
+	return order;
+}
+
+#endif   /* __ASSEMBLY__ */
+
+
 /*
  * IOMAP_MAX_ORDER defines the largest contiguous block
  * of dma space we can get.  IOMAP_MAX_ORDER = 13
  * allows up to 2**12 pages (4096 * 4096) = 16 MB
  */
-#define IOMAP_MAX_ORDER 13
+#define IOMAP_MAX_ORDER (25 - PAGE_SHIFT)
 
 struct iommu_table {
 	unsigned long  it_busno;     /* Bus number this table belongs to */
Index: linux-2.6.19-rc1-git11/include/asm-powerpc/tce.h
===================================================================
--- linux-2.6.19-rc1-git11.orig/include/asm-powerpc/tce.h	2006-09-19 22:42:06.000000000 -0500
+++ linux-2.6.19-rc1-git11/include/asm-powerpc/tce.h	2006-10-23 15:46:57.000000000 -0500
@@ -22,6 +22,8 @@
 #define _ASM_POWERPC_TCE_H
 #ifdef __KERNEL__
 
+#include <asm/iommu.h>
+
 /*
  * Tces come in two formats, one for the virtual bus and a different
  * format for PCI
@@ -33,7 +35,7 @@
 
 #define TCE_SHIFT	12
 #define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
-#define TCE_PAGE_FACTOR	(PAGE_SHIFT - TCE_SHIFT)
+#define TCE_PAGE_FACTOR	(IOMMU_PAGE_SHIFT - TCE_SHIFT)
 
 #define TCE_ENTRY_SIZE		8		/* each TCE is 64 bits */
 
Index: linux-2.6.19-rc1-git11/arch/powerpc/kernel/vio.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/arch/powerpc/kernel/vio.c	2006-10-13 11:52:51.000000000 -0500
+++ linux-2.6.19-rc1-git11/arch/powerpc/kernel/vio.c	2006-10-23 16:06:43.000000000 -0500
@@ -92,9 +92,9 @@ static struct iommu_table *vio_build_iom
 				&tbl->it_index, &offset, &size);
 
 		/* TCE table size - measured in tce entries */
-		tbl->it_size = size >> PAGE_SHIFT;
+		tbl->it_size = size >> IOMMU_PAGE_SHIFT;
 		/* offset for VIO should always be 0 */
-		tbl->it_offset = offset >> PAGE_SHIFT;
+		tbl->it_offset = offset >> IOMMU_PAGE_SHIFT;
 		tbl->it_busno = 0;
 		tbl->it_type = TCE_VB;
 
Index: linux-2.6.19-rc1-git11/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6.19-rc1-git11.orig/arch/powerpc/platforms/pseries/iommu.c	2006-10-13 11:54:00.000000000 -0500
+++ linux-2.6.19-rc1-git11/arch/powerpc/platforms/pseries/iommu.c	2006-10-23 18:42:03.000000000 -0500
@@ -289,7 +289,7 @@ static void iommu_table_setparms(struct 
 	tbl->it_busno = phb->bus->number;
 
 	/* Units of tce entries */
-	tbl->it_offset = phb->dma_window_base_cur >> PAGE_SHIFT;
+	tbl->it_offset = phb->dma_window_base_cur >> IOMMU_PAGE_SHIFT;
 
 	/* Test if we are going over 2GB of DMA space */
 	if (phb->dma_window_base_cur + phb->dma_window_size > 0x80000000ul) {
@@ -300,7 +300,7 @@ static void iommu_table_setparms(struct 
 	phb->dma_window_base_cur += phb->dma_window_size;
 
 	/* Set the tce table size - measured in entries */
-	tbl->it_size = phb->dma_window_size >> PAGE_SHIFT;
+	tbl->it_size = phb->dma_window_size >> IOMMU_PAGE_SHIFT;
 
 	tbl->it_index = 0;
 	tbl->it_blocksize = 16;
@@ -325,8 +325,8 @@ static void iommu_table_setparms_lpar(st
 	tbl->it_base   = 0;
 	tbl->it_blocksize  = 16;
 	tbl->it_type = TCE_PCI;
-	tbl->it_offset = offset >> PAGE_SHIFT;
-	tbl->it_size = size >> PAGE_SHIFT;
+	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT;
+	tbl->it_size = size >> IOMMU_PAGE_SHIFT;
 }
 
 static void iommu_bus_setup_pSeries(struct pci_bus *bus)
@@ -522,8 +522,6 @@ static void iommu_dev_setup_pSeriesLP(st
 	const void *dma_window = NULL;
 	struct pci_dn *pci;
 
-	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s)\n", dev, pci_name(dev));
-
 	/* dev setup for LPAR is a little tricky, since the device tree might
 	 * contain the dma-window properties per-device and not neccesarily
 	 * for the bus. So we need to search upwards in the tree until we
@@ -532,6 +530,9 @@ static void iommu_dev_setup_pSeriesLP(st
 	 */
 	dn = pci_device_to_OF_node(dev);
 
+	DBG("iommu_dev_setup_pSeriesLP, dev %p (%s) %s\n",
+	     dev, pci_name(dev), dn->full_name);
+
 	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
 	     pdn = pdn->parent) {
 		dma_window = get_property(pdn, "ibm,dma-window", NULL);
