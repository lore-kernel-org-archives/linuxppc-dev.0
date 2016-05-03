Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzVSy0XNszDqB9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:14 +1000 (AEST)
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 3 May 2016 15:43:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 89D353578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 15:43:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u435h1p830671100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:43:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u435gafx019432
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 3 May 2016 15:42:37 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 alistair@popple.id.au, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v9 17/26] powerpc/powernv: Use PE instead of number during
 setup and release
Date: Tue,  3 May 2016 15:41:36 +1000
Message-Id: <1462254105-24128-18-git-send-email-gwshan@linux.vnet.ibm.com>
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

In current implementation, the PEs that are allocated or picked
from the reserved list are identified by PE number. The PE instance
has to be picked according to the PE number eventually. We have
same issue when PE is released.

For pnv_ioda_pick_m64_pe() and pnv_ioda_alloc_pe(), this returns
PE instance so that pnv_ioda_setup_bus_PE() can use the allocated
or reserved PE instance directly. Also, pnv_ioda_setup_bus_PE()
returns the reserved/allocated PE instance to be used in subsequent
patches. On the other hand, pnv_ioda_free_pe() uses PE instance
(not number) as its argument. No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 104 +++++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci.h      |   2 +-
 2 files changed, 59 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index cfd2906..5ee8a57 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -123,6 +123,14 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
+{
+	phb->ioda.pe_array[pe_no].phb = phb;
+	phb->ioda.pe_array[pe_no].pe_number = pe_no;
+
+	return &phb->ioda.pe_array[pe_no];
+}
+
 static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 {
 	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe_num)) {
@@ -135,11 +143,10 @@ static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
 		pr_debug("%s: PE %d was reserved on PHB#%x\n",
 			 __func__, pe_no, phb->hose->global_number);
 
-	phb->ioda.pe_array[pe_no].phb = phb;
-	phb->ioda.pe_array[pe_no].pe_number = pe_no;
+	pnv_ioda_init_pe(phb, pe_no);
 }
 
-static unsigned int pnv_ioda_alloc_pe(struct pnv_phb *phb)
+static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
 {
 	unsigned long pe;
 
@@ -147,20 +154,20 @@ static unsigned int pnv_ioda_alloc_pe(struct pnv_phb *phb)
 		pe = find_next_zero_bit(phb->ioda.pe_alloc,
 					phb->ioda.total_pe_num, 0);
 		if (pe >= phb->ioda.total_pe_num)
-			return IODA_INVALID_PE;
+			return NULL;
 	} while(test_and_set_bit(pe, phb->ioda.pe_alloc));
 
-	phb->ioda.pe_array[pe].phb = phb;
-	phb->ioda.pe_array[pe].pe_number = pe;
-	return pe;
+	return pnv_ioda_init_pe(phb, pe);
 }
 
-static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
+static void pnv_ioda_free_pe(struct pnv_ioda_pe *pe)
 {
-	WARN_ON(phb->ioda.pe_array[pe].pdev);
+	struct pnv_phb *phb = pe->phb;
 
-	memset(&phb->ioda.pe_array[pe], 0, sizeof(struct pnv_ioda_pe));
-	clear_bit(pe, phb->ioda.pe_alloc);
+	WARN_ON(pe->pdev);
+
+	memset(pe, 0, sizeof(struct pnv_ioda_pe));
+	clear_bit(pe->pe_number, phb->ioda.pe_alloc);
 }
 
 /* The default M64 BAR is shared by all PEs */
@@ -320,7 +327,7 @@ static void pnv_ioda_reserve_m64_pe(struct pci_bus *bus,
 	}
 }
 
-static unsigned int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
+static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
@@ -330,7 +337,7 @@ static unsigned int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 
 	/* Root bus shouldn't use M64 */
 	if (pci_is_root_bus(bus))
-		return IODA_INVALID_PE;
+		return NULL;
 
 	/* Allocate bitmap */
 	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
@@ -338,7 +345,7 @@ static unsigned int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 	if (!pe_alloc) {
 		pr_warn("%s: Out of memory !\n",
 			__func__);
-		return IODA_INVALID_PE;
+		return NULL;
 	}
 
 	/* Figure out reserved PE numbers by the PE */
@@ -351,7 +358,7 @@ static unsigned int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 	 */
 	if (bitmap_empty(pe_alloc, phb->ioda.total_pe_num)) {
 		kfree(pe_alloc);
-		return IODA_INVALID_PE;
+		return NULL;
 	}
 
 	/*
@@ -397,7 +404,7 @@ static unsigned int pnv_ioda_pick_m64_pe(struct pci_bus *bus, bool all)
 	}
 
 	kfree(pe_alloc);
-	return master_pe->pe_number;
+	return master_pe;
 }
 
 static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
@@ -963,7 +970,6 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 	struct pnv_phb *phb = hose->private_data;
 	struct pci_dn *pdn = pci_get_pdn(dev);
 	struct pnv_ioda_pe *pe;
-	unsigned int pe_num;
 
 	if (!pdn) {
 		pr_err("%s: Device tree node not associated properly\n",
@@ -973,8 +979,8 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 	if (pdn->pe_number != IODA_INVALID_PE)
 		return NULL;
 
-	pe_num = pnv_ioda_alloc_pe(phb);
-	if (pe_num == IODA_INVALID_PE) {
+	pe = pnv_ioda_alloc_pe(phb);
+	if (!pe) {
 		pr_warning("%s: Not enough PE# available, disabling device\n",
 			   pci_name(dev));
 		return NULL;
@@ -987,10 +993,9 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 	 *
 	 * At some point we want to remove the PDN completely anyways
 	 */
-	pe = &phb->ioda.pe_array[pe_num];
 	pci_dev_get(dev);
 	pdn->pcidev = dev;
-	pdn->pe_number = pe_num;
+	pdn->pe_number = pe->pe_number;
 	pe->flags = PNV_IODA_PE_DEV;
 	pe->pdev = dev;
 	pe->pbus = NULL;
@@ -1001,8 +1006,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
 		/* XXX What do we do here ? */
-		if (pe_num)
-			pnv_ioda_free_pe(phb, pe_num);
+		pnv_ioda_free_pe(pe);
 		pdn->pe_number = IODA_INVALID_PE;
 		pe->pdev = NULL;
 		pci_dev_put(dev);
@@ -1037,28 +1041,26 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
  * subordinate PCI devices and buses. The second type of PE is normally
  * orgiriated by PCIe-to-PCI bridge or PLX switch downstream ports.
  */
-static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
+static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 {
 	struct pci_controller *hose = pci_bus_to_host(bus);
 	struct pnv_phb *phb = hose->private_data;
-	struct pnv_ioda_pe *pe;
-	unsigned int pe_num = IODA_INVALID_PE;
+	struct pnv_ioda_pe *pe = NULL;
 
 	/* Check if PE is determined by M64 */
 	if (phb->pick_m64_pe)
-		pe_num = phb->pick_m64_pe(bus, all);
+		pe = phb->pick_m64_pe(bus, all);
 
 	/* The PE number isn't pinned by M64 */
-	if (pe_num == IODA_INVALID_PE)
-		pe_num = pnv_ioda_alloc_pe(phb);
+	if (!pe)
+		pe = pnv_ioda_alloc_pe(phb);
 
-	if (pe_num == IODA_INVALID_PE) {
+	if (!pe) {
 		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
 			__func__, pci_domain_nr(bus), bus->number);
-		return;
+		return NULL;
 	}
 
-	pe = &phb->ioda.pe_array[pe_num];
 	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
 	pe->pbus = bus;
 	pe->pdev = NULL;
@@ -1067,17 +1069,16 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 
 	if (all)
 		pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
-			bus->busn_res.start, bus->busn_res.end, pe_num);
+			bus->busn_res.start, bus->busn_res.end, pe->pe_number);
 	else
 		pe_info(pe, "Secondary bus %d associated with PE#%d\n",
-			bus->busn_res.start, pe_num);
+			bus->busn_res.start, pe->pe_number);
 
 	if (pnv_ioda_configure_pe(phb, pe)) {
 		/* XXX What do we do here ? */
-		if (pe_num)
-			pnv_ioda_free_pe(phb, pe_num);
+		pnv_ioda_free_pe(pe);
 		pe->pbus = NULL;
-		return;
+		return NULL;
 	}
 
 	/* Associate it with all child devices */
@@ -1085,6 +1086,8 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
 
 	/* Put PE to the list */
 	list_add_tail(&pe->list, &phb->ioda.pe_list);
+
+	return pe;
 }
 
 static struct pnv_ioda_pe *pnv_ioda_setup_npu_PE(struct pci_dev *npu_pdev)
@@ -1396,7 +1399,7 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
 
 		pnv_ioda_deconfigure_pe(phb, pe);
 
-		pnv_ioda_free_pe(phb, pe->pe_number);
+		pnv_ioda_free_pe(pe);
 	}
 }
 
@@ -1405,6 +1408,7 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 	struct pci_bus        *bus;
 	struct pci_controller *hose;
 	struct pnv_phb        *phb;
+	struct pnv_ioda_pe    *pe;
 	struct pci_dn         *pdn;
 	struct pci_sriov      *iov;
 	u16                    num_vfs, i;
@@ -1429,8 +1433,11 @@ void pnv_pci_sriov_disable(struct pci_dev *pdev)
 		/* Release PE numbers */
 		if (pdn->m64_single_mode) {
 			for (i = 0; i < num_vfs; i++) {
-				if (pdn->pe_num_map[i] != IODA_INVALID_PE)
-					pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
+				if (pdn->pe_num_map[i] == IODA_INVALID_PE)
+					continue;
+
+				pe = &phb->ioda.pe_array[pdn->pe_num_map[i]];
+				pnv_ioda_free_pe(pe);
 			}
 		} else
 			bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
@@ -1483,8 +1490,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 
 		if (pnv_ioda_configure_pe(phb, pe)) {
 			/* XXX What do we do here ? */
-			if (pe_num)
-				pnv_ioda_free_pe(phb, pe_num);
+			pnv_ioda_free_pe(pe);
 			pe->pdev = NULL;
 			continue;
 		}
@@ -1503,6 +1509,7 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 	struct pci_bus        *bus;
 	struct pci_controller *hose;
 	struct pnv_phb        *phb;
+	struct pnv_ioda_pe    *pe;
 	struct pci_dn         *pdn;
 	int                    ret;
 	u16                    i;
@@ -1545,11 +1552,13 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 		/* Calculate available PE for required VFs */
 		if (pdn->m64_single_mode) {
 			for (i = 0; i < num_vfs; i++) {
-				pdn->pe_num_map[i] = pnv_ioda_alloc_pe(phb);
-				if (pdn->pe_num_map[i] == IODA_INVALID_PE) {
+				pe = pnv_ioda_alloc_pe(phb);
+				if (!pe) {
 					ret = -EBUSY;
 					goto m64_failed;
 				}
+
+				pdn->pe_num_map[i] = pe->pe_number;
 			}
 		} else {
 			mutex_lock(&phb->ioda.pe_alloc_mutex);
@@ -1594,8 +1603,11 @@ int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 num_vfs)
 m64_failed:
 	if (pdn->m64_single_mode) {
 		for (i = 0; i < num_vfs; i++) {
-			if (pdn->pe_num_map[i] != IODA_INVALID_PE)
-				pnv_ioda_free_pe(phb, pdn->pe_num_map[i]);
+			if (pdn->pe_num_map[i] == IODA_INVALID_PE)
+				continue;
+
+			pe = &phb->ioda.pe_array[pdn->pe_num_map[i]];
+			pnv_ioda_free_pe(pe);
 		}
 	} else
 		bitmap_clear(phb->ioda.pe_alloc, *pdn->pe_num_map, num_vfs);
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 14d9391..904f60b 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -105,7 +105,7 @@ struct pnv_phb {
 	int (*init_m64)(struct pnv_phb *phb);
 	void (*reserve_m64_pe)(struct pci_bus *bus,
 			       unsigned long *pe_bitmap, bool all);
-	unsigned int (*pick_m64_pe)(struct pci_bus *bus, bool all);
+	struct pnv_ioda_pe *(*pick_m64_pe)(struct pci_bus *bus, bool all);
 	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
 	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
 	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
-- 
2.1.0
