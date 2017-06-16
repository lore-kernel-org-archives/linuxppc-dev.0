Return-Path: <BATV+48ca1ab4adaecdf09dc3+5045+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wq7lg0c6kzDq8W
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 04:13:19 +1000 (AEST)
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
Subject: [PATCH 33/44] openrisc: remove arch-specific dma_supported
 implementation
Date: Fri, 16 Jun 2017 20:10:48 +0200
Message-Id: <20170616181059.19206-34-hch@lst.de>
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

This implementation is simply bogus - openrisc only has a simple
direct mapped DMA implementation and thus doesn't care about the
address.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/openrisc/include/asm/dma-mapping.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/openrisc/include/asm/dma-mapping.h b/arch/openrisc/include/asm/dma-mapping.h
index a4ea139c2ef9..f41bd3cb76d9 100644
--- a/arch/openrisc/include/asm/dma-mapping.h
+++ b/arch/openrisc/include/asm/dma-mapping.h
@@ -33,11 +33,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &or1k_dma_map_ops;
 }
 
-#define HAVE_ARCH_DMA_SUPPORTED 1
-static inline int dma_supported(struct device *dev, u64 dma_mask)
-{
-	/* Support 32 bit DMA mask exclusively */
-	return dma_mask == DMA_BIT_MASK(32);
-}
-
 #endif	/* __ASM_OPENRISC_DMA_MAPPING_H */
-- 
2.11.0
