Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk5pb02DpzDqLK
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:28:23 +1000 (AEST)
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
Subject: [PATCH 30/44] dma-virt: remove dma_supported and mapping_error methods
Date: Thu,  8 Jun 2017 15:25:55 +0200
Message-Id: <20170608132609.32662-31-hch@lst.de>
In-Reply-To: <20170608132609.32662-1-hch@lst.de>
References: <20170608132609.32662-1-hch@lst.de>
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
 lib/dma-virt.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/lib/dma-virt.c b/lib/dma-virt.c
index dcd4df1f7174..5c4f11329721 100644
--- a/lib/dma-virt.c
+++ b/lib/dma-virt.c
@@ -51,22 +51,10 @@ static int dma_virt_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static int dma_virt_mapping_error(struct device *dev, dma_addr_t dma_addr)
-{
-	return false;
-}
-
-static int dma_virt_supported(struct device *dev, u64 mask)
-{
-	return true;
-}
-
 const struct dma_map_ops dma_virt_ops = {
 	.alloc			= dma_virt_alloc,
 	.free			= dma_virt_free,
 	.map_page		= dma_virt_map_page,
 	.map_sg			= dma_virt_map_sg,
-	.mapping_error		= dma_virt_mapping_error,
-	.dma_supported		= dma_virt_supported,
 };
 EXPORT_SYMBOL(dma_virt_ops);
-- 
2.11.0
