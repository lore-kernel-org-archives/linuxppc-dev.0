Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGhKJ6CqvzF0gC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:01:08 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-c6x-dev@linux-c6x.org, linux-cris-kernel@axis.com,
 linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-metag@vger.kernel.org,
 Michal Simek <monstr@monstr.eu>, linux-mips@linux-mips.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 patches@groups.riscv.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/33] s390: remove the unused dma_capable helper
Date: Wed, 10 Jan 2018 09:00:02 +0100
Message-Id: <20180110080027.13879-9-hch@lst.de>
In-Reply-To: <20180110080027.13879-1-hch@lst.de>
References: <20180110080027.13879-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/s390/include/asm/dma-mapping.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/s390/include/asm/dma-mapping.h b/arch/s390/include/asm/dma-mapping.h
index eaf490f9c5bc..2ec7240c1ada 100644
--- a/arch/s390/include/asm/dma-mapping.h
+++ b/arch/s390/include/asm/dma-mapping.h
@@ -16,11 +16,4 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return &dma_noop_ops;
 }
 
-static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
-{
-	if (!dev->dma_mask)
-		return false;
-	return addr + size - 1 <= *dev->dma_mask;
-}
-
 #endif /* _ASM_S390_DMA_MAPPING_H */
-- 
2.14.2
