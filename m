Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B46C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:50:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C68B2222BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pAqGWcIB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C68B2222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zsBx5gdvzDqGQ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:50:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="pAqGWcIB"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7m6VhmzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ujUXJnOJMsj4fPQfSSbff7kUSx0US05+xoBpoTGcrfE=; b=pAqGWcIBOGwQTW2q9QIhT1NiFf
 us0Zz2APTTGGh6uGnjQqxAMqOPpwaroDA4pN5JqSFReH+Yc4DLVqogZRleJ3jDusSUN0JOj2uO0qm
 VId3K6v2RYeXKx7mn7PuVEU4Ag+B0rf796gZBVp/cXqrOepaFpmMwsekmCni0wXZEN0AM8QMniSBZ
 UZkbq3U0Rph6nzqYJ4+sa6GT2eT14G1YgHXjsT7Wf3jz/UimxbXYEVSA5m+s+b9ZddJRZP/yFuESC
 djErn2a8spag6YvXuiHbBqbOoEs5Oz+5OwYpRy9mNZtArYY+lhRXvjPYT5eYfi4u2X0o0QVmfo86H
 TShC64jQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYv-0000WK-K4; Wed, 13 Feb 2019 07:02:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 23/32] powerpc/dma: remove dma_nommu_mmap_coherent
Date: Wed, 13 Feb 2019 08:01:24 +0100
Message-Id: <20190213070133.11259-24-hch@lst.de>
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

The coherent cache version of this function already is functionally
identicall to the default version, and by defining the
arch_dma_coherent_to_pfn hook the same is ture for the noncoherent
version as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-mapping.h |  4 ----
 arch/powerpc/kernel/dma-iommu.c        |  1 -
 arch/powerpc/kernel/dma-swiotlb.c      |  1 -
 arch/powerpc/kernel/dma.c              | 19 -------------------
 arch/powerpc/mm/dma-noncoherent.c      |  7 +++++--
 arch/powerpc/platforms/Kconfig.cputype |  1 +
 arch/powerpc/platforms/pseries/vio.c   |  1 -
 7 files changed, 6 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 16d45518d9bb..f19c486e7b3f 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -25,10 +25,6 @@ extern void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 extern void __dma_nommu_free_coherent(struct device *dev, size_t size,
 				       void *vaddr, dma_addr_t dma_handle,
 				       unsigned long attrs);
-extern int dma_nommu_mmap_coherent(struct device *dev,
-				    struct vm_area_struct *vma,
-				    void *cpu_addr, dma_addr_t handle,
-				    size_t size, unsigned long attrs);
 int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction direction,
 		unsigned long attrs);
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 5a0b5e863b08..ed8b60829a90 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -167,7 +167,6 @@ u64 dma_iommu_get_required_mask(struct device *dev)
 const struct dma_map_ops dma_iommu_ops = {
 	.alloc			= dma_iommu_alloc_coherent,
 	.free			= dma_iommu_free_coherent,
-	.mmap			= dma_nommu_mmap_coherent,
 	.map_sg			= dma_iommu_map_sg,
 	.unmap_sg		= dma_iommu_unmap_sg,
 	.dma_supported		= dma_iommu_dma_supported,
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index 0e21c318300e..d5950a0cb758 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -34,7 +34,6 @@ unsigned int ppc_swiotlb_enable;
 const struct dma_map_ops powerpc_swiotlb_dma_ops = {
 	.alloc = __dma_nommu_alloc_coherent,
 	.free = __dma_nommu_free_coherent,
-	.mmap = dma_nommu_mmap_coherent,
 	.map_sg = dma_direct_map_sg,
 	.unmap_sg = dma_direct_unmap_sg,
 	.dma_supported = swiotlb_dma_supported,
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 10fa4e18b4e9..841c43355a7e 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -114,24 +114,6 @@ void __dma_nommu_free_coherent(struct device *dev, size_t size,
 }
 #endif /* !CONFIG_NOT_COHERENT_CACHE */
 
-int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
-			     void *cpu_addr, dma_addr_t handle, size_t size,
-			     unsigned long attrs)
-{
-	unsigned long pfn;
-
-#ifdef CONFIG_NOT_COHERENT_CACHE
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	pfn = __dma_get_coherent_pfn((unsigned long)cpu_addr);
-#else
-	pfn = page_to_pfn(virt_to_page(cpu_addr));
-#endif
-	return remap_pfn_range(vma, vma->vm_start,
-			       pfn + vma->vm_pgoff,
-			       vma->vm_end - vma->vm_start,
-			       vma->vm_page_prot);
-}
-
 int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 		int nents, enum dma_data_direction direction,
 		unsigned long attrs)
@@ -218,7 +200,6 @@ static inline void dma_nommu_sync_single(struct device *dev,
 const struct dma_map_ops dma_nommu_ops = {
 	.alloc				= __dma_nommu_alloc_coherent,
 	.free				= __dma_nommu_free_coherent,
-	.mmap				= dma_nommu_mmap_coherent,
 	.map_sg				= dma_nommu_map_sg,
 	.unmap_sg			= dma_nommu_unmap_sg,
 	.dma_supported			= dma_nommu_dma_supported,
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
index e955539686a4..ee95da19c82d 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -30,6 +30,7 @@
 #include <linux/types.h>
 #include <linux/highmem.h>
 #include <linux/dma-direct.h>
+#include <linux/dma-noncoherent.h>
 #include <linux/export.h>
 
 #include <asm/tlbflush.h>
@@ -400,14 +401,16 @@ EXPORT_SYMBOL(__dma_sync_page);
 
 /*
  * Return the PFN for a given cpu virtual address returned by
- * __dma_nommu_alloc_coherent. This is used by dma_mmap_coherent()
+ * __dma_nommu_alloc_coherent.
  */
-unsigned long __dma_get_coherent_pfn(unsigned long cpu_addr)
+long arch_dma_coherent_to_pfn(struct device *dev, void *vaddr,
+		dma_addr_t dma_addr)
 {
 	/* This should always be populated, so we don't test every
 	 * level. If that fails, we'll have a nice crash which
 	 * will be as good as a BUG_ON()
 	 */
+	unsigned long cpu_addr = (unsigned long)vaddr;
 	pgd_t *pgd = pgd_offset_k(cpu_addr);
 	pud_t *pud = pud_offset(pgd, cpu_addr);
 	pmd_t *pmd = pmd_offset(pud, cpu_addr);
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 7c544607ba32..dea50355f6e8 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -408,6 +408,7 @@ config NOT_COHERENT_CACHE
 	bool
 	depends on 4xx || PPC_8xx || E200 || PPC_MPC512x || \
 		GAMECUBE_COMMON || AMIGAONE
+	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	default n if PPC_47x
 	default y
 
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/pseries/vio.c
index 7870bf99168c..b7dc8bd41fd0 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -603,7 +603,6 @@ static void vio_dma_iommu_unmap_sg(struct device *dev,
 static const struct dma_map_ops vio_dma_mapping_ops = {
 	.alloc             = vio_dma_iommu_alloc_coherent,
 	.free              = vio_dma_iommu_free_coherent,
-	.mmap		   = dma_nommu_mmap_coherent,
 	.map_sg            = vio_dma_iommu_map_sg,
 	.unmap_sg          = vio_dma_iommu_unmap_sg,
 	.map_page          = vio_dma_iommu_map_page,
-- 
2.20.1

