Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A42271A18F9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:51:47 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 15 May 2015 15:51:46 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BCE743578054
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:51:43 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F5pZKu47120418
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:51:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F5pATY003522
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:51:11 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V4 07/11] powerpc/powernv: Support EEH reset for VFs
Date: Fri, 15 May 2015 13:46:22 +0800
Message-Id: <1431668786-30371-8-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1431668786-30371-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

Before VF PE is introduced, there isn't a method to reset an individual PCI
function. And since skiboot firmware is not aware of the VF, the VF's reset
should be done in kernel.

This patch introduces a function pnv_eeh_vf_pe_reset() to do the FLR or AF
FLR to a VF.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c |  123 +++++++++++++++++++++++++-
 2 files changed, 123 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index c1fde48..3d64cf3 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -134,6 +134,7 @@ struct eeh_dev {
 	int pcix_cap;			/* Saved PCIx capability	*/
 	int pcie_cap;			/* Saved PCIe capability	*/
 	int aer_cap;			/* Saved AER capability		*/
+	int af_cap;			/* Saved AF capability		*/
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 31344a4..61f1a55 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -402,6 +402,7 @@ static void *pnv_eeh_probe(struct pci_dn *pdn, void *data)
 	edev->pcix_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_PCIX);
 	edev->pcie_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
 	edev->aer_cap  = pnv_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
+	edev->af_cap   = pnv_eeh_find_cap(pdn, PCI_CAP_ID_AF);
 	if ((edev->class_code >> 8) == PCI_CLASS_BRIDGE_PCI) {
 		edev->mode |= EEH_DEV_BRIDGE;
 		if (edev->pcie_cap) {
@@ -891,6 +892,117 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
 	return 0;
 }
 
+static int pnv_pci_wait_for_pending(struct pci_dn *pdn, int pos, u16 mask)
+{
+	int i;
+
+	/* Wait for Transaction Pending bit clean */
+	for (i = 0; i < 4; i++) {
+		u32 status;
+		if (i)
+			msleep((1 << (i - 1)) * 100);
+
+		eeh_ops->read_config(pdn, pos, 2, &status);
+		if (!(status & mask))
+			return 1;
+	}
+
+	return 0;
+}
+
+static int pnv_eeh_do_flr(struct pci_dn *pdn, int option)
+{
+	u32 cap;
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+
+	eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP, 4, &cap);
+	if (!(cap & PCI_EXP_DEVCAP_FLR))
+		return -ENOTTY;
+
+	if (!pnv_pci_wait_for_pending(pdn, edev->pcie_cap + PCI_EXP_DEVSTA,
+			PCI_EXP_DEVSTA_TRPND))
+		pr_err("%04x:%02x:%02x:%01x timed out waiting for pending "
+		       "transaction; performing function level reset anyway\n",
+			edev->phb->global_number, pdn->busno,
+			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+
+	eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL, 4, &cap);
+	if (option == EEH_RESET_DEACTIVATE)
+		cap &= ~PCI_EXP_DEVCTL_BCR_FLR;
+	else
+		cap |= PCI_EXP_DEVCTL_BCR_FLR;
+	eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL, 4, cap);
+	msleep(100);
+	return 0;
+}
+
+static int pnv_eeh_do_af_flr(struct pci_dn *pdn, int option)
+{
+	u32 cap;
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+
+	if (!edev->af_cap)
+		return -ENOTTY;
+
+	eeh_ops->read_config(pdn, edev->af_cap + PCI_AF_CAP, 1, &cap);
+	if (!(cap & PCI_AF_CAP_TP) || !(cap & PCI_AF_CAP_FLR))
+		return -ENOTTY;
+
+	/*
+	 * Wait for Transaction Pending bit to clear.  A word-aligned test
+	 * is used, so we use the conrol offset rather than status and shift
+	 * the test bit to match.
+	 */
+	if (!pnv_pci_wait_for_pending(pdn, edev->af_cap + PCI_AF_CTRL,
+				 PCI_AF_STATUS_TP << 8))
+		pr_err("%04x:%02x:%02x:%01x timed out waiting for pending "
+		    "transaction; performing AF function level reset anyway\n",
+			edev->phb->global_number, pdn->busno,
+			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+
+	if (option == EEH_RESET_DEACTIVATE)
+		eeh_ops->write_config(pdn, edev->af_cap + PCI_AF_CTRL, 1, 0);
+	else
+		eeh_ops->write_config(pdn, edev->af_cap + PCI_AF_CTRL, 1,
+				PCI_AF_CTRL_FLR);
+	msleep(100);
+	return 0;
+}
+
+static int pnv_eeh_reset_vf(struct pci_dn *pdn, int option)
+{
+	int rc;
+
+	might_sleep();
+
+	rc = pnv_eeh_do_flr(pdn, option);
+	if (rc != -ENOTTY)
+		goto done;
+
+	rc = pnv_eeh_do_af_flr(pdn, option);
+	if (rc != -ENOTTY)
+		goto done;
+
+done:
+	return rc;
+}
+
+static int pnv_eeh_vf_pe_reset(struct eeh_pe *pe, int option)
+{
+	struct eeh_dev *edev, *tmp;
+	struct pci_dn *pdn;
+	int ret = 0;
+
+	eeh_pe_for_each_dev(pe, edev, tmp) {
+		pdn = eeh_dev_to_pdn(edev);
+		ret |= pnv_eeh_reset_vf(pdn, option);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
@@ -966,7 +1078,9 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 		}
 
 		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus) ||
+		if (pe->type & EEH_PE_VF)
+			ret = pnv_eeh_vf_pe_reset(pe, option);
+		else if (pci_is_root_bus(bus) ||
 			pci_is_root_bus(bus->parent))
 			ret = pnv_eeh_root_reset(hose, option);
 		else
@@ -1106,6 +1220,13 @@ static inline bool pnv_eeh_cfg_blocked(struct pci_dn *pdn)
 	if (!edev || !edev->pe)
 		return false;
 
+	/*
+	 * For VF's reset operation, we need to rely on the kernel to
+	 * do those PCI config operations since firmware isn't aware of VFs.
+	 */
+	if ((edev->physfn) && (edev->pe->state & EEH_PE_RESET))
+		return false;
+
 	if (edev->pe->state & EEH_PE_CFG_BLOCKED)
 		return true;
 
-- 
1.7.9.5
