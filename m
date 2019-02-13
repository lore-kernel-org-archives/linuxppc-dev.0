Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E271C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:58:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC2C6222B5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E8Lr8jai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC2C6222B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zsNJ5zdhzDqRJ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:58:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="E8Lr8jai"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr803KxpzDqMv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lxv0WcQW84mmLJvEFcH/Tsr23MhYXWXlkbgBkcV0LpM=; b=E8Lr8jaijQUN2C3NgfIfAJIuo9
 LAzv2YVf76nZMAgyJGRdRpFEImBROI1eb7btsbLDmnna+1b1StOzo/0VKxm1XUpKPHPDlm2Vq0Egb
 WxzoKay2Gk4ZgagQL1ZZRFJAHWjU0fcLuafR458mPyFOZSsOYcsdKDoc+Z8sGMLnSvJDxbKggLBGu
 h6qzGNesOruL6wMvqsrarqrMTr6bAmdJT4GL5f8EtxlwBGLfg5PXafankBA+P4pEwDo9AqK5nrf2r
 nPcqwhuYvI8O4EAyzuFyLIifRS1fPuS7Mks8A1AVvfd2SORKhr6ZQv5wNLazi9JugYBQPDSQCs63R
 xXeGadyg==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoZF-0000mL-1m; Wed, 13 Feb 2019 07:02:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 31/32] powerpc/dma: remove set_dma_offset
Date: Wed, 13 Feb 2019 08:01:32 +0100
Message-Id: <20190213070133.11259-32-hch@lst.de>
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

There is no good reason for this helper, just opencode it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
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
index c70f55d2f5e0..a59c42879194 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -43,11 +43,5 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
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
index 23989175349c..cbdf13d86227 100644
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
index 06abd432b830..54e012e1f720 100644
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
index 9a1db2de9605..b56bf65e1bb6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1746,7 +1746,7 @@ static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev
 
 	pe = &phb->ioda.pe_array[pdn->pe_number];
 	WARN_ON(get_dma_ops(&pdev->dev) != &dma_iommu_ops);
-	set_dma_offset(&pdev->dev, pe->tce_bypass_base);
+	pdev->dev.archdata.dma_offset = pe->tce_bypass_base;
 	set_iommu_table_base(&pdev->dev, pe->table_group.tables[0]);
 	/*
 	 * Note: iommu_add_device() will fail here as
@@ -1859,7 +1859,7 @@ static bool pnv_pci_ioda_iommu_bypass_supported(struct pci_dev *pdev,
 		if (rc)
 			return rc;
 		/* 4GB offset bypasses 32-bit space */
-		set_dma_offset(&pdev->dev, (1ULL << 32));
+		pdev->dev.archdata.dma_offset = (1ULL << 32);
 		return true;
 	}
 
@@ -1872,7 +1872,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
-		set_dma_offset(&dev->dev, pe->tce_bypass_base);
+		dev->dev.archdata.dma_offset = pe->tce_bypass_base;
 
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 37d2ce3f55a3..36eb1ddbac69 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1202,7 +1202,6 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
 {
 	struct device_node *dn = pci_device_to_OF_node(pdev), *pdn;
 	const __be32 *dma_window = NULL;
-	u64 dma_offset;
 
 	/* only attempt to use a new window if 64-bit DMA is requested */
 	if (dma_mask < DMA_BIT_MASK(64))
@@ -1224,11 +1223,9 @@ static bool iommu_bypass_supported_pSeriesLP(struct pci_dev *pdev, u64 dma_mask)
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
index d42ba645d51d..809797dbe169 100644
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
index 23000ca7f688..a04c6dde6ed0 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -139,7 +139,7 @@ static void fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 	 */
 	if (dev_is_pci(dev) && dma_mask >= pci64_dma_offset * 2 - 1) {
 		dev->bus_dma_mask = 0;
-		set_dma_offset(dev, pci64_dma_offset);
+		dev->archdata.dma_offset = pci64_dma_offset;
 	}
 }
 
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index b64adc0f0865..631c5df246d4 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -43,7 +43,7 @@ static bool cxl_pci_enable_device_hook(struct pci_dev *dev)
 		return false;
 	}
 
-	set_dma_offset(&dev->dev, PAGE_OFFSET);
+	dev->dev.archdata.dma_offset = PAGE_OFFSET;
 
 	/*
 	 * Allocate a context to do cxl things too.  If we eventually do real
-- 
2.20.1

