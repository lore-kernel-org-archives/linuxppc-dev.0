Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273B0C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:43:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DD3621479
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QqaUKh2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DD3621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V0Mt6rx3zF3Hh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 01:43:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="QqaUKh2o";
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
 header.b="QqaUKh2o"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TygW4F01zF38V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:26:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yIv6BDTf8SSyW4q5DR2O7BbFOqkppOKG2igrjWHb8Os=; b=QqaUKh2o32LY2ejJ6ACdm++PJN
 9bHPTjax777yMMB+/jALpB3NPNqXVkL2DUVN8ai9c8iwFnvd89iIep2IOLB2X3yh2Wi8eoVE1qyMx
 XfA+Od6spw1X/mmg8bsX8mLzTMGExn35INk2oS2G4oMv8UIpVt0f++UkVNDcFxR6at7IqS4fcNeqK
 0ZEntpKacfWVTw31oxnorN3k3/2P8GZrSZvcpJOhAUSN8cH8JIyZ5Y/4N98ElGPMBRToD9ZSPDdLv
 dfWEmSG+1qhZo7qj5a866Iby8SY+Y574WvixgRbPCNsUbfIs1lOUZxmMjZqQMUhukVjEhbQaA8ddb
 DIyW0TBA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s1i-0001bW-VA; Tue, 09 Oct 2018 13:26:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 30/33] powerpc/dma: remove set_dma_offset
Date: Tue,  9 Oct 2018 15:24:57 +0200
Message-Id: <20181009132500.17643-31-hch@lst.de>
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

There is no good reason for this helper, just opencode it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/dma-mapping.h    | 6 ------
 arch/powerpc/kernel/pci-common.c          | 2 +-
 arch/powerpc/platforms/cell/iommu.c       | 4 ++--
 arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++---
 arch/powerpc/platforms/pseries/iommu.c    | 7 ++-----
 arch/powerpc/sysdev/dart_iommu.c          | 2 +-
 arch/powerpc/sysdev/fsl_pci.c             | 2 +-
 drivers/misc/cxl/vphb.c                   | 2 +-
 8 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 2d0879b0acf3..e12439ae8211 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -87,11 +87,5 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-static inline void set_dma_offset(struct device *dev, dma_addr_t off)
-{
-	if (dev)
-		dev->archdata.dma_offset = off;
-}
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index a84707680525..fca2b0bafd82 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -966,7 +966,7 @@ static void pcibios_setup_device(struct pci_dev *dev)
 
 	/* Hook up default DMA ops */
 	set_dma_ops(&dev->dev, pci_dma_ops);
-	set_dma_offset(&dev->dev, PCI_DRAM_OFFSET);
+	dev->dev.archdata.dma_offset = PCI_DRAM_OFFSET;
 
 	/* Additional platform DMA/iommu setup */
 	phb = pci_bus_to_host(dev->bus);
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 93c7e4aef571..997ee0f5fc2f 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -577,10 +577,10 @@ static void cell_dma_dev_setup(struct device *dev)
 		u64 addr = cell_iommu_get_fixed_address(dev);
 
 		if (addr != OF_BAD_ADDR)
-			set_dma_offset(dev, addr + dma_iommu_fixed_base);
+			dev->archdata.dma_offset = addr + dma_iommu_fixed_base;
 		set_iommu_table_base(dev, cell_get_iommu_table(dev));
 	} else {
-		set_dma_offset(dev, cell_dma_nommu_offset);
+		dev->archdata.dma_offset = cell_dma_nommu_offset;
 	}
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5748b62e2e86..e2333e10598d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1660,7 +1660,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_dma_offset(&pdev->dev, pe->tce_bypass_base);
+	pdev->dev.archdata.dma_offset = pe->tce_bypass_base;
 	set_iommu_table_base(&pdev->dev, pe->table_group.tables[0]);
 	/*
 	 * Note: iommu_add_device() will fail here as
@@ -1773,7 +1773,7 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
 		if (rc)
 			return rc;
 		/* 4GB offset bypasses 32-bit space */
-		set_dma_offset(&pdev->dev, (1ULL << 32));
+		pdev->dev.archdata.dma_offset = (1ULL << 32);
 		return true;
 	}
 
@@ -1788,7 +1788,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
-		set_dma_offset(&dev->dev, pe->tce_bypass_base);
+		dev->dev.archdata.dma_offset = pe->tce_bypass_base;
 		if (add_to_group)
 			iommu_add_device(&dev->dev);
 
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 8965d174c53b..a2ff20d154fe 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1197,7 +1197,6 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 {
 	struct device_node *dn = pci_device_to_OF_node(pdev), *pdn;
 	const __be32 *dma_window = NULL;
-	u64 dma_offset;
 
 	/* only attempt to use a new window if 64-bit DMA is requested */
 	if (dma_mask < DMA_BIT_MASK(64))
@@ -1219,11 +1218,9 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 	}
 
 	if (pdn && PCI_DN(pdn)) {
-		dma_offset = enable_ddw(pdev, pdn);
-		if (dma_offset != 0) {
-			set_dma_offset(&pdev->dev, dma_offset);
+		pdev->dev.archdata.dma_offset = enable_ddw(pdev, pdn);
+		if (pdev->dev.archdata.dma_offset)
 			return true;
-		}
 	}
 
 	return false;
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index e7d1645a2d2e..21d7e8a30aea 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -386,7 +386,7 @@ static bool dart_device_on_pcie(struct device *dev)
 static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 {
 	if (dart_is_u4 && dart_device_on_pcie(&dev->dev))
-		set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
+		dev->dev.archdata.dma_offset = DART_U4_BYPASS_BASE;
 	set_iommu_table_base(&dev->dev, &iommu_table_dart);
 }
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index cb91a3d113d1..d6b7c91a9ce2 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -141,7 +141,7 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	 */
 	if (dev_is_pci(dev) && dma_mask >= pci64_dma_offset * 2 - 1) {
 		dev->bus_dma_mask = 0;
-		set_dma_offset(dev, pci64_dma_offset);
+		dev->archdata.dma_offset = pci64_dma_offset;
 	}
 
 	return 0;
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 49da2f744bbf..f0645ba1d728 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -44,7 +44,7 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 	}
 
 	set_dma_ops(&dev->dev, &dma_nommu_ops);
-	set_dma_offset(&dev->dev, PAGE_OFFSET);
+	dev->dev.archdata.dma_offset = PAGE_OFFSET;
 
 	/*
 	 * Allocate a context to do cxl things too.  If we eventually do real
-- 
2.19.0

