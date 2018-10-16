Return-Path: <SRS0=rnOA=M4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF2FC04EB9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:36:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47095208D9
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 02:36:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47095208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YzvQ178TzDrdd
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Oct 2018 13:36:02 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (unknown [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 42YzsK0nrnzDrdd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Oct 2018 13:34:13 +1100 (AEDT)
Received: from vpl1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 29FCAAE80026;
 Mon, 15 Oct 2018 22:34:10 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel] powerpc/powernv/ioda: Reduce a number of hooks in
 pnv_phb
Date: Tue, 16 Oct 2018 13:34:09 +1100
Message-Id: <20181016023409.42238-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.11.0
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

fixup_phb() is never used, this removes it.

pick_m64_pe() and reserve_m64_pe() are always defined for all powernv
PHBs: they are initialized by pnv_ioda_parse_m64_window() which is
called unconditionally from pnv_pci_init_ioda_phb() which initializes
all known PHB types on powernv so we can open code them.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci.h      | 4 ----
 arch/powerpc/platforms/powernv/pci-ioda.c | 9 +++------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8b37b28..2131373 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -115,11 +115,7 @@ struct pnv_phb {
 			 unsigned int hwirq, unsigned int virq,
 			 unsigned int is_64, struct msi_msg *msg);
 	void (*dma_dev_setup)(struct pnv_phb *phb, struct pci_dev *pdev);
-	void (*fixup_phb)(struct pci_controller *hose);
 	int (*init_m64)(struct pnv_phb *phb);
-	void (*reserve_m64_pe)(struct pci_bus *bus,
-			       unsigned long *pe_bitmap, bool all);
-	struct pnv_ioda_pe *(*pick_m64_pe)(struct pci_bus *bus, bool all);
 	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
 	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
 	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 78b61f0..15a4556 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -518,8 +518,6 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 		phb->init_m64 = pnv_ioda1_init_m64;
 	else
 		phb->init_m64 = pnv_ioda2_init_m64;
-	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
-	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
 }
 
 static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
@@ -1161,8 +1159,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 		pe = &phb->ioda.pe_array[phb->ioda.root_pe_idx];
 
 	/* Check if PE is determined by M64 */
-	if (!pe && phb->pick_m64_pe)
-		pe = phb->pick_m64_pe(bus, all);
+	if (!pe)
+		pe = pnv_ioda_pick_m64_pe(bus, all);
 
 	/* The PE number isn't pinned by M64 */
 	if (!pe)
@@ -3395,8 +3393,7 @@ static void pnv_pci_setup_bridge(struct pci_bus *bus, unsigned long type)
 		return;
 
 	/* Reserve PEs according to used M64 resources */
-	if (phb->reserve_m64_pe)
-		phb->reserve_m64_pe(bus, NULL, all);
+	pnv_ioda_reserve_m64_pe(bus, NULL, all);
 
 	/*
 	 * Assign PE. We might run here because of partial hotplug.
-- 
2.11.0

