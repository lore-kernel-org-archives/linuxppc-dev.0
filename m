Return-Path: <beckyb@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BFC15B7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  3 Sep 2009 08:23:25 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27641DDD01
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Sep 2009 08:23:24 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n82MNKxW004259
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Sep 2009 17:23:21 -0500
From: Becky Bruce <beckyb@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: rename get_dma_direct_offset get_dma_offset
Date: Wed,  2 Sep 2009 17:23:19 -0500
Message-Id: <1251930200-4796-1-git-send-email-beckyb@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The former is no longer really accurate with the swiotlb case now
a possibility.  I also move it into dma-mapping.h - it no longer
needs to be in dma.c, and there are about to be some more accessors
that should all end up in the same place.

Signed-off-by: Becky Bruce <beckyb@kernel.crashing.org>
---
 arch/powerpc/include/asm/dma-mapping.h |   13 ++++++++++---
 arch/powerpc/kernel/dma.c              |   15 ++++-----------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index cb2ca41..eef4db1 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -26,7 +26,6 @@ extern void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 extern void dma_direct_free_coherent(struct device *dev, size_t size,
 				     void *vaddr, dma_addr_t dma_handle);
 
-extern unsigned long get_dma_direct_offset(struct device *dev);
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
 /*
@@ -90,6 +89,14 @@ static inline void set_dma_ops(struct device *dev, struct dma_map_ops *ops)
 	dev->archdata.dma_ops = ops;
 }
 
+static inline unsigned long get_dma_offset(struct device *dev)
+{
+	if (dev)
+		return (unsigned long)dev->archdata.dma_data;
+
+	return PCI_DRAM_OFFSET;
+}
+
 /* this will be removed soon */
 #define flush_write_buffers()
 
@@ -181,12 +188,12 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
-	return paddr + get_dma_direct_offset(dev);
+	return paddr + get_dma_offset(dev);
 }
 
 static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
 {
-	return daddr - get_dma_direct_offset(dev);
+	return daddr - get_dma_offset(dev);
 }
 
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 21b784d..6215062 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -21,13 +21,6 @@
  * default the offset is PCI_DRAM_OFFSET.
  */
 
-unsigned long get_dma_direct_offset(struct device *dev)
-{
-	if (dev)
-		return (unsigned long)dev->archdata.dma_data;
-
-	return PCI_DRAM_OFFSET;
-}
 
 void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				dma_addr_t *dma_handle, gfp_t flag)
@@ -37,7 +30,7 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 	ret = __dma_alloc_coherent(dev, size, dma_handle, flag);
 	if (ret == NULL)
 		return NULL;
-	*dma_handle += get_dma_direct_offset(dev);
+	*dma_handle += get_dma_offset(dev);
 	return ret;
 #else
 	struct page *page;
@@ -51,7 +44,7 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	ret = page_address(page);
 	memset(ret, 0, size);
-	*dma_handle = virt_to_abs(ret) + get_dma_direct_offset(dev);
+	*dma_handle = virt_to_abs(ret) + get_dma_offset(dev);
 
 	return ret;
 #endif
@@ -75,7 +68,7 @@ static int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = sg_phys(sg) + get_dma_direct_offset(dev);
+		sg->dma_address = sg_phys(sg) + get_dma_offset(dev);
 		sg->dma_length = sg->length;
 		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 	}
@@ -110,7 +103,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 {
 	BUG_ON(dir == DMA_NONE);
 	__dma_sync_page(page, offset, size, dir);
-	return page_to_phys(page) + offset + get_dma_direct_offset(dev);
+	return page_to_phys(page) + offset + get_dma_offset(dev);
 }
 
 static inline void dma_direct_unmap_page(struct device *dev,
-- 
1.6.0.6
