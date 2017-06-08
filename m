Return-Path: <BATV+eb06f239ea6f59aeb59b+5037+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk5pc0Jq6zDqLk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Jun 2017 23:28:24 +1000 (AEST)
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
Subject: [PATCH 31/44] hexagon: remove arch-specific dma_supported
 implementation
Date: Thu,  8 Jun 2017 15:25:56 +0200
Message-Id: <20170608132609.32662-32-hch@lst.de>
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

This implementation is simply bogus - hexagon only has a simple
direct mapped DMA implementation and thus doesn't care about the
address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/hexagon/include/asm/dma-mapping.h | 2 --
 arch/hexagon/kernel/dma.c              | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/hexagon/include/asm/dma-mapping.h b/arch/hexagon/include/asm/dma-mapping.h
index 00e3f10113b0..9c15cb5271a6 100644
--- a/arch/hexagon/include/asm/dma-mapping.h
+++ b/arch/hexagon/include/asm/dma-mapping.h
@@ -37,8 +37,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return dma_ops;
 }
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-extern int dma_supported(struct device *dev, u64 mask);
 extern int dma_is_consistent(struct device *dev, dma_addr_t dma_handle);
 extern void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 			   enum dma_data_direction direction);
diff --git a/arch/hexagon/kernel/dma.c b/arch/hexagon/kernel/dma.c
index 71269dc0f225..9ff1b2041f85 100644
--- a/arch/hexagon/kernel/dma.c
+++ b/arch/hexagon/kernel/dma.c
@@ -35,15 +35,6 @@ static inline void *dma_addr_to_virt(dma_addr_t dma_addr)
 	return phys_to_virt((unsigned long) dma_addr);
 }
 
-int dma_supported(struct device *dev, u64 mask)
-{
-	if (mask == DMA_BIT_MASK(32))
-		return 1;
-	else
-		return 0;
-}
-EXPORT_SYMBOL(dma_supported);
-
 static struct gen_pool *coherent_pool;
 
 
-- 
2.11.0
