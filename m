Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A14FC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 09:04:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5CB214F1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 09:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XiGBxgN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5CB214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vz8F67xMzF3SP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 20:04:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="XiGBxgN2";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+ddbc6e1cf1a82b64ebec+5561+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="XiGBxgN2"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vyG13CTrzF3K4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 19:24:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U3AJVDgY7XuDB+uN8B5PkwdNEKibAyA0Ka6h55RxO5k=; b=XiGBxgN2eKtxJsWFuzvC+jeg4e
 /cs0ZZNcpRMv/fnUGOG7KbcOgzC2dKtWavh8tOfLf85gcmRAkMMvbvgFsAemCputGWkG6wlyhs/dC
 ILjbu44T9c+awsmcElJ6dYcq5bvkR5SABeAkavHyGfzpL/G2gzKeaSBcEEYK+weTmUYuAw0DrMiqU
 8330h8FSe1EJv2JrRmVibu2UZtHK4mxP4RNdSzJxswt89Dfde5vsdi0Ib3EsifgCt62wGQMK3wXv7
 5QnB6mI7vOXQgmd7xOsgU0R/popvz+lJDlAAEVGxZpq1OaXZmUJgy5pLkdh+WmVk7No1S+1o6MJhk
 iL2fHm4w==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMqTA-00050j-OZ; Wed, 14 Nov 2018 08:24:17 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 22/34] powerpc/dma: remove the iommu fallback for coherent
 allocations
Date: Wed, 14 Nov 2018 09:23:02 +0100
Message-Id: <20181114082314.8965-23-hch@lst.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114082314.8965-1-hch@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

All iommu capable platforms now always use the iommu code with the
internal bypass, so there is not need for this magic anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig      |  4 ---
 arch/powerpc/kernel/dma.c | 68 ++-------------------------------------
 2 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index cffff3613bc1..2d4a19bc8023 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -119,9 +119,6 @@ config GENERIC_HWEIGHT
 	bool
 	default y
 
-config ARCH_HAS_DMA_SET_COHERENT_MASK
-        bool
-
 config PPC
 	bool
 	default y
@@ -129,7 +126,6 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
-	select ARCH_HAS_DMA_SET_COHERENT_MASK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 829eb2fefc8c..f9f51fc505a1 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -114,51 +114,6 @@ void __dma_nommu_free_coherent(struct device *dev, size_t size,
 }
 #endif /* !CONFIG_NOT_COHERENT_CACHE */
 
-static void *dma_nommu_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t *dma_handle, gfp_t flag,
-				       unsigned long attrs)
-{
-	struct iommu_table *iommu;
-
-	/* The coherent mask may be smaller than the real mask, check if
-	 * we can really use the direct ops
-	 */
-	if (dma_nommu_dma_supported(dev, dev->coherent_dma_mask))
-		return __dma_nommu_alloc_coherent(dev, size, dma_handle,
-						   flag, attrs);
-
-	/* Ok we can't ... do we have an iommu ? If not, fail */
-	iommu = get_iommu_table_base(dev);
-	if (!iommu)
-		return NULL;
-
-	/* Try to use the iommu */
-	return iommu_alloc_coherent(dev, iommu, size, dma_handle,
-				    dev->coherent_dma_mask, flag,
-				    dev_to_node(dev));
-}
-
-static void dma_nommu_free_coherent(struct device *dev, size_t size,
-				     void *vaddr, dma_addr_t dma_handle,
-				     unsigned long attrs)
-{
-	struct iommu_table *iommu;
-
-	/* See comments in dma_nommu_alloc_coherent() */
-	if (dma_nommu_dma_supported(dev, dev->coherent_dma_mask))
-		return __dma_nommu_free_coherent(dev, size, vaddr, dma_handle,
-						  attrs);
-	/* Maybe we used an iommu ... */
-	iommu = get_iommu_table_base(dev);
-
-	/* If we hit that we should have never allocated in the first
-	 * place so how come we are freeing ?
-	 */
-	if (WARN_ON(!iommu))
-		return;
-	iommu_free_coherent(iommu, size, vaddr, dma_handle);
-}
-
 int dma_nommu_mmap_coherent(struct device *dev, struct vm_area_struct *vma,
 			     void *cpu_addr, dma_addr_t handle, size_t size,
 			     unsigned long attrs)
@@ -240,8 +195,8 @@ static inline void dma_nommu_sync_single(struct device *dev,
 #endif
 
 const struct dma_map_ops dma_nommu_ops = {
-	.alloc				= dma_nommu_alloc_coherent,
-	.free				= dma_nommu_free_coherent,
+	.alloc				= __dma_nommu_alloc_coherent,
+	.free				= __dma_nommu_free_coherent,
 	.mmap				= dma_nommu_mmap_coherent,
 	.map_sg				= dma_nommu_map_sg,
 	.dma_supported			= dma_nommu_dma_supported,
@@ -255,25 +210,6 @@ const struct dma_map_ops dma_nommu_ops = {
 };
 EXPORT_SYMBOL(dma_nommu_ops);
 
-int dma_set_coherent_mask(struct device *dev, u64 mask)
-{
-	if (!dma_supported(dev, mask)) {
-		/*
-		 * We need to special case the direct DMA ops which can
-		 * support a fallback for coherent allocations. There
-		 * is no dma_op->set_coherent_mask() so we have to do
-		 * things the hard way:
-		 */
-		if (get_dma_ops(dev) != &dma_nommu_ops ||
-		    get_iommu_table_base(dev) == NULL ||
-		    !dma_iommu_dma_supported(dev, mask))
-			return -EIO;
-	}
-	dev->coherent_dma_mask = mask;
-	return 0;
-}
-EXPORT_SYMBOL(dma_set_coherent_mask);
-
 int dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	if (ppc_md.dma_set_mask)
-- 
2.19.1

