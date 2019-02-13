Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFEA8C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:26:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D79C222B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tmiq2Erq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D79C222B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zrfy11LJzDqRk
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:26:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="tmiq2Erq"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7M0xPdzDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oftqg/DLnlA4XOQDc02Y6qXG24fb6uUpb//RA0foQtI=; b=tmiq2Erql840y6jWpuiCtwJ5l/
 9KYy8hJZZR47nCaUAldopA4uOgw5koo/sMGnt+yyGvvfiyccbUc5OqEywjKRKCPLcc0kBx7iQK5VH
 RXJzk2dWMyXOmEvZQIcdq/u2eKVtY43cLPrTLKNvMF38iK8d0M/aAKxEuPB+GjTa1h94/QO58HJtG
 PSyr8ywq56Cq8zPkphAY9h22CJ9fpv76N3encArGpl37j0M3TQsRFr6+Ut5zId18GQsB/UpuokzC/
 XlE93qfoNCom58JvVNQ6gPBhLwH4grGWvSss59ESbg2r436Kp9t0/C6X9w8ZV0MQpkSNeo2AnrnUL
 /AQGEnOw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYS-0000IR-Oz; Wed, 13 Feb 2019 07:02:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 11/32] powerpc/powernv: remove pnv_pci_ioda_pe_single_vendor
Date: Wed, 13 Feb 2019 08:01:12 +0100
Message-Id: <20190213070133.11259-12-hch@lst.de>
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
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This function is completely bogus - the fact that two PCIe devices come
from the same vendor has absolutely nothing to say about the DMA
capabilities and characteristics.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 28 ++---------------------
 1 file changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 53982f887a7f..d9060a0f4c8e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1756,31 +1756,6 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 	 */
 }
 
-static bool pnv_pci_ioda_pe_single_vendor(struct pnv_ioda_pe *pe)
-{
-	unsigned short vendor = 0;
-	struct pci_dev *pdev;
-
-	if (pe->device_count == 1)
-		return true;
-
-	/* pe->pdev should be set if it's a single device, pe->pbus if not */
-	if (!pe->pbus)
-		return true;
-
-	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
-		if (!vendor) {
-			vendor = pdev->vendor;
-			continue;
-		}
-
-		if (pdev->vendor != vendor)
-			return false;
-	}
-
-	return true;
-}
-
 /*
  * Reconfigure TVE#0 to be usable as 64-bit DMA space.
  *
@@ -1881,7 +1856,8 @@ static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
 		 */
 		if (dma_mask >> 32 &&
 		    dma_mask > (memory_hotplug_max() + (1ULL << 32)) &&
-		    pnv_pci_ioda_pe_single_vendor(pe) &&
+		    /* pe->pdev should be set if it's a single device, pe->pbus if not */
+		    (pe->device_count == 1 || !pe->pbus) &&
 		    phb->model == PNV_PHB_MODEL_PHB3) {
 			/* Configure the bypass mode */
 			rc = pnv_pci_ioda_dma_64bit_bypass(pe);
-- 
2.20.1

