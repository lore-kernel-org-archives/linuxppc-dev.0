Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73CDC64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:22:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4803F213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ad4Bp8Y4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4803F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TzwH2QS4zF3CT
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 01:22:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="Ad4Bp8Y4";
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
 header.b="Ad4Bp8Y4"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tyg13KS5zF38V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:26:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2smE7t1ubnM/aBYiGbsyFVtZBSQMbwLYlNYKOPwJFGE=; b=Ad4Bp8Y4dt+Sx1b+QODbLDE7jW
 qp3pnjRMZpzX4bSQV88DBJK7v7Lgn0m5NOQfgSEZCvvITTzqoNr+CddsojnVnWlmEsB32lIH4sHzz
 V24jwBHBDcpZ5eRtcvXvY0jubjpjqEwHaAILEnL8H+jHXN1JXpjhByXksdT2zV9z9X70sbeIkKtb+
 mrUqpNwE3WbmPAOCLbhFHzWzP/JMJfpERrXPmznPR27oG3IOkfCR8U+dQDnvwDfUZiebEnI+OIUVJ
 XbQr7VAN3MCoQX4trkMweV2hHV8F62mxD9M+2yo+pc5s+DuTf0wB5b/EjlCp25EVPHcySO4Rh14hn
 ze/6Lmog==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s1W-0001TF-8H; Tue, 09 Oct 2018 13:26:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 25/33] cxl: drop the dma_set_mask callback from vphb
Date: Tue,  9 Oct 2018 15:24:52 +0200
Message-Id: <20181009132500.17643-26-hch@lst.de>
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
2.19.0

