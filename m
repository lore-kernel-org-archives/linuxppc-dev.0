Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0239.outbound.protection.outlook.com [207.46.163.239])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E73E11A0A6A
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 09:41:11 +1000 (EST)
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/4] powerpc/64: Honor swiotlb limit in coherent allocations
Date: Fri, 8 Aug 2014 18:40:43 -0500
Message-ID: <1407541245-27617-2-git-send-email-scottwood@freescale.com>
In-Reply-To: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
References: <1407541245-27617-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Shaohui Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

FSL PCI cannot directly address the whole lower 4 GiB due to
conflicts with PCICSRBAR and outbound windows, and thus
max_direct_dma_addr is less than 4GiB.  Honor that limit in
dma_direct_alloc_coherent().

Note that setting the DMA mask to 31 bits is not an option, since many
PCI drivers would fail if we reject 32-bit DMA in dma_supported(), and
we have no control over the setting of coherent_dma_mask if
dma_supported() returns true.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Cc: Shaohui Xie <Shaohui.Xie@freescale.com>
---
 arch/powerpc/kernel/dma.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index dfd99ef..a7b0156 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -15,6 +15,7 @@
 #include <asm/vio.h>
 #include <asm/bug.h>
 #include <asm/machdep.h>
+#include <asm/swiotlb.h>
 
 /*
  * Generic direct DMA implementation
@@ -25,6 +26,18 @@
  * default the offset is PCI_DRAM_OFFSET.
  */
 
+static u64 __maybe_unused get_pfn_limit(struct device *dev)
+{
+	u64 pfn = (dev->coherent_dma_mask >> PAGE_SHIFT) + 1;
+	struct dev_archdata __maybe_unused *sd = &dev->archdata;
+
+#ifdef CONFIG_SWIOTLB
+	if (sd->max_direct_dma_addr && sd->dma_ops == &swiotlb_dma_ops)
+		pfn = min_t(u64, pfn, sd->max_direct_dma_addr >> PAGE_SHIFT);
+#endif
+
+	return pfn;
+}
 
 void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				dma_addr_t *dma_handle, gfp_t flag,
@@ -40,7 +53,7 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 #else
 	struct page *page;
 	int node = dev_to_node(dev);
-	u64 pfn = (dev->coherent_dma_mask >> PAGE_SHIFT) + 1;
+	u64 pfn = get_pfn_limit(dev);
 	int zone;
 
 	zone = dma_pfn_limit_to_zone(pfn);
-- 
1.9.1
