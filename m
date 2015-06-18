Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5F31C1A0431
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 11:42:40 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 18 Jun 2015 11:42:37 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1272A2BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 11:42:35 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5I1gQ2j590226
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 11:42:34 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5I1g1lO019162
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 11:42:01 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: aik@ozlabs.ru, mpe@ellerman.id.au
Subject: [PATCH] powerpc/powernv: Fix wrong IOMMU table in
 pnv_ioda_setup_bus_dma()
Date: Thu, 18 Jun 2015 11:41:36 +1000
Message-Id: <1434591696-16920-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alexey Kardashevskiy <aik@ozlabs.ru>

When pnv_pci_ioda_fixup() is called during PHB fixup time, each PE in
the sorted list of PEs (phb::pe_dma_list) is iterated to setup the PE's
DMA32 space by pnv_ioda_setup_bus_dma() if the PE's DMA32 weight is bigger
than zero. The function also assigns all the subordinate PCI devices of
the PE's primary bus with the PE's DMA32 IOMMU table. It causes the PCI
devicess in the child PEs, which don't have DMA weight, receives wrong
IOMMU table and then IOMMU group.

The patch fixes above issue by more check on the PE's coverage and don't
assign IOMMU table to those PCI devices, which belong to the child PEs.
The problem was found on Firestone platform initially.

Suggested-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
v2: reworked commitlog
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8424f5c..5738d31 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1661,7 +1661,7 @@ static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
 		set_iommu_table_base(&dev->dev, pe->table_group.tables[0]);
 		iommu_add_device(&dev->dev);
 
-		if (dev->subordinate)
+		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
 	}
 }
-- 
2.1.0
