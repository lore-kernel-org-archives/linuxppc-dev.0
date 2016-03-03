Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 900C41A0B99
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:41 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 4 Mar 2016 09:54:41 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 9AEA62CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 10:54:37 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u23NsTm262718082
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:37 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u23Ns5hh026026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Mar 2016 10:54:05 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: ruscur@russell.cc, mpe@ellerman.id.au,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH v15 08/12] powerpc/powernv: Support PCI config restore for VFs
Date: Fri,  4 Mar 2016 10:53:10 +1100
Message-Id: <1457049194-9281-9-git-send-email-gwshan@linux.vnet.ibm.com>
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

After PE reset, OPAL API opal_pci_reinit() is called on all devices
contained in the PE to reinitialize them. While skiboot is not aware of
VFs, we have to implement the function in kernel to reinitialize VFs after
reset on PE for VFs.

In this patch, two functions pnv_pci_fixup_vf_mps() and
pnv_eeh_restore_vf_config() both manipulate the MPS of the VF, since for a
VF it has three cases.

1. Normal creation for a VF
   In this case, pnv_pci_fixup_vf_mps() is called to make the MPS a proper
   value compared with its parent.
2. EEH recovery without VF removed
   In this case, MPS is stored in pci_dn and pnv_eeh_restore_vf_config() is
   called to restore it and reinitialize other part.
3. EEH recovery with VF removed
   In this case, VF will be removed then re-created. Both functions are
   called. First pnv_pci_fixup_vf_mps() is called to store the proper MPS
   to pci_dn and then pnv_eeh_restore_vf_config() is called to do proper
   thing.

This introduces two functions: pnv_pci_fixup_vf_mps() to fixup the VF's
MPS to make sure it is equal to parent's and store this value in pci_dn
for future use. pnv_eeh_restore_vf_config() to re-initialize on VF by
restoring MPS, disabling completion timeout, enabling SERR, etc.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h        |  1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c | 95 +++++++++++++++++++++++++++-
 2 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index b0b43f5..f4d1758 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -220,6 +220,7 @@ struct pci_dn {
 #define IODA_INVALID_M64        (-1)
 	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
 #endif /* CONFIG_PCI_IOV */
+	int	mps;			/* Maximum Payload Size */
 #endif
 	struct list_head child_list;
 	struct list_head list;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index e26256b..950b3e5 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1588,6 +1588,65 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 	return ret;
 }
 
+static int pnv_eeh_restore_vf_config(struct pci_dn *pdn)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	u32 devctl, cmd, cap2, aer_capctl;
+	int old_mps;
+
+	if (edev->pcie_cap) {
+		/* Restore MPS */
+		old_mps = (ffs(pdn->mps) - 8) << 5;
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				     2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
+		devctl |= old_mps;
+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				      2, devctl);
+
+		/* Disable Completion Timeout */
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
+				     4, &cap2);
+		if (cap2 & 0x10) {
+			eeh_ops->read_config(pdn,
+					     edev->pcie_cap + PCI_EXP_DEVCTL2,
+					     4, &cap2);
+			cap2 |= 0x10;
+			eeh_ops->write_config(pdn,
+					      edev->pcie_cap + PCI_EXP_DEVCTL2,
+					      4, cap2);
+		}
+	}
+
+	/* Enable SERR and parity checking */
+	eeh_ops->read_config(pdn, PCI_COMMAND, 2, &cmd);
+	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
+	eeh_ops->write_config(pdn, PCI_COMMAND, 2, cmd);
+
+	/* Enable report various errors */
+	if (edev->pcie_cap) {
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				     2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_CERE;
+		devctl |= (PCI_EXP_DEVCTL_NFERE |
+			   PCI_EXP_DEVCTL_FERE |
+			   PCI_EXP_DEVCTL_URRE);
+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				      2, devctl);
+	}
+
+	/* Enable ECRC generation and check */
+	if (edev->pcie_cap && edev->aer_cap) {
+		eeh_ops->read_config(pdn, edev->aer_cap + PCI_ERR_CAP,
+				     4, &aer_capctl);
+		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
+		eeh_ops->write_config(pdn, edev->aer_cap + PCI_ERR_CAP,
+				      4, aer_capctl);
+	}
+
+	return 0;
+}
+
 static int pnv_eeh_restore_config(struct pci_dn *pdn)
 {
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
@@ -1597,9 +1656,21 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 	if (!edev)
 		return -EEXIST;
 
-	phb = edev->phb->private_data;
-	ret = opal_pci_reinit(phb->opal_id,
-			      OPAL_REINIT_PCI_DEV, edev->config_addr);
+	/*
+	 * We have to restore the PCI config space after reset since the
+	 * firmware can't see SRIOV VFs.
+	 *
+	 * FIXME: The MPS, error routing rules, timeout setting are worthy
+	 * to be exported by firmware in extendible way.
+	 */
+	if (edev->physfn) {
+		ret = pnv_eeh_restore_vf_config(pdn);
+	} else {
+		phb = edev->phb->private_data;
+		ret = opal_pci_reinit(phb->opal_id,
+				      OPAL_REINIT_PCI_DEV, edev->config_addr);
+	}
+
 	if (ret) {
 		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
 			__func__, edev->config_addr, ret);
@@ -1644,6 +1715,24 @@ void pcibios_bus_add_device(struct pci_dev *pdev)
 	eeh_sysfs_add_device(pdev);
 }
 
+#ifdef CONFIG_PCI_IOV
+static void pnv_pci_fixup_vf_mps(struct pci_dev *pdev)
+{
+	struct pci_dn *pdn = pci_get_pdn(pdev);
+	int parent_mps;
+
+	if (!pdev->is_virtfn)
+		return;
+
+	/* Synchronize MPS for VF and PF */
+	parent_mps = pcie_get_mps(pdev->physfn);
+	if ((128 << pdev->pcie_mpss) >= parent_mps)
+		pcie_set_mps(pdev, parent_mps);
+	pdn->mps = pcie_get_mps(pdev);
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_mps);
+#endif /* CONFIG_PCI_IOV */
+
 /**
  * eeh_powernv_init - Register platform dependent EEH operations
  *
-- 
2.1.0
