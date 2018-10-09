Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02603C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:49:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6491821479
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tbFfGJFn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6491821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V0Vf58P6zF386
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 01:49:14 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="tbFfGJFn";
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
 header.b="tbFfGJFn"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tyxb1D1szF3D0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:38:58 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sm64G9zOzLTVHztS2JfrA+dPUB2AqgJ3QVy7QL6eQdU=; b=tbFfGJFnfB3JeKmr6eXyJMA2lS
 3iSQtuWsqXxhhGFqjV7CQTDfEvCNa/5HApusniYRWiFIqdjdx54MWVo4zff2QbFa7xbe/NLgeV92g
 Mtkmgq+Oolp3YaJ1tQ3RgGayY64YWelr6rCDdmHceAqGZBrGAjWWBf+LdNsc1F9lL6OALqGwmpkm7
 nCYbtK4S/lcNmsu3Ji/jzhfnbmVVqtGWP6e5mMrkSZkVz9Bhw69XDAz5w4QlGYlpg2y5Okc4c1Mwu
 3OehE8L4l4Ju7IQMR1rzzoaCIPVtKFCjLKOqvrKeFdYSZ0En2BKvYgRoA152b2sgpMDzqumkMYOWT
 GKd+ybGQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s0i-000150-Hp; Tue, 09 Oct 2018 13:25:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 06/33] powerpc/dma: remove the no-op dma_nommu_unmap_{page,
 sg} routines
Date: Tue,  9 Oct 2018 15:24:33 +0200
Message-Id: <20181009132500.17643-7-hch@lst.de>
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

These methods are optional, no need to implement no-op versions.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/dma.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index d6deb458bb91..7078d72baec2 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -197,12 +197,6 @@ static int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static void dma_nommu_unmap_sg(struct device *dev, struct scatterlist *sg,
-				int nents, enum dma_data_direction direction,
-				unsigned long attrs)
-{
-}
-
 static u64 dma_nommu_get_required_mask(struct device *dev)
 {
 	u64 end, mask;
@@ -228,14 +222,6 @@ static inline dma_addr_t dma_nommu_map_page(struct device *dev,
 	return page_to_phys(page) + offset + get_dma_offset(dev);
 }
 
-static inline void dma_nommu_unmap_page(struct device *dev,
-					 dma_addr_t dma_address,
-					 size_t size,
-					 enum dma_data_direction direction,
-					 unsigned long attrs)
-{
-}
-
 #ifdef CONFIG_NOT_COHERENT_CACHE
 static inline void dma_nommu_sync_sg(struct device *dev,
 		struct scatterlist *sgl, int nents,
@@ -261,10 +247,8 @@ const struct dma_map_ops dma_nommu_ops = {
 	.free				= dma_nommu_free_coherent,
 	.mmap				= dma_nommu_mmap_coherent,
 	.map_sg				= dma_nommu_map_sg,
-	.unmap_sg			= dma_nommu_unmap_sg,
 	.dma_supported			= dma_nommu_dma_supported,
 	.map_page			= dma_nommu_map_page,
-	.unmap_page			= dma_nommu_unmap_page,
 	.get_required_mask		= dma_nommu_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.sync_single_for_cpu 		= dma_nommu_sync_single,
-- 
2.19.0

