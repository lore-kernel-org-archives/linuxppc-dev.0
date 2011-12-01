Return-Path: <tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=208/8=5D=2044x/currituck=3A=20Add=20support=20for=20the=20new=20IBM=20currituck=20platform?=
Date: Thu,  1 Dec 2011 18:39:24 +1100
Message-Id: <1322725164-4391-9-git-send-email-tony@bakeyournoodle.com>
In-Reply-To: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
References: <1322725164-4391-1-git-send-email-tony@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Based on original work by David 'Shaggy' Kliekamp.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/boot/Makefile                   |    5 +-
 arch/powerpc/boot/dts/currituck.dts          |  237 ++++++++++++++++++++++++++
 arch/powerpc/boot/treeboot-currituck.c       |  119 +++++++++++++
 arch/powerpc/boot/wrapper                    |    3 +
 arch/powerpc/configs/44x/currituck_defconfig |  110 ++++++++++++
 arch/powerpc/platforms/44x/Kconfig           |   10 +
 arch/powerpc/platforms/44x/Makefile          |    1 +
 arch/powerpc/platforms/44x/currituck.c       |  204 ++++++++++++++++++++++
 8 files changed, 688 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/currituck.dts
 create mode 100644 arch/powerpc/boot/treeboot-currituck.c
 create mode 100644 arch/powerpc/configs/44x/currituck_defconfig
 create mode 100644 arch/powerpc/platforms/44x/currituck.c

Much of the currituck.c code could go into ppc44x_simple.c but that makes
finding a home for the quirk code harder.  We can always move it there later.

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 72ee8c1..ff0057f 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -45,6 +45,7 @@ $(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
 $(obj)/cuboot-acadia.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405
 $(obj)/treeboot-iss4xx.o: BOOTCFLAGS += -mcpu=405
+$(obj)/treeboot-currituck.o: BOOTCFLAGS += -mcpu=405
 $(obj)/virtex405-head.o: BOOTAFLAGS += -mcpu=405
 
 
@@ -79,7 +80,8 @@ src-plat := of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c holly.c
 		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
 		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
 		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
-		gamecube-head.S gamecube.c wii-head.S wii.c treeboot-iss4xx.c
+		gamecube-head.S gamecube.c wii-head.S wii.c treeboot-iss4xx.c \
+		treeboot-currituck.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -212,6 +214,7 @@ image-$(CONFIG_WARP)			+= cuImage.warp
 image-$(CONFIG_YOSEMITE)		+= cuImage.yosemite
 image-$(CONFIG_ISS4xx)			+= treeImage.iss4xx \
 					   treeImage.iss4xx-mpic
+image-$(CONFIG_CURRITUCK)			+= treeImage.currituck
 
 # Board ports in arch/powerpc/platform/8xx/Kconfig
 image-$(CONFIG_MPC86XADS)		+= cuImage.mpc866ads
diff --git a/arch/powerpc/boot/dts/currituck.dts b/arch/powerpc/boot/dts/currituck.dts
new file mode 100644
index 0000000..b801dd0
--- /dev/null
+++ b/arch/powerpc/boot/dts/currituck.dts
@@ -0,0 +1,237 @@
+/*
+ * Device Tree Source for IBM Embedded PPC 476 Platform
+ *
+ * Copyright © 2011 Tony Breeds IBM Corporation
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/memreserve/ 0x01f00000 0x00100000;	// spin table
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "ibm,currituck";
+	compatible = "ibm,currituck";
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
+			model = "PowerPC,476";
+			reg = <0>;
+			clock-frequency = <1600000000>; // 1.6 GHz
+			timebase-frequency = <100000000>; // 100Mhz
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
+			model = "PowerPC,476";
+			reg = <1>;
+			clock-frequency = <1600000000>; // 1.6 GHz
+			timebase-frequency = <100000000>; // 100Mhz
+			i-cache-line-size = <32>;
+			d-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			dcr-controller;
+			dcr-access-method = "native";
+			status = "disabled";
+			enable-method = "spin-table";
+			cpu-release-addr = <0x0 0x01f00000>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x0 0x0 0x0>; // filled in by zImage
+	};
+
+	MPIC: interrupt-controller {
+		compatible = "chrp,open-pic";
+		interrupt-controller;
+		dcr-reg = <0xffc00000 0x00040000>;
+		#address-cells = <0>;
+		#size-cells = <0>;
+		#interrupt-cells = <2>;
+
+	};
+
+	plb {
+		compatible = "ibm,plb6";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		clock-frequency = <200000000>; // 200Mhz
+
+		POB0: opb {
+			compatible = "ibm,opb-4xx", "ibm,opb";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* Wish there was a nicer way of specifying a full
+			 * 32-bit range
+			 */
+			ranges = <0x00000000 0x00000200 0x00000000 0x80000000
+				  0x80000000 0x00000200 0x80000000 0x80000000>;
+			clock-frequency = <100000000>;
+
+			UART0: serial@10000000 {
+				device_type = "serial";
+				compatible = "ns16750", "ns16550";
+				reg = <0x10000000 0x00000008>;
+				virtual-reg = <0xe1000000>;
+				clock-frequency = <1851851>; // PCIe refclk/MCGC0_CTL[UART]
+				current-speed = <115200>;
+				interrupt-parent = <&MPIC>;
+				interrupts = <34 2>;
+			};
+
+			IIC0: i2c@00000000 {
+				compatible = "ibm,iic-currituck", "ibm,iic";
+				reg = <0x0 0x00000014>;
+				interrupt-parent = <&MPIC>;
+				interrupts = <79 2>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+                                rtc@68 {
+                                        compatible = "stm,m41t80", "m41st85";
+                                        reg = <0x68>;
+                                };
+			};
+		};
+
+		PCIE0: pciex@10100000000 {		// 4xGBIF1
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-476fpe", "ibm,plb-pciex";
+			primary;
+			port = <0x0>; /* port number */
+			reg = <0x00000101 0x00000000 0x0 0x10000000		/* Config space access */
+			       0x00000100 0x00000000 0x0 0x00001000>;	/* UTL Registers space access */
+			dcr-reg = <0x80 0x20>;
+
+//                                pci_space  < pci_addr          > < cpu_addr          > < size       >
+			ranges = <0x02000000 0x00000000 0x80000000 0x00000110 0x80000000 0x0 0x80000000
+			          0x01000000 0x0        0x0        0x00000140 0x0        0x0 0x00010000>;
+
+			/* Inbound starting at 0 to memsize filled in by zImage */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x0>;
+
+			/* This drives busses 0 to 0xf */
+			bus-range = <0x0 0xf>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <
+				0x0 0x0 0x0 0x1 &MPIC 46 0x2 /* int A */
+				0x0 0x0 0x0 0x2 &MPIC 47 0x2 /* int B */
+				0x0 0x0 0x0 0x3 &MPIC 48 0x2 /* int C */
+				0x0 0x0 0x0 0x4 &MPIC 49 0x2 /* int D */>;
+		};
+
+		PCIE1: pciex@30100000000 {		// 4xGBIF0
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-476fpe", "ibm,plb-pciex";
+			primary;
+			port = <0x1>; /* port number */
+			reg = <0x00000301 0x00000000 0x0 0x10000000		/* Config space access */
+			       0x00000300 0x00000000 0x0 0x00001000>;	/* UTL Registers space access */
+			dcr-reg = <0x60 0x20>;
+
+			ranges = <0x02000000 0x00000000 0x80000000 0x00000310 0x80000000 0x0 0x80000000
+			          0x01000000 0x0        0x0        0x00000340 0x0        0x0 0x00010000>;
+
+			/* Inbound starting at 0 to memsize filled in by zImage */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x0>;
+
+			/* This drives busses 0 to 0xf */
+			bus-range = <0x0 0xf>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <
+				0x0 0x0 0x0 0x1 &MPIC 38 0x2 /* int A */
+				0x0 0x0 0x0 0x2 &MPIC 39 0x2 /* int B */
+				0x0 0x0 0x0 0x3 &MPIC 40 0x2 /* int C */
+				0x0 0x0 0x0 0x4 &MPIC 41 0x2 /* int D */>;
+		};
+
+		PCIE2: pciex@38100000000 {		// 2xGBIF0
+			device_type = "pci";
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "ibm,plb-pciex-476fpe", "ibm,plb-pciex";
+			primary;
+			port = <0x2>; /* port number */
+			reg = <0x00000381 0x00000000 0x0 0x10000000		/* Config space access */
+			       0x00000380 0x00000000 0x0 0x00001000>;	/* UTL Registers space access */
+			dcr-reg = <0xA0 0x20>;
+
+			ranges = <0x02000000 0x00000000 0x80000000 0x00000390 0x80000000 0x0 0x80000000
+			          0x01000000 0x0        0x0        0x000003C0 0x0        0x0 0x00010000>;
+
+			/* Inbound starting at 0 to memsize filled in by zImage */
+			dma-ranges = <0x42000000 0x0 0x0 0x0 0x0 0x0 0x0>;
+
+			/* This drives busses 0 to 0xf */
+			bus-range = <0x0 0xf>;
+
+			/* Legacy interrupts (note the weird polarity, the bridge seems
+			 * to invert PCIe legacy interrupts).
+			 * We are de-swizzling here because the numbers are actually for
+			 * port of the root complex virtual P2P bridge. But I want
+			 * to avoid putting a node for it in the tree, so the numbers
+			 * below are basically de-swizzled numbers.
+			 * The real slot is on idsel 0, so the swizzling is 1:1
+			 */
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <
+				0x0 0x0 0x0 0x1 &MPIC 54 0x2 /* int A */
+				0x0 0x0 0x0 0x2 &MPIC 55 0x2 /* int B */
+				0x0 0x0 0x0 0x3 &MPIC 56 0x2 /* int C */
+				0x0 0x0 0x0 0x4 &MPIC 57 0x2 /* int D */>;
+		};
+
+	};
+
+	chosen {
+		linux,stdout-path = &UART0;
+	};
+};
diff --git a/arch/powerpc/boot/treeboot-currituck.c b/arch/powerpc/boot/treeboot-currituck.c
new file mode 100644
index 0000000..925ae43
--- /dev/null
+++ b/arch/powerpc/boot/treeboot-currituck.c
@@ -0,0 +1,119 @@
+/*
+ * Copyright © 2011 Tony Breeds IBM Corporation
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
+ *    Copyright 2010 Ben. Herrenschmidt, IBM Corporation.
+ *    Copyright © 2011 David Kleikamp IBM Corporation
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
+#define MAX_RANKS	0x4
+#define DDR3_MR0CF	0x80010011U
+
+static unsigned long long ibm_currituck_memsize;
+static unsigned long long ibm_currituck_detect_memsize(void)
+{
+	u32 reg;
+	unsigned i;
+	unsigned long long memsize = 0;
+
+	for(i = 0; i < MAX_RANKS; i++){
+		reg = mfdcrx(DDR3_MR0CF + i);
+
+		if (!(reg & 1))
+			continue;
+
+		reg &= 0x0000f000;
+		reg >>= 12;
+		memsize += (0x800000ULL << reg);
+	}
+
+	return memsize;
+}
+
+static void ibm_currituck_fixups(void)
+{
+	void *devp = finddevice("/");
+	u32 dma_ranges[7];
+
+	dt_fixup_memory(0x0ULL,  ibm_currituck_memsize);
+
+	while ((devp = find_node_by_devtype(devp, "pci"))) {
+		if (getprop(devp, "dma-ranges", dma_ranges, sizeof(dma_ranges)) < 0) {
+			printf("%s: Failed to get dma-ranges\r\n", __func__);
+			continue;
+		}
+
+		dma_ranges[5] = ibm_currituck_memsize >> 32;
+		dma_ranges[6] = ibm_currituck_memsize & 0xffffffffUL;
+
+		setprop(devp, "dma-ranges", dma_ranges, sizeof(dma_ranges));
+	}
+}
+
+#define SPRN_PIR	0x11E	/* Processor Indentification Register */
+void platform_init(void)
+{
+	unsigned long end_of_ram, avail_ram;
+	u32 pir_reg;
+	int node, size;
+	const u32 *timebase;
+
+	ibm_currituck_memsize = ibm_currituck_detect_memsize();
+	if (ibm_currituck_memsize >> 32)
+		end_of_ram = ~0UL;
+	else
+		end_of_ram = ibm_currituck_memsize;
+	avail_ram = end_of_ram - (unsigned long)_end;
+
+	simple_alloc_init(_end, avail_ram, 128, 64);
+	platform_ops.fixups = ibm_currituck_fixups;
+	platform_ops.exit = ibm44x_dbcr_reset;
+	pir_reg = mfspr(SPRN_PIR);
+
+	/* Make sure FDT blob is sane */
+	if (fdt_check_header(_dtb_start) != 0)
+		fatal("Invalid device tree blob\n");
+
+	node = fdt_node_offset_by_prop_value(_dtb_start, -1, "device_type",
+	                                     "cpu", sizeof("cpu"));
+	if (!node)
+		fatal("Cannot find cpu node\n");
+	timebase = fdt_getprop(_dtb_start, node, "timebase-frequency", &size);
+	if (timebase && (size == 4))
+		timebase_period_ns = 1000000000 / *timebase;
+
+	fdt_set_boot_cpuid_phys(_dtb_start, pir_reg);
+	fdt_init(_dtb_start);
+
+	serial_console_init();
+}
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index c74531a..87f4950 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -244,6 +244,9 @@ gamecube|wii)
     link_address='0x600000'
     platformo="$object/$platform-head.o $object/$platform.o"
     ;;
+treeboot-currituck)
+    link_address='0x1000000'
+    ;;
 treeboot-iss4xx-mpic)
     platformo="$object/treeboot-iss4xx.o"
     ;;
diff --git a/arch/powerpc/configs/44x/currituck_defconfig b/arch/powerpc/configs/44x/currituck_defconfig
new file mode 100644
index 0000000..4192322
--- /dev/null
+++ b/arch/powerpc/configs/44x/currituck_defconfig
@@ -0,0 +1,110 @@
+CONFIG_44x=y
+CONFIG_SMP=y
+CONFIG_EXPERIMENTAL=y
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_SPARSE_IRQ=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_EXPERT=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_PROFILING=y
+CONFIG_OPROFILE=y
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+CONFIG_PPC_47x=y
+# CONFIG_EBONY is not set
+CONFIG_CURRITUCK=y
+CONFIG_HIGHMEM=y
+CONFIG_HZ_100=y
+CONFIG_MATH_EMULATION=y
+CONFIG_IRQ_ALL_CPUS=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE=""
+# CONFIG_SUSPEND is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6 is not set
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_CONNECTOR=y
+CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_PHYSMAP_OF=y
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=35000
+# CONFIG_SCSI_PROC_FS is not set
+CONFIG_BLK_DEV_SD=y
+# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_ATA=y
+# CONFIG_SATA_PMP is not set
+CONFIG_SATA_SIL24=y
+# CONFIG_ATA_SFF is not set
+CONFIG_NETDEVICES=y
+CONFIG_E1000E=y
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_INPUT is not set
+# CONFIG_SERIO is not set
+# CONFIG_VT is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_I2C=y
+CONFIG_I2C_IBM_IIC=y
+# CONFIG_HWMON is not set
+CONFIG_THERMAL=y
+CONFIG_USB=y
+CONFIG_USB_DEBUG=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_M41T80=y
+CONFIG_EXT2_FS=y
+CONFIG_EXT3_FS=y
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_CRAMFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NLS_DEFAULT="n"
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_FS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEBUG_INFO=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
+CONFIG_XMON=y
+CONFIG_XMON_DEFAULT=y
+CONFIG_PPC_EARLY_DEBUG=y
+CONFIG_PPC_EARLY_DEBUG_44x_PHYSLOW=0x10000000
+CONFIG_PPC_EARLY_DEBUG_44x_PHYSHIGH=0x200
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_PCBC=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
+# CONFIG_CRYPTO_HW is not set
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index f0be6e0..5d5aaf6 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -186,6 +186,16 @@ config ISS4xx
 	help
 	  This option enables support for the IBM ISS simulation environment
 
+config CURRITUCK
+	bool "IBM Currituck (476fpe) Support"
+	depends on PPC_47x
+	default n
+	select SWIOTLB
+	select 476FPE
+	select PPC4xx_PCI_EXPRESS
+	help
+	  This option enables support for the IBM Currituck (476fpe) evaluation board
+
 config ICON
 	bool "Icon"
 	depends on 44x
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 553db60..d03833a 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -10,3 +10,4 @@ obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
 obj-$(CONFIG_XILINX_ML510) += virtex_ml510.o
 obj-$(CONFIG_ISS4xx)	+= iss4xx.o
 obj-$(CONFIG_CANYONLANDS)+= canyonlands.o
+obj-$(CONFIG_CURRITUCK)	+= currituck.o
diff --git a/arch/powerpc/platforms/44x/currituck.c b/arch/powerpc/platforms/44x/currituck.c
new file mode 100644
index 0000000..1fdf569
--- /dev/null
+++ b/arch/powerpc/platforms/44x/currituck.c
@@ -0,0 +1,204 @@
+/*
+ * Currituck board specific routines
+ *
+ * Copyright © 2011 Tony Breeds IBM Corporation
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
+ *    Copyright © 2011 David Kliekamp IBM Corporation
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/memblock.h>
+#include <linux/of.h>
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
+#include <linux/pci.h>
+
+static __initdata struct of_device_id ppc47x_of_bus[] = {
+	{ .compatible = "ibm,plb4", },
+	{ .compatible = "ibm,plb6", },
+	{ .compatible = "ibm,opb", },
+	{ .compatible = "ibm,ebc", },
+	{},
+};
+
+/* The EEPROM is missing and the default values are bogus.  This forces USB in
+ * to EHCI mode */
+static void __devinit quirk_ppc_currituck_usb_fixup(struct pci_dev *dev)
+{
+	if (of_machine_is_compatible("ibm,currituck")) {
+		pci_write_config_dword(dev, 0xe0, 0x0114231f);
+		pci_write_config_dword(dev, 0xe4, 0x00006c40);
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(0x1033, 0x0035, quirk_ppc_currituck_usb_fixup);
+
+static int __init ppc47x_device_probe(void)
+{
+	of_platform_bus_probe(NULL, ppc47x_of_bus, NULL);
+
+	return 0;
+}
+machine_device_initcall(ppc47x, ppc47x_device_probe);
+
+/* We can have either UICs or MPICs */
+static void __init ppc47x_init_irq(void)
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
+	if (of_device_is_compatible(np, "chrp,open-pic")) {
+		/* The MPIC driver will get everything it needs from the
+		 * device-tree, just pass 0 to all arguments
+		 */
+		struct mpic *mpic =
+			mpic_alloc(np, 0, MPIC_PRIMARY, 0, 0, " MPIC     ");
+		BUG_ON(mpic == NULL);
+		mpic_init(mpic);
+		ppc_md.get_irq = mpic_get_irq;
+	} else
+		panic("Unrecognized top level interrupt controller");
+}
+
+#ifdef CONFIG_SMP
+static void __cpuinit smp_ppc47x_setup_cpu(int cpu)
+{
+	mpic_setup_this_cpu();
+}
+
+static int __cpuinit smp_ppc47x_kick_cpu(int cpu)
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
+	spin_table_addr_prop =
+		of_get_property(cpunode, "cpu-release-addr", NULL);
+
+	if (spin_table_addr_prop == NULL) {
+		pr_err("CPU%d: Can't start, missing cpu-release-addr !\n",
+		       cpu);
+		return 1;
+	}
+
+	/* Assume it's mapped as part of the linear mapping. This is a bit
+	 * fishy but will work fine for now
+	 *
+	 * XXX: Is there any reason to assume differently?
+	 */
+	spin_table = (u32 *)__va(*spin_table_addr_prop);
+	pr_debug("CPU%d: Spin table mapped at %p\n", cpu, spin_table);
+
+	spin_table[3] = cpu;
+	smp_wmb();
+	spin_table[1] = __pa(start_secondary_47x);
+	mb();
+
+	return 0;
+}
+
+static struct smp_ops_t ppc47x_smp_ops = {
+	.probe		= smp_mpic_probe,
+	.message_pass	= smp_mpic_message_pass,
+	.setup_cpu	= smp_ppc47x_setup_cpu,
+	.kick_cpu	= smp_ppc47x_kick_cpu,
+	.give_timebase	= smp_generic_give_timebase,
+	.take_timebase	= smp_generic_take_timebase,
+};
+
+static void __init ppc47x_smp_init(void)
+{
+	if (mmu_has_feature(MMU_FTR_TYPE_47x))
+		smp_ops = &ppc47x_smp_ops;
+}
+
+#else /* CONFIG_SMP */
+static void __init ppc47x_smp_init(void) { }
+#endif /* CONFIG_SMP */
+
+static void __init ppc47x_setup_arch(void)
+{
+
+	/* No need to check the DMA config as we /know/ our windows are all of
+ 	 * RAM.  Lets hope that doesn't change */
+#ifdef CONFIG_SWIOTLB
+	if (memblock_end_of_DRAM() > 0xffffffff) {
+		ppc_swiotlb_enable = 1;
+		set_pci_dma_ops(&swiotlb_dma_ops);
+		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_swiotlb;
+	}
+#endif
+	ppc47x_smp_init();
+}
+
+/*
+ * Called very early, MMU is off, device-tree isn't unflattened
+ */
+static int __init ppc47x_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "ibm,currituck"))
+		return 0;
+
+	return 1;
+}
+
+/* Use USB controller should have been hardware swizzled but it wasn't :( */
+static void ppc47x_pci_irq_fixup(struct pci_dev *dev)
+{
+	if (dev->vendor == 0x1033 && (dev->device == 0x0035 ||
+	                              dev->device == 0x00e0)) {
+		dev->irq = irq_create_mapping(NULL, 47);
+		pr_info("%s: Mapping irq 47 %d\n", __func__, dev->irq);
+	}
+}
+
+define_machine(ppc47x) {
+	.name			= "PowerPC 47x",
+	.probe			= ppc47x_probe,
+	.progress		= udbg_progress,
+	.init_IRQ		= ppc47x_init_irq,
+	.setup_arch		= ppc47x_setup_arch,
+	.pci_irq_fixup		= ppc47x_pci_irq_fixup,
+	.restart		= ppc4xx_reset_system,
+	.calibrate_decr		= generic_calibrate_decr,
+};
-- 
1.7.6.4
