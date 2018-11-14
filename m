Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC1C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 09:25:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B403223DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 09:25:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BGyYBVMb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B403223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vzcX1VMwzF3Q0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 20:25:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="BGyYBVMb";
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
 header.b="BGyYBVMb"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vyGL1ftQzF3KL
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 19:24:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AhpsR67YaOySc3DfSvGldQwkaJtzOq5BMzzw3m2vCO0=; b=BGyYBVMbBZYsgpoJj/x8gZvkeo
 OnlotN77GUvi5LGarif/vVgBFeg/8kfqF1E5IIwROAp+OEiYNUSSwf7JFirgSKLq2ElHP2MyPd51v
 6JACqPBy3otjWAt8hejnNJHQ07CF/ETU65CI189ntrWExSgvx0nywpYTJWg+WTwYbQAWN3JTnzvXo
 S9mOu6bZ6kr8ADGRVnIOjNWYOXbLKGdXjMEccZPwnIXDok8FG0nDZzuq9brNg4Erd5sNGrZV9EnHM
 JuCYzdMME+RWHrM0ztEIYqXlglBEMu9ybXZyvnBJWou7wzODBs/jokjdic1Y/Lkkh5V0FjP59YwmA
 b3M1QJ7A==;
Received: from 089144211136.atnat0020.highway.a1.net ([89.144.211.136]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMqTD-00051C-H9; Wed, 14 Nov 2018 08:24:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 23/34] powerpc/dma: remove get_pci_dma_ops
Date: Wed, 14 Nov 2018 09:23:03 +0100
Message-Id: <20181114082314.8965-24-hch@lst.de>
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

This function is only used by the Cell iommu code, which can keep track
if it is using the iommu internally just as good.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/pci.h      |  2 --
 arch/powerpc/kernel/pci-common.c    |  6 ------
 arch/powerpc/platforms/cell/iommu.c | 17 ++++++++---------
 3 files changed, 8 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/include/asm/pci.h b/arch/powerpc/include/asm/pci.h
index 2af9ded80540..04c44c4b0acf 100644
--- a/arch/powerpc/include/asm/pci.h
+++ b/arch/powerpc/include/asm/pci.h
@@ -52,10 +52,8 @@ static inline int pci_get_legacy_ide_irq(struct pci_dev *dev, int channel)
 
 #ifdef CONFIG_PCI
 extern void set_pci_dma_ops(const struct dma_map_ops *dma_ops);
-extern const struct dma_map_ops *get_pci_dma_ops(void);
 #else	/* CONFIG_PCI */
 #define set_pci_dma_ops(d)
-#define get_pci_dma_ops()	NULL
 #endif
 
 #ifdef CONFIG_PPC64
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 88e4f69a09e5..a84707680525 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -69,12 +69,6 @@ void set_pci_dma_ops(const struct dma_map_ops *dma_ops)
 	pci_dma_ops = dma_ops;
 }
 
-const struct dma_map_ops *get_pci_dma_ops(void)
-{
-	return pci_dma_ops;
-}
-EXPORT_SYMBOL(get_pci_dma_ops);
-
 /*
  * This function should run under locking protection, specifically
  * hose_spinlock.
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index fb51f78035ce..93c7e4aef571 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -544,6 +544,7 @@ static struct cbe_iommu *cell_iommu_for_node(int nid)
 static unsigned long cell_dma_nommu_offset;
 
 static unsigned long dma_iommu_fixed_base;
+static bool cell_iommu_enabled;
 
 /* iommu_fixed_is_weak is set if booted with iommu_fixed=weak */
 bool iommu_fixed_is_weak;
@@ -572,16 +573,14 @@ static u64 cell_iommu_get_fixed_address(struct device *dev);
 
 static void cell_dma_dev_setup(struct device *dev)
 {
-	if (get_pci_dma_ops() == &dma_iommu_ops) {
+	if (cell_iommu_enabled) {
 		u64 addr = cell_iommu_get_fixed_address(dev);
 
 		if (addr != OF_BAD_ADDR)
 			set_dma_offset(dev, addr + dma_iommu_fixed_base);
 		set_iommu_table_base(dev, cell_get_iommu_table(dev));
-	} else if (get_pci_dma_ops() == &dma_nommu_ops) {
-		set_dma_offset(dev, cell_dma_nommu_offset);
 	} else {
-		BUG();
+		set_dma_offset(dev, cell_dma_nommu_offset);
 	}
 }
 
@@ -599,11 +598,11 @@ static int cell_of_bus_notify(struct notifier_block *nb, unsigned long action,
 	if (action != BUS_NOTIFY_ADD_DEVICE)
 		return 0;
 
-	/* We use the PCI DMA ops */
-	dev->dma_ops = get_pci_dma_ops();
-
+	if (cell_iommu_enabled)
+		dev->dma_ops = &dma_iommu_ops;
+	else
+		dev->dma_ops = &dma_nommu_ops;
 	cell_dma_dev_setup(dev);
-
 	return 0;
 }
 
@@ -1091,7 +1090,7 @@ static int __init cell_iommu_init(void)
 				cell_pci_iommu_bypass_supported;
 	}
 	set_pci_dma_ops(&dma_iommu_ops);
-
+	cell_iommu_enabled = true;
  bail:
 	/* Register callbacks on OF platform device addition/removal
 	 * to handle linking them to the right DMA operations
-- 
2.19.1

