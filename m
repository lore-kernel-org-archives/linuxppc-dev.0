Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17608C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 13:59:55 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786362086D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 13:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OUQ35khO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786362086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42TzPh2vKRzF38T
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 00:59:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="OUQ35khO";
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
 header.b="OUQ35khO"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Tyfh2TDpzF38V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:26:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qHIt8PU2ghlSSKLAslc/yyxBCNYkuCHyozLkBsIx2aI=; b=OUQ35khO0MRVkmARK+EPAPDiio
 UoKONGmkCbN4iVRt5myckpSTUi0gQSvXp7mBkf00cd+z8ObfihkHZtg9jkfOgSCUPvU5wOhduYRZS
 irqK3vMa2JbeXOE6li3QBYDfaRtv7dBvJHizrG5fAMwIEOvDCw+bbi5f3eCkTPuR7k0iA+XGPdOeP
 Oer1TgzuziP8S0iKDsxBVoAHn2fZJAWlJjBVHSQVraQUziWNRLVp6TgzLKze3AH3XUT/w16MG5MWj
 PqqJqoFK1HHkkOs73F2DLekxrbWK9j8gl04lyWUvh7LBzBPjFSPuZeBOHoDlL2FHxOqSr5I6gC6AS
 3MewVvGA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s1D-0001HQ-5k; Tue, 09 Oct 2018 13:25:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 18/33] powerpc/dma: stop overriding dma_get_required_mask
Date: Tue,  9 Oct 2018 15:24:45 +0200
Message-Id: <20181009132500.17643-19-hch@lst.de>
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

The ppc_md and pci_controller_ops methods are unused now and can be
removed.  The dma_nommu implementation is generic to the generic one
except for using max_pfn instead of calling into the memblock API,
and all other dma_map_ops instances implement a method of their own.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/device.h      |  2 --
 arch/powerpc/include/asm/dma-mapping.h |  2 --
 arch/powerpc/include/asm/machdep.h     |  2 --
 arch/powerpc/include/asm/pci-bridge.h  |  1 -
 arch/powerpc/kernel/dma.c              | 42 --------------------------
 drivers/base/platform.c                |  2 --
 6 files changed, 51 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 1aa53318b4bc..3814e1c2d4bc 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -59,6 +59,4 @@ struct pdev_archdata {
 	u64 dma_mask;
 };
 
-#define ARCH_HAS_DMA_GET_REQUIRED_MASK
-
 #endif /* _ASM_POWERPC_DEVICE_H */
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 59c090b7eaac..b1999880fc61 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -112,7 +112,5 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 #define HAVE_ARCH_DMA_SET_MASK 1
 extern int dma_set_mask(struct device *dev, u64 dma_mask);
 
-extern u64 __dma_get_required_mask(struct device *dev);
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index a47de82fb8e2..99f06102474e 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -47,9 +47,7 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	/* Platform set_dma_mask and dma_get_required_mask overrides */
 	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
-	u64		(*dma_get_required_mask)(struct device *dev);
 
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 5c7a1e7ffc8a..aace7033fa02 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -46,7 +46,6 @@ struct pci_controller_ops {
 #endif
 
 	int             (*dma_set_mask)(struct pci_dev *pdev, u64 dma_mask);
-	u64		(*dma_get_required_mask)(struct pci_dev *pdev);
 
 	void		(*shutdown)(struct pci_controller *hose);
 };
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 716b7eab3ee7..9ca9d2cec4ed 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -197,18 +197,6 @@ int dma_nommu_map_sg(struct device *dev, struct scatterlist *sgl,
 	return nents;
 }
 
-static u64 dma_nommu_get_required_mask(struct device *dev)
-{
-	u64 end, mask;
-
-	end = memblock_end_of_DRAM() + get_dma_offset(dev);
-
-	mask = 1ULL << (fls64(end) - 1);
-	mask += mask - 1;
-
-	return mask;
-}
-
 dma_addr_t dma_nommu_map_page(struct device *dev, struct page *page,
 		unsigned long offset, size_t size,
 		enum dma_data_direction dir, unsigned long attrs)
@@ -246,7 +234,6 @@ const struct dma_map_ops dma_nommu_ops = {
 	.map_sg				= dma_nommu_map_sg,
 	.dma_supported			= dma_nommu_dma_supported,
 	.map_page			= dma_nommu_map_page,
-	.get_required_mask		= dma_nommu_get_required_mask,
 #ifdef CONFIG_NOT_COHERENT_CACHE
 	.sync_single_for_cpu 		= dma_nommu_sync_single,
 	.sync_single_for_device 	= dma_nommu_sync_single,
@@ -294,35 +281,6 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
 }
 EXPORT_SYMBOL(dma_set_mask);
 
-u64 __dma_get_required_mask(struct device *dev)
-{
-	const struct dma_map_ops *dma_ops = get_dma_ops(dev);
-
-	if (unlikely(dma_ops == NULL))
-		return 0;
-
-	if (dma_ops->get_required_mask)
-		return dma_ops->get_required_mask(dev);
-
-	return DMA_BIT_MASK(8 * sizeof(dma_addr_t));
-}
-
-u64 dma_get_required_mask(struct device *dev)
-{
-	if (ppc_md.dma_get_required_mask)
-		return ppc_md.dma_get_required_mask(dev);
-
-	if (dev_is_pci(dev)) {
-		struct pci_dev *pdev = to_pci_dev(dev);
-		struct pci_controller *phb = pci_bus_to_host(pdev->bus);
-		if (phb->controller_ops.dma_get_required_mask)
-			return phb->controller_ops.dma_get_required_mask(pdev);
-	}
-
-	return __dma_get_required_mask(dev);
-}
-EXPORT_SYMBOL_GPL(dma_get_required_mask);
-
 static int __init dma_init(void)
 {
 #ifdef CONFIG_IBMVIO
diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 23cf4427f425..057357521561 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1179,7 +1179,6 @@ int __init platform_bus_init(void)
 	return error;
 }
 
-#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
 static u64 dma_default_get_required_mask(struct device *dev)
 {
 	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
@@ -1208,7 +1207,6 @@ u64 dma_get_required_mask(struct device *dev)
 	return dma_default_get_required_mask(dev);
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
-#endif
 
 static __initdata LIST_HEAD(early_platform_driver_list);
 static __initdata LIST_HEAD(early_platform_device_list);
-- 
2.19.0

