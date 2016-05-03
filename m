Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSx6yrnzDqCc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:13 +1000 (AEST)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:43:12 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CAB382CE8063
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:09 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435h1ou131504
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:43:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gbYX027902
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 11/26] powerpc/powernv: Rename M64 related functions
Date: Tue,  3 May 2016 15:41:30 +1000
Message-Id: <1462254105-24128-12-git-send-email-gwshan@linux.vnet.ibm.com>
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

This renames those functions picking PE number based on consumed
M64 segments, mapping M64 segments to PEs as those functions are
going to be shared by IODA1/IODA2 in next patch. No logical changes
introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 832b430..37f22b0 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -219,7 +219,7 @@ fail:
 	return -EIO;
 }
 
-static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
+static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
 					 unsigned long *pe_bitmap)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
@@ -246,22 +246,22 @@ static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
 	}
 }
 
-static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
-				     unsigned long *pe_bitmap,
-				     bool all)
+static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
+				    unsigned long *pe_bitmap,
+				    bool all)
 {
 	struct pci_dev *pdev;
 
 	list_for_each_entry(pdev, &bus->devices, bus_list) {
-		pnv_ioda2_reserve_dev_m64_pe(pdev, pe_bitmap);
+		pnv_ioda_reserve_dev_m64_pe(pdev, pe_bitmap);
 
 		if (all && pdev->subordinate)
-			pnv_ioda2_reserve_m64_pe(pdev->subordinate,
-						 pe_bitmap, all);
+			pnv_ioda_reserve_m64_pe(pdev->subordinate,
+						pe_bitmap, all);
 	}
 }
 
-static unsigned int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
+static unsigned int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -283,7 +283,7 @@ static unsigned int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
 	}
 
 	/* Figure out reserved PE numbers by the PE */
-	pnv_ioda2_reserve_m64_pe(bus, pe_alloc, all);
+	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
 
 	/*
 	 * the current bus might not own M64 window and that's all
@@ -365,8 +365,8 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
 	/* Use last M64 BAR to cover M64 window */
 	phb->ioda.m64_bar_idx = 15;
 	phb->init_m64 = pnv_ioda2_init_m64;
-	phb->reserve_m64_pe = pnv_ioda2_reserve_m64_pe;
-	phb->pick_m64_pe = pnv_ioda2_pick_m64_pe;
+	phb->reserve_m64_pe = pnv_ioda_reserve_m64_pe;
+	phb->pick_m64_pe = pnv_ioda_pick_m64_pe;
 }
 
 static void pnv_ioda_freeze_pe(struct pnv_phb *phb, int pe_no)
-- 
2.1.0
