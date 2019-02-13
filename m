Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3620DC282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:48:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA7F6222BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dApQCyB4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA7F6222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zs8x52llzDqJV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:48:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="dApQCyB4"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7m1xnBzDqNb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gmQMrR+haCPqp7z857Jwdy9jPqpTURnjJVFKc6eiFCc=; b=dApQCyB4TlrqItI6tVCQIvaRDe
 JoEI2lfT5sCouP7x/e5UpdEHCZYg0gDWTNw3cDiTHgiHw6N9C/Z3/2ZASSEIjYt9ntMFurLNbzUcA
 MlIa7rwtA9QxnNpqxU7CdtJUDivmot9kTFL3qdy1/MnL598JUEm9sRGpj50JPkcVYJn+NsVaV1WV0
 oOWXxbDvkJZ2cM03LwEVLf7PW94VO/GaiQDq7ktnnh5BPXs1bGT1N0jYua1umslduC9+7DcM5U1uV
 uMYvRvtUMzHQM9ciHUGkMm5zQxJzewLKOdDNkyC+3qCMR+VEF2Ct6Q2u8YRBcfGo5XJU4vJ1KYbTu
 MkJwaNuA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYt-0000Ta-63; Wed, 13 Feb 2019 07:02:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 22/32] powerpc/dma: use phys_to_dma instead of get_dma_offset
Date: Wed, 13 Feb 2019 08:01:23 +0100
Message-Id: <20190213070133.11259-23-hch@lst.de>
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

Use the standard portable helper instead of the powerpc specific one,
which is about to go away.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/kernel/dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index e422ca65d1cf..10fa4e18b4e9 100644
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
@@ -101,7 +101,7 @@ void *__dma_nommu_alloc_coherent(struct device *dev, size_t size,
 		return NULL;
 	ret = page_address(page);
 	memset(ret, 0, size);
-	*dma_handle = __pa(ret) + get_dma_offset(dev);
+	*dma_handle = phys_to_dma(dev,__pa(ret));
 
 	return ret;
 }
@@ -140,7 +140,7 @@ int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 	int i;
 
 	for_each_sg(sgl, sg, nents, i) {
-		sg->dma_address = sg_phys(sg) + get_dma_offset(dev);
+		sg->dma_address = phys_to_dma(dev, sg_phys(sg));
 		sg->dma_length = sg->length;
 
 		if (attrs & DMA_ATTR_SKIP_CPU_SYNC)
@@ -182,7 +182,7 @@ dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 	if (!(attrs & DMA_ATTR_SKIP_CPU_SYNC))
 		__dma_sync_page(page, offset, size, dir);
 
-	return page_to_phys(page) + offset + get_dma_offset(dev);
+	return phys_to_dma(dev, page_to_phys(page)) + offset;
 }
 
 static inline void dma_nommu_unmap_page(struct device *dev,
-- 
2.20.1

