Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2D081A18F2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 17:11:02 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Mon, 4 May 2015 17:11:02 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 78D502BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 May 2015 17:11:00 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t447AqHV11010254
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 17:11:00 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t447ARTR003120
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 May 2015 17:10:28 +1000
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: gwshan@linux.vnet.ibm.com, bhelgaas@google.com
Subject: [PATCH V3 8/9] powerpc/powernv: Support PCI config restore for VFs
Date: Mon,  4 May 2015 15:07:37 +0800
Message-Id: <1430723258-21299-9-git-send-email-weiyang@linux.vnet.ibm.com>
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

Since FW is not aware of VFs, the restore action for VF should be done in
kernel.

This patch introduces pnv_eeh_vf_restore_config() for VF.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pci-bridge.h        |    1 +
 arch/powerpc/platforms/powernv/eeh-powernv.c |   77 +++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 9582aa2..de55ef6 100644
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
index 1ad322f..6ba6d87 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1589,6 +1589,59 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 	return ret;
 }
 
+#ifdef CONFIG_PCI_IOV
+static int pnv_eeh_vf_restore_config(struct pci_dn *pdn)
+{
+	int pcie_cap, aer_cap, old_mps;
+	u32 devctl, cmd, cap2, aer_capctl;
+
+	/* Restore MPS */
+	pcie_cap = pnv_eeh_find_cap(pdn, PCI_CAP_ID_EXP);
+	if (pcie_cap) {
+		old_mps = (ffs(pdn->mps) - 8) << 5;
+		pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
+		devctl |= old_mps;
+		pnv_pci_cfg_write(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, devctl);
+	}
+
+	/* Disable Completion Timeout */
+	if (pcie_cap) {
+		pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCAP2, 4, &cap2);
+		if (cap2 & 0x10) {
+			pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCTL2, 4, &cap2);
+			cap2 |= 0x10;
+			pnv_pci_cfg_write(pdn, pcie_cap + PCI_EXP_DEVCTL2, 4, cap2);
+		}
+	}
+
+	/* Enable SERR and parity checking */
+	pnv_pci_cfg_read(pdn, PCI_COMMAND, 2, &cmd);
+	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
+	pnv_pci_cfg_write(pdn, PCI_COMMAND, 2, cmd);
+
+	/* Enable report various errors */
+	if (pcie_cap) {
+		pnv_pci_cfg_read(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, &devctl);
+		devctl &= ~PCI_EXP_DEVCTL_CERE;
+		devctl |= (PCI_EXP_DEVCTL_NFERE |
+			   PCI_EXP_DEVCTL_FERE |
+			   PCI_EXP_DEVCTL_URRE);
+		pnv_pci_cfg_write(pdn, pcie_cap + PCI_EXP_DEVCTL, 2, devctl);
+	}
+
+	/* Enable ECRC generation and check */
+	if (pcie_cap) {
+		aer_cap = pnv_eeh_find_ecap(pdn, PCI_EXT_CAP_ID_ERR);
+		pnv_pci_cfg_read(pdn, aer_cap + PCI_ERR_CAP, 4, &aer_capctl);
+		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
+		pnv_pci_cfg_write(pdn, aer_cap + PCI_ERR_CAP, 4, aer_capctl);
+	}
+
+	return 0;
+}
+#endif /* CONFIG_PCI_IOV */
+
 static int pnv_eeh_restore_config(struct pci_dn *pdn)
 {
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
@@ -1599,7 +1652,13 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 		return -EEXIST;
 
 	phb = edev->phb->private_data;
-	ret = opal_pci_reinit(phb->opal_id,
+#ifdef CONFIG_PCI_IOV
+	/* FW is not VF aware, we rely on OS to restore it */
+	if (edev->mode & EEH_DEV_VF)
+		ret = pnv_eeh_vf_restore_config(pdn);
+	else
+#endif
+		ret = opal_pci_reinit(phb->opal_id,
 			      OPAL_REINIT_PCI_DEV, edev->config_addr);
 	if (ret) {
 		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
@@ -1660,4 +1719,20 @@ static void pnv_pci_fixup_vf_eeh(struct pci_dev *pdev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_eeh);
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
 #endif /* CONFIG_PCI_IOV */
-- 
1.7.9.5
