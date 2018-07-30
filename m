Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fQHq0lQSzF0gv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:38:47 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Subject: [PATCH 03/20] dma-mapping: make the get_required_mask method
 available unconditionally
Date: Mon, 30 Jul 2018 18:38:07 +0200
Message-Id: <20180730163824.10064-4-hch@lst.de>
In-Reply-To: <20180730163824.10064-1-hch@lst.de>
References: <20180730163824.10064-1-hch@lst.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This save some duplication for ia64.  In the long run this method will
need some additional work including moving over to kernel/dma, but that
will require some additional prep work, so let's do this minimal change
for now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/base/platform.c     | 11 ++++++++++-
 include/linux/dma-mapping.h |  2 --
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index dff82a3c2caa..921ddb0c051b 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1180,7 +1180,7 @@ int __init platform_bus_init(void)
 }
 
 #ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
-u64 dma_get_required_mask(struct device *dev)
+static u64 default_dma_get_required_mask(struct device *dev)
 {
 	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
 	u32 high_totalram = ((max_pfn - 1) >> (32 - PAGE_SHIFT));
@@ -1198,6 +1198,15 @@ u64 dma_get_required_mask(struct device *dev)
 	}
 	return mask;
 }
+
+u64 dma_get_required_mask(struct device *dev)
+{
+	const struct dma_map_ops *ops = get_dma_ops(dev);
+
+	if (ops->get_required_mask)
+		return ops->get_required_mask(dev);
+	return default_dma_get_required_mask(dev);
+}
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
 #endif
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f9cc309507d9..00d3065e1510 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -130,9 +130,7 @@ struct dma_map_ops {
 			enum dma_data_direction direction);
 	int (*mapping_error)(struct device *dev, dma_addr_t dma_addr);
 	int (*dma_supported)(struct device *dev, u64 mask);
-#ifdef ARCH_HAS_DMA_GET_REQUIRED_MASK
 	u64 (*get_required_mask)(struct device *dev);
-#endif
 };
 
 extern const struct dma_map_ops dma_direct_ops;
-- 
2.18.0
