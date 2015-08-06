Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6D7871A1885
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:39 +1000 (AEST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 6 Aug 2015 14:13:39 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 59AE53578066
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 14:13:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t764DS2D36765736
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:36 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t764D13A012939
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Aug 2015 14:13:02 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, aik@ozlabs.ru,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v6 22/42] powerpc/powernv: Move functions around
Date: Thu,  6 Aug 2015 14:11:27 +1000
Message-Id: <1438834307-26960-23-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch moves functions related to releasing PE around so that
we don't need extra declaration for them in subsequent patches.
Also, it fixes warnings from scripts/checkpatch.pl. It doesn't
introduce any behavioural changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 743 +++++++++++++++---------------
 1 file changed, 377 insertions(+), 366 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 84b771e..d2697a3 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -132,6 +132,295 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
 		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
 }
 
+static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
+{
+	/* 01xb - invalidate TCEs that match the specified PE# */
+	unsigned long val = (0x4ull << 60) | (pe->pe_number & 0xFF);
+	struct pnv_phb *phb = pe->phb;
+
+	if (!phb->ioda.tce_inval_reg)
+		return;
+
+	mb(); /* Ensure above stores are visible */
+	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
+}
+
+#if defined(CONFIG_IOMMU_API) || defined(CONFIG_PCI_IOV)
+static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
+		int num)
+{
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
+	struct pnv_phb *phb = pe->phb;
+	long ret;
+
+	pe_info(pe, "Removing DMA window #%d\n", num);
+
+	ret = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+			(pe->pe_number << 1) + num,
+			0/* levels */, 0/* table address */,
+			0/* table size */, 0/* page size */);
+	if (ret)
+		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
+	else
+		pnv_pci_ioda2_tce_invalidate_entire(pe);
+
+	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
+
+	return ret;
+}
+#endif /* CONFIG_IOMMU_API || CONFIG_PCI_IOV */
+
+static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
+{
+	uint16_t window_id = (pe->pe_number << 1) + 1;
+	int64_t rc;
+
+	pe_info(pe, "%sabling 64-bit DMA bypass\n", enable ? "En" : "Dis");
+	if (enable) {
+		phys_addr_t top = memblock_end_of_DRAM();
+
+		top = roundup_pow_of_two(top);
+		rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id,
+						     pe->pe_number,
+						     window_id,
+						     pe->tce_bypass_base,
+						     top);
+	} else {
+		rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id,
+						     pe->pe_number,
+						     window_id,
+						     pe->tce_bypass_base,
+						     0);
+	}
+	if (rc)
+		pe_err(pe, "OPAL error %lld configuring bypass window\n", rc);
+	else
+		pe->tce_bypass_enabled = enable;
+}
+
+#ifdef CONFIG_PCI_IOV
+static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev,
+					 struct pnv_ioda_pe *pe)
+{
+	struct iommu_table    *tbl;
+	int64_t               rc;
+
+	tbl = pe->table_group.tables[0];
+	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
+	if (rc)
+		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
+
+	pnv_pci_ioda2_set_bypass(pe, false);
+	if (pe->table_group.group) {
+		iommu_group_put(pe->table_group.group);
+		BUG_ON(pe->table_group.group);
+	}
+	pnv_pci_ioda2_table_free_pages(tbl);
+	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
+}
+#endif /* CONFIG_PCI_IOV */
+
+static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
+				  struct pnv_ioda_pe *parent,
+				  struct pnv_ioda_pe *child,
+				  bool is_add)
+{
+	const char *desc = is_add ? "adding" : "removing";
+	uint8_t op = is_add ? OPAL_ADD_PE_TO_DOMAIN :
+			      OPAL_REMOVE_PE_FROM_DOMAIN;
+	struct pnv_ioda_pe *slave;
+	long rc;
+
+	/* Parent PE affects child PE */
+	rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
+				child->pe_number, op);
+	if (rc != OPAL_SUCCESS) {
+		pe_warn(child, "OPAL error %ld %s to parent PELTV\n",
+			rc, desc);
+		return -ENXIO;
+	}
+
+	if (!(child->flags & PNV_IODA_PE_MASTER))
+		return 0;
+
+	/* Compound case: parent PE affects slave PEs */
+	list_for_each_entry(slave, &child->slaves, list) {
+		rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
+					slave->pe_number, op);
+		if (rc != OPAL_SUCCESS) {
+			pe_warn(slave, "OPAL error %ld %s to parent PELTV\n",
+				rc, desc);
+			return -ENXIO;
+		}
+	}
+
+	return 0;
+}
+
+static int pnv_ioda_set_peltv(struct pnv_phb *phb,
+			      struct pnv_ioda_pe *pe,
+			      bool is_add)
+{
+	struct pnv_ioda_pe *slave;
+	struct pci_dev *pdev = NULL;
+	int ret;
+
+	/*
+	 * Clear PE frozen state. If it's master PE, we need
+	 * clear slave PE frozen state as well.
+	 */
+	if (is_add) {
+		opal_pci_eeh_freeze_clear(phb->opal_id, pe->pe_number,
+					  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+		if (pe->flags & PNV_IODA_PE_MASTER) {
+			list_for_each_entry(slave, &pe->slaves, list)
+				opal_pci_eeh_freeze_clear(phb->opal_id,
+					slave->pe_number,
+					OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+		}
+	}
+
+	/*
+	 * Associate PE in PELT. We need add the PE into the
+	 * corresponding PELT-V as well. Otherwise, the error
+	 * originated from the PE might contribute to other
+	 * PEs.
+	 */
+	ret = pnv_ioda_set_one_peltv(phb, pe, pe, is_add);
+	if (ret)
+		return ret;
+
+	/* For compound PEs, any one affects all of them */
+	if (pe->flags & PNV_IODA_PE_MASTER) {
+		list_for_each_entry(slave, &pe->slaves, list) {
+			ret = pnv_ioda_set_one_peltv(phb, slave, pe, is_add);
+			if (ret)
+				return ret;
+		}
+	}
+
+	if (pe->flags & (PNV_IODA_PE_BUS_ALL | PNV_IODA_PE_BUS))
+		pdev = pe->pbus->self;
+	else if (pe->flags & PNV_IODA_PE_DEV)
+		pdev = pe->pdev->bus->self;
+#ifdef CONFIG_PCI_IOV
+	else if (pe->flags & PNV_IODA_PE_VF)
+		pdev = pe->parent_dev;
+#endif /* CONFIG_PCI_IOV */
+	while (pdev) {
+		struct pci_dn *pdn = pci_get_pdn(pdev);
+		struct pnv_ioda_pe *parent;
+
+		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
+			parent = &phb->ioda.pe_array[pdn->pe_number];
+			ret = pnv_ioda_set_one_peltv(phb, parent, pe, is_add);
+			if (ret)
+				return ret;
+		}
+
+		pdev = pdev->bus->self;
+	}
+
+	return 0;
+}
+
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
+			count = pe->pbus->busn_res.end -
+				pe->pbus->busn_res.start + 1;
+		else
+			count = 1;
+
+		switch (count) {
+		case  1:
+			bcomp = OpalPciBusAll;
+			break;
+		case  2:
+			bcomp = OpalPciBus7Bits;
+			break;
+		case  4:
+			bcomp = OpalPciBus6Bits;
+			break;
+		case  8:
+			bcomp = OpalPciBus5Bits;
+			break;
+		case 16:
+			bcomp = OpalPciBus4Bits;
+			break;
+		case 32:
+			bcomp = OpalPciBus3Bits;
+			break;
+		default:
+			dev_err(&pe->pbus->dev, "Subordinate buses %d unsupported\n",
+				count);
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
+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
+
+	/* Release from all parents PELT-V */
+	while (parent) {
+		struct pci_dn *pdn = pci_get_pdn(parent);
+
+		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
+			rc = opal_pci_set_peltv(phb->opal_id,
+					pdn->pe_number, pe->pe_number,
+					OPAL_REMOVE_PE_FROM_DOMAIN);
+			/* XXX What to do in case of error ? */
+		}
+		parent = parent->bus->self;
+	}
+
+	opal_pci_eeh_freeze_clear(phb->opal_id, pe->pe_number,
+				  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+
+	/* Disassociate PE in PELT */
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
 static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb, int pe_no)
 {
 	struct pnv_ioda_pe *pe = &phb->ioda.pe_array[pe_no];
@@ -547,305 +836,117 @@ static int pnv_ioda_unfreeze_pe(struct pnv_phb *phb, int pe_no, int opt)
 	struct pnv_ioda_pe *pe, *slave;
 	s64 rc;
 
-	/* Find master PE */
-	pe = &phb->ioda.pe_array[pe_no];
-	if (pe->flags & PNV_IODA_PE_SLAVE) {
-		pe = pe->master;
-		WARN_ON(!pe || !(pe->flags & PNV_IODA_PE_MASTER));
-		pe_no = pe->pe_number;
-	}
-
-	/* Clear frozen state for master PE */
-	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no, opt);
-	if (rc != OPAL_SUCCESS) {
-		pr_warn("%s: Failure %lld clear %d on PHB#%x-PE#%x\n",
-			__func__, rc, opt, phb->hose->global_number, pe_no);
-		return -EIO;
-	}
-
-	if (!(pe->flags & PNV_IODA_PE_MASTER))
-		return 0;
-
-	/* Clear frozen state for slave PEs */
-	list_for_each_entry(slave, &pe->slaves, list) {
-		rc = opal_pci_eeh_freeze_clear(phb->opal_id,
-					     slave->pe_number,
-					     opt);
-		if (rc != OPAL_SUCCESS) {
-			pr_warn("%s: Failure %lld clear %d on PHB#%x-PE#%x\n",
-				__func__, rc, opt, phb->hose->global_number,
-				slave->pe_number);
-			return -EIO;
-		}
-	}
-
-	return 0;
-}
-
-static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
-{
-	struct pnv_ioda_pe *slave, *pe;
-	u8 fstate, state;
-	__be16 pcierr;
-	s64 rc;
-
-	/* Sanity check on PE number */
-	if (pe_no < 0 || pe_no >= phb->ioda.total_pe_num)
-		return OPAL_EEH_STOPPED_PERM_UNAVAIL;
-
-	/*
-	 * Fetch the master PE and the PE instance might be
-	 * not initialized yet.
-	 */
-	pe = &phb->ioda.pe_array[pe_no];
-	if (pe->flags & PNV_IODA_PE_SLAVE) {
-		pe = pe->master;
-		WARN_ON(!pe || !(pe->flags & PNV_IODA_PE_MASTER));
-		pe_no = pe->pe_number;
-	}
-
-	/* Check the master PE */
-	rc = opal_pci_eeh_freeze_status(phb->opal_id, pe_no,
-					&state, &pcierr, NULL);
-	if (rc != OPAL_SUCCESS) {
-		pr_warn("%s: Failure %lld getting "
-			"PHB#%x-PE#%x state\n",
-			__func__, rc,
-			phb->hose->global_number, pe_no);
-		return OPAL_EEH_STOPPED_TEMP_UNAVAIL;
-	}
-
-	/* Check the slave PE */
-	if (!(pe->flags & PNV_IODA_PE_MASTER))
-		return state;
-
-	list_for_each_entry(slave, &pe->slaves, list) {
-		rc = opal_pci_eeh_freeze_status(phb->opal_id,
-						slave->pe_number,
-						&fstate,
-						&pcierr,
-						NULL);
-		if (rc != OPAL_SUCCESS) {
-			pr_warn("%s: Failure %lld getting "
-				"PHB#%x-PE#%x state\n",
-				__func__, rc,
-				phb->hose->global_number, slave->pe_number);
-			return OPAL_EEH_STOPPED_TEMP_UNAVAIL;
-		}
-
-		/*
-		 * Override the result based on the ascending
-		 * priority.
-		 */
-		if (fstate > state)
-			state = fstate;
-	}
-
-	return state;
-}
-
-/* Currently those 2 are only used when MSIs are enabled, this will change
- * but in the meantime, we need to protect them to avoid warnings
- */
-#ifdef CONFIG_PCI_MSI
-static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
-{
-	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	struct pnv_phb *phb = hose->private_data;
-	struct pci_dn *pdn = pci_get_pdn(dev);
-
-	if (!pdn)
-		return NULL;
-	if (pdn->pe_number == IODA_INVALID_PE)
-		return NULL;
-	return &phb->ioda.pe_array[pdn->pe_number];
-}
-#endif /* CONFIG_PCI_MSI */
-
-static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
-				  struct pnv_ioda_pe *parent,
-				  struct pnv_ioda_pe *child,
-				  bool is_add)
-{
-	const char *desc = is_add ? "adding" : "removing";
-	uint8_t op = is_add ? OPAL_ADD_PE_TO_DOMAIN :
-			      OPAL_REMOVE_PE_FROM_DOMAIN;
-	struct pnv_ioda_pe *slave;
-	long rc;
-
-	/* Parent PE affects child PE */
-	rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
-				child->pe_number, op);
-	if (rc != OPAL_SUCCESS) {
-		pe_warn(child, "OPAL error %ld %s to parent PELTV\n",
-			rc, desc);
-		return -ENXIO;
-	}
-
-	if (!(child->flags & PNV_IODA_PE_MASTER))
-		return 0;
-
-	/* Compound case: parent PE affects slave PEs */
-	list_for_each_entry(slave, &child->slaves, list) {
-		rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
-					slave->pe_number, op);
-		if (rc != OPAL_SUCCESS) {
-			pe_warn(slave, "OPAL error %ld %s to parent PELTV\n",
-				rc, desc);
-			return -ENXIO;
-		}
-	}
-
-	return 0;
-}
-
-static int pnv_ioda_set_peltv(struct pnv_phb *phb,
-			      struct pnv_ioda_pe *pe,
-			      bool is_add)
-{
-	struct pnv_ioda_pe *slave;
-	struct pci_dev *pdev = NULL;
-	int ret;
-
-	/*
-	 * Clear PE frozen state. If it's master PE, we need
-	 * clear slave PE frozen state as well.
-	 */
-	if (is_add) {
-		opal_pci_eeh_freeze_clear(phb->opal_id, pe->pe_number,
-					  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
-		if (pe->flags & PNV_IODA_PE_MASTER) {
-			list_for_each_entry(slave, &pe->slaves, list)
-				opal_pci_eeh_freeze_clear(phb->opal_id,
-							  slave->pe_number,
-							  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
-		}
-	}
-
-	/*
-	 * Associate PE in PELT. We need add the PE into the
-	 * corresponding PELT-V as well. Otherwise, the error
-	 * originated from the PE might contribute to other
-	 * PEs.
-	 */
-	ret = pnv_ioda_set_one_peltv(phb, pe, pe, is_add);
-	if (ret)
-		return ret;
+	/* Find master PE */
+	pe = &phb->ioda.pe_array[pe_no];
+	if (pe->flags & PNV_IODA_PE_SLAVE) {
+		pe = pe->master;
+		WARN_ON(!pe || !(pe->flags & PNV_IODA_PE_MASTER));
+		pe_no = pe->pe_number;
+	}
 
-	/* For compound PEs, any one affects all of them */
-	if (pe->flags & PNV_IODA_PE_MASTER) {
-		list_for_each_entry(slave, &pe->slaves, list) {
-			ret = pnv_ioda_set_one_peltv(phb, slave, pe, is_add);
-			if (ret)
-				return ret;
-		}
+	/* Clear frozen state for master PE */
+	rc = opal_pci_eeh_freeze_clear(phb->opal_id, pe_no, opt);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld clear %d on PHB#%x-PE#%x\n",
+			__func__, rc, opt, phb->hose->global_number, pe_no);
+		return -EIO;
 	}
 
-	if (pe->flags & (PNV_IODA_PE_BUS_ALL | PNV_IODA_PE_BUS))
-		pdev = pe->pbus->self;
-	else if (pe->flags & PNV_IODA_PE_DEV)
-		pdev = pe->pdev->bus->self;
-#ifdef CONFIG_PCI_IOV
-	else if (pe->flags & PNV_IODA_PE_VF)
-		pdev = pe->parent_dev;
-#endif /* CONFIG_PCI_IOV */
-	while (pdev) {
-		struct pci_dn *pdn = pci_get_pdn(pdev);
-		struct pnv_ioda_pe *parent;
+	if (!(pe->flags & PNV_IODA_PE_MASTER))
+		return 0;
 
-		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
-			parent = &phb->ioda.pe_array[pdn->pe_number];
-			ret = pnv_ioda_set_one_peltv(phb, parent, pe, is_add);
-			if (ret)
-				return ret;
+	/* Clear frozen state for slave PEs */
+	list_for_each_entry(slave, &pe->slaves, list) {
+		rc = opal_pci_eeh_freeze_clear(phb->opal_id,
+					     slave->pe_number,
+					     opt);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Failure %lld clear %d on PHB#%x-PE#%x\n",
+				__func__, rc, opt, phb->hose->global_number,
+				slave->pe_number);
+			return -EIO;
 		}
-
-		pdev = pdev->bus->self;
 	}
 
 	return 0;
 }
 
-#ifdef CONFIG_PCI_IOV
-static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
+static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
 {
-	struct pci_dev *parent;
-	uint8_t bcomp, dcomp, fcomp;
-	int64_t rc;
-	long rid_end, rid;
+	struct pnv_ioda_pe *slave, *pe;
+	u8 fstate, state;
+	__be16 pcierr;
+	s64 rc;
 
-	/* Currently, we just deconfigure VF PE. Bus PE will always there.*/
-	if (pe->pbus) {
-		int count;
+	/* Sanity check on PE number */
+	if (pe_no < 0 || pe_no >= phb->ioda.total_pe_num)
+		return OPAL_EEH_STOPPED_PERM_UNAVAIL;
 
-		dcomp = OPAL_IGNORE_RID_DEVICE_NUMBER;
-		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
-		parent = pe->pbus->self;
-		if (pe->flags & PNV_IODA_PE_BUS_ALL)
-			count = pe->pbus->busn_res.end - pe->pbus->busn_res.start + 1;
-		else
-			count = 1;
+	/*
+	 * Fetch the master PE and the PE instance might be
+	 * not initialized yet.
+	 */
+	pe = &phb->ioda.pe_array[pe_no];
+	if (pe->flags & PNV_IODA_PE_SLAVE) {
+		pe = pe->master;
+		WARN_ON(!pe || !(pe->flags & PNV_IODA_PE_MASTER));
+		pe_no = pe->pe_number;
+	}
 
-		switch(count) {
-		case  1: bcomp = OpalPciBusAll;         break;
-		case  2: bcomp = OpalPciBus7Bits;       break;
-		case  4: bcomp = OpalPciBus6Bits;       break;
-		case  8: bcomp = OpalPciBus5Bits;       break;
-		case 16: bcomp = OpalPciBus4Bits;       break;
-		case 32: bcomp = OpalPciBus3Bits;       break;
-		default:
-			dev_err(&pe->pbus->dev, "Number of subordinate buses %d unsupported\n",
-			        count);
-			/* Do an exact match only */
-			bcomp = OpalPciBusAll;
-		}
-		rid_end = pe->rid + (count << 8);
-	} else {
-		if (pe->flags & PNV_IODA_PE_VF)
-			parent = pe->parent_dev;
-		else
-			parent = pe->pdev->bus->self;
-		bcomp = OpalPciBusAll;
-		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
-		fcomp = OPAL_COMPARE_RID_FUNCTION_NUMBER;
-		rid_end = pe->rid + 1;
+	/* Check the master PE */
+	rc = opal_pci_eeh_freeze_status(phb->opal_id, pe_no,
+					&state, &pcierr, NULL);
+	if (rc != OPAL_SUCCESS) {
+		pr_warn("%s: Failure %lld getting PHB#%x-PE#%x state\n",
+			__func__, rc, phb->hose->global_number, pe_no);
+		return OPAL_EEH_STOPPED_TEMP_UNAVAIL;
 	}
 
-	/* Clear the reverse map */
-	for (rid = pe->rid; rid < rid_end; rid++)
-		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
+	/* Check the slave PE */
+	if (!(pe->flags & PNV_IODA_PE_MASTER))
+		return state;
 
-	/* Release from all parents PELT-V */
-	while (parent) {
-		struct pci_dn *pdn = pci_get_pdn(parent);
-		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
-			rc = opal_pci_set_peltv(phb->opal_id, pdn->pe_number,
-						pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
-			/* XXX What to do in case of error ? */
+	list_for_each_entry(slave, &pe->slaves, list) {
+		rc = opal_pci_eeh_freeze_status(phb->opal_id,
+						slave->pe_number,
+						&fstate,
+						&pcierr,
+						NULL);
+		if (rc != OPAL_SUCCESS) {
+			pr_warn("%s: Failure %lld getting PHB#%x-PE#%x state\n",
+				__func__, rc, phb->hose->global_number,
+				slave->pe_number);
+			return OPAL_EEH_STOPPED_TEMP_UNAVAIL;
 		}
-		parent = parent->bus->self;
-	}
 
-	opal_pci_eeh_freeze_clear(phb->opal_id, pe->pe_number,
-				  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
+		/*
+		 * Override the result based on the ascending
+		 * priority.
+		 */
+		if (fstate > state)
+			state = fstate;
+	}
 
-	/* Disassociate PE in PELT */
-	rc = opal_pci_set_peltv(phb->opal_id, pe->pe_number,
-				pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
-	if (rc)
-		pe_warn(pe, "OPAL error %ld remove self from PELTV\n", rc);
-	rc = opal_pci_set_pe(phb->opal_id, pe->pe_number, pe->rid,
-			     bcomp, dcomp, fcomp, OPAL_UNMAP_PE);
-	if (rc)
-		pe_err(pe, "OPAL error %ld trying to setup PELT table\n", rc);
+	return state;
+}
 
-	pe->pbus = NULL;
-	pe->pdev = NULL;
-	pe->parent_dev = NULL;
+/* Currently those 2 are only used when MSIs are enabled, this will change
+ * but in the meantime, we need to protect them to avoid warnings
+ */
+#ifdef CONFIG_PCI_MSI
+static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
+{
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+	struct pci_dn *pdn = pci_get_pdn(dev);
 
-	return 0;
+	if (!pdn)
+		return NULL;
+	if (pdn->pe_number == IODA_INVALID_PE)
+		return NULL;
+	return &phb->ioda.pe_array[pdn->pe_number];
 }
-#endif /* CONFIG_PCI_IOV */
+#endif /* CONFIG_PCI_MSI */
 
 static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
@@ -1293,29 +1394,6 @@ m64_failed:
 	return -EBUSY;
 }
 
-static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
-		int num);
-static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable);
-
-static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe *pe)
-{
-	struct iommu_table    *tbl;
-	int64_t               rc;
-
-	tbl = pe->table_group.tables[0];
-	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
-	if (rc)
-		pe_warn(pe, "OPAL error %ld release DMA window\n", rc);
-
-	pnv_pci_ioda2_set_bypass(pe, false);
-	if (pe->table_group.group) {
-		iommu_group_put(pe->table_group.group);
-		BUG_ON(pe->table_group.group);
-	}
-	pnv_pci_ioda2_table_free_pages(tbl);
-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
-}
-
 static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 {
 	struct pci_bus        *bus;
@@ -1804,19 +1882,6 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
 	.get = pnv_tce_get,
 };
 
-static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_pe *pe)
-{
-	/* 01xb - invalidate TCEs that match the specified PE# */
-	unsigned long val = (0x4ull << 60) | (pe->pe_number & 0xFF);
-	struct pnv_phb *phb = pe->phb;
-
-	if (!phb->ioda.tce_inval_reg)
-		return;
-
-	mb(); /* Ensure above stores are visible */
-	__raw_writeq(cpu_to_be64(val), phb->ioda.tce_inval_reg);
-}
-
 static void pnv_pci_ioda2_do_tce_invalidate(unsigned pe_number, bool rm,
 		__be64 __iomem *invalidate, unsigned shift,
 		unsigned long index, unsigned long npages)
@@ -2055,34 +2120,6 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 	return 0;
 }
 
-static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
-{
-	uint16_t window_id = (pe->pe_number << 1 ) + 1;
-	int64_t rc;
-
-	pe_info(pe, "%sabling 64-bit DMA bypass\n", enable ? "En" : "Dis");
-	if (enable) {
-		phys_addr_t top = memblock_end_of_DRAM();
-
-		top = roundup_pow_of_two(top);
-		rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id,
-						     pe->pe_number,
-						     window_id,
-						     pe->tce_bypass_base,
-						     top);
-	} else {
-		rc = opal_pci_map_pe_dma_window_real(pe->phb->opal_id,
-						     pe->pe_number,
-						     window_id,
-						     pe->tce_bypass_base,
-						     0);
-	}
-	if (rc)
-		pe_err(pe, "OPAL error %lld configuring bypass window\n", rc);
-	else
-		pe->tce_bypass_enabled = enable;
-}
-
 static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 		__u32 page_shift, __u64 window_size, __u32 levels,
 		struct iommu_table *tbl);
@@ -2162,32 +2199,6 @@ static long pnv_pci_ioda2_setup_default_config(struct pnv_ioda_pe *pe)
 	return 0;
 }
 
-#if defined(CONFIG_IOMMU_API) || defined(CONFIG_PCI_IOV)
-static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
-		int num)
-{
-	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
-			table_group);
-	struct pnv_phb *phb = pe->phb;
-	long ret;
-
-	pe_info(pe, "Removing DMA window #%d\n", num);
-
-	ret = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
-			(pe->pe_number << 1) + num,
-			0/* levels */, 0/* table address */,
-			0/* table size */, 0/* page size */);
-	if (ret)
-		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
-	else
-		pnv_pci_ioda2_tce_invalidate_entire(pe);
-
-	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
-
-	return ret;
-}
-#endif
-
 #ifdef CONFIG_IOMMU_API
 static unsigned long pnv_pci_ioda2_get_table_size(__u32 page_shift,
 		__u64 window_size, __u32 levels)
-- 
2.1.0
