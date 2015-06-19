Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B75E81A1039
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:28:38 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 19 Jun 2015 12:28:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 21AD62BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:28:34 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5J2RAZg1966484
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:19 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5J2Qkdl023239
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:26:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 4/4] powerpc/powernv: Pick M64 PEs based on BARs
Date: Fri, 19 Jun 2015 12:26:19 +1000
Message-Id: <1434680779-20194-5-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1434680779-20194-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1434680779-20194-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PHB3, PE might be reserved in advance to reflect the M64 segments
consumed by the PE according to M64 BARs (exclude VF BARs) of the PCI
devices included in the PE. The PE is picked based on M64 BARs instead
of the bridge's M64 windows, which might include VF BARs. Otherwise,
wrong PE could be picked.

The patch calculates the used M64 segments and PE numbers according to
the M64 BARs, excluding VF BARs, of PCI devices in one particular PE,
instead of the bridge's M64 windows. Then the right PE number is picked.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 59 ++++---------------------------
 arch/powerpc/platforms/powernv/pci.h      |  2 +-
 2 files changed, 8 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 909ed58..5aa5b82 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -271,35 +271,18 @@ static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
 	}
 }
 
-static int pnv_ioda2_pick_m64_pe(struct pnv_phb *phb,
-				 struct pci_bus *bus, bool all)
+static int pnv_ioda2_pick_m64_pe(struct pci_bus *bus, bool all)
 {
-	resource_size_t segsz = phb->ioda.m64_segsize;
-	struct pci_dev *pdev;
-	struct resource *r;
+	struct pci_controller *hose = pci_bus_to_host(bus);
+	struct pnv_phb *phb = hose->private_data;
 	struct pnv_ioda_pe *master_pe, *pe;
 	unsigned long size, *pe_alloc;
-	bool found;
-	int start, i, j;
+	int i;
 
 	/* Root bus shouldn't use M64 */
 	if (pci_is_root_bus(bus))
 		return IODA_INVALID_PE;
 
-	/* We support only one M64 window on each bus */
-	found = false;
-	pci_bus_for_each_resource(bus, r, i) {
-		if (r && r->parent &&
-		    pnv_pci_is_mem_pref_64(r->flags)) {
-			found = true;
-			break;
-		}
-	}
-
-	/* No M64 window found ? */
-	if (!found)
-		return IODA_INVALID_PE;
-
 	/* Allocate bitmap */
 	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
 	pe_alloc = kzalloc(size, GFP_KERNEL);
@@ -309,35 +292,8 @@ static int pnv_ioda2_pick_m64_pe(struct pnv_phb *phb,
 		return IODA_INVALID_PE;
 	}
 
-	/*
-	 * Figure out reserved PE numbers by the PE
-	 * the its child PEs.
-	 */
-	start = (r->start - phb->ioda.m64_base) / segsz;
-	for (i = 0; i < resource_size(r) / segsz; i++)
-		set_bit(start + i, pe_alloc);
-
-	if (all)
-		goto done;
-
-	/*
-	 * If the PE doesn't cover all subordinate buses,
-	 * we need subtract from reserved PEs for children.
-	 */
-	list_for_each_entry(pdev, &bus->devices, bus_list) {
-		if (!pdev->subordinate)
-			continue;
-
-		pci_bus_for_each_resource(pdev->subordinate, r, i) {
-			if (!r || !r->parent ||
-			    !pnv_pci_is_mem_pref_64(r->flags))
-				continue;
-
-			start = (r->start - phb->ioda.m64_base) / segsz;
-			for (j = 0; j < resource_size(r) / segsz ; j++)
-				clear_bit(start + j, pe_alloc);
-                }
-        }
+	/* Figure out reserved PE numbers by the PE */
+	pnv_ioda2_reserve_m64_pe(bus, pe_alloc, all);
 
 	/*
 	 * the current bus might not own M64 window and that's all
@@ -353,7 +309,6 @@ static int pnv_ioda2_pick_m64_pe(struct pnv_phb *phb,
 	 * Figure out the master PE and put all slave PEs to master
 	 * PE's list to form compound PE.
 	 */
-done:
 	master_pe = NULL;
 	i = -1;
 	while ((i = find_next_bit(pe_alloc, phb->ioda.total_pe, i + 1)) <
@@ -1073,7 +1028,7 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 
 	/* Check if PE is determined by M64 */
 	if (phb->pick_m64_pe)
-		pe_num = phb->pick_m64_pe(phb, bus, all);
+		pe_num = phb->pick_m64_pe(bus, all);
 
 	/* The PE number isn't pinned by M64 */
 	if (pe_num == IODA_INVALID_PE)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 5915cd2..e891ff4 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -112,7 +112,7 @@ struct pnv_phb {
 	int (*init_m64)(struct pnv_phb *phb);
 	void (*reserve_m64_pe)(struct pci_bus *bus,
 			       unsigned long *pe_bitmap, bool all);
-	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, bool all);
+	int (*pick_m64_pe)(struct pci_bus *bus, bool all);
 	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
 	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
 	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
-- 
2.1.0
