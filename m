Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B97E81A03ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:24 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 19 Jun 2015 12:27:24 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 351A13578055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:20 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5J2RAPI57671720
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:27:19 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5J2Qkgk001059
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jun 2015 12:26:46 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 3/4] powerpc/powernv: Boolean argument for
 pnv_ioda_setup_bus_PE()
Date: Fri, 19 Jun 2015 12:26:18 +1000
Message-Id: <1434680779-20194-4-git-send-email-gwshan@linux.vnet.ibm.com>
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

The patch changes the type of last argument of pnv_ioda_setup_bus_PE()
and phb::pick_m64_pe() to boolean. No functional change.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++----
 arch/powerpc/platforms/powernv/pci.h      | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b1d9fec..909ed58 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -272,7 +272,7 @@ static void pnv_ioda2_reserve_m64_pe(struct pci_bus *bus,
 }
 
 static int pnv_ioda2_pick_m64_pe(struct pnv_phb *phb,
-				 struct pci_bus *bus, int all)
+				 struct pci_bus *bus, bool all)
 {
 	resource_size_t segsz = phb->ioda.m64_segsize;
 	struct pci_dev *pdev;
@@ -1064,7 +1064,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
  * subordinate PCI devices and buses. The second type of PE is normally
  * orgiriated by PCIe-to-PCI bridge or PLX switch downstream ports.
  */
-static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
+static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -1131,12 +1131,12 @@ static void pnv_ioda_setup_PEs(struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
-	pnv_ioda_setup_bus_PE(bus, 0);
+	pnv_ioda_setup_bus_PE(bus, false);
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (dev->subordinate) {
 			if (pci_pcie_type(dev) == PCI_EXP_TYPE_PCI_BRIDGE)
-				pnv_ioda_setup_bus_PE(dev->subordinate, 1);
+				pnv_ioda_setup_bus_PE(dev->subordinate, true);
 			else
 				pnv_ioda_setup_PEs(dev->subordinate);
 		}
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index c6ddd18..5915cd2 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -112,7 +112,7 @@ struct pnv_phb {
 	int (*init_m64)(struct pnv_phb *phb);
 	void (*reserve_m64_pe)(struct pci_bus *bus,
 			       unsigned long *pe_bitmap, bool all);
-	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, int all);
+	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, bool all);
 	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
 	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
 	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
-- 
2.1.0
