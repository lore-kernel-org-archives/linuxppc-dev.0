Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B569E1A09B8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 16:03:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 17 Jul 2015 11:33:15 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 57ADF125805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:36:08 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6H639I644957862
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 11:33:09 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6H4mEUj003612
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 10:18:14 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: [PATCH V9 09/11] powerpc/powernv: Support PCI config restore for VFs
Date: Fri, 17 Jul 2015 14:02:39 +0800
Message-Id: <1437112961-17275-10-git-send-email-weiyang@linux.vnet.ibm.com>
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

After PE reset, OPAL API opal_pci_reinit() is called on all devices
contained in the PE to reinitialize them. However, VFs can't be seen
from skiboot firmware. We have to implement the functions, similar
those in skiboot firmware, to reinitialize VFs after reset on PE
for VFs.

[gwshan: changelog and code refactoring]
Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h        |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c |   70 +++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c         |   18 +++++++
 3 files changed, 88 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 7a72f68..c927d5b 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -220,6 +220,7 @@ struct pci_dn {
 #define IODA_INVALID_M64        (-1)
 	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
 #endif /* CONFIG_PCI_IOV */
+	int	mps;
 #endif
 	struct list_head child_list;
 	struct list_head list;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 8d88be1..b09c0d1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1616,6 +1616,67 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 	return ret;
 }
 
+static int pnv_eeh_restore_vf_config(struct pci_dn *pdn)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	u32 devctl, cmd, cap2, aer_capctl;
+	int old_mps;
+
+	/* Restore MPS */
+	if (edev->pcie_cap) {
+		old_mps = (ffs(pdn->mps) - 8) << 5;
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				     2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
+		devctl |= old_mps;
+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				      2, devctl);
+	}
+
+	/* Disable Completion Timeout */
+	if (edev->pcie_cap) {
+		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
+				     4, &cap2);
+		if (cap2 & 0x10) {
+			eeh_ops->read_config(pdn,
+					edev->pcie_cap + PCI_EXP_DEVCTL2,
+					4, &cap2);
+			cap2 |= 0x10;
+			eeh_ops->write_config(pdn,
+					edev->pcie_cap + PCI_EXP_DEVCTL2,
+					4, cap2);
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
+				2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_CERE;
+		devctl |= (PCI_EXP_DEVCTL_NFERE |
+			   PCI_EXP_DEVCTL_FERE |
+			   PCI_EXP_DEVCTL_URRE);
+		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
+				2, devctl);
+	}
+
+	/* Enable ECRC generation and check */
+	if (edev->pcie_cap && edev->aer_cap) {
+		eeh_ops->read_config(pdn, edev->aer_cap + PCI_ERR_CAP,
+				4, &aer_capctl);
+		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
+		eeh_ops->write_config(pdn, edev->aer_cap + PCI_ERR_CAP,
+				4, aer_capctl);
+	}
+
+	return 0;
+}
+
 static int pnv_eeh_restore_config(struct pci_dn *pdn)
 {
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
@@ -1626,7 +1687,14 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 		return -EEXIST;
 
 	phb = edev->phb->private_data;
-	ret = opal_pci_reinit(phb->opal_id,
+	/*
+	 * We have to restore the PCI config space after reset since the
+	 * firmware can't see SRIOV VFs.
+	 */
+	if (edev->physfn)
+		ret = pnv_eeh_restore_vf_config(pdn);
+	else
+		ret = opal_pci_reinit(phb->opal_id,
 			      OPAL_REINIT_PCI_DEV, edev->config_addr);
 	if (ret) {
 		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 765d8ed..0e4f42e 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -788,6 +788,24 @@ static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
 
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
 void __init pnv_pci_init(void)
 {
 	struct device_node *np;
-- 
1.7.9.5
