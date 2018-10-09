Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56109C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:27:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC31F213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PEtGZznv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC31F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V01g19xbzF3FC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 01:27:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="PEtGZznv";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+39c443e67938b060f200+5525+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="PEtGZznv"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tyg965FFzF38J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:26:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5zhArYVOfpz3UhaczPVMIKMuoMp45C3OR3JQcBbTR4Q=; b=PEtGZznvqjw8wP1A7IE3s7HgqV
 Decd25/6zt9jn4oWWFRxPmPK4LgotMOtwUgznAoFNeRbLrz/ug+wyEKCPIcF8WwlxqdyVO59W9yDE
 SKC/H5Ajlt6IlmlXMXFY/7a5Y06GWXqghS2wIrFZf9/O/IuZf/ay77uUu0cv3mycX3mvSnl8EnBCh
 gerYHus3pBh9CkGKEgQybx44AxRQ1erJlyA7MM86Ml/ravdyD4DQ3CUa09sY0pCH5LUFYj0o3aKqP
 IsilkrZNkNMGCo6dspHltDxM3yX7cNLTTb5mVYjMrkf+VCORu/lPswZCu987zHcheUK4F8UI9rvBi
 QD7c1j/A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s1d-0001Y9-ME; Tue, 09 Oct 2018 13:26:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 28/33] powerpc/dma: use phys_to_dma instead of get_dma_offset
Date: Tue,  9 Oct 2018 15:24:55 +0200
Message-Id: <20181009132500.17643-29-hch@lst.de>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181009132500.17643-1-hch@lst.de>
References: <20181009132500.17643-1-hch@lst.de>
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

Use the standard portable helper instead of the powerpc specific one,
which is about to go away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/dma-swiotlb.c |  2 +-
 arch/powerpc/kernel/dma.c         | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index dba216dd70fd..d33caff8c684 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -11,7 +11,7 @@
  *
  */
 
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/memblock.h>
 #include <linux/pfn.h>
 #include <linux/of_platform.h>
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 795afe387c91..7f7f3a069b63 100644
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
@@ -42,7 +42,7 @@ static u64 __maybe_unused get_pfn_limit(struct device *dev)
 int dma_nommu_dma_supported(struct device *dev, u64 mask)
 {
 #ifdef CONFIG_PPC64
-	u64 limit = get_dma_offset(dev) + (memblock_end_of_DRAM() - 1);
+	u64 limit = phys_to_dma(dev, (memblock_end_of_DRAM() - 1));
 
 	/* Limit fits in the mask, we are good */
 	if (mask >= limit)
@@ -100,7 +100,7 @@ void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	ret = page_address(page);
 	memset(ret, 0, size);
-	*dma_handle = __pa(ret) + get_dma_offset(dev);
+	*dma_handle = phys_to_dma(dev,__pa(ret));
 
 	return ret;
 }
@@ -139,7 +139,7 @@ int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = sg_phys(sg) + get_dma_offset(dev);
+		sg->dma_address = phys_to_dma(dev, sg_phys(sg));
 		sg->dma_length = sg->length;
 
 		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
@@ -158,7 +158,7 @@ dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		__dma_sync_page(page, offset, size, dir);
 
-	return page_to_phys(page) + offset + get_dma_offset(dev);
+	return phys_to_dma(dev, page_to_phys(page)) + offset;
 }
 
 #ifdef CONFIG_NOT_COHERENT_CACHE
-- 
2.19.0

