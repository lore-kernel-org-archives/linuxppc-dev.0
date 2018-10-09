Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53285C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 13:57:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C89962086D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 13:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L7giyn18"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89962086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TzLQ6r3bzDr3b
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 00:57:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="L7giyn18";
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
 header.b="L7giyn18"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tyfg0MZ1zF38J
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:26:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hhwdg0p6cD+tBZ2LvXC+nRssqLc7D1MCrzZuVKtcd0k=; b=L7giyn18J6TxYDQfxVkMj3gVH0
 Ew5szJrxKfbV8637Zyd7t+IvyFu01/sTfwQoJXXPYHsjeVSN7AJVLrm78NpBozF9m95TIAg3rAHTG
 DMehxdVSNaIpP/YiAYToVnZif0ptzHQZOZUgDrsqtlskp3Ce6JvS4mGseSB8jxoe72IfS3MdzGye0
 9yiMTmZdkZIos2z1Ldn5zJMstPlRJuGdlPjfLagCcNYC0i6dezrYl0iLUyXImOVMYC+pJbuFZnEyV
 IF4SegwaByNeKspz2z1zC6fAejtlQzyFPWjOjCAdT4IJLfjj2Iqd+6h96fed9QAkiieHe+TcliUab
 jOZlftXg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s11-0001Bk-GY; Tue, 09 Oct 2018 13:25:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 14/33] powerpc/dart: use the generic iommu bypass code
Date: Tue,  9 Oct 2018 15:24:41 +0200
Message-Id: <20181009132500.17643-15-hch@lst.de>
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

Use the generic iommu bypass code instead of overriding set_dma_mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/sysdev/dart_iommu.c | 45 +++++++++++---------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index ce5dd2048f57..e7d1645a2d2e 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -360,13 +360,6 @@ static void iommu_table_dart_setup(void)
 	set_bit(iommu_table_dart.it_size - 1, iommu_table_dart.it_map);
 }
 
-static void pci_dma_dev_setup_dart(struct pci_dev *dev)
-{
-	if (dart_is_u4)
-		set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
-	set_iommu_table_base(&dev->dev, &iommu_table_dart);
-}
-
 static void pci_dma_bus_setup_dart(struct pci_bus *bus)
 {
 	if (!iommu_table_dart_inited) {
@@ -390,27 +383,16 @@ static bool dart_device_on_pcie(struct device *dev)
 	return false;
 }
 
-static int dart_dma_set_mask(struct device *dev, u64 dma_mask)
+static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 {
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
-	/* U4 supports a DART bypass, we use it for 64-bit capable
-	 * devices to improve performances. However, that only works
-	 * for devices connected to U4 own PCIe interface, not bridged
-	 * through hypertransport. We need the device to support at
-	 * least 40 bits of addresses.
-	 */
-	if (dart_device_on_pcie(dev) && dma_mask >= DMA_BIT_MASK(40)) {
-		dev_info(dev, "Using 64-bit DMA iommu bypass\n");
-		set_dma_ops(dev, &dma_nommu_ops);
-	} else {
-		dev_info(dev, "Using 32-bit DMA via iommu\n");
-		set_dma_ops(dev, &dma_iommu_ops);
-	}
+	if (dart_is_u4 && dart_device_on_pcie(&dev->dev))
+		set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
+	set_iommu_table_base(&dev->dev, &iommu_table_dart);
+}
 
-	*dev->dma_mask = dma_mask;
-	return 0;
+static bool iommu_bypass_supported_dart(struct pci_dev *dev, u64 mask)
+{
+	return dart_is_u4 && dart_device_on_pcie(&dev->dev);
 }
 
 void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
@@ -430,12 +412,15 @@ void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)
 	if (dart_init(dn) != 0)
 		return;
 
-	/* Setup bypass if supported */
-	if (dart_is_u4)
-		ppc_md.dma_set_mask = dart_dma_set_mask;
-
+	/*
+	 * U4 supports a DART bypass, we use it for 64-bit capable devices to
+	 * improve performance.  However, that only works for devices connected
+	 * to the U4 own PCIe interface, not bridged through hypertransport.
+	 * We need the device to support at least 40 bits of addresses.
+	 */
 	controller_ops->dma_dev_setup = pci_dma_dev_setup_dart;
 	controller_ops->dma_bus_setup = pci_dma_bus_setup_dart;
+	controller_ops->iommu_bypass_supported = iommu_bypass_supported_dart;
 
 	/* Setup pci_dma ops */
 	set_pci_dma_ops(&dma_iommu_ops);
-- 
2.19.0

