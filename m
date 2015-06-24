Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 737831A0FB1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 15:25:37 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id t5O5PVBK022114
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 00:25:33 -0500
Message-ID: <1435123531.3996.31.camel@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/iommu: Support "hybrid" iommu/direct DMA ops
 for coherent_mask < dma_mask
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Wed, 24 Jun 2015 15:25:31 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds the ability to the DMA direct ops to fallback to the IOMMU
ops for coherent alloc/free if the coherent mask of the device isn't
suitable for accessing the direct DMA space and the device also happens
to have an active IOMMU table.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig                   |   4 ++
 arch/powerpc/include/asm/dma-mapping.h |  10 +--
 arch/powerpc/kernel/dma-iommu.c        |   2 +-
 arch/powerpc/kernel/dma-swiotlb.c      |   4 +-
 arch/powerpc/kernel/dma.c              | 111 +++++++++++++++++++++++++++------
 5 files changed, 105 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 190cc48..72302fa 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -82,6 +82,9 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
+config ARCH_HAS_DMA_SET_COHERENT_MASK
+        bool
+
 config PPC
 	bool
 	default y
@@ -153,6 +156,7 @@ config PPC
 	select NO_BOOTMEM
 	select HAVE_GENERIC_RCU_GUP
 	select HAVE_PERF_EVENTS_NMI if PPC64
+	select ARCH_HAS_DMA_SET_COHERENT_MASK
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 9cbbc9e..710f60e 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -21,12 +21,12 @@
 #define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
 
 /* Some dma direct funcs must be visible for use in other dma_ops */
-extern void *dma_direct_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t flag,
+extern void *__dma_direct_alloc_coherent(struct device *dev, size_t size,
+					 dma_addr_t *dma_handle, gfp_t flag,
+					 struct dma_attrs *attrs);
+extern void __dma_direct_free_coherent(struct device *dev, size_t size,
+				       void *vaddr, dma_addr_t dma_handle,
 				       struct dma_attrs *attrs);
-extern void dma_direct_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle,
-				     struct dma_attrs *attrs);
 extern int dma_direct_mmap_coherent(struct device *dev,
 				    struct vm_area_struct *vma,
 				    void *cpu_addr, dma_addr_t handle,
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 4c68bfe..41a7d9d 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -73,7 +73,7 @@ static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
 }
 
 /* We support DMA to/from any memory page via the iommu */
-static int dma_iommu_dma_supported(struct device *dev, u64 mask)
+int dma_iommu_dma_supported(struct device *dev, u64 mask)
 {
 	struct iommu_table *tbl = get_iommu_table_base(dev);
 
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 6e8d764..c6689f6 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -47,8 +47,8 @@ static u64 swiotlb_powerpc_get_required(struct device *dev)
  * for everything else.
  */
 struct dma_map_ops swiotlb_dma_ops = {
-	.alloc = dma_direct_alloc_coherent,
-	.free = dma_direct_free_coherent,
+	.alloc = __dma_direct_alloc_coherent,
+	.free = __dma_direct_free_coherent,
 	.mmap = dma_direct_mmap_coherent,
 	.map_sg = swiotlb_map_sg_attrs,
 	.unmap_sg = swiotlb_unmap_sg_attrs,
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 35e4dcc..1558f81 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -16,6 +16,7 @@
 #include <asm/bug.h>
 #include <asm/machdep.h>
 #include <asm/swiotlb.h>
+#include <asm/iommu.h>
 
 /*
  * Generic direct DMA implementation
@@ -39,9 +40,31 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
 	return pfn;
 }
 
-void *dma_direct_alloc_coherent(struct device *dev, size_t size,
-				dma_addr_t *dma_handle, gfp_t flag,
-				struct dma_attrs *attrs)
+static int dma_direct_dma_supported(struct device *dev, u64 mask)
+{
+#ifdef CONFIG_PPC64
+	u64 limit = get_dma_offset(dev) + (memblock_end_of_DRAM() - 1);
+
+	/* Limit fits in the mask, we are good */
+	if (mask >= limit)
+		return 1;
+
+#ifdef CONFIG_FSL_SOC
+	/* Freescale gets another chance via ZONE_DMA/ZONE_DMA32, however
+	 * that will have to be refined if/when they support iommus
+	 */
+	return 1;
+#endif
+	/* Sorry ... */
+	return 0;
+#else
+	return 1;
+#endif
+}
+
+void *__dma_direct_alloc_coherent(struct device *dev, size_t size,
+				  dma_addr_t *dma_handle, gfp_t flag,
+				  struct dma_attrs *attrs)
 {
 	void *ret;
 #ifdef CONFIG_NOT_COHERENT_CACHE
@@ -96,9 +119,9 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 #endif
 }
 
-void dma_direct_free_coherent(struct device *dev, size_t size,
-			      void *vaddr, dma_addr_t dma_handle,
-			      struct dma_attrs *attrs)
+void __dma_direct_free_coherent(struct device *dev, size_t size,
+				void *vaddr, dma_addr_t dma_handle,
+				struct dma_attrs *attrs)
 {
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	__dma_free_coherent(size, vaddr);
@@ -107,6 +130,51 @@ void dma_direct_free_coherent(struct device *dev, size_t size,
 #endif
 }
 
+static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
+				       dma_addr_t *dma_handle, gfp_t flag,
+				       struct dma_attrs *attrs)
+{
+	struct iommu_table *iommu;
+
+	/* The coherent mask may be smaller than the real mask, check if
+	 * we can really use the direct ops
+	 */
+	if (dma_direct_dma_supported(dev, dev->coherent_dma_mask))
+		return __dma_direct_alloc_coherent(dev, size, dma_handle,
+						   flag, attrs);
+
+	/* Ok we can't ... do we have an iommu ? If not, fail */
+	iommu = get_iommu_table_base(dev);
+	if (!iommu)
+		return NULL;
+
+	/* Try to use the iommu */
+	return iommu_alloc_coherent(dev, iommu, size, dma_handle,
+				    dev->coherent_dma_mask, flag,
+				    dev_to_node(dev));
+}
+
+static void dma_direct_free_coherent(struct device *dev, size_t size,
+				     void *vaddr, dma_addr_t dma_handle,
+				     struct dma_attrs *attrs)
+{
+	struct iommu_table *iommu;
+
+	/* See comments in dma_direct_alloc_coherent() */
+	if (dma_direct_dma_supported(dev, dev->coherent_dma_mask))
+		return __dma_direct_free_coherent(dev, size, vaddr, dma_handle,
+						  attrs);
+	/* Maybe we used an iommu ... */
+	iommu = get_iommu_table_base(dev);
+
+	/* If we hit that we should have never allocated in the first
+	 * place so how come we are freeing ?
+	 */
+	if (WARN_ON(!iommu))
+		return;
+	iommu_free_coherent(iommu, size, vaddr, dma_handle);
+}
+
 int dma_direct_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 			     void *cpu_addr, dma_addr_t handle, size_t size,
 			     struct dma_attrs *attrs)
@@ -147,18 +215,6 @@ static void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sg,
 {
 }
 
-static int dma_direct_dma_supported(struct device *dev, u64 mask)
-{
-#ifdef CONFIG_PPC64
-	/* Could be improved so platforms can set the limit in case
-	 * they have limited DMA windows
-	 */
-	return mask >= get_dma_offset(dev) + (memblock_end_of_DRAM() - 1);
-#else
-	return 1;
-#endif
-}
-
 static u64 dma_direct_get_required_mask(struct device *dev)
 {
 	u64 end, mask;
@@ -230,6 +286,25 @@ struct dma_map_ops dma_direct_ops = {
 };
 EXPORT_SYMBOL(dma_direct_ops);
 
+int dma_set_coherent_mask(struct device *dev, u64 mask)
+{
+	if (!dma_supported(dev, mask)) {
+		/*
+		 * We need to special case the direct DMA ops which can
+		 * support a fallback for coherent allocations. There
+		 * is no dma_op->set_coherent_mask() so we have to do
+		 * things the hard way:
+		 */
+		if (get_dma_ops(dev) != &dma_direct_ops ||
+		    get_iommu_table_base(dev) == NULL ||
+		    !dma_iommu_dma_supported(dev, mask))
+			return -EIO;
+	}
+	dev->coherent_dma_mask = mask;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dma_set_coherent_mask);
+
 #define PREALLOC_DMA_DEBUG_ENTRIES (1 << 16)
 
 int __dma_set_mask(struct device *dev, u64 dma_mask)
