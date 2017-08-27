Return-Path: <BATV+0d43c28c1e7909f7e68d+5117+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgKdG0Mh5zDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 02:10:58 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Michal Simek <monstr@monstr.eu>,
 David Howells <dhowells@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 x86@kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] microblaze: make dma_cache_sync a no-op
Date: Sun, 27 Aug 2017 18:10:26 +0200
Message-Id: <20170827161032.22772-7-hch@lst.de>
In-Reply-To: <20170827161032.22772-1-hch@lst.de>
References: <20170827161032.22772-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

microblaze does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
doesn't make any sense to do any work in dma_cache_sync given that it
must be a no-op when dma_alloc_attrs returns coherent memory.

This also allows moving __dma_sync out of the microblaze asm/dma-mapping.h
and thus greatly reduce the amount of includes there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/microblaze/include/asm/dma-mapping.h | 34 -------------------------------
 arch/microblaze/kernel/dma.c              | 17 ++++++++++++++++
 2 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index e15cd2f76e23..ad448e4aedb6 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -16,22 +16,6 @@
 #define _ASM_MICROBLAZE_DMA_MAPPING_H
 
 /*
- * See Documentation/DMA-API-HOWTO.txt and
- * Documentation/DMA-API.txt for documentation.
- */
-
-#include <linux/types.h>
-#include <linux/cache.h>
-#include <linux/mm.h>
-#include <linux/scatterlist.h>
-#include <linux/dma-debug.h>
-#include <asm/io.h>
-#include <asm/cacheflush.h>
-
-#define __dma_alloc_coherent(dev, gfp, size, handle)	NULL
-#define __dma_free_coherent(size, addr)		((void)0)
-
-/*
  * Available generic sets of operations
  */
 extern const struct dma_map_ops dma_direct_ops;
@@ -41,27 +25,9 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_direct_ops;
 }
 
-static inline void __dma_sync(unsigned long paddr,
-			      size_t size, enum dma_data_direction direction)
-{
-	switch (direction) {
-	case DMA_TO_DEVICE:
-	case DMA_BIDIRECTIONAL:
-		flush_dcache_range(paddr, paddr + size);
-		break;
-	case DMA_FROM_DEVICE:
-		invalidate_dcache_range(paddr, paddr + size);
-		break;
-	default:
-		BUG();
-	}
-}
-
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-	__dma_sync(virt_to_phys(vaddr), size, (int)direction);
 }
 
 #endif	/* _ASM_MICROBLAZE_DMA_MAPPING_H */
diff --git a/arch/microblaze/kernel/dma.c b/arch/microblaze/kernel/dma.c
index e45ada8fb006..621902f8b0a0 100644
--- a/arch/microblaze/kernel/dma.c
+++ b/arch/microblaze/kernel/dma.c
@@ -12,6 +12,7 @@
 #include <linux/dma-debug.h>
 #include <linux/export.h>
 #include <linux/bug.h>
+#include <asm/cacheflush.h>
 
 #define NOT_COHERENT_CACHE
 
@@ -51,6 +52,22 @@ static void dma_direct_free_coherent(struct device *dev, size_t size,
 #endif
 }
 
+static inline void __dma_sync(unsigned long paddr,
+			      size_t size, enum dma_data_direction direction)
+{
+	switch (direction) {
+	case DMA_TO_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		flush_dcache_range(paddr, paddr + size);
+		break;
+	case DMA_FROM_DEVICE:
+		invalidate_dcache_range(paddr, paddr + size);
+		break;
+	default:
+		BUG();
+	}
+}
+
 static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 			     int nents, enum dma_data_direction direction,
 			     unsigned long attrs)
-- 
2.11.0
