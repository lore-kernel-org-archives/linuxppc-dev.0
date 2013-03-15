Return-Path: <b20052@nmglablinux22.freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe001.messaging.microsoft.com [213.199.154.204])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 385F12C00FE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 18:55:27 +1100 (EST)
Received: from mail63-am1 (localhost [127.0.0.1])	by mail63-am1-R.bigfish.com
 (Postfix) with ESMTP id 453892A01EF	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 15 Mar 2013 07:55:21 +0000 (UTC)
Received: from AM1EHSMHS006.bigfish.com (unknown [10.3.201.239])	by
 mail63-am1.bigfish.com (Postfix) with ESMTP id 5A85B408D0	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2013 07:55:18 +0000 (UTC)
From: Shaveta Leekha <shaveta@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/6] powerpc/fsl-booke: Add initial B4420QDS board device tree
Date: Fri, 15 Mar 2013 13:25:07 +0530
Message-ID: <1363334109-21922-4-git-send-email-shaveta@freescale.com>
In-Reply-To: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
References: <1363334109-21922-1-git-send-email-shaveta@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaveta Leekha <shaveta@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
---
 arch/powerpc/boot/dts/b4420qds.dts |  168 ++++++++++++++++++++++++++++++++++++
 1 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/b4420qds.dts

diff --git a/arch/powerpc/boot/dts/b4420qds.dts b/arch/powerpc/boot/dts/b4420qds.dts
new file mode 100644
index 0000000..3152f8c
--- /dev/null
+++ b/arch/powerpc/boot/dts/b4420qds.dts
@@ -0,0 +1,168 @@
+/*
+ * B4420DS Device Tree Source
+ *
+ * Copyright 2012 Freescale Semiconductor, Inc.
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
+ * This software is provided by Freescale Semiconductor "as is" and any
+ * express or implied warranties, including, but not limited to, the implied
+ * warranties of merchantability and fitness for a particular purpose are
+ * disclaimed. In no event shall Freescale Semiconductor be liable for any
+ * direct, indirect, incidental, special, exemplary, or consequential damages
+ * (including, but not limited to, procurement of substitute goods or services;
+ * loss of use, data, or profits; or business interruption) however caused and
+ * on any theory of liability, whether in contract, strict liability, or tort
+ * (including negligence or otherwise) arising in any way out of the use of
+ * this software, even if advised of the possibility of such damage.
+ */
+
+/include/ "fsl/b4420si-pre.dtsi"
+
+/ {
+	model = "fsl,B4420QDS";
+	compatible = "fsl,B4420QDS";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&mpic>;
+
+	ifc: localbus@ffe124000 {
+		reg = <0xf 0xfe124000 0 0x2000>;
+		ranges = <0 0 0xf 0xe8000000 0x08000000
+			  2 0 0xf 0xff800000 0x00010000
+			  3 0 0xf 0xffdf0000 0x00008000>;
+
+		nor@0,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "cfi-flash";
+			reg = <0x0 0x0 0x8000000>;
+			bank-width = <2>;
+			device-width = <1>;
+		};
+
+		nand@2,0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,ifc-nand";
+			reg = <0x2 0x0 0x10000>;
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
+				/* 10MB for Linux Kernel Image */
+				reg = <0x00200000 0x00A00000>;
+				label = "NAND Linux Kernel Image";
+			};
+
+			partition@c00000 {
+				/* 500MB for Root file System Image */
+				reg = <0x00c00000 0x1F400000>;
+				label = "NAND RFS Image";
+			};
+		};
+
+		board-control@3,0 {
+			compatible = "fsl,b4420qds-fpga", "fsl,fpga-qixis";
+			reg = <3 0 0x300>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+	};
+
+	soc: soc@ffe000000 {
+		ranges = <0x00000000 0xf 0xfe000000 0x1000000>;
+		reg = <0xf 0xfe000000 0 0x00001000>;
+		spi@110000 {
+			flash@0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				compatible = "sst,sst25wf040";
+				reg = <0>;
+				spi-max-frequency = <40000000>; /* input clock */
+			};
+		};
+
+		sdhc@114000 {
+			/*Disabled as there is no sdhc connector on B4420QDS board*/
+			status = "disabled";
+		};
+
+		i2c@118000 {
+			eeprom@50 {
+				compatible = "at24,24c64";
+				reg = <0x50>;
+			};
+			eeprom@51 {
+				compatible = "at24,24c256";
+				reg = <0x51>;
+			};
+			eeprom@53 {
+				compatible = "at24,24c256";
+				reg = <0x53>;
+			};
+			eeprom@57 {
+				compatible = "at24,24c256";
+				reg = <0x57>;
+			};
+			rtc@68 {
+				compatible = "dallas,ds3232";
+				reg = <0x68>;
+				interrupts = <0x1 0x1 0 0>;
+			};
+		};
+
+		usb@210000 {
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+
+	};
+
+	pci0: pcie@ffe200000 {
+		reg = <0xf 0xfe200000 0 0x10000>;
+		ranges = <0x02000000 0 0xe0000000 0xc 0x00000000 0x0 0x20000000
+			  0x01000000 0 0x00000000 0xf 0xf8000000 0x0 0x00010000>;
+		pcie@0 {
+			ranges = <0x02000000 0 0xe0000000
+				  0x02000000 0 0xe0000000
+				  0 0x20000000
+
+				  0x01000000 0 0x00000000
+				  0x01000000 0 0x00000000
+				  0 0x00010000>;
+		};
+	};
+
+};
+
+/include/ "fsl/b4420si-post.dtsi"
-- 
1.7.6.GIT
