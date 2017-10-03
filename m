Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5wck1rhqzDqlm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 21:43:50 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Michal Simek <monstr@monstr.eu>,
 David Howells <dhowells@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 x86@kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/11] xtensa: make dma_cache_sync a no-op
Date: Tue,  3 Oct 2017 12:43:09 +0200
Message-Id: <20171003104311.10058-10-hch@lst.de>
In-Reply-To: <20171003104311.10058-1-hch@lst.de>
References: <20171003104311.10058-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

xtensa does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
doesn't make any sense to do any work in dma_cache_sync given that it
must be a no-op when dma_alloc_attrs returns coherent memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/xtensa/include/asm/dma-mapping.h |  6 ++++--
 arch/xtensa/kernel/pci-dma.c          | 23 -----------------------
 2 files changed, 4 insertions(+), 25 deletions(-)

diff --git a/arch/xtensa/include/asm/dma-mapping.h b/arch/xtensa/include/asm/dma-mapping.h
index 269738dc9d1d..353e0314d6ba 100644
--- a/arch/xtensa/include/asm/dma-mapping.h
+++ b/arch/xtensa/include/asm/dma-mapping.h
@@ -23,8 +23,10 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &xtensa_dma_map_ops;
 }
 
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		    enum dma_data_direction direction);
+static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+		    enum dma_data_direction direction)
+{
+}
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
diff --git a/arch/xtensa/kernel/pci-dma.c b/arch/xtensa/kernel/pci-dma.c
index cec86a1c2acc..623720a11143 100644
--- a/arch/xtensa/kernel/pci-dma.c
+++ b/arch/xtensa/kernel/pci-dma.c
@@ -26,29 +26,6 @@
 #include <asm/cacheflush.h>
 #include <asm/io.h>
 
-void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
-		    enum dma_data_direction dir)
-{
-	switch (dir) {
-	case DMA_BIDIRECTIONAL:
-		__flush_invalidate_dcache_range((unsigned long)vaddr, size);
-		break;
-
-	case DMA_FROM_DEVICE:
-		__invalidate_dcache_range((unsigned long)vaddr, size);
-		break;
-
-	case DMA_TO_DEVICE:
-		__flush_dcache_range((unsigned long)vaddr, size);
-		break;
-
-	case DMA_NONE:
-		BUG();
-		break;
-	}
-}
-EXPORT_SYMBOL(dma_cache_sync);
-
 static void do_cache_op(dma_addr_t dma_handle, size_t size,
 			void (*fn)(unsigned long, unsigned long))
 {
-- 
2.14.1
