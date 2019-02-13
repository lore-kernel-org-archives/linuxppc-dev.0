Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021B4C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:15:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FD74222C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="offfxTOI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FD74222C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zrQp2rJWzDqK9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:15:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="offfxTOI"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr765yPHzDqL7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=14iRwlwGNoZBFUsWPKiWiiozpJu/R4jCHD2X2nnrVGI=; b=offfxTOITEqkPRWqE01KhSsYtz
 1ZjCixEDVEfdHTvFJVh0xa3fMqK0k42OtITTM14bHDNiTEi1JK9i5vQENn3Jypy4ZkIfSeSEBIt6/
 eq01XajRALSh+UkhUXQj4rBfCjN2ugKznkxzrnwcLWlucTJiwOiEoIMb+/YYKk6KxMvWD5slh+sw9
 J1gEL/LggAGbs73MDETB4MIfeeZOa6HwulpY2oJLIWb199wMo/THPTOoa+XBc6HviwUSz9T85mT1a
 UdbDmnpRYQs5bIn1BMwYKtqdIQaLPbc8mVCfHirinO605FMstI7mGqvLw79JaIo3UzjzYBcCA3ave
 RNtamL8w==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYG-0000Gf-SS; Wed, 13 Feb 2019 07:01:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 06/32] powerpc/pseries: use the generic iommu bypass code
Date: Wed, 13 Feb 2019 08:01:07 +0100
Message-Id: <20190213070133.11259-7-hch@lst.de>
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
 arch/powerpc/platforms/pseries/iommu.c | 100 +++++++------------------
 1 file changed, 27 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9f7ac75c5687..37d2ce3f55a3 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -978,7 +978,7 @@ static phys_addr_t ddw_memory_hotplug_max(void)
  * pdn: the parent pe node with the ibm,dma_window property
  * Future: also check if we can remap the base window for our base page size
  *
- * returns the dma offset for use by dma_set_mask
+ * returns the dma offset for use by the direct mapped DMA code.
  */
 static u64 enable_ddw(struct pci_dev *dev, struct device_node *pdn)
 {
@@ -1198,87 +1198,40 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	iommu_add_device(pci->table_group, &dev->dev);
 }
 
-static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
+static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 {
-	bool ddw_enabled = false;
-	struct device_node *pdn, *dn;
-	struct pci_dev *pdev;
+	struct device_node *dn = pci_device_to_OF_node(pdev), *pdn;
 	const __be32 *dma_window = NULL;
 	u64 dma_offset;
 
-	if (!dev->dma_mask)
-		return -EIO;
-
-	if (!dev_is_pci(dev))
-		goto check_mask;
-
-	pdev = to_pci_dev(dev);
-
 	/* only attempt to use a new window if 64-bit DMA is requested */
-	if (!disable_ddw && dma_mask == DMA_BIT_MASK(64)) {
-		dn = pci_device_to_OF_node(pdev);
-		dev_dbg(dev, "node is %pOF\n", dn);
+	if (dma_mask < DMA_BIT_MASK(64))
+		return false;
 
-		/*
-		 * the device tree might contain the dma-window properties
-		 * per-device and not necessarily for the bus. So we need to
-		 * search upwards in the tree until we either hit a dma-window
-		 * property, OR find a parent with a table already allocated.
-		 */
-		for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->table_group;
-				pdn = pdn->parent) {
-			dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
-			if (dma_window)
-				break;
-		}
-		if (pdn && PCI_DN(pdn)) {
-			dma_offset = enable_ddw(pdev, pdn);
-			if (dma_offset != 0) {
-				dev_info(dev, "Using 64-bit direct DMA at offset %llx\n", dma_offset);
-				set_dma_offset(dev, dma_offset);
-				set_dma_ops(dev, &dma_nommu_ops);
-				ddw_enabled = true;
-			}
-		}
-	}
+	dev_dbg(&pdev->dev, "node is %pOF\n", dn);
 
-	/* fall back on iommu ops */
-	if (!ddw_enabled && get_dma_ops(dev) != &dma_iommu_ops) {
-		dev_info(dev, "Restoring 32-bit DMA via iommu\n");
-		set_dma_ops(dev, &dma_iommu_ops);
+	/*
+	 * the device tree might contain the dma-window properties
+	 * per-device and not necessarily for the bus. So we need to
+	 * search upwards in the tree until we either hit a dma-window
+	 * property, OR find a parent with a table already allocated.
+	 */
+	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->table_group;
+			pdn = pdn->parent) {
+		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
+		if (dma_window)
+			break;
 	}
 
-check_mask:
-	if (!dma_supported(dev, dma_mask))
-		return -EIO;
-
-	*dev->dma_mask = dma_mask;
-	return 0;
-}
-
-static u64 dma_get_required_mask_pSeriesLP(struct device *dev)
-{
-	if (!dev->dma_mask)
-		return 0;
-
-	if (!disable_ddw && dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-		struct device_node *dn;
-
-		dn = pci_device_to_OF_node(pdev);
-
-		/* search upwards for ibm,dma-window */
-		for (; dn && PCI_DN(dn) && !PCI_DN(dn)->table_group;
-				dn = dn->parent)
-			if (of_get_property(dn, "ibm,dma-window", NULL))
-				break;
-		/* if there is a ibm,ddw-applicable property require 64 bits */
-		if (dn && PCI_DN(dn) &&
-				of_get_property(dn, "ibm,ddw-applicable", NULL))
-			return DMA_BIT_MASK(64);
+	if (pdn && PCI_DN(pdn)) {
+		dma_offset = enable_ddw(pdev, pdn);
+		if (dma_offset != 0) {
+			set_dma_offset(&pdev->dev, dma_offset);
+			return true;
+		}
 	}
 
-	return dma_iommu_get_required_mask(dev);
+	return false;
 }
 
 static int iommu_mem_notifier(struct notifier_block *nb, unsigned long action,
@@ -1373,8 +1326,9 @@ void iommu_init_early_pSeries(void)
 	if (firmware_has_feature(FW_FEATURE_LPAR)) {
 		pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeriesLP;
 		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
-		ppc_md.dma_set_mask = dma_set_mask_pSeriesLP;
-		ppc_md.dma_get_required_mask = dma_get_required_mask_pSeriesLP;
+		if (!disable_ddw)
+			pseries_pci_controller_ops.iommu_bypass_supported =
+				iommu_bypass_supported_pSeriesLP;
 	} else {
 		pseries_pci_controller_ops.dma_bus_setup = pci_dma_bus_setup_pSeries;
 		pseries_pci_controller_ops.dma_dev_setup = pci_dma_dev_setup_pSeries;
-- 
2.20.1

