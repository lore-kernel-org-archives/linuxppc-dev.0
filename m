Return-Path: <BATV+ddff6d03254b98e050e8+5253+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zGhWT2mMzzDqpw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jan 2018 19:09:57 +1100 (AEDT)
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux-foundation.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Michal Simek <monstr@monstr.eu>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/22] powerpc: rename swiotlb_dma_ops
Date: Wed, 10 Jan 2018 09:09:14 +0100
Message-Id: <20180110080932.14157-5-hch@lst.de>
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

We'll need that name for a generic implementation soon.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/swiotlb.h | 2 +-
 arch/powerpc/kernel/dma-swiotlb.c  | 4 ++--
 arch/powerpc/kernel/dma.c          | 2 +-
 arch/powerpc/sysdev/fsl_pci.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/swiotlb.h b/arch/powerpc/include/asm/swiotlb.h
index 9341ee804d19..f65ecf57b66c 100644
--- a/arch/powerpc/include/asm/swiotlb.h
+++ b/arch/powerpc/include/asm/swiotlb.h
@@ -13,7 +13,7 @@
 
 #include <linux/swiotlb.h>
 
-extern const struct dma_map_ops swiotlb_dma_ops;
+extern const struct dma_map_ops powerpc_swiotlb_dma_ops;
 
 extern unsigned int ppc_swiotlb_enable;
 int __init swiotlb_setup_bus_notifier(void);
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index f1e99b9cee97..506ac4fafac5 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -46,7 +46,7 @@ static u64 swiotlb_powerpc_get_required(struct device *dev)
  * map_page, and unmap_page on highmem, use normal dma_ops
  * for everything else.
  */
-const struct dma_map_ops swiotlb_dma_ops = {
+const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.alloc = __dma_nommu_alloc_coherent,
 	.free = __dma_nommu_free_coherent,
 	.mmap = dma_nommu_mmap_coherent,
@@ -89,7 +89,7 @@ static int ppc_swiotlb_bus_notify(struct notifier_block *nb,
 
 	/* May need to bounce if the device can't address all of DRAM */
 	if ((dma_get_mask(dev) + 1) < memblock_end_of_DRAM())
-		set_dma_ops(dev, &swiotlb_dma_ops);
+		set_dma_ops(dev, &powerpc_swiotlb_dma_ops);
 
 	return NOTIFY_DONE;
 }
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 76079841d3d0..da20569de9d4 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -33,7 +33,7 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
 	struct dev_archdata __maybe_unused *sd = &dev->archdata;
 
 #ifdef CONFIG_SWIOTLB
-	if (sd->max_direct_dma_addr && dev->dma_ops == &swiotlb_dma_ops)
+	if (sd->max_direct_dma_addr && dev->dma_ops == &powerpc_swiotlb_dma_ops)
 		pfn = min_t(u64, pfn, sd->max_direct_dma_addr >> PAGE_SHIFT);
 #endif
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index e4d0133bbeeb..61e07c78d64f 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -118,7 +118,7 @@ static void setup_swiotlb_ops(struct pci_controller *hose)
 {
 	if (ppc_swiotlb_enable) {
 		hose->controller_ops.dma_dev_setup = pci_dma_dev_setup_swiotlb;
-		set_pci_dma_ops(&swiotlb_dma_ops);
+		set_pci_dma_ops(&powerpc_swiotlb_dma_ops);
 	}
 }
 #else
-- 
2.14.2
