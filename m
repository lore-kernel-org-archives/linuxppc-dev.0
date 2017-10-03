Return-Path: <BATV+69bb01a06caa5cf26dd3+5154+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5wcP1806zDql4
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 21:43:30 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Michal Simek <monstr@monstr.eu>,
 David Howells <dhowells@redhat.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
 x86@kernel.org, linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/11] x86: make dma_cache_sync a no-op
Date: Tue,  3 Oct 2017 12:43:02 +0200
Message-Id: <20171003104311.10058-3-hch@lst.de>
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

x86 does not implement DMA_ATTR_NON_CONSISTENT allocations, so it doesn't
make any sense to do any work in dma_cache_sync given that it must be a
no-op when dma_alloc_attrs returns coherent memory.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/include/asm/dma-mapping.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/include/asm/dma-mapping.h b/arch/x86/include/asm/dma-mapping.h
index 1387dafdba2d..c6d3367be916 100644
--- a/arch/x86/include/asm/dma-mapping.h
+++ b/arch/x86/include/asm/dma-mapping.h
@@ -71,7 +71,6 @@ static inline void
 dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 	enum dma_data_direction dir)
 {
-	flush_write_buffers();
 }
 
 static inline unsigned long dma_alloc_coherent_mask(struct device *dev,
-- 
2.14.1
