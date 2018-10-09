Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1736BC64EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 13:45:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6D42086D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 13:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Io5Mbc2M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6D42086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tz4Y2yV4zDqNG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 00:45:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="Io5Mbc2M";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=198.137.202.133;
 helo=bombadil.infradead.org;
 envelope-from=batv+39c443e67938b060f200+5525+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from bombadil.infradead.org (bombadil.infradead.org
 [198.137.202.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TyfQ2phvzF38V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:25:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pgdEXC/sHHUjWFtFn1VF7InKvXmUXueeyx2znGokKV8=; b=Io5Mbc2M9Xbt6IT198HDwBTfJs
 upqerTOm4EpX0USVYJgiDSzsVzlreExWfkJ+Ygi7qfp6CS4pMsqwelPzA4pzOvHLnJDod1pkNSwvV
 UGB8MBaqeDOkVhwqrsZXrQ0l889Sgl4l8oqtwJI5JWklfxA5TUECat72Emj/oJE++KPJSrJFplFlU
 r0Q7FQ74IvEqbMcR5xYD8YymdUNnqu9aKx0FzrkIzCnot1Wt1G2+oFiMRqR32zkiIKK+iFQ2ug3m2
 cE61hN5wQmsF9NoWJGr9WrNkqYDYKAuv0/eIbXKYwM4mF9Ln5/fHdYYB6ycVbxU2Rt9++tnTozvoe
 +lgilGiQ==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s0u-00019t-Br; Tue, 09 Oct 2018 13:25:28 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 11/33] powerpc/cell: move dma direct window setup out of
 dma_configure
Date: Tue,  9 Oct 2018 15:24:38 +0200
Message-Id: <20181009132500.17643-12-hch@lst.de>
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

Configure the dma settings at device setup time, and stop playing games
with get_pci_dma_ops.  This prepares for using the common dma_configure
code later on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/cell/iommu.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 12352a58072a..cce5bf9515e5 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -657,14 +657,21 @@ static const struct dma_map_ops dma_iommu_fixed_ops = {
 	.mapping_error	= dma_iommu_mapping_error,
 };
 
+static u64 cell_iommu_get_fixed_address(struct device *dev);
+
 static void cell_dma_dev_setup(struct device *dev)
 {
-	if (get_pci_dma_ops() == &dma_iommu_ops)
+	if (get_pci_dma_ops() == &dma_iommu_ops) {
+		u64 addr = cell_iommu_get_fixed_address(dev);
+
+		if (addr != OF_BAD_ADDR)
+			set_dma_offset(dev, addr + dma_iommu_fixed_base);
 		set_iommu_table_base(dev, cell_get_iommu_table(dev));
-	else if (get_pci_dma_ops() == &dma_nommu_ops)
+	} else if (get_pci_dma_ops() == &dma_nommu_ops) {
 		set_dma_offset(dev, cell_dma_nommu_offset);
-	else
+	} else {
 		BUG();
+	}
 }
 
 static void cell_pci_dma_dev_setup(struct pci_dev *dev)
@@ -950,19 +957,14 @@ static int dma_suported_and_switch(struct device *dev, u64 dma_mask)
 {
 	if (dma_mask == DMA_BIT_MASK(64) &&
 	    cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR) {
-		u64 addr = cell_iommu_get_fixed_address(dev) +
-			dma_iommu_fixed_base;
 		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
-		dev_dbg(dev, "iommu: fixed addr = %llx\n", addr);
 		set_dma_ops(dev, &dma_iommu_fixed_ops);
-		set_dma_offset(dev, addr);
 		return 1;
 	}
 
 	if (dma_iommu_dma_supported(dev, dma_mask)) {
 		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
-		set_dma_ops(dev, get_pci_dma_ops());
-		cell_dma_dev_setup(dev);
+		set_dma_ops(dev, &dma_iommu_ops);
 		return 1;
 	}
 
-- 
2.19.0

