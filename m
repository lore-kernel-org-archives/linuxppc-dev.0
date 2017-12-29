Return-Path: <BATV+bc2f3f92dc59fc4fc549+5241+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z7KNF57SFzDq8c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Dec 2017 19:23:09 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linux-c6x-dev@linux-c6x.org,
 linux-cris-kernel@axis.com, linux-hexagon@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
 linux-mips@linux-mips.org, linux-parisc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 49/67] swiotlb: refactor coherent buffer freeing
Date: Fri, 29 Dec 2017 09:18:53 +0100
Message-Id: <20171229081911.2802-50-hch@lst.de>
In-Reply-To: <20171229081911.2802-1-hch@lst.de>
References: <20171229081911.2802-1-hch@lst.de>
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
index a14fff30ee9d..adb4dd0091fa 100644
--- a/lib/swiotlb.c
+++ b/lib/swiotlb.c
@@ -773,22 +773,31 @@ swiotlb_alloc_coherent(struct device *hwdev, size_t size,
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
 
@@ -1103,9 +1112,7 @@ void *swiotlb_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
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
