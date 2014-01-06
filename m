Return-Path: <schivers@csc.com>
Received: from mail171.messagelabs.com (mail171.messagelabs.com
 [216.82.253.243])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 447BF2C00C5
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jan 2014 12:23:17 +1100 (EST)
Date: Mon, 06 Jan 2014 12:23:06 +1100
To: benh@kernel.crashing.org, scottwood@freescale.com
Subject: [PATCH v5 1/1] powerpc/embedded6xx: Add support for
 Motorola/Emerson MVME5100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20140106012306.A6AB5E06BF@canberra.localdomain>
From: schivers@csc.com (Stephen Chivers)
Cc: schivers@csc.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add support for the Motorola/Emerson MVME5100 Single Board Computer.

The MVME5100 is a 6U form factor VME64 computer with:

	- A single MPC7410 or MPC750 CPU
	- A HAWK Processor Host Bridge (CPU to PCI) and
	  MultiProcessor Interrupt Controller (MPIC)
	- Up to 500Mb of onboard memory
	- A M48T37 Real Time Clock (RTC) and Non-Volatile Memory chip
	- Two 16550 compatible UARTS
	- Two Intel E100 Fast Ethernets
	- Two PCI Mezzanine Card (PMC) Slots
	- PPCBug Firmware

The HAWK PHB/MPIC is compatible with the MPC10x devices.

There is no onboard disk support. This is usually provided by installing a PMC
in first PMC slot.

This patch revives the board support, it was present in early 2.6
series kernels. The board support in those days was by Matt Porter of
MontaVista Software.

CSC Australia has around 31 of these boards in service. The kernel in use
for the boards is based on 2.6.31. The boards are operated without disks
from a file server. 

This patch is based on linux-3.13-rc2 and has been boot tested.

Only boards with 512 Mb of memory are known to work.

V1->V2:
	Address comments by Kumar Gala and Scott Wood.
	Minor adjustment to platforms/embedded6xx/Kconfig to ensure
		correct indentation where possible.

V2->V3:
	Address comments by Scott Wood and Ben Herrenschmidt.
	Address errors reported by checkpatch.

V3->V4:
	Address comment by Geert Uytterhoeven
	Add tested by Alessio Bogani.

V4->V5:
	Correct horrible typo in patch history.
	Kular Gama is Kumar Gala.

Signed-off-by: Stephen Chivers <schivers@csc.com>
Tested-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
---
 arch/powerpc/boot/Makefile                    |    3 +-
 arch/powerpc/boot/dts/mvme5100.dts            |  185 +++++++++++++++++++++
 arch/powerpc/boot/mvme5100.c                  |   27 +++
 arch/powerpc/boot/wrapper                     |    4 +
 arch/powerpc/configs/mvme5100_defconfig       |  144 ++++++++++++++++
 arch/powerpc/platforms/embedded6xx/Kconfig    |   13 ++-
 arch/powerpc/platforms/embedded6xx/Makefile   |    1 +
 arch/powerpc/platforms/embedded6xx/mvme5100.c |  221 +++++++++++++++++++++++++
 8 files changed, 596 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index ca7f08c..cd9ea99 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -95,7 +95,7 @@ src-plat-$(CONFIG_FSL_SOC_BOOKE) += cuboot-85xx.c cuboot-85xx-cpm2.c
 src-plat-$(CONFIG_EMBEDDED6xx) += cuboot-pq2.c cuboot-mpc7448hpc2.c \
 					cuboot-c2k.c gamecube-head.S \
 					gamecube.c wii-head.S wii.c holly.c \
-					prpmc2800.c
+					prpmc2800.c fixed-head.S mvme5100.c
 src-plat-$(CONFIG_AMIGAONE) += cuboot-amigaone.c
 src-plat-$(CONFIG_PPC_PS3) += ps3-head.S ps3-hvcall.S ps3.c
 src-plat-$(CONFIG_EPAPR_BOOT) += epapr.c epapr-wrapper.c
@@ -286,6 +286,7 @@ image-$(CONFIG_MPC7448HPC2)		+= cuImage.mpc7448hpc2
 image-$(CONFIG_PPC_C2K)			+= cuImage.c2k
 image-$(CONFIG_GAMECUBE)		+= dtbImage.gamecube
 image-$(CONFIG_WII)			+= dtbImage.wii
+image-$(CONFIG_MVME5100)		+= dtbImage.mvme5100
 
 # Board port in arch/powerpc/platform/amigaone/Kconfig
 image-$(CONFIG_AMIGAONE)		+= cuImage.amigaone
diff --git a/arch/powerpc/boot/dts/mvme5100.dts b/arch/powerpc/boot/dts/mvme5100.dts
new file mode 100644
index 0000000..1ecb341
--- /dev/null
+++ b/arch/powerpc/boot/dts/mvme5100.dts
@@ -0,0 +1,185 @@
+/*
+ * Device Tree Source for Motorola/Emerson MVME5100.
+ *
+ * Copyright 2013 CSC Australia Pty. Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without
+ * any warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+
+/ {
+	model = "MVME5100";
+	compatible = "MVME5100";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	aliases {
+		serial0 = &serial0;
+		pci0 = &pci0;
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,7410 {
+			device_type = "cpu";
+			reg = <0x0>;
+			/* Following required by dtc but not used */
+			d-cache-line-size = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <32768>;
+			d-cache-size = <32768>;
+			timebase-frequency = <25000000>;
+			clock-frequency = <500000000>;
+			bus-frequency = <100000000>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x0 0x20000000>;
+	};
+
+	hawk@fef80000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "hawk-bridge", "simple-bus";
+		ranges = <0x0 0xfef80000 0x10000>;
+		reg = <0xfef80000 0x10000>;
+
+		serial0: serial@8000 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x8000 0x80>;
+			reg-shift = <4>;
+			clock-frequency = <1843200>;
+			current-speed = <9600>;
+			interrupts = <1 1>; // IRQ1 Level Active Low.
+			interrupt-parent = <&mpic>;
+		};
+
+		serial1: serial@8200 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <0x8200 0x80>;
+			reg-shift = <4>;
+			clock-frequency = <1843200>;
+			current-speed = <9600>;
+			interrupts = <1 1>; // IRQ1 Level Active Low.
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: interrupt-controller@f3f80000 {
+			#interrupt-cells = <2>;
+			#address-cells = <0>;
+			device_type = "open-pic";
+			compatible = "chrp,open-pic";
+			interrupt-controller;
+			reg = <0xf3f80000 0x40000>;
+		};
+	};
+
+	pci0: pci@feff0000 {
+		#address-cells = <3>;
+		#size-cells = <2>;
+		#interrupt-cells = <1>;
+		device_type = "pci";
+		compatible = "hawk-pci";
+		reg = <0xfec00000 0x400000>;
+		8259-interrupt-acknowledge = <0xfeff0030>;
+		ranges = <0x1000000 0x0        0x0 0xfe000000 0x0 0x800000
+			  0x2000000 0x0 0x80000000 0x80000000 0x0 0x74000000>;
+		bus-range = <0 255>;
+		clock-frequency = <33333333>;
+		interrupt-parent = <&mpic>;
+		interrupt-map-mask = <0xf800 0x0 0x0 0x7>;
+		interrupt-map = <
+
+			/*
+			 * This definition (IDSEL 11) duplicates the
+			 * interrupts definition in the i8259
+			 * interrupt controller below.
+			 *
+			 * Do not change the interrupt sense/polarity from
+			 * 0x2 to anything else, doing so will cause endless
+			 * "spurious" i8259 interrupts to be fielded.
+			 */
+			// IDSEL 11 - iPMC712 PCI/ISA Bridge
+			0x5800 0x0 0x0 0x1 &mpic 0x0 0x2
+			0x5800 0x0 0x0 0x2 &mpic 0x0 0x2
+			0x5800 0x0 0x0 0x3 &mpic 0x0 0x2
+			0x5800 0x0 0x0 0x4 &mpic 0x0 0x2
+
+			/* IDSEL 12 - Not Used */
+
+			/* IDSEL 13 - Universe VME Bridge */
+			0x6800 0x0 0x0 0x1 &mpic 0x5 0x1
+			0x6800 0x0 0x0 0x2 &mpic 0x6 0x1
+			0x6800 0x0 0x0 0x3 &mpic 0x7 0x1
+			0x6800 0x0 0x0 0x4 &mpic 0x8 0x1
+
+			/* IDSEL 14 - ENET 1 */
+			0x7000 0x0 0x0 0x1 &mpic 0x2 0x1
+
+			/* IDSEL 15 - Not Used */
+
+			/* IDSEL 16 - PMC Slot 1 */
+			0x8000 0x0 0x0 0x1 &mpic 0x9 0x1
+			0x8000 0x0 0x0 0x2 &mpic 0xa 0x1
+			0x8000 0x0 0x0 0x3 &mpic 0xb 0x1
+			0x8000 0x0 0x0 0x4 &mpic 0xc 0x1
+
+			/* IDSEL 17 - PMC Slot 2 */
+			0x8800 0x0 0x0 0x1 &mpic 0xc 0x1
+			0x8800 0x0 0x0 0x2 &mpic 0x9 0x1
+			0x8800 0x0 0x0 0x3 &mpic 0xa 0x1
+			0x8800 0x0 0x0 0x4 &mpic 0xb 0x1
+
+			/* IDSEL 18 - Not Used */
+
+			/* IDSEL 19 - ENET 2 */
+			0x9800 0x0 0x0 0x1 &mpic 0xd 0x1
+
+			/* IDSEL 20 - PMCSPAN (PCI-X) */
+			0xa000 0x0 0x0 0x1 &mpic 0x9 0x1
+			0xa000 0x0 0x0 0x2 &mpic 0xa 0x1
+			0xa000 0x0 0x0 0x3 &mpic 0xb 0x1
+			0xa000 0x0 0x0 0x4 &mpic 0xc 0x1
+
+		>;
+
+		isa {
+			#address-cells = <2>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			device_type = "isa";
+			compatible = "isa";
+			ranges = <0x00000001 0 0x01000000 0 0x00000000 0x00001000>;
+			interrupt-parent = <&i8259>;
+
+			i8259: interrupt-controller@20 {
+				#interrupt-cells = <2>;
+				#address-cells = <0>;
+				interrupts = <0 2>;
+				device_type = "interrupt-controller";
+				compatible = "chrp,iic";
+				interrupt-controller;
+				reg = <1 0x00000020 0x00000002
+                                       1 0x000000a0 0x00000002
+                                       1 0x000004d0 0x00000002>;
+				interrupt-parent = <&mpic>;
+			};
+
+		};
+
+	};
+
+	chosen {
+		linux,stdout-path = &serial0;
+        };
+
+};
diff --git a/arch/powerpc/boot/mvme5100.c b/arch/powerpc/boot/mvme5100.c
new file mode 100644
index 0000000..cb865f8
--- /dev/null
+++ b/arch/powerpc/boot/mvme5100.c
@@ -0,0 +1,27 @@
+/*
+ * Motorola/Emerson MVME5100 with PPCBug firmware.
+ *
+ * Author: Stephen Chivers <schivers@csc.com>
+ *
+ * Copyright 2013 CSC Australia Pty. Ltd.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ */
+#include "types.h"
+#include "ops.h"
+#include "io.h"
+
+BSS_STACK(4096);
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5)
+{
+	u32			heapsize;
+
+	heapsize = 0x8000000 - (u32)_end; /* 128M */
+	simple_alloc_init(_end, heapsize, 32, 64);
+	fdt_init(_dtb_start);
+	serial_console_init();
+}
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 2e1af74..d27a255 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -265,6 +265,10 @@ epapr)
     link_address='0x20000000'
     pie=-pie
     ;;
+mvme5100)
+    platformo="$object/fixed-head.o $object/mvme5100.o"
+    binary=y
+    ;;
 esac
 
 vmz="$tmpdir/`basename \"$kernel\"`.$ext"
diff --git a/arch/powerpc/configs/mvme5100_defconfig b/arch/powerpc/configs/mvme5100_defconfig
new file mode 100644
index 0000000..93c7752
--- /dev/null
+++ b/arch/powerpc/configs/mvme5100_defconfig
@@ -0,0 +1,144 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_UTS_NS is not set
+# CONFIG_IPC_NS is not set
+# CONFIG_PID_NS is not set
+# CONFIG_NET_NS is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+# CONFIG_COMPAT_BRK is not set
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
+CONFIG_EMBEDDED6xx=y
+CONFIG_MVME5100=y
+CONFIG_KVM_GUEST=y
+CONFIG_HZ_100=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_COMPACTION is not set
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS0,9600 ip=dhcp root=/dev/nfs"
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_INET_LRO is not set
+# CONFIG_IPV6 is not set
+CONFIG_NETFILTER=y
+CONFIG_NF_CONNTRACK=m
+CONFIG_NF_CT_PROTO_SCTP=m
+CONFIG_NF_CONNTRACK_AMANDA=m
+CONFIG_NF_CONNTRACK_FTP=m
+CONFIG_NF_CONNTRACK_H323=m
+CONFIG_NF_CONNTRACK_IRC=m
+CONFIG_NF_CONNTRACK_NETBIOS_NS=m
+CONFIG_NF_CONNTRACK_PPTP=m
+CONFIG_NF_CONNTRACK_SIP=m
+CONFIG_NF_CONNTRACK_TFTP=m
+CONFIG_NETFILTER_XT_MATCH_MAC=m
+CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
+CONFIG_NETFILTER_XT_MATCH_STATE=m
+CONFIG_NF_CONNTRACK_IPV4=m
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_MANGLE=m
+CONFIG_IP_NF_TARGET_ECN=m
+CONFIG_IP_NF_TARGET_TTL=m
+CONFIG_IP_NF_RAW=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+CONFIG_IP_NF_ARP_MANGLE=m
+CONFIG_LAPB=m
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_PROC_DEVICETREE=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=2
+CONFIG_BLK_DEV_RAM_SIZE=8192
+CONFIG_EEPROM_LEGACY=m
+CONFIG_NETDEVICES=y
+CONFIG_TUN=m
+# CONFIG_NET_VENDOR_3COM is not set
+CONFIG_E100=y
+# CONFIG_WLAN is not set
+# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=10
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_HW_RANDOM=y
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MPC=y
+# CONFIG_HWMON is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
+# CONFIG_VGA_CONSOLE is not set
+# CONFIG_HID is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_VME_BUS=m
+CONFIG_VME_CA91CX42=m
+CONFIG_EXT2_FS=m
+CONFIG_EXT3_FS=m
+# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
+CONFIG_XFS_FS=m
+CONFIG_ISO9660_FS=m
+CONFIG_JOLIET=y
+CONFIG_ZISOFS=y
+CONFIG_UDF_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+CONFIG_PROC_KCORE=y
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_ROOT_NFS=y
+CONFIG_NFSD=m
+CONFIG_NFSD_V3=y
+CONFIG_CIFS=m
+CONFIG_NLS=y
+CONFIG_NLS_CODEPAGE_437=m
+CONFIG_NLS_CODEPAGE_932=m
+CONFIG_NLS_ISO8859_1=m
+CONFIG_NLS_UTF8=m
+CONFIG_CRC_CCITT=m
+CONFIG_CRC_T10DIF=y
+CONFIG_XZ_DEC=y
+CONFIG_XZ_DEC_X86=y
+CONFIG_XZ_DEC_IA64=y
+CONFIG_XZ_DEC_ARM=y
+CONFIG_XZ_DEC_ARMTHUMB=y
+CONFIG_XZ_DEC_SPARC=y
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DETECT_HUNG_TASK=y
+CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=20
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_MICHAEL_MIC=m
+CONFIG_CRYPTO_SHA1=m
+CONFIG_CRYPTO_BLOWFISH=m
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_SERPENT=m
+CONFIG_CRYPTO_TWOFISH=m
+CONFIG_CRYPTO_DEFLATE=m
+# CONFIG_CRYPTO_ANSI_CPRNG is not set
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 302ba43..6d3c7a9 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -67,6 +67,18 @@ config PPC_C2K
 	  This option enables support for the GE Fanuc C2K board (formerly
 	  an SBS board).
 
+config MVME5100
+	bool "Motorola/Emerson MVME5100"
+	depends on EMBEDDED6xx
+	select MPIC
+	select PCI
+	select PPC_INDIRECT_PCI
+	select PPC_I8259
+	select PPC_NATIVE
+	help
+	  This option enables support for the Motorola (now Emerson) MVME5100
+	  board.
+
 config TSI108_BRIDGE
 	bool
 	select PCI
@@ -113,4 +125,3 @@ config WII
 	help
 	  Select WII if configuring for the Nintendo Wii.
 	  More information at: <http://gc-linux.sourceforge.net/>
-
diff --git a/arch/powerpc/platforms/embedded6xx/Makefile b/arch/powerpc/platforms/embedded6xx/Makefile
index 66c23e4..cdd48d4 100644
--- a/arch/powerpc/platforms/embedded6xx/Makefile
+++ b/arch/powerpc/platforms/embedded6xx/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_USBGECKO_UDBG)	+= usbgecko_udbg.o
 obj-$(CONFIG_GAMECUBE_COMMON)	+= flipper-pic.o
 obj-$(CONFIG_GAMECUBE)		+= gamecube.o
 obj-$(CONFIG_WII)		+= wii.o hlwd-pic.o
+obj-$(CONFIG_MVME5100)		+= mvme5100.o
diff --git a/arch/powerpc/platforms/embedded6xx/mvme5100.c b/arch/powerpc/platforms/embedded6xx/mvme5100.c
new file mode 100644
index 0000000..25e3bfb
--- /dev/null
+++ b/arch/powerpc/platforms/embedded6xx/mvme5100.c
@@ -0,0 +1,221 @@
+/*
+ * Board setup routines for the Motorola/Emerson MVME5100.
+ *
+ * Copyright 2013 CSC Australia Pty. Ltd.
+ *
+ * Based on earlier code by:
+ *
+ *    Matt Porter, MontaVista Software Inc.
+ *    Copyright 2001 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Author: Stephen Chivers <schivers@csc.com>
+ *
+ */
+
+#include <linux/of_platform.h>
+
+#include <asm/i8259.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpic.h>
+#include <asm/prom.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+
+#define HAWK_MPIC_SIZE		0x00040000U
+#define MVME5100_PCI_MEM_OFFSET 0x00000000
+
+/* Board register addresses. */
+#define BOARD_STATUS_REG	0xfef88080
+#define BOARD_MODFAIL_REG	0xfef88090
+#define BOARD_MODRST_REG	0xfef880a0
+#define BOARD_TBEN_REG		0xfef880c0
+#define BOARD_SW_READ_REG	0xfef880e0
+#define BOARD_GEO_ADDR_REG	0xfef880e8
+#define BOARD_EXT_FEATURE1_REG	0xfef880f0
+#define BOARD_EXT_FEATURE2_REG	0xfef88100
+
+static phys_addr_t pci_membase;
+static u_char *restart;
+
+static void mvme5100_8259_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int cascade_irq = i8259_irq();
+
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq);
+
+	chip->irq_eoi(&desc->irq_data);
+}
+
+static void __init mvme5100_pic_init(void)
+{
+	struct mpic *mpic;
+	struct device_node *np;
+	struct device_node *cp = NULL;
+	unsigned int cirq;
+	unsigned long intack = 0;
+	const u32 *prop = NULL;
+
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (!np) {
+		pr_err("Could not find open-pic node\n");
+		return;
+	}
+
+	mpic = mpic_alloc(np, pci_membase, 0, 16, 256, " OpenPIC  ");
+
+	BUG_ON(mpic == NULL);
+	of_node_put(np);
+
+	mpic_assign_isu(mpic, 0, pci_membase + 0x10000);
+
+	mpic_init(mpic);
+
+	cp = of_find_compatible_node(NULL, NULL, "chrp,iic");
+	if (cp == NULL) {
+		pr_warn("mvme5100_pic_init: couldn't find i8259\n");
+		return;
+	}
+
+	cirq = irq_of_parse_and_map(cp, 0);
+	if (cirq == NO_IRQ) {
+		pr_warn("mvme5100_pic_init: no cascade interrupt?\n");
+		return;
+	}
+
+	np = of_find_compatible_node(NULL, "pci", "mpc10x-pci");
+	if (np) {
+		prop = of_get_property(np, "8259-interrupt-acknowledge", NULL);
+
+		if (prop)
+			intack = prop[0];
+
+		of_node_put(np);
+	}
+
+	if (intack)
+		pr_debug("mvme5100_pic_init: PCI 8259 intack at 0x%016lx\n",
+		   intack);
+
+	i8259_init(cp, intack);
+	of_node_put(cp);
+	irq_set_chained_handler(cirq, mvme5100_8259_cascade);
+}
+
+static int __init mvme5100_add_bridge(struct device_node *dev)
+{
+	const int		*bus_range;
+	int			len;
+	struct pci_controller	*hose;
+	unsigned short		devid;
+
+	pr_info("Adding PCI host bridge %s\n", dev->full_name);
+
+	bus_range = of_get_property(dev, "bus-range", &len);
+
+	hose = pcibios_alloc_controller(dev);
+	if (hose == NULL)
+		return -ENOMEM;
+
+	hose->first_busno = bus_range ? bus_range[0] : 0;
+	hose->last_busno = bus_range ? bus_range[1] : 0xff;
+
+	setup_indirect_pci(hose, 0xfe000cf8, 0xfe000cfc, 0);
+
+	pci_process_bridge_OF_ranges(hose, dev, 1);
+
+	early_read_config_word(hose, 0, 0, PCI_DEVICE_ID, &devid);
+
+	if (devid != PCI_DEVICE_ID_MOTOROLA_HAWK) {
+		pr_err("HAWK PHB not present?\n");
+		return 0;
+	}
+
+	early_read_config_dword(hose, 0, 0, PCI_BASE_ADDRESS_1, &pci_membase);
+
+	if (pci_membase == 0) {
+		pr_err("HAWK PHB mibar not correctly set?\n");
+		return 0;
+	}
+
+	pr_info("mvme5100_pic_init: pci_membase: %x\n", pci_membase);
+
+	return 0;
+}
+
+static struct of_device_id mvme5100_of_bus_ids[] __initdata = {
+	{ .compatible = "hawk-bridge", },
+	{},
+};
+
+/*
+ * Setup the architecture
+ */
+static void __init mvme5100_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("mvme5100_setup_arch()", 0);
+
+	for_each_compatible_node(np, "pci", "hawk-pci")
+		mvme5100_add_bridge(np);
+
+	restart = ioremap(BOARD_MODRST_REG, 4);
+}
+
+
+static void mvme5100_show_cpuinfo(struct seq_file *m)
+{
+	seq_puts(m, "Vendor\t\t: Motorola/Emerson\n");
+	seq_puts(m, "Machine\t\t: MVME5100\n");
+}
+
+static void mvme5100_restart(char *cmd)
+{
+
+	local_irq_disable();
+	mtmsr(mfmsr() | MSR_IP);
+
+	out_8((u_char *) restart, 0x01);
+
+	while (1)
+		;
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mvme5100_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "MVME5100");
+}
+
+static int __init probe_of_platform_devices(void)
+{
+
+	of_platform_bus_probe(NULL, mvme5100_of_bus_ids, NULL);
+	return 0;
+}
+
+machine_device_initcall(mvme5100, probe_of_platform_devices);
+
+define_machine(mvme5100) {
+	.name			= "MVME5100",
+	.probe			= mvme5100_probe,
+	.setup_arch		= mvme5100_setup_arch,
+	.init_IRQ		= mvme5100_pic_init,
+	.show_cpuinfo		= mvme5100_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= mvme5100_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
