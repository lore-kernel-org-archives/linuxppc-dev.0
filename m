Return-Path: <bryantly@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0wtW6QrdzDrXM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 09:38:43 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBIMcdYG145725
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 17:38:39 -0500
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2exj6tt74j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 17:38:37 -0500
Received: from localhost
 by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bryantly@linux.vnet.ibm.com>;
 Mon, 18 Dec 2017 17:38:30 -0500
From: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, jjalvare@linux.vnet.ibm.com,
 alex.williamson@redhat.com, helgaas@kernel.org, aik@ozlabs.ru,
 ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com, "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>
Subject: [PATCH v2 1/7] platform/pseries: Update VF config space after EEH
Date: Mon, 18 Dec 2017 16:38:02 -0600
In-Reply-To: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
References: <20171218223808.83928-1-bryantly@linux.vnet.ibm.com>
Message-Id: <20171218223808.83928-2-bryantly@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add EEH platform operations for pseries to update VF
config space. With this change after EEH, the VF
will have updated config space for pseries platform.

Signed-off-by: Bryant G. Ly <bryantly@linux.vnet.ibm.com>
Signed-off-by: Juan J. Alvarez <jjalvare@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/eeh.h               |  1 +
 arch/powerpc/kernel/eeh.c                    | 59 +++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/eeh-powernv.c | 65 ++--------------------------
 arch/powerpc/platforms/pseries/eeh_pseries.c | 26 ++++++++++-
 4 files changed, 88 insertions(+), 63 deletions(-)

diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
index 5161c37dd039..82829c65f31a 100644
--- a/arch/powerpc/include/asm/eeh.h
+++ b/arch/powerpc/include/asm/eeh.h
@@ -297,6 +297,7 @@ int eeh_pe_reset(struct eeh_pe *pe, int option);
 int eeh_pe_configure(struct eeh_pe *pe);
 int eeh_pe_inject_err(struct eeh_pe *pe, int type, int func,
 		      unsigned long addr, unsigned long mask);
+int eeh_restore_vf_config(struct pci_dn *pdn);
 
 /**
  * EEH_POSSIBLE_ERROR() -- test for possible MMIO failure.
diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index cbca0a667682..cc649809885e 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -740,6 +740,65 @@ static void *eeh_restore_dev_state(void *data, void *userdata)
 	return NULL;
 }
 
+int eeh_restore_vf_config(struct pci_dn *pdn)
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
 /**
  * pcibios_set_pcie_reset_state - Set PCI-E reset state
  * @dev: pci device struct
diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
index 961e64115d92..0665b6d03cb3 100644
--- a/arch/powerpc/platforms/powernv/eeh-powernv.c
+++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
@@ -1655,70 +1655,11 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
 	return ret;
 }
 
-static int pnv_eeh_restore_vf_config(struct pci_dn *pdn)
-{
-	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
-	u32 devctl, cmd, cap2, aer_capctl;
-	int old_mps;
-
-	if (edev->pcie_cap) {
-		/* Restore MPS */
-		old_mps = (ffs(pdn->mps) - 8) << 5;
-		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
-				     2, &devctl);
-		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
-		devctl |= old_mps;
-		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
-				      2, devctl);
-
-		/* Disable Completion Timeout */
-		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
-				     4, &cap2);
-		if (cap2 & 0x10) {
-			eeh_ops->read_config(pdn,
-					     edev->pcie_cap + PCI_EXP_DEVCTL2,
-					     4, &cap2);
-			cap2 |= 0x10;
-			eeh_ops->write_config(pdn,
-					      edev->pcie_cap + PCI_EXP_DEVCTL2,
-					      4, cap2);
-		}
-	}
-
-	/* Enable SERR and parity checking */
-	eeh_ops->read_config(pdn, PCI_COMMAND, 2, &cmd);
-	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
-	eeh_ops->write_config(pdn, PCI_COMMAND, 2, cmd);
-
-	/* Enable report various errors */
-	if (edev->pcie_cap) {
-		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
-				     2, &devctl);
-		devctl &= ~PCI_EXP_DEVCTL_CERE;
-		devctl |= (PCI_EXP_DEVCTL_NFERE |
-			   PCI_EXP_DEVCTL_FERE |
-			   PCI_EXP_DEVCTL_URRE);
-		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
-				      2, devctl);
-	}
-
-	/* Enable ECRC generation and check */
-	if (edev->pcie_cap && edev->aer_cap) {
-		eeh_ops->read_config(pdn, edev->aer_cap + PCI_ERR_CAP,
-				     4, &aer_capctl);
-		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
-		eeh_ops->write_config(pdn, edev->aer_cap + PCI_ERR_CAP,
-				      4, aer_capctl);
-	}
-
-	return 0;
-}
-
 static int pnv_eeh_restore_config(struct pci_dn *pdn)
 {
 	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
 	struct pnv_phb *phb;
-	s64 ret;
+	s64 ret = 0;
 	int config_addr = (pdn->busno << 8) | (pdn->devfn);
 
 	if (!edev)
@@ -1732,7 +1673,7 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 	 * to be exported by firmware in extendible way.
 	 */
 	if (edev->physfn) {
-		ret = pnv_eeh_restore_vf_config(pdn);
+		ret = eeh_restore_vf_config(pdn);
 	} else {
 		phb = pdn->phb->private_data;
 		ret = opal_pci_reinit(phb->opal_id,
@@ -1745,7 +1686,7 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
 		return -EIO;
 	}
 
-	return 0;
+	return ret;
 }
 
 static struct eeh_ops pnv_eeh_ops = {
diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 2295f117e2d3..a671ef4f57f5 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -708,6 +708,30 @@ static int pseries_eeh_write_config(struct pci_dn *pdn, int where, int size, u32
 	return rtas_write_config(pdn, where, size, val);
 }
 
+static int pseries_eeh_restore_config(struct pci_dn *pdn)
+{
+	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
+	s64 ret = 0;
+
+	if (!edev)
+		return -EEXIST;
+
+	/*
+	 * FIXME: The MPS, error routing rules, timeout setting are worthy
+	 * to be exported by firmware in extendible way.
+	 */
+	if (edev->physfn)
+		ret = eeh_restore_vf_config(pdn);
+
+	if (ret) {
+		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
+			__func__, edev->pe_config_addr, ret);
+		return -EIO;
+	}
+
+	return ret;
+}
+
 static struct eeh_ops pseries_eeh_ops = {
 	.name			= "pseries",
 	.init			= pseries_eeh_init,
@@ -723,7 +747,7 @@ static struct eeh_ops pseries_eeh_ops = {
 	.read_config		= pseries_eeh_read_config,
 	.write_config		= pseries_eeh_write_config,
 	.next_error		= NULL,
-	.restore_config		= NULL
+	.restore_config		= pseries_eeh_restore_config
 };
 
 /**
-- 
2.14.3 (Apple Git-98)
