Return-Path: <BATV+17e4623c997d928794c6+5506+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GQq70tl2zF3Nf
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 04:53:18 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 4/5] dma-direct: implement complete bus_dma_mask handling
Date: Thu, 20 Sep 2018 20:52:46 +0200
Message-Id: <20180920185247.20037-5-hch@lst.de>
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

Instead of rejecting devices with a too small bus_dma_mask we can handle
by taking the bus dma_mask into account for allocations and bounce
buffering decisions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-direct.h |  3 ++-
 kernel/dma/direct.c        | 21 +++++++++++----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/include/linux/dma-direct.h b/include/linux/dma-direct.h
index b79496d8c75b..fbca184ff5a0 100644
--- a/include/linux/dma-direct.h
+++ b/include/linux/dma-direct.h
@@ -27,7 +27,8 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 	if (!dev->dma_mask)
 		return false;
 
-	return addr + size - 1 <= *dev->dma_mask;
+	return addr + size - 1 <=
+		min_not_zero(*dev->dma_mask, dev->bus_dma_mask);
 }
 #endif /* !CONFIG_ARCH_HAS_PHYS_TO_DMA */
 
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 3c404e33d946..64466b7ef67b 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -43,10 +43,11 @@ check_addr(struct device *dev, dma_addr_t dma_addr, size_t size,
 			return false;
 		}
 
-		if (*dev->dma_mask >= DMA_BIT_MASK(32)) {
+		if (*dev->dma_mask >= DMA_BIT_MASK(32) || dev->bus_dma_mask) {
 			dev_err(dev,
-				"%s: overflow %pad+%zu of device mask %llx\n",
-				caller, &dma_addr, size, *dev->dma_mask);
+				"%s: overflow %pad+%zu of device mask %llx bus mask %llx\n",
+				caller, &dma_addr, size,
+				*dev->dma_mask, dev->bus_dma_mask);
 		}
 		return false;
 	}
@@ -65,12 +66,18 @@ u64 dma_direct_get_required_mask(struct device *dev)
 {
 	u64 max_dma = phys_to_dma_direct(dev, (max_pfn - 1) << PAGE_SHIFT);
 
+	if (dev->bus_dma_mask && dev->bus_dma_mask < max_dma)
+		max_dma = dev->bus_dma_mask;
+
 	return (1ULL << (fls64(max_dma) - 1)) * 2 - 1;
 }
 
 static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 		u64 *phys_mask)
 {
+	if (dev->bus_dma_mask && dev->bus_dma_mask < dma_mask)
+		dma_mask = dev->bus_dma_mask;
+
 	if (force_dma_unencrypted())
 		*phys_mask = __dma_to_phys(dev, dma_mask);
 	else
@@ -87,7 +94,7 @@ static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
 static bool dma_coherent_ok(struct device *dev, phys_addr_t phys, size_t size)
 {
 	return phys_to_dma_direct(dev, phys) + size - 1 <=
-			dev->coherent_dma_mask;
+			min_not_zero(dev->coherent_dma_mask, dev->bus_dma_mask);
 }
 
 void *dma_direct_alloc_pages(struct device *dev, size_t size,
@@ -291,12 +298,6 @@ int dma_direct_supported(struct device *dev, u64 mask)
 	if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
 		return 0;
 #endif
-	/*
-	 * Upstream PCI/PCIe bridges or SoC interconnects may not carry
-	 * as many DMA address bits as the device itself supports.
-	 */
-	if (dev->bus_dma_mask && mask > dev->bus_dma_mask)
-		return 0;
 	return 1;
 }
 
-- 
2.18.0
