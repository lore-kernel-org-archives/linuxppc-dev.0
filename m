Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq7m26HNMzDq98
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 04:13:38 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 xen-devel@lists.xenproject.org, linux-c6x-dev@linux-c6x.org,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, openrisc@lists.librecores.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-xtensa@linux-xtensa.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 40/44] tile: remove dma_supported and mapping_error methods
Date: Fri, 16 Jun 2017 20:10:55 +0200
Message-Id: <20170616181059.19206-41-hch@lst.de>
In-Reply-To: <20170616181059.19206-1-hch@lst.de>
References: <20170616181059.19206-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These just duplicate the default behavior if no method is provided.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/tile/kernel/pci-dma.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/tile/kernel/pci-dma.c b/arch/tile/kernel/pci-dma.c
index 569bb6dd154a..f2abedc8a080 100644
--- a/arch/tile/kernel/pci-dma.c
+++ b/arch/tile/kernel/pci-dma.c
@@ -317,18 +317,6 @@ static void tile_dma_sync_sg_for_device(struct device *dev,
 	}
 }
 
-static inline int
-tile_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline int
-tile_dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 static const struct dma_map_ops tile_default_dma_map_ops = {
 	.alloc = tile_dma_alloc_coherent,
 	.free = tile_dma_free_coherent,
@@ -340,8 +328,6 @@ static const struct dma_map_ops tile_default_dma_map_ops = {
 	.sync_single_for_device = tile_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_dma_sync_sg_for_device,
-	.mapping_error = tile_dma_mapping_error,
-	.dma_supported = tile_dma_supported
 };
 
 const struct dma_map_ops *tile_dma_map_ops = &tile_default_dma_map_ops;
@@ -504,18 +490,6 @@ static void tile_pci_dma_sync_sg_for_device(struct device *dev,
 	}
 }
 
-static inline int
-tile_pci_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return 0;
-}
-
-static inline int
-tile_pci_dma_supported(struct device *dev, u64 mask)
-{
-	return 1;
-}
-
 static const struct dma_map_ops tile_pci_default_dma_map_ops = {
 	.alloc = tile_pci_dma_alloc_coherent,
 	.free = tile_pci_dma_free_coherent,
@@ -527,8 +501,6 @@ static const struct dma_map_ops tile_pci_default_dma_map_ops = {
 	.sync_single_for_device = tile_pci_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_pci_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_pci_dma_sync_sg_for_device,
-	.mapping_error = tile_pci_dma_mapping_error,
-	.dma_supported = tile_pci_dma_supported
 };
 
 const struct dma_map_ops *gx_pci_dma_map_ops = &tile_pci_default_dma_map_ops;
@@ -578,8 +550,6 @@ static const struct dma_map_ops pci_hybrid_dma_ops = {
 	.sync_single_for_device = tile_pci_dma_sync_single_for_device,
 	.sync_sg_for_cpu = tile_pci_dma_sync_sg_for_cpu,
 	.sync_sg_for_device = tile_pci_dma_sync_sg_for_device,
-	.mapping_error = tile_pci_dma_mapping_error,
-	.dma_supported = tile_pci_dma_supported
 };
 
 const struct dma_map_ops *gx_legacy_pci_dma_map_ops = &pci_swiotlb_dma_ops;
-- 
2.11.0
