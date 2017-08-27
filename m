Return-Path: <BATV+0d43c28c1e7909f7e68d+5117+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgKdQ0mYZzDqjS
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 02:11:06 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Michal Simek <monstr@monstr.eu>,
 David Howells <dhowells@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 x86@kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] unicore32: make dma_cache_sync a no-op
Date: Sun, 27 Aug 2017 18:10:29 +0200
Message-Id: <20170827161032.22772-10-hch@lst.de>
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

unicore32 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it
doesn't make any sense to do any work in dma_cache_sync given that it
must be a no-op when dma_alloc_attrs returns coherent memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/unicore32/include/asm/cacheflush.h  |  9 ---------
 arch/unicore32/include/asm/dma-mapping.h | 17 -----------------
 arch/unicore32/mm/proc-syms.c            |  3 ---
 3 files changed, 29 deletions(-)

diff --git a/arch/unicore32/include/asm/cacheflush.h b/arch/unicore32/include/asm/cacheflush.h
index c0301e6c8b81..a5e08e2d5d6d 100644
--- a/arch/unicore32/include/asm/cacheflush.h
+++ b/arch/unicore32/include/asm/cacheflush.h
@@ -102,15 +102,6 @@ extern void __cpuc_flush_dcache_area(void *, size_t);
 extern void __cpuc_flush_kern_dcache_area(void *addr, size_t size);
 
 /*
- * These are private to the dma-mapping API.  Do not use directly.
- * Their sole purpose is to ensure that data held in the cache
- * is visible to DMA, or data written by DMA to system memory is
- * visible to the CPU.
- */
-extern void __cpuc_dma_clean_range(unsigned long, unsigned long);
-extern void __cpuc_dma_flush_range(unsigned long, unsigned long);
-
-/*
  * Copy user data from/to a page which is mapped into a different
  * processes address space.  Really, we want to allow our "user
  * space" model to handle this.
diff --git a/arch/unicore32/include/asm/dma-mapping.h b/arch/unicore32/include/asm/dma-mapping.h
index 518ba5848dd6..e949855bb794 100644
--- a/arch/unicore32/include/asm/dma-mapping.h
+++ b/arch/unicore32/include/asm/dma-mapping.h
@@ -18,9 +18,6 @@
 #include <linux/scatterlist.h>
 #include <linux/swiotlb.h>
 
-#include <asm/memory.h>
-#include <asm/cacheflush.h>
-
 extern const struct dma_map_ops swiotlb_dma_map_ops;
 
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
@@ -51,20 +48,6 @@ static inline void dma_mark_clean(void *addr, size_t size) {}
 static inline void dma_cache_sync(struct device *dev, void *vaddr,
 		size_t size, enum dma_data_direction direction)
 {
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end   = start + size;
-
-	switch (direction) {
-	case DMA_NONE:
-		BUG();
-	case DMA_FROM_DEVICE:
-	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		__cpuc_dma_flush_range(start, end);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		__cpuc_dma_clean_range(start, end);
-		break;
-	}
 }
 
 #endif /* __KERNEL__ */
diff --git a/arch/unicore32/mm/proc-syms.c b/arch/unicore32/mm/proc-syms.c
index 21c00fc85c99..df215fd6d639 100644
--- a/arch/unicore32/mm/proc-syms.c
+++ b/arch/unicore32/mm/proc-syms.c
@@ -20,6 +20,3 @@ EXPORT_SYMBOL(cpu_dcache_clean_area);
 EXPORT_SYMBOL(cpu_set_pte);
 
 EXPORT_SYMBOL(__cpuc_coherent_kern_range);
-
-EXPORT_SYMBOL(__cpuc_dma_flush_range);
-EXPORT_SYMBOL(__cpuc_dma_clean_range);
-- 
2.11.0
