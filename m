Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03341C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:29:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E83222BE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t/cXSGyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E83222BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zrkP43gwzDqHX
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:29:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="t/cXSGyh"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7R6RghzDqHX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YMKgdeCFzRRsjQmXzBPgxCdS4et9FtXuG0XYXLckdeE=; b=t/cXSGyhIVJRa5ozQXMKJ5k5iZ
 Gxdep5/rSCZyGb6zcKsfPepJaUqNdb4FIC4maQt4ONOI20p0+AfdCqfCyMvfrdxMPUYB5TGiuIwL4
 Amvh6fESZzMm93WSfVfn0Su4aOZMo0DaznAmbF3U5eJIko6nKo4KSCTbC2e6A+FJrw//tDhXm4J7m
 zY3E0tlUYHz2eS1cINScgiQyC1NDJT7Bz8c6QuG4rY6DnMVJLURgNnY9bMa2F6sasyhN8P8oeKJa2
 v6K08dsxghKppE+vqJaVxU0J3jxcJe7+3f545r3QF88mYtCQcsZd4AQprfl9ZQeUpKNtEkffJEV3y
 pYsXkTyw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYX-0000JG-HS; Wed, 13 Feb 2019 07:02:05 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 13/32] powerpc/powernv: use the generic iommu bypass code
Date: Wed, 13 Feb 2019 08:01:14 +0100
Message-Id: <20190213070133.11259-14-hch@lst.de>
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

Use the generic iommu bypass code instead of overriding set_dma_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 95 ++++++-----------------
 1 file changed, 25 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 23ffbc71589a..9a1db2de9605 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1825,89 +1825,45 @@ static int pnv_pci_ioda_dma_64bit_bypass(struct pnv_ioda_pe *pe)
 	return -EIO;
 }
 
-static int pnv_pci_ioda_dma_set_mask(struct pci_dev *pdev, u64 dma_mask)
+static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
+		u64 dma_mask)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
 	struct pci_dn *pdn = pci_get_pdn(pdev);
 	struct pnv_ioda_pe *pe;
-	uint64_t top;
-	bool bypass = false;
-	s64 rc;
 
 	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
 		return -ENODEV;
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	if (pe->tce_bypass_enabled) {
-		top = pe->tce_bypass_base + memblock_end_of_DRAM() - 1;
-		bypass = (dma_mask >= top);
+		u64 top = pe->tce_bypass_base + memblock_end_of_DRAM() - 1;
+		if (dma_mask >= top)
+			return true;
 	}
 
-	if (bypass) {
-		dev_info(&pdev->dev, "Using 64-bit DMA iommu bypass\n");
-		set_dma_ops(&pdev->dev, &dma_nommu_ops);
-	} else {
-		/*
-		 * If the device can't set the TCE bypass bit but still wants
-		 * to access 4GB or more, on PHB3 we can reconfigure TVE#0 to
-		 * bypass the 32-bit region and be usable for 64-bit DMAs.
-		 * The device needs to be able to address all of this space.
-		 */
-		if (dma_mask >> 32 &&
-		    dma_mask > (memory_hotplug_max() + (1ULL << 32)) &&
-		    /* pe->pdev should be set if it's a single device, pe->pbus if not */
-		    (pe->device_count == 1 || !pe->pbus) &&
-		    phb->model == PNV_PHB_MODEL_PHB3) {
-			/* Configure the bypass mode */
-			rc = pnv_pci_ioda_dma_64bit_bypass(pe);
-			if (rc)
-				return rc;
-			/* 4GB offset bypasses 32-bit space */
-			set_dma_offset(&pdev->dev, (1ULL << 32));
-			set_dma_ops(&pdev->dev, &dma_nommu_ops);
-		} else if (dma_mask >> 32 && dma_mask != DMA_BIT_MASK(64)) {
-			/*
-			 * Fail the request if a DMA mask between 32 and 64 bits
-			 * was requested but couldn't be fulfilled. Ideally we
-			 * would do this for 64-bits but historically we have
-			 * always fallen back to 32-bits.
-			 */
-			return -ENOMEM;
-		} else {
-			dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
-			set_dma_ops(&pdev->dev, &dma_iommu_ops);
-		}
+	/*
+	 * If the device can't set the TCE bypass bit but still wants
+	 * to access 4GB or more, on PHB3 we can reconfigure TVE#0 to
+	 * bypass the 32-bit region and be usable for 64-bit DMAs.
+	 * The device needs to be able to address all of this space.
+	 */
+	if (dma_mask >> 32 &&
+	    dma_mask > (memory_hotplug_max() + (1ULL << 32)) &&
+	    /* pe->pdev should be set if it's a single device, pe->pbus if not */
+	    (pe->device_count == 1 || !pe->pbus) &&
+	    phb->model == PNV_PHB_MODEL_PHB3) {
+		/* Configure the bypass mode */
+		s64 rc = pnv_pci_ioda_dma_64bit_bypass(pe);
+		if (rc)
+			return rc;
+		/* 4GB offset bypasses 32-bit space */
+		set_dma_offset(&pdev->dev, (1ULL << 32));
+		return true;
 	}
-	*pdev->dev.dma_mask = dma_mask;
-
-	/* Update peer npu devices */
-	pnv_npu_try_dma_set_bypass(pdev, bypass);
-
-	return 0;
-}
-
-static u64 pnv_pci_ioda_dma_get_required_mask(struct pci_dev *pdev)
-{
-	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	struct pci_dn *pdn = pci_get_pdn(pdev);
-	struct pnv_ioda_pe *pe;
-	u64 end, mask;
 
-	if (WARN_ON(!pdn || pdn->pe_number == IODA_INVALID_PE))
-		return 0;
-
-	pe = &phb->ioda.pe_array[pdn->pe_number];
-	if (!pe->tce_bypass_enabled)
-		return __dma_get_required_mask(&pdev->dev);
-
-
-	end = pe->tce_bypass_base + memblock_end_of_DRAM();
-	mask = 1ULL << (fls64(end) - 1);
-	mask += mask - 1;
-
-	return mask;
+	return false;
 }
 
 static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
@@ -3634,6 +3590,7 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 	.dma_bus_setup		= pnv_pci_dma_bus_setup,
+	.iommu_bypass_supported	= pnv_pci_ioda_iommu_bypass_supported,
 	.setup_msi_irqs		= pnv_setup_msi_irqs,
 	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
 	.enable_device_hook	= pnv_pci_enable_device_hook,
@@ -3641,8 +3598,6 @@ static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.window_alignment	= pnv_pci_window_alignment,
 	.setup_bridge		= pnv_pci_setup_bridge,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
-	.dma_set_mask		= pnv_pci_ioda_dma_set_mask,
-	.dma_get_required_mask	= pnv_pci_ioda_dma_get_required_mask,
 	.shutdown		= pnv_pci_ioda_shutdown,
 };
 
-- 
2.20.1

