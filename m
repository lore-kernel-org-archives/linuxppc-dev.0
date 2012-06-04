Return-Path: <anton@samba.org>
Date: Mon, 4 Jun 2012 15:43:44 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, olof@lixom.net,
 michael@ellerman.id.au
Subject: [PATCH 3/5] powerpc: iommu: Reduce spinlock coverage in iommu_free
Message-ID: <20120604154344.4cadd299@kryten>
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


This patch moves tce_free outside of the lock in iommu_free.

Some performance numbers were obtained with a Chelsio T3 adapter on
two POWER7 boxes, running a 100 session TCP round robin test.

Performance improved 25% with this patch applied.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/iommu.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/iommu.c	2012-06-04 10:38:41.461284266 +1000
+++ linux-build/arch/powerpc/kernel/iommu.c	2012-06-04 10:38:43.813334034 +1000
@@ -190,10 +190,7 @@ static dma_addr_t iommu_alloc(struct dev
 	 * not altered.
 	 */
 	if (unlikely(build_fail)) {
-		spin_lock_irqsave(&(tbl->it_lock), flags);
 		__iommu_free(tbl, ret, npages);
-		spin_unlock_irqrestore(&(tbl->it_lock), flags);
-
 		return DMA_ERROR_CODE;
 	}
 
@@ -207,8 +204,8 @@ static dma_addr_t iommu_alloc(struct dev
 	return ret;
 }
 
-static void __iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr, 
-			 unsigned int npages)
+static bool iommu_free_check(struct iommu_table *tbl, dma_addr_t dma_addr,
+			     unsigned int npages)
 {
 	unsigned long entry, free_entry;
 
@@ -228,21 +225,53 @@ static void __iommu_free(struct iommu_ta
 			printk(KERN_INFO "\tindex     = 0x%llx\n", (u64)tbl->it_index);
 			WARN_ON(1);
 		}
-		return;
+
+		return false;
 	}
 
+	return true;
+}
+
+static void __iommu_free_locked(struct iommu_table *tbl, dma_addr_t dma_addr,
+			 unsigned int npages)
+{
+	unsigned long entry, free_entry;
+
+	BUG_ON(!spin_is_locked(&tbl->it_lock));
+
+	entry = dma_addr >> IOMMU_PAGE_SHIFT;
+	free_entry = entry - tbl->it_offset;
+
+	if (!iommu_free_check(tbl, dma_addr, npages))
+		return;
+
 	ppc_md.tce_free(tbl, entry, npages);
 	bitmap_clear(tbl->it_map, free_entry, npages);
 }
 
-static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
-		unsigned int npages)
+static void __iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
+			 unsigned int npages)
 {
+	unsigned long entry, free_entry;
 	unsigned long flags;
 
+	entry = dma_addr >> IOMMU_PAGE_SHIFT;
+	free_entry = entry - tbl->it_offset;
+
+	if (!iommu_free_check(tbl, dma_addr, npages))
+		return;
+
+	ppc_md.tce_free(tbl, entry, npages);
+
 	spin_lock_irqsave(&(tbl->it_lock), flags);
-	__iommu_free(tbl, dma_addr, npages);
+	bitmap_clear(tbl->it_map, free_entry, npages);
 	spin_unlock_irqrestore(&(tbl->it_lock), flags);
+}
+
+static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
+		unsigned int npages)
+{
+	__iommu_free(tbl, dma_addr, npages);
 
 	/* Make sure TLB cache is flushed if the HW needs it. We do
 	 * not do an mb() here on purpose, it is not needed on any of
@@ -390,7 +419,7 @@ int iommu_map_sg(struct device *dev, str
 			vaddr = s->dma_address & IOMMU_PAGE_MASK;
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
 						 IOMMU_PAGE_SIZE);
-			__iommu_free(tbl, vaddr, npages);
+			__iommu_free_locked(tbl, vaddr, npages);
 			s->dma_address = DMA_ERROR_CODE;
 			s->dma_length = 0;
 		}
@@ -425,7 +454,7 @@ void iommu_unmap_sg(struct iommu_table *
 			break;
 		npages = iommu_num_pages(dma_handle, sg->dma_length,
 					 IOMMU_PAGE_SIZE);
-		__iommu_free(tbl, dma_handle, npages);
+		__iommu_free_locked(tbl, dma_handle, npages);
 		sg = sg_next(sg);
 	}
 
