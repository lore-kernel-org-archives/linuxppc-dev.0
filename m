Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D897A1A0EBD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:45:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:45:16 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D5FED2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:45:14 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hpgW34668558
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:59 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546hPDG002188
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:26 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 17/42] powerpc/powernv: PE oriented during configuration
Date: Thu,  4 Jun 2015 16:41:46 +1000
Message-Id: <1433400131-18429-18-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Except pnv_ioda_configure_pe(), all PE configuration related functions
are already PE oriented. The patch changes the return value from PE
number to PE instance for its callee for the purpose.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 07/21]
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 44 ++++++++++++++++---------------
 arch/powerpc/platforms/powernv/pci.h      |  3 ++-
 2 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fd2f898..6187f84 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -132,25 +132,26 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
-static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
+static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 {
 	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
 		pr_warn("%s: Invalid PE %d on PHB#%x\n",
 			__func__, pe_no, phb->hose->global_number);
-		return;
+		return NULL;
 	}
 
 	if (test_and_set_bit(pe_no, phb->ioda.pe_alloc)) {
 		pr_warn("%s: PE %d was assigned on PHB#%x\n",
 			__func__, pe_no, phb->hose->global_number);
-		return;
+		return NULL;
 	}
 
 	phb->ioda.pe_array[pe_no].phb = phb;
 	phb->ioda.pe_array[pe_no].pe_number = pe_no;
+	return &phb->ioda.pe_array[pe_no];
 }
 
-static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
+static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
 	unsigned long pe_no;
 	unsigned long limit = phb->ioda.total_pe - 1;
@@ -163,12 +164,12 @@ static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 			break;
 
 		if (--limit >= phb->ioda.total_pe)
-			return IODA_INVALID_PE;
+			return NULL;
 	} while (1);
 
 	phb->ioda.pe_array[pe_no].phb = phb;
 	phb->ioda.pe_array[pe_no].pe_number = pe_no;
-	return pe_no;
+	return &phb->ioda.pe_array[pe_no];
 }
 
 static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
@@ -389,8 +390,8 @@ static void pnv_ioda_reserve_m64_pe(struct pnv_phb *phb,
 	}
 }
 
-static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
-				struct pci_bus *bus, int all)
+static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
+						struct pci_bus *bus, int all)
 {
 	resource_size_t segsz = phb->ioda.m64_segsize;
 	struct pci_dev *pdev;
@@ -401,13 +402,13 @@ static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
 	int i;
 
 	if (!pnv_ioda_need_m64_pe(phb, bus))
-		return IODA_INVALID_PE;
+		return NULL;
 
 	/* Allocate bitmap */
 	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
 	pe_bitmap = kzalloc(size, GFP_KERNEL);
 	if (!pe_bitmap)
-		return IODA_INVALID_PE;
+		return NULL;
 
 	/* The bridge's M64 window might be extended to PHB's M64
 	 * window by intention to support PCI hotplug. So we have
@@ -444,7 +445,7 @@ static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
 	/* No M64 window found ? */
 	if (bitmap_empty(pe_bitmap, phb->ioda.total_pe)) {
 		kfree(pe_bitmap);
-		return IODA_INVALID_PE;
+		return NULL;
 	}
 
 	/* Figure out the master PE and put all slave PEs
@@ -495,7 +496,7 @@ static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
 	}
 
 	kfree(pe_bitmap);
-	return master_pe->pe_number;
+	return master_pe;
 }
 
 static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
@@ -1224,7 +1225,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
-	struct pnv_ioda_pe *pe;
+	struct pnv_ioda_pe *pe = NULL;
 	int pe_num = IODA_INVALID_PE;
 
 	/* For partial hotplug case, the PE instance hasn't been destroyed
@@ -1240,24 +1241,25 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 	}
 
 	/* PE number for root bus should have been reserved */
-	if (pci_is_root_bus(bus))
-		pe_num = phb->ioda.root_pe;
+	if (pci_is_root_bus(bus) &&
+	    phb->ioda.root_pe != IODA_INVALID_PE)
+		pe = &phb->ioda.pe_array[phb->ioda.root_pe];
 
 	/* Check if PE is determined by M64 */
-	if (pe_num == IODA_INVALID_PE && phb->pick_m64_pe)
-		pe_num = phb->pick_m64_pe(phb, bus, all);
+	if (!pe && phb->pick_m64_pe)
+		pe = phb->pick_m64_pe(phb, bus, all);
 
 	/* The PE number isn't pinned by M64 */
-	if (pe_num == IODA_INVALID_PE)
-		pe_num = pnv_ioda_alloc_pe(phb);
+	if (!pe)
+		pe = pnv_ioda_alloc_pe(phb);
 
-	if (pe_num == IODA_INVALID_PE) {
+	if (!pe) {
 		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
 			__func__, pci_domain_nr(bus), bus->number);
 		return NULL;
 	}
 
-	pe = &phb->ioda.pe_array[pe_num];
+	pe_num = pe->pe_number;
 	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
 	pe->pbus = bus;
 	pe->pdev = NULL;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 45a6450..64c7f03 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -119,7 +119,8 @@ struct pnv_phb {
 	void (*shutdown)(struct pnv_phb *phb);
 	int (*init_m64)(struct pnv_phb *phb);
 	void (*reserve_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus);
-	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, int all);
+	struct pnv_ioda_pe * (*pick_m64_pe)(struct pnv_phb *phb,
+					    struct pci_bus *bus, int all);
 	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
 	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
 	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
-- 
2.1.0
