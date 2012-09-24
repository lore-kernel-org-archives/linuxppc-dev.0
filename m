Return-Path: <B31939@freescale.com>
Received: from db3outboundpool.messaging.microsoft.com
 (db3ehsobe004.messaging.microsoft.com [213.199.154.142])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BFB82C0082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Sep 2012 15:51:01 +1000 (EST)
From: Minghuan Lian <Minghuan.Lian@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH][v2] powerpc/fsl-pci: use 'Header Type' to identify PCIE mode
Date: Mon, 24 Sep 2012 13:50:52 +0800
Message-ID: <1348465852-6507-1-git-send-email-Minghuan.Lian@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original code uses 'Programming Interface' field to judge if PCIE is
EP or RC mode, however, some latest silicons do not support this functionality.
According to PCIE specification, 'Header Type' offset 0x0e is used to
indicate header type, so change code to use 'Header Type' field to
judge PCIE mode. Because FSL PCI controller does not support 'Header Type',
patch still uses 'Programming Interface' to identify PCI mode.

Signed-off-by: Minghuan Lian <Minghuan.Lian@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
---
Change log:
v2 - 
keep the original PCI initialization order according to kumar's recommendations.

 arch/powerpc/sysdev/fsl_pci.c |   37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index c37f461..468e76c 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -38,15 +38,15 @@ static int fsl_pcie_bus_fixup, is_mpc83xx_pci;
 
 static void __devinit quirk_fsl_pcie_header(struct pci_dev *dev)
 {
-	u8 progif;
+	u8 hdr_type;
 
 	/* if we aren't a PCIe don't bother */
 	if (!pci_find_capability(dev, PCI_CAP_ID_EXP))
 		return;
 
 	/* if we aren't in host mode don't bother */
-	pci_read_config_byte(dev, PCI_CLASS_PROG, &progif);
-	if (progif & 0x1)
+	pci_read_config_byte(dev, PCI_HEADER_TYPE, &hdr_type);
+	if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
 		return;
 
 	dev->class = PCI_CLASS_BRIDGE_PCI << 8;
@@ -425,7 +425,7 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	struct pci_controller *hose;
 	struct resource rsrc;
 	const int *bus_range;
-	u8 progif;
+	u8 hdr_type, progif;
 
 	if (!of_device_is_available(dev)) {
 		pr_warning("%s: disabled\n", dev->full_name);
@@ -457,15 +457,17 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	setup_indirect_pci(hose, rsrc.start, rsrc.start + 0x4,
 		PPC_INDIRECT_TYPE_BIG_ENDIAN);
 
-	early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
-	if ((progif & 1) == 1) {
-		/* unmap cfg_data & cfg_addr separately if not on same page */
-		if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
-		    ((unsigned long)hose->cfg_addr & PAGE_MASK))
-			iounmap(hose->cfg_data);
-		iounmap(hose->cfg_addr);
-		pcibios_free_controller(hose);
-		return -ENODEV;
+	if (early_find_capability(hose, 0, 0, PCI_CAP_ID_EXP)) {
+		/* For PCIE read HEADER_TYPE to identify controler mode */
+		early_read_config_byte(hose, 0, 0, PCI_HEADER_TYPE, &hdr_type);
+		if ((hdr_type & 0x7f) != PCI_HEADER_TYPE_BRIDGE)
+			goto no_bridge;
+
+	} else {
+		/* For PCI read PROG to identify controller mode */
+		early_read_config_byte(hose, 0, 0, PCI_CLASS_PROG, &progif);
+		if ((progif & 1) == 1)
+			goto no_bridge;
 	}
 
 	setup_pci_cmd(hose);
@@ -494,6 +496,15 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	setup_pci_atmu(hose, &rsrc);
 
 	return 0;
+
+no_bridge:
+	/* unmap cfg_data & cfg_addr separately if not on same page */
+	if (((unsigned long)hose->cfg_data & PAGE_MASK) !=
+	    ((unsigned long)hose->cfg_addr & PAGE_MASK))
+		iounmap(hose->cfg_data);
+	iounmap(hose->cfg_addr);
+	pcibios_free_controller(hose);
+	return -ENODEV;
 }
 #endif /* CONFIG_FSL_SOC_BOOKE || CONFIG_PPC_86xx */
 
-- 
1.7.9.5
