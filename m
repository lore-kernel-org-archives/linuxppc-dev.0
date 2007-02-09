Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id C51C6DDEC5
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 10:28:43 +1100 (EST)
Date: Fri, 9 Feb 2007 17:28:31 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Subject: [PATCH] Add support for the 8568 MDS board
Message-ID: <Pine.LNX.4.61.0702091727290.791@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Signed-off-by: Andrew Fleming <afleming@freescale.com>
---
 arch/powerpc/boot/dts/mpc8568mds.dts      |  380 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig       |   13 +
 arch/powerpc/platforms/85xx/Makefile      |    1 +
 arch/powerpc/platforms/85xx/mpc8568_mds.c |  246 +++++++++++++++++++
 4 files changed, 640 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
new file mode 100644
index 0000000..06d2465
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -0,0 +1,380 @@
+/*
+ * MPC8568E MDS Device Tree Source
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/*
+/memreserve/	00000000 1000000;
+*/
+
+/ {
+	model = "MPC8568EMDS";
+	compatible = "MPC85xxMDS";
+	#address-cells = <1>;
+	#size-cells = <1>;
+	linux,phandle = <100>;
+
+	cpus {
+		#cpus = <1>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		linux,phandle = <200>;
+
+		PowerPC,8568@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			32-bit;
+			linux,phandle = <201>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		reg = <00000000 10000000>;
+	};
+
+	bcsr@f8000000 {
+		device_type = "board-control";
+		reg = <f8000000 8000>;
+	};
+
+	soc8568@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00100000>;
+		bus-frequency = <0>;
+
+		i2c@3000 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3000 100>;
+			interrupts = <1b 2>;
+			interrupt-parent = <40000>;
+			dfsrr;
+		};
+
+		i2c@3100 {
+			device_type = "i2c";
+			compatible = "fsl-i2c";
+			reg = <3100 100>;
+			interrupts = <1b 2>;
+			interrupt-parent = <40000>;
+			dfsrr;
+		};
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			linux,phandle = <24520>;
+			ethernet-phy@0 {
+				linux,phandle = <2452000>;
+				interrupt-parent = <40000>;
+				interrupts = <31 1>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <40000>;
+				interrupts = <32 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+
+			ethernet-phy@2 {
+				linux,phandle = <2452002>;
+				interrupt-parent = <40000>;
+				interrupts = <31 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@3 {
+				linux,phandle = <2452003>;
+				interrupt-parent = <40000>;
+				interrupts = <32 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <d 2 e 2 12 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452002>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			mac-address = [ 00 00 00 00 00 00];
+			interrupts = <13 2 14 2 18 2>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452003>;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;
+			clock-frequency = <0>;
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;
+			clock-frequency = <0>;
+			interrupts = <1a 2>;
+			interrupt-parent = <40000>;
+		};
+
+		crypto@30000 {
+			device_type = "crypto";
+			model = "SEC2";
+			compatible = "talitos";
+			reg = <30000 f000>;
+			interrupts = <1d 2>;
+			interrupt-parent = <40000>;
+			num-channels = <4>;
+			channel-fifo-len = <18>;
+			exec-units-mask = <000000fe>;
+			descriptor-types-mask = <012b0ebf>;
+		};
+
+		pic@40000 {
+			linux,phandle = <40000>;
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+                        big-endian;
+		};
+		par_io@e0100 {
+			reg = <e0100 100>;
+			device_type = "par_io";
+			num-ports = <7>;
+
+			ucc_pin@01 {
+				linux,phandle = <e010001>;
+				pio-map = <
+			/* port  pin  dir  open_drain  assignment  has_irq */
+					4  0a  1  0  2  0 	/* TxD0 */
+					4  09  1  0  2  0 	/* TxD1 */
+					4  08  1  0  2  0 	/* TxD2 */
+					4  07  1  0  2  0 	/* TxD3 */
+					4  17  1  0  2  0 	/* TxD4 */
+					4  16  1  0  2  0 	/* TxD5 */
+					4  15  1  0  2  0 	/* TxD6 */
+					4  14  1  0  2  0 	/* TxD7 */
+					4  0f  2  0  2  0 	/* RxD0 */
+					4  0e  2  0  2  0 	/* RxD1 */
+					4  0d  2  0  2  0 	/* RxD2 */
+					4  0c  2  0  2  0 	/* RxD3 */
+					4  1d  2  0  2  0 	/* RxD4 */
+					4  1c  2  0  2  0 	/* RxD5 */
+					4  1b  2  0  2  0 	/* RxD6 */
+					4  1a  2  0  2  0 	/* RxD7 */
+					4  0b  1  0  2  0 	/* TX_EN */
+					4  18  1  0  2  0 	/* TX_ER */
+					4  0f  2  0  2  0 	/* RX_DV */
+					4  1e  2  0  2  0 	/* RX_ER */
+					4  11  2  0  2  0 	/* RX_CLK */
+					4  13  1  0  2  0 	/* GTX_CLK */
+					1  1f  2  0  3  0>;	/* GTX125 */
+			};
+			ucc_pin@02 {
+				linux,phandle = <e010002>;
+				pio-map = <
+			/* port  pin  dir  open_drain  assignment  has_irq */
+					5  0a 1  0  2  0   /* TxD0 */
+					5  09 1  0  2  0   /* TxD1 */
+					5  08 1  0  2  0   /* TxD2 */
+					5  07 1  0  2  0   /* TxD3 */
+					5  17 1  0  2  0   /* TxD4 */
+					5  16 1  0  2  0   /* TxD5 */
+					5  15 1  0  2  0   /* TxD6 */
+					5  14 1  0  2  0   /* TxD7 */
+					5  0f 2  0  2  0   /* RxD0 */
+					5  0e 2  0  2  0   /* RxD1 */
+					5  0d 2  0  2  0   /* RxD2 */
+					5  0c 2  0  2  0   /* RxD3 */
+					5  1d 2  0  2  0   /* RxD4 */
+					5  1c 2  0  2  0   /* RxD5 */
+					5  1b 2  0  2  0   /* RxD6 */
+					5  1a 2  0  2  0   /* RxD7 */
+					5  0b 1  0  2  0   /* TX_EN */
+					5  18 1  0  2  0   /* TX_ER */
+					5  10 2  0  2  0   /* RX_DV */
+					5  1e 2  0  2  0   /* RX_ER */
+					5  11 2  0  2  0   /* RX_CLK */
+					5  13 1  0  2  0   /* GTX_CLK */
+					1  1f 2  0  3  0   /* GTX125 */
+					4  06 3  0  2  0   /* MDIO */
+					4  05 1  0  2  0>; /* MDC */
+			};
+		};
+	};
+
+	qe@e0080000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "qe";
+		model = "QE";
+		ranges = <0 e0080000 00040000>;
+		reg = <e0080000 480>;
+		brg-frequency = <0>;
+		bus-frequency = <179A7B00>;
+
+		muram@10000 {
+			device_type = "muram";
+			ranges = <0 00010000 0000c000>;
+
+			data-only@0{
+				reg = <0 c000>;
+			};
+		};
+
+		spi@4c0 {
+			device_type = "spi";
+			compatible = "fsl_spi";
+			reg = <4c0 40>;
+			interrupts = <2>;
+			interrupt-parent = <80>;
+			mode = "cpu";
+		};
+
+		spi@500 {
+			device_type = "spi";
+			compatible = "fsl_spi";
+			reg = <500 40>;
+			interrupts = <1>;
+			interrupt-parent = <80>;
+			mode = "cpu";
+		};
+
+		ucc@2000 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			model = "UCC";
+			device-id = <1>;
+			reg = <2000 200>;
+			interrupts = <20>;
+			interrupt-parent = <80>;
+			mac-address = [ 00 04 9f 00 23 23 ];
+			rx-clock = <0>;
+			tx-clock = <19>;
+			phy-handle = <212000>;
+			pio-handle = <e010001>;
+		};
+
+		ucc@3000 {
+			device_type = "network";
+			compatible = "ucc_geth";
+			model = "UCC";
+			device-id = <2>;
+			reg = <3000 200>;
+			interrupts = <21>;
+			interrupt-parent = <80>;
+			mac-address = [ 00 11 22 33 44 55 ];
+			rx-clock = <0>;
+			tx-clock = <14>;
+			phy-handle = <212001>;
+			pio-handle = <e010002>;
+		};
+
+		mdio@2120 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2120 18>;
+			device_type = "mdio";
+			compatible = "ucc_geth_phy";
+
+			/* These are the same PHYs as on
+			 * gianfar's MDIO bus */
+			ethernet-phy@00 {
+				linux,phandle = <212000>;
+				interrupt-parent = <40000>;
+				interrupts = <31 1>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+				interface = <6>; //ENET_1000_GMII
+			};
+			ethernet-phy@01 {
+				linux,phandle = <212001>;
+				interrupt-parent = <40000>;
+				interrupts = <32 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+				interface = <6>;
+			};
+			ethernet-phy@02 {
+				linux,phandle = <212002>;
+				interrupt-parent = <40000>;
+				interrupts = <31 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+				interface = <6>; //ENET_1000_GMII
+			};
+			ethernet-phy@03 {
+				linux,phandle = <212003>;
+				interrupt-parent = <40000>;
+				interrupts = <32 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+				interface = <6>; //ENET_1000_GMII
+			};
+		};
+
+		qeic@80 {
+			linux,phandle = <80>;
+			interrupt-controller;
+			device_type = "qeic";
+			#address-cells = <0>;
+			#interrupt-cells = <1>;
+			reg = <80 80>;
+			built-in;
+			big-endian;
+			interrupts = <1e 2 1e 2>; //high:30 low:30
+			interrupt-parent = <40000>;
+		};
+
+	};
+};
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index ac2de08..ba1e6b2 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -24,6 +24,13 @@ config MPC85xx_CDS
 	help
 	  This option enables support for the MPC85xx CDS board
 
+config MPC8568_MDS
+	bool "Freescale MPC8568 MDS"
+	select DEFAULT_UIMAGE
+#	select QUICC_ENGINE
+	help
+	  This option enables support for the MPC8568 MDS board
+
 endchoice
 
 config MPC8540
@@ -37,6 +44,12 @@ config MPC8560
 	select PPC_INDIRECT_PCI
 	default y if MPC8560_ADS
 
+config MPC85xx
+	bool
+	select PPC_UDBG_16550
+	select PPC_INDIRECT_PCI
+	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS || MPC8568_MDS
+
 config PPC_INDIRECT_PCI_BE
 	bool
 	depends on PPC_85xx
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 282f5d0..e40e521 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_PPC_85xx)	+= misc.o pci.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
+obj-$(CONFIG_MPC8568_MDS) += mpc8568_mds.o
diff --git a/arch/powerpc/platforms/85xx/mpc8568_mds.c b/arch/powerpc/platforms/85xx/mpc8568_mds.c
new file mode 100644
index 0000000..0861d11
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc8568_mds.c
@@ -0,0 +1,246 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006-2007. All rights reserved.
+ *
+ * Author: Andy Fleming <afleming@freescale.com>
+ *
+ * Based on 83xx/mpc8360e_pb.c by:
+ *	   Li Yang <LeoLi@freescale.com>
+ *	   Yin Olivia <Hong-hua.Yin@freescale.com>
+ *
+ * Description:
+ * MPC8568E MDS PB board specific routines.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/bootinfo.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc85xx.h>
+#include <asm/irq.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <sysdev/fsl_soc.h>
+#include <asm/qe.h>
+#include <asm/qe_ic.h>
+#include <asm/mpic.h>
+
+#include "mpc85xx.h"
+
+#undef DEBUG
+#ifdef DEBUG
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+#ifndef CONFIG_PCI
+unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+#endif
+
+/* ************************************************************************
+ *
+ * Setup the architecture
+ *
+ */
+static void __init mpc8568_mds_setup_arch(void)
+{
+	struct device_node *np;
+	static u8 *bcsr_regs = NULL;
+
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8568_mds_setup_arch()", 0);
+
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np != NULL) {
+		const unsigned int *fp =
+		    get_property(np, "clock-frequency", NULL);
+		if (fp != NULL)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(np);
+	}
+
+	/* Map BCSR area */
+	np = of_find_node_by_name(NULL, "bcsr");
+	if (np != NULL) {
+		struct resource res;
+
+		of_address_to_resource(np, 0, &res);
+		bcsr_regs = ioremap(res.start, res.end - res.start +1);
+		of_node_put(np);
+	}
+
+#ifdef CONFIG_PCI
+	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
+		add_bridge(np);
+	}
+	of_node_put(np);
+#endif
+
+#ifdef CONFIG_QUICC_ENGINE
+	if ((np = of_find_node_by_name(NULL, "qe")) != NULL) {
+		qe_reset();
+		of_node_put(np);
+	}
+
+	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
+		struct device_node *ucc = NULL;
+
+		par_io_init(np);
+		of_node_put(np);
+
+		for ( ;(ucc = of_find_node_by_name(ucc, "ucc")) != NULL;)
+			par_io_of_config(ucc);
+
+		of_node_put(ucc);
+	}
+
+	if (bcsr_regs) {
+		u8 bcsr_phy;
+
+		/* Reset the Ethernet PHY */
+		bcsr_phy = in_be8(&bcsr_regs[9]);
+		bcsr_phy &= ~0x20;
+		out_be8(&bcsr_regs[9], bcsr_phy);
+
+		udelay(1000);
+
+		bcsr_phy = in_be8(&bcsr_regs[9]);
+		bcsr_phy |= 0x20;
+		out_be8(&bcsr_regs[9], bcsr_phy);
+
+		iounmap(bcsr_regs);
+	}
+
+#endif	/* CONFIG_QUICC_ENGINE */
+}
+
+static struct of_device_id mpc8568_ids[] = {
+	{ .type = "soc", },
+	{ .compatible = "soc", },
+	{ .type = "qe", },
+	{},
+};
+
+static int __init mpc8568_publish_devices(void)
+{
+	if (!machine_is(mpc8568_mds))
+		return 0;
+
+	/* Publish the QE devices */
+	of_platform_bus_probe(NULL,mpc8568_ids,NULL);
+
+	return 0;
+}
+device_initcall(mpc8568_publish_devices);
+
+static void __init mpc8568_mds_pic_init(void)
+{
+	struct mpic *mpic;
+	struct resource r;
+	struct device_node *np = NULL;
+
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (!np)
+		return;
+
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "Failed to map mpic register space\n");
+		of_node_put(np);
+		return;
+	}
+
+	mpic = mpic_alloc(np, r.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			4, 0, " OpenPIC  ");
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	/* Internal Interrupts */
+	mpic_assign_isu(mpic, 0, r.start + 0x10200);
+	mpic_assign_isu(mpic, 1, r.start + 0x10280);
+	mpic_assign_isu(mpic, 2, r.start + 0x10300);
+	mpic_assign_isu(mpic, 3, r.start + 0x10380);
+	mpic_assign_isu(mpic, 4, r.start + 0x10400);
+	mpic_assign_isu(mpic, 5, r.start + 0x10480);
+	mpic_assign_isu(mpic, 6, r.start + 0x10500);
+	mpic_assign_isu(mpic, 7, r.start + 0x10580);
+	mpic_assign_isu(mpic, 8, r.start + 0x10600);
+	mpic_assign_isu(mpic, 9, r.start + 0x10680);
+	mpic_assign_isu(mpic, 10, r.start + 0x10700);
+	mpic_assign_isu(mpic, 11, r.start + 0x10780);
+
+	/* External Interrupts */
+	mpic_assign_isu(mpic, 12, r.start + 0x10000);
+	mpic_assign_isu(mpic, 13, r.start + 0x10080);
+	mpic_assign_isu(mpic, 14, r.start + 0x10100);
+
+	mpic_init(mpic);
+
+
+#ifdef CONFIG_QUICC_ENGINE
+	np = of_find_node_by_type(NULL, "qeic");
+	if (!np)
+		return;
+
+	qe_ic_init(np, 0);
+	of_node_put(np);
+#endif				/* CONFIG_QUICC_ENGINE */
+}
+
+
+static int __init mpc8568_mds_probe(void)
+{
+	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
+					  "model", NULL);
+	if (model == NULL)
+		return 0;
+	if (strcmp(model, "MPC8568EMDS"))
+		return 0;
+
+	DBG("MPC8568EMDS found\n");
+
+	return 1;
+}
+
+
+define_machine(mpc8568_mds) {
+	.name		= "MPC8568E MDS",
+	.probe		= mpc8568_mds_probe,
+	.setup_arch	= mpc8568_mds_setup_arch,
+	.init_IRQ	= mpc8568_mds_pic_init,
+	.get_irq	= mpic_get_irq,
+	.restart	= mpc85xx_restart,
+	.calibrate_decr	= generic_calibrate_decr,
+	.progress	= udbg_progress,
+};
-- 
1.4.4
