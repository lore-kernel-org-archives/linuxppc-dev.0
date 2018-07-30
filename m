Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fQJP3jbgzF14j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:39:17 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Subject: [PATCH 14/20] powerpc/dma: replace dma_nommu_dma_supported with
 dma_direct_supported
Date: Mon, 30 Jul 2018 18:38:18 +0200
Message-Id: <20180730163824.10064-15-hch@lst.de>
In-Reply-To: <20180730163824.10064-1-hch@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ppc32 case of dma_nommu_dma_supported already was a no-op, and the
64-bit case came to the same conclusion as dma_direct_supported, so
replace it with the generic version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig      |  1 +
 arch/powerpc/kernel/dma.c | 28 +++-------------------------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f9cae7edd735..bbfa6a8df4da 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -158,6 +158,7 @@ config PPC
 	select CLONE_BACKWARDS
 	select DCACHE_WORD_ACCESS		if PPC64 && CPU_LITTLE_ENDIAN
 	select DYNAMIC_FTRACE			if FUNCTION_TRACER
+	select DMA_DIRECT_OPS
 	select EDAC_ATOMIC_SCRUB
 	select EDAC_SUPPORT
 	select GENERIC_ATOMIC64			if PPC32
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 3487de83bb37..511a4972560d 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -40,28 +40,6 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
 	return pfn;
 }
 
-static int dma_nommu_dma_supported(struct device *dev, u64 mask)
-{
-#ifdef CONFIG_PPC64
-	u64 limit = phys_to_dma(dev, (memblock_end_of_DRAM() - 1));
-
-	/* Limit fits in the mask, we are good */
-	if (mask >= limit)
-		return 1;
-
-#ifdef CONFIG_FSL_SOC
-	/* Freescale gets another chance via ZONE_DMA/ZONE_DMA32, however
-	 * that will have to be refined if/when they support iommus
-	 */
-	return 1;
-#endif
-	/* Sorry ... */
-	return 0;
-#else
-	return 1;
-#endif
-}
-
 #ifndef CONFIG_NOT_COHERENT_CACHE
 void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flag,
@@ -126,7 +104,7 @@ static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
 	/* The coherent mask may be smaller than the real mask, check if
 	 * we can really use the direct ops
 	 */
-	if (dma_nommu_dma_supported(dev, dev->coherent_dma_mask))
+	if (dma_direct_supported(dev, dev->coherent_dma_mask))
 		return __dma_nommu_alloc_coherent(dev, size, dma_handle,
 						   flag, attrs);
 
@@ -148,7 +126,7 @@ static void dma_nommu_free_coherent(struct device *dev, size_t size,
 	struct iommu_table *iommu;
 
 	/* See comments in dma_nommu_alloc_coherent() */
-	if (dma_nommu_dma_supported(dev, dev->coherent_dma_mask))
+	if (dma_direct_supported(dev, dev->coherent_dma_mask))
 		return __dma_nommu_free_coherent(dev, size, vaddr, dma_handle,
 						  attrs);
 	/* Maybe we used an iommu ... */
@@ -265,7 +243,7 @@ const struct dma_map_ops dma_nommu_ops = {
 	.mmap				= dma_nommu_mmap_coherent,
 	.map_sg				= dma_nommu_map_sg,
 	.unmap_sg			= dma_nommu_unmap_sg,
-	.dma_supported			= dma_nommu_dma_supported,
+	.dma_supported			= dma_direct_supported,
 	.map_page			= dma_nommu_map_page,
 	.unmap_page			= dma_nommu_unmap_page,
 	.get_required_mask		= dma_nommu_get_required_mask,
-- 
2.18.0
