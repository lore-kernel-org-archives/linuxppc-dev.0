Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 85196DDDE6
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 12:33:02 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1045913yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 01 Dec 2008 17:33:00 -0800 (PST)
Date: Mon, 1 Dec 2008 20:32:56 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: mmadishetty@amcc.com
Subject: Re: [PATCH] Add_460SX_Initial_Framework
Message-ID: <20081202013256.GB25631@zod.rchland.ibm.com>
References: <1228174635-27620-1-git-send-email-mmadishetty@amcc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1228174635-27620-1-git-send-email-mmadishetty@amcc.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Dec 01, 2008 at 03:37:15PM -0800, mmadishetty@amcc.com wrote:
>From: Madhulika Madishetty <mmadishetty@amcc.com>
>
>This patch contains the initial framework for AMCC Redwood board.
>
>Signed-off-by: Madhulika Madishetty <mmadishetty@amcc.com>, Tirumala Reddy 
>Marri <tmarri@amcc.com>,
>Feng Kan <fkan@amcc.com>, Vidhyananth Venkatasamy <vvenkatasamy@amcc.com>, 
>Preetesh Parekh <pparekh@amcc.com>
>Acked-by: Loc Ho <lho@amcc.com>, Feng Kan <fkan@amcc.com>

One Signed-off-by: per person, per line please.  Don't use a single
with multiple names.

>---
> arch/powerpc/boot/dts/redwood_amcc.dts     |  247 +++++++
> arch/powerpc/configs/44x/redwood_defconfig | 1082 
>++++++++++++++++++++++++++++

Parts of your patch are word-wrapped.

>diff --git a/arch/powerpc/boot/dts/redwood_amcc.dts 
>b/arch/powerpc/boot/dts/redwood_amcc.dts
>new file mode 100644
>index 0000000..e4f5efd
>--- /dev/null
>+++ b/arch/powerpc/boot/dts/redwood_amcc.dts

Any particular reason you chose to call this redwood_amcc.dts?  None
of the other boards do that.

Also, what possessed AMCC to create an entirely new board called
Redwood when there is already a 4xx board called Redwood?  I realize
this isn't really something you can control, and the old board isn't
supported any longer, but still...  yell at your marketing people or
something :).

>@@ -0,0 +1,247 @@
>+/*
>+ * Device Tree Source for AMCC Redwood(460SX)
>+ *
>+ * Copyright 2008 AMCC <tmarri@amcc.com>
>+ *
>+ * This file is licensed under the terms of the GNU General Public
>+ * License version 2.  This program is licensed "as is" without
>+ * any warranty of any kind, whether express or implied.
>+ */
>+
>+/dts-v1/;

If this is really a dts-v1, I would expect all the values here to
look differently.  See below.

>+
>+/ {
>+	#address-cells = <2>;
>+	#size-cells = <1>;
>+	model = "amcc,redwood";
>+	compatible = "amcc,redwood";
>+	dcr-parent = <&/cpus/cpu@0>;
>+
>+	aliases {
>+		ethernet0 = &EMAC0;
>+		serial0 = &UART0;
>+	};
>+
>+	cpus {
>+		#address-cells = <1>;
>+		#size-cells = <0>;
>+
>+		cpu@0 {
>+			device_type = "cpu";
>+			model = "PowerPC,460SX";
>+			reg = <0>;
>+			clock-frequency = <0>; /* Filled in by U-Boot */
>+			timebase-frequency = <0>; /* Filled in by U-Boot */
>+			i-cache-line-size = <20>;
>+			d-cache-line-size = <20>;

Here.  You have a i/d-cache line size of 20 bytes?  That's odd...

>+			i-cache-size = <8000>;
>+			d-cache-size = <8000>;

And you have a cache size of 8000 bytes?  Also odd.  I would expect these
lines to look like:

			i-cache-line-size = <0x20>;
			i-cache-size = <0x8000>;

or
			i-cache-line-size = <32>;
			i-cache-size = <32768>;

Please go through and verify all the values are properly filled out.  I'm
not even sure how this works with newer dtc versions.

>+			dcr-controller;
>+			dcr-access-method = "native";
>+		};
>+	};
>+
>+	memory {
>+		device_type = "memory";
>+		reg = <0 0 0>; /* Filled in by U-Boot */
>+	};
>+
>+	UIC0: interrupt-controller0 {
>+		compatible = "ibm,uic-460sx","ibm,uic";
>+		interrupt-controller;
>+		cell-index = <0>;
>+		dcr-reg = <0c0 009>;
>+		#address-cells = <0>;
>+		#size-cells = <0>;
>+		#interrupt-cells = <2>;
>+	};
>+
>+	UIC1: interrupt-controller1 {
>+		compatible = "ibm,uic-460sx","ibm,uic";
>+		interrupt-controller;
>+		cell-index = <1>;
>+		dcr-reg = <0d0 009>;
>+		#address-cells = <0>;
>+		#size-cells = <0>;
>+		#interrupt-cells = <2>;
>+		interrupts = <1e 4 1f 4>; /* cascade */
>+		interrupt-parent = <&UIC0>;
>+	};
>+
>+	UIC2: interrupt-controller2 {
>+		compatible = "ibm,uic-460sx","ibm,uic";
>+		interrupt-controller;
>+		cell-index = <2>;
>+		dcr-reg = <0e0 009>;
>+		#address-cells = <0>;
>+		#size-cells = <0>;
>+		#interrupt-cells = <2>;
>+		interrupts = <a 4 b 4>; /* cascade */
>+		interrupt-parent = <&UIC0>;
>+	};
>+
>+	UIC3: interrupt-controller3 {
>+		compatible = "ibm,uic-460sx","ibm,uic";
>+		interrupt-controller;
>+		cell-index = <3>;
>+		dcr-reg = <0f0 009>;
>+		#address-cells = <0>;
>+		#size-cells = <0>;
>+		#interrupt-cells = <2>;
>+		interrupts = <10 4 11 4>; /* cascade */
>+		interrupt-parent = <&UIC0>;
>+	};
>+
>+	SDR0: sdr {
>+		compatible = "ibm,sdr-460sx";
>+		dcr-reg = <00e 002>;
>+	};
>+
>+	CPR0: cpr {
>+		compatible = "ibm,cpr-460sx";
>+		dcr-reg = <00c 002>;
>+	};
>+	plb {
>+		compatible = "ibm,plb-460sx", "ibm,plb4";
>+		#address-cells = <2>;
>+		#size-cells = <1>;
>+		ranges;
>+		clock-frequency = <0>; /* Filled in by U-Boot */
>+
>+		SDRAM0: sdram {
>+			compatible = "ibm,sdram-460sx", "ibm,sdram-405gp";
>+			dcr-reg = <010 2>;
>+		};
>+
>+		MAL0: mcmal {
>+			compatible = "ibm,mcmal-460sx", "ibm,mcmal2";
>+			dcr-reg = <180 62>;
>+			num-tx-chans = <4>;
>+			num-rx-chans = <20>;
>+			#address-cells = <1>;
>+			#size-cells = <1>;
>+			/*reg = <4 00040000 10000>;
>+			ranges = <0 4 00040000 10000>;*/  /*OCM mapped to 0xa0000000 */

You have reg and ranges commented out?  Not sure why those are here anyway,
but you should remove them if they aren't needed.

>+			interrupt-parent = <&UIC1>;
>+			interrupts = <	/*TXEOB*/ 6 4
>+					/*RXEOB*/ 7 4
>+					/*SERR*/  1 4
>+					/*TXDE*/  2 4
>+					/*RXDE*/  3 4
>+					/*COAL TX0*/ 18 2
>+					/*COAL TX1*/ 19 2
>+					/*COAL TX2*/ 1a 2
>+					/*COAL TX3*/ 1b 2
>+					/*COAL RX0*/ 1c 2
>+					/*COAL RX1*/ 1d 2
>+					/*COAL RX2*/ 1e 2
>+					/*COAL RX3*/ 1f 2>;
>+		};
>+
>+
>+		POB0: opb {
>+			compatible = "ibm,opb-460sx", "ibm,opb";
>+			#address-cells = <1>;
>+			#size-cells = <1>;
>+			ranges = <b0000000 4 b0000000 50000000>;
>+			clock-frequency = <0>; /* Filled in by U-Boot */
>+
>+			EBC0: ebc {
>+				compatible = "ibm,ebc-460sx", "ibm,ebc";
>+				dcr-reg = <012 2>;
>+				#address-cells = <2>;
>+				#size-cells = <1>;
>+				clock-frequency = <0>; /* Filled in by U-Boot */
>+				/* ranges property is supplied by U-Boot */
>+				interrupts = <6 4>;
>+				interrupt-parent = <&UIC1>;
>+
>+				nor_flash@0,0 {
>+					compatible = "amd,s29gl512n", "cfi-flash";
>+					bank-width = <2>;
>+					reg = <0 000000 4000000>;
>+					#address-cells = <1>;
>+					#size-cells = <1>;
>+					partition@0 {
>+						label = "kernel";
>+						reg = <0 1e0000>;
>+					};
>+					partition@1e0000 {
>+						label = "dtb";
>+						reg = <1e0000 20000>;
>+					};
>+					partition@200000 {
>+						label = "ramdisk";
>+						reg = <200000 1400000>;
>+					};
>+					partition@1600000 {
>+						label = "jffs2";
>+						reg = <1600000 400000>;
>+					};
>+					partition@1a00000 {
>+						label = "user";
>+						reg = <1a00000 2560000>;
>+					};
>+					partition@3f60000 {
>+						label = "env";
>+						reg = <3f60000 40000>;
>+					};
>+					partition@3fa0000 {
>+						label = "u-boot";
>+						reg = <3fa0000 60000>;
>+					};
>+				};
>+			};
>+
>+			UART0: serial@ef600200 {
>+				device_type = "serial";
>+				compatible = "ns16550";
>+				reg = <ef600200 8>;
>+				virtual-reg = <ef600200>;
>+				clock-frequency = <0>; /* Filled in by U-Boot */
>+				current-speed = <0>; /* Filled in by U-Boot */
>+				interrupt-parent = <&UIC0>;
>+				interrupts = <0 4>;
>+			};
>+
>+			RGMII0: emac-rgmii@ef600900 {
>+				compatible = "ibm,rgmii-460sx", "ibm,rgmii";
>+				reg = <ef600900 8>;
>+			};
>+
>+			EMAC0: ethernet@ef600a00 {
>+				device_type = "network";
>+				compatible = "ibm,emac-460sx", "ibm,emac4";
>+				interrupt-parent = <&EMAC0>;
>+				interrupts = <0 1>;
>+				#interrupt-cells = <1>;
>+				#address-cells = <0>;
>+				#size-cells = <0>;
>+				interrupt-map = </*Status*/ 0 &UIC0 13 4
>+						 /*Wake*/   1 &UIC2 1D 4>;
>+				reg = <ef600a00 70>;
>+				local-mac-address = [000000000000]; /* Filled in by U-Boot */
>+				mal-device = <&MAL0>;
>+				mal-tx-channel = <0>;
>+				mal-rx-channel = <0>;
>+				cell-index = <0>;
>+				max-frame-size = <2328>;
>+				rx-fifo-size = <1000>;
>+				tx-fifo-size = <800>;
>+				phy-mode = "rgmii";
>+				phy-map = <00000000>;
>+				rgmii-device = <&RGMII0>;
>+				rgmii-channel = <0>;
>+				has-inverted-stacr-oc;
>+				has-new-stacr-staopc;
>+			};
>+
>+		};
>+
>+
>+	};
>+	chosen {
>+		linux,stdout-path = "/plb/opb/serial@ef600200";
>+	};
>+
>+};
>diff --git a/arch/powerpc/configs/44x/redwood_defconfig 
>b/arch/powerpc/configs/44x/redwood_defconfig
>new file mode 100644
>index 0000000..e9ad3b2
>--- /dev/null
>+++ b/arch/powerpc/configs/44x/redwood_defconfig
>@@ -0,0 +1,1082 @@
>+#
>+# Automatically generated make config: don't edit
>+# Linux kernel version: 2.6.26

I think you need to regenerate this defconfig against
a more current kernel.


>diff --git a/arch/powerpc/kernel/cpu_setup_44x.S 
>b/arch/powerpc/kernel/cpu_setup_44x.S
>index 80cac98..ebc2449 100644
>--- a/arch/powerpc/kernel/cpu_setup_44x.S
>+++ b/arch/powerpc/kernel/cpu_setup_44x.S
>@@ -35,6 +35,8 @@ _GLOBAL(__setup_cpu_440grx)
> _GLOBAL(__setup_cpu_460ex)
> _GLOBAL(__setup_cpu_460gt)
> 	b	__init_fpu_44x
>+_GLOBAL(__setup_cpu_460sx)
>+	b	__init_fpu_44x

Don't you also need __fixup_440A_mcheck here?

> _GLOBAL(__setup_cpu_440gx)
> _GLOBAL(__setup_cpu_440spe)
> 	b	__fixup_440A_mcheck
>diff --git a/arch/powerpc/kernel/cputable.c 
>b/arch/powerpc/kernel/cputable.c
>index b1eb834..f3005f8 100644
>--- a/arch/powerpc/kernel/cputable.c
>+++ b/arch/powerpc/kernel/cputable.c
>@@ -41,6 +41,7 @@ extern void __setup_cpu_440grx(unsigned long offset, 
>struct cpu_spec* spec);
> extern void __setup_cpu_440spe(unsigned long offset, struct cpu_spec* 
>spec);
> extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec* 
>spec);
> extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec* 
>spec);
>+extern void __setup_cpu_460sx(unsigned long offset, struct cpu_spec 
>*spec);
> extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
> extern void __setup_cpu_604(unsigned long offset, struct cpu_spec* spec);
> extern void __setup_cpu_750(unsigned long offset, struct cpu_spec* spec);
>@@ -1526,6 +1527,18 @@ static struct cpu_spec __initdata cpu_specs[] = {
> 		.machine_check		= machine_check_440A,
> 		.platform		= "ppc440",
> 	},
>+	{ /* 460SX */
>+		.pvr_mask		= 0xffffff00,
>+		.pvr_value		= 0x13541800,
>+		.cpu_name		= "460SX",
>+		.cpu_features		= CPU_FTRS_44X,
>+		.cpu_user_features	= COMMON_USER_BOOKE,
>+		.icache_bsize		= 32,
>+		.dcache_bsize		= 32,
>+		.cpu_setup		= __setup_cpu_460sx,
>+		.machine_check		= machine_check_440A,
>+		.platform		= "ppc440",
>+	},
> 	{	/* default match */
> 		.pvr_mask		= 0x00000000,
> 		.pvr_value		= 0x00000000,
>diff --git a/arch/powerpc/platforms/44x/Kconfig 
>b/arch/powerpc/platforms/44x/Kconfig
>index 3496bc0..52a38d0 100644
>--- a/arch/powerpc/platforms/44x/Kconfig
>+++ b/arch/powerpc/platforms/44x/Kconfig
>@@ -118,6 +118,17 @@ config GLACIER
> 	help
> 	  This option enables support for the AMCC PPC460GT evaluation board.
>
>+config REDWOOD
>+	bool "Redwood"
>+	depends on 44x
>+	default n
>+	select PPC44x_SIMPLE

If you are selecting PPC44x_SIMPLE, why do you create
your own redwood.c file?

>+	select 460SX
>+	select PCI
>+	select PPC4xx_PCI_EXPRESS
>+	help
>+	  This option enables support for the AMCC PPC460SX validation board.
>+
> config YOSEMITE
> 	bool "Yosemite"
> 	depends on 44x
>@@ -220,6 +231,14 @@ config 460EX
> 	select IBM_NEW_EMAC_EMAC4
> 	select IBM_NEW_EMAC_TAH
>
>+config 460SX
>+	bool
>+	select PPC_FPU
>+	select IBM_NEW_EMAC_EMAC4
>+	select IBM_NEW_EMAC_RGMII
>+	select IBM_NEW_EMAC_ZMII
>+	select IBM_NEW_EMAC_TAH
>+
> # 44x errata/workaround config symbols, selected by the CPU models above
> config IBM440EP_ERR42
> 	bool
>@@ -231,5 +250,4 @@ config XILINX_VIRTEX
> # Xilinx Virtex 5 FXT FPGA architecture, selected by a Xilinx board above
> config XILINX_VIRTEX_5_FXT
> 	bool
>-	select XILINX_VIRTEX
>-
>+	select XILINX_VIRTEX
>\ No newline at end of file

Erm, this is an unnecessary patch hunk.

>diff --git a/arch/powerpc/platforms/44x/Makefile 
>b/arch/powerpc/platforms/44x/Makefile
>index 6981331..af797c8 100644
>--- a/arch/powerpc/platforms/44x/Makefile
>+++ b/arch/powerpc/platforms/44x/Makefile
>@@ -5,3 +5,4 @@ obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
> obj-$(CONFIG_WARP)	+= warp.o
> obj-$(CONFIG_WARP)	+= warp-nand.o
> obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
>+obj-$(CONFIG_REDWOOD) += redwood.o
>\ No newline at end of file
>diff --git a/arch/powerpc/platforms/44x/ppc44x_simple.c 
>b/arch/powerpc/platforms/44x/ppc44x_simple.c
>index 2967126..1470a1c 100644
>--- a/arch/powerpc/platforms/44x/ppc44x_simple.c
>+++ b/arch/powerpc/platforms/44x/ppc44x_simple.c
>@@ -57,9 +57,11 @@ static char *board[] __initdata = {
> 	"ibm,ebony",
> 	"amcc,katmai",
> 	"amcc,rainier",
>+	"amcc,redwood"
> 	"amcc,sequoia",
> 	"amcc,taishan",
> 	"amcc,yosemite"
>+
> };
>
> static int __init ppc44x_probe(void)

Judging from the redwood.c file you create below, this is
entirely incorrect.

>diff --git a/arch/powerpc/platforms/44x/redwood.c 
>b/arch/powerpc/platforms/44x/redwood.c
>new file mode 100644
>index 0000000..c3bae49
>--- /dev/null
>+++ b/arch/powerpc/platforms/44x/redwood.c
>@@ -0,0 +1,103 @@
>+/*
>+ * redwood board specific routines
>+ *
>+ * Copyright 2008 Appled Micro Circuits Corporation.
>+ * All rights reserved. Tirumala Marri <tmarri@amcc.com>
>+ *
>+ * Based on the Katmai code by
>+ * Benjamin Herrenschmidt <benh@kernel.crashing.org>
>+ * Copyright 2007 IBM Corp.
>+ * Josh Boyer <jwboyer@linux.vnet.ibm.com>
>+ * Copyright 2007 IBM Corporation
>+ *
>+ * This program is free software; you can redistribute  it and/or modify 
>it
>+ * under  the terms of  the GNU General  Public License as published by 
>the
>+ * Free Software Foundation;  either version 2 of the  License, or (at 
>your
>+ * option) any later version.
>+ */

Word-wrapped.

>+#include <linux/init.h>
>+#include <linux/of_platform.h>
>+
>+#include <asm/machdep.h>
>+#include <asm/prom.h>
>+#include <asm/udbg.h>
>+#include <asm/time.h>
>+#include <asm/uic.h>
>+#include <asm/pci-bridge.h>
>+#include <asm/ppc4xx.h>
>+#include <asm/dcr.h>
>+#include <asm/dcr-regs.h>
>+#include <asm/io.h>
>+
>+#define DCRN_EBC0_CONFIG_ADDR    0x012
>+#define DCRN_EBC0_CONFIG_DATA    0x013
>+
>+static __initdata struct of_device_id redwood_of_bus[] = {
>+	{ .compatible = "ibm,plb4", },
>+	{ .compatible = "ibm,opb", },
>+	{ .compatible = "ibm,ebc", },
>+	{},
>+};
>+
>+static int __init redwood_device_probe(void)
>+{
>+	of_platform_bus_probe(NULL, redwood_of_bus, NULL);
>+
>+	return 0;
>+}
>+machine_device_initcall(redwood, redwood_device_probe);
>+
>+static int __init redwood_probe(void)
>+{
>+	unsigned long root = of_get_flat_dt_root();
>+
>+	if (!of_flat_dt_is_compatible(root, "amcc,redwood"))
>+		return 0;
>+	ppc_pci_flags = PPC_PCI_REASSIGN_ALL_RSRC;
>+	return 1;
>+}
>+
>+static void __init redwood_setup_arch(void)
>+{
>+	struct device_node *np;
>+	unsigned int *cpld_ptr = NULL;
>+	unsigned int ebc_b3cr = 0;
>+	unsigned long long ebc_cpld_addr = 0;
>+
>+	mtdcr(DCRN_EBC0_CONFIG_ADDR, 0x3);

What is 0x3?  No hard-coded magic hex values please.  Same comment
elsewhere.

>+	ebc_b3cr = mfdcr(DCRN_EBC0_CONFIG_DATA);
>+	/* cpld address retrieved from EBC_CR */
>+	ebc_cpld_addr = 0x400000000ULL | (ebc_b3cr & 0xFFF00000);
>+	cpld_ptr = ioremap(ebc_cpld_addr, 0xC);

Why aren't you using the device tree here?  Getting the cpld address
and resources should be easy enough if the cpld is enumerated in the
device tree...

>+	if (!cpld_ptr) {
>+		printk(KERN_ERR "Err: can't map CPLD registers!\n");
>+		return;
>+	}
>+	/* Check EMAC bridge setting */
>+	np = of_find_compatible_node(NULL, NULL, "ibm,emac-460sx");

of_find_compatible_node creates a reference on the node pointer.  You
need to use of_node_put on it when you are done.

>+	if (np) {
>+		const char *phymode;
>+		unsigned int bcr;
>+		phymode = of_get_property(np, "phy-mode", NULL);
>+		if (!phymode) {
>+			printk(KERN_ERR "Err: can't access node property \
>+					phy-mode\n defaulting to rgmii");
>+		}
>+		bcr = in_be32(cpld_ptr + 2);
>+		if (strcasecmp(phymode, "gmii") == 0)
>+			out_be32(cpld_ptr + 2, bcr & 0xFFEFFFFF);
>+		else
>+			out_be32(cpld_ptr + 2, bcr | 0x00100000);
>+	}

A comment about what this function is trying to do would be nice.  I can
guess that it's setting the phy in a certain mode with some magical hex
values, but I have no idea why.

>+}
>+
>+define_machine(redwood) {
>+	.name 				= "redwood",
>+	.probe 				= redwood_probe,
>+	.setup_arch			= redwood_setup_arch,
>+	.progress 			= udbg_progress,
>+	.init_IRQ 			= uic_init_tree,
>+	.get_irq 			= uic_get_irq,
>+	.restart			= ppc4xx_reset_system,
>+	.calibrate_decr			= generic_calibrate_decr,
>+};
>-- 
>1.5.5
>--------------------------------------------------------
>
>CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
>for the sole use of the intended recipient(s) and contains information 
>that is confidential and proprietary to Applied Micro Circuits Corporation 
>or its subsidiaries. It is to be used solely for the purpose of furthering 
>the parties' business relationship. All unauthorized review, use, 
>disclosure or distribution is prohibited. If you are not the intended 
>recipient, please contact the sender by reply e-mail and destroy all 
>copies of the original message.

Get rid of this message entirely.  It has no place on a public mailing list,
and certainly not for a patch submission.

josh
