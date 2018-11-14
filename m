Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6956EC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 09:11:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB1BC22360
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 09:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pOLfihGi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB1BC22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vzJH0BcZzF37J
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 20:11:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="pOLfihGi";
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
 header.b="pOLfihGi"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vyG71JblzF3K7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 19:24:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k2PN9Oa8YSIvjJVRt3mNzWxL4HQYVzsgYlk0h0MWqTE=; b=pOLfihGiHCs6K+Lok6Fb6Er5Vq
 ZGkVaVy4A23W0HzSF+rfRnDt3vNd+f8arpEEN5rKsUm1xPugb/ju1c/nE/XmoVi2P/tdeOFSV/e40
 Xc5n/3R0c1ozaCtVqWS+ZEgKQFB8yZfuwO+A1t5jBslTD/94pkbNh7BuoHNi6aiZFSaeEzcObxGBl
 +ezwjHJ1zGQCPGX1cx/UJ6eJpDUSaKZZwdXP3f/h6HpcKwQV8fMg/lSbLLMi+hIXF5HQsNgwGbpPU
 JCGAmPHk66BWsgAlj++QBK/KcugEmX8ZTfxCkewt7Dwjru2mXCMDpmVzeYt3To7sje3VKuZFGhAT1
 Jj2zJBzw==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMqT2-0004yA-Jz; Wed, 14 Nov 2018 08:24:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 19/34] cxl: drop the dma_set_mask callback from vphb
Date: Wed, 14 Nov 2018 09:22:59 +0100
Message-Id: <20181114082314.8965-20-hch@lst.de>
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

The CXL code never even looks at the dma mask, so there is no good
reason for this sanity check.  Remove it because it gets in the way
of the dma ops refactoring.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/misc/cxl/vphb.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 7908633d9204..49da2f744bbf 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -11,17 +11,6 @@
 #include <misc/cxl.h>
 #include "cxl.h"
 
-static int cxl_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
-{
-	if (dma_mask < DMA_BIT_MASK(64)) {
-		pr_info("%s only 64bit DMA supported on CXL", __func__);
-		return -EIO;
-	}
-
-	*(pdev->dev.dma_mask) = dma_mask;
-	return 0;
-}
-
 static int cxl_pci_probe_mode(struct pci_bus *bus)
 {
 	return PCI_PROBE_NORMAL;
@@ -220,7 +209,6 @@ static struct pci_controller_ops cxl_pci_controller_ops =
 	.reset_secondary_bus = cxl_pci_reset_secondary_bus,
 	.setup_msi_irqs = cxl_setup_msi_irqs,
 	.teardown_msi_irqs = cxl_teardown_msi_irqs,
-	.dma_set_mask = cxl_dma_set_mask,
 };
 
 int cxl_pci_vphb_add(struct cxl_afu *afu)
-- 
2.19.1

