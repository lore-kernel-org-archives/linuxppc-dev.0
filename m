Return-Path: <joro@8bytes.org>
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A63931A025B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 23:32:28 +1100 (AEDT)
Date: Thu, 6 Nov 2014 13:32:23 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] powerpc/iommu: Rename iommu_[un]map_sg functions
Message-ID: <20141106123223.GL10744@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

here is a patch that fixes a compile failure on powerpc with the recent
iommu tree. If this patch is okay with you guys I'd like to carry it in
the iommu tree too.

Thanks,

	Joerg

>From ff39a0301d01ad24f7097718b4ec8215eb0c1141 Mon Sep 17 00:00:00 2001
From: Joerg Roedel <jroedel@suse.de>
Date: Wed, 5 Nov 2014 15:28:30 +0100
Subject: [PATCH] powerpc/iommu: Rename iommu_[un]map_sg functions

The IOMMU-API gained support for a new iommu_map_sg
function. This causes compile failures on powerpc because
the function name is already globally used there.
This patch renames adds a ppc_ prefix to these functions to
solve the compile problem.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/powerpc/include/asm/iommu.h    | 17 ++++++++++-------
 arch/powerpc/kernel/dma-iommu.c     |  8 ++++----
 arch/powerpc/kernel/iommu.c         | 16 ++++++++--------
 arch/powerpc/platforms/cell/iommu.c |  9 +++++----
 4 files changed, 27 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index 42632c7..9cfa370 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -137,13 +137,16 @@ static inline void set_iommu_table_base_and_group(struct device *dev,
 	iommu_add_device(dev);
 }
 
-extern int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
-			struct scatterlist *sglist, int nelems,
-			unsigned long mask, enum dma_data_direction direction,
-			struct dma_attrs *attrs);
-extern void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
-			   int nelems, enum dma_data_direction direction,
-			   struct dma_attrs *attrs);
+extern int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
+			    struct scatterlist *sglist, int nelems,
+			    unsigned long mask,
+			    enum dma_data_direction direction,
+			    struct dma_attrs *attrs);
+extern void ppc_iommu_unmap_sg(struct iommu_table *tbl,
+			       struct scatterlist *sglist,
+			       int nelems,
+			       enum dma_data_direction direction,
+			       struct dma_attrs *attrs);
 
 extern void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 				  size_t size, dma_addr_t *dma_handle,
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 54d0116..4c68bfe 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -60,16 +60,16 @@ static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    int nelems, enum dma_data_direction direction,
 			    struct dma_attrs *attrs)
 {
-	return iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
-			    device_to_mask(dev), direction, attrs);
+	return ppc_iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
+				device_to_mask(dev), direction, attrs);
 }
 
 static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		int nelems, enum dma_data_direction direction,
 		struct dma_attrs *attrs)
 {
-	iommu_unmap_sg(get_iommu_table_base(dev), sglist, nelems, direction,
-		       attrs);
+	ppc_iommu_unmap_sg(get_iommu_table_base(dev), sglist, nelems,
+			   direction, attrs);
 }
 
 /* We support DMA to/from any memory page via the iommu */
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index a10642a..a83cf5e 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -428,10 +428,10 @@ static void iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 		ppc_md.tce_flush(tbl);
 }
 
-int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
-		 struct scatterlist *sglist, int nelems,
-		 unsigned long mask, enum dma_data_direction direction,
-		 struct dma_attrs *attrs)
+int ppc_iommu_map_sg(struct device *dev, struct iommu_table *tbl,
+		     struct scatterlist *sglist, int nelems,
+		     unsigned long mask, enum dma_data_direction direction,
+		     struct dma_attrs *attrs)
 {
 	dma_addr_t dma_next = 0, dma_addr;
 	struct scatterlist *s, *outs, *segstart;
@@ -539,7 +539,7 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 	DBG("mapped %d elements:\n", outcount);
 
-	/* For the sake of iommu_unmap_sg, we clear out the length in the
+	/* For the sake of ppc_iommu_unmap_sg, we clear out the length in the
 	 * next entry of the sglist if we didn't fill the list completely
 	 */
 	if (outcount < incount) {
@@ -572,9 +572,9 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 }
 
 
-void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
-		int nelems, enum dma_data_direction direction,
-		struct dma_attrs *attrs)
+void ppc_iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
+			int nelems, enum dma_data_direction direction,
+			struct dma_attrs *attrs)
 {
 	struct scatterlist *sg;
 
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 2b90ff8..c7c8720 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -621,8 +621,9 @@ static int dma_fixed_map_sg(struct device *dev, struct scatterlist *sg,
 	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
 		return dma_direct_ops.map_sg(dev, sg, nents, direction, attrs);
 	else
-		return iommu_map_sg(dev, cell_get_iommu_table(dev), sg, nents,
-				    device_to_mask(dev), direction, attrs);
+		return ppc_iommu_map_sg(dev, cell_get_iommu_table(dev), sg,
+					nents, device_to_mask(dev),
+					direction, attrs);
 }
 
 static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
@@ -632,8 +633,8 @@ static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
 	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
 		dma_direct_ops.unmap_sg(dev, sg, nents, direction, attrs);
 	else
-		iommu_unmap_sg(cell_get_iommu_table(dev), sg, nents, direction,
-			       attrs);
+		ppc_iommu_unmap_sg(cell_get_iommu_table(dev), sg, nents,
+				   direction, attrs);
 }
 
 static int dma_fixed_dma_supported(struct device *dev, u64 mask)
-- 
1.8.4.5
