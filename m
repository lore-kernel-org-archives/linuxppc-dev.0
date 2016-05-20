Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9z0M35qZzDqG1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:15 +1000 (AEST)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 20 May 2016 16:43:15 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 83D8B2BB005A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:12 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4K6h4Hv7405884
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:43:12 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4K6gd9B032391
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 16:42:40 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 alistair@popple.id.au, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v10 04/18] powerpc/powernv: Move
 pnv_pci_ioda_setup_opal_tce_kill() around
Date: Fri, 20 May 2016 16:41:28 +1000
Message-Id: <1463726502-14679-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3a5ea82..3ce9867 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2702,8 +2702,6 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 	pr_info("PCI: Domain %04x has %d available 32-bit DMA segments\n",
 		hose->global_number, phb->ioda.dma32_count);
 
-	pnv_pci_ioda_setup_opal_tce_kill(phb);
-
 	/* Walk our PE list and configure their DMA segments */
 	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
 		weight = pnv_pci_ioda_pe_dma_weight(pe);
@@ -3480,6 +3478,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
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
