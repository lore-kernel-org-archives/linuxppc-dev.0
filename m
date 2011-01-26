Return-Path: <shaggy@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e9.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CABFB7129
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 08:51:25 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e9.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0QLQewJ011738
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:26:44 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 261B44DE8041
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 16:47:49 -0500 (EST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0QLpKbu440900
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 16:51:20 -0500
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p0QLtqPj014088
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jan 2011 14:55:52 -0700
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 5/5] powerpc/476: Create a dts files for two 476 AMP instances
	under ISS
Date: Wed, 26 Jan 2011 15:51:16 -0600
Message-Id: <1296078676-13940-6-git-send-email-shaggy@linux.vnet.ibm.com>
In-Reply-To: <1296078676-13940-1-git-send-email-shaggy@linux.vnet.ibm.com>
References: <1296078676-13940-1-git-send-email-shaggy@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Dave Kleikamp <shaggy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are completely independent OS instances, each running on 2 cores.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---
 arch/powerpc/boot/Makefile             |    9 ++-
 arch/powerpc/boot/dts/iss476-amp1.dts  |  119 ++++++++++++++++++++++++++++++
 arch/powerpc/boot/dts/iss476-amp2.dts  |  123 ++++++++++++++++++++++++++++++++
 arch/powerpc/boot/treeboot-iss4xx-hi.c |   65 +++++++++++++++++
 arch/powerpc/boot/wrapper              |    7 ++
 5 files changed, 321 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/iss476-amp1.dts
 create mode 100644 arch/powerpc/boot/dts/iss476-amp2.dts
 create mode 100644 arch/powerpc/boot/treeboot-iss4xx-hi.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 8917816..417502a 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -45,6 +45,8 @@ $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-acadia.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-iss4xx.o: BOOTCFLAGS += -mcpu=405
+$(obj)/treeboot-iss476-amp1.o: BOOTCFLAGS += -mcpu=405
+$(obj)/treeboot-iss476-amp2.o: BOOTCFLAGS += -mcpu=405
 $(obj)/virtex405-head.o: BOOTAFLAGS += -mcpu=405
 
 
@@ -78,7 +80,8 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
 		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
-		gamecube-head.S gamecube.c wii-head.S wii.c treeboot-iss4xx.c
+		gamecube-head.S gamecube.c wii-head.S wii.c treeboot-iss4xx.c \
+		treeboot-iss4xx-hi.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -208,7 +211,9 @@ image-$(CONFIG_KATMAI)			+= cuImage.katmai
 image-$(CONFIG_WARP)			+= cuImage.warp
 image-$(CONFIG_YOSEMITE)		+= cuImage.yosemite
 image-$(CONFIG_ISS4xx)			+= treeImage.iss4xx \
-					   treeImage.iss4xx-mpic
+					   treeImage.iss4xx-mpic \
+					   treeImage.iss476-amp1 \
+					   treeImage.iss476-amp2
 
 # Board ports in arch/powerpc/platform/8xx/Kconfig
 image-$(CONFIG_MPC86XADS)		+= cuImage.mpc866ads
diff --git a/arch/powerpc/boot/dts/iss476-amp1.dts b/arch/powerpc/boot/dts/iss476-amp1.dts
new file mode 100644
index 0000000..7de3485
--- /dev/null
+++ b/arch/powerpc/boot/dts/iss476-amp1.dts
@@ -0,0 +1,119 @@
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
+	compatible = "ibm,iss-4xx", "ibm,47x-AMP";
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
+
+	chosen {
+		linux,stdout-path = "/plb/opb/serial@40000200";
+	};
+};
diff --git a/arch/powerpc/boot/dts/iss476-amp2.dts b/arch/powerpc/boot/dts/iss476-amp2.dts
new file mode 100644
index 0000000..df38ee5
--- /dev/null
+++ b/arch/powerpc/boot/dts/iss476-amp2.dts
@@ -0,0 +1,123 @@
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
+/memreserve/ 0x11f00000 0x00100000;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <1>;
+	model = "ibm,iss-4xx";
+	compatible = "ibm,iss-4xx", "ibm,47x-AMP";
+	dcr-parent = <&{/cpus/cpu@2}>;
+
+	aliases {
+		serial0 = &UART0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
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
+			status = "ok";
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
+			cpu-release-addr = <0 0x11f00300>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+/*
+		reg =  <0x00000000 0x00000000 0x00000000>; // Filled in by zImage
+ */
+		reg = < 0x0 0x10000000 0x02000000 >;
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
+			UART0: serial@40001200 {
+				device_type = "serial";
+				compatible = "ns16550a";
+				reg = <0x40001200 0x00000008>;
+				virtual-reg = <0xe0001200>;
+				clock-frequency = <11059200>;
+				current-speed = <115200>;
+				interrupt-parent = <&MPIC>;
+				interrupts = <0x1 0x2>;
+			};
+		};
+	};
+
+	nvrtc {
+		compatible = "ds1743-nvram", "ds1743", "rtc-ds1743";
+		reg = <0 0xEF703000 0x2000>;
+	};
+
+	chosen {
+		bootargs = "uart_addr=0xf0001200";
+		linux,stdout-path = "/plb/opb/serial@40001200";
+	};
+};
diff --git a/arch/powerpc/boot/treeboot-iss4xx-hi.c b/arch/powerpc/boot/treeboot-iss4xx-hi.c
new file mode 100644
index 0000000..c6f376f
--- /dev/null
+++ b/arch/powerpc/boot/treeboot-iss4xx-hi.c
@@ -0,0 +1,65 @@
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
+/*
+ * Quick and dirty hack for loading a kernel at fixed address 0x10000000
+ */
+static void *iss_4xx_vmlinux_alloc(unsigned long size)
+{
+	return (void *)0x10000000;
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
+	/* platform_ops.fixups = iss_4xx_fixups; */
+	platform_ops.vmlinux_alloc = iss_4xx_vmlinux_alloc;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	pir_reg = mfspr(SPRN_PIR);
+	fdt_set_boot_cpuid_phys(_dtb_start, pir_reg);
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index cb97e75..2d2336c 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -244,6 +244,13 @@ gamecube|wii)
 treeboot-iss4xx-mpic)
     platformo="$object/treeboot-iss4xx.o"
     ;;
+treeboot-iss476-amp1)
+    platformo="$object/treeboot-iss4xx.o"
+    ;;
+treeboot-iss476-amp2)
+    platformo="$object/treeboot-iss4xx-hi.o"
+    link_address='0x10400000'
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
-- 
1.7.3.4
