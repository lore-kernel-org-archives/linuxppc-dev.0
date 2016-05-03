Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSx0BlSzDqCM
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:12 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:43:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id F32453578068
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435h1jq63111224
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:43:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gbwK019529
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 09/26] powerpc/powernv: IO and M32 mapping based on PCI
 device resources
Date: Tue,  3 May 2016 15:41:28 +1000
Message-Id: <1462254105-24128-10-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, the IO and M32 segments are mapped to the corresponding
PE based on the windows of the parent bridge of PE's primary bus.
It's not going to work when the windows of root port or upstream
port of the PCIe switch behind root port are extended to PHB's
apertures in order to support hotplug in subsequent patch.

This fixes the issue by mapping IO and M32 segments based on the
resources of the PCI devices included in the PE, instead of the
windows of the parent bridge of the PE's primary bus.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b954fbc..904790b 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2993,7 +2993,7 @@ static void pnv_ioda_setup_pe_res(struct pnv_ioda_pe *pe,
  */
 static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
 {
-	struct resource *res;
+	struct pci_dev *pdev;
 	int i;
 
 	/*
@@ -3003,8 +3003,21 @@ static void pnv_ioda_setup_pe_seg(struct pnv_ioda_pe *pe)
 	 */
 	BUG_ON(!(pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)));
 
-	pci_bus_for_each_resource(pe->pbus, res, i)
-		pnv_ioda_setup_pe_res(pe, res);
+	list_for_each_entry(pdev, &pe->pbus->devices, bus_list) {
+		for (i = 0; i <= PCI_ROM_RESOURCE; i++)
+			pnv_ioda_setup_pe_res(pe, &pdev->resource[i]);
+
+		/*
+		 * If the PE contains all subordinate PCI buses, the
+		 * windows of the child bridges should be mapped to
+		 * the PE as well.
+		 */
+		if (!(pe->flags & PNV_IODA_PE_BUS_ALL) || !pci_is_bridge(pdev))
+			continue;
+		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++)
+			pnv_ioda_setup_pe_res(pe,
+				&pdev->resource[PCI_BRIDGE_RESOURCES + i]);
+	}
 }
 
 static void pnv_pci_ioda_setup_seg(void)
-- 
2.1.0
