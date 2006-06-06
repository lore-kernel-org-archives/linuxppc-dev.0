Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 969BA67B2A
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jun 2006 00:11:39 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id k56EBZRT007377
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Jun 2006 16:11:35 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id k56EBZZh007375
	for linuxppc-dev@ozlabs.org; Tue, 6 Jun 2006 16:11:35 +0200
Date: Tue, 6 Jun 2006 16:11:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: node-away dma allocations
Message-ID: <20060606141135.GB6974@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make sure dma_alloc_coherent allocates memory from the local node.  This
is important on Cell where we avoid going through the slow cpu
interconnect.

Note:  I could only test this patch on Cell, it should be verified on
some pseries machine by thos that have the hardware.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/kernel/iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/iommu.c	2006-04-25 15:53:07.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/iommu.c	2006-05-30 14:54:25.000000000 +0200
@@ -536,11 +536,12 @@
  * to the dma address (mapping) of the first page.
  */
 void *iommu_alloc_coherent(struct iommu_table *tbl, size_t size,
-		dma_addr_t *dma_handle, unsigned long mask, gfp_t flag)
+		dma_addr_t *dma_handle, unsigned long mask, gfp_t flag, int node)
 {
 	void *ret = NULL;
 	dma_addr_t mapping;
 	unsigned int npages, order;
+	struct page *page;
 
 	size = PAGE_ALIGN(size);
 	npages = size >> PAGE_SHIFT;
@@ -560,9 +561,10 @@
 		return NULL;
 
 	/* Alloc enough pages (and possibly more) */
-	ret = (void *)__get_free_pages(flag, order);
-	if (!ret)
+	page = alloc_pages_node(flag, order, node);
+	if (!page)
 		return NULL;
+	ret = page_address(page);
 	memset(ret, 0, size);
 
 	/* Set up tces to cover the allocated range */
@@ -570,9 +572,9 @@
 			      mask >> PAGE_SHIFT, order);
 	if (mapping == DMA_ERROR_CODE) {
 		free_pages((unsigned long)ret, order);
-		ret = NULL;
-	} else
-		*dma_handle = mapping;
+		return NULL;
+	}
+	*dma_handle = mapping;
 	return ret;
 }
 
Index: linux-2.6/arch/powerpc/kernel/pci_iommu.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/pci_iommu.c	2006-04-25 15:53:07.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/pci_iommu.c	2006-05-30 14:55:18.000000000 +0200
@@ -86,7 +86,8 @@
 			   dma_addr_t *dma_handle, gfp_t flag)
 {
 	return iommu_alloc_coherent(devnode_table(hwdev), size, dma_handle,
-			device_to_mask(hwdev), flag);
+			device_to_mask(hwdev), flag,
+			pcibus_to_node(to_pci_dev(hwdev)->bus));
 }
 
 static void pci_iommu_free_coherent(struct device *hwdev, size_t size,
Index: linux-2.6/arch/powerpc/kernel/vio.c
===================================================================
--- linux-2.6.orig/arch/powerpc/kernel/vio.c	2006-04-25 15:53:07.000000000 +0200
+++ linux-2.6/arch/powerpc/kernel/vio.c	2006-05-30 14:54:38.000000000 +0200
@@ -229,7 +229,7 @@
 			   dma_addr_t *dma_handle, gfp_t flag)
 {
 	return iommu_alloc_coherent(to_vio_dev(dev)->iommu_table, size,
-			dma_handle, ~0ul, flag);
+			dma_handle, ~0ul, flag, -1);
 }
 
 static void vio_free_coherent(struct device *dev, size_t size,
Index: linux-2.6/include/asm-powerpc/iommu.h
===================================================================
--- linux-2.6.orig/include/asm-powerpc/iommu.h	2006-04-25 15:53:07.000000000 +0200
+++ linux-2.6/include/asm-powerpc/iommu.h	2006-05-30 14:55:45.000000000 +0200
@@ -76,7 +76,8 @@
 		int nelems, enum dma_data_direction direction);
 
 extern void *iommu_alloc_coherent(struct iommu_table *tbl, size_t size,
-		dma_addr_t *dma_handle, unsigned long mask, gfp_t flag);
+		dma_addr_t *dma_handle, unsigned long mask,
+		gfp_t flag, int node);
 extern void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 		void *vaddr, dma_addr_t dma_handle);
 extern dma_addr_t iommu_map_single(struct iommu_table *tbl, void *vaddr,
