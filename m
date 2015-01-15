Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C47ED1A0DB1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:39 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 15 Jan 2015 12:28:39 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 212EF2BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0F2SbTK53346364
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:38 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0F2SbU9020150
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jan 2015 13:28:37 +1100
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: bhelgaas@google.com, benh@au1.ibm.com, gwshan@linux.vnet.ibm.com
Subject: [PATCH V11 15/17] powerpc/powernv: Allocate VF PE
Date: Thu, 15 Jan 2015 10:28:05 +0800
Message-Id: <1421288887-7765-16-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VFs are created, when pci device is enabled.

This patch tries best to assign maximum resources and PEs for VF when pci
device is enabled. Enough M64 assigned to cover the IOV BAR, IOV BAR is
shifted to meet the PE# indicated by M64. VF's pdn->pdev and
pdn->pe_number are fixed.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    4 +
 arch/powerpc/kernel/pci_dn.c              |   11 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  451 ++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c      |   18 ++
 arch/powerpc/platforms/powernv/pci.h      |    7 +
 5 files changed, 476 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index b857ec4..d61c384 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -172,6 +172,10 @@ struct pci_dn {
 	int	pe_number;
 #ifdef CONFIG_PCI_IOV
 	u16     max_vfs;		/* number of VFs IOV BAR expended */
+	u16     vf_pes;			/* VF PE# under this PF */
+	int     offset;			/* PE# for the first VF PE */
+#define IODA_INVALID_M64        (-1)
+	int     m64_wins[PCI_SRIOV_NUM_BARS];
 #endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
index 6536573..36aaa8e 100644
--- a/arch/powerpc/kernel/pci_dn.c
+++ b/arch/powerpc/kernel/pci_dn.c
@@ -218,6 +218,17 @@ void remove_dev_pci_info(struct pci_dev *pdev, u16 vf_num)
 	struct pci_dn *pdn, *tmp;
 	int i;
 
+	/*
+	 * VF and VF PE is create/released dynamicly, which we need to
+	 * bind/unbind them. Otherwise when re-enable SRIOV, the VF and VF PE
+	 * would be mismatched.
+	 */
+	if (pdev->is_virtfn) {
+		pdn = pci_get_pdn(pdev);
+		pdn->pe_number = IODA_INVALID_PE;
+		return;
+	}
+
 	/* Only support IOV PF for now */
 	if (!pdev->is_physfn)
 		return;
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 62bb2eb..94fe6e1 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -45,6 +45,9 @@
 #include "powernv.h"
 #include "pci.h"
 
+/* 256M DMA window, 4K TCE pages, 8 bytes TCE */
+#define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
+
 static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 			    const char *fmt, ...)
 {
@@ -57,11 +60,18 @@ static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
 	vaf.fmt = fmt;
 	vaf.va = &args;
 
-	if (pe->pdev)
+	if (pe->flags & PNV_IODA_PE_DEV)
 		strlcpy(pfix, dev_name(&pe->pdev->dev), sizeof(pfix));
-	else
+	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
 		sprintf(pfix, "%04x:%02x     ",
 			pci_domain_nr(pe->pbus), pe->pbus->number);
+#ifdef CONFIG_PCI_IOV
+	else if (pe->flags & PNV_IODA_PE_VF)
+		sprintf(pfix, "%04x:%02x:%2x.%d",
+			pci_domain_nr(pe->parent_dev->bus),
+			(pe->rid & 0xff00) >> 8,
+			PCI_SLOT(pe->rid), PCI_FUNC(pe->rid));
+#endif /* CONFIG_PCI_IOV*/
 
 	printk("%spci %s: [PE# %.3d] %pV",
 	       level, pfix, pe->pe_number, &vaf);
@@ -567,7 +577,7 @@ static int pnv_ioda_set_peltv(struct pnv_phb *phb,
 			      bool is_add)
 {
 	struct pnv_ioda_pe *slave;
-	struct pci_dev *pdev;
+	struct pci_dev *pdev = NULL;
 	int ret;
 
 	/*
@@ -606,8 +616,12 @@ static int pnv_ioda_set_peltv(struct pnv_phb *phb,
 
 	if (pe->flags & (PNV_IODA_PE_BUS_ALL | PNV_IODA_PE_BUS))
 		pdev = pe->pbus->self;
-	else
+	else if (pe->flags & PNV_IODA_PE_DEV)
 		pdev = pe->pdev->bus->self;
+#ifdef CONFIG_PCI_IOV
+	else if (pe->flags & PNV_IODA_PE_VF)
+		pdev = pe->parent_dev->bus->self;
+#endif /* CONFIG_PCI_IOV */
 	while (pdev) {
 		struct pci_dn *pdn = pci_get_pdn(pdev);
 		struct pnv_ioda_pe *parent;
@@ -625,6 +639,89 @@ static int pnv_ioda_set_peltv(struct pnv_phb *phb,
 	return 0;
 }
 
+#ifdef CONFIG_PCI_IOV
+static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
+{
+	struct pci_dev *parent;
+	uint8_t bcomp, dcomp, fcomp;
+	int64_t rc;
+	long rid_end, rid;
+
+	/* Currently, we just deconfigure VF PE. Bus PE will always there.*/
+	if (pe->pbus) {
+		int count;
+
+		dcomp = OPAL_IGNORE_RID_DEVICE_NUMBER;
+		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
+		parent = pe->pbus->self;
+		if (pe->flags & PNV_IODA_PE_BUS_ALL)
+			count = pe->pbus->busn_res.end - pe->pbus->busn_res.start + 1;
+		else
+			count = 1;
+
+		switch(count) {
+		case  1: bcomp = OpalPciBusAll;         break;
+		case  2: bcomp = OpalPciBus7Bits;       break;
+		case  4: bcomp = OpalPciBus6Bits;       break;
+		case  8: bcomp = OpalPciBus5Bits;       break;
+		case 16: bcomp = OpalPciBus4Bits;       break;
+		case 32: bcomp = OpalPciBus3Bits;       break;
+		default:
+			pr_err("%s: Number of subordinate busses %d"
+			       " unsupported\n",
+			       pci_is_root_bus(pe->pbus)?"root bus":pci_name(pe->pbus->self),
+			       count);
+			/* Do an exact match only */
+			bcomp = OpalPciBusAll;
+		}
+		rid_end = pe->rid + (count << 8);
+	} else {
+		if (pe->flags & PNV_IODA_PE_VF)
+			parent = pe->parent_dev;
+		else
+			parent = pe->pdev->bus->self;
+		bcomp = OpalPciBusAll;
+		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
+		fcomp = OPAL_COMPARE_RID_FUNCTION_NUMBER;
+		rid_end = pe->rid + 1;
+	}
+
+	/* Clear the reverse map */
+	for (rid = pe->rid; rid < rid_end; rid++)
+		phb->ioda.pe_rmap[rid] = 0;
+
+	/* Release from all parents PELT-V */
+	while (parent) {
+		struct pci_dn *pdn = pci_get_pdn(parent);
+		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
+			rc = opal_pci_set_peltv(phb->opal_id, pdn->pe_number,
+						pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
+			/* XXX What to do in case of error ? */
+		}
+		parent = parent->bus->self;
+	}
+
+	opal_pci_eeh_freeze_set(phb->opal_id, pe->pe_number,
+				  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+
+	/* Dissociate PE in PELT */
+	rc = opal_pci_set_peltv(phb->opal_id, pe->pe_number,
+				pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
+	if (rc)
+		pe_warn(pe, "OPAL error %ld remove self from PELTV\n", rc);
+	rc = opal_pci_set_pe(phb->opal_id, pe->pe_number, pe->rid,
+			     bcomp, dcomp, fcomp, OPAL_UNMAP_PE);
+	if (rc)
+		pe_err(pe, "OPAL error %ld trying to setup PELT table\n", rc);
+
+	pe->pbus = NULL;
+	pe->pdev = NULL;
+	pe->parent_dev = NULL;
+
+	return 0;
+}
+#endif /* CONFIG_PCI_IOV */
+
 static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
 	struct pci_dev *parent;
@@ -653,13 +750,19 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		default:
 			pr_err("%s: Number of subordinate busses %d"
 			       " unsupported\n",
-			       pci_name(pe->pbus->self), count);
+			       pci_is_root_bus(pe->pbus)?"root bus":pci_name(pe->pbus->self),
+			       count);
 			/* Do an exact match only */
 			bcomp = OpalPciBusAll;
 		}
 		rid_end = pe->rid + (count << 8);
 	} else {
-		parent = pe->pdev->bus->self;
+#ifdef CONFIG_PCI_IOV
+		if (pe->flags & PNV_IODA_PE_VF)
+			parent = pe->parent_dev;
+		else
+#endif /* CONFIG_PCI_IOV */
+			parent = pe->pdev->bus->self;
 		bcomp = OpalPciBusAll;
 		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
 		fcomp = OPAL_COMPARE_RID_FUNCTION_NUMBER;
@@ -984,8 +1087,311 @@ static void pnv_pci_ioda_setup_PEs(void)
 }
 
 #ifdef CONFIG_PCI_IOV
+static int pnv_pci_vf_release_m64(struct pci_dev *pdev)
+{
+	struct pci_bus        *bus;
+	struct pci_controller *hose;
+	struct pnv_phb        *phb;
+	struct pci_dn         *pdn;
+	int                    i;
+
+	bus = pdev->bus;
+	hose = pci_bus_to_host(bus);
+	phb = hose->private_data;
+	pdn = pci_get_pdn(pdev);
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		if (pdn->m64_wins[i] == IODA_INVALID_M64)
+			continue;
+		opal_pci_phb_mmio_enable(phb->opal_id,
+				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i], 0);
+		clear_bit(pdn->m64_wins[i], &phb->ioda.m64_bar_alloc);
+		pdn->m64_wins[i] = IODA_INVALID_M64;
+	}
+
+	return 0;
+}
+
+static int pnv_pci_vf_assign_m64(struct pci_dev *pdev)
+{
+	struct pci_bus        *bus;
+	struct pci_controller *hose;
+	struct pnv_phb        *phb;
+	struct pci_dn         *pdn;
+	unsigned int           win;
+	struct resource       *res;
+	int                    i;
+	int64_t                rc;
+
+	bus = pdev->bus;
+	hose = pci_bus_to_host(bus);
+	phb = hose->private_data;
+	pdn = pci_get_pdn(pdev);
+
+	/* Initialize the m64_wins to IODA_INVALID_M64 */
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
+		pdn->m64_wins[i] = IODA_INVALID_M64;
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		res = pdev->resource + PCI_IOV_RESOURCES + i;
+		if (!res->flags || !res->parent)
+			continue;
+
+		if (!pnv_pci_is_mem_pref_64(res->flags))
+			continue;
+
+		do {
+			win = find_next_zero_bit(&phb->ioda.m64_bar_alloc,
+					phb->ioda.m64_bar_idx + 1, 0);
+
+			if (win >= phb->ioda.m64_bar_idx + 1)
+				goto m64_failed;
+		} while (test_and_set_bit(win, &phb->ioda.m64_bar_alloc));
+
+		pdn->m64_wins[i] = win;
+
+		/* Map the M64 here */
+		rc = opal_pci_set_phb_mem_window(phb->opal_id,
+						 OPAL_M64_WINDOW_TYPE,
+						 pdn->m64_wins[i],
+						 res->start,
+						 0, /* unused */
+						 resource_size(res));
+		if (rc != OPAL_SUCCESS) {
+			pr_err("Failed to map M64 BAR #%d: %lld\n", win, rc);
+			goto m64_failed;
+		}
+
+		rc = opal_pci_phb_mmio_enable(phb->opal_id,
+				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i], 1);
+		if (rc != OPAL_SUCCESS) {
+			pr_err("Failed to enable M64 BAR #%d: %llx\n", win, rc);
+			goto m64_failed;
+		}
+	}
+	return 0;
+
+m64_failed:
+	pnv_pci_vf_release_m64(pdev);
+	return -EBUSY;
+}
+
+static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
+{
+	struct pci_bus        *bus;
+	struct pci_controller *hose;
+	struct pnv_phb        *phb;
+	struct iommu_table    *tbl;
+	unsigned long         addr;
+	int64_t               rc;
+
+	bus = dev->bus;
+	hose = pci_bus_to_host(bus);
+	phb = hose->private_data;
+	tbl = pe->tce32_table;
+	addr = tbl->it_base;
+
+	opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+				   pe->pe_number << 1, 1, __pa(addr),
+				   0, 0x1000);
+
+	rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id,
+				        pe->pe_number,
+				        (pe->pe_number << 1) + 1,
+				        pe->tce_bypass_base,
+				        0);
+	if (rc)
+		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
+
+	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
+	free_pages(addr, get_order(TCE32_TABLE_SIZE));
+	pe->tce32_table = NULL;
+}
+
+static void pnv_ioda_release_vf_PE(struct pci_dev *pdev)
+{
+	struct pci_bus        *bus;
+	struct pci_controller *hose;
+	struct pnv_phb        *phb;
+	struct pnv_ioda_pe    *pe, *pe_n;
+	struct pci_dn         *pdn;
+
+	bus = pdev->bus;
+	hose = pci_bus_to_host(bus);
+	phb = hose->private_data;
+
+	if (!pdev->is_physfn)
+		return;
+
+	pdn = pci_get_pdn(pdev);
+	list_for_each_entry_safe(pe, pe_n, &phb->ioda.pe_list, list) {
+		if (pe->parent_dev != pdev)
+			continue;
+
+		pnv_pci_ioda2_release_dma_pe(pdev, pe);
+
+		/* Remove from list */
+		mutex_lock(&phb->ioda.pe_list_mutex);
+		list_del(&pe->list);
+		mutex_unlock(&phb->ioda.pe_list_mutex);
+
+		pnv_ioda_deconfigure_pe(phb, pe);
+
+		pnv_ioda_free_pe(phb, pe->pe_number);
+	}
+}
+
+void pnv_pci_sriov_disable(struct pci_dev *pdev)
+{
+	struct pci_bus        *bus;
+	struct pci_controller *hose;
+	struct pnv_phb        *phb;
+	struct pci_dn         *pdn;
+	struct pci_sriov      *iov;
+	u16 vf_num;
+
+	bus = pdev->bus;
+	hose = pci_bus_to_host(bus);
+	phb = hose->private_data;
+	pdn = pci_get_pdn(pdev);
+	iov = pdev->sriov;
+	vf_num = pdn->vf_pes;
+
+	/* Release VF PEs */
+	pnv_ioda_release_vf_PE(pdev);
+
+	if (phb->type == PNV_PHB_IODA2) {
+		pnv_pci_vf_resource_shift(pdev, -pdn->offset);
+
+		/* Release M64 BARs */
+		pnv_pci_vf_release_m64(pdev);
+
+		/* Release PE numbers */
+		bitmap_clear(phb->ioda.pe_alloc, pdn->offset, vf_num);
+		pdn->offset = 0;
+	}
+
+	return;
+}
+
+static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
+				       struct pnv_ioda_pe *pe);
+static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 vf_num)
+{
+	struct pci_bus        *bus;
+	struct pci_controller *hose;
+	struct pnv_phb        *phb;
+	struct pnv_ioda_pe    *pe;
+	int                    pe_num;
+	u16                    vf_index;
+	struct pci_dn         *pdn;
+
+	bus = pdev->bus;
+	hose = pci_bus_to_host(bus);
+	phb = hose->private_data;
+	pdn = pci_get_pdn(pdev);
+
+	if (!pdev->is_physfn)
+		return;
+
+	/* Reserve PE for each VF */
+	for (vf_index = 0; vf_index < vf_num; vf_index++) {
+		pe_num = pdn->offset + vf_index;
+
+		pe = &phb->ioda.pe_array[pe_num];
+		pe->pe_number = pe_num;
+		pe->phb = phb;
+		pe->flags = PNV_IODA_PE_VF;
+		pe->pbus = NULL;
+		pe->parent_dev = pdev;
+		pe->tce32_seg = -1;
+		pe->mve_number = -1;
+		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
+			   pci_iov_virtfn_devfn(pdev, vf_index);
+
+		pe_info(pe, "VF %04d:%02d:%02d.%d associated with PE#%d\n",
+			hose->global_number, pdev->bus->number,
+			PCI_SLOT(pci_iov_virtfn_devfn(pdev, vf_index)),
+			PCI_FUNC(pci_iov_virtfn_devfn(pdev, vf_index)), pe_num);
+
+		if (pnv_ioda_configure_pe(phb, pe)) {
+			/* XXX What do we do here ? */
+			if (pe_num)
+				pnv_ioda_free_pe(phb, pe_num);
+			pe->pdev = NULL;
+			continue;
+		}
+
+		pe->tce32_table = kzalloc_node(sizeof(struct iommu_table),
+				GFP_KERNEL, hose->node);
+		pe->tce32_table->data = pe;
+
+		/* Put PE to the list */
+		mutex_lock(&phb->ioda.pe_list_mutex);
+		list_add_tail(&pe->list, &phb->ioda.pe_list);
+		mutex_unlock(&phb->ioda.pe_list_mutex);
+
+		pnv_pci_ioda2_setup_dma_pe(phb, pe);
+
+	}
+}
+
+int pnv_pci_sriov_enable(struct pci_dev *pdev, u16 vf_num)
+{
+	struct pci_bus        *bus;
+	struct pci_controller *hose;
+	struct pnv_phb        *phb;
+	struct pci_dn         *pdn;
+	int                    ret;
+
+	bus = pdev->bus;
+	hose = pci_bus_to_host(bus);
+	phb = hose->private_data;
+	pdn = pci_get_pdn(pdev);
+
+	if (phb->type == PNV_PHB_IODA2) {
+		/* Calculate available PE for required VFs */
+		mutex_lock(&phb->ioda.pe_alloc_mutex);
+		pdn->offset = bitmap_find_next_zero_area(
+			phb->ioda.pe_alloc, phb->ioda.total_pe,
+			0, vf_num, 0);
+		if (pdn->offset >= phb->ioda.total_pe) {
+			mutex_unlock(&phb->ioda.pe_alloc_mutex);
+			pr_info("Failed to enable VF\n");
+			pdn->offset = 0;
+			return -EBUSY;
+		}
+		bitmap_set(phb->ioda.pe_alloc, pdn->offset, vf_num);
+		pdn->vf_pes = vf_num;
+		mutex_unlock(&phb->ioda.pe_alloc_mutex);
+
+		/* Assign M64 BAR accordingly */
+		ret = pnv_pci_vf_assign_m64(pdev);
+		if (ret) {
+			pr_info("No enough M64 resource\n");
+			goto m64_failed;
+		}
+
+		/* Do some magic shift */
+		pnv_pci_vf_resource_shift(pdev, pdn->offset);
+	}
+
+	/* Setup VF PEs */
+	pnv_ioda_setup_vf_PE(pdev, vf_num);
+
+	return 0;
+
+m64_failed:
+	bitmap_clear(phb->ioda.pe_alloc, pdn->offset, vf_num);
+	pdn->offset = 0;
+
+	return ret;
+}
+
 int pcibios_sriov_disable(struct pci_dev *pdev, u16 vf_num)
 {
+	pnv_pci_sriov_disable(pdev);
+
 	/* Release firmware data */
 	remove_dev_pci_info(pdev, vf_num);
 	return 0;
@@ -995,6 +1401,8 @@ int pcibios_sriov_enable(struct pci_dev *pdev, u16 vf_num)
 {
 	/* Allocate firmware data */
 	add_dev_pci_info(pdev, vf_num);
+
+	pnv_pci_sriov_enable(pdev, vf_num);
 	return 0;
 }
 #endif /* CONFIG_PCI_IOV */
@@ -1191,9 +1599,6 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	int64_t rc;
 	void *addr;
 
-	/* 256M DMA window, 4K TCE pages, 8 bytes TCE */
-#define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
-
 	/* XXX FIXME: Handle 64-bit only DMA devices */
 	/* XXX FIXME: Provide 64-bit DMA facilities & non-4K TCE tables etc.. */
 	/* XXX FIXME: Allocate multi-level tables on PHB3 */
@@ -1256,12 +1661,19 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 				 TCE_PCI_SWINV_PAIR);
 	}
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
 
-	if (pe->pdev)
+	if (pe->flags & PNV_IODA_PE_DEV) {
+		iommu_register_group(tbl, phb->hose->global_number,
+				     pe->pe_number);
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
-	else
+	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
+		iommu_register_group(tbl, phb->hose->global_number,
+				     pe->pe_number);
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
+	} else if (pe->flags & PNV_IODA_PE_VF) {
+		iommu_register_group(tbl, phb->hose->global_number,
+				     pe->pe_number);
+	}
 
 	return;
  fail:
@@ -1388,12 +1800,19 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 	}
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
 
-	if (pe->pdev)
+	if (pe->flags & PNV_IODA_PE_DEV) {
+		iommu_register_group(tbl, phb->hose->global_number,
+				     pe->pe_number);
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
-	else
+	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
+		iommu_register_group(tbl, phb->hose->global_number,
+				     pe->pe_number);
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
+	} else if (pe->flags & PNV_IODA_PE_VF) {
+		iommu_register_group(tbl, phb->hose->global_number,
+				     pe->pe_number);
+	}
 
 	/* Also create a bypass window */
 	pnv_pci_ioda2_setup_bypass_pe(phb, pe);
@@ -2087,6 +2506,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = ioda_type;
+	mutex_init(&phb->ioda.pe_alloc_mutex);
 
 	/* Detect specific models for error handling */
 	if (of_device_is_compatible(np, "ibm,p7ioc-pciex"))
@@ -2146,6 +2566,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
+	mutex_init(&phb->ioda.pe_list_mutex);
 
 	/* Calculate how many 32-bit TCE segments we have */
 	phb->ioda.tce32_count = phb->ioda.m32_pci_base >> 28;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index b7d4b9d..269f1dd 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -714,6 +714,24 @@ static void pnv_pci_dma_dev_setup(struct pci_dev *pdev)
 {
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct pnv_phb *phb = hose->private_data;
+#ifdef CONFIG_PCI_IOV
+	struct pnv_ioda_pe *pe;
+	struct pci_dn *pdn;
+
+	/* Fix the VF pdn PE number */
+	if (pdev->is_virtfn) {
+		pdn = pci_get_pdn(pdev);
+		WARN_ON(pdn->pe_number != IODA_INVALID_PE);
+		list_for_each_entry(pe, &phb->ioda.pe_list, list) {
+			if (pe->rid == ((pdev->bus->number << 8) |
+			    (pdev->devfn & 0xff))) {
+				pdn->pe_number = pe->pe_number;
+				pe->pdev = pdev;
+				break;
+			}
+		}
+	}
+#endif /* CONFIG_PCI_IOV */
 
 	/* If we have no phb structure, try to setup a fallback based on
 	 * the device-tree (RTAS PCI for example)
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 7317777..39d42f2 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -23,6 +23,7 @@ enum pnv_phb_model {
 #define PNV_IODA_PE_BUS_ALL	(1 << 2)	/* PE has subordinate buses	*/
 #define PNV_IODA_PE_MASTER	(1 << 3)	/* Master PE in compound case	*/
 #define PNV_IODA_PE_SLAVE	(1 << 4)	/* Slave PE in compound case	*/
+#define PNV_IODA_PE_VF		(1 << 5)	/* PE for one VF 		*/
 
 /* Data associated with a PE, including IOMMU tracking etc.. */
 struct pnv_phb;
@@ -34,6 +35,9 @@ struct pnv_ioda_pe {
 	 * entire bus (& children). In the former case, pdev
 	 * is populated, in the later case, pbus is.
 	 */
+#ifdef CONFIG_PCI_IOV
+	struct pci_dev          *parent_dev;
+#endif
 	struct pci_dev		*pdev;
 	struct pci_bus		*pbus;
 
@@ -165,6 +169,8 @@ struct pnv_phb {
 
 			/* PE allocation bitmap */
 			unsigned long		*pe_alloc;
+			/* PE allocation mutex */
+			struct mutex		pe_alloc_mutex;
 
 			/* M32 & IO segment maps */
 			unsigned int		*m32_segmap;
@@ -179,6 +185,7 @@ struct pnv_phb {
 			 * on the sequence of creation
 			 */
 			struct list_head	pe_list;
+			struct mutex            pe_list_mutex;
 
 			/* Reverse map of PEs, will have to extend if
 			 * we are to support more than 256 PEs, indexed
-- 
1.7.9.5
