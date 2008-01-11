Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 328A7DE022
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 08:09:28 +1100 (EST)
Date: Fri, 11 Jan 2008 14:07:05 -0600
From: Scott Wood <scottwood@freescale.com>
To: vitb@kernel.crashing.org, galak@kernel.crashing.org
Subject: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
Message-ID: <20080111200705.GA696@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Please pull for 2.6.25.

 arch/powerpc/Kconfig                            |    3 +
 arch/powerpc/boot/.gitignore                    |    1 +
 arch/powerpc/boot/Makefile                      |    6 +-
 arch/powerpc/boot/dts/adder875-redboot.dts      |  182 +++++
 arch/powerpc/boot/dts/adder875-uboot.dts        |  181 +++++
 arch/powerpc/boot/redboot-8xx.c                 |   58 ++
 arch/powerpc/boot/redboot.h                     |   56 ++
 arch/powerpc/boot/wrapper                       |    2 +-
 arch/powerpc/configs/adder875-redboot_defconfig |  798 +++++++++++++++++++++++
 arch/powerpc/configs/adder875-uboot_defconfig   |  798 +++++++++++++++++++++++
 arch/powerpc/platforms/8xx/Kconfig              |    9 +
 arch/powerpc/platforms/8xx/Makefile             |    1 +
 arch/powerpc/platforms/8xx/adder875.c           |  123 ++++
 13 files changed, 2216 insertions(+), 2 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/adder875-redboot.dts
 create mode 100644 arch/powerpc/boot/dts/adder875-uboot.dts
 create mode 100644 arch/powerpc/boot/redboot-8xx.c
 create mode 100644 arch/powerpc/boot/redboot.h
 create mode 100644 arch/powerpc/configs/adder875-redboot_defconfig
 create mode 100644 arch/powerpc/configs/adder875-uboot_defconfig
 create mode 100644 arch/powerpc/platforms/8xx/adder875.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 66a3d8c..47fe256 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -140,6 +140,9 @@ config DEFAULT_UIMAGE
 	  Used to allow a board to specify it wants a uImage built by default
 	default n
 
+config REDBOOT
+	bool
+
 config PPC64_SWSUSP
 	bool
 	depends on PPC64 && (BROKEN || (PPC_PMAC64 && EXPERIMENTAL))
diff --git a/arch/powerpc/boot/.gitignore b/arch/powerpc/boot/.gitignore
index 65f4118..a424be6 100644
--- a/arch/powerpc/boot/.gitignore
+++ b/arch/powerpc/boot/.gitignore
@@ -30,6 +30,7 @@ zImage.*lds
 zImage.miboot
 zImage.pmac
 zImage.pseries
+zImage.redboot*
 zImage.sandpoint
 zImage.vmode
 zconf.h
diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d1e625c..08bf7aa 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -62,7 +62,7 @@ src-plat := of.c cuboot-52xx.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
 		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c cuboot-bamboo.c \
 		fixed-head.S ep88xc.c cuboot-hpc2.c ep405.c cuboot-taishan.c \
-		cuboot-katmai.c cuboot-rainier.c
+		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -208,6 +208,10 @@ image-$(CONFIG_TAISHAN)			+= cuImage.taishan
 image-$(CONFIG_KATMAI)			+= cuImage.katmai
 endif
 
+ifneq ($(CONFIG_REDBOOT),"")
+image-$(CONFIG_PPC_8xx)			+= zImage.redboot-8xx
+endif
+
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
 ifeq ($(CONFIG_PPC32),y)
diff --git a/arch/powerpc/boot/dts/adder875-redboot.dts b/arch/powerpc/boot/dts/adder875-redboot.dts
new file mode 100644
index 0000000..8880a9b
--- /dev/null
+++ b/arch/powerpc/boot/dts/adder875-redboot.dts
@@ -0,0 +1,182 @@
+/*
+ * Device Tree Source for MPC885 ADS running RedBoot
+ *
+ * Copyright 2006 MontaVista Software, Inc.
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+/ {
+	model = "Analogue & Micro Adder MPC875";
+	compatible = "analogue-and-micro,adder875";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		console = &console;
+		enet0 = &eth0;
+		enet1 = &eth1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,875@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <16>;
+			i-cache-line-size = <16>;
+			d-cache-size = <8192>;
+			i-cache-size = <8192>;
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			interrupts = <15 2>;	// decrementer interrupt
+			interrupt-parent = <&PIC>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x01000000>;
+	};
+
+	localbus@fa200100 {
+		compatible = "fsl,mpc885-localbus", "fsl,pq1-localbus",
+		             "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xfa200100 0x40>;
+
+		ranges = <
+			0 0 0xfe000000 0x00800000
+			2 0 0xfa100000 0x00008000
+		>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x800000>;
+			bank-width = <4>;
+			device-width = <2>;
+		};
+	};
+
+	soc@fa200000 {
+		compatible = "fsl,mpc875", "fsl,pq1-soc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 0xfa200000 0x00004000>;
+
+		// Temporary until get_immrbase() is fixed.
+		reg = <0xfa200000 0x4000>;
+
+		mdio@e00 {
+			compatible = "fsl,mpc875-fec-mdio", "fsl,pq1-fec-mdio";
+			reg = <0xe00 0x188>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			PHY0: ethernet-phy@0 {
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+
+			PHY1: ethernet-phy@1 {
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		eth0: ethernet@e00 {
+			device_type = "network";
+			compatible = "fsl,mpc875-fec-enet",
+			             "fsl,pq1-fec-enet";
+			reg = <0xe00 0x188>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <3 1>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY0>;
+			linux,network-index = <0>;
+		};
+
+		eth1: ethernet@1e00 {
+			device_type = "network";
+			compatible = "fsl,mpc875-fec-enet",
+			             "fsl,pq1-fec-enet";
+			reg = <0x1e00 0x188>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <7 1>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY1>;
+			linux,network-index = <1>;
+		};
+
+		PIC: interrupt-controller@0 {
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0 0x24>;
+			compatible = "fsl,mpc875-pic", "fsl,pq1-pic";
+		};
+
+		cpm@9c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc875-cpm", "fsl,cpm1";
+			interrupts = <0>;	// cpm error interrupt
+			interrupt-parent = <&CPM_PIC>;
+			reg = <0x9c0 0x40>;
+			ranges;
+
+			muram {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x2000 0x2000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 0x1c00>;
+				};
+			};
+
+			brg@9f0 {
+				compatible = "fsl,mpc875-brg",
+				             "fsl,cpm1-brg",
+				             "fsl,cpm-brg";
+				reg = <0x9f0 0x10>;
+			};
+
+			CPM_PIC: interrupt-controller@930 {
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupts = <5 2 0 2>;
+				interrupt-parent = <&PIC>;
+				reg = <0x930 0x20>;
+				compatible = "fsl,mpc875-cpm-pic",
+				             "fsl,cpm1-pic";
+			};
+
+			console: serial@a80 {
+				device_type = "serial";
+				compatible = "fsl,mpc875-smc-uart",
+				             "fsl,cpm1-smc-uart";
+				reg = <0xa80 0x10 0x3e80 0x40>;
+				interrupts = <4>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0x0090>;
+				current-speed = <115200>;
+			};
+		};
+	};
+
+	chosen {
+		linux,stdout-path = &console;
+	};
+};
diff --git a/arch/powerpc/boot/dts/adder875-uboot.dts b/arch/powerpc/boot/dts/adder875-uboot.dts
new file mode 100644
index 0000000..c1b4bf9
--- /dev/null
+++ b/arch/powerpc/boot/dts/adder875-uboot.dts
@@ -0,0 +1,181 @@
+/*
+ * Device Tree Source for MPC885 ADS running U-Boot
+ *
+ * Copyright 2006 MontaVista Software, Inc.
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/dts-v1/;
+/ {
+	model = "Analogue & Micro Adder MPC875";
+	compatible = "analogue-and-micro,adder875";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		console = &console;
+		enet0 = &eth0;
+		enet1 = &eth1;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,875@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <16>;
+			i-cache-line-size = <16>;
+			d-cache-size = <8192>;
+			i-cache-size = <8192>;
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			interrupts = <15 2>;	// decrementer interrupt
+			interrupt-parent = <&PIC>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x01000000>;
+	};
+
+	localbus@ff000100 {
+		compatible = "fsl,mpc885-localbus", "fsl,pq1-localbus",
+		             "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <0xff000100 0x40>;
+
+		ranges = <
+			0 0 0xfe000000 0x01000000
+		>;
+
+		flash@0,0 {
+			compatible = "cfi-flash";
+			reg = <0 0 0x800000>;
+			bank-width = <4>;
+			device-width = <2>;
+		};
+	};
+
+	soc@ff000000 {
+		compatible = "fsl,mpc875", "fsl,pq1-soc", "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 0xff000000 0x00004000>;
+
+		// Temporary until get_immrbase() is fixed.
+		reg = <0xff000000 0x4000>;
+
+		mdio@e00 {
+			compatible = "fsl,mpc875-fec-mdio", "fsl,pq1-fec-mdio";
+			reg = <0xe00 0x188>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			PHY0: ethernet-phy@0 {
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+
+			PHY1: ethernet-phy@1 {
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		eth0: ethernet@e00 {
+			device_type = "network";
+			compatible = "fsl,mpc875-fec-enet",
+			             "fsl,pq1-fec-enet";
+			reg = <0xe00 0x188>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <3 1>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY0>;
+			linux,network-index = <0>;
+		};
+
+		eth1: ethernet@1e00 {
+			device_type = "network";
+			compatible = "fsl,mpc875-fec-enet",
+			             "fsl,pq1-fec-enet";
+			reg = <0x1e00 0x188>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <7 1>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY1>;
+			linux,network-index = <1>;
+		};
+
+		PIC: interrupt-controller@0 {
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0 0x24>;
+			compatible = "fsl,mpc875-pic", "fsl,pq1-pic";
+		};
+
+		cpm@9c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc875-cpm", "fsl,cpm1";
+			interrupts = <0>;	// cpm error interrupt
+			interrupt-parent = <&CPM_PIC>;
+			reg = <0x9c0 0x40>;
+			ranges;
+
+			muram {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0 0x2000 0x2000>;
+
+				data@0 {
+					compatible = "fsl,cpm-muram-data";
+					reg = <0 0x1c00>;
+				};
+			};
+
+			brg@9f0 {
+				compatible = "fsl,mpc875-brg",
+				             "fsl,cpm1-brg",
+				             "fsl,cpm-brg";
+				reg = <0x9f0 0x10>;
+			};
+
+			CPM_PIC: interrupt-controller@930 {
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupts = <5 2 0 2>;
+				interrupt-parent = <&PIC>;
+				reg = <0x930 0x20>;
+				compatible = "fsl,mpc875-cpm-pic",
+				             "fsl,cpm1-pic";
+			};
+
+			console: serial@a80 {
+				device_type = "serial";
+				compatible = "fsl,mpc875-smc-uart",
+				             "fsl,cpm1-smc-uart";
+				reg = <0xa80 0x10 0x3e80 0x40>;
+				interrupts = <4>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0x0090>;
+				current-speed = <115200>;
+			};
+		};
+	};
+
+	chosen {
+		linux,stdout-path = &console;
+	};
+};
diff --git a/arch/powerpc/boot/redboot-8xx.c b/arch/powerpc/boot/redboot-8xx.c
new file mode 100644
index 0000000..f7945ad
--- /dev/null
+++ b/arch/powerpc/boot/redboot-8xx.c
@@ -0,0 +1,58 @@
+/*
+ * RedBoot firmware support
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include "ops.h"
+#include "stdio.h"
+#include "redboot.h"
+#include "fsl-soc.h"
+#include "io.h"
+
+static bd_t bd;
+BSS_STACK(4096);
+
+#define MHZ(x)	((x + 500000) / 1000000)
+
+static void platform_fixups(void)
+{
+	void *node;
+
+	dt_fixup_memory(bd.bi_memstart, bd.bi_memsize);
+	dt_fixup_mac_addresses(bd.bi_enetaddr);
+	dt_fixup_cpu_clocks(bd.bi_intfreq, bd.bi_busfreq / 16, bd.bi_busfreq);
+
+	node = finddevice("/soc/cpm/brg");
+	if (node) {
+		printf("BRG clock-frequency <- 0x%x (%dMHz)\r\n",
+		       bd.bi_busfreq, MHZ(bd.bi_busfreq));
+		setprop(node, "clock-frequency",  &bd.bi_busfreq, 4);
+	}
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	memcpy(&bd, (char *)r3, sizeof(bd));
+
+	if (bd.bi_tag != 0x42444944)
+		return;
+
+	simple_alloc_init(_end,
+	                  bd.bi_memstart + bd.bi_memsize - (unsigned long)_end,
+	                  32, 64);
+
+	fdt_init(_dtb_start);
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+
+	loader_info.cmdline = (char *)bd.bi_cmdline;
+	loader_info.cmdline_len = strlen((char *)bd.bi_cmdline);
+}
diff --git a/arch/powerpc/boot/redboot.h b/arch/powerpc/boot/redboot.h
new file mode 100644
index 0000000..ace0b7f
--- /dev/null
+++ b/arch/powerpc/boot/redboot.h
@@ -0,0 +1,56 @@
+#ifndef _PPC_REDBOOT_H
+#define _PPC_REDBOOT_H
+
+//=========================================================================
+// include/asm-ppc/redboot.h
+//   Copyright (c) 2002, 2003 Gary Thomas (<gary@mlbassoc.com>
+//   Copyright (c) 1997 Dan Malek (dmalek@jlc.net)
+
+//
+// Board specific details, as provided by RedBoot
+//
+
+/* A Board Information structure that is given to a program when
+ * RedBoot starts it up.  Note: not all fields make sense for all
+ * architectures and it's up to the platform specific code to fill
+ * in the details.
+ */
+typedef struct bd_info {
+    unsigned int   bi_tag;        /* Should be 0x42444944 "BDID" */
+    unsigned int   bi_size;       /* Size of this structure */
+    unsigned int   bi_revision;   /* revision of this structure */
+    unsigned int   bi_bdate;      /* bootstrap date, i.e. 0x19971106 */
+    unsigned int   bi_memstart;   /* Memory start address */
+    unsigned int   bi_memsize;    /* Memory (end) size in bytes */
+    unsigned int   bi_intfreq;    /* Internal Freq, in Hz */
+    unsigned int   bi_busfreq;    /* Bus Freq, in Hz */
+    unsigned int   bi_cpmfreq;    /* CPM Freq, in Hz */
+    unsigned int   bi_brgfreq;    /* BRG Freq, in Hz */
+    unsigned int   bi_vco;        /* VCO Out from PLL */
+    unsigned int   bi_pci_freq;   /* PCI Freq, in Hz */
+    unsigned int   bi_baudrate;   /* Default console baud rate */
+    unsigned int   bi_immr;       /* IMMR when called from boot rom */
+    unsigned char  bi_enetaddr[6];
+    unsigned int   bi_flashbase;  /* Physical address of FLASH memory */
+    unsigned int   bi_flashsize;  /* Length of FLASH memory */
+    int            bi_flashwidth; /* Width (8,16,32,64) */
+    unsigned char *bi_cmdline;    /* Pointer to command line */
+    unsigned char  bi_esa[3][6];  /* Ethernet station addresses */
+    unsigned int   bi_ramdisk_begin, bi_ramdisk_end;
+    struct {                      /* Information about [main] video screen */
+        short x_res;              /*   Horizontal resolution in pixels */
+        short y_res;              /*   Vertical resolution in pixels */
+        short bpp;                /*   Bits/pixel */
+        short mode;               /*   Type of pixels (packed, indexed) */
+        unsigned long fb;         /*   Pointer to frame buffer (pixel) memory */
+    } bi_video;
+    void         (*bi_cputc)(char);   /* Write a character to the RedBoot console */
+    char         (*bi_cgetc)(void);   /* Read a character from the RedBoot console */
+    int          (*bi_ctstc)(void);   /* Test for input on the RedBoot console */
+} bd_t;
+
+#define BI_REV 0x0102    /* Version 1.02 */
+
+#define bi_pci_busfreq bi_pci_freq
+#define bi_immr_base   bi_immr
+#endif
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 154df05..a7c4671 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -168,7 +168,7 @@ ps3)
     ksection=.kernel:vmlinux.bin
     isection=.kernel:initrd
     ;;
-ep88xc|ep405)
+ep88xc|ep405|redboot*)
     platformo="$object/fixed-head.o $object/$platform.o"
     binary=y
     ;;
diff --git a/arch/powerpc/configs/adder875-redboot_defconfig b/arch/powerpc/configs/adder875-redboot_defconfig
new file mode 100644
index 0000000..ceda44d
--- /dev/null
+++ b/arch/powerpc/configs/adder875-redboot_defconfig
@@ -0,0 +1,798 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.24-rc3
+# Mon Dec 10 11:29:32 2007
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+# CONFIG_PPC_85xx is not set
+CONFIG_PPC_8xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_8xx=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=y
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_OF=y
+# CONFIG_PPC_UDBG_16550 is not set
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+# CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_REDBOOT=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+# CONFIG_ELF_CORE is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=1
+# CONFIG_MODULES is not set
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+CONFIG_DEFAULT_DEADLINE=y
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="deadline"
+
+#
+# Platform support
+#
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+CONFIG_CPM1=y
+# CONFIG_MPC8XXFADS is not set
+# CONFIG_MPC86XADS is not set
+# CONFIG_MPC885ADS is not set
+# CONFIG_PPC_EP88XC is not set
+CONFIG_PPC_ADDER875=y
+
+#
+# MPC8xx CPM Options
+#
+
+#
+# Generic MPC8xx Options
+#
+CONFIG_8xx_COPYBACK=y
+# CONFIG_8xx_CPU6 is not set
+CONFIG_8xx_CPU15=y
+CONFIG_NO_UCODE_PATCH v3=y
+# CONFIG_USB_SOF_UCODE_PATCH v3 is not set
+# CONFIG_I2C_SPI_UCODE_PATCH v3 is not set
+# CONFIG_I2C_SPI_SMC1_UCODE_PATCH v3 is not set
+# CONFIG_PQ2ADS is not set
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_CPM2 is not set
+CONFIG_PPC_CPM_NEW_BINDING=y
+# CONFIG_FSL_ULI1575 is not set
+CONFIG_CPM=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_8XX_MINIMAL_FPEMU is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_PROC_DEVICETREE is not set
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
+# CONFIG_SECCOMP is not set
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="adder875-redboot.dts"
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_FSL_SOC=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_PCI_QSPAN is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START=0xfd000000
+CONFIG_CONSISTENT_SIZE=0x00200000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_PARTITIONS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_CFI_FLAGADM is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+CONFIG_OF_DEVICE=y
+# CONFIG_PARPORT is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_MISC_DEVICES is not set
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+CONFIG_DAVICOM_PHY=y
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FEC=y
+CONFIG_FS_ENET_MDIO_FEC=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+CONFIG_MOUSE_PS2_ALPS=y
+CONFIG_MOUSE_PS2_LOGIPS2PP=y
+CONFIG_MOUSE_PS2_SYNAPTICS=y
+CONFIG_MOUSE_PS2_LIFEBOOK=y
+CONFIG_MOUSE_PS2_TRACKPOINT=y
+# CONFIG_MOUSE_PS2_TOUCHKIT is not set
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+# CONFIG_SERIAL_CPM_SCC1 is not set
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+CONFIG_SERIAL_CPM_SMC1=y
+CONFIG_SERIAL_CPM_SMC2=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+
+#
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+CONFIG_CRAMFS=y
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
+# CONFIG_NLS is not set
+# CONFIG_DLM is not set
+# CONFIG_UCC_SLOW is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+# CONFIG_CRC32 is not set
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_INSTRUMENTATION=y
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_CRYPTO is not set
+# CONFIG_PPC_CLOCK is not set
+CONFIG_PPC_LIB_RHEAP=y
diff --git a/arch/powerpc/configs/adder875-uboot_defconfig b/arch/powerpc/configs/adder875-uboot_defconfig
new file mode 100644
index 0000000..bb97223
--- /dev/null
+++ b/arch/powerpc/configs/adder875-uboot_defconfig
@@ -0,0 +1,798 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.24-rc3
+# Mon Dec 10 11:29:32 2007
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+# CONFIG_6xx is not set
+# CONFIG_PPC_85xx is not set
+CONFIG_PPC_8xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_8xx=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_NOT_COHERENT_CACHE=y
+CONFIG_PPC32=y
+CONFIG_WORD_SIZE=32
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_TIME_VSYSCALL=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_ARCH_HAS_ILOG2_U32=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_OF=y
+# CONFIG_PPC_UDBG_16550 is not set
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+# CONFIG_DEFAULT_UIMAGE is not set
+CONFIG_REDBOOT=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_USER_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_CGROUPS is not set
+CONFIG_FAIR_GROUP_SCHED=y
+CONFIG_FAIR_USER_SCHED=y
+# CONFIG_FAIR_CGROUP_SCHED is not set
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+# CONFIG_ELF_CORE is not set
+# CONFIG_BASE_FULL is not set
+# CONFIG_FUTEX is not set
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_SLUB_DEBUG=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=1
+# CONFIG_MODULES is not set
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+CONFIG_DEFAULT_DEADLINE=y
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="deadline"
+
+#
+# Platform support
+#
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+CONFIG_CPM1=y
+# CONFIG_MPC8XXFADS is not set
+# CONFIG_MPC86XADS is not set
+# CONFIG_MPC885ADS is not set
+# CONFIG_PPC_EP88XC is not set
+CONFIG_PPC_ADDER875=y
+
+#
+# MPC8xx CPM Options
+#
+
+#
+# Generic MPC8xx Options
+#
+CONFIG_8xx_COPYBACK=y
+# CONFIG_8xx_CPU6 is not set
+CONFIG_8xx_CPU15=y
+CONFIG_NO_UCODE_PATCH v3=y
+# CONFIG_USB_SOF_UCODE_PATCH v3 is not set
+# CONFIG_I2C_SPI_UCODE_PATCH v3 is not set
+# CONFIG_I2C_SPI_SMC1_UCODE_PATCH v3 is not set
+# CONFIG_PQ2ADS is not set
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+# CONFIG_PPC_RTAS is not set
+# CONFIG_MMIO_NVRAM is not set
+# CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
+# CONFIG_PPC_INDIRECT_IO is not set
+# CONFIG_GENERIC_IOMAP is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_CPM2 is not set
+CONFIG_PPC_CPM_NEW_BINDING=y
+# CONFIG_FSL_ULI1575 is not set
+CONFIG_CPM=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_TICK_ONESHOT is not set
+# CONFIG_NO_HZ is not set
+# CONFIG_HIGH_RES_TIMERS is not set
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_MATH_EMULATION is not set
+# CONFIG_8XX_MINIMAL_FPEMU is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+# CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+# CONFIG_PROC_DEVICETREE is not set
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+CONFIG_SUSPEND_UP_POSSIBLE=y
+CONFIG_HIBERNATION_UP_POSSIBLE=y
+# CONFIG_SECCOMP is not set
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="adder875-uboot.dts"
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_FSL_SOC=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_SYSCALL is not set
+# CONFIG_PCI_QSPAN is not set
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+# CONFIG_ADVANCED_OPTIONS is not set
+
+#
+# Default settings for advanced configuration options are used
+#
+CONFIG_HIGHMEM_START=0xfe000000
+CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_KERNEL_START=0xc0000000
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_CONSISTENT_START=0xfd000000
+CONFIG_CONSISTENT_SIZE=0x00200000
+CONFIG_BOOT_LOAD=0x00400000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_MAC80211 is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_PARTITIONS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_CFI_FLAGADM is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+# CONFIG_MTD_NAND is not set
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+CONFIG_OF_DEVICE=y
+# CONFIG_PARPORT is not set
+# CONFIG_BLK_DEV is not set
+# CONFIG_MISC_DEVICES is not set
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+CONFIG_DAVICOM_PHY=y
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_B44 is not set
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FEC=y
+CONFIG_FS_ENET_MDIO_FEC=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_ATKBD=y
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+CONFIG_MOUSE_PS2_ALPS=y
+CONFIG_MOUSE_PS2_LOGIPS2PP=y
+CONFIG_MOUSE_PS2_SYNAPTICS=y
+CONFIG_MOUSE_PS2_LIFEBOOK=y
+CONFIG_MOUSE_PS2_TRACKPOINT=y
+# CONFIG_MOUSE_PS2_TOUCHKIT is not set
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+# CONFIG_SERIAL_8250 is not set
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+# CONFIG_SERIAL_CPM_SCC1 is not set
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+CONFIG_SERIAL_CPM_SMC1=y
+CONFIG_SERIAL_CPM_SMC2=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
+# CONFIG_IPMI_HANDLER is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+# CONFIG_HWMON is not set
+# CONFIG_WATCHDOG is not set
+
+#
+# Sonics Silicon Backplane
+#
+CONFIG_SSB_POSSIBLE=y
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+CONFIG_DAB=y
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+
+#
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
+# File systems
+#
+# CONFIG_EXT2_FS is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4DEV_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_GFS2_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_INOTIFY is not set
+# CONFIG_QUOTA is not set
+# CONFIG_DNOTIFY is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_JFFS2_FS is not set
+CONFIG_CRAMFS=y
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SUNRPC_BIND34 is not set
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+# CONFIG_SYSV68_PARTITION is not set
+# CONFIG_NLS is not set
+# CONFIG_DLM is not set
+# CONFIG_UCC_SLOW is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+# CONFIG_CRC32 is not set
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_INSTRUMENTATION=y
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_MAGIC_SYSRQ=y
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_SLUB_DEBUG_ON is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_SAMPLES is not set
+# CONFIG_DEBUG_STACKOVERFLOW is not set
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+# CONFIG_SECURITY_FILE_CAPABILITIES is not set
+# CONFIG_CRYPTO is not set
+# CONFIG_PPC_CLOCK is not set
+CONFIG_PPC_LIB_RHEAP=y
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 91fbe42..7fd224c 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -44,6 +44,15 @@ config PPC_EP88XC
 	  This board is also resold by Freescale as the QUICCStart
 	  MPC885 Evaluation System and/or the CWH-PPC-885XN-VE.
 
+config PPC_ADDER875
+	bool "Analogue & Micro Adder 875"
+	select CPM1
+	select PPC_CPM_NEW_BINDING
+	select REDBOOT
+	help
+	  This enables support for the Analogue & Micro Adder 875
+	  board.
+
 endchoice
 
 menu "Freescale Ethernet driver platform-specific options"
diff --git a/arch/powerpc/platforms/8xx/Makefile b/arch/powerpc/platforms/8xx/Makefile
index 8b70980..7b71d9c 100644
--- a/arch/powerpc/platforms/8xx/Makefile
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_PPC_8xx)	  += m8xx_setup.o
 obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
 obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
 obj-$(CONFIG_PPC_EP88XC)  += ep88xc.o
+obj-$(CONFIG_PPC_ADDER875) += adder875.o
diff --git a/arch/powerpc/platforms/8xx/adder875.c b/arch/powerpc/platforms/8xx/adder875.c
new file mode 100644
index 0000000..3a3bb2b
--- /dev/null
+++ b/arch/powerpc/platforms/8xx/adder875.c
@@ -0,0 +1,123 @@
+/* Analogue & Micro Adder MPC875 board support
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Copyright (c) 2007 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/fs_enet_pd.h>
+#include <linux/of_platform.h>
+
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/commproc.h>
+#include <asm/fs_pd.h>
+#include <asm/udbg.h>
+#include <asm/prom.h>
+
+#include <sysdev/commproc.h>
+
+struct cpm_pin {
+	int port, pin, flags;
+};
+
+static const struct cpm_pin adder875_pins[] = {
+	/* SMC1 */
+	{CPM_PORTB, 24, CPM_PIN_INPUT}, /* RX */
+	{CPM_PORTB, 25, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
+
+	/* MII1 */
+	{CPM_PORTA, 0, CPM_PIN_INPUT},
+	{CPM_PORTA, 1, CPM_PIN_INPUT},
+	{CPM_PORTA, 2, CPM_PIN_INPUT},
+	{CPM_PORTA, 3, CPM_PIN_INPUT},
+	{CPM_PORTA, 4, CPM_PIN_OUTPUT},
+	{CPM_PORTA, 10, CPM_PIN_OUTPUT},
+	{CPM_PORTA, 11, CPM_PIN_OUTPUT},
+	{CPM_PORTB, 19, CPM_PIN_INPUT},
+	{CPM_PORTB, 31, CPM_PIN_INPUT},
+	{CPM_PORTC, 12, CPM_PIN_INPUT},
+	{CPM_PORTC, 13, CPM_PIN_INPUT},
+	{CPM_PORTE, 30, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 31, CPM_PIN_OUTPUT},
+
+	/* MII2 */
+	{CPM_PORTE, 14, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{CPM_PORTE, 15, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{CPM_PORTE, 16, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 17, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{CPM_PORTE, 18, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{CPM_PORTE, 19, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{CPM_PORTE, 20, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{CPM_PORTE, 21, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 22, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 23, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 24, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 25, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 26, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 27, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 28, CPM_PIN_OUTPUT},
+	{CPM_PORTE, 29, CPM_PIN_OUTPUT},
+};
+
+static void __init init_ioports(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(adder875_pins); i++) {
+		const struct cpm_pin *pin = &adder875_pins[i];
+		cpm1_set_pin(pin->port, pin->pin, pin->flags);
+	}
+
+	cpm1_clk_setup(CPM_CLK_SMC1, CPM_BRG1, CPM_CLK_RTX);
+
+	/* Set FEC1 and FEC2 to MII mode */
+	clrbits32(&mpc8xx_immr->im_cpm.cp_cptr, 0x00000180);
+}
+
+static void __init adder875_setup(void)
+{
+	cpm_reset();
+	init_ioports();
+}
+
+static int __init adder875_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "analogue-and-micro,adder875");
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "cpm", },
+	{ .name = "localbus", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	/* Publish the QE devices */
+	if (machine_is(adder875))
+		of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+device_initcall(declare_of_platform_devices);
+
+define_machine(adder875) {
+	.name = "Adder MPC875",
+	.probe = adder875_probe,
+	.setup_arch = adder875_setup,
+	.init_IRQ = m8xx_pic_init,
+	.get_irq = mpc8xx_get_irq,
+	.restart = mpc8xx_restart,
+	.calibrate_decr = generic_calibrate_decr,
+	.set_rtc_time = mpc8xx_set_rtc_time,
+	.get_rtc_time = mpc8xx_get_rtc_time,
+	.progress = udbg_progress,
+};
-- 
1.5.3.8
