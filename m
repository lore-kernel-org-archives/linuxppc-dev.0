Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 819841A0C82
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:39 +1100 (AEDT)
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 09:54:39 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 5EA2B2CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:37 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23NsT6f63111346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:37 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23Ns4Lv002701
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:05 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v15 07/12] powerpc/powernv: Support EEH reset for VF PE
Date: Fri,  4 Mar 2016 10:53:09 +1100
Message-Id: <1457049194-9281-8-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1457049194-9281-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wei Yang <weiyang@linux.vnet.ibm.com>

PEs for VFs don't have primary bus. So they have to have their own reset
backend, which is used during EEH recovery. The patch implements the reset
backend for VF's PE by issuing FLR or AF FLR to the VFs, which are contained
in the PE.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |   1 +
 arch/powerpc/kernel/eeh.c                    |   9 +-
 arch/powerpc/platforms/powernv/eeh-powernv.c | 127 ++++++++++++++++++++++++++-
 3 files changed, 133 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 0c551a2..b5b5f45 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -137,6 +137,7 @@ struct eeh_dev {
 	int pcix_cap;			/* Saved PCIx capability	*/
 	int pcie_cap;			/* Saved PCIe capability	*/
 	int aer_cap;			/* Saved AER capability		*/
+	int af_cap;			/* Saved AF capability		*/
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 8c6005c..0d72462 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -761,7 +761,8 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 	case pcie_deassert_reset:
 		eeh_ops->reset(pe, EEH_RESET_DEACTIVATE);
 		eeh_unfreeze_pe(pe, false);
-		eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
+		if (!(pe->type & EEH_PE_VF))
+			eeh_pe_state_clear(pe, EEH_PE_CFG_BLOCKED);
 		eeh_pe_dev_traverse(pe, eeh_restore_dev_state, dev);
 		eeh_pe_state_clear(pe, EEH_PE_ISOLATED);
 		break;
@@ -769,14 +770,16 @@ int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state stat
 		eeh_pe_state_mark_with_cfg(pe, EEH_PE_ISOLATED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
-		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
+		if (!(pe->type & EEH_PE_VF))
+			eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_HOT);
 		break;
 	case pcie_warm_reset:
 		eeh_pe_state_mark_with_cfg(pe, EEH_PE_ISOLATED);
 		eeh_ops->set_option(pe, EEH_OPT_FREEZE_PE);
 		eeh_pe_dev_traverse(pe, eeh_disable_and_save_dev_state, dev);
-		eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
+		if (!(pe->type & EEH_PE_VF))
+			eeh_pe_state_mark(pe, EEH_PE_CFG_BLOCKED);
 		eeh_ops->reset(pe, EEH_RESET_FUNDAMENTAL);
 		break;
 	default:
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 830526e..e26256b 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -371,6 +371,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	edev->mode	&= 0xFFFFFF00;
 	edev->pcix_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_PCIX);
 	edev->pcie_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
+	edev->af_cap   = pnv_eeh_find_cap(pdn, PCI_CAP_ID_AF);
 	edev->aer_cap  = pnv_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
 	if ((edev->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		edev->mode |= EEH_DEV_BRIDGE;
@@ -879,6 +880,120 @@ void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 	}
 }
 
+static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, const char *type,
+				     int pos, u16 mask)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	int i, status = 0;
+
+	/* Wait for Transaction Pending bit to be cleared */
+	for (i = 0; i < 4; i++) {
+		eeh_ops->read_config(pdn, pos, 2, &status);
+		if (!(status & mask))
+			return;
+
+		msleep((1 << i) * 100);
+	}
+
+	pr_warn("%s: Pending transaction while issuing %sFLR to %04x:%02x:%02x.%01x\n",
+		__func__, type,
+		edev->phb->global_number, pdn->busno,
+		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+}
+
+static int pnv_eeh_do_flr(struct pci_dn *pdn, int option)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	u32 reg = 0;
+
+	if (WARN_ON(!edev->pcie_cap))
+		return -ENOTTY;
+
+	eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP, 4, &reg);
+	if (!(reg & PCI_EXP_DEVCAP_FLR))
+		return -ENOTTY;
+
+	switch (option) {
+	case EEH_RESET_HOT:
+	case EEH_RESET_FUNDAMENTAL:
+		pnv_eeh_wait_for_pending(pdn, "",
+					 edev->pcie_cap + PCI_EXP_DEVSTA,
+					 PCI_EXP_DEVSTA_TRPND);
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				     4, &reg);
+		reg |= PCI_EXP_DEVCTL_BCR_FLR;
+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				      4, reg);
+		msleep(EEH_PE_RST_HOLD_TIME);
+		break;
+	case EEH_RESET_DEACTIVATE:
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				     4, &reg);
+		reg &= ~PCI_EXP_DEVCTL_BCR_FLR;
+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				      4, reg);
+		msleep(EEH_PE_RST_SETTLE_TIME);
+		break;
+	}
+
+	return 0;
+}
+
+static int pnv_eeh_do_af_flr(struct pci_dn *pdn, int option)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	u32 cap = 0;
+
+	if (WARN_ON(!edev->af_cap))
+		return -ENOTTY;
+
+	eeh_ops->read_config(pdn, edev->af_cap + PCI_AF_CAP, 1, &cap);
+	if (!(cap & PCI_AF_CAP_TP) || !(cap & PCI_AF_CAP_FLR))
+		return -ENOTTY;
+
+	switch (option) {
+	case EEH_RESET_HOT:
+	case EEH_RESET_FUNDAMENTAL:
+		/*
+		 * Wait for Transaction Pending bit to clear. A word-aligned
+		 * test is used, so we use the conrol offset rather than status
+		 * and shift the test bit to match.
+		 */
+		pnv_eeh_wait_for_pending(pdn, "AF",
+					 edev->af_cap + PCI_AF_CTRL,
+					 PCI_AF_STATUS_TP << 8);
+		eeh_ops->write_config(pdn, edev->af_cap + PCI_AF_CTRL,
+				      1, PCI_AF_CTRL_FLR);
+		msleep(EEH_PE_RST_HOLD_TIME);
+		break;
+	case EEH_RESET_DEACTIVATE:
+		eeh_ops->write_config(pdn, edev->af_cap + PCI_AF_CTRL, 1, 0);
+		msleep(EEH_PE_RST_SETTLE_TIME);
+		break;
+	}
+
+	return 0;
+}
+
+static int pnv_eeh_reset_vf_pe(struct eeh_pe *pe, int option)
+{
+	struct eeh_dev *edev;
+	struct pci_dn *pdn;
+	int ret;
+
+	/* The VF PE should have only one child device */
+	edev = list_first_entry_or_null(&pe->edevs, struct eeh_dev, list);
+	pdn = eeh_dev_to_pdn(edev);
+	if (!pdn)
+		return -ENXIO;
+
+	ret = pnv_eeh_do_flr(pdn, option);
+	if (!ret)
+		return ret;
+
+	return pnv_eeh_do_af_flr(pdn, option);
+}
+
 /**
  * pnv_eeh_reset - Reset the specified PE
  * @pe: EEH PE
@@ -940,7 +1055,9 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 		}
 
 		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus) ||
+		if (pe->type & EEH_PE_VF)
+			ret = pnv_eeh_reset_vf_pe(pe, option);
+		else if (pci_is_root_bus(bus) ||
 			pci_is_root_bus(bus->parent))
 			ret = pnv_eeh_root_reset(hose, option);
 		else
@@ -1079,6 +1196,14 @@ static inline bool pnv_eeh_cfg_blocked(struct pci_dn *pdn)
 	if (!edev || !edev->pe)
 		return false;
 
+	/*
+	 * We will issue FLR or AF FLR to all VFs, which are contained
+	 * in VF PE. It relies on the EEH PCI config accessors. So we
+	 * can't block them during the window.
+	 */
+	if (edev->physfn && (edev->pe->state & EEH_PE_RESET))
+		return false;
+
 	if (edev->pe->state & EEH_PE_CFG_BLOCKED)
 		return true;
 
-- 
2.1.0
