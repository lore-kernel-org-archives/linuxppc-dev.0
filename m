Return-Path: <B42677@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 153402C00DA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jul 2013 19:13:08 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH V6] powerpc/85xx: add the P1020RDB-PD DTS support
Date: Mon, 15 Jul 2013 16:22:33 +0800
Message-ID: <1373876553-14580-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>, AFLEMING@freescale.com,
 Xie Xiaobo-R63061 <X.Xie@freescale.com>, Scott Wood <scottwood@freescale.com>,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Overview of P1020RDB-PD device:
- DDR3 2GB
- NOR flash 64MB
- NAND flash 128MB
- SPI flash 16MB
- I2C EEPROM 256Kb
- eTSEC1 (RGMII PHY) connected to VSC7385 L2 switch
- eTSEC2 (SGMII PHY)
- eTSEC3 (RGMII PHY)
- SDHC
- 1 USB ports
- TDM ports
- PCIe

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Xie Xiaobo-R63061 <X.Xie@freescale.com>
CC: Scott Wood <scottwood@freescale.com>
---
changes for v6:
	- change the size of SPI file system
changes for v5:
	- change the size of nand file system

 arch/powerpc/boot/dts/p1020rdb-pd.dts | 280 ++++++++++++++++++++++++++++++++++
 1 file changed, 280 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/p1020rdb-pd.dts

diff --git a/arch/powerpc/boot/dts/p1020rdb-pd.dts b/arch/powerpc/boot/dts/p1020rdb-pd.dts
new file mode 100644
index 0000000..ffbda25
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1020rdb-pd.dts
@@ -0,0 +1,280 @@
+/*
+ * P1020 RDB-PD Device Tree Source (32-bit address map)
+ *
+ * Copyright 2013 Freescale Semiconductor Inc.
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
+/include/ "fsl/p1020si-pre.dtsi"
+/ {
+	model = "fsl,P1020RDB-PD";
+	compatible = "fsl,P1020RDB-PD";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0x0 0xffe05000 0x0 0x1000>;
+
+		/* NOR, NAND flash, L2 switch and CPLD */
+		ranges = <0x0 0x0 0x0 0xec000000 0x04000000
+			  0x1 0x0 0x0 0xff800000 0x00040000
+			  0x2 0x0 0x0 0xffa00000 0x00020000
+			  0x3 0x0 0x0 0xffb00000 0x00020000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x4000000>;
+			bank-width = <2>;
+			device-width = <1>;
+
+			partition@0 {
+				/* 128KB for DTB Image */
+				reg = <0x0 0x00020000>;
+				label = "NOR DTB Image";
+			};
+
+			partition@20000 {
+				/* 3.875 MB for Linux Kernel Image */
+				reg = <0x00020000 0x003e0000>;
+				label = "NOR Linux Kernel Image";
+			};
+
+			partition@400000 {
+				/* 58MB for Root file System */
+				reg = <0x00400000 0x03a00000>;
+				label = "NOR Root File System";
+			};
+
+			partition@3e00000 {
+				/* This location must not be altered  */
+				/* 1M for Vitesse 7385 Switch firmware */
+				reg = <0x3e00000 0x00100000>;
+				label = "NOR Vitesse-7385 Firmware";
+				read-only;
+			};
+
+			partition@3f00000 {
+				/* This location must not be altered  */
+				/* 512KB for u-boot Bootloader Image */
+				/* 512KB for u-boot Environment Variables */
+				reg = <0x03f00000 0x00100000>;
+				label = "NOR U-Boot Image";
+				read-only;
+			};
+		};
+
+		nand@1,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,p1020-fcm-nand",
+				     "fsl,elbc-fcm-nand";
+			reg = <0x1 0x0 0x40000>;
+
+			partition@0 {
+				/* This location must not be altered  */
+				/* 1MB for u-boot Bootloader Image */
+				reg = <0x0 0x00100000>;
+				label = "NAND U-Boot Image";
+				read-only;
+			};
+
+			partition@100000 {
+				/* 1MB for DTB Image */
+				reg = <0x00100000 0x00100000>;
+				label = "NAND DTB Image";
+			};
+
+			partition@200000 {
+				/* 4MB for Linux Kernel Image */
+				reg = <0x00200000 0x00400000>;
+				label = "NAND Linux Kernel Image";
+			};
+
+			partition@600000 {
+				/* 122MB for File System Image */
+				reg = <0x00600000 0x07a00000>;
+				label = "NAND File System Image";
+			};
+		};
+
+		cpld@2,0 {
+			compatible = "fsl,p1020rdb-pd-cpld";
+			reg = <0x2 0x0 0x20000>;
+		};
+
+		L2switch@3,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "vitesse-7385";
+			reg = <0x3 0x0 0x20000>;
+		};
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+
+		i2c@3000 {
+			rtc@68 {
+				compatible = "dallas,ds1339";
+				reg = <0x68>;
+			};
+		};
+
+		spi@7000 {
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "spansion,s25sl12801";
+				reg = <0>;
+				/* input clock */
+				spi-max-frequency = <40000000>;
+
+				partition@0 {
+					/* 512KB for u-boot Bootloader Image */
+					reg = <0x0 0x00080000>;
+					label = "SPI U-Boot Image";
+					read-only;
+				};
+
+				partition@80000 {
+					/* 512KB for DTB Image*/
+					reg = <0x00080000 0x00080000>;
+					label = "SPI DTB Image";
+				};
+
+				partition@100000 {
+					/* 4MB for Linux Kernel Image */
+					reg = <0x00100000 0x00400000>;
+					label = "SPI Linux Kernel Image";
+				};
+
+				partition@500000 {
+					/* 11MB for FS System Image */
+					reg = <0x00500000 0x00b00000>;
+					label = "SPI File System Image";
+				};
+			};
+
+			slic@0 {
+				compatible = "zarlink,le88266";
+				reg = <1>;
+				spi-max-frequency = <8000000>;
+			};
+
+			slic@1 {
+				compatible = "zarlink,le88266";
+				reg = <2>;
+				spi-max-frequency = <8000000>;
+			};
+		};
+
+		mdio@24000 {
+			phy0: ethernet-phy@0 {
+				interrupts = <3 1 0 0>;
+				reg = <0x0>;
+			};
+
+			phy1: ethernet-phy@1 {
+				interrupts = <2 1 0 0>;
+				reg = <0x1>;
+			};
+		};
+
+		mdio@25000 {
+			tbi1: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		mdio@26000 {
+			tbi2: tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet0: ethernet@b0000 {
+			fixed-link = <1 1 1000 0 0>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		enet1: ethernet@b1000 {
+			phy-handle = <&phy0>;
+			tbi-handle = <&tbi1>;
+			phy-connection-type = "sgmii";
+		};
+
+		enet2: ethernet@b2000 {
+			phy-handle = <&phy1>;
+			phy-connection-type = "rgmii-id";
+		};
+
+		usb@22000 {
+			phy_type = "ulpi";
+		};
+	};
+
+	pci0: pcie@ffe09000 {
+		reg = <0x0 0xffe09000 0x0 0x1000>;
+		ranges = <0x2000000 0x0 0xa0000000 0x0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0x0 0xffc10000 0x0 0x10000>;
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
+	pci1: pcie@ffe0a000 {
+		reg = <0x0 0xffe0a000 0x0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0x0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0x0 0xffc00000 0x0 0x10000>;
+		pcie@0 {
+			ranges = <0x2000000 0x0 0x80000000
+				  0x2000000 0x0 0x80000000
+				  0x0 0x20000000
+
+				  0x1000000 0x0 0x0
+				  0x1000000 0x0 0x0
+				  0x0 0x100000>;
+		};
+	};
+};
+
+/include/ "fsl/p1020si-post.dtsi"
-- 
1.8.0
