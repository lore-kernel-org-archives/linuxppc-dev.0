Return-Path: <B35336@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 50CF6B6FC5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 20:05:08 +1100 (EST)
Received: from mail73-tx2 (localhost [127.0.0.1])	by mail73-tx2-R.bigfish.com
 (Postfix) with ESMTP id D0103480390	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2012 09:05:03 +0000 (UTC)
Received: from TX2EHSMHS037.bigfish.com (unknown [10.9.14.249])	by
 mail73-tx2.bigfish.com (Postfix) with ESMTP id D8A7F20046	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 09:05:00 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 8/9] powerpc/mpc8548cds: rename mpc8548cds.dts to
 mpc8548cds_32b.dts and create mpc8548cds.dtsi
Date: Tue, 6 Mar 2012 17:06:44 +0800
Message-ID: <1331024805-15926-7-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
References: <1331024805-15926-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 * Create mpc8548cds.dtsi.
 * Move lbc, soc and pci0 nodes to mpc8548cds_32b.dtsi.
 * Change cuImage.mpc8548cds to cuImage.mpc8548cds_32b.
 * Rename mpc8548cds.dts to mpc8548cds_32b.dts.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/Makefile               |    2 +-
 arch/powerpc/boot/dts/mpc8548cds.dts     |  357 ------------------------------
 arch/powerpc/boot/dts/mpc8548cds.dtsi    |  306 +++++++++++++++++++++++++
 arch/powerpc/boot/dts/mpc8548cds_32b.dts |   86 +++++++
 4 files changed, 393 insertions(+), 358 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/mpc8548cds.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8548cds.dtsi
 create mode 100644 arch/powerpc/boot/dts/mpc8548cds_32b.dts

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8844a17..f6622e0 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -247,7 +247,7 @@ image-$(CONFIG_ASP834x)			+= dtbImage.asp834x-redboot
 image-$(CONFIG_MPC8540_ADS)		+= cuImage.mpc8540ads
 image-$(CONFIG_MPC8560_ADS)		+= cuImage.mpc8560ads
 image-$(CONFIG_MPC85xx_CDS)		+= cuImage.mpc8541cds \
-					   cuImage.mpc8548cds \
+					   cuImage.mpc8548cds_32b \
 					   cuImage.mpc8555cds
 image-$(CONFIG_MPC85xx_MDS)		+= cuImage.mpc8568mds
 image-$(CONFIG_MPC85xx_DS)		+= cuImage.mpc8544ds \
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
deleted file mode 100644
index 0683983..0000000
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ /dev/null
@@ -1,357 +0,0 @@
-/*
- * MPC8548 CDS Device Tree Source
- *
- * Copyright 2006, 2008, 2011 Freescale Semiconductor Inc.
- *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
- * option) any later version.
- */
-
-/include/ "fsl/mpc8548si-pre.dtsi"
-
-/ {
-	model = "MPC8548CDS";
-	compatible = "MPC8548CDS", "MPC85xxCDS";
-
-	aliases {
-		ethernet0 = &enet0;
-		ethernet1 = &enet1;
-		ethernet2 = &enet2;
-		ethernet3 = &enet3;
-		serial0 = &serial0;
-		serial1 = &serial1;
-		pci0 = &pci0;
-		pci1 = &pci1;
-		pci2 = &pci2;
-	};
-
-	memory {
-		device_type = "memory";
-		reg = <0 0 0x0 0x8000000>;	// 128M at 0x0
-	};
-
-	lbc: localbus@e0005000 {
-		reg = <0 0xe0005000 0 0x1000>;
-
-		ranges = <0x0 0x0 0x0 0xff000000 0x01000000
-			  0x1 0x0 0x0 0xf8004000 0x00001000>;
-
-		nor@0,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "cfi-flash";
-			reg = <0x0 0x0 0x01000000>;
-			bank-width = <2>;
-			device-width = <2>;
-
-			partition@0 {
-				reg = <0x0 0x0b00000>;
-				label = "ramdisk-nor";
-			};
-
-			partition@300000 {
-				reg = <0x0b00000 0x0400000>;
-				label = "kernel-nor";
-			};
-
-			partition@700000 {
-				reg = <0x0f00000 0x060000>;
-				label = "dtb-nor";
-			};
-
-			partition@760000 {
-				reg = <0x0f60000 0x020000>;
-				label = "env-nor";
-				read-only;
-			};
-
-			partition@780000 {
-				reg = <0x0f80000 0x080000>;
-				label = "u-boot-nor";
-				read-only;
-			};
-		};
-
-		board-control@1,0 {
-			compatible = "fsl,mpc8548cds-fpga";
-			reg = <0x1 0x0 0x1000>;
-		};
-	};
-
-	soc: soc8548@e0000000 {
-		ranges = <0 0x0 0xe0000000 0x100000>;
-
-		i2c@3000 {
-			eeprom@50 {
-				compatible = "atmel,24c64";
-				reg = <0x50>;
-			};
-
-			eeprom@56 {
-				compatible = "atmel,24c64";
-				reg = <0x56>;
-			};
-
-			eeprom@57 {
-				compatible = "atmel,24c64";
-				reg = <0x57>;
-			};
-		};
-
-		i2c@3100 {
-			eeprom@50 {
-				compatible = "atmel,24c64";
-				reg = <0x50>;
-			};
-		};
-
-		enet0: ethernet@24000 {
-			tbi-handle = <&tbi0>;
-			phy-handle = <&phy0>;
-		};
-
-		mdio@24520 {
-			phy0: ethernet-phy@0 {
-				interrupts = <5 1 0 0>;
-				reg = <0x0>;
-				device_type = "ethernet-phy";
-			};
-			phy1: ethernet-phy@1 {
-				interrupts = <5 1 0 0>;
-				reg = <0x1>;
-				device_type = "ethernet-phy";
-			};
-			phy2: ethernet-phy@2 {
-				interrupts = <5 1 0 0>;
-				reg = <0x2>;
-				device_type = "ethernet-phy";
-			};
-			phy3: ethernet-phy@3 {
-				interrupts = <5 1 0 0>;
-				reg = <0x3>;
-				device_type = "ethernet-phy";
-			};
-			tbi0: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		enet1: ethernet@25000 {
-			tbi-handle = <&tbi1>;
-			phy-handle = <&phy1>;
-		};
-
-		mdio@25520 {
-			tbi1: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		enet2: ethernet@26000 {
-			tbi-handle = <&tbi2>;
-			phy-handle = <&phy2>;
-		};
-
-		mdio@26520 {
-			tbi2: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-
-		enet3: ethernet@27000 {
-			tbi-handle = <&tbi3>;
-			phy-handle = <&phy3>;
-		};
-
-		mdio@27520 {
-			tbi3: tbi-phy@11 {
-				reg = <0x11>;
-				device_type = "tbi-phy";
-			};
-		};
-	};
-
-	pci0: pci@e0008000 {
-		reg = <0 0xe0008000 0 0x1000>;
-		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x10000000
-			  0x1000000 0x0 0x00000000 0 0xe2000000 0x0 0x800000>;
-		clock-frequency = <66666666>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-			/* IDSEL 0x4 (PCIX Slot 2) */
-			0x2000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
-			0x2000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
-			0x2000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
-			0x2000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
-
-			/* IDSEL 0x5 (PCIX Slot 3) */
-			0x2800 0x0 0x0 0x1 &mpic 0x1 0x1 0 0
-			0x2800 0x0 0x0 0x2 &mpic 0x2 0x1 0 0
-			0x2800 0x0 0x0 0x3 &mpic 0x3 0x1 0 0
-			0x2800 0x0 0x0 0x4 &mpic 0x0 0x1 0 0
-
-			/* IDSEL 0x6 (PCIX Slot 4) */
-			0x3000 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
-			0x3000 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
-			0x3000 0x0 0x0 0x3 &mpic 0x0 0x1 0 0
-			0x3000 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
-
-			/* IDSEL 0x8 (PCIX Slot 5) */
-			0x4000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
-			0x4000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
-			0x4000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
-			0x4000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
-
-			/* IDSEL 0xC (Tsi310 bridge) */
-			0x6000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
-			0x6000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
-			0x6000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
-			0x6000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
-
-			/* IDSEL 0x14 (Slot 2) */
-			0xa000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
-			0xa000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
-			0xa000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
-			0xa000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
-
-			/* IDSEL 0x15 (Slot 3) */
-			0xa800 0x0 0x0 0x1 &mpic 0x1 0x1 0 0
-			0xa800 0x0 0x0 0x2 &mpic 0x2 0x1 0 0
-			0xa800 0x0 0x0 0x3 &mpic 0x3 0x1 0 0
-			0xa800 0x0 0x0 0x4 &mpic 0x0 0x1 0 0
-
-			/* IDSEL 0x16 (Slot 4) */
-			0xb000 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
-			0xb000 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
-			0xb000 0x0 0x0 0x3 &mpic 0x0 0x1 0 0
-			0xb000 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
-
-			/* IDSEL 0x18 (Slot 5) */
-			0xc000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
-			0xc000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
-			0xc000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
-			0xc000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
-
-			/* IDSEL 0x1C (Tsi310 bridge PCI primary) */
-			0xe000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
-			0xe000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
-			0xe000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
-			0xe000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0>;
-
-		pci_bridge@1c {
-			interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-			interrupt-map = <
-
-				/* IDSEL 0x00 (PrPMC Site) */
-				0000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
-				0000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
-				0000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
-				0000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
-
-				/* IDSEL 0x04 (VIA chip) */
-				0x2000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
-				0x2000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
-				0x2000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
-				0x2000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
-
-				/* IDSEL 0x05 (8139) */
-				0x2800 0x0 0x0 0x1 &mpic 0x1 0x1 0 0
-
-				/* IDSEL 0x06 (Slot 6) */
-				0x3000 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
-				0x3000 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
-				0x3000 0x0 0x0 0x3 &mpic 0x0 0x1 0 0
-				0x3000 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
-
-				/* IDESL 0x07 (Slot 7) */
-				0x3800 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
-				0x3800 0x0 0x0 0x2 &mpic 0x0 0x1 0 0
-				0x3800 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
-				0x3800 0x0 0x0 0x4 &mpic 0x2 0x1 0 0>;
-
-			reg = <0xe000 0x0 0x0 0x0 0x0>;
-			#interrupt-cells = <1>;
-			#size-cells = <2>;
-			#address-cells = <3>;
-			ranges = <0x2000000 0x0 0x80000000
-				  0x2000000 0x0 0x80000000
-				  0x0 0x20000000
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x80000>;
-			clock-frequency = <33333333>;
-
-			isa@4 {
-				device_type = "isa";
-				#interrupt-cells = <2>;
-				#size-cells = <1>;
-				#address-cells = <2>;
-				reg = <0x2000 0x0 0x0 0x0 0x0>;
-				ranges = <0x1 0x0 0x1000000 0x0 0x0 0x1000>;
-				interrupt-parent = <&i8259>;
-
-				i8259: interrupt-controller@20 {
-					interrupt-controller;
-					device_type = "interrupt-controller";
-					reg = <0x1 0x20 0x2
-					       0x1 0xa0 0x2
-					       0x1 0x4d0 0x2>;
-					#address-cells = <0>;
-					#interrupt-cells = <2>;
-					compatible = "chrp,iic";
-					interrupts = <0 1 0 0>;
-					interrupt-parent = <&mpic>;
-				};
-
-				rtc@70 {
-					compatible = "pnpPNP,b00";
-					reg = <0x1 0x70 0x2>;
-				};
-			};
-		};
-	};
-
-	pci1: pci@e0009000 {
-		reg = <0 0xe0009000 0 0x1000>;
-		ranges = <0x2000000 0x0 0x90000000 0 0x90000000 0x0 0x10000000
-			  0x1000000 0x0 0x00000000 0 0xe2800000 0x0 0x800000>;
-		clock-frequency = <66666666>;
-		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
-		interrupt-map = <
-
-			/* IDSEL 0x15 */
-			0xa800 0x0 0x0 0x1 &mpic 0xb 0x1 0 0
-			0xa800 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
-			0xa800 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
-			0xa800 0x0 0x0 0x4 &mpic 0x3 0x1 0 0>;
-	};
-
-	pci2: pcie@e000a000 {
-		reg = <0 0xe000a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0 0xe3000000 0x0 0x100000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xa0000000
-				  0x2000000 0x0 0xa0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-
-	rio: rapidio@e00c0000 {
-		reg = <0x0 0xe00c0000 0x0 0x20000>;
-		port1 {
-			ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x20000000>;
-		};
-	};
-};
-
-/include/ "fsl/mpc8548si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dtsi b/arch/powerpc/boot/dts/mpc8548cds.dtsi
new file mode 100644
index 0000000..c61f525
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8548cds.dtsi
@@ -0,0 +1,306 @@
+/*
+ * MPC8548CDS Device Tree Source stub (no addresses or top-level ranges)
+ *
+ * Copyright 2012 Freescale Semiconductor Inc.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of Freescale Semiconductor nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor ``AS IS'' AND ANY
+ * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
+ * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
+ * DISCLAIMED. IN NO EVENT SHALL Freescale Semiconductor BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+&board_lbc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x01000000>;
+		bank-width = <2>;
+		device-width = <2>;
+
+		partition@0 {
+			reg = <0x0 0x0b00000>;
+			label = "ramdisk-nor";
+		};
+
+		partition@300000 {
+			reg = <0x0b00000 0x0400000>;
+			label = "kernel-nor";
+		};
+
+		partition@700000 {
+			reg = <0x0f00000 0x060000>;
+			label = "dtb-nor";
+		};
+
+		partition@760000 {
+			reg = <0x0f60000 0x020000>;
+			label = "env-nor";
+			read-only;
+		};
+
+		partition@780000 {
+			reg = <0x0f80000 0x080000>;
+			label = "u-boot-nor";
+			read-only;
+		};
+	};
+
+	board-control@1,0 {
+		compatible = "fsl,mpc8548cds-fpga";
+		reg = <0x1 0x0 0x1000>;
+	};
+};
+
+&board_soc {
+	i2c@3000 {
+		eeprom@50 {
+			compatible = "atmel,24c64";
+			reg = <0x50>;
+		};
+
+		eeprom@56 {
+			compatible = "atmel,24c64";
+			reg = <0x56>;
+		};
+
+		eeprom@57 {
+			compatible = "atmel,24c64";
+			reg = <0x57>;
+		};
+	};
+
+	i2c@3100 {
+		eeprom@50 {
+			compatible = "atmel,24c64";
+			reg = <0x50>;
+		};
+	};
+
+	enet0: ethernet@24000 {
+		tbi-handle = <&tbi0>;
+		phy-handle = <&phy0>;
+	};
+
+	mdio@24520 {
+		phy0: ethernet-phy@0 {
+			interrupts = <5 1 0 0>;
+			reg = <0x0>;
+			device_type = "ethernet-phy";
+		};
+		phy1: ethernet-phy@1 {
+			interrupts = <5 1 0 0>;
+			reg = <0x1>;
+			device_type = "ethernet-phy";
+		};
+		phy2: ethernet-phy@2 {
+			interrupts = <5 1 0 0>;
+			reg = <0x2>;
+			device_type = "ethernet-phy";
+		};
+		phy3: ethernet-phy@3 {
+			interrupts = <5 1 0 0>;
+			reg = <0x3>;
+			device_type = "ethernet-phy";
+		};
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet1: ethernet@25000 {
+		tbi-handle = <&tbi1>;
+		phy-handle = <&phy1>;
+	};
+
+	mdio@25520 {
+		tbi1: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet2: ethernet@26000 {
+		tbi-handle = <&tbi2>;
+		phy-handle = <&phy2>;
+	};
+
+	mdio@26520 {
+		tbi2: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet3: ethernet@27000 {
+		tbi-handle = <&tbi3>;
+		phy-handle = <&phy3>;
+	};
+
+	mdio@27520 {
+		tbi3: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+};
+
+&board_pci0 {
+	interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+	interrupt-map = <
+		/* IDSEL 0x4 (PCIX Slot 2) */
+		0x2000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+		0x2000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+		0x2000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+		0x2000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
+
+		/* IDSEL 0x5 (PCIX Slot 3) */
+		0x2800 0x0 0x0 0x1 &mpic 0x1 0x1 0 0
+		0x2800 0x0 0x0 0x2 &mpic 0x2 0x1 0 0
+		0x2800 0x0 0x0 0x3 &mpic 0x3 0x1 0 0
+		0x2800 0x0 0x0 0x4 &mpic 0x0 0x1 0 0
+
+		/* IDSEL 0x6 (PCIX Slot 4) */
+		0x3000 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+		0x3000 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+		0x3000 0x0 0x0 0x3 &mpic 0x0 0x1 0 0
+		0x3000 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+		/* IDSEL 0x8 (PCIX Slot 5) */
+		0x4000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+		0x4000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+		0x4000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+		0x4000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
+
+		/* IDSEL 0xC (Tsi310 bridge) */
+		0x6000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+		0x6000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+		0x6000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+		0x6000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
+
+		/* IDSEL 0x14 (Slot 2) */
+		0xa000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+		0xa000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+		0xa000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+		0xa000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
+
+		/* IDSEL 0x15 (Slot 3) */
+		0xa800 0x0 0x0 0x1 &mpic 0x1 0x1 0 0
+		0xa800 0x0 0x0 0x2 &mpic 0x2 0x1 0 0
+		0xa800 0x0 0x0 0x3 &mpic 0x3 0x1 0 0
+		0xa800 0x0 0x0 0x4 &mpic 0x0 0x1 0 0
+
+		/* IDSEL 0x16 (Slot 4) */
+		0xb000 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+		0xb000 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+		0xb000 0x0 0x0 0x3 &mpic 0x0 0x1 0 0
+		0xb000 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+		/* IDSEL 0x18 (Slot 5) */
+		0xc000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+		0xc000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+		0xc000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+		0xc000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
+
+		/* IDSEL 0x1C (Tsi310 bridge PCI primary) */
+		0xe000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+		0xe000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+		0xe000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+		0xe000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0>;
+
+	pci_bridge@1c {
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+
+			/* IDSEL 0x00 (PrPMC Site) */
+			0000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+			0000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
+
+			/* IDSEL 0x04 (VIA chip) */
+			0x2000 0x0 0x0 0x1 &mpic 0x0 0x1 0 0
+			0x2000 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0x2000 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0x2000 0x0 0x0 0x4 &mpic 0x3 0x1 0 0
+
+			/* IDSEL 0x05 (8139) */
+			0x2800 0x0 0x0 0x1 &mpic 0x1 0x1 0 0
+
+			/* IDSEL 0x06 (Slot 6) */
+			0x3000 0x0 0x0 0x1 &mpic 0x2 0x1 0 0
+			0x3000 0x0 0x0 0x2 &mpic 0x3 0x1 0 0
+			0x3000 0x0 0x0 0x3 &mpic 0x0 0x1 0 0
+			0x3000 0x0 0x0 0x4 &mpic 0x1 0x1 0 0
+
+			/* IDESL 0x07 (Slot 7) */
+			0x3800 0x0 0x0 0x1 &mpic 0x3 0x1 0 0
+			0x3800 0x0 0x0 0x2 &mpic 0x0 0x1 0 0
+			0x3800 0x0 0x0 0x3 &mpic 0x1 0x1 0 0
+			0x3800 0x0 0x0 0x4 &mpic 0x2 0x1 0 0>;
+
+		reg = <0xe000 0x0 0x0 0x0 0x0>;
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		ranges = <0x2000000 0x0 0x80000000
+			  0x2000000 0x0 0x80000000
+			  0x0 0x20000000
+			  0x1000000 0x0 0x0
+			  0x1000000 0x0 0x0
+			  0x0 0x80000>;
+		clock-frequency = <33333333>;
+
+		isa@4 {
+			device_type = "isa";
+			#interrupt-cells = <2>;
+			#size-cells = <1>;
+			#address-cells = <2>;
+			reg = <0x2000 0x0 0x0 0x0 0x0>;
+			ranges = <0x1 0x0 0x1000000 0x0 0x0 0x1000>;
+			interrupt-parent = <&i8259>;
+
+			i8259: interrupt-controller@20 {
+				interrupt-controller;
+				device_type = "interrupt-controller";
+				reg = <0x1 0x20 0x2
+				       0x1 0xa0 0x2
+				       0x1 0x4d0 0x2>;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				compatible = "chrp,iic";
+				interrupts = <0 1 0 0>;
+				interrupt-parent = <&mpic>;
+			};
+
+			rtc@70 {
+				compatible = "pnpPNP,b00";
+				reg = <0x1 0x70 0x2>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/boot/dts/mpc8548cds_32b.dts b/arch/powerpc/boot/dts/mpc8548cds_32b.dts
new file mode 100644
index 0000000..6fd6316
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8548cds_32b.dts
@@ -0,0 +1,86 @@
+/*
+ * MPC8548 CDS Device Tree Source (32-bit address map)
+ *
+ * Copyright 2006, 2008, 2011-2012 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/include/ "fsl/mpc8548si-pre.dtsi"
+
+/ {
+	model = "MPC8548CDS";
+	compatible = "MPC8548CDS", "MPC85xxCDS";
+
+	memory {
+		device_type = "memory";
+		reg = <0 0 0x0 0x8000000>;	// 128M at 0x0
+	};
+
+	board_lbc: lbc: localbus@e0005000 {
+		reg = <0 0xe0005000 0 0x1000>;
+
+		ranges = <0x0 0x0 0x0 0xff000000 0x01000000
+			  0x1 0x0 0x0 0xf8004000 0x00001000>;
+
+	};
+
+	board_soc: soc: soc8548@e0000000 {
+		ranges = <0 0x0 0xe0000000 0x100000>;
+	};
+
+	board_pci0: pci0: pci@e0008000 {
+		reg = <0 0xe0008000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0 0xe2000000 0x0 0x800000>;
+		clock-frequency = <66666666>;
+	};
+
+	pci1: pci@e0009000 {
+		reg = <0 0xe0009000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x90000000 0 0x90000000 0x0 0x10000000
+			  0x1000000 0x0 0x00000000 0 0xe2800000 0x0 0x800000>;
+		clock-frequency = <66666666>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+
+			/* IDSEL 0x15 */
+			0xa800 0x0 0x0 0x1 &mpic 0xb 0x1 0 0
+			0xa800 0x0 0x0 0x2 &mpic 0x1 0x1 0 0
+			0xa800 0x0 0x0 0x3 &mpic 0x2 0x1 0 0
+			0xa800 0x0 0x0 0x4 &mpic 0x3 0x1 0 0>;
+	};
+
+	pci2: pcie@e000a000 {
+		reg = <0 0xe000a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xe3000000 0x0 0x100000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xa0000000
+				  0x2000000 0x0 0xa0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	rio: rapidio@e00c0000 {
+		reg = <0x0 0xe00c0000 0x0 0x20000>;
+		port1 {
+			ranges = <0x0 0x0 0x0 0xc0000000 0x0 0x20000000>;
+		};
+	};
+};
+
+/*
+ * mpc8548cds.dtsi must be last to ensure board_pci0 overrides pci0 settings
+ * for interrupt-map & interrupt-map-mask.
+ */
+
+/include/ "fsl/mpc8548si-post.dtsi"
+/include/ "mpc8548cds.dtsi"
-- 
1.6.4.1
