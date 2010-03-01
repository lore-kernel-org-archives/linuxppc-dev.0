Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 1 Mar 2010 12:16:00 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100301191337.20987.58130.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
Subject: [RFC: PATCH 06/13] powerpc/4xx: Simple platform for the ISS 4xx
	simulator
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/4xx: Simple platform for the ISS 4xx simulator

From: Torez Smith <lnxtorez@linux.vnet.ibm.com>

This is a trivial 4xx plaform that uses the new simple bsp from
Josh and is handy to use in simulators such as ISS or even Mambo
who don't properly implement most of the actual devices in the
SoC but really only the core.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/boot/Makefile            |    5 +
 arch/powerpc/boot/dts/iss4xx-mpic.dts |  155 +++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/iss4xx.dts      |  116 +++++++++++++++++++++++
 arch/powerpc/boot/treeboot-iss4xx.c   |   56 +++++++++++
 arch/powerpc/boot/wrapper             |    3 +
 arch/powerpc/include/asm/reg.h        |    3 +
 arch/powerpc/kernel/cputable.c        |   15 +++
 arch/powerpc/kernel/head_44x.S        |    2 
 arch/powerpc/platforms/44x/Kconfig    |   11 ++
 arch/powerpc/platforms/44x/Makefile   |    1 
 arch/powerpc/platforms/44x/iss4xx.c   |  165 +++++++++++++++++++++++++++++++++
 11 files changed, 531 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/iss4xx-mpic.dts
 create mode 100644 arch/powerpc/boot/dts/iss4xx.dts
 create mode 100644 arch/powerpc/boot/treeboot-iss4xx.c
 create mode 100644 arch/powerpc/platforms/44x/iss4xx.c


diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index bb2465b..997196e 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -44,6 +44,7 @@ $(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-acadia.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
+$(obj)/treeboot-iss4xx.o: BOOTCFLAGS += -mcpu=405
 $(obj)/virtex405-head.o: BOOTAFLAGS += -mcpu=405
 
 
@@ -77,7 +78,7 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
 		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
-		gamecube-head.S gamecube.c wii-head.S wii.c
+		gamecube-head.S gamecube.c wii-head.S wii.c treeboot-iss4xx.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -206,6 +207,8 @@ image-$(CONFIG_TAISHAN)			+= cuImage.taishan
 image-$(CONFIG_KATMAI)			+= cuImage.katmai
 image-$(CONFIG_WARP)			+= cuImage.warp
 image-$(CONFIG_YOSEMITE)		+= cuImage.yosemite
+image-$(CONFIG_ISS4xx)			+= treeImage.iss4xx \
+					   treeImage.iss4xx-mpic
 
 # Board ports in arch/powerpc/platform/8xx/Kconfig
 image-$(CONFIG_MPC86XADS)		+= cuImage.mpc866ads
diff --git a/arch/powerpc/boot/dts/iss4xx-mpic.dts b/arch/powerpc/boot/dts/iss4xx-mpic.dts
new file mode 100644
index 0000000..23e9d9b
--- /dev/null
+++ b/arch/powerpc/boot/dts/iss4xx-mpic.dts
@@ -0,0 +1,155 @@
+/*
+ * Device Tree Source for IBM Embedded PPC 476 Platform
+ *
+ * Copyright 2010 Torez Smith, IBM Corporation.
+ *
+ * Based on earlier code:
+ *     Copyright (c) 2006, 2007 IBM Corp.
+ *     Josh Boyer <jwboyer@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/memreserve/ 0x01f00000 0x00100000;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "ibm,iss-4xx";
+	compatible = "ibm,iss-4xx";
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,4xx"; // real CPU changed in sim
+			reg = <0>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			status = "ok";
+		};
+		cpu@1 {
+			device_type = "cpu";
+			model = "PowerPC,4xx"; // real CPU changed in sim
+			reg = <1>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			status = "disabled";
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x01f00100>;
+		};
+		cpu@2 {
+			device_type = "cpu";
+			model = "PowerPC,4xx"; // real CPU changed in sim
+			reg = <2>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			status = "disabled";
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x01f00200>;
+		};
+		cpu@3 {
+			device_type = "cpu";
+			model = "PowerPC,4xx"; // real CPU changed in sim
+			reg = <3>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			status = "disabled";
+			enable-method = "spin-table";
+			cpu-release-addr = <0 0x01f00300>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg =  <0x00000000 0x00000000 0x00000000>; // Filled in by zImage
+
+	};
+
+	MPIC: interrupt-controller {
+		compatible = "chrp,open-pic";
+		interrupt-controller;
+		dcr-reg = <0xffc00000 0x00030000>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+	};
+
+	plb {
+		compatible = "ibm,plb-4xx", "ibm,plb4"; /* Could be PLB6, doesn't matter */
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; // Filled in by zImage
+
+		POB0: opb {
+			compatible = "ibm,opb-4xx", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* Wish there was a nicer way of specifying a full 32-bit
+			   range */
+			ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+				  0x80000000 0x00000001 0x80000000 0x80000000>;
+			clock-frequency = <0>; // Filled in by zImage
+			UART0: serial@40000200 {
+				device_type = "serial";
+				compatible = "ns16550a";
+				reg = <0x40000200 0x00000008>;
+				virtual-reg = <0xe0000200>;
+				clock-frequency = <11059200>;
+				current-speed = <115200>;
+				interrupt-parent = <&MPIC>;
+				interrupts = <0x0 0x2>;
+			};
+		};
+	};
+
+	nvrtc {
+		compatible = "ds1743-nvram", "ds1743", "rtc-ds1743";
+		reg = <0 0xEF703000 0x2000>;
+	};
+	iss-block {
+		compatible = "ibm,iss-sim-block-device";
+		reg = <0 0xEF701000 0x1000>;
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@40000200";
+	};
+};
diff --git a/arch/powerpc/boot/dts/iss4xx.dts b/arch/powerpc/boot/dts/iss4xx.dts
new file mode 100644
index 0000000..4ff6555
--- /dev/null
+++ b/arch/powerpc/boot/dts/iss4xx.dts
@@ -0,0 +1,116 @@
+/*
+ * Device Tree Source for IBM Embedded PPC 476 Platform
+ *
+ * Copyright 2010 Torez Smith, IBM Corporation.
+ *
+ * Based on earlier code:
+ *    Copyright (c) 2006, 2007 IBM Corp.
+ *    Josh Boyer <jwboyer@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "ibm,iss-4xx";
+	compatible = "ibm,iss-4xx";
+	dcr-parent = <&{/cpus/cpu@0}>;
+
+	aliases {
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,4xx"; // real CPU changed in sim
+			reg = <0x00000000>;
+			clock-frequency = <100000000>; // 100Mhz :-)
+			timebase-frequency = <100000000>;
+			i-cache-line-size = <32>; // may need fixup in sim
+			d-cache-line-size = <32>; // may need fixup in sim
+			i-cache-size = <32768>; /* may need fixup in sim */
+			d-cache-size = <32768>; /* may need fixup in sim */
+			dcr-controller;
+			dcr-access-method = "native";
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000>; // Filled in by zImage
+	};
+
+	UIC0: interrupt-controller0 {
+		compatible = "ibm,uic-4xx", "ibm,uic";
+		interrupt-controller;
+		cell-index = <0>;
+		dcr-reg = <0x0c0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+	};
+
+	UIC1: interrupt-controller1 {
+		compatible = "ibm,uic-4xx", "ibm,uic";
+		interrupt-controller;
+		cell-index = <1>;
+		dcr-reg = <0x0d0 0x009>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+		interrupts = <0x1e 0x4 0x1f 0x4>; /* cascade */
+		interrupt-parent = <&UIC0>;
+	};
+
+	plb {
+		compatible = "ibm,plb-4xx", "ibm,plb4"; /* Could be PLB6, doesn't matter */
+		#address-cells = <2>;
+		#size-cells = <1>;
+		ranges;
+		clock-frequency = <0>; // Filled in by zImage
+
+		POB0: opb {
+			compatible = "ibm,opb-4xx", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* Wish there was a nicer way of specifying a full 32-bit
+			   range */
+			ranges = <0x00000000 0x00000001 0x00000000 0x80000000
+				  0x80000000 0x00000001 0x80000000 0x80000000>;
+			clock-frequency = <0>; // Filled in by zImage
+			UART0: serial@40000200 {
+				device_type = "serial";
+				compatible = "ns16550a";
+				reg = <0x40000200 0x00000008>;
+				virtual-reg = <0xe0000200>;
+				clock-frequency = <11059200>;
+				current-speed = <115200>;
+				interrupt-parent = <&UIC0>;
+				interrupts = <0x0 0x4>;
+			};
+		};
+	};
+
+	nvrtc {
+		compatible = "ds1743-nvram", "ds1743", "rtc-ds1743";
+		reg = <0 0xEF703000 0x2000>;
+	};
+	iss-block {
+		compatible = "ibm,iss-sim-block-device";
+		reg = <0 0xEF701000 0x1000>;
+	};
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@40000200";
+	};
+};
diff --git a/arch/powerpc/boot/treeboot-iss4xx.c b/arch/powerpc/boot/treeboot-iss4xx.c
new file mode 100644
index 0000000..fcc4495
--- /dev/null
+++ b/arch/powerpc/boot/treeboot-iss4xx.c
@@ -0,0 +1,56 @@
+/*
+ * Copyright 2010 Ben. Herrenschmidt, IBM Corporation.
+ *
+ * Based on earlier code:
+ *   Copyright (C) Paul Mackerras 1997.
+ *
+ *   Matt Porter <mporter@kernel.crashing.org>
+ *   Copyright 2002-2005 MontaVista Software Inc.
+ *
+ *   Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *   Copyright (c) 2003, 2004 Zultys Technologies
+ *
+ *    Copyright 2007 David Gibson, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+#include <stdarg.h>
+#include <stddef.h>
+#include "types.h"
+#include "elf.h"
+#include "string.h"
+#include "stdio.h"
+#include "page.h"
+#include "ops.h"
+#include "reg.h"
+#include "io.h"
+#include "dcr.h"
+#include "4xx.h"
+#include "44x.h"
+#include "libfdt.h"
+
+BSS_STACK(4096);
+
+static void iss_4xx_fixups(void)
+{
+	ibm4xx_sdram_fixup_memsize();
+}
+
+#define SPRN_PIR	0x11E	/* Processor Indentification Register */
+void platform_init(void)
+{
+	unsigned long end_of_ram = 0x08000000;
+	unsigned long avail_ram = end_of_ram - (unsigned long)_end;
+	u32 pir_reg;
+
+	simple_alloc_init(_end, avail_ram, 128, 64);
+	platform_ops.fixups = iss_4xx_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	pir_reg = mfspr(SPRN_PIR);
+	fdt_set_boot_cpuid_phys(_dtb_start, pir_reg);
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index f4594ed..d3216a3 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -237,6 +237,9 @@ gamecube|wii)
     link_address='0x600000'
     platformo="$object/$platform-head.o $object/$platform.o"
     ;;
+treeboot-iss4xx-mpic)
+    platformo="$object/treeboot-iss4xx.o"
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 4af1c28..bd1c3ab 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -850,6 +850,9 @@
 #define PVR_8245	0x80811014
 #define PVR_8260	PVR_8240
 
+/* 476 Simulator seems to currently have the PVR of the 602... */
+#define PVR_476_ISS	0x00052000
+
 /* 64-bit processors */
 /* XXX the prefix should be PVR_, we'll do a global sweep to fix it one day */
 #define PV_NORTHSTAR	0x0033
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 7b2a67c..a06e6d3 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1715,6 +1715,21 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_47x,
 		.platform		= "ppc470",
 	},
+	{ /* 476 iss */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x00050000,
+		.cpu_name		= "476",
+		.cpu_features		= CPU_FTRS_47X,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+			PPC_FEATURE_HAS_FPU,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_47x |
+			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 128,
+		.machine_check		= machine_check_47x,
+		.platform		= "ppc470",
+	},
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index 992e9d5..af3a9e1 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -721,6 +721,8 @@ _GLOBAL(init_cpu_state)
 	srwi	r3,r3,16
 	cmplwi	cr0,r3,PVR_476@h
 	beq	head_start_47x
+	cmplwi	cr0,r3,PVR_476_ISS@h
+	beq	head_start_47x
 #endif /* CONFIG_PPC_47x */
 
 /*
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 1dfc1c1..915c295 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -162,6 +162,17 @@ config YOSEMITE
 	help
 	  This option enables support for the AMCC PPC440EP evaluation board.
 
+config ISS4xx
+	bool "ISS 4xx Simulator"
+	depends on (44x || 40x)
+	default n
+	select 405GP if 40x
+	select 440GP if 44x
+	select PPC_FPU
+	select OF_RTC
+	help
+	  This option enables support for the IBM ISS simulation environment
+
 #config LUAN
 #	bool "Luan"
 #	depends on PPC_44x_46x
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index ee6185a..82ff326 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
 obj-$(CONFIG_XILINX_ML510) += virtex_ml510.o
+obj-$(CONFIG_ISS4xx)	+= iss4xx.o
diff --git a/arch/powerpc/platforms/44x/iss4xx.c b/arch/powerpc/platforms/44x/iss4xx.c
new file mode 100644
index 0000000..c9a13c6
--- /dev/null
+++ b/arch/powerpc/platforms/44x/iss4xx.c
@@ -0,0 +1,165 @@
+/*
+ * PPC476 board specific routines
+ *
+ * Copyright 2010 Torez Smith, IBM Corporation.
+ *
+ * Based on earlier code:
+ *    Matt Porter <mporter@kernel.crashing.org>
+ *    Copyright 2002-2005 MontaVista Software Inc.
+ *
+ *    Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
+ *    Copyright (c) 2003-2005 Zultys Technologies
+ *
+ *    Rewritten and ported to the merged powerpc tree:
+ *    Copyright 2007 David Gibson <dwg@au1.ibm.com>, IBM Corporation.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <linux/rtc.h>
+
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/udbg.h>
+#include <asm/time.h>
+#include <asm/uic.h>
+#include <asm/ppc4xx.h>
+#include <asm/mpic.h>
+#include <asm/mmu.h>
+
+static __initdata struct of_device_id iss4xx_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,plb6", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+static int __init iss4xx_device_probe(void)
+{
+	of_platform_bus_probe(NULL, iss4xx_of_bus, NULL);
+	of_instantiate_rtc();
+
+	return 0;
+}
+machine_device_initcall(iss4xx, iss4xx_device_probe);
+
+/* We can have either UICs or MPICs */
+static void __init iss4xx_init_irq(void)
+{
+	struct device_node *np;
+
+	/* Find top level interrupt controller */
+	for_each_node_with_property(np, "interrupt-controller") {
+		if (of_get_property(np, "interrupts", NULL) == NULL)
+			break;
+	}
+	if (np == NULL)
+		panic("Can't find top level interrupt controller");
+
+	/* Check type and do appropriate initialization */
+	if (of_device_is_compatible(np, "ibm,uic")) {
+		uic_init_tree();
+		ppc_md.get_irq = uic_get_irq;
+	} else if (of_device_is_compatible(np, "chrp,open-pic")) {
+		/* The MPIC driver will get everything it needs from the
+		 * device-tree, just pass 0 to all arguments
+		 */
+		struct mpic *mpic = mpic_alloc(np, 0, MPIC_PRIMARY, 0, 0,
+					       " MPIC     ");
+		BUG_ON(mpic == NULL);
+		mpic_init(mpic);
+		ppc_md.get_irq = mpic_get_irq;
+	} else
+		panic("Unrecognized top level interrupt controller");
+}
+
+#ifdef CONFIG_SMP
+static void __cpuinit smp_iss4xx_setup_cpu(int cpu)
+{
+	mpic_setup_this_cpu();
+}
+
+static void __cpuinit smp_iss4xx_kick_cpu(int cpu)
+{
+	struct device_node *cpunode = of_get_cpu_node(cpu, NULL);
+	const u64 *spin_table_addr_prop;
+	u32 *spin_table;
+	extern void start_secondary_47x(void);
+
+	BUG_ON(cpunode == NULL);
+
+	/* Assume spin table. We could test for the enable-method in
+	 * the device-tree but currently there's little point as it's
+	 * our only supported method
+	 */
+	spin_table_addr_prop = of_get_property(cpunode, "cpu-release-addr",
+					       NULL);
+	if (spin_table_addr_prop == NULL) {
+		pr_err("CPU%d: Can't start, missing cpu-release-addr !\n", cpu);
+		return;
+	}
+
+	/* Assume it's mapped as part of the linear mapping. This is a bit
+	 * fishy but will work fine for now
+	 */
+	spin_table = (u32 *)__va(*spin_table_addr_prop);
+	pr_debug("CPU%d: Spin table mapped at %p\n", cpu, spin_table);
+
+	spin_table[3] = cpu;
+	smp_wmb();
+	spin_table[1] = __pa(start_secondary_47x);
+	mb();
+}
+
+static struct smp_ops_t iss_smp_ops = {
+	.probe		= smp_mpic_probe,
+	.message_pass	= smp_mpic_message_pass,
+	.setup_cpu	= smp_iss4xx_setup_cpu,
+	.kick_cpu	= smp_iss4xx_kick_cpu,
+	.give_timebase	= smp_generic_give_timebase,
+	.take_timebase	= smp_generic_take_timebase,
+};
+
+static void __init iss4xx_smp_init(void)
+{
+	if (mmu_has_feature(MMU_FTR_TYPE_47x))
+		smp_ops = &iss_smp_ops;
+}
+
+#else /* CONFIG_SMP */
+static void __init iss4xx_smp_init(void) { }
+#endif /* CONFIG_SMP */
+
+static void __init iss4xx_setup_arch(void)
+{
+	iss4xx_smp_init();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init iss4xx_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ibm,iss-4xx"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(iss4xx) {
+	.name			= "ISS-4xx",
+	.probe			= iss4xx_probe,
+	.progress		= udbg_progress,
+	.init_IRQ		= iss4xx_init_irq,
+	.setup_arch		= iss4xx_setup_arch,
+	.restart		= ppc4xx_reset_system,
+	.calibrate_decr		= generic_calibrate_decr,
+};

-- 
Dave Kleikamp
IBM Linux Technology Center
