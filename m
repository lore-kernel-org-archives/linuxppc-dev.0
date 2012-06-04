Return-Path: <anton@samba.org>
Date: Mon, 4 Jun 2012 15:44:25 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, olof@lixom.net,
 michael@ellerman.id.au
Subject: [PATCH 4/5] powerpc: iommu: Push spinlock into iommu_range_alloc
 and __iommu_free
Message-ID: <20120604154425.147c3fc5@kryten>
In-Reply-To: <20120604154213.173feecb@kryten>
References: <20120604154213.173feecb@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


In preparation for IOMMU pools, push the spinlock into
iommu_range_alloc and __iommu_free.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/iommu.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/iommu.c	2012-06-04 10:38:43.813334034 +1000
+++ linux-build/arch/powerpc/kernel/iommu.c	2012-06-04 10:38:45.305365604 +1000
@@ -71,6 +71,7 @@ static unsigned long iommu_range_alloc(s
 	int pass = 0;
 	unsigned long align_mask;
 	unsigned long boundary_size;
+	unsigned long flags;
 
 	align_mask = 0xffffffffffffffffl >> (64 - align_order);
 
@@ -83,6 +84,8 @@ static unsigned long iommu_range_alloc(s
 		return DMA_ERROR_CODE;
 	}
 
+	spin_lock_irqsave(&(tbl->it_lock), flags);
+
 	if (handle && *handle)
 		start = *handle;
 	else
@@ -136,6 +139,7 @@ static unsigned long iommu_range_alloc(s
 			goto again;
 		} else {
 			/* Third failure, give up */
+			spin_unlock_irqrestore(&(tbl->it_lock), flags);
 			return DMA_ERROR_CODE;
 		}
 	}
@@ -156,6 +160,7 @@ static unsigned long iommu_range_alloc(s
 	if (handle)
 		*handle = end;
 
+	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 	return n;
 }
 
@@ -165,13 +170,11 @@ static dma_addr_t iommu_alloc(struct dev
 			      unsigned long mask, unsigned int align_order,
 			      struct dma_attrs *attrs)
 {
-	unsigned long entry, flags;
+	unsigned long entry;
 	dma_addr_t ret = DMA_ERROR_CODE;
 	int build_fail;
 
-	spin_lock_irqsave(&(tbl->it_lock), flags);
 	entry = iommu_range_alloc(dev, tbl, npages, NULL, mask, align_order);
-	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 
 	if (unlikely(entry == DMA_ERROR_CODE))
 		return DMA_ERROR_CODE;
@@ -232,23 +235,6 @@ static bool iommu_free_check(struct iomm
 	return true;
 }
 
-static void __iommu_free_locked(struct iommu_table *tbl, dma_addr_t dma_addr,
-			 unsigned int npages)
-{
-	unsigned long entry, free_entry;
-
-	BUG_ON(!spin_is_locked(&tbl->it_lock));
-
-	entry = dma_addr >> IOMMU_PAGE_SHIFT;
-	free_entry = entry - tbl->it_offset;
-
-	if (!iommu_free_check(tbl, dma_addr, npages))
-		return;
-
-	ppc_md.tce_free(tbl, entry, npages);
-	bitmap_clear(tbl->it_map, free_entry, npages);
-}
-
 static void __iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 			 unsigned int npages)
 {
@@ -287,7 +273,6 @@ int iommu_map_sg(struct device *dev, str
 		 struct dma_attrs *attrs)
 {
 	dma_addr_t dma_next = 0, dma_addr;
-	unsigned long flags;
 	struct scatterlist *s, *outs, *segstart;
 	int outcount, incount, i, build_fail = 0;
 	unsigned int align;
@@ -309,8 +294,6 @@ int iommu_map_sg(struct device *dev, str
 
 	DBG("sg mapping %d elements:\n", nelems);
 
-	spin_lock_irqsave(&(tbl->it_lock), flags);
-
 	max_seg_size = dma_get_max_seg_size(dev);
 	for_each_sg(sglist, s, nelems, i) {
 		unsigned long vaddr, npages, entry, slen;
@@ -393,8 +376,6 @@ int iommu_map_sg(struct device *dev, str
 	if (ppc_md.tce_flush)
 		ppc_md.tce_flush(tbl);
 
-	spin_unlock_irqrestore(&(tbl->it_lock), flags);
-
 	DBG("mapped %d elements:\n", outcount);
 
 	/* For the sake of iommu_unmap_sg, we clear out the length in the
@@ -419,14 +400,13 @@ int iommu_map_sg(struct device *dev, str
 			vaddr = s->dma_address & IOMMU_PAGE_MASK;
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
 						 IOMMU_PAGE_SIZE);
-			__iommu_free_locked(tbl, vaddr, npages);
+			__iommu_free(tbl, vaddr, npages);
 			s->dma_address = DMA_ERROR_CODE;
 			s->dma_length = 0;
 		}
 		if (s == outs)
 			break;
 	}
-	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 	return 0;
 }
 
@@ -436,15 +416,12 @@ void iommu_unmap_sg(struct iommu_table *
 		struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
-	unsigned long flags;
 
 	BUG_ON(direction == DMA_NONE);
 
 	if (!tbl)
 		return;
 
-	spin_lock_irqsave(&(tbl->it_lock), flags);
-
 	sg = sglist;
 	while (nelems--) {
 		unsigned int npages;
@@ -454,7 +431,7 @@ void iommu_unmap_sg(struct iommu_table *
 			break;
 		npages = iommu_num_pages(dma_handle, sg->dma_length,
 					 IOMMU_PAGE_SIZE);
-		__iommu_free_locked(tbl, dma_handle, npages);
+		__iommu_free(tbl, dma_handle, npages);
 		sg = sg_next(sg);
 	}
 
@@ -464,8 +441,6 @@ void iommu_unmap_sg(struct iommu_table *
 	 */
 	if (ppc_md.tce_flush)
 		ppc_md.tce_flush(tbl);
-
-	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 }
 
 static void iommu_table_clear(struct iommu_table *tbl)
