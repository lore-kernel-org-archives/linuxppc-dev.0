Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7680B1A196D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:52:05 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Fri, 15 May 2015 15:52:04 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 814DD2CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:52:01 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4F5prOY21299386
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:52:01 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4F5pSmK003905
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 15:51:28 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V4 08/11] powerpc/powernv: Support PCI config restore for VFs
Date: Fri, 15 May 2015 13:46:23 +0800
Message-Id: <1431668786-30371-9-git-send-email-weiyang@linux.vnet.ibm.com>
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

Since skiboot firmware is not aware of VFs, the restore action for VF
should be done in kernel.

The patch introduces function pnv_eeh_restore_vf_config() to restore PCI
config space for VFs after reset.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h        |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c |   59 +++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/pci.c         |   16 +++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index d78afe4..168b991 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -205,6 +205,7 @@ struct pci_dn {
 	int     m64_per_iov;
 #define IODA_INVALID_M64        (-1)
 	int     m64_wins[PCI_SRIOV_NUM_BARS][M64_PER_IOV];
+	int	mps;
 #endif /* CONFIG_PCI_IOV */
 #endif
 	struct list_head child_list;
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 61f1a55..e200ed1 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1601,6 +1601,59 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 	return ret;
 }
 
+#ifdef CONFIG_PCI_IOV
+static int pnv_eeh_restore_vf_config(struct pci_dn *pdn)
+{
+	int pcie_cap, aer_cap, old_mps;
+	u32 devctl, cmd, cap2, aer_capctl;
+
+	/* Restore MPS */
+	pcie_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
+	if (pcie_cap) {
+		old_mps = (ffs(pdn->mps) - 8) << 5;
+		eeh_ops->read_config(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
+		devctl |= old_mps;
+		eeh_ops->write_config(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, devctl);
+	}
+
+	/* Disable Completion Timeout */
+	if (pcie_cap) {
+		eeh_ops->read_config(pdn, pcie_cap + PCI_EXP_DEVCAP2, 4, &cap2);
+		if (cap2 & 0x10) {
+			eeh_ops->read_config(pdn, pcie_cap + PCI_EXP_DEVCTL2, 4, &cap2);
+			cap2 |= 0x10;
+			eeh_ops->write_config(pdn, pcie_cap + PCI_EXP_DEVCTL2, 4, cap2);
+		}
+	}
+
+	/* Enable SERR and parity checking */
+	eeh_ops->read_config(pdn, PCI_COMMAND, 2, &cmd);
+	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
+	eeh_ops->write_config(pdn, PCI_COMMAND, 2, cmd);
+
+	/* Enable report various errors */
+	if (pcie_cap) {
+		eeh_ops->read_config(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_CERE;
+		devctl |= (PCI_EXP_DEVCTL_NFERE |
+			   PCI_EXP_DEVCTL_FERE |
+			   PCI_EXP_DEVCTL_URRE);
+		eeh_ops->write_config(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, devctl);
+	}
+
+	/* Enable ECRC generation and check */
+	if (pcie_cap) {
+		aer_cap = pnv_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
+		eeh_ops->read_config(pdn, aer_cap + PCI_ERR_CAP, 4, &aer_capctl);
+		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
+		eeh_ops->write_config(pdn, aer_cap + PCI_ERR_CAP, 4, aer_capctl);
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PCI_IOV */
+
 static int pnv_eeh_restore_config(struct pci_dn *pdn)
 {
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
@@ -1611,7 +1664,11 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 		return -EEXIST;
 
 	phb = edev->phb->private_data;
-	ret = opal_pci_reinit(phb->opal_id,
+	/* FW is not VF aware, we rely on OS to restore it */
+	if (edev->physfn)
+		ret = pnv_eeh_restore_vf_config(pdn);
+	else
+		ret = opal_pci_reinit(phb->opal_id,
 			      OPAL_REINIT_PCI_DEV, edev->config_addr);
 	if (ret) {
 		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index bca2aeb..31d0258 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -781,3 +781,19 @@ machine_subsys_initcall_sync(powernv, tce_iommu_bus_notifier_init);
 struct pci_controller_ops pnv_pci_controller_ops = {
 	.dma_dev_setup = pnv_pci_dma_dev_setup,
 };
+
+static void pnv_pci_fixup_vf_caps(struct pci_dev *pdev)
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
+DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_caps);
-- 
1.7.9.5
