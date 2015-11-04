Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3136D1A0D76
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:14:49 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:44:48 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A255A394005B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:44:43 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DEgKV590262
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:44:42 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DD9jj031674
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:10 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 13/50] powerpc/powernv: Rename M64 related functions
Date: Thu,  5 Nov 2015 00:12:13 +1100
Message-Id: <1446642770-4681-14-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 76ce694..1f7d985 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -229,7 +229,7 @@ fail:
 	return -EIO;
 }
 
-static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
+static void pnv_ioda_reserve_dev_m64_pe(struct pci_dev *pdev,
 					 unsigned long *pe_bitmap)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
@@ -256,22 +256,22 @@ static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
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
 
-static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
+static int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -293,7 +293,7 @@ static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
 	}
 
 	/* Figure out reserved PE numbers by the PE */
-	pnv_ioda2_reserve_m64_pe(bus, pe_alloc, all);
+	pnv_ioda_reserve_m64_pe(bus, pe_alloc, all);
 
 	/*
 	 * the current bus might not own M64 window and that's all
@@ -374,8 +374,8 @@ static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
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
