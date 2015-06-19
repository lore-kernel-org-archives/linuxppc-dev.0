Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 079571A0EF6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:24 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 19 Jun 2015 12:27:22 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id AE58D2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:19 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5J2RAv842074182
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:19 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5J2QjAH025979
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:26:45 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/4] powerpc/powernv: Reserve M64 PEs based on BARs
Date: Fri, 19 Jun 2015 12:26:17 +1000
Message-Id: <1434680779-20194-3-git-send-email-gwshan@linux.vnet.ibm.com>
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

On PHB3, some PEs might be reserved in advance to reflect the M64
segments consumed by those PEs. We're reserving PEs based on the
M64 window of root port, which might contain VF BAR. The PEs for
VFs are allocated dynamically, not reserved based on the consumed
M64 segments. So the M64 window of root port isn't reliable for
the task. Instead, we go through M64 BARs (VF BARs excluded) of
PCI devices under the specified root bus and reserve PEs accordingly,
as the patch does.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 56 ++++++++++++++++++++-----------
 arch/powerpc/platforms/powernv/pci.h      |  3 +-
 2 files changed, 38 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d5bfa76..b1d9fec 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -229,32 +229,48 @@ fail:
 	return -EIO;
 }
 
-static void pnv_ioda2_reserve_m64_pe(struct pnv_phb *phb)
+static void pnv_ioda2_reserve_dev_m64_pe(struct pci_dev *pdev,
+					 unsigned long *pe_bitmap)
 {
-	resource_size_t sgsz = phb->ioda.m64_segsize;
-	struct pci_dev *pdev;
+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
+	struct pnv_phb *phb = hose->private_data;
 	struct resource *r;
-	int base, step, i;
-
-	/*
-	 * Root bus always has full M64 range and root port has
-	 * M64 range used in reality. So we're checking root port
-	 * instead of root bus.
-	 */
-	list_for_each_entry(pdev, &phb->hose->bus->devices, bus_list) {
-		for (i = 0; i < PCI_BRIDGE_RESOURCE_NUM; i++) {
-			r = &pdev->resource[PCI_BRIDGE_RESOURCES + i];
-			if (!r->parent ||
-			    !pnv_pci_is_mem_pref_64(r->flags))
-				continue;
+	resource_size_t base, sgsz, start, end;
+	int segno, i;
+
+	base = phb->ioda.m64_base;
+	sgsz = phb->ioda.m64_segsize;
+	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
+		r = &pdev->resource[i];
+		if (!r->parent || !pnv_pci_is_mem_pref_64(r->flags))
+			continue;
 
-			base = (r->start - phb->ioda.m64_base) / sgsz;
-			for (step = 0; step < resource_size(r) / sgsz; step++)
-				pnv_ioda_reserve_pe(phb, base + step);
+		start = _ALIGN_DOWN(r->start - base, sgsz);
+		end = _ALIGN_UP(r->end - base, sgsz);
+		for (segno = start / sgsz; segno < end / sgsz; segno++) {
+			if (pe_bitmap)
+				set_bit(segno, pe_bitmap);
+			else
+				pnv_ioda_reserve_pe(phb, segno);
 		}
 	}
 }
 
+static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
+				     unsigned long *pe_bitmap,
+				     bool all)
+{
+	struct pci_dev *pdev;
+
+	list_for_each_entry(pdev, &bus->devices, bus_list) {
+		pnv_ioda2_reserve_dev_m64_pe(pdev, pe_bitmap);
+
+		if (all && pdev->subordinate)
+			pnv_ioda2_reserve_m64_pe(pdev->subordinate,
+						 pe_bitmap, all);
+	}
+}
+
 static int pnv_ioda2_pick_m64_pe(struct pnv_phb *phb,
 				 struct pci_bus *bus, int all)
 {
@@ -1145,7 +1161,7 @@ static void pnv_pci_ioda_setup_PEs(void)
 
 		/* M64 layout might affect PE allocation */
 		if (phb->reserve_m64_pe)
-			phb->reserve_m64_pe(phb);
+			phb->reserve_m64_pe(hose->bus, NULL, true);
 
 		pnv_ioda_setup_PEs(hose->bus);
 	}
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 8ef2d28..c6ddd18 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -110,7 +110,8 @@ struct pnv_phb {
 	void (*fixup_phb)(struct pci_controller *hose);
 	u32 (*bdfn_to_pe)(struct pnv_phb *phb, struct pci_bus *bus, u32 devfn);
 	int (*init_m64)(struct pnv_phb *phb);
-	void (*reserve_m64_pe)(struct pnv_phb *phb);
+	void (*reserve_m64_pe)(struct pci_bus *bus,
+			       unsigned long *pe_bitmap, bool all);
 	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, int all);
 	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
 	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
-- 
2.1.0
