Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6433F1007D3
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 16:57:19 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o9E5vElm016109
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 00:57:14 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/fsl-pci: Fix MSI support on 83xx platforms
Date: Thu, 14 Oct 2010 00:57:13 -0500
Message-Id: <1287035833-6047-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following commit broke 83xx because it assumed the 83xx platforms
exposed the "IMMR" address in BAR0 like the 85xx/86xx/QoriQ devices do:

commit 3da34aae03d498ee62f75aa7467de93cce3030fd
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Tue May 12 15:51:56 2009 -0500

    powerpc/fsl: Support unique MSI addresses per PCIe Root Complex

However that is not true, so we have to search through the inbound
window settings on 83xx to find which one matches the IMMR address to
determine its PCI address.

Reported-by: Ilya Yanok <yanok@emcraft.com>
Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Its possible that we build 83xx and 86xx together and thus
  fsl_pci_immrbar_base needs to deal with that.  Introduce a simple global
  is_mpc83xx_pci that we change for such a case.

 arch/powerpc/sysdev/fsl_msi.c |    9 +++----
 arch/powerpc/sysdev/fsl_pci.c |   52 +++++++++++++++++++++++++++++++++++++++-
 arch/powerpc/sysdev/fsl_pci.h |    1 +
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 87991d3..20cdcd2 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -24,6 +24,7 @@
 #include <asm/ppc-pci.h>
 #include <asm/mpic.h>
 #include "fsl_msi.h"
+#include "fsl_pci.h"
 
 LIST_HEAD(msi_head);
 
@@ -125,13 +126,11 @@ static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 {
 	struct fsl_msi *msi_data = fsl_msi_data;
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
-	u32 base = 0;
+	u64 base = fsl_pci_immrbar_base(hose);
 
-	pci_bus_read_config_dword(hose->bus,
-		PCI_DEVFN(0, 0), PCI_BASE_ADDRESS_0, &base);
+	msg->address_lo = msi_data->msi_addr_lo + lower_32_bits(base);
+	msg->address_hi = msi_data->msi_addr_hi + upper_32_bits(base);
 
-	msg->address_lo = msi_data->msi_addr_lo + base;
-	msg->address_hi = msi_data->msi_addr_hi;
 	msg->data = hwirq;
 
 	pr_debug("%s: allocated srs: %d, ibs: %d\n",
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 4ae9332..505c8f0 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -1,7 +1,7 @@
 /*
  * MPC83xx/85xx/86xx PCI/PCIE support routing.
  *
- * Copyright 2007-2009 Freescale Semiconductor, Inc.
+ * Copyright 2007-2010 Freescale Semiconductor, Inc.
  * Copyright 2008-2009 MontaVista Software, Inc.
  *
  * Initial author: Xianghua Xiao <x.xiao@freescale.com>
@@ -34,7 +34,7 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
-static int fsl_pcie_bus_fixup;
+static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
 
 static void __init quirk_fsl_pcie_header(struct pci_dev *dev)
 {
@@ -430,6 +430,13 @@ struct mpc83xx_pcie_priv {
 	u32 dev_base;
 };
 
+struct pex_inbound_window {
+	u32 ar;
+	u32 tar;
+	u32 barl;
+	u32 barh;
+};
+
 /*
  * With the convention of u-boot, the PCIE outbound window 0 serves
  * as configuration transactions outbound.
@@ -437,6 +444,8 @@ struct mpc83xx_pcie_priv {
 #define PEX_OUTWIN0_BAR		0xCA4
 #define PEX_OUTWIN0_TAL		0xCA8
 #define PEX_OUTWIN0_TAH		0xCAC
+#define PEX_RC_INWIN_BASE	0xE60
+#define PEX_RCIWARn_EN		0x1
 
 static int mpc83xx_pcie_exclude_device(struct pci_bus *bus, unsigned int devfn)
 {
@@ -604,6 +613,8 @@ int __init mpc83xx_add_bridge(struct device_node *dev)
 	const int *bus_range;
 	int primary;
 
+	is_mpc83xx_pci = 1;
+
 	if (!of_device_is_available(dev)) {
 		pr_warning("%s: disabled by the firmware.\n",
 			   dev->full_name);
@@ -683,3 +694,40 @@ err0:
 	return ret;
 }
 #endif /* CONFIG_PPC_83xx */
+
+u64 fsl_pci_immrbar_base(struct pci_controller *hose)
+{
+#ifdef CONFIG_PPC_83xx
+	if (is_mpc83xx_pci) {
+		struct mpc83xx_pcie_priv *pcie = hose->dn->data;
+		struct pex_inbound_window *in;
+		int i;
+
+		/* Walk the Root Complex Inbound windows to match IMMR base */
+		in = pcie->cfg_type0 + PEX_RC_INWIN_BASE;
+		for (i = 0; i < 4; i++) {
+			/* not enabled, skip */
+			if (!in_le32(&in[i].ar) & PEX_RCIWARn_EN)
+				 continue;
+
+			if (get_immrbase() == in_le32(&in[i].tar))
+				return (u64)in_le32(&in[i].barh) << 32 |
+					    in_le32(&in[i].barl);
+		}
+
+		printk(KERN_WARNING "could not find PCI BAR matching IMMR\n");
+	}
+#endif
+
+#if defined(CONFIG_FSL_SOC_BOOKE) || defined(CONFIG_PPC_86xx)
+	if (!is_mpc83xx_pci) {
+		u32 base;
+
+		pci_bus_read_config_dword(hose->bus,
+			PCI_DEVFN(0, 0), PCI_BASE_ADDRESS_0, &base);
+		return base;
+	}
+#endif
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a9d8bbe..8ad72a1 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -88,6 +88,7 @@ struct ccsr_pci {
 extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
+u64 fsl_pci_immrbar_base(struct pci_controller *hose);
 
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
-- 
1.7.2.3
