Return-Path: <B21989@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe003.messaging.microsoft.com [213.199.154.141])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 67B2C2C12BA
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 22:46:02 +1000 (EST)
Received: from mail111-db3 (localhost [127.0.0.1])	by
 mail111-db3-R.bigfish.com (Postfix) with ESMTP id 1743C3801A6	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 12:45:56 +0000 (UTC)
Received: from DB3EHSMHS002.bigfish.com (unknown [10.3.81.246])	by
 mail111-db3.bigfish.com (Postfix) with ESMTP id 089E9340133	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jul 2012 12:45:53 +0000 (UTC)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH] powerpc/mm: add ZONE_NORMAL zone for 64 bit kernel
Date: Fri, 20 Jul 2012 20:21:46 +0800
Message-ID: <1342786906-12634-1-git-send-email-Shaohui.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Mingkai Hu <Mingkai.hu@freescale.com>,
 Shaohui Xie <Shaohui.Xie@freescale.com>, Chen Yuanquan <B41889@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PowerPC platform only supports ZONE_DMA zone for 64bit kernel, so all the
memory will be put into this zone. If the memory size is greater than
the device's DMA capability and device uses dma_alloc_coherent to allocate
memory, it will get an address which is over the device's DMA addressing,
the device will fail.

So we split the memory to two zones by adding a zone ZONE_NORMAL, since
we already allocate PCICSRBAR/PEXCSRBAR right below the 4G boundary (if the
lowest PCI address is above 4G), so we constrain the DMA zone ZONE_DMA
to 2GB, also, we clear the flag __GFP_DMA and set it only if the device's
dma_mask < total memory size. By doing this, devices which cannot DMA all
the memory will be limited to ZONE_DMA, but devices which can DMA all the
memory will not be affected by this limitation.

Signed-off-by: Shaohui Xie <Shaohui.Xie@freescale.com>
Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
Signed-off-by: Chen Yuanquan <B41889@freescale.com>
---
 arch/powerpc/kernel/dma.c |   13 ++++++++++++-
 arch/powerpc/mm/mem.c     |    4 +++-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index b1ec983..8029295 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -30,6 +30,7 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				struct dma_attrs *attrs)
 {
 	void *ret;
+	phys_addr_t top_ram_pfn = memblock_end_of_DRAM();
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	ret = __dma_alloc_coherent(dev, size, dma_handle, flag);
 	if (ret == NULL)
@@ -40,8 +41,18 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 	struct page *page;
 	int node = dev_to_node(dev);
 
+	/*
+	 * check for crappy device which has dma_mask < ZONE_DMA, and
+	 * we are not going to support it, just warn and fail.
+	 */
+	if (*dev->dma_mask < DMA_BIT_MASK(31)) {
+		dev_err(dev, "Unsupported dma_mask 0x%llx\n", *dev->dma_mask);
+		return NULL;
+	}
 	/* ignore region specifiers */
-	flag  &= ~(__GFP_HIGHMEM);
+	flag  &= ~(__GFP_HIGHMEM | __GFP_DMA);
+	if (*dev->dma_mask < top_ram_pfn - 1)
+		flag |= GFP_DMA;
 
 	page = alloc_pages_node(node, flag, get_order(size));
 	if (page == NULL)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index baaafde..a494555 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -281,7 +281,9 @@ void __init paging_init(void)
 	max_zone_pfns[ZONE_DMA] = lowmem_end_addr >> PAGE_SHIFT;
 	max_zone_pfns[ZONE_HIGHMEM] = top_of_ram >> PAGE_SHIFT;
 #else
-	max_zone_pfns[ZONE_DMA] = top_of_ram >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_DMA] = min_t(phys_addr_t, top_of_ram,
+					1ull << 31) >> PAGE_SHIFT;
+	max_zone_pfns[ZONE_NORMAL] = top_of_ram >> PAGE_SHIFT;
 #endif
 	free_area_init_nodes(max_zone_pfns);
 
-- 
1.6.4
