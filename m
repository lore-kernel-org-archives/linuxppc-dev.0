Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzhhW12YPzDqCn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:55 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 23:23:54 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 61034357805B
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 23:23:52 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u43DNiPr7995742
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 23:23:52 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u43DNJPZ028575
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 23:23:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, robherring2@gmail.com, dja@axtens.net,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 03/22] powerpc/powernv: Move
 pnv_pci_ioda_setup_opal_tce_kill() around
Date: Tue,  3 May 2016 23:22:34 +1000
Message-Id: <1462281773-26438-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462281773-26438-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

pnv_pci_ioda_setup_opal_tce_kill() called by pnv_ioda_setup_dma()
to remap the TCE kill regiter. What's done in pnv_ioda_setup_dma()
will be covered in pcibios_setup_bridge() which is invoked on each
PCI bridge. It means we will possibly remap the TCE kill register
for multiple times and it's unnecessary.

This moves pnv_pci_ioda_setup_opal_tce_kill() to where the PHB is
initialized (pnv_pci_init_ioda_phb()) to avoid above issue.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5ee8a57..cbd4c0b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2599,8 +2599,6 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 	pr_info("PCI: Domain %04x has %d available 32-bit DMA segments\n",
 		hose->global_number, phb->ioda.dma32_count);
 
-	pnv_pci_ioda_setup_opal_tce_kill(phb);
-
 	/* Walk our PE list and configure their DMA segments */
 	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
 		weight = pnv_pci_ioda_pe_dma_weight(pe);
@@ -3396,6 +3394,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	if (phb->regs == NULL)
 		pr_err("  Failed to map registers !\n");
 
+	/* Initialize TCE kill register */
+	pnv_pci_ioda_setup_opal_tce_kill(phb);
+
 	/* Initialize more IODA stuff */
 	phb->ioda.total_pe_num = 1;
 	prop32 = of_get_property(np, "ibm,opal-num-pes", NULL);
-- 
2.1.0
