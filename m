Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5C521A1167
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 17:10:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 4 May 2015 17:10:44 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4F0523578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 17:10:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t447AYwF31916146
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 17:10:42 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t447A9Gl002597
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 17:10:09 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V3 7/9] powerpc/powernv: Support EEH reset for VFs
Date: Mon,  4 May 2015 15:07:36 +0800
Message-Id: <1430723258-21299-8-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1430723258-21299-1-git-send-email-weiyang@linux.vnet.ibm.com>
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

Before VF PE introduced, there isn't a method to reset an individual pci
function. And since FW is not aware of the VF, the VF's reset should be
done in kernel.

This patch introduce a pnv_eeh_vf_pe_reset() to do the flr or af_flr to a
VF.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c |  111 +++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 2067de4..78c8bec 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -135,6 +135,7 @@ struct eeh_dev {
 	int pcix_cap;			/* Saved PCIx capability	*/
 	int pcie_cap;			/* Saved PCIe capability	*/
 	int aer_cap;			/* Saved AER capability		*/
+	int af_cap;			/* Saved AF capability		*/
 	struct eeh_pe *pe;		/* Associated PE		*/
 	struct list_head list;		/* Form link list in the PE	*/
 	struct pci_controller *phb;	/* Associated PHB		*/
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 5447481..1ad322f 100644
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
@@ -891,6 +892,105 @@ static int pnv_eeh_bridge_reset(struct pci_dev *dev, int option)
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
+static int pnv_eeh_do_flr(struct pci_dn *pdn)
+{
+	u32 cap;
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+
+	eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP, 4, &cap);
+	if (!(cap & PCI_EXP_DEVCAP_FLR))
+		return -ENOTTY;
+
+	if (!pnv_pci_wait_for_pending(pdn, edev->pcie_cap + PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_TRPND))
+		pr_err("%04x:%02x:%02x:%01x timed out waiting for pending transaction; performing function level reset anyway\n",
+			edev->phb->global_number, pdn->busno,
+			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+
+	eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL, 4, &cap);
+	cap |= PCI_EXP_DEVCTL_BCR_FLR;
+	eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL, 4, cap);
+	msleep(100);
+	return 0;
+}
+
+static int pnv_eeh_do_af_flr(struct pci_dn *pdn)
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
+		pr_err("%04x:%02x:%02x:%01x timed out waiting for pending transaction; performing AF function level reset anyway\n",
+			edev->phb->global_number, pdn->busno,
+			PCI_SLOT(pdn->devfn), PCI_FUNC(pdn->devfn));
+
+	eeh_ops->write_config(pdn, edev->af_cap + PCI_AF_CTRL, 1, PCI_AF_CTRL_FLR);
+	msleep(100);
+	return 0;
+}
+
+static int pnv_eeh_reset_vf(struct pci_dn *pdn)
+{
+	int rc;
+
+	might_sleep();
+
+	rc = pnv_eeh_do_flr(pdn);
+	if (rc != -ENOTTY)
+		goto done;
+
+	rc = pnv_eeh_do_af_flr(pdn);
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
+		ret |= pnv_eeh_reset_vf(pdn);
+	}
+
+	return ret;
+}
+
 void pnv_pci_reset_secondary_bus(struct pci_dev *dev)
 {
 	struct pci_controller *hose;
@@ -966,7 +1066,9 @@ static int pnv_eeh_reset(struct eeh_pe *pe, int option)
 		}
 
 		bus = eeh_pe_bus_get(pe);
-		if (pci_is_root_bus(bus) ||
+		if (pe->type & EEH_PE_VF)
+			ret = pnv_eeh_vf_pe_reset(pe, option);
+		else if (pci_is_root_bus(bus) ||
 			pci_is_root_bus(bus->parent))
 			ret = pnv_eeh_root_reset(hose, option);
 		else
@@ -1106,6 +1208,13 @@ static inline bool pnv_eeh_cfg_blocked(struct pci_dn *pdn)
 	if (!edev || !edev->pe)
 		return false;
 
+	/*
+	 * For VF's reset operation, we need to rely on the kernel to
+	 * do those pci read/write, since FW isn't aware of VFs.
+	 */
+	if ((edev->mode & EEH_DEV_VF) && (edev->pe->state & EEH_PE_RESET))
+		return true;
+
 	if (edev->pe->state & EEH_PE_CFG_BLOCKED)
 		return true;
 
-- 
1.7.9.5
