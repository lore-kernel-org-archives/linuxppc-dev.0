Return-Path: <wg@grandegger.com>
Message-ID: <4847ADBD.4050508@grandegger.com>
Date: Thu, 05 Jun 2008 11:11:25 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH v2 3/4] [POWERPC] 85xx: add local bus nodes for Flash and
	CAN to tqm8560.dts
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add local bus nodes for Flash and CAN to tqm8560.dts

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/boot/dts/tqm8560.dts |   65 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

Index: linux-2.6-galak/arch/powerpc/boot/dts/tqm8560.dts
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/boot/dts/tqm8560.dts
+++ linux-2.6-galak/arch/powerpc/boot/dts/tqm8560.dts
@@ -2,6 +2,7 @@
  * TQM 8560 Device Tree Source
  *
  * Copyright 2008 Freescale Semiconductor Inc.
+ * Copyright 2008 Wolfgang Grandegger <wg@grandegger.com>
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -223,6 +224,70 @@
 		};
 	};
 
+	localbus@e0005000 {
+		compatible = "fsl,mpc8560-localbus", "fsl,pq3-localbus",
+			     "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xe0005000 0x100>;	// BRx, ORx, etc.
+
+		ranges = <
+			0 0x0 0xfc000000 0x04000000	// NOR FLASH bank 1
+			1 0x0 0xf8000000 0x08000000	// NOR FLASH bank 0
+			2 0x0 0xe3000000 0x00008000	// CAN (2 x i82527)
+		>;
+
+		flash@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <1 0x0 0x8000000>;
+			bank-width = <4>;
+			device-width = <1>;
+
+			partition@0 {
+				label = "kernel";
+				reg = <0x00000000 0x00200000>;
+			};
+			partition@200000 {
+				label = "root";
+				reg = <0x00200000 0x00300000>;
+			};
+			partition@500000 {
+				label = "user";
+				reg = <0x00500000 0x07a00000>;
+			};
+			partition@7f00000 {
+				label = "env1";
+				reg = <0x07f00000 0x00040000>;
+			};
+			partition@7f40000 {
+				label = "env2";
+				reg = <0x07f40000 0x00040000>;
+			};
+			partition@7f80000 {
+				label = "u-boot";
+				reg = <0x07f80000 0x00080000>;
+				read-only;
+			};
+		};
+
+		/* Note: CAN support needs be enabled in U-Boot */
+		can0@2,0 {
+			compatible = "intel,82527"; // Bosch CC770
+			reg = <2 0x0 0x100>;
+			interrupts = <4 0>;
+			interrupt-parent = <&mpic>;
+		};
+
+		can1@2,100 {
+			compatible = "intel,82527"; // Bosch CC770
+			reg = <2 0x100 0x100>;
+			interrupts = <4 0>;
+			interrupt-parent = <&mpic>;
+		};
+	};
+
 	pci0: pci@e0008000 {
 		cell-index = <0>;
 		#interrupt-cells = <1>;
