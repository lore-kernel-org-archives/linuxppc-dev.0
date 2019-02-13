Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23C7C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:55:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E6FC222BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mhJhnq4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E6FC222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zsJK37dRzDqV3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:55:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="mhJhnq4c"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7r69RKzDqNX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fNbJrcHN25NVSYV/f4JAQi3fs53KdSu9kh9zLwE6id4=; b=mhJhnq4c6rdzb0FRlLNltQucSq
 mm1dYZLRjwvF4gfYJ0vxks4QzBQELvktYr/YX+0sLa1Gq3V5xXdLMuUpMzq3FIocfPmSjEqI8xapG
 g5lItJ1VOzTl3pjbyKCzWBZca7eqWRderjPnRvNBcIUhQpE4BFvFXq/bXkwl+vmyOHRlSKjeARxnT
 2/YPsjRGKvndhHvvHqfi9qLTBuJ1JO4VWChdW0mpdG4oA9Uuv9uL0UWpY2BQ1IgJFv5AlRQ1Pr/Y7
 2L2VQtdoijFOOF5nAmmOzYnwHcNCa5GJCcrrh9HcNmloxaf5N1Q2oxN44jJudxX9Do5K3hf2iLMH9
 LMJcQSWg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoZ7-0000ji-IE; Wed, 13 Feb 2019 07:02:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 28/32] powerpc/dma: use the dma_direct mapping routines
Date: Wed, 13 Feb 2019 08:01:29 +0100
Message-Id: <20190213070133.11259-29-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213070133.11259-1-hch@lst.de>
References: <20190213070133.11259-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Switch the streaming DMA mapping and ownership transfer methods to the
functionally identical dma_direct_ versions.  Factor the cache
maintainance helpers into the form expected by the common code for that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-mapping.h | 30 ---------
 arch/powerpc/kernel/dma-iommu.c        |  4 +-
 arch/powerpc/kernel/dma.c              | 87 +++-----------------------
 arch/powerpc/mm/dma-noncoherent.c      | 29 ++++++---
 arch/powerpc/platforms/Kconfig.cputype |  2 +
 5 files changed, 32 insertions(+), 120 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index cdf70aaeafeb..4de9d4ee23c1 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -25,36 +25,6 @@ extern void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 extern void __dma_nommu_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_handle,
 				       unsigned long attrs);
-int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction direction,
-		unsigned long attrs);
-dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size,
-		enum dma_data_direction dir, unsigned long attrs);
-
-#ifdef CONFIG_NOT_COHERENT_CACHE
-/*
- * DMA-consistent mapping functions for PowerPCs that don't support
- * cache snooping.  These allocate/free a region of uncached mapped
- * memory space for use with DMA devices.  Alternatively, you could
- * allocate the space "normally" and use the cache management functions
- * to ensure it is consistent.
- */
-struct device;
-extern void __dma_sync(void *vaddr, size_t size, int direction);
-extern void __dma_sync_page(struct page *page, unsigned long offset,
-				 size_t size, int direction);
-extern unsigned long __dma_get_coherent_pfn(unsigned long cpu_addr);
-
-#else /* ! CONFIG_NOT_COHERENT_CACHE */
-/*
- * Cache coherent cores.
- */
-
-#define __dma_sync(addr, size, rw)		((void)0)
-#define __dma_sync_page(pg, off, sz, rw)	((void)0)
-
-#endif /* ! CONFIG_NOT_COHERENT_CACHE */
 
 static inline unsigned long device_to_mask(struct device *dev)
 {
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index c75ba4e3a50c..09231ef06d01 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -68,7 +68,7 @@ static dma_addr_t dma_iommu_map_page(struct device *dev, struct page *page,
 				     unsigned long attrs)
 {
 	if (dma_iommu_map_bypass(dev, attrs))
-		return dma_nommu_map_page(dev, page, offset, size, direction,
+		return dma_direct_map_page(dev, page, offset, size, direction,
 				attrs);
 	return iommu_map_page(dev, get_iommu_table_base(dev), page, offset,
 			      size, device_to_mask(dev), direction, attrs);
@@ -90,7 +90,7 @@ static int dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 			    unsigned long attrs)
 {
 	if (dma_iommu_map_bypass(dev, attrs))
-		return dma_nommu_map_sg(dev, sglist, nelems, direction, attrs);
+		return dma_direct_map_sg(dev, sglist, nelems, direction, attrs);
 	return ppc_iommu_map_sg(dev, get_iommu_table_base(dev), sglist, nelems,
 				device_to_mask(dev), direction, attrs);
 }
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index f983f8d435a6..b9f7283e7224 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -27,77 +27,6 @@
  * default the offset is PCI_DRAM_OFFSET.
  */
 
-int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
-		int nents, enum dma_data_direction direction,
-		unsigned long attrs)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = phys_to_dma(dev, sg_phys(sg));
-		sg->dma_length = sg->length;
-
-		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
-			continue;
-
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
-	}
-
-	return nents;
-}
-
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
-dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
-		unsigned long offset, size_t size,
-		enum dma_data_direction dir, unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync_page(page, offset, size, dir);
-
-	return phys_to_dma(dev, page_to_phys(page)) + offset;
-}
-
-static inline void dma_nommu_unmap_page(struct device *dev,
-					 dma_addr_t dma_address,
-					 size_t size,
-					 enum dma_data_direction direction,
-					 unsigned long attrs)
-{
-	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
-		__dma_sync(bus_to_virt(dma_address), size, direction);
-}
-
-#ifdef CONFIG_NOT_COHERENT_CACHE
-static inline void dma_nommu_sync_sg(struct device *dev,
-		struct scatterlist *sgl, int nents,
-		enum dma_data_direction direction)
-{
-	struct scatterlist *sg;
-	int i;
-
-	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
-}
-
-static inline void dma_nommu_sync_single(struct device *dev,
-					  dma_addr_t dma_handle, size_t size,
-					  enum dma_data_direction direction)
-{
-	__dma_sync(bus_to_virt(dma_handle), size, direction);
-}
-#endif
-
 const struct dma_map_ops dma_nommu_ops = {
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.alloc				= __dma_nommu_alloc_coherent,
@@ -106,17 +35,17 @@ const struct dma_map_ops dma_nommu_ops = {
 	.alloc				= dma_direct_alloc,
 	.free				= dma_direct_free,
 #endif
-	.map_sg				= dma_nommu_map_sg,
-	.unmap_sg			= dma_nommu_unmap_sg,
+	.map_sg				= dma_direct_map_sg,
 	.dma_supported			= dma_direct_supported,
-	.map_page			= dma_nommu_map_page,
-	.unmap_page			= dma_nommu_unmap_page,
+	.map_page			= dma_direct_map_page,
 	.get_required_mask		= dma_direct_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
-	.sync_single_for_cpu 		= dma_nommu_sync_single,
-	.sync_single_for_device 	= dma_nommu_sync_single,
-	.sync_sg_for_cpu 		= dma_nommu_sync_sg,
-	.sync_sg_for_device 		= dma_nommu_sync_sg,
+	.unmap_sg			= dma_direct_unmap_sg,
+	.unmap_page			= dma_direct_unmap_page,
+	.sync_single_for_cpu 		= dma_direct_sync_single_for_cpu,
+	.sync_single_for_device 	= dma_direct_sync_single_for_device,
+	.sync_sg_for_cpu 		= dma_direct_sync_sg_for_cpu,
+	.sync_sg_for_device 		= dma_direct_sync_sg_for_device,
 #endif
 };
 EXPORT_SYMBOL(dma_nommu_ops);
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index ee95da19c82d..c3d15d718a58 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -314,7 +314,7 @@ void __dma_nommu_free_coherent(struct device *dev, size_t size, void *vaddr,
 /*
  * make an area consistent.
  */
-void __dma_sync(void *vaddr, size_t size, int direction)
+static void __dma_sync(void *vaddr, size_t size, int direction)
 {
 	unsigned long start = (unsigned long)vaddr;
 	unsigned long end   = start + size;
@@ -340,7 +340,6 @@ void __dma_sync(void *vaddr, size_t size, int direction)
 		break;
 	}
 }
-EXPORT_SYMBOL(__dma_sync);
 
 #ifdef CONFIG_HIGHMEM
 /*
@@ -387,21 +386,33 @@ static inline void __dma_sync_page_highmem(struct page *page,
  * __dma_sync_page makes memory consistent. identical to __dma_sync, but
  * takes a struct page instead of a virtual address
  */
-void __dma_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction)
+static void __dma_sync_page(phys_addr_t paddr, size_t size, int dir)
 {
+	struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+	unsigned offset = paddr & ~PAGE_MASK;
+
 #ifdef CONFIG_HIGHMEM
-	__dma_sync_page_highmem(page, offset, size, direction);
+	__dma_sync_page_highmem(page, offset, size, dir);
 #else
 	unsigned long start = (unsigned long)page_address(page) + offset;
-	__dma_sync((void *)start, size, direction);
+	__dma_sync((void *)start, size, dir);
 #endif
 }
-EXPORT_SYMBOL(__dma_sync_page);
+
+void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	__dma_sync_page(paddr, size, dir);
+}
+
+void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
+		size_t size, enum dma_data_direction dir)
+{
+	__dma_sync_page(paddr, size, dir);
+}
 
 /*
- * Return the PFN for a given cpu virtual address returned by
- * __dma_nommu_alloc_coherent.
+ * Return the PFN for a given cpu virtual address returned by arch_dma_alloc.
  */
 long arch_dma_coherent_to_pfn(struct device *dev, void *vaddr,
 		dma_addr_t dma_addr)
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index dea50355f6e8..842b2c7e156a 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -409,6 +409,8 @@ config NOT_COHERENT_CACHE
 	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
 		GAMECUBE_COMMON || AMIGAONE
 	select ARCH_HAS_DMA_COHERENT_TO_PFN
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	default n if PPC_47x
 	default y
 
-- 
2.20.1

