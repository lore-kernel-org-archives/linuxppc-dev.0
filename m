Return-Path: <markn@au1.ibm.com>
Received: from ausmtp04.au.ibm.com (ausmtp04.au.ibm.com [202.81.18.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2BB0DDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 17:45:06 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp04.au.ibm.com (8.13.8/8.13.8) with ESMTP id m9S6qIhV092270
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 17:52:18 +1100
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9S6bV5P277630
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 17:37:32 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9S6bUT2005486
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Oct 2008 17:37:31 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc: Remove map_/unmap_single() from dma_mapping_ops
Date: Tue, 28 Oct 2008 17:38:14 +1100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200810281738.14104.markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that all of the remaining dma_mapping_ops have had their map_/unmap_single
functions updated to become map/unmap_page functions, there is no need to have
the map_/unmap_single function pointers in the dma_mapping_ops.

So, take this opportunity to remove them and also remove the code that does
the checking for which set of functions to use.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
This is just a cleanup so can wait for 2.6.29

 arch/powerpc/include/asm/dma-mapping.h |   36 ++++-----------------------------
 1 file changed, 5 insertions(+), 31 deletions(-)

Index: upstream/arch/powerpc/include/asm/dma-mapping.h
===================================================================
--- upstream.orig/arch/powerpc/include/asm/dma-mapping.h
+++ upstream/arch/powerpc/include/asm/dma-mapping.h
@@ -60,12 +60,6 @@ struct dma_mapping_ops {
 				dma_addr_t *dma_handle, gfp_t flag);
 	void		(*free_coherent)(struct device *dev, size_t size,
 				void *vaddr, dma_addr_t dma_handle);
-	dma_addr_t	(*map_single)(struct device *dev, void *ptr,
-				size_t size, enum dma_data_direction direction,
-				struct dma_attrs *attrs);
-	void		(*unmap_single)(struct device *dev, dma_addr_t dma_addr,
-				size_t size, enum dma_data_direction direction,
-				struct dma_attrs *attrs);
 	int		(*map_sg)(struct device *dev, struct scatterlist *sg,
 				int nents, enum dma_data_direction direction,
 				struct dma_attrs *attrs);
@@ -149,10 +143,9 @@ static inline int dma_set_mask(struct de
 }
 
 /*
- * TODO: map_/unmap_single will ideally go away, to be completely
- * replaced by map/unmap_page.   Until then, we allow dma_ops to have
- * one or the other, or both by checking to see if the specific
- * function requested exists; and if not, falling back on the other set.
+ * map_/unmap_single actually call through to map/unmap_page now that all the
+ * dma_mapping_ops have been converted over. We just have to get the page and
+ * offset to pass through to map_page
  */
 static inline dma_addr_t dma_map_single_attrs(struct device *dev,
 					      void *cpu_addr,
@@ -164,10 +157,6 @@ static inline dma_addr_t dma_map_single_
 
 	BUG_ON(!dma_ops);
 
-	if (dma_ops->map_single)
-		return dma_ops->map_single(dev, cpu_addr, size, direction,
-					   attrs);
-
 	return dma_ops->map_page(dev, virt_to_page(cpu_addr),
 				 (unsigned long)cpu_addr % PAGE_SIZE, size,
 				 direction, attrs);
@@ -183,11 +172,6 @@ static inline void dma_unmap_single_attr
 
 	BUG_ON(!dma_ops);
 
-	if (dma_ops->unmap_single) {
-		dma_ops->unmap_single(dev, dma_addr, size, direction, attrs);
-		return;
-	}
-
 	dma_ops->unmap_page(dev, dma_addr, size, direction, attrs);
 }
 
@@ -201,12 +185,7 @@ static inline dma_addr_t dma_map_page_at
 
 	BUG_ON(!dma_ops);
 
-	if (dma_ops->map_page)
-		return dma_ops->map_page(dev, page, offset, size, direction,
-					 attrs);
-
-	return dma_ops->map_single(dev, page_address(page) + offset, size,
-				   direction, attrs);
+	return dma_ops->map_page(dev, page, offset, size, direction, attrs);
 }
 
 static inline void dma_unmap_page_attrs(struct device *dev,
@@ -219,12 +198,7 @@ static inline void dma_unmap_page_attrs(
 
 	BUG_ON(!dma_ops);
 
-	if (dma_ops->unmap_page) {
-		dma_ops->unmap_page(dev, dma_address, size, direction, attrs);
-		return;
-	}
-
-	dma_ops->unmap_single(dev, dma_address, size, direction, attrs);
+	dma_ops->unmap_page(dev, dma_address, size, direction, attrs);
 }
 
 static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
