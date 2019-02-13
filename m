Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DC8C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:46:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E89BA222BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nh6AWLdh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89BA222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zs6d5slpzDqSF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:46:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Nh6AWLdh"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7l6SlyzDqHL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6WQFL3C23zajiNfd0kAqIeZVSaZbYE4kbbquM/AFGS8=; b=Nh6AWLdhKTA+H+35V3Y9F5RVff
 skGBg3zzTKKCnD271HT6SldgKbJmfhFTdcZxKzjoGtZ13CMSGSx+bu3FSzkCMbeFqubjDP7Sqd5Rl
 9KhJ9ZVAJZgFAr8LxQ4Tk7COLMMtpbAwe4Dc8hQ3Gk+tvsy+nmtPRxQVqewiDvgnSc437hsK9fvVt
 V/HPsxLXp8Q7F0fmCiiuhh2UsZxPOWPXVTl+iV1Orh32JJDKLD5D7GWLbHlu63hGVJL46pCXDGsyt
 fPxlaSR+2LfVohQmfyHivc+i/sbrhqVjpZgCclBwI7firSJ2owWZN5vyxRAYh1412nuOLjfXI3EVa
 XIk9hkDQ==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoZ0-0000ho-Dz; Wed, 13 Feb 2019 07:02:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 25/32] powerpc/dma: remove dma_nommu_dma_supported
Date: Wed, 13 Feb 2019 08:01:26 +0100
Message-Id: <20190213070133.11259-26-hch@lst.de>
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

This function is largely identical to the generic version used
everywhere else.  Replace it with the generic version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-mapping.h |  1 -
 arch/powerpc/kernel/dma-iommu.c        |  2 +-
 arch/powerpc/kernel/dma.c              | 25 +------------------------
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index af9a32d4fcf8..cdf70aaeafeb 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -31,7 +31,6 @@ int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
-int dma_nommu_dma_supported(struct device *dev, u64 mask);
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
 /*
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 4377b69a9d42..67fbfaa4e3b2 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -21,7 +21,7 @@
 static inline bool dma_iommu_alloc_bypass(struct device *dev)
 {
 	return dev->archdata.iommu_bypass && !iommu_fixed_is_weak &&
-		dma_nommu_dma_supported(dev, dev->coherent_dma_mask);
+		dma_direct_supported(dev, dev->coherent_dma_mask);
 }
 
 static inline bool dma_iommu_map_bypass(struct device *dev,
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 46afc66cc271..a3546a82f6d7 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -39,29 +39,6 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
 	return pfn;
 }
 
-int dma_nommu_dma_supported(struct device *dev, u64 mask)
-{
-#ifdef CONFIG_PPC64
-	u64 limit = phys_to_dma(dev, (memblock_end_of_DRAM() - 1));
-
-	/* Limit fits in the mask, we are good */
-	if (mask >= limit)
-		return 1;
-
-#ifdef CONFIG_FSL_SOC
-	/*
-	 * Freescale gets another chance via ZONE_DMA, however
-	 * that will have to be refined if/when they support iommus
-	 */
-	return 1;
-#endif
-	/* Sorry ... */
-	return 0;
-#else
-	return 1;
-#endif
-}
-
 #ifndef CONFIG_NOT_COHERENT_CACHE
 void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 				  dma_addr_t *dma_handle, gfp_t flag,
@@ -190,7 +167,7 @@ const struct dma_map_ops dma_nommu_ops = {
 	.free				= __dma_nommu_free_coherent,
 	.map_sg				= dma_nommu_map_sg,
 	.unmap_sg			= dma_nommu_unmap_sg,
-	.dma_supported			= dma_nommu_dma_supported,
+	.dma_supported			= dma_direct_supported,
 	.map_page			= dma_nommu_map_page,
 	.unmap_page			= dma_nommu_unmap_page,
 	.get_required_mask		= dma_direct_get_required_mask,
-- 
2.20.1

