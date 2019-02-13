Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 318C7C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:42:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A246D21904
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R9BvU+rS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A246D21904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zs1J4BRMzDqSc
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:42:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="R9BvU+rS"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7l2QBbzDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=trbd6cg4F+mafDtD6lzbWwOTuAfjWQjkxgAmq1QJDKk=; b=R9BvU+rS41m0zmbJ9PK6nO8sFy
 h12/CVLObarS0V/Axg9efnL6TGc9Ytaycrt0tmaa0Bz/T1aIpccfnV1w/m1TX4Ruigbus/hYXEB+L
 jRi4PBHtDtYrXg7TbA4LX44cvhceVQqynHftjIvv0nWU0YGpKXQ01RlFvLRq2JBbKoEK+UY7v/7Lk
 tNiwiQXsZlr1NfrlcpkI6rEchL7JIRyqI6G3lo3KeACkRFTj8TRyj7/pGazGyUPQ1ZBw1IB0v3cUx
 S10bLvOswMNibavWPV7ZA6DESJAL3kRC9M07R2j4O1ZSM4Rf46vbhxQIJvJjUGGEmBVBWF1fGcc3V
 /SW18oTA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYy-0000eL-16; Wed, 13 Feb 2019 07:02:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 24/32] powerpc/dma: remove dma_nommu_get_required_mask
Date: Wed, 13 Feb 2019 08:01:25 +0100
Message-Id: <20190213070133.11259-25-hch@lst.de>
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

This function is identical to the generic dma_direct_get_required_mask,
except that the generic version also takes the bus_dma_mask account,
which could lead to incorrect results in the powerpc version.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/dma-mapping.h |  1 -
 arch/powerpc/kernel/dma-iommu.c        |  2 +-
 arch/powerpc/kernel/dma.c              | 14 +-------------
 3 files changed, 2 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index f19c486e7b3f..af9a32d4fcf8 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -32,7 +32,6 @@ dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs);
 int dma_nommu_dma_supported(struct device *dev, u64 mask);
-u64 dma_nommu_get_required_mask(struct device *dev);
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
 /*
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index ed8b60829a90..4377b69a9d42 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -152,7 +152,7 @@ u64 dma_iommu_get_required_mask(struct device *dev)
 		return 0;
 
 	if (dev_is_pci(dev)) {
-		u64 bypass_mask = dma_nommu_get_required_mask(dev);
+		u64 bypass_mask = dma_direct_get_required_mask(dev);
 
 		if (dma_iommu_bypass_supported(dev, bypass_mask))
 			return bypass_mask;
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 841c43355a7e..46afc66cc271 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -145,18 +145,6 @@ static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sgl,
 		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
 }
 
-u64 dma_nommu_get_required_mask(struct device *dev)
-{
-	u64 end, mask;
-
-	end = memblock_end_of_DRAM() + get_dma_offset(dev);
-
-	mask = 1ULL << (fls64(end) - 1);
-	mask += mask - 1;
-
-	return mask;
-}
-
 dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -205,7 +193,7 @@ const struct dma_map_ops dma_nommu_ops = {
 	.dma_supported			= dma_nommu_dma_supported,
 	.map_page			= dma_nommu_map_page,
 	.unmap_page			= dma_nommu_unmap_page,
-	.get_required_mask		= dma_nommu_get_required_mask,
+	.get_required_mask		= dma_direct_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.sync_single_for_cpu 		= dma_nommu_sync_single,
 	.sync_single_for_device 	= dma_nommu_sync_single,
-- 
2.20.1

