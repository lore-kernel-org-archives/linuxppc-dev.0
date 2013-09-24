Return-Path: <r63061@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B7C322C0132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 20:54:42 +1000 (EST)
Received: from mail172-tx2 (localhost [127.0.0.1])	by
 mail172-tx2-R.bigfish.com (Postfix) with ESMTP id A26AC2A0195	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 10:54:37 +0000 (UTC)
Received: from TX2EHSMHS031.bigfish.com (unknown [10.9.14.234])	by
 mail172-tx2.bigfish.com (Postfix) with ESMTP id D1B88140049	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 10:54:34 +0000 (UTC)
From: Xie Xiaobo <X.Xie@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
Subject: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
Date: Tue, 24 Sep 2013 18:48:59 +0800
Message-ID: <1380019739-8196-3-git-send-email-X.Xie@freescale.com>
In-Reply-To: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Michael Johnston <michael.johnston@freescale.com>,
 Xie Xiaobo <X.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

TWR-P1025 Overview
 -----------------
 512Mbyte DDR3 (on board DDR)
 64MB Nor Flash
 eTSEC1: Connected to RGMII PHY AR8035
 eTSEC3: Connected to RGMII PHY AR8035
 Two USB2.0 Type A
 One microSD Card slot
 One mini-PCIe slot
 One mini-USB TypeB dual UART

Signed-off-by: Michael Johnston <michael.johnston@freescale.com>
Signed-off-by: Xie Xiaobo <X.Xie@freescale.com>
---
Patch V4: Fix the mdio phy interrupt issue in dts
Patch V3: fix pcie range issue in dts
Patch V2: QE related init codes were factored out to a common file

 arch/powerpc/boot/dts/p1025twr.dtsi     | 244 ++++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/p1025twr_32b.dts  | 135 ++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig     |   6 +
 arch/powerpc/platforms/85xx/Makefile    |   1 +
 arch/powerpc/platforms/85xx/twr_p102x.c | 142 +++++++++++++++++++
 5 files changed, 528 insertions(+)
 create mode 100644 arch/powerpc/boot/dts/p1025twr.dtsi
 create mode 100644 arch/powerpc/boot/dts/p1025twr_32b.dts
 create mode 100644 arch/powerpc/platforms/85xx/twr_p102x.c

diff --git a/arch/powerpc/boot/dts/p1025twr.dtsi b/arch/powerpc/boot/dts/p1025twr.dtsi
new file mode 100644
index 0000000..4b1d5f7
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1025twr.dtsi
@@ -0,0 +1,244 @@
+/*
+ * P1025 TWR Device Tree Source stub (no addresses or top-level ranges)
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
+/{
+       aliases {
+		ethernet3 = &enet3;
+		ethernet4 = &enet4;
+       };
+};
+
+&lbc {
+	nor@0,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-flash";
+		reg = <0x0 0x0 0x4000000>;
+		bank-width = <2>;
+		device-width = <1>;
+
+		partition@0 {
+			/* This location must not be altered  */
+			/* 256KB for Vitesse 7385 Switch firmware */
+			reg = <0x0 0x00040000>;
+			label = "NOR Vitesse-7385 Firmware";
+			read-only;
+		};
+
+		partition@40000 {
+			/* 256KB for DTB Image */
+			reg = <0x00040000 0x00040000>;
+			label = "NOR DTB Image";
+		};
+
+		partition@80000 {
+			/* 3.5 MB for Linux Kernel Image */
+			reg = <0x00080000 0x00380000>;
+			label = "NOR Linux Kernel Image";
+		};
+
+		partition@400000 {
+			/* 58.75MB for JFFS2 based Root file System */
+			reg = <0x00400000 0x03ac0000>;
+			label = "NOR Root File System";
+		};
+
+		partition@ec0000 {
+			/* This location must not be altered  */
+			/* 256KB for QE ucode firmware*/
+			reg = <0x03ec0000 0x00040000>;
+			label = "NOR QE microcode firmware";
+			read-only;
+		};
+
+		partition@f00000 {
+			/* This location must not be altered  */
+			/* 512KB for u-boot Bootloader Image */
+			/* 512KB for u-boot Environment Variables */
+			reg = <0x03f00000 0x00100000>;
+			label = "NOR U-Boot Image";
+			read-only;
+		};
+	};
+
+	/* CS2 for Display */
+	ssd1289@2,0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "ssd1289";
+		reg = <0x2 0x0000 0x0002
+		       0x2 0x0002 0x0002>;
+	};
+
+};
+
+&soc {
+	usb@22000 {
+		phy_type = "ulpi";
+	};
+
+	mdio@24000 {
+		phy0: ethernet-phy@2 {
+			interrupt-parent = <&mpic>;
+			interrupts = <1 1 0 0>;
+			reg = <0x2>;
+		};
+
+		phy1: ethernet-phy@1 {
+			interrupt-parent = <&mpic>;
+			interrupts = <2 1 0 0>;
+			reg = <0x1>;
+		};
+
+		tbi0: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	mdio@25000 {
+		tbi1: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	mdio@26000 {
+		tbi2: tbi-phy@11 {
+			reg = <0x11>;
+			device_type = "tbi-phy";
+		};
+	};
+
+	enet0: ethernet@b0000 {
+		phy-handle = <&phy0>;
+		phy-connection-type = "rgmii-id";
+
+	};
+
+	enet1: ethernet@b1000 {
+		status = "disabled";
+	};
+
+	enet2: ethernet@b2000 {
+		phy-handle = <&phy1>;
+		phy-connection-type = "rgmii-id";
+	};
+
+	par_io@e0100 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		reg = <0xe0100 0x60>;
+		ranges = <0x0 0xe0100 0x60>;
+		device_type = "par_io";
+		num-ports = <3>;
+		pio1: ucc_pin@01 {
+			pio-map = <
+		/* port  pin  dir  open_drain  assignment  has_irq */
+				0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
+				0x1  0x14 0x3  0x0  0x1  0x0    /* QE_MUX_MDIO */
+				0x0  0x17 0x2  0x0  0x2  0x0    /* CLK12 */
+				0x0  0x18 0x2  0x0  0x1  0x0    /* CLK9 */
+				0x0  0x7  0x1  0x0  0x2  0x0    /* ENET1_TXD0_SER1_TXD0 */
+				0x0  0x9  0x1  0x0  0x2  0x0    /* ENET1_TXD1_SER1_TXD1 */
+				0x0  0xb  0x1  0x0  0x2  0x0    /* ENET1_TXD2_SER1_TXD2 */
+				0x0  0xc  0x1  0x0  0x2  0x0    /* ENET1_TXD3_SER1_TXD3 */
+				0x0  0x6  0x2  0x0  0x2  0x0    /* ENET1_RXD0_SER1_RXD0 */
+				0x0  0xa  0x2  0x0  0x2  0x0    /* ENET1_RXD1_SER1_RXD1 */
+				0x0  0xe  0x2  0x0  0x2  0x0    /* ENET1_RXD2_SER1_RXD2 */
+				0x0  0xf  0x2  0x0  0x2  0x0    /* ENET1_RXD3_SER1_RXD3 */
+				0x0  0x5  0x1  0x0  0x2  0x0    /* ENET1_TX_EN_SER1_RTS_B */
+				0x0  0xd  0x1  0x0  0x2  0x0    /* ENET1_TX_ER */
+				0x0  0x4  0x2  0x0  0x2  0x0    /* ENET1_RX_DV_SER1_CTS_B */
+				0x0  0x8  0x2  0x0  0x2  0x0    /* ENET1_RX_ER_SER1_CD_B */
+				0x0  0x11 0x2  0x0  0x2  0x0    /* ENET1_CRS */
+				0x0  0x10 0x2  0x0  0x2  0x0>;    /* ENET1_COL */
+		};
+
+		pio2: ucc_pin@02 {
+			pio-map = <
+		/* port  pin  dir  open_drain  assignment  has_irq */
+				0x1  0x13 0x1  0x0  0x1  0x0    /* QE_MUX_MDC */
+				0x1  0x14 0x3  0x0  0x1  0x0    /* QE_MUX_MDIO */
+				0x1  0xb  0x2  0x0  0x1  0x0    /* CLK13 */
+				0x1  0x7  0x1  0x0  0x2  0x0    /* ENET5_TXD0_SER5_TXD0 */
+				0x1  0xa  0x1  0x0  0x2  0x0    /* ENET5_TXD1_SER5_TXD1 */
+				0x1  0x6  0x2  0x0  0x2  0x0    /* ENET5_RXD0_SER5_RXD0 */
+				0x1  0x9  0x2  0x0  0x2  0x0    /* ENET5_RXD1_SER5_RXD1 */
+				0x1  0x5  0x1  0x0  0x2  0x0    /* ENET5_TX_EN_SER5_RTS_B */
+				0x1  0x4  0x2  0x0  0x2  0x0    /* ENET5_RX_DV_SER5_CTS_B */
+				0x1  0x8  0x2  0x0  0x2  0x0>;    /* ENET5_RX_ER_SER5_CD_B */
+		};
+
+		pio3: ucc_pin@03 {
+			pio-map = <
+		/* port  pin  dir  open_drain  assignment  has_irq */
+				0x0  0x16 0x2  0x0  0x2  0x0    /* SER7_CD_B*/
+				0x0  0x12 0x2  0x0  0x2  0x0    /* SER7_CTS_B*/
+				0x0  0x13 0x1  0x0  0x2  0x0    /* SER7_RTS_B*/
+				0x0  0x14 0x2  0x0  0x2  0x0    /* SER7_RXD0*/
+				0x0  0x15 0x1  0x0  0x2  0x0>;    /* SER7_TXD0*/
+		};
+
+		pio4: ucc_pin@04 {
+			pio-map = <
+		/* port  pin  dir  open_drain  assignment  has_irq */
+				0x1  0x0  0x2  0x0  0x2  0x0    /* SER3_CD_B*/
+				0x0  0x1c 0x2  0x0  0x2  0x0    /* SER3_CTS_B*/
+				0x0  0x1d 0x1  0x0  0x2  0x0    /* SER3_RTS_B*/
+				0x0  0x1e 0x2  0x0  0x2  0x0    /* SER3_RXD0*/
+				0x0  0x1f 0x1  0x0  0x2  0x0>;    /* SER3_TXD0*/
+		};
+	};
+};
+
+&qe {
+	serial2: ucc@2600 {
+		device_type = "serial";
+		compatible = "ucc_uart";
+		port-number = <0>;
+		rx-clock-name = "brg6";
+		tx-clock-name = "brg6";
+		pio-handle = <&pio3>;
+	};
+
+	serial3: ucc@2200 {
+		device_type = "serial";
+		compatible = "ucc_uart";
+		port-number = <1>;
+		rx-clock-name = "brg2";
+		tx-clock-name = "brg2";
+		pio-handle = <&pio4>;
+	};
+};
diff --git a/arch/powerpc/boot/dts/p1025twr_32b.dts b/arch/powerpc/boot/dts/p1025twr_32b.dts
new file mode 100644
index 0000000..ccb173f
--- /dev/null
+++ b/arch/powerpc/boot/dts/p1025twr_32b.dts
@@ -0,0 +1,135 @@
+/*
+ * P1025 TWR Device Tree Source (32-bit address map)
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
+/include/ "fsl/p1021si-pre.dtsi"
+/ {
+	model = "fsl,P1025";
+	compatible = "fsl,TWR-P1025";
+
+	memory {
+		device_type = "memory";
+	};
+
+	lbc: localbus@ffe05000 {
+		reg = <0 0xffe05000 0 0x1000>;
+
+		/* NOR Flash and SSD1289 */
+		ranges = <0x0 0x0 0x0 0xec000000 0x04000000
+			  0x2 0x0 0x0 0xe0000000 0x00020000>;
+	};
+
+	soc: soc@ffe00000 {
+		ranges = <0x0 0x0 0xffe00000 0x100000>;
+	};
+
+	pci0: pcie@ffe09000 {
+		ranges = <0x2000000 0x0 0xa0000000 0 0xa0000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc10000 0x0 0x10000>;
+		reg = <0 0xffe09000 0 0x1000>;
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
+		reg = <0 0xffe0a000 0 0x1000>;
+		ranges = <0x2000000 0x0 0x80000000 0 0x80000000 0x0 0x20000000
+			  0x1000000 0x0 0x00000000 0 0xffc00000 0x0 0x10000>;
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
+
+	qe: qe@ffe80000 {
+		ranges = <0x0 0x0 0xffe80000 0x40000>;
+		reg = <0 0xffe80000 0 0x480>;
+		brg-frequency = <0>;
+		bus-frequency = <0>;
+		status = "disabled"; /* no firmware loaded */
+
+		enet3: ucc@2000 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			rx-clock-name = "clk12";
+			tx-clock-name = "clk9";
+			pio-handle = <&pio1>;
+			phy-handle = <&qe_phy0>;
+			phy-connection-type = "mii";
+		};
+
+		mdio@2120 {
+			qe_phy0: ethernet-phy@18 {
+				interrupt-parent = <&mpic>;
+				interrupts = <4 1 0 0>;
+				reg = <0x18>;
+				device_type = "ethernet-phy";
+			};
+			qe_phy1: ethernet-phy@19 {
+				interrupt-parent = <&mpic>;
+				interrupts = <5 1 0 0>;
+				reg = <0x19>;
+				device_type = "ethernet-phy";
+			};
+			tbi-phy@11 {
+				reg = <0x11>;
+				device_type = "tbi-phy";
+			};
+		};
+
+		enet4: ucc@2400 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			rx-clock-name = "none";
+			tx-clock-name = "clk13";
+			pio-handle = <&pio2>;
+			phy-handle = <&qe_phy1>;
+			phy-connection-type = "rmii";
+		};
+	};
+};
+
+/include/ "p1025twr.dtsi"
+/include/ "fsl/p1021si-post.dtsi"
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index de2eb93..b1a7d0a 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -123,6 +123,12 @@ config P1023_RDS
 	help
 	  This option enables support for the P1023 RDS and RDB boards
 
+config TWR_P102x
+	bool "Freescale TWR-P102x"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the TWR-P1025 board.
+
 config SOCRATES
 	bool "Socrates"
 	select DEFAULT_UIMAGE
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 53c9f75..228c4dd 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_P1010_RDB)   += p1010rdb.o
 obj-$(CONFIG_P1022_DS)    += p1022_ds.o
 obj-$(CONFIG_P1022_RDK)   += p1022_rdk.o
 obj-$(CONFIG_P1023_RDS)   += p1023_rds.o
+obj-$(CONFIG_TWR_P102x)   += twr_p102x.o
 obj-$(CONFIG_P2041_RDB)   += p2041_rdb.o corenet_ds.o
 obj-$(CONFIG_P3041_DS)    += p3041_ds.o corenet_ds.o
 obj-$(CONFIG_P4080_DS)    += p4080_ds.o corenet_ds.o
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
new file mode 100644
index 0000000..8ba3b25
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -0,0 +1,142 @@
+/*
+ * Copyright 2010-2011, 2013 Freescale Semiconductor, Inc.
+ *
+ * Author: Michael Johnston <michael.johnston@freescale.com>
+ *
+ * Description:
+ * TWR-P102x Board Setup
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/pci.h>
+#include <linux/of_platform.h>
+
+#include <asm/pci-bridge.h>
+#include <asm/udbg.h>
+#include <asm/mpic.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
+#include <asm/fsl_guts.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/fsl_pci.h>
+#include "smp.h"
+
+#include "mpc85xx.h"
+
+static void __init twr_p1025_pic_init(void)
+{
+	struct mpic *mpic;
+
+	mpic = mpic_alloc(NULL, 0, MPIC_BIG_ENDIAN |
+			MPIC_SINGLE_DEST_CPU,
+			0, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+	mpic_init(mpic);
+
+#ifdef CONFIG_QUICC_ENGINE
+	mpc85xx_qe_pic_init();
+#endif
+}
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+static void __init twr_p1025_setup_arch(void)
+{
+#ifdef CONFIG_QUICC_ENGINE
+	struct device_node *np;
+#endif
+
+	if (ppc_md.progress)
+		ppc_md.progress("twr_p1025_setup_arch()", 0);
+
+	mpc85xx_smp_init();
+
+	fsl_pci_assign_primary();
+
+#ifdef CONFIG_QUICC_ENGINE
+	mpc85xx_qe_init();
+
+#if defined(CONFIG_UCC_GETH) || defined(CONFIG_SERIAL_QE)
+	if (machine_is(twr_p1025)) {
+		struct ccsr_guts __iomem *guts;
+
+		np = of_find_node_by_name(NULL, "global-utilities");
+		if (np) {
+			guts = of_iomap(np, 0);
+			if (!guts)
+				pr_err("twr_p1025: could not map"
+					"global utilities register\n");
+			else {
+			/* P1025 has pins muxed for QE and other functions. To
+			 * enable QE UEC mode, we need to set bit QE0 for UCC1
+			 * in Eth mode, QE0 and QE3 for UCC5 in Eth mode, QE9
+			 * and QE12 for QE MII management signals in PMUXCR
+			 * register.
+			 */
+
+			printk(KERN_INFO "P1025 pinmux configured for QE\n");
+
+			/* Set QE mux bits in PMUXCR */
+			setbits32(&guts->pmuxcr, MPC85xx_PMUXCR_QE(0) |
+					MPC85xx_PMUXCR_QE(3) |
+					MPC85xx_PMUXCR_QE(9) |
+					MPC85xx_PMUXCR_QE(12));
+			iounmap(guts);
+
+#if defined(CONFIG_SERIAL_QE)
+			/* On P1025TWR board, the UCC7 acted as UART port.
+			 * However, The UCC7's CTS pin is low level in default,
+			 * it will impact the transmission in full duplex
+			 * communication. So disable the Flow control pin PA18.
+			 * The UCC7 UART just can use RXD and TXD pins.
+			 */
+			par_io_config_pin(0, 18, 0, 0, 0, 0);
+#endif
+			/* Drive PB29 to CPLD low - CPLD will then change
+			 * muxing from LBC to QE */
+			par_io_config_pin(1, 29, 1, 0, 0, 0);
+			par_io_data_set(1, 29, 0);
+			}
+			of_node_put(np);
+		}
+	}
+#endif
+#endif	/* CONFIG_QUICC_ENGINE */
+
+	printk(KERN_INFO "TWR-P1025 board from Freescale Semiconductor\n");
+}
+
+machine_arch_initcall(twr_p1025, mpc85xx_common_publish_devices);
+
+static int __init twr_p1025_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,TWR-P1025");
+}
+
+define_machine(twr_p1025) {
+	.name			= "TWR-P1025",
+	.probe			= twr_p1025_probe,
+	.setup_arch		= twr_p1025_setup_arch,
+	.init_IRQ		= twr_p1025_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.8.0
