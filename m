Return-Path: <B04825@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
 [213.199.154.143])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B6698B6F18
 for <linuxppc-dev@ozlabs.org>; Sat,  3 Dec 2011 09:10:35 +1100 (EST)
Received: from mail11-db3 (localhost [127.0.0.1])	by mail11-db3-R.bigfish.com
 (Postfix) with ESMTP id 4805A36059C	for <linuxppc-dev@ozlabs.org>;
 Fri,  2 Dec 2011 22:10:31 +0000 (UTC)
Received: from DB3EHSMHS005.bigfish.com (unknown [10.3.81.246])	by
 mail11-db3.bigfish.com (Postfix) with ESMTP id 625324000DF	for
 <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 22:09:00 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/2] powerpc/85xx: add a 32-bit P1022DS device tree
Date: Fri, 2 Dec 2011 16:08:34 -0600
Message-ID: <1322863714-6818-2-git-send-email-timur@freescale.com>
In-Reply-To: <1322863714-6818-1-git-send-email-timur@freescale.com>
References: <1322863714-6818-1-git-send-email-timur@freescale.com>
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

Add a 32-bit version of the device tree for the Freescale P1022DS reference
board.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/boot/dts/p1022ds_32b.dts |  270 +++++++++++++++++++++++++++++++++
 1 files changed, 270 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/p1022ds_32b.dts

diff --git a/arch/powerpc/boot/dts/p1022ds_32b.dts b/arch/powerpc/boot/dts/p1022ds_32b.dts
new file mode 100644
index 0000000..18787d9
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1022ds_32b.dts
@@ -0,0 +1,270 @@
+/*
+ * P1022 DS 32-Bit Physical Address Map Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/include/ "fsl/p1022si-pre.dtsi"
+/ {
+	model = "fsl,P1022DS";
+	compatible = "fsl,P1022DS";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0x0 0xffe05000 0 0x1000>;
+		ranges = <0x0 0x0 0x0 0xe8000000 0x08000000
+			  0x1 0x0 0x0 0xe0000000 0x08000000
+			  0x2 0x0 0x0 0xff800000 0x00040000
+			  0x3 0x0 0x0 0xffdf0000 0x00008000>;
+
+		/*
+		 * This node is used to access the pixis via "indirect" mode,
+		 * which is done by writing the pixis register index to chip
+		 * select 0 and the value to/from chip select 1.  Indirect
+		 * mode is the only way to access the pixis when DIU video
+		 * is enabled.  Note that this assumes that the first column
+		 * of the 'ranges' property above is the chip select number.
+		 */
+		board-control@0,0 {
+			compatible = "fsl,p1022ds-indirect-pixis";
+			reg = <0x0 0x0 1	/* CS0 */
+			       0x1 0x0 1>;	/* CS1 */
+		};
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x8000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition@0 {
+				reg = <0x0 0x03000000>;
+				label = "ramdisk-nor";
+				read-only;
+			};
+
+			partition@3000000 {
+				reg = <0x03000000 0x00e00000>;
+				label = "diagnostic-nor";
+				read-only;
+			};
+
+			partition@3e00000 {
+				reg = <0x03e00000 0x00200000>;
+				label = "dink-nor";
+				read-only;
+			};
+
+			partition@4000000 {
+				reg = <0x04000000 0x00400000>;
+				label = "kernel-nor";
+				read-only;
+			};
+
+			partition@4400000 {
+				reg = <0x04400000 0x03b00000>;
+				label = "jffs2-nor";
+			};
+
+			partition@7f00000 {
+				reg = <0x07f00000 0x00080000>;
+				label = "dtb-nor";
+				read-only;
+			};
+
+			partition@7f80000 {
+				reg = <0x07f80000 0x00080000>;
+				label = "u-boot-nor";
+				read-only;
+			};
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,elbc-fcm-nand";
+			reg = <0x2 0x0 0x40000>;
+
+			partition@0 {
+				reg = <0x0 0x02000000>;
+				label = "u-boot-nand";
+				read-only;
+			};
+
+			partition@2000000 {
+				reg = <0x02000000 0x10000000>;
+				label = "jffs2-nand";
+			};
+
+			partition@12000000 {
+				reg = <0x12000000 0x10000000>;
+				label = "ramdisk-nand";
+				read-only;
+			};
+
+			partition@22000000 {
+				reg = <0x22000000 0x04000000>;
+				label = "kernel-nand";
+			};
+
+			partition@26000000 {
+				reg = <0x26000000 0x01000000>;
+				label = "dtb-nand";
+				read-only;
+			};
+
+			partition@27000000 {
+				reg = <0x27000000 0x19000000>;
+				label = "reserved-nand";
+			};
+		};
+
+		board-control@3,0 {
+			compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
+			reg = <3 0 0x30>;
+			interrupt-parent = <&mpic>;
+			/*
+			 * IRQ8 is generated if the "EVENT" switch is pressed
+			 * and PX_CTL[EVESEL] is set to 00.
+			 */
+			interrupts = <8 8 0 0>;
+		};
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+
+		i2c@3100 {
+			wm8776:codec@1a {
+				compatible = "wlf,wm8776";
+				reg = <0x1a>;
+				/*
+				 * clock-frequency will be set by U-Boot if
+				 * the clock is enabled.
+				 */
+			};
+		};
+
+		spi@7000 {
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "spansion,s25sl12801";
+				reg = <0>;
+				spi-max-frequency = <40000000>; /* input clock */
+
+				partition@0 {
+					label = "u-boot-spi";
+					reg = <0x00000000 0x00100000>;
+					read-only;
+				};
+				partition@100000 {
+					label = "kernel-spi";
+					reg = <0x00100000 0x00500000>;
+					read-only;
+				};
+				partition@600000 {
+					label = "dtb-spi";
+					reg = <0x00600000 0x00100000>;
+					read-only;
+				};
+				partition@700000 {
+					label = "file system-spi";
+					reg = <0x00700000 0x00900000>;
+				};
+			};
+		};
+
+		ssi@15000 {
+			fsl,mode = "i2s-slave";
+			codec-handle = <&wm8776>;
+			fsl,ssi-asynchronous;
+		};
+
+		usb@22000 {
+			phy_type = "ulpi";
+		};
+
+		usb@23000 {
+			status = "disabled";
+		};
+
+		mdio@24000 {
+			phy0: ethernet-phy@0 {
+				interrupts = <3 1 0 0>;
+				reg = <0x1>;
+			};
+			phy1: ethernet-phy@1 {
+				interrupts = <9 1 0 0>;
+				reg = <0x2>;
+			};
+		};
+
+		ethernet@b0000 {
+			phy-handle = <&phy0>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		ethernet@b1000 {
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+		};
+	};
+
+	pci0: pcie@ffe09000 {
+		reg = <0x0 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci1: pcie@ffe0a000 {
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0 0xc0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc20000 0x0 0x10000>;
+		pcie@0 {
+			reg = <0x0 0x0 0x0 0x0 0x0>;
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+
+	pci2: pcie@ffe0b000 {
+		reg = <0 0xffe0b000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0xe0000000
+				  0x2000000 0x0 0xe0000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+/include/ "fsl/p1022si-post.dtsi"
-- 
1.7.3.4
