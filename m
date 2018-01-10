Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGhXN0wP4zDqJt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:10:44 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek <monstr@monstr.eu>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 20/22] mips: use swiotlb_{alloc,free}
Date: Wed, 10 Jan 2018 09:09:30 +0100
Message-Id: <20180110080932.14157-21-hch@lst.de>
In-Reply-To: <20180110080932.14157-1-hch@lst.de>
References: <20180110080932.14157-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These already include the GFP_DMA/GFP_DMA32 usage, and will use CMA
memory if enabled, thus avoiding the GFP_NORETRY hack.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/cavium-octeon/Kconfig           |  1 +
 arch/mips/cavium-octeon/dma-octeon.c      | 26 +++-----------------------
 arch/mips/loongson64/Kconfig              |  1 +
 arch/mips/loongson64/common/dma-swiotlb.c | 21 ++-------------------
 4 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/arch/mips/cavium-octeon/Kconfig b/arch/mips/cavium-octeon/Kconfig
index 204a1670fd9b..b5eee1a57d6c 100644
--- a/arch/mips/cavium-octeon/Kconfig
+++ b/arch/mips/cavium-octeon/Kconfig
@@ -75,6 +75,7 @@ config NEED_SG_DMA_LENGTH
 
 config SWIOTLB
 	def_bool y
+	select DMA_DIRECT_OPS
 	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
 
diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index 5baf79fce643..c7bb8a407041 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -159,33 +159,13 @@ static void octeon_dma_sync_sg_for_device(struct device *dev,
 static void *octeon_dma_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	void *ret;
-
-	if (IS_ENABLED(CONFIG_ZONE_DMA) && dev == NULL)
-		gfp |= __GFP_DMA;
-	else if (IS_ENABLED(CONFIG_ZONE_DMA) &&
-		 dev->coherent_dma_mask <= DMA_BIT_MASK(24))
-		gfp |= __GFP_DMA;
-	else if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-		 dev->coherent_dma_mask <= DMA_BIT_MASK(32))
-		gfp |= __GFP_DMA32;
-
-	/* Don't invoke OOM killer */
-	gfp |= __GFP_NORETRY;
-
-	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
+	void *ret = swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
 
 	mb();
 
 	return ret;
 }
 
-static void octeon_dma_free_coherent(struct device *dev, size_t size,
-	void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
-}
-
 static dma_addr_t octeon_unity_phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	return paddr;
@@ -225,7 +205,7 @@ EXPORT_SYMBOL(dma_to_phys);
 static struct octeon_dma_map_ops octeon_linear_dma_map_ops = {
 	.dma_map_ops = {
 		.alloc = octeon_dma_alloc_coherent,
-		.free = octeon_dma_free_coherent,
+		.free = swiotlb_free,
 		.map_page = octeon_dma_map_page,
 		.unmap_page = swiotlb_unmap_page,
 		.map_sg = octeon_dma_map_sg,
@@ -311,7 +291,7 @@ void __init plat_swiotlb_setup(void)
 static struct octeon_dma_map_ops _octeon_pci_dma_map_ops = {
 	.dma_map_ops = {
 		.alloc = octeon_dma_alloc_coherent,
-		.free = octeon_dma_free_coherent,
+		.free = swiotlb_free,
 		.map_page = octeon_dma_map_page,
 		.unmap_page = swiotlb_unmap_page,
 		.map_sg = octeon_dma_map_sg,
diff --git a/arch/mips/loongson64/Kconfig b/arch/mips/loongson64/Kconfig
index 0d249fc3cfe9..6f109bb54cdb 100644
--- a/arch/mips/loongson64/Kconfig
+++ b/arch/mips/loongson64/Kconfig
@@ -136,6 +136,7 @@ config SWIOTLB
 	bool "Soft IOMMU Support for All-Memory DMA"
 	default y
 	depends on CPU_LOONGSON3
+	select DMA_DIRECT_OPS
 	select IOMMU_HELPER
 	select NEED_SG_DMA_LENGTH
 	select NEED_DMA_MAP_STATE
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 15388c24a504..7bbcf89475f3 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -13,29 +13,12 @@
 static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
 		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
 {
-	void *ret;
+	void *ret = swiotlb_alloc(dev, size, dma_handle, gfp, attrs);
 
-	if ((IS_ENABLED(CONFIG_ISA) && dev == NULL) ||
-	    (IS_ENABLED(CONFIG_ZONE_DMA) &&
-	     dev->coherent_dma_mask < DMA_BIT_MASK(32)))
-		gfp |= __GFP_DMA;
-	else if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
-		 dev->coherent_dma_mask < DMA_BIT_MASK(40))
-		gfp |= __GFP_DMA32;
-
-	gfp |= __GFP_NORETRY;
-
-	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
 	mb();
 	return ret;
 }
 
-static void loongson_dma_free_coherent(struct device *dev, size_t size,
-		void *vaddr, dma_addr_t dma_handle, unsigned long attrs)
-{
-	swiotlb_free_coherent(dev, size, vaddr, dma_handle);
-}
-
 static dma_addr_t loongson_dma_map_page(struct device *dev, struct page *page,
 				unsigned long offset, size_t size,
 				enum dma_data_direction dir,
@@ -106,7 +89,7 @@ phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 
 static const struct dma_map_ops loongson_dma_map_ops = {
 	.alloc = loongson_dma_alloc_coherent,
-	.free = loongson_dma_free_coherent,
+	.free = swiotlb_free,
 	.map_page = loongson_dma_map_page,
 	.unmap_page = swiotlb_unmap_page,
 	.map_sg = loongson_dma_map_sg,
-- 
2.14.2
