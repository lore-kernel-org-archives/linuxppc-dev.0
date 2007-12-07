Return-Path: <SRS0=99Ew=Q6=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 426F6DDE03
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 20:42:42 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/3] [POWERPC] 4xx: Add Kilauea PCIe support to dts and Kconfig
Date: Fri,  7 Dec 2007 10:34:26 +0100
Message-Id: <1197020066-22118-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stefan Roese <sr@denx.de>
---
 arch/powerpc/boot/dts/kilauea.dts  |   82 ++++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/40x/Kconfig |    1 +
 2 files changed, 83 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/kilauea.dts b/arch/powerpc/boot/dts/kilauea.dts
index 1ffb6e3..0a3fbfa 100644
--- a/arch/powerpc/boot/dts/kilauea.dts
+++ b/arch/powerpc/boot/dts/kilauea.dts
@@ -254,5 +254,87 @@
 				has-new-stacr-staopc;
 			};
 		};
+
+		PCIE0: pciex@0a0000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
+			primary;
+			port = <0>; /* port number */
+			reg = <a0000000 20000000	/* Config space access */
+			       ef000000 00001000>;	/* Registers */
+			dcr-reg = <040 020>;
+			sdr-base = <400>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <02000000 0 80000000 90000000 0 08000000
+				  01000000 0 00000000 e0000000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 80000000>;
+
+			/* This drives busses 0x00 to 0x0f */
+			bus-range = <00 0f>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map = <
+				0000 0 0 1 &UIC2 0 4 /* swizzled int A */
+				0000 0 0 2 &UIC2 1 4 /* swizzled int B */
+				0000 0 0 3 &UIC2 2 4 /* swizzled int C */
+				0000 0 0 4 &UIC2 3 4 /* swizzled int D */>;
+		};
+
+		PCIE1: pciex@0c0000000 {
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-405ex", "ibm,plb-pciex";
+			primary;
+			port = <1>; /* port number */
+			reg = <c0000000 20000000	/* Config space access */
+			       ef001000 00001000>;	/* Registers */
+			dcr-reg = <060 020>;
+			sdr-base = <440>;
+
+			/* Outbound ranges, one memory and one IO,
+			 * later cannot be changed
+			 */
+			ranges = <02000000 0 80000000 98000000 0 08000000
+				  01000000 0 00000000 e0010000 0 00010000>;
+
+			/* Inbound 2GB range starting at 0 */
+			dma-ranges = <42000000 0 0 0 0 80000000>;
+
+			/* This drives busses 0x10 to 0x1f */
+			bus-range = <10 1f>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0000 0 0 7>;
+			interrupt-map = <
+				0000 0 0 1 &UIC2 b 4 /* swizzled int A */
+				0000 0 0 2 &UIC2 c 4 /* swizzled int B */
+				0000 0 0 3 &UIC2 d 4 /* swizzled int C */
+				0000 0 0 4 &UIC2 e 4 /* swizzled int D */>;
+		};
 	};
 };
diff --git a/arch/powerpc/platforms/40x/Kconfig b/arch/powerpc/platforms/40x/Kconfig
index 5d2ca0d..0ac1b0b 100644
--- a/arch/powerpc/platforms/40x/Kconfig
+++ b/arch/powerpc/platforms/40x/Kconfig
@@ -27,6 +27,7 @@ config KILAUEA
 	depends on 40x
 	default n
 	select 405EX
+	select PPC4xx_PCI_EXPRESS
 	help
 	  This option enables support for the AMCC PPC405EX evaluation board.
 
-- 
1.5.3.7.949.g2221a6
