Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A74732C0324
 for <linuxppc-dev@ozlabs.org>; Wed,  6 Mar 2013 10:16:05 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/8] powerpc/85xx: Add support for FSL PCIe controller v3.0
Date: Tue,  5 Mar 2013 17:15:54 -0600
Message-Id: <1362525360-23136-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
References: <1362525360-23136-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roy ZANG <tie-fei.zang@freescale.com>

The T4240 utilizes a new PCIe controller block that has some minor
programming model differences from previous versions.

The major one that impacts initialization is how we determine the link
state.  On the 3.x controllers we have a memory mapped SoC register
instead of a PCI config register that reports the link state.

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |   29 ++++++++++++++++++++++++++---
 arch/powerpc/sysdev/fsl_pci.h |   11 +++++++++++
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 682084d..3271177 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -54,13 +54,35 @@ static void quirk_fsl_pcie_header(struct pci_dev *dev)
 	return;
 }
 
-static int __init fsl_pcie_check_link(struct pci_controller *hose)
+static int __init fsl_pcie_check_link(struct pci_controller *hose,
+				  struct resource *rsrc)
 {
+	struct ccsr_pci __iomem *pci = NULL;
 	u32 val;
 
+	/* for PCIe IP rev 3.0 or greater use CSR0 for link state */
+	if (rsrc) {
+		pr_debug("PCI memory map start 0x%016llx, size 0x%016llx\n",
+		    (u64)rsrc->start, (u64)rsrc->end - (u64)rsrc->start + 1);
+		pci = ioremap(rsrc->start, rsrc->end - rsrc->start + 1);
+		if (!pci) {
+			dev_err(hose->parent, "Unable to map PCIe registers\n");
+			return -ENOMEM;
+		}
+		if (in_be32(&pci->block_rev1) >= PCIE_IP_REV_3_0) {
+			val = (in_be32(&pci->pex_csr0) & PEX_CSR0_LTSSM_MASK)
+					>> PEX_CSR0_LTSSM_SHIFT;
+			if (val != PEX_CSR0_LTSSM_L0)
+				return 1;
+			iounmap(pci);
+			return 0;
+		}
+		iounmap(pci);
+	}
 	early_read_config_dword(hose, 0, 0, PCIE_LTSSM, &val);
 	if (val < PCIE_LTSSM_L0)
 		return 1;
+
 	return 0;
 }
 
@@ -483,7 +505,7 @@ int __init fsl_add_bridge(struct platform_device *pdev, int is_primary)
 	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
 		hose->indirect_type |= PPC_INDIRECT_TYPE_EXT_REG |
 			PPC_INDIRECT_TYPE_SURPRESS_PRIMARY_BUS;
-		if (fsl_pcie_check_link(hose))
+		if (fsl_pcie_check_link(hose, &rsrc))
 			hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
 	}
 
@@ -685,7 +707,7 @@ static int __init mpc83xx_pcie_setup(struct pci_controller *hose,
 	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAH, 0);
 	out_le32(pcie->cfg_type0 + PEX_OUTWIN0_TAL, 0);
 
-	if (fsl_pcie_check_link(hose))
+	if (fsl_pcie_check_link(hose, NULL))
 		hose->indirect_type |= PPC_INDIRECT_TYPE_NO_PCIE_LINK;
 
 	return 0;
@@ -836,6 +858,7 @@ static const struct of_device_id pci_ids[] = {
 	{ .compatible = "fsl,qoriq-pcie-v2.2", },
 	{ .compatible = "fsl,qoriq-pcie-v2.3", },
 	{ .compatible = "fsl,qoriq-pcie-v2.4", },
+	{ .compatible = "fsl,qoriq-pcie-v3.0", },
 
 	/*
 	 * The following entries are for compatibility with older device
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index c495c00..c81bf44 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -17,6 +17,7 @@
 #define PCIE_LTSSM	0x0404		/* PCIE Link Training and Status */
 #define PCIE_LTSSM_L0	0x16		/* L0 state */
 #define PCIE_IP_REV_2_2		0x02080202 /* PCIE IP block version Rev2.2 */
+#define PCIE_IP_REV_3_0		0x02080300 /* PCIE IP block version Rev3.0 */
 #define PIWAR_EN		0x80000000	/* Enable */
 #define PIWAR_PF		0x20000000	/* prefetch */
 #define PIWAR_TGI_LOCAL		0x00f00000	/* target - local memory */
@@ -89,6 +90,16 @@ struct ccsr_pci {
 	__be32	pex_err_cap_r1;		/* 0x.e2c - PCIE error capture register 0 */
 	__be32	pex_err_cap_r2;		/* 0x.e30 - PCIE error capture register 0 */
 	__be32	pex_err_cap_r3;		/* 0x.e34 - PCIE error capture register 0 */
+	u8	res_e38[200];
+	__be32	pdb_stat;		/* 0x.f00 - PCIE Debug Status */
+	u8	res_f04[16];
+	__be32	pex_csr0;		/* 0x.f14 - PEX Control/Status register 0*/
+#define PEX_CSR0_LTSSM_MASK	0xFC
+#define PEX_CSR0_LTSSM_SHIFT	2
+#define PEX_CSR0_LTSSM_L0	0x11
+	__be32	pex_csr1;		/* 0x.f18 - PEX Control/Status register 1*/
+	u8	res_f1c[228];
+
 };
 
 extern int fsl_add_bridge(struct platform_device *pdev, int is_primary);
-- 
1.7.9.7
