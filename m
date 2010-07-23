Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 324E81007D2
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 23:49:48 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/2] powerpc/mpc5121: add initial support for PDM360NG board
Date: Fri, 23 Jul 2010 15:49:33 +0200
Message-Id: <1279892973-24110-1-git-send-email-agust@denx.de>
In-Reply-To: <1272882222-12253-1-git-send-email-agust@denx.de>
References: <1272882222-12253-1-git-send-email-agust@denx.de>
Cc: Detlev Zundel <dzu@denx.de>, Markus Fischer <markus.fischer.ec@ifm.com>,
	devicetree-discuss@lists.ozlabs.org, Michael Weiss <michael.weiss@ifm.com>,
	Anatolij Gustschin <agust@denx.de>, Wolfgang Grandegger <wg@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds IFM PDM360NG device tree, and platform code.

Currently following is supported:
 - Spansion S29GL512P 256 MB NOR flash
 - ST Micro NAND 1 GiB flash
 - DIU, please use "fbcon=map:5 video=fslfb:800x480-32@60"
   at the kernel command line to enable PrimeView PM070WL3
   Display support.
 - FEC
 - I2C
 - RTC, EEPROM
 - MSCAN
 - PSC UART, please pass "console=tty0 console=ttyPSC5,115200"
   on the kernel command line.
 - SPI, ADS7845 Touchscreen
 - USB0/1 Host
 - USB0 OTG Host/Device
 - VIU, Overlay/Capture support

Signed-off-by: Markus Fischer <markus.fischer.ec@ifm.com>
Signed-off-by: Wolfgang Grandegger <wg@denx.de>
Signed-off-by: Michael Weiss <michael.weiss@ifm.com>
Signed-off-by: Detlev Zundel <dzu@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: devicetree-discuss@lists.ozlabs.org
Cc: Grant Likely <grant.likely@secretlab.ca>
---
v3:
 - uncomment and correct .irq_flags field of touchscreen
   platform data struct as proposed extension to this
   data struct has been accepted and merged via input tree
   a short while ago

v1 -> v2:
 - fix interrupt-parent property in nfc node
 - drop #address-cells in ipic node
 - remove device_type from ethernet-phy sub-node
 - remove device_type from ethernet node
 - add aliases node for eth0, needed for MAC address
   update by U-Boot
 - removed spaces around &ipic

 arch/powerpc/boot/dts/pdm360ng.dts     |  432 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/512x/Kconfig    |    7 +
 arch/powerpc/platforms/512x/Makefile   |    1 +
 arch/powerpc/platforms/512x/pdm360ng.c |  158 ++++++++++++
 4 files changed, 598 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/pdm360ng.dts
 create mode 100644 arch/powerpc/platforms/512x/pdm360ng.c

diff --git a/arch/powerpc/boot/dts/pdm360ng.dts b/arch/powerpc/boot/dts/pdm360ng.dts
new file mode 100644
index 0000000..7dc42e9
--- /dev/null
+++ b/arch/powerpc/boot/dts/pdm360ng.dts
@@ -0,0 +1,432 @@
+/*
+ * Device Tree Source for IFM PDM360NG.
+ *
+ * Copyright 2009 - 2010 DENX Software Engineering.
+ * Anatolij Gustschin <agust@denx.de>
+ *
+ * Based on MPC5121E ADS dts.
+ * Copyright 2008 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "pdm360ng";
+	compatible = "ifm,pdm360ng";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		ethernet0 = &eth0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,5121@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <0x20>;	// 32 bytes
+			i-cache-line-size = <0x20>;	// 32 bytes
+			d-cache-size = <0x8000>;	// L1, 32K
+			i-cache-size = <0x8000>;	// L1, 32K
+			timebase-frequency = <49500000>;// 49.5 MHz (csb/4)
+			bus-frequency = <198000000>;	// 198 MHz csb bus
+			clock-frequency = <396000000>;	// 396 MHz ppc core
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;	// 512MB at 0
+	};
+
+	nfc@40000000 {
+		compatible = "fsl,mpc5121-nfc";
+		reg = <0x40000000 0x100000>;
+		interrupts = <0x6 0x8>;
+		interrupt-parent = <&ipic>;
+		#address-cells = <0x1>;
+		#size-cells = <0x1>;
+		bank-width = <0x1>;
+		chips = <0x1>;
+
+		partition@0 {
+			label = "nand0";
+			reg = <0x0 0x40000000>;
+		};
+	};
+
+	sram@50000000 {
+		compatible = "fsl,mpc5121-sram";
+		reg = <0x50000000 0x20000>;	// 128K at 0x50000000
+	};
+
+	localbus@80000020 {
+		compatible = "fsl,mpc5121-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0x80000020 0x40>;
+
+		ranges = <0x0 0x0 0xf0000000 0x10000000   /* Flash */
+			  0x2 0x0 0x50040000 0x00020000>; /* CS2: MRAM */
+
+		flash@0,0 {
+			compatible = "amd,s29gl01gp", "cfi-flash";
+			reg = <0 0x00000000 0x08000000
+			       0 0x08000000 0x08000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			bank-width = <4>;
+			device-width = <2>;
+
+			partition@0 {
+				label = "u-boot";
+				reg = <0x00000000 0x00080000>;
+				read-only;
+			};
+			partition@80000 {
+				label = "environment";
+				reg = <0x00080000 0x00080000>;
+				read-only;
+			};
+			partition@100000 {
+				label = "splash-image";
+				reg = <0x00100000 0x00080000>;
+				read-only;
+			};
+			partition@180000 {
+				label = "device-tree";
+				reg = <0x00180000 0x00040000>;
+			};
+			partition@1c0000 {
+				label = "kernel";
+				reg = <0x001c0000 0x00500000>;
+			};
+			partition@6c0000 {
+				label = "filesystem";
+				reg = <0x006c0000 0x07940000>;
+			};
+		};
+
+		mram0@2,0 {
+			compatible = "mtd-ram";
+			reg = <2 0x00000 0x10000>;
+			bank-width = <2>;
+		};
+
+		mram1@2,10000 {
+			compatible = "mtd-ram";
+			reg = <2 0x010000 0x10000>;
+			bank-width = <2>;
+		};
+	};
+
+	soc@80000000 {
+		compatible = "fsl,mpc5121-immr";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		ranges = <0x0 0x80000000 0x400000>;
+		reg = <0x80000000 0x400000>;
+		bus-frequency = <66000000>;	// 66 MHz ips bus
+
+		// IPIC
+		// interrupts cell = <intr #, sense>
+		// sense values match linux IORESOURCE_IRQ_* defines:
+		// sense == 8: Level, low assertion
+		// sense == 2: Edge, high-to-low change
+		//
+		ipic: interrupt-controller@c00 {
+			compatible = "fsl,mpc5121-ipic", "fsl,ipic";
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0xc00 0x100>;
+		};
+
+		rtc@a00 {	// Real time clock
+			compatible = "fsl,mpc5121-rtc";
+			reg = <0xa00 0x100>;
+			interrupts = <79 0x8 80 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		reset@e00 {	// Reset module
+			compatible = "fsl,mpc5121-reset";
+			reg = <0xe00 0x100>;
+		};
+
+		clock@f00 {	// Clock control
+			compatible = "fsl,mpc5121-clock";
+			reg = <0xf00 0x100>;
+		};
+
+		pmc@1000{	//Power Management Controller
+			compatible = "fsl,mpc5121-pmc";
+			reg = <0x1000 0x100>;
+			interrupts = <83 0x2>;
+			interrupt-parent = <&ipic>;
+		};
+
+		gpio@1100 {
+			compatible = "fsl,mpc5121-gpio";
+			reg = <0x1100 0x100>;
+			interrupts = <78 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		can@1300 {
+			compatible = "fsl,mpc5121-mscan";
+			interrupts = <12 0x8>;
+			interrupt-parent = <&ipic>;
+			reg = <0x1300 0x80>;
+		};
+
+		can@1380 {
+			compatible = "fsl,mpc5121-mscan";
+			interrupts = <13 0x8>;
+			interrupt-parent = <&ipic>;
+			reg = <0x1380 0x80>;
+		};
+
+		i2c@1700 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c";
+			reg = <0x1700 0x20>;
+			interrupts = <0x9 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,preserve-clocking;
+
+			eeprom@50 {
+				compatible = "at,24c01";
+				reg = <0x50>;
+			};
+
+			rtc@68 {
+				compatible = "stm,m41t00";
+				reg = <0x68>;
+			};
+		};
+
+		i2c@1740 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5121-i2c";
+			reg = <0x1740 0x20>;
+			interrupts = <0xb 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,preserve-clocking;
+		};
+
+		i2ccontrol@1760 {
+			compatible = "fsl,mpc5121-i2c-ctrl";
+			reg = <0x1760 0x8>;
+		};
+
+		axe@2000 {
+			compatible = "fsl,mpc5121-axe";
+			reg = <0x2000 0x100>;
+			interrupts = <42 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		display@2100 {
+			compatible = "fsl,mpc5121-diu";
+			reg = <0x2100 0x100>;
+			interrupts = <64 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		can@2300 {
+			compatible = "fsl,mpc5121-mscan";
+			interrupts = <90 0x8>;
+			interrupt-parent = <&ipic>;
+			reg = <0x2300 0x80>;
+		};
+
+		can@2380 {
+			compatible = "fsl,mpc5121-mscan";
+			interrupts = <91 0x8>;
+			interrupt-parent = <&ipic>;
+			reg = <0x2380 0x80>;
+		};
+
+		viu@2400 {
+			compatible = "fsl,mpc5121-viu";
+			reg = <0x2400 0x400>;
+			interrupts = <67 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		mdio@2800 {
+			compatible = "fsl,mpc5121-fec-mdio";
+			reg = <0x2800 0x200>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy: ethernet-phy@0 {
+				reg = <0x1f>;
+			};
+		};
+
+		eth0: ethernet@2800 {
+			compatible = "fsl,mpc5121-fec";
+			reg = <0x2800 0x200>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <4 0x8>;
+			interrupt-parent = <&ipic>;
+			phy-handle = < &phy >;
+		};
+
+		// USB1 using external ULPI PHY
+		usb@3000 {
+			compatible = "fsl,mpc5121-usb2-dr";
+			reg = <0x3000 0x600>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&ipic>;
+			interrupts = <43 0x8>;
+			dr_mode = "host";
+			phy_type = "ulpi";
+		};
+
+		// USB0 using internal UTMI PHY
+		usb@4000 {
+			compatible = "fsl,mpc5121-usb2-dr";
+			reg = <0x4000 0x600>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupt-parent = <&ipic>;
+			interrupts = <44 0x8>;
+			dr_mode = "otg";
+			phy_type = "utmi_wide";
+			fsl,invert-pwr-fault;
+		};
+
+		// IO control
+		ioctl@a000 {
+			compatible = "fsl,mpc5121-ioctl";
+			reg = <0xA000 0x1000>;
+		};
+
+		// 512x PSCs are not 52xx PSCs compatible
+		serial@11000 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			cell-index = <0>;
+			reg = <0x11000 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		serial@11100 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			cell-index = <1>;
+			reg = <0x11100 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		serial@11200 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			cell-index = <2>;
+			reg = <0x11200 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		serial@11300 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			cell-index = <3>;
+			reg = <0x11300 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		serial@11400 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			cell-index = <4>;
+			reg = <0x11400 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		serial@11600 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			cell-index = <6>;
+			reg = <0x11600 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		serial@11800 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			cell-index = <8>;
+			reg = <0x11800 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		serial@11B00 {
+			compatible = "fsl,mpc5121-psc-uart", "fsl,mpc5121-psc";
+			cell-index = <11>;
+			reg = <0x11B00 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+		};
+
+		pscfifo@11f00 {
+			compatible = "fsl,mpc5121-psc-fifo";
+			reg = <0x11f00 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+
+		spi@11900 {
+			compatible = "fsl,mpc5121-psc-spi", "fsl,mpc5121-psc";
+			cell-index = <9>;
+			reg = <0x11900 0x100>;
+			interrupts = <40 0x8>;
+			interrupt-parent = <&ipic>;
+			fsl,rx-fifo-size = <16>;
+			fsl,tx-fifo-size = <16>;
+
+			// 7845 touch screen controller
+			ts@0 {
+				compatible = "ti,ads7845";
+				interrupt-parent = <&ipic>;
+				// pen irq is GPIO25
+				interrupts = <78 0x8>;
+			};
+		};
+
+		dma@14000 {
+			compatible = "fsl,mpc5121-dma";
+			reg = <0x14000 0x1800>;
+			interrupts = <65 0x8>;
+			interrupt-parent = <&ipic>;
+		};
+	};
+};
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index e9dca28..27b0651 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -25,3 +25,10 @@ config MPC5121_GENERIC
 
 	  Compatible boards include:  Protonic LVT base boards (ZANMCU
 	  and VICVT2).
+
+config PDM360NG
+	bool "ifm PDM360NG board"
+	depends on PPC_MPC512x
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the PDM360NG board.
diff --git a/arch/powerpc/platforms/512x/Makefile b/arch/powerpc/platforms/512x/Makefile
index 90be2f5..4efc1c4 100644
--- a/arch/powerpc/platforms/512x/Makefile
+++ b/arch/powerpc/platforms/512x/Makefile
@@ -4,3 +4,4 @@
 obj-y				+= clock.o mpc512x_shared.o
 obj-$(CONFIG_MPC5121_ADS)	+= mpc5121_ads.o mpc5121_ads_cpld.o
 obj-$(CONFIG_MPC5121_GENERIC)	+= mpc5121_generic.o
+obj-$(CONFIG_PDM360NG)		+= pdm360ng.o
diff --git a/arch/powerpc/platforms/512x/pdm360ng.c b/arch/powerpc/platforms/512x/pdm360ng.c
new file mode 100644
index 0000000..01e6023
--- /dev/null
+++ b/arch/powerpc/platforms/512x/pdm360ng.c
@@ -0,0 +1,158 @@
+/*
+ * Copyright (C) 2010 DENX Software Engineering
+ *
+ * Anatolij Gustschin, <agust@denx.de>
+ *
+ * PDM360NG board setup
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
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/ipic.h>
+#include <asm/prom.h>
+
+#include "mpc512x.h"
+
+#if defined(CONFIG_TOUCHSCREEN_ADS7846) || \
+    defined(CONFIG_TOUCHSCREEN_ADS7846_MODULE)
+#include <linux/fsl_devices.h>
+#include <linux/interrupt.h>
+#include <linux/spi/ads7846.h>
+#include <linux/spi/spi.h>
+
+static void *pdm360ng_gpio_base;
+
+static int pdm360ng_get_pendown_state(void)
+{
+	u32 reg;
+
+	reg = in_be32((u32 *)(pdm360ng_gpio_base + 0xc));
+	if (reg & 0x40)
+		setbits32((u32 *)(pdm360ng_gpio_base + 0xc), 0x40);
+
+	reg = in_be32((u32 *)(pdm360ng_gpio_base + 0x8));
+
+	/* return 1 if pen is down */
+	return reg & 0x40 ? 0 : 1;
+}
+
+static struct ads7846_platform_data pdm360ng_ads7846_pdata __initdata = {
+	.model			= 7845,
+	.get_pendown_state	= pdm360ng_get_pendown_state,
+	.irq_flags		= IRQF_TRIGGER_LOW,
+};
+
+static int __init pdm360ng_penirq_init(void)
+{
+	struct device_node *np;
+	struct resource r;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,mpc5121-gpio");
+	if (!np) {
+		pr_err("%s: Can't find 'mpc5121-gpio' node\n", __func__);
+		return -1;
+	}
+
+	if (of_address_to_resource(np, 0, &r)) {
+		pr_err("%s: Invalid gpio address.\n", __func__);
+		of_node_put(np);
+		return -1;
+	}
+	of_node_put(np);
+
+	pdm360ng_gpio_base = ioremap(r.start, resource_size(&r));
+	if (!pdm360ng_gpio_base) {
+		pr_err("%s: Can't map gpio regs.\n", __func__);
+		return -1;
+	}
+	out_be32((u32 *)pdm360ng_gpio_base + 0xc, 0xffffffff);
+	setbits32((u32 *)(pdm360ng_gpio_base + 0x18), 0x2000);
+	setbits32((u32 *)(pdm360ng_gpio_base + 0x10), 0x40);
+
+	return 0;
+}
+
+static int __init pdm360ng_touchscreen_init(void)
+{
+	struct device_node *np;
+	struct of_device *of_dev;
+	struct spi_board_info info;
+	const u32 *prop;
+	int bus_num = -1;
+	int len;
+
+	np = of_find_compatible_node(NULL, NULL, "ti,ads7845");
+	if (!np)
+		return -ENODEV;
+
+	memset(&info, 0, sizeof(info));
+	info.irq = irq_of_parse_and_map(np, 0);
+	if (info.irq == NO_IRQ)
+		return -ENODEV;
+
+	info.platform_data = &pdm360ng_ads7846_pdata;
+	if (strlcpy(info.modalias, "ads7846",
+		    SPI_NAME_SIZE) >= SPI_NAME_SIZE)
+		return -ENOMEM;
+
+	np = of_get_next_parent(np);
+	if (!np)
+		return -ENODEV;
+
+	prop = of_get_property(np, "cell-index", &len);
+	if (prop && len == 4)
+		bus_num = *prop;
+
+	if (bus_num < 0 || bus_num > 11)
+		return -ENODEV;
+
+	info.bus_num = bus_num;
+
+	of_dev = of_find_device_by_node(np);
+	of_node_put(np);
+	if (of_dev) {
+		struct fsl_spi_platform_data *pdata;
+
+		pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
+		if (pdata) {
+			pdata->bus_num = bus_num;
+			pdata->max_chipselect = 1;
+			of_dev->dev.platform_data = pdata;
+		}
+	}
+
+	if (pdm360ng_penirq_init())
+		return -ENODEV;
+
+	return spi_register_board_info(&info, 1);
+}
+machine_device_initcall(pdm360ng, pdm360ng_touchscreen_init);
+#endif
+
+static int __init pdm360ng_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "ifm,pdm360ng");
+}
+
+define_machine(pdm360ng) {
+	.name			= "PDM360NG",
+	.probe			= pdm360ng_probe,
+	.setup_arch		= mpc512x_setup_diu,
+	.init			= mpc512x_init,
+	.init_early		= mpc512x_init_diu,
+	.init_IRQ		= mpc512x_init_IRQ,
+	.get_irq		= ipic_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+	.restart		= mpc512x_restart,
+};
-- 
1.7.0.4
