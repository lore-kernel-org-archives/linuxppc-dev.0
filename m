Return-Path: <BATV+396ebc2d5722fb16c925+5454+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fQHy2XdJzF14Y
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jul 2018 02:38:54 +1000 (AEST)
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Robin Murphy <robin.murphy@arm.com>, linuxppc-dev@lists.ozlabs.org,
 iommu@lists.linux-foundation.org, linux-ia64@vger.kernel.org
Subject: [PATCH 06/20] dma-noncoherent: add an optional arch hook for
 ->get_required_mask
Date: Mon, 30 Jul 2018 18:38:10 +0200
Message-Id: <20180730163824.10064-7-hch@lst.de>
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

This is need for powerpc for now.  Hopefully we can come up with a clean
generic implementation mid-term.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dma-noncoherent.h | 6 ++++++
 kernel/dma/Kconfig              | 4 ++++
 kernel/dma/noncoherent.c        | 1 +
 3 files changed, 11 insertions(+)

diff --git a/include/linux/dma-noncoherent.h b/include/linux/dma-noncoherent.h
index 10b2654d549b..61394c6e56df 100644
--- a/include/linux/dma-noncoherent.h
+++ b/include/linux/dma-noncoherent.h
@@ -17,6 +17,12 @@ int arch_dma_mmap(struct device *dev, struct vm_area_struct *vma,
 #define arch_dma_mmap NULL
 #endif /* CONFIG_DMA_NONCOHERENT_MMAP */
 
+#ifdef CONFIG_DMA_NONCOHERENT_GET_REQUIRED
+u64 arch_get_required_mask(struct device *dev);
+#else
+#define arch_get_required_mask NULL
+#endif
+
 #ifdef CONFIG_DMA_NONCOHERENT_CACHE_SYNC
 void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9bd54304446f..b523104d6199 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -36,6 +36,10 @@ config DMA_NONCOHERENT_MMAP
 	bool
 	depends on DMA_NONCOHERENT_OPS
 
+config DMA_NONCOHERENT_GET_REQUIRED
+	bool
+	depends on DMA_NONCOHERENT_OPS
+
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
 	depends on DMA_NONCOHERENT_OPS
diff --git a/kernel/dma/noncoherent.c b/kernel/dma/noncoherent.c
index 79e9a757387f..cf4ffbe4a09d 100644
--- a/kernel/dma/noncoherent.c
+++ b/kernel/dma/noncoherent.c
@@ -98,5 +98,6 @@ const struct dma_map_ops dma_noncoherent_ops = {
 	.dma_supported		= dma_direct_supported,
 	.mapping_error		= dma_direct_mapping_error,
 	.cache_sync		= arch_dma_cache_sync,
+	.get_required_mask	= arch_get_required_mask,
 };
 EXPORT_SYMBOL(dma_noncoherent_ops);
-- 
2.18.0
