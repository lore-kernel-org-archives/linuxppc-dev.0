Return-Path: <vooon341@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F117AB6FDA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Mar 2011 22:35:47 +1100 (EST)
Received: by iym7 with SMTP id 7so4052083iym.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Mar 2011 04:35:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110317212542.GB29231@pengutronix.de>
References: <1300318163.12970.66.camel@desinto>
	<20110317212542.GB29231@pengutronix.de>
From: "vooon341@gmail.com" <vooon341@gmail.com>
Date: Fri, 18 Mar 2011 14:35:24 +0300
Message-ID: <AANLkTimy3Qu=KiPp8mhAiuL=GzqUHuNLTZ3cwmNKkrF7@mail.gmail.com>
Subject: Re: [PATCH 1/4] powerpc/mpc512x: Add initial support for TWR-MPC5125
To: Wolfram Sang <w.sang@pengutronix.de>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram.
I create function for select compat string and give name for registers.

commit fe8895542d537567f43f99af8234e7326451197e
Author: Ermakov Vladimir <ermakov@tecon.ru>
Date:   Thu Mar 17 11:10:49 2011 +0300

    Adds Freescale TWR-MPC5125 device tree and platform code.

    Currently following is supported:
     - NAND
     - FEC1 and FEC2
     - RTC
     - PSC UART

    Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>
    ---
    v2:
     - add PSC compat string selection
     - add ioctl defines

diff --git a/arch/powerpc/boot/dts/mpc5125twr.dts
b/arch/powerpc/boot/dts/mpc5125twr.dts
new file mode 100644
index 0000000..54f568f
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc5125twr.dts
@@ -0,0 +1,394 @@
+/*
+ * STx/Freescale ADS5125 MPC5125 silicon
+ *
+ * Copyright (C) 2009 Freescale Semiconductor Inc. All rights reserved.
+ *
+ * This program is free software; you can redistribute  it and/or modify i=
t
+ * under  the terms of  the GNU General  Public License as published by th=
e
+ * Free Software Foundation;  either version 2 of the  License, or (at you=
r
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model =3D "mpc5125ads";
+	compatible =3D "fsl,mpc5125ads";
+	#address-cells =3D <1>;
+	#size-cells =3D <1>;
+
+	cpus {
+		#address-cells =3D <1>;
+		#size-cells =3D <0>;
+
+		PowerPC,5125@0 {
+			device_type =3D "cpu";
+			reg =3D <0>;
+			d-cache-line-size =3D <0x20>;	// 32 bytes
+			i-cache-line-size =3D <0x20>;	// 32 bytes
+			d-cache-size =3D <0x8000>;	// L1, 32K
+			i-cache-size =3D <0x8000>;	// L1, 32K
+			timebase-frequency =3D <49500000>;// 49.5 MHz (csb/4)
+			bus-frequency =3D <198000000>;	// 198 MHz csb bus
+			clock-frequency =3D <396000000>;	// 396 MHz ppc core
+		};
+	};
+
+	memory {
+		device_type =3D "memory";
+		reg =3D <0x00000000 0x10000000>;	// 256MB at 0
+	};
+
+	sram@30000000 {
+		compatible =3D "fsl,mpc5121-sram";
+		reg =3D <0x30000000 0x08000>;		// 32K at 0x30000000
+	};
+
+	nfc@40000000 {
+		compatible =3D "fsl,mpc5125-nfc";
+		reg =3D <0x40000000 0x100000>;	// 1M at 0x40000000
+		interrupts =3D <6 0x8>;
+		interrupt-parent =3D < &ipic >;
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		bank-width =3D <1>;
+		write-size =3D <4096>;
+		spare-size =3D <128>;
+		chips =3D <1>;
+		// NOTE: partition map different than in BSP
+		nand-spl@0 {
+			label =3D "loader";
+			reg =3D <0x00000000 0x00100000>;
+			read-only;
+		};
+		uboot@100000 {
+			label =3D "uboot";
+			reg =3D <0x00100000 0x00100000>;
+			read-only;
+		};
+		uboot-env@200000 {
+			label =3D "uboot-env";
+			reg =3D <0x00200000 0x00100000>;
+			read-only;
+		};
+		kernel300000 {
+			label =3D "kernel";
+			reg =3D <0x00300000 0x00800000>;
+		};
+		device-tree00000 {
+			label =3D "device-tree";
+			reg =3D <0x00b00000 0x00100000>;
+		};
+		ramboot-rootfs@c00000 {
+			label =3D "ramboot-rootfs";
+			reg =3D <0x00c00000 0x00800000>;
+		};
+		rootfs@1400000 {
+			label =3D "rootfs";
+			reg =3D <0x01400000 0x01400000>;
+		};
+		user@2800000 {
+			label =3D "user";
+			reg =3D <0x02800000 0x01400000>;
+		};
+		SRAM@4200000 {
+			label =3D "SRAM"; // NVRAM emul
+			reg =3D <0x04200000 0x01400000>;
+		};
+		prom@5600000 {
+			label =3D "prom";
+			reg =3D <0x05600000 0x01400000>;
+		};
+		//data@2800000 {
+		//	label =3D "data";
+		//	reg =3D <0x28000000 0xeac00000>;
+		//};
+	};
+
+	soc@80000000 {
+		compatible =3D "fsl,mpc5121-immr";
+		device_type =3D "soc";
+		#address-cells =3D <1>;
+		#size-cells =3D <1>;
+		#interrupt-cells =3D <2>;
+		ranges =3D <0x0 0x80000000 0x400000>;
+		reg =3D <0x80000000 0x400000>;
+		bus-frequency =3D <66000000>;	// 66 MHz ips bus
+
+
+		// IPIC
+		// interrupts cell =3D <intr #, sense>
+		// sense values match linux IORESOURCE_IRQ_* defines:
+		// sense =3D=3D 8: Level, low assertion
+		// sense =3D=3D 2: Edge, high-to-low change
+		//
+		ipic: interrupt-controller@c00 {
+			compatible =3D "fsl,mpc5121-ipic", "fsl,ipic";
+			interrupt-controller;
+			#address-cells =3D <0>;
+			#interrupt-cells =3D <2>;
+			reg =3D <0xc00 0x100>;
+		};
+
+		rtc@a00 {	// Real time clock
+			compatible =3D "fsl,mpc5121-rtc";
+			reg =3D <0xa00 0x100>;
+			interrupts =3D <79 0x8 80 0x8>;
+			interrupt-parent =3D < &ipic >;
+		};
+
+		reset@e00 {	// Reset module
+			compatible =3D "fsl,mpc5121-reset";
+			reg =3D <0xe00 0x100>;
+		};
+
+		clock@f00 {	// Clock control
+			compatible =3D "fsl,mpc5121rev2-clock", "fsl,mpc5121-clock";
+			reg =3D <0xf00 0x100>;
+		};
+
+		pmc@1000{  // Power Management Controller
+			compatible =3D "fsl,mpc5121-pmc";
+			reg =3D <0x1000 0x100>;
+			interrupts =3D <83 0x2>;
+			interrupt-parent =3D < &ipic >;
+		};
+
+		gpio@1100 {
+			compatible =3D "fsl,mpc5125-gpio";
+			cell-index =3D <0>;
+			reg =3D <0x1100 0x080>;
+			interrupts =3D <78 0x8>;
+			interrupt-parent =3D < &ipic >;
+		};
+
+		gpio@1180 {
+			compatible =3D "fsl,mpc5125-gpio1";
+			cell-index =3D <1>;
+			reg =3D <0x1180 0x080>;
+			interrupts =3D <78 0x8>;
+			interrupt-parent =3D < &ipic >;
+		};
+
+		can@1300 { // CAN rev.2
+			compatible =3D "fsl,mpc5121-mscan";
+			cell-index =3D <0>;
+			interrupts =3D <12 0x8>;
+			interrupt-parent =3D < &ipic >;
+			reg =3D <0x1300 0x80>;
+		};
+
+		can@1380 {
+			compatible =3D "fsl,mpc5121-mscan";
+			cell-index =3D <1>;
+			interrupts =3D <13 0x8>;
+			interrupt-parent =3D < &ipic >;
+			reg =3D <0x1380 0x80>;
+		};
+
+		sdhc@1500 {
+			compatible =3D "fsl,mpc5125-sdhc";
+			interrupts =3D <8 0x8>;
+			interrupt-parent =3D < &ipic >;
+			reg =3D <0x1500 0x100>;
+		};
+
+		i2c@1700 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			compatible =3D "fsl-i2c";
+			cell-index =3D <0>;
+			reg =3D <0x1700 0x20>;
+			interrupts =3D <0x9 0x8>;
+			interrupt-parent =3D < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2c@1720 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			compatible =3D "fsl-i2c";
+			cell-index =3D <1>;
+			reg =3D <0x1720 0x20>;
+			interrupts =3D <0xa 0x8>;
+			interrupt-parent =3D < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2c@1740 {
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			compatible =3D "fsl-i2c";
+			cell-index =3D <2>;
+			reg =3D <0x1740 0x20>;
+			interrupts =3D <0xb 0x8>;
+			interrupt-parent =3D < &ipic >;
+			fsl5200-clocking;
+		};
+
+		i2ccontrol@1760 {
+			compatible =3D "fsl,mpc5121-i2c-ctrl";
+			reg =3D <0x1760 0x8>;
+		};
+
+		//diu@2100 {
+		//	device_type =3D "display";
+		//	compatible =3D "fsl-diu";
+		//	reg =3D <0x2100 0x100>;
+		//	interrupts =3D <64 0x8>;
+		//	interrupt-parent =3D < &ipic >;
+		//};
+
+		// MPC5125e has two more CAN ports
+		// but they are not used on ADS5125
+		//can@2300 {
+		//	compatible =3D "fsl,mpc5121-mscan";
+		//	cell-index =3D <2>;
+		//	interrupts =3D <90 0x8>;
+		//	interrupt-parent =3D < &ipic >;
+		//	reg =3D <0x2300 0x80>;
+		//};
+
+		//can@2380 {
+		//	compatible =3D "fsl,mpc5121-mscan";
+		//	cell-index =3D <3>;
+		//	interrupts =3D <91 0x8>;
+		//	interrupt-parent =3D < &ipic >;
+		//	reg =3D <0x2380 0x80>;
+		//};
+
+		mdio@2800 {
+			device_type =3D "mdio";
+			compatible =3D "fsl,mpc5121-fec-mdio";
+			reg =3D <0x2800 0x800>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			phy0: ethernet-phy@0 {
+				reg =3D <1>;
+				device_type =3D "ethernet-phy";
+			};
+		};
+
+		ethernet@2800 {
+			device_type =3D "network";
+			compatible =3D "fsl,mpc5121-fec";
+			reg =3D <0x2800 0x800>;
+			local-mac-address =3D [ 00 00 00 00 00 00 ];
+			interrupts =3D <4 0x8>;
+			interrupt-parent =3D < &ipic >;
+			phy-handle =3D < &phy0 >;
+		};
+
+		// USB ULPI1
+		//usb@3000 {
+		//	device_type =3D "usb";
+		//	compatible =3D "fsl-usb2-dr";
+		//	reg =3D <0x3000 0x400>;
+		//	#address-cells =3D <1>;
+		//	#size-cells =3D <0>;
+		//	interrupt-parent =3D < &ipic >;
+		//	interrupts =3D <43 0x8>;
+		//	dr_mode =3D "host";
+		//	phy_type =3D "ulpi";
+		//	big-endian-regs;
+		//};
+
+		// USB ULPI2
+		//usb@4000 {
+		//	device_type =3D "usb";
+		//	compatible =3D "fsl-usb2-dr";
+		//	reg =3D <0x4000 0x400>;
+		//	#address-cells =3D <1>;
+		//	#size-cells =3D <0>;
+		//	interrupt-parent =3D < &ipic >;
+		//	interrupts =3D <44 0x8>;
+		//	dr_mode =3D "otg";
+		//	phy_type =3D "ulpi";
+		//	big-endian-regs;
+		//};
+
+		mdio@4800 {
+			device_type =3D "mdio";
+			compatible =3D "fsl,mpc5121-fec-mdio";
+			reg =3D <0x4800 0x800>;
+			#address-cells =3D <1>;
+			#size-cells =3D <0>;
+			phy1: ethernet-phy@0 {
+				reg =3D <1>;
+				device_type =3D "ethernet-phy";
+			};
+		};
+
+		ethernet@4800 {
+			device_type =3D "network";
+			compatible =3D "fsl,mpc5121-fec";
+			reg =3D <0x4800 0x800>;
+			local-mac-address =3D [ 00 00 00 00 00 00 ];
+			interrupts =3D <5 0x8>;
+			interrupt-parent =3D < &ipic >;
+			phy-handle =3D < &phy1 >;
+		};
+
+		// IO control
+		ioctl@a000 {
+			compatible =3D "fsl,mpc5125-ioctl";
+			reg =3D <0xA000 0x1000>;
+		};
+
+		// PSC0 in ac97 mode
+		//ac97@11000 {
+		//	device_type =3D "sound";
+		//	compatible =3D "fsl,mpc5125-psc-ac97", "fsl,mpc5125-psc";
+		//	cell-index =3D <0>;
+		//	reg =3D <0x11000 0x100>;
+		//	interrupts =3D <40 0x8>;
+		//	interrupt-parent =3D < &ipic >;
+		//	fsl,mode =3D "ac97-slave";
+		//	rx-fifo-size =3D <384>;
+		//	tx-fifo-size =3D <384>;
+		//};
+
+		// 5125 PSCs are not 52xx or 5121 PSC compatible
+		// PSC1 uart0 aka ttyPSC0
+		serial@11100 {
+			device_type =3D "serial";
+			compatible =3D "fsl,mpc5125-psc-uart", "fsl,mpc5125-psc";
+			port-number =3D <0>;
+			cell-index =3D <1>;
+			reg =3D <0x11100 0x100>;
+			interrupts =3D <40 0x8 71 0x8>;
+			interrupt-parent =3D < &ipic >;
+			fsl,rx-fifo-size =3D <16>;
+			fsl,tx-fifo-size =3D <16>;
+			nodcd;
+		};
+
+		// PSC9 uart1 aka ttyPSC1
+		serial@11900 {
+			device_type =3D "serial";
+			compatible =3D "fsl,mpc5125-psc-uart", "fsl,mpc5125-psc";
+			port-number =3D <1>;
+			cell-index =3D <9>;
+			reg =3D <0x11900 0x100>;
+			interrupts =3D <40 0x8 32 0x8>;
+			interrupt-parent =3D < &ipic >;
+			fsl,rx-fifo-size =3D <16>;
+			fsl,tx-fifo-size =3D <16>;
+			nodcd;
+		};
+
+		pscfifo@11f00 {
+			compatible =3D "fsl,mpc5121-psc-fifo";
+			reg =3D <0x11f00 0x100>;
+			interrupts =3D <40 0x8>;
+			interrupt-parent =3D < &ipic >;
+		};
+
+		dma@14000 {
+			compatible =3D "fsl,mpc5121-dma"; // old name: "mpc512x-dma2"
+			reg =3D <0x14000 0x1800>;
+			interrupts =3D <65 0x8>;
+			interrupt-parent =3D < &ipic >;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/512x/Kconfig
b/arch/powerpc/platforms/512x/Kconfig
index 27b0651..0dde4b0 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -26,6 +26,20 @@ config MPC5121_GENERIC
 	  Compatible boards include:  Protonic LVT base boards (ZANMCU
 	  and VICVT2).

+config PPC_MPC5125
+	bool "Generic support for MPC5125 based boards"
+	depends on PPC_MPC512x
+	select DEFAULT_UIMAGE
+	select PPC_INDIRECT_PCI
+	default n
+
+config MPC5125_TWR
+	bool "Freescale MPC5125 Tower system"
+	depends on PPC_MPC512x
+	select PPC_MPC5125
+	help
+	  This option enables support for the MPC5125 TWR board.
+
 config PDM360NG
 	bool "ifm PDM360NG board"
 	depends on PPC_MPC512x
diff --git a/arch/powerpc/platforms/512x/Makefile
b/arch/powerpc/platforms/512x/Makefile
index 4efc1c4..5c17561 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -5,3 +5,4 @@ obj-y				+=3D clock.o mpc512x_shared.o
 obj-$(CONFIG_MPC5121_ADS)	+=3D mpc5121_ads.o mpc5121_ads_cpld.o
 obj-$(CONFIG_MPC5121_GENERIC)	+=3D mpc5121_generic.o
 obj-$(CONFIG_PDM360NG)		+=3D pdm360ng.o
+obj-$(CONFIG_MPC5125_TWR)	+=3D mpc5125_twr.o
diff --git a/arch/powerpc/platforms/512x/clock.c
b/arch/powerpc/platforms/512x/clock.c
index 3dc2a8d..5cadf8e 100644
--- a/arch/powerpc/platforms/512x/clock.c
+++ b/arch/powerpc/platforms/512x/clock.c
@@ -606,6 +606,21 @@ static void rate_clks_init(void)
  */
 struct clk dev_clks[2][32];

+char *mpc512x_select_psc_compat(void)
+{
+	char *psc_compats[] =3D {
+		"fsl,mpc5121-psc",
+		"fsl,mpc5125-psc"
+	};
+	int i;
+
+	for (i =3D 0; i < ARRAY_SIZE(psc_compats); i++)
+		if (of_find_compatible_node(NULL, NULL, psc_compats[i]))
+			return psc_compats[i];
+
+	return NULL;
+}
+
 /*
  * Given a psc number return the dev_clk
  * associated with it
@@ -679,8 +694,13 @@ static void psc_clks_init(void)
 	struct device_node *np;
 	const u32 *cell_index;
 	struct platform_device *ofdev;
+	char *psc_compat;
+
+	psc_compat =3D mpc512x_select_psc_compat();
+	if (!psc_compat)
+		return;

-	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
+	for_each_compatible_node(np, NULL, psc_compat) {
 		cell_index =3D of_get_property(np, "cell-index", NULL);
 		if (cell_index) {
 			int pscnum =3D *cell_index;
diff --git a/arch/powerpc/platforms/512x/mpc5125_twr.c
b/arch/powerpc/platforms/512x/mpc5125_twr.c
new file mode 100644
index 0000000..b4f931f
--- /dev/null
+++ b/arch/powerpc/platforms/512x/mpc5125_twr.c
@@ -0,0 +1,182 @@
+/*
+ * Copyright (C) 2010 LimePC Multimedia Technologies Co., Limited
+ * Copyright (C) 2011 Vladimir Ermakov <vooon341@gmail.com>
+ *
+ * Based on original Freescale Semiconductor BSP
+ * written by Cloudy Chen <chen_yunsong@mtcera.com>
+ *
+ * MPC5125 Tower board setup
+ *
+ * This is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+
+#include <sysdev/fsl_soc.h>
+
+#include <linux/bootmem.h>
+#include <asm/rheap.h>
+
+#include "mpc512x.h"
+
+// IOCTL registers for USB1/FEC2
+#define IOCTL_USB1_DATA0	0x63
+#define IOCTL_USB1_DATA1	0x64
+#define IOCTL_USB1_DATA2	0x65
+#define IOCTL_USB1_DATA3	0x66
+#define IOCTL_USB1_DATA4	0x67
+#define IOCTL_USB1_DATA5	0x68
+#define IOCTL_USB1_DATA6	0x69
+#define IOCTL_USB1_DATA7	0x6A
+#define IOCTL_USB1_STOP		0x6B
+#define IOCTL_USB1_CLK		0x6C
+#define IOCTL_USB1_NEXT		0x6D
+#define IOCTL_USB1_DIR		0x6E
+
+// IOCTL for PSCx
+#define PSC_TO_IOCTL_OFFSET(psc)	(0x76 + 5 * psc)
+#define IOCTL_PSCx_0		0
+#define IOCTL_PSCx_1		1
+#define IOCTL_PSCx_2		2
+#define IOCTL_PSCx_3		3
+#define IOCTL_PSCx_4		4
+
+// MODES
+#define IOCTL_DEFAULT_MODE	0x03 // FUNCMUX=3D0, PUD=3D0, PUE=3D0, DS=3D3
+#define IOCTL_FEC2_MODE		0x43 // FUNCMUX=3D2, PUD=3D0, PUE=3D0, DS=3D3
+#define IOCTL_PSCx_0_MODE	0x07 // FUNCMUX=3D0, PUD=3D0, PUE=3D0, ST=3D1, D=
S=3D3
+
+static void mpc5125_psc_iopad_init(void __iomem *ioctl, char *name)
+{
+	struct device_node *np;
+	const u32 *cell_index;
+	char *default_psc =3D "fsl,mpc5125-psc";
+	char *psc_name;
+
+	if (name)
+		psc_name =3D name;
+	else
+		psc_name =3D default_psc;
+
+	for_each_compatible_node(np, NULL, psc_name) {
+		cell_index =3D of_get_property(np, "cell-index", NULL);
+		if (cell_index) {
+			u8 __iomem *pscioctl;
+			int psc_num =3D *cell_index;
+			if (psc_num > 1)
+				continue;
+
+			pscioctl =3D ioctl + PSC_TO_IOCTL_OFFSET(psc_num);
+			out_8(pscioctl + IOCTL_PSCx_0, IOCTL_PSCx_0_MODE); // NOTE maybe wrong
+			out_8(pscioctl + IOCTL_PSCx_1, IOCTL_DEFAULT_MODE);
+			out_8(pscioctl + IOCTL_PSCx_2, IOCTL_DEFAULT_MODE);
+			out_8(pscioctl + IOCTL_PSCx_3, IOCTL_DEFAULT_MODE);
+			out_8(pscioctl + IOCTL_PSCx_4, IOCTL_DEFAULT_MODE);
+		}
+	}
+}
+
+static void mpc5125_fec2_usb_io_init(void __iomem *ioctl, int isusb)
+{
+	int i;
+	const u8 offset[12] =3D {
+		IOCTL_USB1_DATA0, IOCTL_USB1_DATA1,
+		IOCTL_USB1_DATA2, IOCTL_USB1_DATA3,
+		IOCTL_USB1_DATA4, IOCTL_USB1_DATA5,
+		IOCTL_USB1_DATA6, IOCTL_USB1_DATA7,
+		IOCTL_USB1_STOP, IOCTL_USB1_CLK,
+		IOCTL_USB1_NEXT, IOCTL_USB1_DIR
+	};
+	u8 mode;
+
+	mode =3D (isusb) ? IOCTL_DEFAULT_MODE : IOCTL_FEC2_MODE;
+	for (i =3D 0; i < ARRAY_SIZE(offset); i++)
+		out_8(ioctl + offset[i], mode);
+}
+
+static void __init mpc5125_board_setup(void)
+{
+	struct device_node *np;
+
+	/*
+	 * io pad config
+	 */
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5125-ioctl");
+	if (np) {
+		void __iomem *ioctl =3D of_iomap(np, 0);
+
+		mpc5125_psc_iopad_init(ioctl, NULL);
+		mpc5125_fec2_usb_io_init(ioctl, 0);
+
+		of_node_put(np);
+		iounmap(ioctl);
+	}
+}
+
+static void __init mpc5125_ads_setup_arch(void)
+{
+	printk(KERN_INFO "MPC5125 ADS board from Freescale Semiconductor\n");
+
+	mpc5125_board_setup();
+}
+
+static struct of_device_id __initdata of_bus_ids[] =3D {
+	{ .name =3D "soc", },
+	{},
+};
+
+static void __init mpc5125_ads_declare_of_platform_devices(void)
+{
+	struct device_node *np;
+
+	if (of_platform_bus_probe(NULL, of_bus_ids, NULL))
+		printk(KERN_ERR __FILE__ ": "
+			"Error while probing of_platform bus\n");
+
+	np =3D of_find_compatible_node(NULL, NULL, "fsl,mpc5125-nfc");
+	if (np) {
+		of_platform_device_create(np, NULL, NULL);
+		of_node_put(np);
+	}
+}
+
+static void __init mpc5125_ads_init(void)
+{
+	mpc5125_ads_declare_of_platform_devices();
+	mpc5121_clk_init();
+	mpc512x_restart_init();
+	mpc512x_psc_fifo_init();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init mpc5125_ads_probe(void)
+{
+	unsigned long root =3D of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,mpc5125ads");
+}
+
+define_machine(mpc5125_ads) {
+	.name			=3D "MPC5125 ADS",
+	.probe			=3D mpc5125_ads_probe,
+	.setup_arch		=3D mpc5125_ads_setup_arch,
+	.init			=3D mpc5125_ads_init,
+	.init_IRQ		=3D mpc512x_init_IRQ,
+	.get_irq		=3D ipic_get_irq,
+	.calibrate_decr		=3D generic_calibrate_decr,
+	.restart		=3D mpc512x_restart,
+};
diff --git a/arch/powerpc/platforms/512x/mpc512x.h
b/arch/powerpc/platforms/512x/mpc512x.h
index 1ab6d11..91c903f 100644
--- a/arch/powerpc/platforms/512x/mpc512x.h
+++ b/arch/powerpc/platforms/512x/mpc512x.h
@@ -13,8 +13,11 @@
 #define __MPC512X_H__
 extern void __init mpc512x_init_IRQ(void);
 extern void __init mpc512x_init(void);
+extern void __init mpc512x_restart_init(void);
 extern int __init mpc5121_clk_init(void);
-void __init mpc512x_declare_of_platform_devices(void);
+extern void __init mpc512x_declare_of_platform_devices(void);
+extern void __init mpc512x_psc_fifo_init(void);
+extern char *mpc512x_select_psc_compat(void);
 extern void mpc512x_restart(char *cmd);
 extern void mpc512x_init_diu(void);
 extern void mpc512x_setup_diu(void);
diff --git a/arch/powerpc/platforms/512x/mpc512x_shared.c
b/arch/powerpc/platforms/512x/mpc512x_shared.c
index e41ebbd..52283d6 100644
--- a/arch/powerpc/platforms/512x/mpc512x_shared.c
+++ b/arch/powerpc/platforms/512x/mpc512x_shared.c
@@ -32,7 +32,7 @@

 static struct mpc512x_reset_module __iomem *reset_module_base;

-static void __init mpc512x_restart_init(void)
+void __init mpc512x_restart_init(void)
 {
 	struct device_node *np;

@@ -407,9 +407,16 @@ void __init mpc512x_psc_fifo_init(void)
 	void __iomem *psc;
 	unsigned int tx_fifo_size;
 	unsigned int rx_fifo_size;
+	char *psc_compat;
 	int fifobase =3D 0; /* current fifo address in 32 bit words */

-	for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
+	psc_compat =3D mpc512x_select_psc_compat();
+	if (!psc_compat) {
+		pr_err("%s: no compatible devices found\n", __func__);
+		return;
+	}
+
+	for_each_compatible_node(np, NULL, psc_compat) {
 		tx_fifo_size =3D get_fifo_size(np, "fsl,tx-fifo-size");
 		rx_fifo_size =3D get_fifo_size(np, "fsl,rx-fifo-size");


2011/3/18 Wolfram Sang <w.sang@pengutronix.de>
>
> Hi Vladimir,
>
> (if possible, please provide a diffstat with the patches)
>
> > diff --git a/arch/powerpc/platforms/512x/clock.c b/arch/powerpc/platfor=
ms/512x/clock.c
> > index 3dc2a8d..962c0ba 100644
> > --- a/arch/powerpc/platforms/512x/clock.c
> > +++ b/arch/powerpc/platforms/512x/clock.c
> > @@ -669,6 +669,13 @@ static void psc_calc_rate(struct clk *clk, int psc=
num, struct device_node *np)
> > =C2=A0 =C2=A0 =C2=A0 clk->rate =3D mclk_src / mclk_div;
> > =C2=A0}
> >
> > +
> > +#ifdef CONFIG_PPC_MPC5125
> > +#define PSC_PREFIX "mpc5125"
> > +#else
> > +#define PSC_PREFIX "mpc5121"
> > +#endif
> > +
> > =C2=A0/*
> > =C2=A0 * Find all psc nodes in device tree and assign a clock
> > =C2=A0 * with name "psc%d_mclk" and dev pointing at the device
> > @@ -680,7 +687,7 @@ static void psc_clks_init(void)
> > =C2=A0 =C2=A0 =C2=A0 const u32 *cell_index;
> > =C2=A0 =C2=A0 =C2=A0 struct platform_device *ofdev;
> >
> > - =C2=A0 =C2=A0 for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
> > + =C2=A0 =C2=A0 for_each_compatible_node(np, NULL, "fsl," PSC_PREFIX "-=
psc") {
>
> Uh, that makes it impossible to have one kernel for mpc5121/5.
>
> > -void __init mpc512x_psc_fifo_init(void)
> > +void __init mpc512x_psc_fifo_init(char *psc_name)
> > =C2=A0{
> > =C2=A0 =C2=A0 =C2=A0 struct device_node *np;
> > =C2=A0 =C2=A0 =C2=A0 void __iomem *psc;
> > =C2=A0 =C2=A0 =C2=A0 unsigned int tx_fifo_size;
> > =C2=A0 =C2=A0 =C2=A0 unsigned int rx_fifo_size;
> > + =C2=A0 =C2=A0 char *default_psc =3D "fsl,mpc5121-psc";
> > =C2=A0 =C2=A0 =C2=A0 int fifobase =3D 0; /* current fifo address in 32 =
bit words */
> >
> > - =C2=A0 =C2=A0 for_each_compatible_node(np, NULL, "fsl,mpc5121-psc") {
> > + =C2=A0 =C2=A0 if (!psc_name)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 psc_name =3D default_psc;
> > +
> > + =C2=A0 =C2=A0 for_each_compatible_node(np, NULL, psc_name) {
>
> I think this goes more to the right direction, although you passed the
> non-default string for mpc5125 in the board-config, which is the wrong pl=
ace,
> because it is a platform thing.
>
> What about something like:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if of_find_compatible_node(startpoint, NULL, "=
fsl,mpc5121-psc")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0psc_compat =3D "fs=
l,mpc5121-psc";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if of_find_compatible_node(startpoint, NU=
LL, "fsl,mpc5125-psc")
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0psc_compat =3D "fs=
l,mpc5125-psc";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else if
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Problem handlin=
g */
>
> Dunno, might be worth to put it into a function as it could be used here =
and in
> the block above.
>
> Also, I noticed quite a number of magic values (e.g. 0x76). I guess those=
 are
> register and bit names, which should be used instead.
>
> Thanks,
>
> =C2=A0 Wolfram
>
> --
> Pengutronix e.K. =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Wolfram Sang =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|
> Industrial Linux Solutions =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 | http://www.pengutronix.de/ =C2=A0|
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.9 (GNU/Linux)
>
> iEYEARECAAYFAk2CfFYACgkQD27XaX1/VRsmcwCfdqwIn6V6VDwm7wZXm1PDHXmx
> 0mcAnirFHcCmZ4TqqNXbXfOOWsDPFauA
> =3DU2sn
> -----END PGP SIGNATURE-----
>
