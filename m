Return-Path: <SRS0=t5Ns=QU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5148CC282C2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:44:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF1C9222BA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 07:44:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H/4tMC5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF1C9222BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zs3d5Nk9zDqTK
	for <linuxppc-dev@archiver.kernel.org>; Wed, 13 Feb 2019 18:44:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+b68490c3fe13e616ccfb+5652+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="H/4tMC5L"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zr7l1mt0zDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2019 18:02:43 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t30kSeZI9TDrUrln4+oy0MMyYsoe4CFLh3oG0dPZMWs=; b=H/4tMC5LDp43Tah/X0pVQtKgCg
 HrWtJN0sSkaDxEJDCY6iUWIfDQDYC7+05swEquheWcZvUx6Jw6FnGaW4txSuMN8iO1vqqfxpYwHLc
 rihv9r4ukEUWygORNqJk7cYN+OcZ1pX9A0u2borK9sadcxCrtXYuRfwQ3BLeL8zEIf+0fmlTA9iLC
 vynyZYuW85rk//SYu0E8zfLranzhQTK5ooZVs9BqCvo9Xh2D95svI7rVyJyPzIwihZAwJbW3cjurY
 IWHRwC3BMJA6e1+nhLa47mT5Tz7gftAd7VBviRV0MwLibnmw7CI0y6/tuQkYJm2shLfazbxCYsl3T
 jFBOnQlw==;
Received: from 089144210182.atnat0019.highway.a1.net ([89.144.210.182]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtoYq-0000T2-Pm; Wed, 13 Feb 2019 07:02:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Olof Johansson <olof@lixom.net>
Subject: [PATCH 21/32] dma-mapping,
 powerpc: simplify the arch dma_set_mask override
Date: Wed, 13 Feb 2019 08:01:22 +0100
Message-Id: <20190213070133.11259-22-hch@lst.de>
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

Instead of letting the architecture supply all of dma_set_mask just
give it an additional hook selected by Kconfig.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Christian Zigotzky <chzigotzky@xenosoft.de>
---
 arch/powerpc/Kconfig                   |  1 +
 arch/powerpc/include/asm/dma-mapping.h |  2 --
 arch/powerpc/include/asm/machdep.h     |  2 +-
 arch/powerpc/kernel/Makefile           |  1 +
 arch/powerpc/kernel/dma-mask.c         | 12 ++++++++++++
 arch/powerpc/kernel/dma.c              | 12 ------------
 arch/powerpc/sysdev/fsl_pci.c          |  8 +-------
 kernel/dma/Kconfig                     |  3 +++
 kernel/dma/mapping.c                   |  9 +++++++--
 9 files changed, 26 insertions(+), 24 deletions(-)
 create mode 100644 arch/powerpc/kernel/dma-mask.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 8a4ae675c9ba..8af6a7d93148 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -883,6 +883,7 @@ config FSL_SOC
 
 config FSL_PCI
  	bool
+	select ARCH_HAS_DMA_SET_MASK
 	select PPC_INDIRECT_PCI
 	select PCI_QUIRKS
 
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index dc7f7bcdf65d..16d45518d9bb 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -110,7 +110,5 @@ static inline void set_dma_offset(struct device *dev, dma_addr_t off)
 		dev->archdata.dma_offset = off;
 }
 
-#define HAVE_ARCH_DMA_SET_MASK 1
-
 #endif /* __KERNEL__ */
 #endif	/* _ASM_DMA_MAPPING_H */
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
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index cb7f0bb9ee71..9bb12cd642ef 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -105,6 +105,7 @@ obj-$(CONFIG_UPROBES)		+= uprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 obj-$(CONFIG_STACKTRACE)	+= stacktrace.o
 obj-$(CONFIG_SWIOTLB)		+= dma-swiotlb.o
+obj-$(CONFIG_ARCH_HAS_DMA_SET_MASK) += dma-mask.o
 
 pci64-$(CONFIG_PPC64)		+= pci_dn.o pci-hotplug.o isa-bridge.o
 obj-$(CONFIG_PCI)		+= pci_$(BITS).o $(pci64-y) \
diff --git a/arch/powerpc/kernel/dma-mask.c b/arch/powerpc/kernel/dma-mask.c
new file mode 100644
index 000000000000..ffbbbc432612
--- /dev/null
+++ b/arch/powerpc/kernel/dma-mask.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/dma-mapping.h>
+#include <linux/export.h>
+#include <asm/machdep.h>
+
+void arch_dma_set_mask(struct device *dev, u64 dma_mask)
+{
+	if (ppc_md.dma_set_mask)
+		ppc_md.dma_set_mask(dev, dma_mask);
+}
+EXPORT_SYMBOL(arch_dma_set_mask);
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 1e191eb3f0ec..e422ca65d1cf 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -234,18 +234,6 @@ const struct dma_map_ops dma_nommu_ops = {
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
index b710cee023a2..0c6510f340cb 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -133,11 +133,8 @@ static void setup_swiotlb_ops(struct pci_controller *hose)
 static inline void setup_swiotlb_ops(struct pci_controller *hose) {}
 #endif
 
-static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
+static void fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 {
-	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
-		return -EIO;
-
 	/*
 	 * Fix up PCI devices that are able to DMA to the large inbound
 	 * mapping that allows addressing any RAM address from across PCI.
@@ -147,9 +144,6 @@ static int fsl_pci_dma_set_mask(struct device *dev, u64 dma_mask)
 		set_dma_ops(dev, &dma_nommu_ops);
 		set_dma_offset(dev, pci64_dma_offset);
 	}
-
-	*dev->dma_mask = dma_mask;
-	return 0;
 }
 
 static int setup_one_atmu(struct ccsr_pci __iomem *pci,
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index ca88b867e7fe..0711d18645de 100644
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
 
diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 40c0af744692..ef2aba503467 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -316,18 +316,23 @@ int dma_supported(struct device *dev, u64 mask)
 }
 EXPORT_SYMBOL(dma_supported);
 
-#ifndef HAVE_ARCH_DMA_SET_MASK
+#ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
+void arch_dma_set_mask(struct device *dev, u64 mask);
+#else
+#define arch_dma_set_mask(dev, mask)	do { } while (0)
+#endif
+
 int dma_set_mask(struct device *dev, u64 mask)
 {
 	if (!dev->dma_mask || !dma_supported(dev, mask))
 		return -EIO;
 
+	arch_dma_set_mask(dev, mask);
 	dma_check_mask(dev, mask);
 	*dev->dma_mask = mask;
 	return 0;
 }
 EXPORT_SYMBOL(dma_set_mask);
-#endif
 
 #ifndef CONFIG_ARCH_HAS_DMA_SET_COHERENT_MASK
 int dma_set_coherent_mask(struct device *dev, u64 mask)
-- 
2.20.1

