Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-244.msk.skylink.ru
	[83.217.45.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A16767D1F
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 10:21:06 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 4/6] POWERPC: add support of mpc8560 eval board
Date: Sat, 12 Aug 2006 04:10:17 +0400
Message-Id: <20060812001017.6186.99359.stgit@localhost.localdomain>
In-Reply-To: <20060812000655.6186.42738.stgit@localhost.localdomain>
References: <20060812000655.6186.42738.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This make the 8560 evaluation board fully supported under arch/powerpc,
as the first board with CPM2 SoC peripherals. The brand new devicetree
nodes are introduced (intending to be a subset of the QuiccEngine-equipped
models, with dts sources placed into the kernel according to the new convention.

Assuming all the preceding stuff applied (PAL+fs_enet related+ CPM_UART
update), the both TSEC eth ,FCC Eths, and both SCC UARTs are
working. The relevant drivers are still capable to drive users in ppc,
which was verified with 8272ADS (SCC uart+FCC eth).

This is also verified on mpc8540 and actually make it work (PCI stuff 
working as well)

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/boot/dts/mpc8560ads.dts       |  310 ++++++++++
 arch/powerpc/configs/mpc8560_ads_defconfig |  854 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/Kconfig        |   11 
 arch/powerpc/platforms/85xx/Makefile       |    1 
 arch/powerpc/platforms/85xx/mpc8540_ads.h  |   12 
 arch/powerpc/platforms/85xx/mpc8560_ads.h  |   65 ++
 arch/powerpc/platforms/85xx/mpc85xx.h      |    1 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c  |  334 +++++++++--
 arch/powerpc/platforms/85xx/pci.c          |   12 
 include/asm-powerpc/mpc85xx.h              |  199 +++++++
 10 files changed, 1729 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
new file mode 100644
index 0000000..f6ccb99
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -0,0 +1,310 @@
+/*
+ * MPC8560 ADS Device Tree Source
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ * 
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
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
+	model = "MPC8560ADS";
+	compatible = "MPC85xxADS";
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
+		PowerPC,8560@0 {
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
+			linux,boot-cpu;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		reg = <00000000 10000000>;
+	};
+
+	soc8560@e0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 e0000000 00100000>;
+		reg = <e0000000 00000200>;
+		bus-frequency = <0>;
+
+		mdio@24520 {
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			linux,phandle = <24520>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ethernet-phy@0 {
+				linux,phandle = <2452000>;
+				interrupt-parent = <40000>;
+				interrupts = <35 1>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <40000>;
+				interrupts = <35 1>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@2 {
+				linux,phandle = <2452002>;
+				interrupt-parent = <40000>;
+				interrupts = <37 1>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@3 {
+				linux,phandle = <2452003>;
+				interrupt-parent = <40000>;
+				interrupts = <37 1>;
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			address = [ 00 00 0C 00 00 FD ];
+			interrupts = <d 0 e 0 12 0>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452000>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "TSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			address = [ 00 00 0C 00 01 FD ];
+			interrupts = <13 0 14 0 18 0>;
+			interrupt-parent = <40000>;
+			phy-handle = <2452001>;
+		};
+
+		pci@8000 {
+			linux,phandle = <8000>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			compatible = "85xx";
+			device_type = "pci";
+			reg = <8000 400>;
+			clock-frequency = <3f940aa>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+					/* IDSEL 0x2 */
+					 1000 0 0 1 40000 31 1
+					 1000 0 0 2 40000 32 1
+					 1000 0 0 3 40000 33 1
+					 1000 0 0 4 40000 34 1
+
+					/* IDSEL 0x3 */
+					 1800 0 0 1 40000 34 1
+					 1800 0 0 2 40000 31 1
+					 1800 0 0 3 40000 32 1
+					 1800 0 0 4 40000 33 1
+
+					/* IDSEL 0x4 */
+					 2000 0 0 1 40000 33 1
+					 2000 0 0 2 40000 34 1
+					 2000 0 0 3 40000 31 1
+					 2000 0 0 4 40000 32 1
+
+					/* IDSEL 0x5  */
+					 2800 0 0 1 40000 32 1
+					 2800 0 0 2 40000 33 1
+					 2800 0 0 3 40000 34 1
+					 2800 0 0 4 40000 31 1
+
+					/* IDSEL 12 */
+					 6000 0 0 1 40000 31 1
+					 6000 0 0 2 40000 32 1
+					 6000 0 0 3 40000 33 1
+					 6000 0 0 4 40000 34 1
+
+					/* IDSEL 13 */
+					 6800 0 0 1 40000 34 1
+					 6800 0 0 2 40000 31 1
+					 6800 0 0 3 40000 32 1
+					 6800 0 0 4 40000 33 1
+                                                                
+					/* IDSEL 14*/
+					 7000 0 0 1 40000 33 1
+					 7000 0 0 2 40000 34 1
+					 7000 0 0 3 40000 31 1
+					 7000 0 0 4 40000 32 1
+                                                        
+					/* IDSEL 15 */
+					 7800 0 0 1 40000 32 1
+					 7800 0 0 2 40000 33 1
+					 7800 0 0 3 40000 34 1
+					 7800 0 0 4 40000 31 1
+
+					/* IDSEL 18 */
+					 9000 0 0 1 40000 31 1
+					 9000 0 0 2 40000 32 1
+					 9000 0 0 3 40000 33 1
+					 9000 0 0 4 40000 34 1
+
+					/* IDSEL 19 */
+					 9800 0 0 1 40000 34 1
+					 9800 0 0 2 40000 31 1
+					 9800 0 0 3 40000 32 1
+					 9800 0 0 4 40000 33 1
+
+					/* IDSEL 20 */
+					 a000 0 0 1 40000 33 1
+					 a000 0 0 2 40000 34 1
+					 a000 0 0 3 40000 31 1
+					 a000 0 0 4 40000 32 1
+
+					/* IDSEL 21 */
+					 a800 0 0 1 40000 32 1
+					 a800 0 0 2 40000 33 1
+					 a800 0 0 3 40000 34 1
+					 a800 0 0 4 40000 31 1>;
+
+			interrupt-parent = <40000>;
+			interrupts = <42 0>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 80000000 80000000 0 20000000
+				  01000000 0 00000000 e2000000 0 01000000>;
+		};
+
+		pic@40000 {
+			linux,phandle = <40000>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 20100>;
+			built-in;
+			device_type = "mpic";
+		};
+		
+		cpm@e0000000 {
+			linux,phandle = <e0000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			device_type = "cpm";
+			model = "CPM2";
+			ranges = <0 0 c0000>;
+			reg = <80000 40000>;
+			command-proc = <919c0>;
+			brg-frequency = <0>;
+
+			pic@90c00 {
+				linux,phandle = <90c00>;
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupts = <1e 0>;
+				interrupt-parent = <40000>;
+				reg = <90c00 80>;
+				built-in;
+				device_type = "cpm-pic";
+			};
+
+			scc@91a00 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SCC";
+				device-id = <2>;
+				reg = <91a00 20 88000 100>;
+				clock-setup = <00ffffff 0>;
+				rx-clock = <1>;
+				tx-clock = <1>;
+				current-speed = <0>;
+				interrupts = <64 3>;
+				interrupt-parent = <90c00>;
+			};
+
+			scc@91a20 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SCC";
+				device-id = <3>;
+				reg = <91a20 20 88100 100>;
+				clock-setup = <ff00ffff 90000>;
+				rx-clock = <2>;
+				tx-clock = <2>;
+				current-speed = <0>;
+				interrupts = <65 3>;
+				interrupt-parent = <90c00>;
+			};
+
+			fcc@91320 {
+				device_type = "network";
+				compatible = "fs_enet";
+				model = "FCC";
+				device-id = <3>;
+				reg = <91320 20 88500 100 913a0 30>;
+				mac-address = [ 00 00 0C 00 02 FD ];
+				clock-setup = <ff00ffff 250000>;
+				rx-clock = <15>;
+				tx-clock = <16>;
+				interrupts = <5d 3>;
+				interrupt-parent = <90c00>;
+				phy-handle = <2452002>;
+			};
+
+			fcc@91340 {
+				device_type = "network";
+				compatible = "fs_enet";
+				model = "FCC";
+				device-id = <4>;
+				reg = <91340 20 88600 100 913d0 30>;
+				mac-address = [ 00 00 0C 00 03 FD ];
+				clock-setup = <ffff00ff 3700>;
+				rx-clock = <17>;
+				tx-clock = <18>;
+				interrupts = <5e 3>;
+				interrupt-parent = <90c00>;
+				phy-handle = <2452003>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/configs/mpc8560_ads_defconfig b/arch/powerpc/configs/mpc8560_ads_defconfig
new file mode 100644
index 0000000..ddc2a7b
--- /dev/null
+++ b/arch/powerpc/configs/mpc8560_ads_defconfig
@@ -0,0 +1,854 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.18-rc4
+# Fri Aug 11 16:45:05 2006
+#
+# CONFIG_PPC64 is not set
+CONFIG_PPC32=y
+CONFIG_PPC_MERGE=y
+CONFIG_MMU=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_IRQ_PER_CPU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+# CONFIG_PPC_UDBG_16550 is not set
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_DEFAULT_UIMAGE=y
+
+#
+# Processor support
+#
+# CONFIG_CLASSIC32 is not set
+# CONFIG_PPC_52xx is not set
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+CONFIG_PPC_85xx=y
+# CONFIG_PPC_86xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+CONFIG_85xx=y
+CONFIG_E500=y
+CONFIG_BOOKE=y
+CONFIG_FSL_BOOKE=y
+# CONFIG_PHYS_64BIT is not set
+CONFIG_SPE=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_ALL is not set
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_RT_MUTEXES=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_SLOB is not set
+
+#
+# Loadable module support
+#
+# CONFIG_MODULES is not set
+
+#
+# Block layer
+#
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_MPIC=y
+CONFIG_CPM2=y
+# CONFIG_WANT_EARLY_SERIAL is not set
+
+#
+# Platform support
+#
+# CONFIG_MPC8540_ADS is not set
+CONFIG_MPC8560_ADS=y
+# CONFIG_MPC85xx_CDS is not set
+CONFIG_MPC8560=y
+CONFIG_PPC_INDIRECT_PCI_BE=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+# CONFIG_MATH_EMULATION is not set
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_PC_KEYBOARD is not set
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+# CONFIG_PROC_DEVICETREE is not set
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+# CONFIG_PPC_I8259 is not set
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_FSL_SOC=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_PCI_DEBUG=y
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
+# CONFIG_HOTPLUG_PCI is not set
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
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
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
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+
+#
+# TIPC Configuration (EXPERIMENTAL)
+#
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
+# CONFIG_NET_DIVERT is not set
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
+# CONFIG_IEEE80211 is not set
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
+# CONFIG_SYS_HYPERVISOR is not set
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=32768
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+CONFIG_BLK_DEV_INITRD=y
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+# CONFIG_WINDFARM is not set
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+
+#
+# PHY device support
+#
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+CONFIG_MARVELL_PHY=y
+CONFIG_DAVICOM_PHY=y
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_FIXED_PHY is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+CONFIG_E1000=y
+CONFIG_E1000_NAPI=y
+# CONFIG_E1000_DISABLE_PACKET_SPLIT is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+CONFIG_GIANFAR=y
+CONFIG_GFAR_NAPI=y
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+# CONFIG_NET_RADIO is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+# CONFIG_INPUT_EVDEV is not set
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
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
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+CONFIG_SERIAL_CPM_SCC1=y
+CONFIG_SERIAL_CPM_SCC2=y
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+# CONFIG_SERIAL_CPM_SMC1 is not set
+# CONFIG_SERIAL_CPM_SMC2 is not set
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_BRIQ_PANEL is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# SPI support
+#
+# CONFIG_SPI is not set
+# CONFIG_SPI_MASTER is not set
+
+#
+# Dallas's 1-wire bus
+#
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+CONFIG_VIDEO_V4L2=y
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+CONFIG_FIRMWARE_EDID=y
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+# CONFIG_USB is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# LED devices
+#
+# CONFIG_NEW_LEDS is not set
+
+#
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
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
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+# CONFIG_EXT3_FS_POSIX_ACL is not set
+# CONFIG_EXT3_FS_SECURITY is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
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
+CONFIG_PROC_KCORE=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
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
+# CONFIG_CRAMFS is not set
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
+# CONFIG_NFS_V3 is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
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
+# CONFIG_MSDOS_PARTITION is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Library routines
+#
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_PLIST=y
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
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_DETECT_SOFTLOCKUP=y
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+# CONFIG_DEBUG_INFO is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+# CONFIG_UNWIND_INFO is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_KGDB_CONSOLE is not set
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_BOOTX_TEXT is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+# CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 454fc53..3d440de 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -11,6 +11,12 @@ config MPC8540_ADS
 	help
 	  This option enables support for the MPC 8540 ADS board
 
+config MPC8560_ADS
+	bool "Freescale MPC8560 ADS"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the MPC 8560 ADS board
+
 config MPC85xx_CDS
 	bool "Freescale MPC85xx CDS"
 	select DEFAULT_UIMAGE
@@ -26,6 +32,11 @@ config MPC8540
 	select PPC_INDIRECT_PCI
 	default y if MPC8540_ADS || MPC85xx_CDS
 
+config MPC8560
+	bool
+	select PPC_INDIRECT_PCI
+	default y if MPC8560_ADS
+
 config PPC_INDIRECT_PCI_BE
 	bool
 	depends on PPC_85xx
diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 7615aa5..282f5d0 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -3,4 +3,5 @@ # Makefile for the PowerPC 85xx linux ke
 #
 obj-$(CONFIG_PPC_85xx)	+= misc.o pci.o
 obj-$(CONFIG_MPC8540_ADS) += mpc85xx_ads.o
+obj-$(CONFIG_MPC8560_ADS) += mpc85xx_ads.o
 obj-$(CONFIG_MPC85xx_CDS) += mpc85xx_cds.o
diff --git a/arch/powerpc/platforms/85xx/mpc8540_ads.h b/arch/powerpc/platforms/85xx/mpc8540_ads.h
index c0d56d2..670abaf 100644
--- a/arch/powerpc/platforms/85xx/mpc8540_ads.h
+++ b/arch/powerpc/platforms/85xx/mpc8540_ads.h
@@ -6,6 +6,10 @@
  * Maintainer: Kumar Gala <kumar.gala@freescale.com>
  *
  * Copyright 2004 Freescale Semiconductor Inc.
+ * 
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *	Merged to arch/powerpc
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -24,10 +28,10 @@ #define BCSR_ADDR		((uint)0xf8000000)
 #define BCSR_SIZE		((uint)(32 * 1024))
 
 /* PCI interrupt controller */
-#define PIRQA		MPC85xx_IRQ_EXT1
-#define PIRQB		MPC85xx_IRQ_EXT2
-#define PIRQC		MPC85xx_IRQ_EXT3
-#define PIRQD		MPC85xx_IRQ_EXT4
+#define PIRQA		49
+#define PIRQB		50
+#define PIRQC		51
+#define PIRQD		52
 
 /* Offset of CPM register space */
 #define CPM_MAP_ADDR	(CCSRBAR + MPC85xx_CPM_OFFSET)
diff --git a/arch/powerpc/platforms/85xx/mpc8560_ads.h b/arch/powerpc/platforms/85xx/mpc8560_ads.h
new file mode 100644
index 0000000..17b2327
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc8560_ads.h
@@ -0,0 +1,65 @@
+/*
+ * MPC8560ADS board definitions
+ *
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
+ *
+ * Copyright 2004 Freescale Semiconductor Inc.
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 	Merged to arch/powerpc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __MACH_MPC8560ADS_H
+#define __MACH_MPC8560ADS_H
+
+#include <linux/config.h>
+#include <linux/initrd.h>
+#include <sysdev/fsl_soc.h>
+
+#define BCSR_ADDR		((uint)0xf8000000)
+#define BCSR_SIZE		((uint)(32 * 1024))
+
+#define MPC85xx_CPM_OFFSET	(0x80000)
+
+#define CPM_MAP_ADDR		(get_immrbase() + MPC85xx_CPM_OFFSET)
+#define CPM_IRQ_OFFSET		60
+
+#define SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
+#define SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
+
+/* PCI interrupt controller */
+#define PIRQA		49
+#define PIRQB		50
+#define PIRQC		51
+#define PIRQD		52
+
+/* FCC1 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK9-12 */
+#define F1_RXCLK       12
+#define F1_TXCLK       11
+
+/* FCC2 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK13-16 */
+#define F2_RXCLK       13
+#define F2_TXCLK       14
+
+/* FCC3 Clock Source Configuration.  These can be
+ * redefined in the board specific file.
+ *    Can only choose from CLK13-16 */
+#define F3_RXCLK       15
+#define F3_TXCLK       16
+
+#endif				/* __MACH_MPC8560ADS_H */
diff --git a/arch/powerpc/platforms/85xx/mpc85xx.h b/arch/powerpc/platforms/85xx/mpc85xx.h
index b44db62..4fe613e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx.h
+++ b/arch/powerpc/platforms/85xx/mpc85xx.h
@@ -16,3 +16,4 @@
 
 extern void mpc85xx_restart(char *);
 extern int add_bridge(struct device_node *dev);
+extern void mpc85xx_pcibios_fixup(void);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index d0cfcdb..974e035 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -4,6 +4,10 @@
  * Maintained by Kumar Gala (see MAINTAINERS for contact information)
  *
  * Copyright 2005 Freescale Semiconductor Inc.
+ * 
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 	Merged to arch/powerpc
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -14,10 +18,12 @@
 #include <linux/stddef.h>
 #include <linux/kernel.h>
 #include <linux/pci.h>
+#include <linux/interrupt.h>
 #include <linux/kdev_t.h>
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/fs_enet_pd.h>
 
 #include <asm/system.h>
 #include <asm/time.h>
@@ -29,6 +35,12 @@ #include <asm/mpic.h>
 #include <mm/mmu_decl.h>
 #include <asm/udbg.h>
 
+#ifdef CONFIG_CPM2
+#include <asm/cpm2.h>
+#include <sysdev/cpm2_pic.h>
+#include <asm/fs_pd.h>
+#endif
+
 #include <sysdev/fsl_soc.h>
 #include "mpc85xx.h"
 
@@ -47,19 +59,19 @@ static u_char mpc85xx_ads_openpic_initse
 	MPC85XX_INTERNAL_IRQ_SENSES,
 	0x0,			/* External  0: */
 #if defined(CONFIG_PCI)
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 1: PCI slot 0 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 2: PCI slot 1 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 3: PCI slot 2 */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* Ext 4: PCI slot 3 */
+	IRQ_TYPE_LEVEL_LOW, 	/* Ext 1: PCI slot 0 */
+	IRQ_TYPE_LEVEL_LOW, 	/* Ext 2: PCI slot 1 */
+	IRQ_TYPE_LEVEL_LOW, 	/* Ext 3: PCI slot 2 */
+	IRQ_TYPE_LEVEL_LOW, 	/* Ext 4: PCI slot 3 */
 #else
 	0x0,			/* External  1: */
 	0x0,			/* External  2: */
 	0x0,			/* External  3: */
 	0x0,			/* External  4: */
 #endif
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 5: PHY */
+	IRQ_TYPE_LEVEL_LOW,  	/* External  5: PHY */
 	0x0,			/* External  6: */
-	(IRQ_SENSE_LEVEL | IRQ_POLARITY_NEGATIVE),	/* External 7: PHY */
+	IRQ_TYPE_LEVEL_LOW,  	/* External  7: PHY */
 	0x0,			/* External  8: */
 	0x0,			/* External  9: */
 	0x0,			/* External 10: */
@@ -74,40 +86,109 @@ #ifdef CONFIG_PCI
 int
 mpc85xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned char pin)
 {
-	static char pci_irq_table[][4] =
-	    /*
-	     * This is little evil, but works around the fact
-	     * that revA boards have IDSEL starting at 18
-	     * and others boards (older) start at 12
-	     *
-	     *      PCI IDSEL/INTPIN->INTLINE
-	     *       A      B      C      D
-	     */
-	{
-		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 2 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},
-		{PIRQC, PIRQD, PIRQA, PIRQB},
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 5 */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 12 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},
-		{PIRQC, PIRQD, PIRQA, PIRQB},
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 15 */
-		{0, 0, 0, 0},	/* -- */
-		{0, 0, 0, 0},	/* -- */
-		{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 18 */
-		{PIRQD, PIRQA, PIRQB, PIRQC},
-		{PIRQC, PIRQD, PIRQA, PIRQB},
-		{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 21 */
-	};
-
-	const long min_idsel = 2, max_idsel = 21, irqs_per_slot = 4;
-	return PCI_IRQ_TABLE_LOOKUP;
+	struct device_node * pci_OF;
+	struct irq_map_of_mask {
+		unsigned int idsel_msk;
+		unsigned int slot_msk;
+		unsigned int offset_irqs_msk;
+		unsigned int line_msk;
+	} *ip;
+	int i;
+	struct irq_of_table_s {
+		struct {
+			unsigned int idsel;
+			unsigned int slot;
+			unsigned int offset_irqs;
+			unsigned int line;
+			unsigned int parent;
+			unsigned int table_item;
+			unsigned int ext_irqs;
+		} idsel[1];
+	}* irq_of_table;
+
+
+	pci_OF = of_find_node_by_type(NULL, "pci");
+	if (pci_OF) {
+		unsigned long max_idsel = 0;
+		unsigned long min_idsel = 0xffffffff;
+		unsigned long irqs_per_slot = 0;
+		unsigned int idsel_ = 0;
+		unsigned int line;
+		unsigned int* irq;
+		unsigned int ip_len;
+		unsigned int irq_table_len;
+		unsigned int irq_len;
+
+		ip = (struct irq_map_of_mask*)get_property(pci_OF, "interrupt-map-mask", &ip_len);
+
+		irq_of_table = (struct irq_of_table_s*)get_property(pci_OF, "interrupt-map", &irq_table_len);
+
+		irq = (unsigned int*)get_property(pci_OF, "interrupts", &irq_len);
+
+		if (ip && irq_of_table && irq && ip_len && irq_table_len && irq_len ) {
+			for (i=0; i<irq_table_len/sizeof(irq_of_table->idsel[0]); i++) {
+				line = irq_of_table->idsel[i].line & ip->line_msk;
+				idsel_ = (irq_of_table->idsel[i].idsel & ip->idsel_msk) >> 11;
+
+				irqs_per_slot = (line > irqs_per_slot) ? line : irqs_per_slot;
+				min_idsel =  (idsel_ < min_idsel) ? idsel_ : min_idsel;
+				max_idsel =  (idsel_ > max_idsel) ? idsel_ : max_idsel;
+			}
+
+			do {
+				char pci_irq_table[max_idsel - min_idsel + 1][irqs_per_slot];
+
+				memset(&pci_irq_table[0][0], 0, sizeof(pci_irq_table));
+				for (i = irq_table_len/sizeof(irq_of_table->idsel[0]) - 1; i>=0;  i--) {
+					idsel_ = (irq_of_table->idsel[i].idsel & ip->idsel_msk) >> 11;
+
+					line = irq_of_table->idsel[i].line & ip->line_msk;
+					pci_irq_table[idsel_ - min_idsel][line-1] =
+							irq_of_table->idsel[i].table_item;
+				}
+
+				return PCI_IRQ_TABLE_LOOKUP;
+			} while(0);
+		} else {
+			printk(KERN_INFO "%s: device tree ERROR\n",__func__);
+			return -1;
+		}
+	} else {
+		static char pci_irq_table[][4] =
+		    /*
+		     * This is little evil, but works around the fact
+		     * that revA boards have IDSEL starting at 18
+		     * and others boards (older) start at 12
+		     *
+		     *      PCI IDSEL/INTPIN->INTLINE
+		     *       A      B      C      D
+		     */
+		{
+			{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 2 */
+			{PIRQD, PIRQA, PIRQB, PIRQC},
+			{PIRQC, PIRQD, PIRQA, PIRQB},
+			{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 5 */
+			{0, 0, 0, 0},	/* -- */
+			{0, 0, 0, 0},	/* -- */
+			{0, 0, 0, 0},	/* -- */
+			{0, 0, 0, 0},	/* -- */
+			{0, 0, 0, 0},	/* -- */
+			{0, 0, 0, 0},	/* -- */
+			{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 12 */
+			{PIRQD, PIRQA, PIRQB, PIRQC},
+			{PIRQC, PIRQD, PIRQA, PIRQB},
+			{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 15 */
+			{0, 0, 0, 0},	/* -- */
+			{0, 0, 0, 0},	/* -- */
+			{PIRQA, PIRQB, PIRQC, PIRQD},	/* IDSEL 18 */
+			{PIRQD, PIRQA, PIRQB, PIRQC},
+			{PIRQC, PIRQD, PIRQA, PIRQB},
+			{PIRQB, PIRQC, PIRQD, PIRQA},	/* IDSEL 21 */
+		};
+
+		const long min_idsel = 2, max_idsel = 21, irqs_per_slot = 4;
+		return PCI_IRQ_TABLE_LOOKUP;
+	}
 }
 
 int
@@ -121,52 +202,171 @@ mpc85xx_exclude_device(u_char bus, u_cha
 
 #endif /* CONFIG_PCI */
 
+#ifdef CONFIG_CPM2
+
+static void cpm2_cascade(unsigned int irq, struct irq_desc *desc,
+			 struct pt_regs *regs)
+{
+	int cascade_irq;
+
+	while ((cascade_irq = cpm2_get_irq(regs)) >= 0) {
+		generic_handle_irq(cascade_irq, regs);
+	}
+	desc->chip->eoi(irq);
+}
+
+#endif /* CONFIG_CPM2 */
 
 void __init mpc85xx_ads_pic_init(void)
 {
 	struct mpic *mpic1;
-	phys_addr_t OpenPIC_PAddr;
+	struct device_node *np;
+	struct resource r;
+	unsigned long opaddr;
+	int irq;
+
+	np = of_find_node_by_type(NULL, "mpic"); // TODO: change to mpic in the dts
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find mpic node\n");
+		return;
+	}
 
-	/* Determine the Physical Address of the OpenPIC regs */
-	OpenPIC_PAddr = get_immrbase() + MPC85xx_OPENPIC_OFFSET;
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "PIC init: invalid resource\n");
+		of_node_put(np);
+		return;
+	}
+	opaddr = r.start;
 
-	mpic1 = mpic_alloc(OpenPIC_PAddr,
+        mpic1 = mpic_alloc(np,
+			   opaddr,
 			   MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
-			   4, MPC85xx_OPENPIC_IRQ_OFFSET, 0, 250,
-			   mpc85xx_ads_openpic_initsenses,
-			   sizeof(mpc85xx_ads_openpic_initsenses),
+			   4,
+			   0,
 			   " OpenPIC  ");
 	BUG_ON(mpic1 == NULL);
-	mpic_assign_isu(mpic1, 0, OpenPIC_PAddr + 0x10200);
-	mpic_assign_isu(mpic1, 1, OpenPIC_PAddr + 0x10280);
-	mpic_assign_isu(mpic1, 2, OpenPIC_PAddr + 0x10300);
-	mpic_assign_isu(mpic1, 3, OpenPIC_PAddr + 0x10380);
-	mpic_assign_isu(mpic1, 4, OpenPIC_PAddr + 0x10400);
-	mpic_assign_isu(mpic1, 5, OpenPIC_PAddr + 0x10480);
-	mpic_assign_isu(mpic1, 6, OpenPIC_PAddr + 0x10500);
-	mpic_assign_isu(mpic1, 7, OpenPIC_PAddr + 0x10580);
+	mpic_assign_isu(mpic1, 0, opaddr + 0x10200);
+	mpic_assign_isu(mpic1, 1, opaddr + 0x10280);
+	mpic_assign_isu(mpic1, 2, opaddr + 0x10300);
+	mpic_assign_isu(mpic1, 3, opaddr + 0x10380);
+	mpic_assign_isu(mpic1, 4, opaddr + 0x10400);
+	mpic_assign_isu(mpic1, 5, opaddr + 0x10480);
+	mpic_assign_isu(mpic1, 6, opaddr + 0x10500);
+	mpic_assign_isu(mpic1, 7, opaddr + 0x10580);
 
 	/* dummy mappings to get to 48 */
-	mpic_assign_isu(mpic1, 8, OpenPIC_PAddr + 0x10600);
-	mpic_assign_isu(mpic1, 9, OpenPIC_PAddr + 0x10680);
-	mpic_assign_isu(mpic1, 10, OpenPIC_PAddr + 0x10700);
-	mpic_assign_isu(mpic1, 11, OpenPIC_PAddr + 0x10780);
+	mpic_assign_isu(mpic1, 8, opaddr + 0x10600);
+	mpic_assign_isu(mpic1, 9, opaddr + 0x10680);
+	mpic_assign_isu(mpic1, 10, opaddr + 0x10700);
+	mpic_assign_isu(mpic1, 11, opaddr + 0x10780);
 
 	/* External ints */
-	mpic_assign_isu(mpic1, 12, OpenPIC_PAddr + 0x10000);
-	mpic_assign_isu(mpic1, 13, OpenPIC_PAddr + 0x10080);
-	mpic_assign_isu(mpic1, 14, OpenPIC_PAddr + 0x10100);
+	mpic_assign_isu(mpic1, 12, opaddr + 0x10000);
+	mpic_assign_isu(mpic1, 13, opaddr + 0x10080);
+	mpic_assign_isu(mpic1, 14, opaddr + 0x10100);
+
+	mpic_set_default_senses(mpic1,
+				mpc85xx_ads_openpic_initsenses,
+				sizeof(mpc85xx_ads_openpic_initsenses));
+
 	mpic_init(mpic1);
+	of_node_put(np);
+
+#ifdef CONFIG_CPM2
+	/* Setup CPM2 PIC */
+
+	np = of_find_node_by_type(NULL, "cpm-pic");// TODO: change to cpm-pic in the dts
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
+                return;
+	}
+	irq = irq_of_parse_and_map(np, 0);
+
+	cpm2_pic_init(np);
+
+	set_irq_chained_handler(irq, cpm2_cascade);
+	of_node_put(np);
+#endif
 }
 
 /*
  * Setup the architecture
  */
+static void init_fcc_ioports(void)
+{
+	struct immap *immap;
+	struct io_port *io;
+	u32 tempval;
+
+	immap = cpm2_immr;
+
+	io = &immap->im_ioport;
+	/* FCC2/3 are on the ports B/C. */
+	tempval = in_be32(&io->iop_pdirb);
+	tempval &= ~PB2_DIRB0;
+	tempval |= PB2_DIRB1;
+	out_be32(&io->iop_pdirb, tempval);
+
+	tempval = in_be32(&io->iop_psorb);
+	tempval &= ~PB2_PSORB0;
+	tempval |= PB2_PSORB1;
+	out_be32(&io->iop_psorb, tempval);
+
+	tempval = in_be32(&io->iop_pparb);
+	tempval |= (PB2_DIRB0 | PB2_DIRB1);
+	out_be32(&io->iop_pparb, tempval);
+
+	tempval = in_be32(&io->iop_pdirb);
+	tempval &= ~PB3_DIRB0;
+	tempval |= PB3_DIRB1;
+	out_be32(&io->iop_pdirb, tempval);
+
+	tempval = in_be32(&io->iop_psorb);
+	tempval &= ~PB3_PSORB0;
+	tempval |= PB3_PSORB1;
+	out_be32(&io->iop_psorb, tempval);
+
+	tempval = in_be32(&io->iop_pparb);
+	tempval |= (PB3_DIRB0 | PB3_DIRB1);
+	out_be32(&io->iop_pparb, tempval);
+
+	tempval = in_be32(&io->iop_pdirc);
+	tempval |= PC3_DIRC1;
+	out_be32(&io->iop_pdirc, tempval);
+
+	tempval = in_be32(&io->iop_pparc);
+	tempval |= PC3_DIRC1;
+	out_be32(&io->iop_pparc, tempval);
+
+	/* Port C has clocks......  */
+	tempval = in_be32(&io->iop_psorc);
+	tempval &= ~(CLK_TRX);
+	out_be32(&io->iop_psorc, tempval);
+
+	tempval = in_be32(&io->iop_pdirc);
+	tempval &= ~(CLK_TRX);
+	out_be32(&io->iop_pdirc, tempval);
+	tempval = in_be32(&io->iop_pparc);
+	tempval |= (CLK_TRX);
+	out_be32(&io->iop_pparc, tempval);
+
+	/* Configure Serial Interface clock routing.
+	 * First,  clear all FCC bits to zero,
+	 * then set the ones we want.
+	 */
+	immap->im_cpmux.cmx_fcr &= ~(CPMUX_CLK_MASK);
+	immap->im_cpmux.cmx_fcr |= CPMUX_CLK_ROUTE;
+}
+
 static void __init mpc85xx_ads_setup_arch(void)
 {
 	struct device_node *cpu;
 	struct device_node *np;
 
+#ifdef CONFIG_CPM2
+	cpm2_reset();
+#endif
+
 	if (ppc_md.progress)
 		ppc_md.progress("mpc85xx_ads_setup_arch()", 0);
 
@@ -224,10 +424,9 @@ void mpc85xx_ads_show_cpuinfo(struct seq
  */
 static int __init mpc85xx_ads_probe(void)
 {
-	/* We always match for now, eventually we should look at the flat
-	   dev tree to ensure this is the board we are suppose to run on
-	*/
-	return 1;
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "MPC85xxADS");
 }
 
 define_machine(mpc85xx_ads) {
@@ -237,7 +436,10 @@ define_machine(mpc85xx_ads) {
 	.init_IRQ		= mpc85xx_ads_pic_init,
 	.show_cpuinfo		= mpc85xx_ads_show_cpuinfo,
 	.get_irq		= mpic_get_irq,
+	.pcibios_fixup		= mpc85xx_pcibios_fixup,
 	.restart		= mpc85xx_restart,
 	.calibrate_decr		= generic_calibrate_decr,
+#ifndef CONFIG_CPM2
 	.progress		= udbg_progress,
+#endif
 };
diff --git a/arch/powerpc/platforms/85xx/pci.c b/arch/powerpc/platforms/85xx/pci.c
index 05930ee..af4cef5 100644
--- a/arch/powerpc/platforms/85xx/pci.c
+++ b/arch/powerpc/platforms/85xx/pci.c
@@ -3,6 +3,10 @@
  *
  * Maintained by Kumar Gala (see MAINTAINERS for contact information)
  *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *      Merged to arch/powerpc
+ *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
  * Free Software Foundation;  either version 2 of the  License, or (at your
@@ -93,4 +97,12 @@ int __init add_bridge(struct device_node
 	return 0;
 }
 
+void __init mpc85xx_pcibios_fixup(void)
+{
+	struct pci_dev *dev = NULL;
+
+	for_each_pci_dev(dev)
+		pci_read_irq_line(dev);
+}
+
 #endif
diff --git a/include/asm-powerpc/mpc85xx.h b/include/asm-powerpc/mpc85xx.h
new file mode 100644
index 0000000..aa85945
--- /dev/null
+++ b/include/asm-powerpc/mpc85xx.h
@@ -0,0 +1,199 @@
+/*
+ * include/asm-ppc/mpc85xx.h
+ *
+ * MPC85xx definitions
+ *
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_MPC85xx_H__
+#define __ASM_MPC85xx_H__
+
+#include <asm/mmu.h>
+
+#ifdef CONFIG_85xx
+
+#ifdef CONFIG_MPC8540_ADS
+#include <platforms/85xx/mpc8540_ads.h>
+#endif
+#if defined(CONFIG_MPC8555_CDS) || defined(CONFIG_MPC8548_CDS)
+#include <platforms/85xx/mpc8555_cds.h>
+#endif
+#ifdef CONFIG_MPC85xx_CDS
+#include <platforms/85xx/mpc85xx_cds.h>
+#endif
+#ifdef CONFIG_MPC8560_ADS
+#include <platforms/85xx/mpc8560_ads.h>
+#endif
+#ifdef CONFIG_SBC8560
+#include <platforms/85xx/sbc8560.h>
+#endif
+#ifdef CONFIG_STX_GP3
+#include <platforms/85xx/stx_gp3.h>
+#endif
+#if defined(CONFIG_TQM8540) || defined(CONFIG_TQM8541) || \
+	defined(CONFIG_TQM8555) || defined(CONFIG_TQM8560)
+#include <platforms/85xx/tqm85xx.h>
+#endif
+
+#define _IO_BASE        isa_io_base
+#define _ISA_MEM_BASE   isa_mem_base
+#ifdef CONFIG_PCI
+#define PCI_DRAM_OFFSET pci_dram_offset
+#else
+#define PCI_DRAM_OFFSET 0
+#endif
+
+/*
+ * The "residual" board information structure the boot loader passes
+ * into the kernel.
+ */
+extern unsigned char __res[];
+
+/* Offset from CCSRBAR */
+#define MPC85xx_CPM_OFFSET	(0x80000)
+#define MPC85xx_CPM_SIZE	(0x40000)
+#define MPC85xx_DMA_OFFSET	(0x21000)
+#define MPC85xx_DMA_SIZE	(0x01000)
+#define MPC85xx_DMA0_OFFSET	(0x21100)
+#define MPC85xx_DMA0_SIZE	(0x00080)
+#define MPC85xx_DMA1_OFFSET	(0x21180)
+#define MPC85xx_DMA1_SIZE	(0x00080)
+#define MPC85xx_DMA2_OFFSET	(0x21200)
+#define MPC85xx_DMA2_SIZE	(0x00080)
+#define MPC85xx_DMA3_OFFSET	(0x21280)
+#define MPC85xx_DMA3_SIZE	(0x00080)
+#define MPC85xx_ENET1_OFFSET	(0x24000)
+#define MPC85xx_ENET1_SIZE	(0x01000)
+#define MPC85xx_MIIM_OFFSET	(0x24520)
+#define MPC85xx_MIIM_SIZE	(0x00018)
+#define MPC85xx_ENET2_OFFSET	(0x25000)
+#define MPC85xx_ENET2_SIZE	(0x01000)
+#define MPC85xx_ENET3_OFFSET	(0x26000)
+#define MPC85xx_ENET3_SIZE	(0x01000)
+#define MPC85xx_GUTS_OFFSET	(0xe0000)
+#define MPC85xx_GUTS_SIZE	(0x01000)
+#define MPC85xx_IIC1_OFFSET	(0x03000)
+#define MPC85xx_IIC1_SIZE	(0x00100)
+#define MPC85xx_OPENPIC_OFFSET	(0x40000)
+#define MPC85xx_OPENPIC_SIZE	(0x40000)
+#define MPC85xx_PCI1_OFFSET	(0x08000)
+#define MPC85xx_PCI1_SIZE	(0x01000)
+#define MPC85xx_PCI2_OFFSET	(0x09000)
+#define MPC85xx_PCI2_SIZE	(0x01000)
+#define MPC85xx_PERFMON_OFFSET	(0xe1000)
+#define MPC85xx_PERFMON_SIZE	(0x01000)
+#define MPC85xx_SEC2_OFFSET	(0x30000)
+#define MPC85xx_SEC2_SIZE	(0x10000)
+#define MPC85xx_UART0_OFFSET	(0x04500)
+#define MPC85xx_UART0_SIZE	(0x00100)
+#define MPC85xx_UART1_OFFSET	(0x04600)
+#define MPC85xx_UART1_SIZE	(0x00100)
+
+#define MPC85xx_CCSRBAR_SIZE	(1024*1024)
+
+/* Let modules/drivers get at CCSRBAR */
+extern phys_addr_t get_ccsrbar(void);
+
+#ifdef MODULE
+#define CCSRBAR get_ccsrbar()
+#else
+#define CCSRBAR BOARD_CCSRBAR
+#endif
+
+enum ppc_sys_devices {
+	MPC85xx_TSEC1,
+	MPC85xx_TSEC2,
+	MPC85xx_FEC,
+	MPC85xx_IIC1,
+	MPC85xx_DMA0,
+	MPC85xx_DMA1,
+	MPC85xx_DMA2,
+	MPC85xx_DMA3,
+	MPC85xx_DUART,
+	MPC85xx_PERFMON,
+	MPC85xx_SEC2,
+	MPC85xx_CPM_SPI,
+	MPC85xx_CPM_I2C,
+	MPC85xx_CPM_USB,
+	MPC85xx_CPM_SCC1,
+	MPC85xx_CPM_SCC2,
+	MPC85xx_CPM_SCC3,
+	MPC85xx_CPM_SCC4,
+	MPC85xx_CPM_FCC1,
+	MPC85xx_CPM_FCC2,
+	MPC85xx_CPM_FCC3,
+	MPC85xx_CPM_MCC1,
+	MPC85xx_CPM_MCC2,
+	MPC85xx_CPM_SMC1,
+	MPC85xx_CPM_SMC2,
+	MPC85xx_eTSEC1,
+	MPC85xx_eTSEC2,
+	MPC85xx_eTSEC3,
+	MPC85xx_eTSEC4,
+	MPC85xx_IIC2,
+	MPC85xx_MDIO,
+	NUM_PPC_SYS_DEVS,
+};
+
+#define MPC85XX_INTERNAL_IRQ_SENSES			\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  0 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  1 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  2 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  3 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  4 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  5 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  6 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  7 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  8 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal  9 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 10 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 11 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 12 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 13 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 14 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 15 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 16 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 17 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 18 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 19 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 20 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 21 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 22 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 23 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 24 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 25 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 26 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 27 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 28 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 29 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 30 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 31 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 32 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 33 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 34 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 35 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 36 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 37 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 38 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 39 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 40 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 41 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 42 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 43 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 44 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 45 */	\
+	IRQ_TYPE_LEVEL_HIGH, 	/* Internal 46 */	\
+	IRQ_TYPE_LEVEL_HIGH 	/* Internal 47 */
+
+#endif /* CONFIG_85xx */
+#endif /* __ASM_MPC85xx_H__ */
+#endif /* __KERNEL__ */
