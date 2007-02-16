Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 05F9ADDDF4
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 13:46:37 +1100 (EST)
Date: Thu, 15 Feb 2007 20:46:03 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	jdl@jdl.com
Subject: [RFC 5/7] Unite all PCI-e on 85xx and 86xx under one codebase
Message-ID: <Pine.LNX.4.61.0702152045190.9034@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add PCI express link register status check.

When scanning empty PCI express slot, the kernel will block.
Fix this block issue on 8548 board.

Cleaned up some minor whitespace issues in fsl_pcie.c and
mpc8548cds.dts

Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/boot/dts/mpc8548cds.dts |   14 +++++++-------
 arch/powerpc/sysdev/fsl_pcie.c       |   22 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index 3bb83a3..d59a28a 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -187,19 +187,19 @@
 				02800 0 0 2 40000 32 1
 				02800 0 0 3 40000 33 1
 				02800 0 0 4 40000 30 1
-				
+
 				/* IDSEL 0x6 (PCIX Slot 4) */
 				03000 0 0 1 40000 32 1
 				03000 0 0 2 40000 33 1
 				03000 0 0 3 40000 30 1
 				03000 0 0 4 40000 31 1
-				
+
 				/* IDSEL 0x8 (PCIX Slot 5) */
 				04000 0 0 1 40000 30 1
 				04000 0 0 2 40000 31 1
 				04000 0 0 3 40000 32 1
 				04000 0 0 4 40000 33 1
-				
+
 				/* IDSEL 0xC (Tsi310 bridge) */
 				06000 0 0 1 40000 30 1
 				06000 0 0 2 40000 31 1
@@ -223,19 +223,19 @@
 				0b000 0 0 2 40000 33 1
 				0b000 0 0 3 40000 30 1
 				0b000 0 0 4 40000 31 1
-				
+
 				/* IDSEL 0x18 (Slot 5) */
 				0c000 0 0 1 40000 30 1
 				0c000 0 0 2 40000 31 1
 				0c000 0 0 3 40000 32 1
 				0c000 0 0 4 40000 33 1
-				
+
 				/* bus 1 , idsel 0x2 Tsi310 bridge secondary */
 				11000 0 0 1 40000 32 1
 				11000 0 0 2 40000 33 1
 				11000 0 0 3 40000 30 1
 				11000 0 0 4 40000 31 1
-				
+
 				/* IDSEL 0x1C (Tsi310 bridge PCI primary) */
 				0E000 0 0 1 40000 30 1
 				0E000 0 0 2 40000 31 1
@@ -247,7 +247,7 @@
 				12000 0 0 2 19000 31 1
 				12000 0 0 3 19000 32 1
 				12000 0 0 4 19000 33 1>;
-				
+
 			interrupt-parent = <40000>;
 			interrupts = <08 2>;
 			bus-range = <0 0>;
diff --git a/arch/powerpc/sysdev/fsl_pcie.c b/arch/powerpc/sysdev/fsl_pcie.c
index 041c07e..469ded9 100644
--- a/arch/powerpc/sysdev/fsl_pcie.c
+++ b/arch/powerpc/sysdev/fsl_pcie.c
@@ -37,6 +37,7 @@ indirect_read_config_pcie(struct pci_bus
 	struct pci_controller *hose = bus->sysdata;
 	volatile void __iomem *cfg_data;
 	u32 temp;
+	u32 link_training_stat;
 
 	if (ppc_md.pci_exclude_device)
 		if (ppc_md.pci_exclude_device(bus->number, devfn))
@@ -46,8 +47,14 @@ indirect_read_config_pcie(struct pci_bus
 	if (devfn != 0x0 && bus->number == 0xff)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	PCI_CFG_OUT(hose->cfg_addr, 0x80000000 | 0x4 << 24
+		| (0 << 16) | (0x4 & 0xfc));
+	link_training_stat = in_le32(hose->cfg_data);
+	if ((link_training_stat & 0x5f) < 0x16)  /* Training failure */
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	PCIE_FIX;
-	if (bus->number == 0xff) {
+	if (bus->number == 0xff || bus->number == hose->bus_offset) {
 		PCI_CFG_OUT(hose->cfg_addr,
 			    (0x80000000 | ((offset & 0xf00) << 16) |
 			     ((bus->number - hose->bus_offset) << 16)
@@ -55,7 +62,7 @@ indirect_read_config_pcie(struct pci_bus
 	} else {
 		PCI_CFG_OUT(hose->cfg_addr,
 			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
+			     (bus->number << 16)
 			     | (devfn << 8) | ((offset & 0xfc) )));
 	}
 
@@ -88,6 +95,7 @@ indirect_write_config_pcie(struct pci_bu
 	struct pci_controller *hose = bus->sysdata;
 	volatile void __iomem *cfg_data;
 	u32 temp;
+	u32 link_training_stat;
 
 	if (ppc_md.pci_exclude_device)
 		if (ppc_md.pci_exclude_device(bus->number, devfn))
@@ -97,8 +105,14 @@ indirect_write_config_pcie(struct pci_bu
 	if (devfn != 0x0 && bus->number == 0xff)
 		return PCIBIOS_DEVICE_NOT_FOUND;
 
+	PCI_CFG_OUT(hose->cfg_addr, 0x80000000 | 0x4 << 24
+		| (0 << 16) | (0x4 & 0xfc));
+	link_training_stat = in_le32(hose->cfg_data);
+	if ((link_training_stat & 0x5f) < 0x16)  /* Training failure */
+		return PCIBIOS_DEVICE_NOT_FOUND;
+
 	PCIE_FIX;
-	if (bus->number == 0xff) {
+	if (bus->number == 0xff || bus->number == hose->bus_offset) {
 		PCI_CFG_OUT(hose->cfg_addr,
 			    (0x80000000 | ((offset & 0xf00) << 16) |
 			     ((bus->number - hose->bus_offset) << 16)
@@ -106,7 +120,7 @@ indirect_write_config_pcie(struct pci_bu
 	} else {
 		PCI_CFG_OUT(hose->cfg_addr,
 			    (0x80000001 | ((offset & 0xf00) << 16) |
-			     ((bus->number - hose->bus_offset) << 16)
+			     (bus->number << 16)
 			     | (devfn << 8) | ((offset & 0xfc) )));
         }
 
-- 
1.4.4
