Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 698BF1A09C0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 16:03:15 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 11:33:12 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 92A99E005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:37:06 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H6379Y49938436
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:33:08 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H637Fx015308
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:33:07 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V9 08/11] powerpc/powernv: Support EEH reset for VF PE
Date: Fri, 17 Jul 2015 14:02:38 +0800
Message-Id: <1437112961-17275-9-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1437112961-17275-1-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PEs for VFs don't have primary bus. So they have to have their own reset
backend, which is used during EEH recovery. The patch implements the reset
backend for VF's PE by issuing FLR or AF FLR to the VFs, which are contained
in the PE.

[gwshan: changelog and code refactoring]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c |  134 +++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index ec21f8f..331c856 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -136,6 +136,7 @@ struct eeh_dev {
 	int pcix_cap;			/* Saved PCIx capability	*/
 	int pcie_cap;			/* Saved PCIe capability	*/
 	int aer_cap;			/* Saved AER capability		*/
+	int af_cap;			/* Saved AF capability		*/
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e9aec1d..8d88be1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -404,6 +404,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	edev->pcix_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_PCIX);
 	edev->pcie_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
 	edev->aer_cap  = pnv_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
+	edev->af_cap   = pnv_eeh_find_cap(pdn, PCI_CAP_ID_AF);
 	if ((edev->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		edev->mode |= EEH_DEV_BRIDGE;
 		if (edev->pcie_cap) {
@@ -893,6 +894,127 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static void pnv_eeh_wait_for_pending(struct pci_dn *pdn, int pos,
+				     u16 mask, bool af_flr_rst)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	int status, i;
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
+	pr_warn("%s: Pending transaction while issuing %s FLR to "
+		"%04x:%02x:%02x.%01x\n",
+		__func__, af_flr_rst ? "AF" : "",
+		edev->phb->global_number, pdn->busno,
+		PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+}
+
+static int pnv_eeh_do_flr(struct pci_dn *pdn, int option)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	u32 reg;
+
+	if (!edev->pcie_cap)
+		return -ENOTTY;
+
+	eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP, 4, &reg);
+	if (!(reg & PCI_EXP_DEVCAP_FLR))
+		return -ENOTTY;
+
+	switch (option) {
+	case EEH_RESET_HOT:
+	case EEH_RESET_FUNDAMENTAL:
+		pnv_eeh_wait_for_pending(pdn, edev->pcie_cap + PCI_EXP_DEVSTA,
+					 PCI_EXP_DEVSTA_TRPND, false);
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
+	u32 cap;
+
+	if (!edev->af_cap)
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
+		pnv_eeh_wait_for_pending(pdn, edev->af_cap + PCI_AF_CTRL,
+					 PCI_AF_STATUS_TP << 8, true);
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
+static int pnv_eeh_reset_vf(struct pci_dn *pdn, int option)
+{
+	int ret;
+
+	ret = pnv_eeh_do_flr(pdn, option);
+	if (ret != -ENOTTY)
+		return ret;
+
+	return pnv_eeh_do_af_flr(pdn, option);
+}
+
+static int pnv_eeh_vf_pe_reset(struct eeh_pe *pe, int option)
+{
+	struct eeh_dev *edev, *tmp;
+	struct pci_dn *pdn;
+	int ret;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdn = eeh_dev_to_pdn(edev);
+		ret = pnv_eeh_reset_vf(pdn, option);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
@@ -968,7 +1090,9 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 		}
 
 		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus) ||
+		if (pe->type & EEH_PE_VF)
+			ret = pnv_eeh_vf_pe_reset(pe, option);
+		else if (pci_is_root_bus(bus) ||
 			pci_is_root_bus(bus->parent))
 			ret = pnv_eeh_root_reset(hose, option);
 		else
@@ -1108,6 +1232,14 @@ static inline bool pnv_eeh_cfg_blocked(struct pci_dn *pdn)
 	if (!edev || !edev->pe)
 		return false;
 
+	/*
+	 * We will issue FLR or AF FLR to all VFs, which are contained
+	 * in VF PE. It relies on the EEH PCI config accessors. So we
+	 * can't block them during the window.
+	 */
+	if ((edev->physfn) && (edev->pe->state & EEH_PE_RESET))
+		return false;
+
 	if (edev->pe->state & EEH_PE_CFG_BLOCKED)
 		return true;
 
-- 
1.7.9.5
