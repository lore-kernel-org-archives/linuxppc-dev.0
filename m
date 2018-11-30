Return-Path: <SRS0=Kv2y=OJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13164C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 10:55:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5563D20863
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 10:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5563D20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 435rsL2y50zDrS2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 30 Nov 2018 21:55:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 435rq30TSZzDrPn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Nov 2018 21:53:50 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 7081F68BE5; Fri, 30 Nov 2018 11:53:46 +0100 (CET)
Date: Fri, 30 Nov 2018 11:53:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181130105346.GB26765@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
 <87zhttfonk.fsf@concordia.ellerman.id.au>
 <4d4e3cdd-d1a9-affe-0f63-45b8c342bbd6@xenosoft.de>
 <20181129170351.GC27951@lst.de>
 <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0e04a85-f17d-414e-6fea-971414417430@xenosoft.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Paul Mackerras <paulus@samba.org>, Olof Johansson <olof@lixom.net>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Christian,

for such a diverse architecture like powerpc we'll have to rely on
users / non core developers like you to help with testing.

Can you try the patch below for he cyrus config?

For the nemo one I have no idea yet, there is no chance I could trick
you into a git bisect to see which patch caused the problem, is there?


diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 7b70dcbce1b9..2f0ca6560e47 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -47,7 +47,7 @@ struct machdep_calls {
 #endif
 #endif /* CONFIG_PPC64 */
 
-	int		(*dma_set_mask)(struct device *dev, u64 dma_mask);
+	void		(*dma_set_mask)(struct device *dev, u64 dma_mask);
 
 	int		(*probe)(void);
 	void		(*setup_arch)(void); /* Optional, may be NULL */
diff --git a/arch/powerpc/kernel/dma-swiotlb.c b/arch/powerpc/kernel/dma-swiotlb.c
index bded4127791a..2587eb0f3fde 100644
--- a/arch/powerpc/kernel/dma-swiotlb.c
+++ b/arch/powerpc/kernel/dma-swiotlb.c
@@ -22,11 +22,10 @@
 #include <asm/swiotlb.h>
 #include <asm/dma.h>
 
-bool arch_dma_set_mask(struct device *dev, u64 dma_mask)
+void arch_dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	if (!ppc_md.dma_set_mask)
-		return 0;
-	return ppc_md.dma_set_mask(dev, dma_mask);
+	if (ppc_md.dma_set_mask)
+		ppc_md.dma_set_mask(dev, dma_mask);
 }
 EXPORT_SYMBOL(arch_dma_set_mask);
 
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 9584765dbe3b..8582a418516b 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -134,7 +134,7 @@ static void setup_swiotlb_ops(struct pci_controller *hose)
 static inline void setup_swiotlb_ops(struct pci_controller *hose) {}
 #endif
 
-static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
+static void fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 {
 	/*
 	 * Fix up PCI devices that are able to DMA to the large inbound
@@ -144,8 +144,6 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 		dev->bus_dma_mask = 0;
 		dev->archdata.dma_offset = pci64_dma_offset;
 	}
-
-	return 0;
 }
 
 static int setup_one_atmu(struct ccsr_pci __iomem *pci,
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 8dd19e66c0e5..94a4db5f7ec3 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -599,17 +599,16 @@ static inline int dma_supported(struct device *dev, u64 mask)
 }
 
 #ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
-bool arch_dma_set_mask(struct device *dev, u64 mask);
+void arch_dma_set_mask(struct device *dev, u64 mask);
 #else
-#define arch_dma_set_mask(dev, mask)		true
+#define arch_dma_set_mask(dev, mask)	do { } while (0)
 #endif
 
 static inline int dma_set_mask(struct device *dev, u64 mask)
 {
 	if (!dev->dma_mask || !dma_supported(dev, mask))
 		return -EIO;
-	if (!arch_dma_set_mask(dev, mask))
-		return -EIO;
+	arch_dma_set_mask(dev, mask);
 	dma_check_mask(dev, mask);
 
 	*dev->dma_mask = mask;

