Return-Path: <BATV+17e4623c997d928794c6+5506+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GRbH4V79zF3Nw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 05:28:11 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] dma-direct: add an explicit dma_direct_get_required_mask
Date: Thu, 20 Sep 2018 20:52:44 +0200
Message-Id: <20180920185247.20037-3-hch@lst.de>
In-Reply-To: <20180920185247.20037-1-hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is somewhat modelled after the powerpc version, and differs from
the legacy fallback in use fls64 instead of pointlessly splitting up the
address into low and high dwords and in that it takes (__)phys_to_dma
into account.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h |  1 +
 kernel/dma/direct.c        | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index 86a59ba5a7f3..b79496d8c75b 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -55,6 +55,7 @@ static inline void dma_mark_clean(void *addr, size_t size)
 }
 #endif /* CONFIG_ARCH_HAS_DMA_MARK_CLEAN */
 
+u64 dma_direct_get_required_mask(struct device *dev);
 void *dma_direct_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 		gfp_t gfp, unsigned long attrs);
 void dma_direct_free(struct device *dev, size_t size, void *cpu_addr,
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index c954f0a6dc62..81b73a5bba54 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -53,11 +53,25 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 	return true;
 }
 
+static inline dma_addr_t phys_to_dma_direct(struct device *dev,
+		phys_addr_t phys)
+{
+	if (force_dma_unencrypted())
+		return __phys_to_dma(dev, phys);
+	return phys_to_dma(dev, phys);
+}
+
+u64 dma_direct_get_required_mask(struct device *dev)
+{
+	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
+
+	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
+}
+
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
-	dma_addr_t addr = force_dma_unencrypted() ?
-		__phys_to_dma(dev, phys) : phys_to_dma(dev, phys);
-	return addr + size - 1 <= dev->coherent_dma_mask;
+	return phys_to_dma_direct(dev, phys) + size - 1 <=
+			dev->coherent_dma_mask;
 }
 
 void *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -296,6 +310,7 @@ const struct dma_map_ops dma_direct_ops = {
 	.unmap_page		= dma_direct_unmap_page,
 	.unmap_sg		= dma_direct_unmap_sg,
 #endif
+	.get_required_mask	= dma_direct_get_required_mask,
 	.dma_supported		= dma_direct_supported,
 	.mapping_error		= dma_direct_mapping_error,
 	.cache_sync		= arch_dma_cache_sync,
-- 
2.18.0
