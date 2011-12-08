Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 687BD1007D6
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Dec 2011 08:50:59 +1100 (EST)
Received: from mail11-tx2 (localhost [127.0.0.1])	by mail11-tx2-R.bigfish.com
 (Postfix) with ESMTP id 069016801BF	for <linuxppc-dev@ozlabs.org>;
 Thu,  8 Dec 2011 21:50:57 +0000 (UTC)
Received: from TX2EHSMHS005.bigfish.com (unknown [10.9.14.253])	by
 mail11-tx2.bigfish.com (Postfix) with ESMTP id 71EF73C0042	for
 <linuxppc-dev@ozlabs.org>; Thu,  8 Dec 2011 21:50:54 +0000 (UTC)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] [v2] powerpc/85xx: create 32-bit DTS for the P1022DS
Date: Thu, 8 Dec 2011 15:50:49 -0600
Message-ID: <1323381049-29429-1-git-send-email-timur@freescale.com>
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

Create a 32-bit address space version of p1022ds.dts.  To avoid confusion,
p1022ds.dts is renamed to p1022ds_36b.dts.  We also create p1022ds.dtsi
to store some common nodes.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

fix pixis interrupt property and added tbi node

 arch/powerpc/boot/dts/p1022ds.dts     |  270 ---------------------------------
 arch/powerpc/boot/dts/p1022ds.dtsi    |  116 ++++++++++++++
 arch/powerpc/boot/dts/p1022ds_32b.dts |  218 ++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1022ds_36b.dts |  218 ++++++++++++++++++++++++++
 4 files changed, 552 insertions(+), 270 deletions(-)
 delete mode 100644 arch/powerpc/boot/dts/p1022ds.dts
 create mode 100644 arch/powerpc/boot/dts/p1022ds.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1022ds_32b.dts
 create mode 100644 arch/powerpc/boot/dts/p1022ds_36b.dts

diff --git a/arch/powerpc/boot/dts/p1022ds.dts b/arch/powerpc/boot/dts/p1022ds.dts
deleted file mode 100644
index a54dd13..0000000
--- a/arch/powerpc/boot/dts/p1022ds.dts
+++ /dev/null
@@ -1,270 +0,0 @@
-/*
- * P1022 DS 36Bit Physical Address Map Device Tree Source
- *
- * Copyright 2010 Freescale Semiconductor, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-/include/ "fsl/p1022si-pre.dtsi"
-/ {
-	model = "fsl,P1022DS";
-	compatible = "fsl,P1022DS";
-
-	memory {
-		device_type = "memory";
-	};
-
-	lbc: localbus@fffe05000 {
-		reg = <0xf 0xffe05000 0 0x1000>;
-		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
-			  0x1 0x0 0xf 0xe0000000 0x08000000
-			  0x2 0x0 0xf 0xff800000 0x00040000
-			  0x3 0x0 0xf 0xffdf0000 0x00008000>;
-
-		/*
-		 * This node is used to access the pixis via "indirect" mode,
-		 * which is done by writing the pixis register index to chip
-		 * select 0 and the value to/from chip select 1.  Indirect
-		 * mode is the only way to access the pixis when DIU video
-		 * is enabled.  Note that this assumes that the first column
-		 * of the 'ranges' property above is the chip select number.
-		 */
-		board-control@0,0 {
-			compatible = "fsl,p1022ds-indirect-pixis";
-			reg = <0x0 0x0 1	/* CS0 */
-			       0x1 0x0 1>;	/* CS1 */
-		};
-
-		nor@0,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "cfi-flash";
-			reg = <0x0 0x0 0x8000000>;
-			bank-width = <2>;
-			device-width = <1>;
-
-			partition@0 {
-				reg = <0x0 0x03000000>;
-				label = "ramdisk-nor";
-				read-only;
-			};
-
-			partition@3000000 {
-				reg = <0x03000000 0x00e00000>;
-				label = "diagnostic-nor";
-				read-only;
-			};
-
-			partition@3e00000 {
-				reg = <0x03e00000 0x00200000>;
-				label = "dink-nor";
-				read-only;
-			};
-
-			partition@4000000 {
-				reg = <0x04000000 0x00400000>;
-				label = "kernel-nor";
-				read-only;
-			};
-
-			partition@4400000 {
-				reg = <0x04400000 0x03b00000>;
-				label = "jffs2-nor";
-			};
-
-			partition@7f00000 {
-				reg = <0x07f00000 0x00080000>;
-				label = "dtb-nor";
-				read-only;
-			};
-
-			partition@7f80000 {
-				reg = <0x07f80000 0x00080000>;
-				label = "u-boot-nor";
-				read-only;
-			};
-		};
-
-		nand@2,0 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "fsl,elbc-fcm-nand";
-			reg = <0x2 0x0 0x40000>;
-
-			partition@0 {
-				reg = <0x0 0x02000000>;
-				label = "u-boot-nand";
-				read-only;
-			};
-
-			partition@2000000 {
-				reg = <0x02000000 0x10000000>;
-				label = "jffs2-nand";
-			};
-
-			partition@12000000 {
-				reg = <0x12000000 0x10000000>;
-				label = "ramdisk-nand";
-				read-only;
-			};
-
-			partition@22000000 {
-				reg = <0x22000000 0x04000000>;
-				label = "kernel-nand";
-			};
-
-			partition@26000000 {
-				reg = <0x26000000 0x01000000>;
-				label = "dtb-nand";
-				read-only;
-			};
-
-			partition@27000000 {
-				reg = <0x27000000 0x19000000>;
-				label = "reserved-nand";
-			};
-		};
-
-		board-control@3,0 {
-			compatible = "fsl,p1022ds-fpga", "fsl,fpga-ngpixis";
-			reg = <3 0 0x30>;
-			interrupt-parent = <&mpic>;
-			/*
-			 * IRQ8 is generated if the "EVENT" switch is pressed
-			 * and PX_CTL[EVESEL] is set to 00.
-			 */
-			interrupts = <8 8 0 0>;
-		};
-	};
-
-	soc: soc@fffe00000 {
-		ranges = <0x0 0xf 0xffe00000 0x100000>;
-
-		i2c@3100 {
-			wm8776:codec@1a {
-				compatible = "wlf,wm8776";
-				reg = <0x1a>;
-				/*
-				 * clock-frequency will be set by U-Boot if
-				 * the clock is enabled.
-				 */
-			};
-		};
-
-		spi@7000 {
-			flash@0 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "spansion,s25sl12801";
-				reg = <0>;
-				spi-max-frequency = <40000000>; /* input clock */
-
-				partition@0 {
-					label = "u-boot-spi";
-					reg = <0x00000000 0x00100000>;
-					read-only;
-				};
-				partition@100000 {
-					label = "kernel-spi";
-					reg = <0x00100000 0x00500000>;
-					read-only;
-				};
-				partition@600000 {
-					label = "dtb-spi";
-					reg = <0x00600000 0x00100000>;
-					read-only;
-				};
-				partition@700000 {
-					label = "file system-spi";
-					reg = <0x00700000 0x00900000>;
-				};
-			};
-		};
-
-		ssi@15000 {
-			fsl,mode = "i2s-slave";
-			codec-handle = <&wm8776>;
-			fsl,ssi-asynchronous;
-		};
-
-		usb@22000 {
-			phy_type = "ulpi";
-		};
-
-		usb@23000 {
-			status = "disabled";
-		};
-
-		mdio@24000 {
-			phy0: ethernet-phy@0 {
-				interrupts = <3 1 0 0>;
-				reg = <0x1>;
-			};
-			phy1: ethernet-phy@1 {
-				interrupts = <9 1 0 0>;
-				reg = <0x2>;
-			};
-		};
-
-		ethernet@b0000 {
-			phy-handle = <&phy0>;
-			phy-connection-type = "rgmii-id";
-		};
-
-		ethernet@b1000 {
-			phy-handle = <&phy1>;
-			phy-connection-type = "rgmii-id";
-		};
-	};
-
-	pci0: pcie@fffe09000 {
-		reg = <0xf 0xffe09000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xe0000000
-				  0x2000000 0x0 0xe0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-
-	pci1: pcie@fffe0a000 {
-		reg = <0xf 0xffe0a000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0xf 0xffc20000 0x0 0x10000>;
-		pcie@0 {
-			reg = <0x0 0x0 0x0 0x0 0x0>;
-			ranges = <0x2000000 0x0 0xe0000000
-				  0x2000000 0x0 0xe0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-
-	pci2: pcie@fffe0b000 {
-		reg = <0xf 0xffe0b000 0 0x1000>;
-		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
-			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
-		pcie@0 {
-			ranges = <0x2000000 0x0 0xe0000000
-				  0x2000000 0x0 0xe0000000
-				  0x0 0x20000000
-
-				  0x1000000 0x0 0x0
-				  0x1000000 0x0 0x0
-				  0x0 0x100000>;
-		};
-	};
-};
-
-/include/ "fsl/p1022si-post.dtsi"
diff --git a/arch/powerpc/boot/dts/p1022ds.dtsi b/arch/powerpc/boot/dts/p1022ds.dtsi
new file mode 100644
index 0000000..c82cfc9
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1022ds.dtsi
@@ -0,0 +1,116 @@
+/*
+ * P1022 DS Device Tree Source stub (no addresses or top-level ranges)
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
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
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+&board_soc {
+	i2c@3100 {
+		wm8776:codec@1a {
+			compatible = "wlf,wm8776";
+			reg = <0x1a>;
+			/*
+			 * clock-frequency will be set by U-Boot if
+			 * the clock is enabled.
+			 */
+		};
+	};
+
+	spi@7000 {
+		flash@0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "spansion,s25sl12801";
+			reg = <0>;
+			spi-max-frequency = <40000000>; /* input clock */
+
+			partition@0 {
+				label = "u-boot-spi";
+				reg = <0x00000000 0x00100000>;
+				read-only;
+			};
+			partition@100000 {
+				label = "kernel-spi";
+				reg = <0x00100000 0x00500000>;
+				read-only;
+			};
+			partition@600000 {
+				label = "dtb-spi";
+				reg = <0x00600000 0x00100000>;
+				read-only;
+			};
+			partition@700000 {
+				label = "file system-spi";
+				reg = <0x00700000 0x00900000>;
+			};
+		};
+	};
+
+	ssi@15000 {
+		fsl,mode = "i2s-slave";
+		codec-handle = <&wm8776>;
+		fsl,ssi-asynchronous;
+	};
+
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	usb@23000 {
+		status = "disabled";
+	};
+
+	mdio@24000 {
+		phy0: ethernet-phy@0 {
+			interrupts = <3 1 0 0>;
+			reg = <0x1>;
+		};
+		phy1: ethernet-phy@1 {
+			interrupts = <9 1 0 0>;
+			reg = <0x2>;
+		};
+		tbi-phy@2 {
+			device_type = "tbi-phy";
+			reg = <0x2>;
+		};
+	};
+
+	ethernet@b0000 {
+		phy-handle = <&phy0>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	ethernet@b1000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+};
+
diff --git a/arch/powerpc/boot/dts/p1022ds_32b.dts b/arch/powerpc/boot/dts/p1022ds_32b.dts
new file mode 100644
index 0000000..03c94e1
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1022ds_32b.dts
@@ -0,0 +1,218 @@
+/*
+ * P1022 DS 32-bit Physical Address Map Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
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
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+			interrupts = <8 0 0 0>;
+		};
+	};
+
+	board_soc: soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
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
+/include/ "p1022ds.dtsi"
diff --git a/arch/powerpc/boot/dts/p1022ds_36b.dts b/arch/powerpc/boot/dts/p1022ds_36b.dts
new file mode 100644
index 0000000..2893bfa
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1022ds_36b.dts
@@ -0,0 +1,218 @@
+/*
+ * P1022 DS 36-bit Physical Address Map Device Tree Source
+ *
+ * Copyright 2011 Freescale Semiconductor Inc.
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
+ * THIS SOFTWARE IS PROVIDED BY Freescale Semiconductor "AS IS" AND ANY
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
+/include/ "fsl/p1022si-pre.dtsi"
+/ {
+	model = "fsl,P1022DS";
+	compatible = "fsl,P1022DS";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@fffe05000 {
+		reg = <0xf 0xffe05000 0 0x1000>;
+		ranges = <0x0 0x0 0xf 0xe8000000 0x08000000
+			  0x1 0x0 0xf 0xe0000000 0x08000000
+			  0x2 0x0 0xf 0xff800000 0x00040000
+			  0x3 0x0 0xf 0xffdf0000 0x00008000>;
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
+			interrupts = <8 0 0 0>;
+		};
+	};
+
+	board_soc: soc: soc@fffe00000 {
+		ranges = <0x0 0xf 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@fffe09000 {
+		reg = <0xf 0xffe09000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x20000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc10000 0x0 0x10000>;
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
+	pci1: pcie@fffe0a000 {
+		reg = <0xf 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x40000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc20000 0x0 0x10000>;
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
+	pci2: pcie@fffe0b000 {
+		reg = <0xf 0xffe0b000 0 0x1000>;
+		ranges = <0x2000000 0x0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0xf 0xffc00000 0x0 0x10000>;
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
+/include/ "p1022ds.dtsi"
-- 
1.7.3.4
