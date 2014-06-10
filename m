Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D6EB1A02A3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:23 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 11:57:21 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B40C82BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:18 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1v3Au9044302
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:03 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1vHOR024968
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:18 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 15/17] powerpc/powernv: allocate VF PE
Date: Tue, 10 Jun 2014 09:56:37 +0800
Message-Id: <1402365399-5121-16-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com, bhelgaas@google.com,
 yan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VFs are created, when driver intends to enable sriov.

This patch assign related resources and allocate PEs for VF at this moment.
This patch allocate enough M64 for IOV BAR and shift the VF resource to meet
the PE# indicated by M64.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h     |    2 +
 arch/powerpc/platforms/powernv/pci-ioda.c |  340 ++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.h      |   10 +-
 3 files changed, 339 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 8c849d8..72f0af5 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -170,6 +170,8 @@ struct pci_dn {
 	int	pe_number;
 #ifdef CONFIG_PCI_IOV
 	u16     vfs;
+	int     offset;
+	int     m64_wins[PCI_SRIOV_NUM_BARS];
 #endif /* CONFIG_PCI_IOV */
 #endif
 };
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9ace027..fb2c2c6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -42,6 +42,17 @@
 #include "powernv.h"
 #include "pci.h"
 
+#ifdef CONFIG_PCI_IOV
+#define VF_PE_LOG						\
+	else if (pe->flags & PNV_IODA_PE_VF)                    \
+		sprintf(pfix, "%04x:%02x:%2x.%d",               \
+			pci_domain_nr(pe->parent_dev->bus),     \
+			(pe->rid & 0xff00) >> 8,                \
+			PCI_SLOT(pe->rid), PCI_FUNC(pe->rid));
+#else  /* CONFIG_PCI_IOV*/
+#define VF_PE_LOG
+#endif /* CONFIG_PCI_IOV*/
+
 #define define_pe_printk_level(func, kern_level)		\
 static int func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
 {								\
@@ -55,13 +66,14 @@ static int func(const struct pnv_ioda_pe *pe, const char *fmt, ...)	\
 	vaf.fmt = fmt;						\
 	vaf.va = &args;						\
 								\
-	if (pe->pdev)						\
+	if (pe->flags & PNV_IODA_PE_DEV)			\
 		strlcpy(pfix, dev_name(&pe->pdev->dev),		\
 			sizeof(pfix));				\
-	else							\
+	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) \
 		sprintf(pfix, "%04x:%02x     ",			\
 			pci_domain_nr(pe->pbus),		\
 			pe->pbus->number);			\
+	VF_PE_LOG						\
 	r = printk(kern_level "pci %s: [PE# %.3d] %pV",		\
 		   pfix, pe->pe_number, &vaf);			\
 								\
@@ -365,7 +377,12 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 		}
 		rid_end = pe->rid + (count << 8);
 	}else {
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
@@ -405,6 +422,9 @@ static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 
 	pe->pbus = NULL;
 	pe->pdev = NULL;
+#ifdef CONFIG_PCI_IOV
+	pe->parent_dev = NULL;
+#endif /* CONFIG_PCI_IOV */
 
 	return 0;
 }
@@ -443,7 +463,12 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
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
@@ -773,6 +798,114 @@ static void pnv_pci_ioda_setup_PEs(void)
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
+		if (pdn->m64_wins[i] == -1)
+			continue;
+		opal_pci_phb_mmio_enable(phb->opal_id,
+				OPAL_M64_WINDOW_TYPE, pdn->m64_wins[i], 0);
+		clear_bit(pdn->m64_wins[i], &phb->ioda.m64win_alloc);
+		pdn->m64_wins[i] = -1;
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
+	/* Initialize the m64_wins to -1 */
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++)
+		pdn->m64_wins[i] = -1;
+
+	for (i = 0; i < PCI_SRIOV_NUM_BARS; i++) {
+		res = pdev->resource + PCI_IOV_RESOURCES + i;
+		if (!res->flags || !res->parent)
+			continue;
+
+		if (!is_mem_pref_64_type(res->flags))
+			continue;
+
+		do {
+			win = find_next_zero_bit(&phb->ioda.m64win_alloc,
+					phb->ioda.m64_bars, 0);
+
+			if (win >= phb->ioda.m64_bars)
+				goto m64_failed;
+		} while (test_and_set_bit(win, &phb->ioda.m64win_alloc));
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
+static void pnv_pci_release_dev_dma(struct pci_dev *dev, struct pnv_ioda_pe *pe)
+{
+	struct pci_bus        *bus;
+	struct pci_controller *hose;
+	struct pnv_phb        *phb;
+	struct iommu_table    *tbl;
+	unsigned long         addr;
+
+	bus = dev->bus;
+	hose = pci_bus_to_host(bus);
+	phb = hose->private_data;
+	tbl = pe->tce32_table;
+	addr = tbl->it_base;
+
+	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
+	free_pages(addr, get_order(PNV_TCE32_TAB_SIZE));
+	pe->tce32_table = NULL;
+}
+
 static void pnv_pci_create_vf_node(struct pci_dev *dev, u16 vf_num)
 {
 	struct device_node *dn, *p_dn;
@@ -854,23 +987,186 @@ static void pnv_pci_release_vf_node(struct pci_dev *dev, u16 vf_num)
 	}
 }
 
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
+		pnv_pci_release_dev_dma(pdev, pe);
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
 int pcibios_sriov_disable(struct pci_dev *pdev)
 {
-	struct pci_sriov *iov;
+	struct pci_bus        *bus;
+	struct pci_controller *hose;
+	struct pnv_phb        *phb;
+	struct pci_dn         *pdn;
+	struct pci_sriov      *iov;
 	u16 vf_num;
 
+	bus = pdev->bus;
+	hose = pci_bus_to_host(bus);
+	phb = hose->private_data;
+	pdn = pci_get_pdn(pdev);
 	iov = pdev->sriov;
 	vf_num = iov->num_VFs;
+
+	/* Release VF PEs */
+	pnv_ioda_release_vf_PE(pdev);
 	pnv_pci_release_vf_node(pdev, vf_num);
 
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
 	return 0;
 }
 
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
 int pcibios_sriov_enable(struct pci_dev *pdev, u16 vf_num)
 {
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
+			pr_info("Failed to enable %d VFs, reduce VF number"
+				" and try again\n", vf_num);
+			pdn->offset = 0;
+			return -EBUSY;
+		}
+		bitmap_set(phb->ioda.pe_alloc, pdn->offset, vf_num);
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
 	pnv_pci_create_vf_node(pdev, vf_num);
+	pnv_ioda_setup_vf_PE(pdev, vf_num);
 
 	return 0;
+
+m64_failed:
+	bitmap_clear(phb->ioda.pe_alloc, pdn->offset, vf_num);
+	pdn->offset = 0;
+
+	return ret;
 }
 #endif /* CONFIG_PCI_IOV */
 
@@ -1095,12 +1391,22 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 			       TCE_PCI_SWINV_PAIR;
 	}
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, pci_domain_nr(pe->pbus), pe->pe_number);
 
-	if (pe->pdev)
+	if (pe->flags & PNV_IODA_PE_DEV) {
+		iommu_register_group(tbl, pci_domain_nr(pe->pdev->bus),
+				pe->pe_number);
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
-	else
+	}
+	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
+		iommu_register_group(tbl, pci_domain_nr(pe->pbus),
+				pe->pe_number);
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+	}
+#ifdef CONFIG_PCI_IOV
+	else if (pe->flags & PNV_IODA_PE_VF)
+		iommu_register_group(tbl, pci_domain_nr(pe->parent_dev->bus),
+				pe->pe_number);
+#endif /* CONFIG_PCI_IOV */
 
 	return;
  fail:
@@ -1223,12 +1529,22 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		tbl->it_type = TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE;
 	}
 	iommu_init_table(tbl, phb->hose->node);
-	iommu_register_group(tbl, pci_domain_nr(pe->pbus), pe->pe_number);
 
-	if (pe->pdev)
+	if (pe->flags & PNV_IODA_PE_DEV) {
+		iommu_register_group(tbl, pci_domain_nr(pe->pdev->bus),
+				pe->pe_number);
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
-	else
+	}
+	else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
+		iommu_register_group(tbl, pci_domain_nr(pe->pbus),
+				pe->pe_number);
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+	}
+#ifdef CONFIG_PCI_IOV
+	else if (pe->flags & PNV_IODA_PE_VF)
+		iommu_register_group(tbl, pci_domain_nr(pe->parent_dev->bus),
+				pe->pe_number);
+#endif /* CONFIG_PCI_IOV */
 
 	/* Also create a bypass window */
 	pnv_pci_ioda2_setup_bypass_pe(phb, pe);
@@ -1813,6 +2129,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	phb->hub_id = hub_id;
 	phb->opal_id = phb_id;
 	phb->type = ioda_type;
+	mutex_init(&phb->ioda.pe_alloc_mutex);
 
 	/* Detect specific models for error handling */
 	if (of_device_is_compatible(np, "ibm,p7ioc-pciex"))
@@ -1873,6 +2190,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 
 	INIT_LIST_HEAD(&phb->ioda.pe_dma_list);
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
+	mutex_init(&phb->ioda.pe_list_mutex);
 
 	/* Calculate how many 32-bit TCE segments we have */
 	phb->ioda.tce32_count = phb->ioda.m32_pci_base >> PNV_TCE32_SEG_SHIFT;
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 9fbf7c0..e3ca524 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -28,8 +28,9 @@ static inline bool is_mem_pref_64_type(unsigned long flags)
 
 #define PNV_PCI_DIAG_BUF_SIZE	8192
 #define PNV_IODA_PE_DEV		(1 << 0)	/* PE has single PCI device	*/
-#define PNV_IODA_PE_BUS		(1 << 1)	/* PE has primary PCI bus	*/
-#define PNV_IODA_PE_BUS_ALL	(1 << 2)	/* PE has subordinate buses	*/
+#define PNV_IODA_PE_VF		(1 << 1)	/* PE for one VF 		*/
+#define PNV_IODA_PE_BUS		(1 << 2)	/* PE has primary PCI bus	*/
+#define PNV_IODA_PE_BUS_ALL	(1 << 3)	/* PE has subordinate buses	*/
 
 /* Data associated with a PE, including IOMMU tracking etc.. */
 struct pnv_phb;
@@ -41,6 +42,9 @@ struct pnv_ioda_pe {
 	 * entire bus (& children). In the former case, pdev
 	 * is populated, in the later case, pbus is.
 	 */
+#ifdef CONFIG_PCI_IOV
+	struct pci_dev          *parent_dev;
+#endif
 	struct pci_dev		*pdev;
 	struct pci_bus		*pbus;
 
@@ -156,6 +160,7 @@ struct pnv_phb {
 
 			/* PE allocation bitmap */
 			unsigned long		*pe_alloc;
+			struct mutex             pe_alloc_mutex;
 
 			/* M64 window allocation bitmap */
 			unsigned long		m64win_alloc;
@@ -174,6 +179,7 @@ struct pnv_phb {
 			 * on the sequence of creation
 			 */
 			struct list_head	pe_list;
+			struct mutex            pe_list_mutex;
 
 			/* Reverse map of PEs, will have to extend if
 			 * we are to support more than 256 PEs, indexed
-- 
1.7.9.5
