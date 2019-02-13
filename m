Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65430C282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:22:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFE20206C0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ha8HlbjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFE20206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zrZz4nn5zDqRs
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:22:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="Ha8HlbjR"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7G6kd8zDqP5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=deIo4waZ4Tvrtcfo/8rp2UNAq5cX4H01UYLCap4CyU8=; b=Ha8HlbjRNGN3NvehSoklkkWai1
 tBEvQ91haxXzseIP5Sl+v2l/hoHeatAJDTOCUjK4DyNH71UgwIPDbuhHKKDOK/OvekiUuOdnWzOPJ
 S5aJb3mc6tRqZzgzg4Dx2etFIvnWKDruux8W+RDF/Al09InX4tCgMeeI9Ly4jHJi8knwVG+P8zfr4
 08nxRVOk5smjUC5jAk03SKDwvOBSZS4ulyBCZPFGwBNqOeTpdVV57pcRJpLWgto3KejmJHItGHYpd
 Sb7+qvp/ox0nNVF6rgRLpmLvEF/CEAzUzPVanO5ddisUCokzjxhoDuT/AdrmvgvOA+H9tJ5Jnu1dR
 Urq5XupA==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYZ-0000Ji-Sz; Wed, 13 Feb 2019 07:02:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 14/32] powerpc/dma: stop overriding dma_get_required_mask
Date: Wed, 13 Feb 2019 08:01:15 +0100
Message-Id: <20190213070133.11259-15-hch@lst.de>
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

The ppc_md and pci_controller_ops methods are unused now and can be
removed.  The dma_nommu implementation is generic to the generic one
except for using max_pfn instead of calling into the memblock API,
and all other dma_map_ops instances implement a method of their own.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/include/asm/device.h      |  2 --
 arch/powerpc/include/asm/dma-mapping.h |  2 --
 arch/powerpc/include/asm/machdep.h     |  2 --
 arch/powerpc/include/asm/pci-bridge.h  |  1 -
 arch/powerpc/kernel/dma.c              | 29 --------------------------
 kernel/dma/mapping.c                   |  2 --
 6 files changed, 38 deletions(-)

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
index 1d80174db8a4..dc7f7bcdf65d 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -112,7 +112,5 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 
 #define HAVE_ARCH_DMA_SET_MASK 1
 
-extern u64 __dma_get_required_mask(struct device *dev);
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 8311869005fa..7b70dcbce1b9 100644
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
index d7492dca6599..236a7460b6ec 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -46,7 +46,6 @@ struct pci_controller_ops {
 #endif
 
 	int             (*dma_set_mask)(struct pci_dev *pdev, u64 dma_mask);
-	u64		(*dma_get_required_mask)(struct pci_dev *pdev);
 
 	void		(*shutdown)(struct pci_controller *hose);
 };
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index e5db4d3f8bea..0d52107b90f0 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -318,35 +318,6 @@ int dma_set_mask(struct device *dev, u64 dma_mask)
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
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index a11006b6d8e8..40c0af744692 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -207,7 +207,6 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
 }
 EXPORT_SYMBOL(dma_mmap_attrs);
 
-#ifndef ARCH_HAS_DMA_GET_REQUIRED_MASK
 static u64 dma_default_get_required_mask(struct device *dev)
 {
 	u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
@@ -238,7 +237,6 @@ u64 dma_get_required_mask(struct device *dev)
 	return dma_default_get_required_mask(dev);
 }
 EXPORT_SYMBOL_GPL(dma_get_required_mask);
-#endif
 
 #ifndef arch_dma_alloc_attrs
 #define arch_dma_alloc_attrs(dev)	(true)
-- 
2.20.1

