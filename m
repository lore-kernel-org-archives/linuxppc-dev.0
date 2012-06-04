Return-Path: <anton@samba.org>
Date: Mon, 4 Jun 2012 15:43:02 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, olof@lixom.net,
 michael@ellerman.id.au
Subject: [PATCH 2/5] powerpc: iommu: Reduce spinlock coverage in iommu_alloc
 and iommu_free
Message-ID: <20120604154302.50647773@kryten>
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


We currently hold the IOMMU spinlock around tce_build and tce_flush.
This causes our spinlock hold times to be much higher than required
and can impact multiqueue adapters.

This patch moves tce_build and tce_flush outside of the lock in
iommu_alloc, and tce_flush outside of the lock in iommu_free.

Some performance numbers were obtained with a Chelsio T3 adapter on
two POWER7 boxes, running a 100 session TCP round robin test.

Performance improved 32% with this patch applied.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-build/arch/powerpc/kernel/iommu.c
===================================================================
--- linux-build.orig/arch/powerpc/kernel/iommu.c	2012-06-04 10:38:38.045211977 +1000
+++ linux-build/arch/powerpc/kernel/iommu.c	2012-06-04 10:38:41.461284266 +1000
@@ -170,13 +170,11 @@ static dma_addr_t iommu_alloc(struct dev
 	int build_fail;
 
 	spin_lock_irqsave(&(tbl->it_lock), flags);
-
 	entry = iommu_range_alloc(dev, tbl, npages, NULL, mask, align_order);
+	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 
-	if (unlikely(entry == DMA_ERROR_CODE)) {
-		spin_unlock_irqrestore(&(tbl->it_lock), flags);
+	if (unlikely(entry == DMA_ERROR_CODE))
 		return DMA_ERROR_CODE;
-	}
 
 	entry += tbl->it_offset;	/* Offset into real TCE table */
 	ret = entry << IOMMU_PAGE_SHIFT;	/* Set the return dma address */
@@ -192,9 +190,10 @@ static dma_addr_t iommu_alloc(struct dev
 	 * not altered.
 	 */
 	if (unlikely(build_fail)) {
+		spin_lock_irqsave(&(tbl->it_lock), flags);
 		__iommu_free(tbl, ret, npages);
-
 		spin_unlock_irqrestore(&(tbl->it_lock), flags);
+
 		return DMA_ERROR_CODE;
 	}
 
@@ -202,8 +201,6 @@ static dma_addr_t iommu_alloc(struct dev
 	if (ppc_md.tce_flush)
 		ppc_md.tce_flush(tbl);
 
-	spin_unlock_irqrestore(&(tbl->it_lock), flags);
-
 	/* Make sure updates are seen by hardware */
 	mb();
 
@@ -244,8 +241,8 @@ static void iommu_free(struct iommu_tabl
 	unsigned long flags;
 
 	spin_lock_irqsave(&(tbl->it_lock), flags);
-
 	__iommu_free(tbl, dma_addr, npages);
+	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 
 	/* Make sure TLB cache is flushed if the HW needs it. We do
 	 * not do an mb() here on purpose, it is not needed on any of
@@ -253,8 +250,6 @@ static void iommu_free(struct iommu_tabl
 	 */
 	if (ppc_md.tce_flush)
 		ppc_md.tce_flush(tbl);
-
-	spin_unlock_irqrestore(&(tbl->it_lock), flags);
 }
 
 int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
