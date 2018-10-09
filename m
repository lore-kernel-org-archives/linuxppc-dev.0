Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC5DC64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:30:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B467F213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 14:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VhBM8FnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B467F213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42V04h6BPxzDqfD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 01:30:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=infradead.org header.i=@infradead.org header.b="VhBM8FnV";
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
 header.b="VhBM8FnV"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TygC0W3DzF38h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 00:26:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ql7aNHvXxzTTeGCBs2l+3pR2u55du0W8IqjAoV6Ofu0=; b=VhBM8FnV/Qb+hJcAxNWpyw9fjs
 6Q0QpkQut2T2b2x7zH2vBrGPoBZ7Nddazm5NgWlGmEITQuh/VYiWFXAgEFmdG2tFGTp1XTNf4xule
 QvTfYZnRF035flgMM6Zlgs40ULWxeyO72tDCMRb/k8HL6h2mW5DnASyOnevYy6Z/gJJ9OV5imIhLO
 qiW9dwSI1vDt+rx3oM7OeCTS9CWUXBMcKitKCyIkg36gRE8UzpDCLxlDaanT1k3jpSCHKIVMWw4Do
 hfp7AF2F70U9I5gFCs7JlLzGtuCNeZ2iuVRs6zqNwIJCahrt5+e+/NUl2esH4mmei2gIY0GuAc0P1
 0tZPIB3A==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g9s1b-0001Wk-6c; Tue, 09 Oct 2018 13:26:11 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 27/33] dma-mapping,
 powerpc: simplify the arch dma_set_mask override
Date: Tue,  9 Oct 2018 15:24:54 +0200
Message-Id: <20181009132500.17643-28-hch@lst.de>
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

Instead of letting the architecture supply all of dma_set_mask just
give it an additional hook selected by Kconfig.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/dma-mapping.h |  3 ---
 arch/powerpc/kernel/dma-swiotlb.c      |  8 ++++++++
 arch/powerpc/kernel/dma.c              | 12 ------------
 arch/powerpc/sysdev/fsl_pci.c          |  4 ----
 include/linux/dma-mapping.h            | 11 ++++++++---
 kernel/dma/Kconfig                     |  3 +++
 7 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 7097019d8907..7ea01687995d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -126,6 +126,7 @@ config PPC
 	# Please keep this list sorted alphabetically.
 	#
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
+	select ARCH_HAS_DMA_SET_MASK		if SWIOTLB
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index b1999880fc61..7694985f05ee 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -109,8 +109,5 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 		dev->archdata.dma_offset = off;
 }
 
-#define HAVE_ARCH_DMA_SET_MASK 1
-extern int dma_set_mask(struct device *dev, u64 dma_mask);
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index e05d95ff50ad..dba216dd70fd 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -22,6 +22,14 @@
 #include <asm/swiotlb.h>
 #include <asm/dma.h>
 
+bool arch_dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	if (!ppc_md.dma_set_mask)
+		return 0;
+	return ppc_md.dma_set_mask(dev, dma_mask);
+}
+EXPORT_SYMBOL(arch_dma_set_mask);
+
 unsigned int ppc_swiotlb_enable;
 
 /*
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index e3d2c15b209c..795afe387c91 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -197,18 +197,6 @@ const struct dma_map_ops dma_nommu_ops = {
 };
 EXPORT_SYMBOL(dma_nommu_ops);
 
-int dma_set_mask(struct device *dev, u64 dma_mask)
-{
-	if (ppc_md.dma_set_mask)
-		return ppc_md.dma_set_mask(dev, dma_mask);
-
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-	*dev->dma_mask = dma_mask;
-	return 0;
-}
-EXPORT_SYMBOL(dma_set_mask);
-
 static int __init dma_init(void)
 {
 #ifdef CONFIG_IBMVIO
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 296ffabc9386..cb91a3d113d1 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -135,9 +135,6 @@ static inline void setup_swiotlb_ops(struct pci_controller *hose) {}
 
 static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
 	/*
 	 * Fix up PCI devices that are able to DMA to the large inbound
 	 * mapping that allows addressing any RAM address from across PCI.
@@ -147,7 +144,6 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 		set_dma_offset(dev, pci64_dma_offset);
 	}
 
-	*dev->dma_mask = dma_mask;
 	return 0;
 }
 
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 15bd41447025..8dd19e66c0e5 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -598,18 +598,23 @@ static inline int dma_supported(struct device *dev, u64 mask)
 	return ops->dma_supported(dev, mask);
 }
 
-#ifndef HAVE_ARCH_DMA_SET_MASK
+#ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
+bool arch_dma_set_mask(struct device *dev, u64 mask);
+#else
+#define arch_dma_set_mask(dev, mask)		true
+#endif
+
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
 	if (!dev->dma_mask || !dma_supported(dev, mask))
 		return -EIO;
-
+	if (!arch_dma_set_mask(dev, mask))
+		return -EIO;
 	dma_check_mask(dev, mask);
 
 	*dev->dma_mask = mask;
 	return 0;
 }
-#endif
 
 static inline u64 dma_get_mask(struct device *dev)
 {
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 645c7a2ecde8..951045c90c2c 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -16,6 +16,9 @@ config ARCH_DMA_ADDR_T_64BIT
 config ARCH_HAS_DMA_COHERENCE_H
 	bool
 
+config ARCH_HAS_DMA_SET_MASK
+	bool
+
 config HAVE_GENERIC_DMA_COHERENT
 	bool
 
-- 
2.19.0

