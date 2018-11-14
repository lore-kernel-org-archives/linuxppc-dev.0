Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8921C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 06:22:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CD3221780
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 06:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPC7vf2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD3221780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vvYV0PTdzF35b
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 17:22:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JPC7vf2A";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=oohall@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="JPC7vf2A"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vvVp6p34zF3Ph
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 17:20:18 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id e22-v6so7361845pfn.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 22:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=gk2ODjPPsCuuKvnvYZIQSStDHzlRIg856CysXETbwFU=;
 b=JPC7vf2Aip/bsUZOga29RpwgZupNCPZjNKzMw9ZNi+EGDQGL0HQBpOcZniNnZiRVNH
 H/ZkHSl94aOZcV0pOonH7jlhd79a2poQEeFAl4vxDDwk8CDPZo6HOVr7rTNyTbspQn7u
 /gwuQJRgSISPvxcPlDWzVwNQhSz5g+mM9tD7CBzMgLMbh3BtMj7wipt7Bxk/LrxuZ7BO
 Z11DVFNu7OB8huuXJaNKzgPac69blPhbdCmW+QBVPj4hdzolJRcDK+GBkGBZ04ogV1DA
 C+ER+hbfpifToRVbWoiur0Tmovukce85Rd2OTzoefjgedm06RMk9Ks9pTu9r24AkD3/p
 HThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=gk2ODjPPsCuuKvnvYZIQSStDHzlRIg856CysXETbwFU=;
 b=o82i8qw0a98QTttAP1/f1Nehlqbhh49a69UvkTUe//mnaNdFqxmg7GPZgtD6BQ68zX
 H0uIPRnKkgX11syKpFjBruExB6LD6gpq+OcxUaCrFcQfx1+6o1aPs/d3WYl5dpucmDHx
 7UO+/pjWFBlW55can3Fgwube1VXZv3oGzUhtlz3pc8SCaHaeV8BjZHZhvzk0vIoBct41
 FchqvU+KaQ08B7lLgXze9qqvkIiGX6wYS3Nz7JTkmJ1vs9Gh2frpOcsV7nM0qX8g85rR
 43nJQgUPKESzz3LBRVc5RiTpUGJMa7j3AlUqLZNYoAIDNt/fQMmTAMtex19Z/sPhaRgc
 XwZw==
X-Gm-Message-State: AGRZ1gJaFQ+ndEk0IEQBDmCaL8HY0R2J9QxUJNvleb6LuL0HmSvUU8iJ
 RMsFVa2TqAjUmOLntnv3hqDf0n2z
X-Google-Smtp-Source: AJdET5efbrrT5+A0Mgq3ITia6KT5b/MhTwbrQ8RDuFXINNPIHsf31L/dr9SO0nXtQRfuhQyucA18dQ==
X-Received: by 2002:a63:8ac4:: with SMTP id y187mr594080pgd.446.1542176416402; 
 Tue, 13 Nov 2018 22:20:16 -0800 (PST)
Received: from wafer.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id h8sm3795671pgv.27.2018.11.13.22.20.14
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 13 Nov 2018 22:20:15 -0800 (PST)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/powernv: Remove PCI_MSI ifdef checks
Date: Wed, 14 Nov 2018 17:19:58 +1100
Message-Id: <20181114061958.3462-1-oohall@gmail.com>
X-Mailer: git-send-email 2.17.2
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

CONFIG_PCI_MSI was made mandatory by commit a311e738b6d8
("powerpc/powernv: Make PCI non-optional") so the #ifdef
checks around CONFIG_PCI_MSI here can be removed entirely.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 13 -------------
 arch/powerpc/platforms/powernv/pci.c      |  2 --
 arch/powerpc/platforms/powernv/pci.h      |  2 --
 3 files changed, 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cde710297a4e..90c5ea1e16f3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -664,10 +664,6 @@ static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
 	return state;
 }
 
-/* Currently those 2 are only used when MSIs are enabled, this will change
- * but in the meantime, we need to protect them to avoid warnings
- */
-#ifdef CONFIG_PCI_MSI
 struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 {
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
@@ -680,7 +676,6 @@ struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
 		return NULL;
 	return &phb->ioda.pe_array[pdn->pe_number];
 }
-#endif /* CONFIG_PCI_MSI */
 
 static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
 				  struct pnv_ioda_pe *parent,
@@ -2837,7 +2832,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 }
 
-#ifdef CONFIG_PCI_MSI
 int64_t pnv_opal_pci_msi_eoi(struct irq_chip *chip, unsigned int hw_irq)
 {
 	struct pnv_phb *phb = container_of(chip, struct pnv_phb,
@@ -2983,9 +2977,6 @@ static void pnv_pci_init_ioda_msis(struct pnv_phb *phb)
 	pr_info("  Allocated bitmap for %d MSIs (base IRQ 0x%x)\n",
 		count, phb->msi_base);
 }
-#else
-static void pnv_pci_init_ioda_msis(struct pnv_phb *phb) { }
-#endif /* CONFIG_PCI_MSI */
 
 #ifdef CONFIG_PCI_IOV
 static void pnv_pci_ioda_fixup_iov_resources(struct pci_dev *pdev)
@@ -3699,10 +3690,8 @@ static void pnv_pci_ioda_shutdown(struct pci_controller *hose)
 static const struct pci_controller_ops pnv_pci_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_dma_dev_setup,
 	.dma_bus_setup		= pnv_pci_dma_bus_setup,
-#ifdef CONFIG_PCI_MSI
 	.setup_msi_irqs		= pnv_setup_msi_irqs,
 	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
-#endif
 	.enable_device_hook	= pnv_pci_enable_device_hook,
 	.release_device		= pnv_pci_release_device,
 	.window_alignment	= pnv_pci_window_alignment,
@@ -3723,10 +3712,8 @@ static int pnv_npu_dma_set_mask(struct pci_dev *npdev, u64 dma_mask)
 
 static const struct pci_controller_ops pnv_npu_ioda_controller_ops = {
 	.dma_dev_setup		= pnv_pci_dma_dev_setup,
-#ifdef CONFIG_PCI_MSI
 	.setup_msi_irqs		= pnv_setup_msi_irqs,
 	.teardown_msi_irqs	= pnv_teardown_msi_irqs,
-#endif
 	.enable_device_hook	= pnv_pci_enable_device_hook,
 	.window_alignment	= pnv_pci_window_alignment,
 	.reset_secondary_bus	= pnv_pci_reset_secondary_bus,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 13aef2323bbc..583fb2e64893 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -160,7 +160,6 @@ int pnv_pci_set_power_state(uint64_t id, uint8_t state, struct opal_msg *msg)
 }
 EXPORT_SYMBOL_GPL(pnv_pci_set_power_state);
 
-#ifdef CONFIG_PCI_MSI
 int pnv_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
@@ -229,7 +228,6 @@ void pnv_teardown_msi_irqs(struct pci_dev *pdev)
 		msi_bitmap_free_hwirqs(&phb->msi_bmp, hwirq - phb->msi_base, 1);
 	}
 }
-#endif /* CONFIG_PCI_MSI */
 
 /* Nicely print the contents of the PE State Tables (PEST). */
 static void pnv_pci_dump_pest(__be64 pestA[], __be64 pestB[], int pest_size)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8b37b28e3831..99ac2bd0cf51 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -106,11 +106,9 @@ struct pnv_phb {
 	struct dentry		*dbgfs;
 #endif
 
-#ifdef CONFIG_PCI_MSI
 	unsigned int		msi_base;
 	unsigned int		msi32_support;
 	struct msi_bitmap	msi_bmp;
-#endif
 	int (*msi_setup)(struct pnv_phb *phb, struct pci_dev *dev,
 			 unsigned int hwirq, unsigned int virq,
 			 unsigned int is_64, struct msi_msg *msg);
-- 
2.17.2

