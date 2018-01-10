Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGhWm3dVSzDqnt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:10:12 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek <monstr@monstr.eu>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/22] swiotlb: refactor coherent buffer freeing
Date: Wed, 10 Jan 2018 09:09:19 +0100
Message-Id: <20180110080932.14157-10-hch@lst.de>
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

Factor out a new swiotlb_free_buffer helper that checks if an address
is allocated from the swiotlb bounce buffer, and if yes frees it.

This allows to simplify the swiotlb_free implemenation that uses
dma_direct_free to free the non-bounce buffer allocations.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 lib/swiotlb.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/lib/swiotlb.c b/lib/swiotlb.c
index 539fd1099ba9..1a147f1354a1 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -780,22 +780,31 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 }
 EXPORT_SYMBOL(swiotlb_alloc_coherent);
 
+static bool swiotlb_free_buffer(struct device *dev, size_t size,
+		dma_addr_t dma_addr)
+{
+	phys_addr_t phys_addr = dma_to_phys(dev, dma_addr);
+
+	WARN_ON_ONCE(irqs_disabled());
+
+	if (!is_swiotlb_buffer(phys_addr))
+		return false;
+
+	/*
+	 * DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single.
+	 * DMA_ATTR_SKIP_CPU_SYNC is optional.
+	 */
+	swiotlb_tbl_unmap_single(dev, phys_addr, size, DMA_TO_DEVICE,
+				 DMA_ATTR_SKIP_CPU_SYNC);
+	return true;
+}
+
 void
 swiotlb_free_coherent(struct device *hwdev, size_t size, void *vaddr,
 		      dma_addr_t dev_addr)
 {
-	phys_addr_t paddr = dma_to_phys(hwdev, dev_addr);
-
-	WARN_ON(irqs_disabled());
-	if (!is_swiotlb_buffer(paddr))
+	if (!swiotlb_free_buffer(hwdev, size, dev_addr))
 		free_pages((unsigned long)vaddr, get_order(size));
-	else
-		/*
-		 * DMA_TO_DEVICE to avoid memcpy in swiotlb_tbl_unmap_single.
-		 * DMA_ATTR_SKIP_CPU_SYNC is optional.
-		 */
-		swiotlb_tbl_unmap_single(hwdev, paddr, size, DMA_TO_DEVICE,
-					 DMA_ATTR_SKIP_CPU_SYNC);
 }
 EXPORT_SYMBOL(swiotlb_free_coherent);
 
@@ -1110,9 +1119,7 @@ void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
 void swiotlb_free(struct device *dev, size_t size, void *vaddr,
 		dma_addr_t dma_addr, unsigned long attrs)
 {
-	if (is_swiotlb_buffer(dma_to_phys(dev, dma_addr)))
-		swiotlb_free_coherent(dev, size, vaddr, dma_addr);
-	else
+	if (!swiotlb_free_buffer(dev, size, dma_addr))
 		dma_direct_free(dev, size, vaddr, dma_addr, attrs);
 }
 
-- 
2.14.2
