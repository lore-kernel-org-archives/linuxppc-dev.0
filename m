Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 89F43DEF9F
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:26:52 +1000 (EST)
Date: Tue, 28 Aug 2007 15:19:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 8/9] 8xx: Embedded Planet EP88xC support
Message-ID: <20070828201910.GI24260@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070828201127.GA24068@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This board is also resold by Freescale under the names
"QUICCStart MPC885 Evaluation System" and "CWH-PPC-885XN-VE".

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/Makefile            |    3 +-
 arch/powerpc/boot/dts/ep88xc.dts      |  192 +++++++++
 arch/powerpc/boot/ep88xc.c            |   54 +++
 arch/powerpc/configs/ep88xc_defconfig |  747 +++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/8xx/Kconfig    |   10 +
 arch/powerpc/platforms/8xx/Makefile   |    1 +
 arch/powerpc/platforms/8xx/ep88xc.c   |  181 ++++++++
 7 files changed, 1187 insertions(+), 1 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/ep88xc.dts
 create mode 100644 arch/powerpc/boot/ep88xc.c
 create mode 100644 arch/powerpc/configs/ep88xc_defconfig
 create mode 100644 arch/powerpc/platforms/8xx/ep88xc.c

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index d96b06a..10f1fc0 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -49,7 +49,7 @@ src-wlib := string.S crt0.S stdio.c main.c flatdevtree.c flatdevtree_misc.c \
 src-plat := of.c cuboot-83xx.c cuboot-85xx.c holly.c \
 		cuboot-ebony.c treeboot-ebony.c prpmc2800.c \
 		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c \
-		cuboot-8xx.c cuboot-pq2.c fixed-head.S
+		cuboot-8xx.c cuboot-pq2.c fixed-head.S ep88xc.c
 src-boot := $(src-wlib) $(src-plat) empty.c
 
 src-boot := $(addprefix $(obj)/, $(src-boot))
@@ -142,6 +142,7 @@ image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 ifneq ($(CONFIG_DEVICE_TREE),"")
 image-$(CONFIG_PPC_8xx)			+= cuImage.8xx
+image-$(CONFIG_PPC_EP88XC)		+= zImage.bin.ep88xc
 image-$(CONFIG_8260)			+= cuImage.pq2
 image-$(CONFIG_PPC_83xx)		+= cuImage.83xx
 image-$(CONFIG_PPC_85xx)		+= cuImage.85xx
diff --git a/arch/powerpc/boot/dts/ep88xc.dts b/arch/powerpc/boot/dts/ep88xc.dts
new file mode 100644
index 0000000..0a62059
--- /dev/null
+++ b/arch/powerpc/boot/dts/ep88xc.dts
@@ -0,0 +1,192 @@
+/*
+ * EP88xC Device Tree Source
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
+
+/ {
+	model = "EP88xC";
+	compatible = "fsl,ep88xc";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,885@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <d#16>;
+			i-cache-line-size = <d#16>;
+			d-cache-size = <d#8192>;
+			i-cache-size = <d#8192>;
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			interrupts = <f 2>;	// decrementer interrupt
+			interrupt-parent = <&PIC>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
+	chipselect {
+		board-control@fa400000 {
+			reg = <fa400000 10>;
+			compatible = "fsl,ep88xc-bcsr";
+		};
+
+		flash@fe000000 {
+			device_type = "rom";
+			compatible = "direct-mapped";
+			reg = <fe000000 2000000>;
+			probe-type = "CFI";
+			bank-width = <4>;
+		};
+	};
+
+	soc@fa200000 {
+		compatible = "fsl,mpc885", "fsl,pq1-soc";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		ranges = <0 fa200000 00004000>;
+		bus-frequency = <0>;
+
+		mdio@e00 {
+			compatible = "fsl,mpc885-fec-mdio", "fsl,pq1-fec-mdio";
+			reg = <e00 188>;
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
+		ethernet@e00 {
+			device_type = "network";
+			compatible = "fsl,mpc885-fec-enet",
+			             "fsl,pq1-fec-enet";
+			reg = <e00 188>;
+			local-mac-address = [ 00 00 00 00 00 00 ];
+			interrupts = <3 1>;
+			interrupt-parent = <&PIC>;
+			phy-handle = <&PHY0>;
+			linux,network-index = <0>;
+		};
+
+		ethernet@1e00 {
+			device_type = "network";
+			compatible = "fsl,mpc885-fec-enet",
+			             "fsl,pq1-fec-enet";
+			reg = <1e00 188>;
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
+			reg = <0 24>;
+			compatible = "fsl,mpc885-pic", "fsl,pq1-pic";
+		};
+
+		pcmcia@80 {
+			#address-cells = <3>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			compatible = "fsl,pq-pcmcia";
+			device_type = "pcmcia";
+			reg = <80 80>;
+			interrupt-parent = <&PIC>;
+			interrupts = <d 1>;
+		};
+
+		cpm@9c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "fsl,mpc885-cpm", "fsl,cpm1";
+			command-proc = <9c0>;
+			fsl,brg-frequency = <0>;
+			interrupts = <0>;	// cpm error interrupt
+			interrupt-parent = <&CPM_PIC>;
+			reg = <9c0 40 2000 1c00>;
+			ranges;
+
+			brg@9f0 {
+				compatible = "fsl,mpc885-brg",
+				             "fsl,cpm1-brg",
+				             "fsl,cpm-brg";
+				reg = <9f0 10>;
+			};
+
+			CPM_PIC: interrupt-controller@930 {
+				interrupt-controller;
+				#interrupt-cells = <1>;
+				interrupts = <5 2 0 2>;
+				interrupt-parent = <&PIC>;
+				reg = <930 20>;
+				compatible = "fsl,mpc885-cpm-pic",
+				             "fsl,cpm1-pic";
+			};
+
+			// MON-1
+			serial@a80 {
+				device_type = "serial";
+				compatible = "fsl,mpc885-smc-uart",
+				             "fsl,cpm1-smc-uart";
+				reg = <a80 10 3e80 40>;
+				interrupts = <4>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <0090>;
+				linux,planetcore-label = "SMC1";
+			};
+
+			// SER-1
+			serial@a20 {
+				device_type = "serial";
+				compatible = "fsl,mpc885-scc-uart",
+				             "fsl,cpm1-scc-uart";
+				reg = <a20 20 3d00 80>;
+				interrupts = <1d>;
+				interrupt-parent = <&CPM_PIC>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <0040>;
+				linux,planetcore-label = "SCC2";
+			};
+
+			usb@a00 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,mpc885-usb",
+				             "fsl,cpm1-usb";
+				reg = <a00 18 1c00 80>;
+				interrupt-parent = <&CPM_PIC>;
+				interrupts = <1e>;
+				fsl,cpm-command = <0000>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/boot/ep88xc.c b/arch/powerpc/boot/ep88xc.c
new file mode 100644
index 0000000..6b87cdc
--- /dev/null
+++ b/arch/powerpc/boot/ep88xc.c
@@ -0,0 +1,54 @@
+/*
+ * Embedded Planet EP88xC with PlanetCore firmware
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
+#include "planetcore.h"
+#include "mpc8xx.h"
+
+static char *table;
+static u64 mem_size;
+
+static void platform_fixups(void)
+{
+	u64 val;
+
+	dt_fixup_memory(0, mem_size);
+	planetcore_set_mac_addrs(table);
+
+	if (!planetcore_get_decimal(table, PLANETCORE_KEY_CRYSTAL_HZ, &val)) {
+		printf("No PlanetCore crystal frequency key.\r\n");
+		return;
+	}
+
+	mpc885_fixup_clocks(val);
+}
+
+void platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+                   unsigned long r6, unsigned long r7)
+{
+	table = (char *)r3;
+	planetcore_prepare_table(table);
+
+	if (!planetcore_get_decimal(table, PLANETCORE_KEY_MB_RAM, &mem_size))
+		return;
+
+	mem_size *= 1024 * 1024;
+	simple_alloc_init(_end, mem_size - (unsigned long)_end, 32, 64);
+
+	ft_init(_dtb_start, _dtb_end - _dtb_start, 32);
+
+	planetcore_set_stdout_path(table);
+
+	serial_console_init();
+	platform_ops.fixups = platform_fixups;
+}
diff --git a/arch/powerpc/configs/ep88xc_defconfig b/arch/powerpc/configs/ep88xc_defconfig
new file mode 100644
index 0000000..e945143
--- /dev/null
+++ b/arch/powerpc/configs/ep88xc_defconfig
@@ -0,0 +1,747 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.23-rc3
+# Mon Aug 27 15:11:14 2007
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
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
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
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=14
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
+CONFIG_TIMERFD=y
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
+CONFIG_PPC_EP88XC=y
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
+CONFIG_NO_UCODE_PATCH=y
+# CONFIG_USB_SOF_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set
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
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+# CONFIG_MATH_EMULATION is not set
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
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
+CONFIG_VIRT_TO_BUS=y
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SECCOMP is not set
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="ep88xc.dts"
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
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
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
+CONFIG_CONSISTENT_START=0xff100000
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
+
+#
+# QoS and/or fair queueing
+#
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
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVI COM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+CONFIG_LXT_PHY=y
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FEC=y
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
+# CONFIG_INPUT is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
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
+# CONFIG_WATCHDOG is not set
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
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_EDAC is not set
+# CONFIG_RTC_CLASS is not set
+
+#
+# DMA Engine support
+#
+# CONFIG_DMA_ENGINE is not set
+
+#
+# DMA Clients
+#
+
+#
+# DMA Devices
+#
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
+CONFIG_RAMFS=y
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
+
+#
+# Network File Systems
+#
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
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Distributed Lock Manager
+#
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
+
+#
+# Instrumentation Support
+#
+# CONFIG_PROFILING is not set
+
+#
+# Kernel hacking
+#
+# CONFIG_PRINTK_TIME is not set
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
+CONFIG_FORCED_INLINING=y
+# CONFIG_FAULT_INJECTION is not set
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
+# CONFIG_CRYPTO is not set
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index 4829378..f60be55 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -32,6 +32,16 @@ config MPC885ADS
 	  The MPC885ADS is meant to serve as a platform for s/w and h/w
 	  development around the MPC885 processor family.
 
+config PPC_EP88XC
+	bool "Embedded Planet EP88xC (a.k.a. CWH-PPC-885XN-VE)"
+	select CPM1
+	select PPC_CPM_NEW_BINDING
+	help
+	  This enables support for the Embedded Planet EP88xC board.
+
+	  This board is also resold by Freescale as the QUICCStart
+	  MPC885 Evaluation System and/or the CWH-PPC-885XN-VE.
+
 endchoice
 
 menu "Freescale Ethernet driver platform-specific options"
diff --git a/arch/powerpc/platforms/8xx/Makefile b/arch/powerpc/platforms/8xx/Makefile
index 5e2dae3..8b70980 100644
--- a/arch/powerpc/platforms/8xx/Makefile
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -4,3 +4,4 @@
 obj-$(CONFIG_PPC_8xx)	  += m8xx_setup.o
 obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
 obj-$(CONFIG_MPC86XADS)   += mpc86xads_setup.o
+obj-$(CONFIG_PPC_EP88XC)  += ep88xc.o
diff --git a/arch/powerpc/platforms/8xx/ep88xc.c b/arch/powerpc/platforms/8xx/ep88xc.c
new file mode 100644
index 0000000..f654072
--- /dev/null
+++ b/arch/powerpc/platforms/8xx/ep88xc.c
@@ -0,0 +1,181 @@
+/*
+ * Platform setup for the Embedded Planet EP88xC board
+ *
+ * Author: Scott Wood <scottwood@freescale.com>
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+
+#include <asm/machdep.h>
+#include <asm/io.h>
+#include <asm/udbg.h>
+#include <asm/commproc.h>
+
+#include <sysdev/commproc.h>
+#include <sysdev/cpm_common.h>
+
+struct cpm_pin {
+	int port, pin, flags;
+};
+
+static struct cpm_pin ep88xc_pins[] = {
+	/* SMC1 */
+	{1, 24, CPM_PIN_INPUT}, /* RX */
+	{1, 25, CPM_PIN_INPUT | CPM_PIN_SECONDARY}, /* TX */
+
+	/* SCC2 */
+	{0, 12, CPM_PIN_INPUT}, /* TX */
+	{0, 13, CPM_PIN_INPUT}, /* RX */
+	{2, 8, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_GPIO}, /* CD */
+	{2, 9, CPM_PIN_INPUT | CPM_PIN_SECONDARY | CPM_PIN_GPIO}, /* CTS */
+	{2, 14, CPM_PIN_INPUT}, /* RTS */
+
+	/* MII1 */
+	{0, 0, CPM_PIN_INPUT},
+	{0, 1, CPM_PIN_INPUT},
+	{0, 2, CPM_PIN_INPUT},
+	{0, 3, CPM_PIN_INPUT},
+	{0, 4, CPM_PIN_OUTPUT},
+	{0, 10, CPM_PIN_OUTPUT},
+	{0, 11, CPM_PIN_OUTPUT},
+	{1, 19, CPM_PIN_INPUT},
+	{1, 31, CPM_PIN_INPUT},
+	{2, 12, CPM_PIN_INPUT},
+	{2, 13, CPM_PIN_INPUT},
+	{3, 8, CPM_PIN_INPUT},
+	{4, 30, CPM_PIN_OUTPUT},
+	{4, 31, CPM_PIN_OUTPUT},
+
+	/* MII2 */
+	{4, 14, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 15, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 16, CPM_PIN_OUTPUT},
+	{4, 17, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 18, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 19, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 20, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{4, 21, CPM_PIN_OUTPUT},
+	{4, 22, CPM_PIN_OUTPUT},
+	{4, 23, CPM_PIN_OUTPUT},
+	{4, 24, CPM_PIN_OUTPUT},
+	{4, 25, CPM_PIN_OUTPUT},
+	{4, 26, CPM_PIN_OUTPUT},
+	{4, 27, CPM_PIN_OUTPUT},
+	{4, 28, CPM_PIN_OUTPUT},
+	{4, 29, CPM_PIN_OUTPUT},
+
+	/* USB */
+	{0, 6, CPM_PIN_INPUT},  /* CLK2 */
+	{0, 14, CPM_PIN_INPUT}, /* USBOE */
+	{0, 15, CPM_PIN_INPUT}, /* USBRXD */
+	{2, 6, CPM_PIN_OUTPUT}, /* USBTXN */
+	{2, 7, CPM_PIN_OUTPUT}, /* USBTXP */
+	{2, 10, CPM_PIN_INPUT}, /* USBRXN */
+	{2, 11, CPM_PIN_INPUT}, /* USBRXP */
+
+	/* Misc */
+	{1, 26, CPM_PIN_INPUT}, /* BRGO2 */
+	{1, 27, CPM_PIN_INPUT}, /* BRGO1 */
+};
+
+static void __init init_ioports(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ep88xc_pins); i++) {
+		struct cpm_pin *pin = &ep88xc_pins[i];
+		cpm1_set_pin(pin->port, pin->pin, pin->flags);
+	}
+
+	cpm1_clk_setup(CPM_CLK_SMC1, CPM_BRG1, CPM_CLK_RTX);
+	cpm1_clk_setup(CPM_CLK_SCC1, CPM_CLK2, CPM_CLK_TX); /* USB */
+	cpm1_clk_setup(CPM_CLK_SCC1, CPM_CLK2, CPM_CLK_RX);
+	cpm1_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_TX);
+	cpm1_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_RX);
+}
+
+static u8 __iomem *ep88xc_bcsr;
+
+#define BCSR7_SCC2_ENABLE 0x10
+
+#define BCSR8_PHY1_ENABLE 0x80
+#define BCSR8_PHY1_POWER  0x40
+#define BCSR8_PHY2_ENABLE 0x20
+#define BCSR8_PHY2_POWER  0x10
+
+#define BCSR9_USB_ENABLE  0x80
+#define BCSR9_USB_POWER   0x40
+#define BCSR9_USB_HOST    0x20
+#define BCSR9_USB_FULL_SPEED_TARGET 0x10
+
+static void __init ep88xc_setup_arch(void)
+{
+	struct device_node *np;
+
+	cpm_reset();
+	init_ioports();
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,ep88xc-bcsr");
+	if (!np) {
+		printk(KERN_CRIT "Could not find fsl,ep88xc-bcsr node\n");
+		return;
+	}
+
+	ep88xc_bcsr = of_iomap(np, 0);
+	of_node_put(np);
+
+	if (!ep88xc_bcsr) {
+		printk(KERN_CRIT "Could not remap BCSR\n");
+		return;
+	}
+
+	setbits8(&ep88xc_bcsr[7], BCSR7_SCC2_ENABLE);
+	setbits8(&ep88xc_bcsr[8], BCSR8_PHY1_ENABLE | BCSR8_PHY1_POWER |
+	                          BCSR8_PHY2_ENABLE | BCSR8_PHY2_POWER);
+}
+
+static int __init ep88xc_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,ep88xc");
+}
+
+static struct of_device_id __initdata of_bus_ids[] = {
+	{ .name = "soc", },
+	{ .name = "cpm", },
+	{ .name = "chipselect", },
+	{},
+};
+
+static int __init declare_of_platform_devices(void)
+{
+	/* Publish the QE devices */
+	if (machine_is(ep88xc))
+		of_platform_bus_probe(NULL, of_bus_ids, NULL);
+
+	return 0;
+}
+device_initcall(declare_of_platform_devices);
+
+define_machine(ep88xc) {
+	.name = "Embedded Planet EP88xC",
+	.probe = ep88xc_probe,
+	.setup_arch = ep88xc_setup_arch,
+	.init_IRQ = m8xx_pic_init,
+	.get_irq	= mpc8xx_get_irq,
+	.restart = mpc8xx_restart,
+	.calibrate_decr = mpc8xx_calibrate_decr,
+	.set_rtc_time = mpc8xx_set_rtc_time,
+	.get_rtc_time = mpc8xx_get_rtc_time,
+	.progress = udbg_progress,
+};
+
+#ifdef CONFIG_PPC_EARLY_DEBUG_CPM
+u32 __iomem *cpm_udbg_txdesc = (u32 __iomem __force *)0xfa202808;
+#endif
-- 
1.5.0.3
