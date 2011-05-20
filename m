Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 07907B7324
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 16:09:39 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id p4K69ahx001089
	for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2011 01:09:36 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/14] powerpc/fsl_pci: Simplify matching logic for
	PCI_FIXUP_HEADER
Date: Fri, 20 May 2011 01:09:24 -0500
Message-Id: <1305871771-16334-7-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
References: <1305871771-16334-1-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-2-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-3-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-4-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-5-git-send-email-galak@kernel.crashing.org>
	<1305871771-16334-6-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We fixup every FSL PCIe Root Complex we need to fixup a few things.
Rather than adding every device under the sun we move to just matching
only on the vendor (PCI_VENDOR_ID_FREESCALE) and than check that we are
a PCIe controller in host mode in the fixup.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/sysdev/fsl_pci.c |   70 +++++-----------------------------------
 1 files changed, 9 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 68ca929..b4d6046d 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -38,10 +38,17 @@ static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
 
 static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
 {
+	u8 progif;
+
 	/* if we aren't a PCIe don't bother */
 	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
 		return;
 
+	/* if we aren't in host mode don't bother */
+	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
+	if (progif & 0x1)
+		return;
+
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
 	fsl_pcie_bus_fixup = 1;
 	return;
@@ -380,70 +387,11 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 
 	return 0;
 }
-
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8543E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8543, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8547E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8545E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8545, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8569E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8569, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8568E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8568, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8567E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8567, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8533E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8533, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8544E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8544, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8572E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8572, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8536E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8536, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8641D, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8610, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1011E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1011, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1013E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1013, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1020E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1020, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1021E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1021, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1022E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P1022, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2010E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2010, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2020, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2040E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P2040, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P3041E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P3041, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4040, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P4080, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5010E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5010, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5020E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_P5020, quirk_fsl_pcie_header);
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
-#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8308, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8314E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8314, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8315E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8315, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8377E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8377, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8378E, quirk_fsl_pcie_header);
-DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8378, quirk_fsl_pcie_header);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_FREESCALE, PCI_ANY_ID, quirk_fsl_pcie_header);
 
+#if defined(CONFIG_PPC_83xx) || defined(CONFIG_PPC_MPC512x)
 struct mpc83xx_pcie_priv {
 	void __iomem *cfg_type0;
 	void __iomem *cfg_type1;
-- 
1.7.3.4
