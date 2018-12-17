Return-Path: <SRS0=wNeI=O2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0C6C43387
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 08:18:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3639520672
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 08:18:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3639520672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43JDYg408HzDqHj
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Dec 2018 19:18:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43JDWP2D2ZzDqMr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Dec 2018 19:16:17 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id C2A8F68DD3; Mon, 17 Dec 2018 09:16:13 +0100 (CET)
Date: Mon, 17 Dec 2018 09:16:13 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 2/8] powerpc/dma: properly wire up the unmap_page and
 unmap_sg methods
Message-ID: <20181217081613.GA2973@lst.de>
References: <20181216171951.31306-1-hch@lst.de>
 <20181216171951.31306-3-hch@lst.de>
 <ea83ba21-feee-9776-ab0a-5bc78b237e4c@c-s.fr> <20181217073434.GC1933@lst.de>
 <7074a63b-2eda-b775-ef1f-9708618fc717@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7074a63b-2eda-b775-ef1f-9708618fc717@c-s.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Christian Lamparter <chunkeey@gmail.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 17, 2018 at 08:39:17AM +0100, Christophe Leroy wrote:
> I can help you with powerpc 8xx actually.

Below is a patch that implements the proper scheme on top of the series
in this thread.  Compile tested with tqm8xx_defconfig and tqm8xx_defconfig
+ CONFIG_HIGHMEM only.

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index dacd0f93f2b2..8df9dd42b351 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -39,19 +39,17 @@ extern int dma_nommu_mmap_coherent(struct device *dev,
  * to ensure it is consistent.
  */
 struct device;
-extern void __dma_sync(void *vaddr, size_t size, int direction);
-extern void __dma_sync_page(struct page *page, unsigned long offset,
-				 size_t size, int direction);
+void ppc_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir);
+void ppc_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir);
 extern unsigned long __dma_get_coherent_pfn(unsigned long cpu_addr);
 
 #else /* ! CONFIG_NOT_COHERENT_CACHE */
-/*
- * Cache coherent cores.
- */
-
-#define __dma_sync(addr, size, rw)		((void)0)
-#define __dma_sync_page(pg, off, sz, rw)	((void)0)
-
+static inline void ppc_sync_dma_for_device(struct device *dev,
+		phys_addr_t paddr, size_t size, enum dma_data_direction dir)
+{
+}
 #endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
 static inline unsigned long device_to_mask(struct device *dev)
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 270b2911c437..0c0bcfebc271 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -6,7 +6,7 @@
  */
 
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/dma-debug.h>
 #include <linux/gfp.h>
 #include <linux/memblock.h>
@@ -194,23 +194,12 @@ static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
 			continue;
 
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+		ppc_sync_dma_for_device(dev, sg_phys(sg), sg->length, direction);
 	}
 
 	return nents;
 }
 
-static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
-				int nents, enum dma_data_direction direction,
-				unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
-}
-
 static u64 dma_nommu_get_required_mask(struct device *dev)
 {
 	u64 end, mask;
@@ -230,39 +219,70 @@ static inline dma_addr_t dma_nommu_map_page(struct device *dev,
 					     enum dma_data_direction dir,
 					     unsigned long attrs)
 {
+	phys_addr_t paddr = page_to_phys(page) + offset;
+
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync_page(page, offset, size, dir);
+		ppc_sync_dma_for_device(dev, paddr, size, dir);
 
-	return page_to_phys(page) + offset + get_dma_offset(dev);
+	return paddr + get_dma_offset(dev);
 }
 
+#ifdef CONFIG_NOT_COHERENT_CACHE
 static inline void dma_nommu_unmap_page(struct device *dev,
 					 dma_addr_t dma_address,
 					 size_t size,
-					 enum dma_data_direction direction,
+					 enum dma_data_direction dir,
 					 unsigned long attrs)
 {
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync(bus_to_virt(dma_address), size, dir);
+		ppc_sync_dma_for_cpu(dev, dma_to_phys(dev, dma_address), size,
+				dir);
 }
 
-#ifdef CONFIG_NOT_COHERENT_CACHE
-static inline void dma_nommu_sync_sg(struct device *dev,
+static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
+				int nents, enum dma_data_direction direction,
+				unsigned long attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		ppc_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, direction);
+}
+
+static inline void dma_nommu_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents,
-		enum dma_data_direction direction)
+		enum dma_data_direction dir)
 {
 	struct scatterlist *sg;
 	int i;
 
 	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+		ppc_sync_dma_for_device(dev, sg_phys(sg), sg->length, dir);
 }
+static inline void dma_nommu_sync_sg_for_cpu(struct device *dev,
+		struct scatterlist *sgl, int nents,
+		enum dma_data_direction dir)
+{
+	struct scatterlist *sg;
+	int i;
 
-static inline void dma_nommu_sync_single(struct device *dev,
+	for_each_sg(sgl, sg, nents, i)
+		ppc_sync_dma_for_cpu(dev, sg_phys(sg), sg->length, dir);
+}
+
+static inline void dma_nommu_sync_single_for_device(struct device *dev,
+					  dma_addr_t dma_handle, size_t size,
+					  enum dma_data_direction dir)
+{
+	ppc_sync_dma_for_device(dev, dma_to_phys(dev, dma_handle), size, dir);
+}
+
+static inline void dma_nommu_sync_single_for_cpu(struct device *dev,
 					  dma_addr_t dma_handle, size_t size,
-					  enum dma_data_direction direction)
+					  enum dma_data_direction dir)
 {
-	__dma_sync(bus_to_virt(dma_handle), size, direction);
+	ppc_sync_dma_for_cpu(dev, dma_to_phys(dev, dma_handle), size, dir);
 }
 #endif
 
@@ -271,16 +291,16 @@ const struct dma_map_ops dma_nommu_ops = {
 	.free				= dma_nommu_free_coherent,
 	.mmap				= dma_nommu_mmap_coherent,
 	.map_sg				= dma_nommu_map_sg,
-	.unmap_sg			= dma_nommu_unmap_sg,
 	.dma_supported			= dma_nommu_dma_supported,
 	.map_page			= dma_nommu_map_page,
-	.unmap_page			= dma_nommu_unmap_page,
 	.get_required_mask		= dma_nommu_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
-	.sync_single_for_cpu 		= dma_nommu_sync_single,
-	.sync_single_for_device 	= dma_nommu_sync_single,
-	.sync_sg_for_cpu 		= dma_nommu_sync_sg,
-	.sync_sg_for_device 		= dma_nommu_sync_sg,
+	.unmap_page			= dma_nommu_unmap_page,
+	.unmap_sg			= dma_nommu_unmap_sg,
+	.sync_single_for_cpu 		= dma_nommu_sync_single_for_cpu,
+	.sync_single_for_device 	= dma_nommu_sync_single_for_device,
+	.sync_sg_for_cpu 		= dma_nommu_sync_sg_for_cpu,
+	.sync_sg_for_device 		= dma_nommu_sync_sg_for_device,
 #endif
 };
 EXPORT_SYMBOL(dma_nommu_ops);
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index e955539686a4..b6501f0a5ac8 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -311,35 +311,17 @@ void __dma_nommu_free_coherent(struct device *dev, size_t size, void *vaddr,
 }
 
 /*
- * make an area consistent.
+ * Invalidate only when cache-line aligned otherwise there is the potential for
+ * discarding uncommitted data from the cache
  */
-void __dma_sync(void *vaddr, size_t size, int direction)
+static void flush_or_invalidate_dcache_range(unsigned long start,
+		unsigned long end)
 {
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end   = start + size;
-
-	switch (direction) {
-	case DMA_NONE:
-		BUG();
-	case DMA_FROM_DEVICE:
-		/*
-		 * invalidate only when cache-line aligned otherwise there is
-		 * the potential for discarding uncommitted data from the cache
-		 */
-		if ((start | end) & (L1_CACHE_BYTES - 1))
-			flush_dcache_range(start, end);
-		else
-			invalidate_dcache_range(start, end);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		clean_dcache_range(start, end);
-		break;
-	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
+	if ((start | end) & (L1_CACHE_BYTES - 1))
 		flush_dcache_range(start, end);
-		break;
-	}
+	else
+		invalidate_dcache_range(start, end);
 }
-EXPORT_SYMBOL(__dma_sync);
 
 #ifdef CONFIG_HIGHMEM
 /*
@@ -351,9 +333,11 @@ EXPORT_SYMBOL(__dma_sync);
  * Note: yes, it is possible and correct to have a buffer extend
  * beyond the first page.
  */
-static inline void __dma_sync_page_highmem(struct page *page,
-		unsigned long offset, size_t size, int direction)
+static inline void __dma_sync_phys(phys_addr_t paddr, size_t size,
+		void (*op)(unsigned long start, unsigned long end))
 {
+	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+	unsigned long offset = paddr & ~PAGE_MASK;
 	size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
 	size_t cur_size = seg_size;
 	unsigned long flags, start, seg_offset = offset;
@@ -366,7 +350,7 @@ static inline void __dma_sync_page_highmem(struct page *page,
 		start = (unsigned long)kmap_atomic(page + seg_nr) + seg_offset;
 
 		/* Sync this buffer segment */
-		__dma_sync((void *)start, seg_size, direction);
+		op(start, start + seg_size);
 		kunmap_atomic((void *)start);
 		seg_nr++;
 
@@ -380,23 +364,47 @@ static inline void __dma_sync_page_highmem(struct page *page,
 
 	local_irq_restore(flags);
 }
+#else
+static inline void __dma_sync_phys(phys_addr_t paddr, size_t size,
+		void (*op)(unsigned long start, unsigned long end))
+{
+	unsigned long start = (unsigned long)phys_to_virt(paddr);
+	op(start, start + size);
+}
 #endif /* CONFIG_HIGHMEM */
 
-/*
- * __dma_sync_page makes memory consistent. identical to __dma_sync, but
- * takes a struct page instead of a virtual address
- */
-void __dma_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction)
+void ppc_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
 {
-#ifdef CONFIG_HIGHMEM
-	__dma_sync_page_highmem(page, offset, size, direction);
-#else
-	unsigned long start = (unsigned long)page_address(page) + offset;
-	__dma_sync((void *)start, size, direction);
-#endif
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		__dma_sync_phys(paddr, size, flush_or_invalidate_dcache_range);
+		break;
+	case DMA_FROM_DEVICE:
+		__dma_sync_phys(paddr, size, clean_dcache_range);
+		break;
+	case DMA_BIDIRECTIONAL:
+		__dma_sync_phys(paddr, size, flush_dcache_range);
+		break;
+	default:
+		break;
+	}
+}
+
+void ppc_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	switch (dir) {
+	case DMA_TO_DEVICE:
+		break;
+	case DMA_FROM_DEVICE:
+	case DMA_BIDIRECTIONAL:
+		__dma_sync_phys(paddr, size, clean_dcache_range);
+		break;
+	default:
+		break;
+	}
 }
-EXPORT_SYMBOL(__dma_sync_page);
 
 /*
  * Return the PFN for a given cpu virtual address returned by
