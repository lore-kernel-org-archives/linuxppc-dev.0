Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (cdma-45-244.msk.skylink.ru
	[83.217.45.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 53C6E67C37
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 10:44:35 +1000 (EST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.7/8.13.7) with ESMTP id k7C0iTPR006795
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 04:44:29 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 2/2] [incomplete]POWERPC: add support of mpc8272 eval board
Date: Sat, 12 Aug 2006 04:44:29 +0400
To: linuxppc-dev@ozlabs.org
Message-Id: <20060812004429.6748.17011.stgit@localhost.localdomain>
In-Reply-To: <20060812003759.6748.89145.stgit@localhost.localdomain>
References: <20060812003759.6748.89145.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Vitaly Bordug <vbordug@ru.mvista.com>

Powerpc-merged 8272 code and all necessary stuff to make it actually
work. Still a lot of stuff pending, but the code works and make SoC
usable, so might be a good reference for the similar hw.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/Kconfig                       |    1 
 arch/powerpc/boot/dts/mpc8272ads.dts       |  248 ++++++++
 arch/powerpc/configs/mpc8272_ads_defconfig |  888 ++++++++++++++++++++++++++++
 arch/powerpc/kernel/prom_parse.c           |    2 
 arch/powerpc/platforms/82xx/Kconfig        |   21 +
 arch/powerpc/platforms/82xx/Makefile       |    6 
 arch/powerpc/platforms/82xx/mpc8272_ads.c  |  333 +++++++++++
 arch/powerpc/platforms/82xx/pq2ads.c       |   55 ++
 arch/powerpc/platforms/82xx/pq2ads.h       |  115 ++++
 arch/powerpc/platforms/82xx/pq2ads_pd.h    |  114 ++++
 arch/powerpc/platforms/Makefile            |    1 
 arch/powerpc/sysdev/cpm2_pic.c             |    2 
 arch/powerpc/sysdev/cpm2_pic.h             |    2 
 arch/powerpc/sysdev/fsl_soc.c              |   62 ++
 include/asm-powerpc/mpc8260.h              |  103 +++
 15 files changed, 1949 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 13e583f..052d35a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -578,6 +578,7 @@ endmenu
 
 source arch/powerpc/platforms/embedded6xx/Kconfig
 source arch/powerpc/platforms/4xx/Kconfig
+source arch/powerpc/platforms/82xx/Kconfig
 source arch/powerpc/platforms/83xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
 source arch/powerpc/platforms/86xx/Kconfig
diff --git a/arch/powerpc/boot/dts/mpc8272ads.dts b/arch/powerpc/boot/dts/mpc8272ads.dts
new file mode 100644
index 0000000..0d1f36e
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc8272ads.dts
@@ -0,0 +1,248 @@
+/*
+ * MPC8272 ADS Device Tree Source
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/*
+/memreserve/	00000000 4000000;
+*/
+
+/ {
+	model = "MPC8272ADS";
+	compatible = "MPC8260ADS";
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
+		PowerPC,8272@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <4000>;		// L1, 16K
+			i-cache-size = <4000>;		// L1, 16K
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
+		reg = <00000000 4000000>;
+	};
+
+	chosen {
+		name = "chosen";
+		bootargs = "root=/dev/nfs rw ip=on";
+		linux,stdout-path = "/dev/ttyCPM0";
+		linux,platform = <0>;
+		interrupt-controller = <10c00>;
+		linux,phandle = <400>;
+	};
+
+	soc8272@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = < 0 0 2 00000000 f0000000 00053000>;
+		reg = <f0000000 0>;
+		bus-frequency = <0>;
+
+		mdio@0 {
+			device_type = "mdio";
+			compatible = "fs_enet";
+			reg = <0 0>;
+			linux,phandle = <24520>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ethernet-phy@0 {
+				linux,phandle = <2452000>;
+				interrupt-parent = <10c00>;
+				interrupts = <19 1>;
+				reg = <0>;
+				bitbang = [ 12 12 13 02 02 01 ];
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <2452001>;
+				interrupt-parent = <10c00>;
+				interrupts = <19 1>;
+				bitbang = [ 12 12 13 02 02 01 ];
+				reg = <3>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			device-id = <2>;
+			compatible = "fs_enet";
+			model = "FCC";
+			reg = <11300 20 8400 100 11380 30>;
+			address = [ 00 11 2F 99 43 54 ];
+			interrupts = <20 2>;
+			interrupt-parent = <10c00>;
+			phy-handle = <2452000>;
+			rx-clock = <13>;
+			tx-clock = <12>;
+		};
+
+		ethernet@25000 {
+			device_type = "network";
+			device-id = <3>;
+			compatible = "fs_enet";
+			model = "FCC";
+			reg = <11320 20 8500 100 113b0 30>;
+			address = [ 00 11 2F 99 44 55 ];
+			interrupts = <21 2>;
+			interrupt-parent = <10c00>;
+			phy-handle = <2452001>;
+			rx-clock = <17>;
+			tx-clock = <18>;
+		};
+
+		cpm@f0000000 {
+			linux,phandle = <f0000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			device_type = "cpm";
+			model = "CPM2";
+			ranges = <00000000 00000000 3ffff>;
+			reg = <10d80 3280>;
+			command-proc = <119c0>;
+			brg-frequency = <17D7840>;
+			cpm_clk = <BEBC200>;
+
+			scc@11a00 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SCC";
+				device-id = <2>;
+				reg = <11a00 20 8000 100>;
+				current-speed = <1c200>;
+				interrupts = <28 2>;
+				interrupt-parent = <10c00>;
+				clock-setup = <0 00ffffff>;
+				rx-clock = <0>;
+				tx-clock = <0>;
+			};
+
+			scc@11a60 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SCC";
+				device-id = <5>;
+				reg = <11a60 20 8300 100>;
+				current-speed = <0>;
+				interrupts = <2b 2>;
+				interrupt-parent = <10c00>;
+				clock-setup = <1b ffffff00>;
+				rx-clock = <0>;
+				tx-clock = <0>;
+			};
+
+		};
+		interrupt-controller@10c00 {
+			linux,phandle = <10c00>;
+			clock-frequency = <0>;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <10c00 80>;
+			built-in;
+			device_type = "cpm-pic";
+		};
+		pci@8500 {
+			linux,phandle = <0500>;
+			interrupt-map-mask = <f800 0 0 7>;
+			interrupt-map = <
+
+					/* IDSEL 0x10 */
+					 8000 0 0 1 700 0 0
+					 8000 0 0 2 700 1 0
+					 8000 0 0 3 700 2 0
+					 8000 0 0 4 700 3 0
+                                                                
+					/* IDSEL 0x11 */
+					 8800 0 0 1 700 0 0
+					 8800 0 0 2 700 1 0
+					 8800 0 0 3 700 2 0
+					 8800 0 0 4 700 3 0
+                                                                
+					/* IDSEL 0x12 */
+					 9000 0 0 1 700 0 0
+					 9000 0 0 2 700 1 0
+					 9000 0 0 3 700 2 0
+					 9000 0 0 4 700 3 0
+                                                                
+					/* IDSEL 0x13 */
+					 9800 0 0 1 700 1 0
+					 9800 0 0 2 700 2 0
+					 9800 0 0 3 700 3 0
+					 9800 0 0 4 700 0 0
+                                                                
+					/* IDSEL 0x14 */
+					 a000 0 0 1 700 2 0
+					 a000 0 0 2 700 3 0
+					 a000 0 0 3 700 0 0
+					 a000 0 0 4 700 1 0
+                                                                
+					/* IDSEL 0x15 */
+					 a800 0 0 1 700 3 0
+					 a800 0 0 2 700 0 0
+					 a800 0 0 3 700 1 0
+					 a800 0 0 4 700 2 0>;
+			interrupt-parent = <10c00>;
+			interrupts = <80 1>;
+			bus-range = <0 0>;
+			ranges = <02000000 0 a0000000 a0000000 0 10000000
+				  42000000 0 80000000 80000000 0 10000000
+				  01000000 0 00000000 e2000000 0 00100000>;
+			clock-frequency = <3f940aa>;
+			#interrupt-cells = <1>;
+			#size-cells = <2>;
+			#address-cells = <3>;
+			reg = <8000 1000>;
+			compatible = "85xx";
+			device_type = "pci";
+		};
+
+/* May need to remove if on a part without crypto engine */
+		crypto@30000 {
+			device_type = "crypto";
+			model = "SEC2";
+			compatible = "talitos";
+			reg = <30000 10000>;
+			interrupts = <b 0>;
+			interrupt-parent = <10c00>;
+			num-channels = <4>;
+			channel-fifo-len = <18>;
+			exec-units-mask = <0000007e>;
+/* desc mask is for rev1.x, we need runtime fixup for >=2.x */
+			descriptor-types-mask = <01010ebf>;
+		};
+
+	};
+};
diff --git a/arch/powerpc/configs/mpc8272_ads_defconfig b/arch/powerpc/configs/mpc8272_ads_defconfig
new file mode 100644
index 0000000..e27cde8
--- /dev/null
+++ b/arch/powerpc/configs/mpc8272_ads_defconfig
@@ -0,0 +1,888 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.18-rc3
+# Fri Aug 11 20:40:38 2006
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
+CONFIG_PPC_82xx=y
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_86xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_8xx is not set
+# CONFIG_E200 is not set
+CONFIG_6xx=y
+CONFIG_PPC_FPU=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_SMP is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# Code maturity level options
+#
+# CONFIG_EXPERIMENTAL is not set
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+
+#
+# General setup
+#
+CONFIG_LOCALVERSION="powerpc8272"
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+CONFIG_SYSCTL=y
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
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
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+# CONFIG_KMOD is not set
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
+CONFIG_PQ2ADS=y
+CONFIG_8260=y
+CONFIG_8272=y
+CONFIG_CPM2=y
+# CONFIG_WANT_EARLY_SERIAL is not set
+CONFIG_EMBEDDEDBOOT=y
+
+#
+# Platform support
+#
+CONFIG_MPC8272_ADS=y
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
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_PC_KEYBOARD is not set
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_RESOURCES_64BIT is not set
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+# CONFIG_PPC_I8259 is not set
+CONFIG_FSL_SOC=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PCI Hotplug Support
+#
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
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# Core Netfilter Configuration
+#
+# CONFIG_NETFILTER_NETLINK is not set
+# CONFIG_NETFILTER_XTABLES is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_CONNTRACK is not set
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
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
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_BLK_DEV_INITRD is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDEFLOPPY is not set
+# CONFIG_IDE_TASK_IOCTL is not set
+
+#
+# IDE chipset support/bugfixes
+#
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_IDE_ARM is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_IDEDMA_AUTO is not set
+# CONFIG_BLK_DEV_HD is not set
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
+
+#
+# I2O device support
+#
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
+CONFIG_TUN=y
+
+#
+# PHY device support
+#
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
+# CONFIG_FIXED_PHY is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
+
+#
+# Ethernet (1000 Mbit)
+#
+
+#
+# Ethernet (10000 Mbit)
+#
+
+#
+# Token Ring devices
+#
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
+CONFIG_PPP=y
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=y
+CONFIG_PPP_SYNC_TTY=y
+CONFIG_PPP_DEFLATE=y
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_SLIP is not set
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
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
+CONFIG_INPUT_EVDEV=y
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
+CONFIG_INPUT_MOUSE=y
+CONFIG_MOUSE_PS2=y
+# CONFIG_MOUSE_SERIAL is not set
+# CONFIG_MOUSE_VSXXXAA is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+# CONFIG_INPUT_MISC is not set
+
+#
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+# CONFIG_SERIO_I8042 is not set
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
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+CONFIG_SERIAL_CPM_SCC1=y
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+CONFIG_SERIAL_CPM_SCC4=y
+# CONFIG_SERIAL_CPM_SMC1 is not set
+# CONFIG_SERIAL_CPM_SMC2 is not set
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
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
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
+# CONFIG_HWMON is not set
+# CONFIG_HWMON_VID is not set
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
+# CONFIG_FIRMWARE_EDID is not set
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
+# CONFIG_USB_ARCH_HAS_HCD is not set
+# CONFIG_USB_ARCH_HAS_OHCI is not set
+# CONFIG_USB_ARCH_HAS_EHCI is not set
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
+CONFIG_USB_GADGET=y
+# CONFIG_USB_GADGET_DEBUG_FILES is not set
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_PXA2XX is not set
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+# CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_DUMMY_HCD is not set
+# CONFIG_USB_GADGET_DUALSPEED is not set
+# CONFIG_USB_ZERO is not set
+# CONFIG_USB_ETH is not set
+# CONFIG_USB_GADGETFS is not set
+# CONFIG_USB_FILE_STORAGE is not set
+# CONFIG_USB_G_SERIAL is not set
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
+
+#
+# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+#
+
+#
+# Real Time Clock
+#
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
+CONFIG_FS_POSIX_ACL=y
+CONFIG_XFS_FS=y
+# CONFIG_XFS_QUOTA is not set
+# CONFIG_XFS_SECURITY is not set
+# CONFIG_XFS_POSIX_ACL is not set
+# CONFIG_XFS_RT is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+# CONFIG_INOTIFY_USER is not set
+# CONFIG_QUOTA is not set
+CONFIG_DNOTIFY=y
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=y
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
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_HFSPLUS_FS is not set
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
+CONFIG_NFS_V3_ACL=y
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SMB_FS=y
+# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
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
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=y
+
+#
+# Library routines
+#
+CONFIG_CRC_CCITT=y
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
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
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_RWSEMS is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_FS is not set
+# CONFIG_DEBUG_VM is not set
+CONFIG_FORCED_INLINING=y
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_DEBUGGER is not set
+# CONFIG_KGDB_CONSOLE is not set
+CONFIG_BDI_SWITCH=y
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
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_KHAZAD is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
+# CONFIG_CRYPTO_CRC32C is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#
diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 59f69d3..686b66c 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -895,6 +895,7 @@ int of_irq_map_one(struct device_node *d
 }
 EXPORT_SYMBOL_GPL(of_irq_map_one);
 
+#ifdef CONFIG_PCI
 int of_irq_map_pci(struct pci_dev *pdev, struct of_irq *out_irq)
 {
 	struct device_node *dn, *ppnode;
@@ -971,4 +972,5 @@ #endif
 	return of_irq_map_raw(ppnode, &lspec, laddr, out_irq);
 }
 EXPORT_SYMBOL_GPL(of_irq_map_pci);
+#endif
 
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
new file mode 100644
index 0000000..c8e4f1c
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -0,0 +1,21 @@
+menu "Platform support"
+	depends on PPC_82xx
+
+choice
+	prompt "Machine Type"
+	default MPC8272_ADS
+
+config MPC8272_ADS
+	bool "Freescale MPC8272 ADS"
+	select DEFAULT_UIMAGE
+	select PQ2ADS
+	select 8272
+	select 8260
+	select CPM2
+	select FSL_SOC
+	help
+	  This option enables support for the MPC8272 ADS board
+
+endchoice
+
+endmenu
diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
new file mode 100644
index 0000000..e6f06b4
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the PowerPC 82xx linux kernel.
+#
+obj-$(CONFIG_PPC_82xx)	+= pq2ads.o
+obj-$(CONFIG_MPC8272_ADS) += mpc8272_ads.o
+
diff --git a/arch/powerpc/platforms/82xx/mpc8272_ads.c b/arch/powerpc/platforms/82xx/mpc8272_ads.c
new file mode 100644
index 0000000..dac06f3
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/mpc8272_ads.c
@@ -0,0 +1,333 @@
+/*
+ * MPC8272 setup and early boot code plus other random bits.
+ *
+ * Maintained by Kumar Gala (see MAINTAINERS for contact information)
+ *
+ * Copyright 2005 Freescale Semiconductor Inc.
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *      Merged to arch/powerpc from the respective file in arch/ppc/syslib/
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/kdev_t.h>
+#include <linux/major.h>
+#include <linux/console.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/initrd.h>
+#include <linux/module.h>
+#include <linux/fsl_devices.h>
+#include <linux/fs_uart_pd.h>
+
+#include <asm/system.h>
+#include <asm/pgtable.h>
+#include <asm/page.h>
+#include <asm/atomic.h>
+#include <asm/time.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/bootinfo.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc8260.h>
+#include <asm/irq.h>
+#include <mm/mmu_decl.h>
+#include <asm/prom.h>
+#include <asm/cpm2.h>
+#include <asm/udbg.h>
+#include <asm/i8259.h>
+#include <linux/fs_enet_pd.h>
+
+#include <sysdev/fsl_soc.h>
+#include <../sysdev/cpm2_pic.h>
+
+#include "pq2ads_pd.h"
+
+static void __init mpc8272_ads_pic_init (void)
+{
+	struct device_node *np = of_find_node_by_type(NULL, "cpm-pic");
+	struct resource r;
+
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
+                return;
+	}
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "PIC init: invalid resource\n");
+		of_node_put(np);
+		return;
+	}
+	cpm2_pic_init(np);
+	of_node_put(np);
+
+	/* Initialize the default interrupt mapping priorities,
+	 * in case the boot rom changed something on us.
+	 */
+	cpm2_immr->im_intctl.ic_siprr = 0x05309770;
+}
+
+static int __init get_freq(char *name, unsigned long *val)
+{
+	struct device_node *cpu;
+	unsigned int *fp;
+	int found = 0;
+
+	/* The cpu node should have timebase and clock frequency properties */
+	cpu = of_find_node_by_type(NULL, "cpu");
+
+	if (cpu) {
+		fp = (unsigned int *)get_property(cpu, name, NULL);
+		if (fp) {
+			found = 1;
+			*val = *fp++;
+		}
+
+		of_node_put(cpu);
+	}
+
+	return found;
+}
+
+static void __init
+m8272_calibrate_decr(void)
+{
+	ppc_tb_freq = 125000000;
+	if (!get_freq("bus-frequency", &ppc_tb_freq)) {
+		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
+			"(not found)\n");
+	}
+	ppc_tb_freq /= 4;
+	ppc_proc_freq = 1000000000;
+	if (!get_freq("clock-frequency", &ppc_proc_freq)) {
+		printk(KERN_ERR "WARNING: Estimating processor frequency "
+			"(not found)\n");
+	}
+}
+
+static void init_fcc1_ioports(struct fs_platform_info *fpi)
+{
+	struct io_port *io;
+	u32 tempval;
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+	u32 *bcsr = ioremap(BCSR_ADDR+4, sizeof(u32));
+
+	io = &immap->im_ioport;
+
+	/* Enable the PHY */
+	clrbits32(bcsr, BCSR1_FETHIEN);
+	setbits32(bcsr, BCSR1_FETH_RST);
+
+	/* FCC1 pins are on port A/C. */
+	/* Configure port A and C pins for FCC1 Ethernet. */
+
+	tempval = in_be32(&io->iop_pdira);
+	tempval &= ~PA1_DIRA0;
+	tempval |= PA1_DIRA1;
+	out_be32(&io->iop_pdira, tempval);
+
+	tempval = in_be32(&io->iop_psora);
+	tempval &= ~PA1_PSORA0;
+	tempval |= PA1_PSORA1;
+	out_be32(&io->iop_psora, tempval);
+
+	setbits32(&io->iop_ppara,PA1_DIRA0 | PA1_DIRA1);
+
+	/* Alter clocks */
+	tempval = PC_F1TXCLK|PC_F1RXCLK;
+
+	clrbits32(&io->iop_psorc, tempval);
+	clrbits32(&io->iop_pdirc, tempval);
+	setbits32(&io->iop_pparc, tempval);
+
+	cpm2_clk_setup(CPM_CLK_FCC1, fpi->clk_rx, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC1, fpi->clk_tx, CPM_CLK_TX);
+
+	iounmap(bcsr);
+	iounmap(immap);
+}
+
+static void init_fcc2_ioports(struct fs_platform_info *fpi)
+{
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+	u32 *bcsr = ioremap(BCSR_ADDR+12, sizeof(u32));
+
+	struct io_port *io;
+	u32 tempval;
+
+	immap = cpm2_immr;
+
+	io = &immap->im_ioport;
+
+	/* Enable the PHY */
+	clrbits32(bcsr, BCSR3_FETHIEN2);
+	setbits32(bcsr, BCSR3_FETH2_RST);
+
+	/* FCC2 are port B/C. */
+	/* Configure port A and C pins for FCC2 Ethernet. */
+
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
+	setbits32(&io->iop_pparb,PB2_DIRB0 | PB2_DIRB1);
+
+	tempval = PC_F2RXCLK|PC_F2TXCLK;
+
+	/* Alter clocks */
+	clrbits32(&io->iop_psorc,tempval);
+	clrbits32(&io->iop_pdirc,tempval);
+	setbits32(&io->iop_pparc,tempval);
+
+	cpm2_clk_setup(CPM_CLK_FCC2, fpi->clk_rx, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC2, fpi->clk_tx, CPM_CLK_TX);
+
+	iounmap(bcsr);
+	iounmap(immap);
+}
+
+void init_fcc_ioports(struct fs_platform_info *fpi)
+{
+	int fcc_no = fs_get_fcc_index(fpi->fs_no);
+
+	switch (fcc_no) {
+	case 0:
+		init_fcc1_ioports(fpi);
+		break;
+	case 1:
+		init_fcc2_ioports(fpi);
+		break;
+	default:
+		printk(KERN_ERR "init_fcc_ioports: invalid FCC number\n");
+		return;
+	}
+}
+
+static void init_scc1_uart_ioports(void)
+{
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+
+        /* SCC1 is only on port D */
+	setbits32(&immap->im_ioport.iop_ppard,0x00000003);
+	clrbits32(&immap->im_ioport.iop_psord,0x00000001);
+	setbits32(&immap->im_ioport.iop_psord,0x00000002);
+	clrbits32(&immap->im_ioport.iop_pdird,0x00000001);
+	setbits32(&immap->im_ioport.iop_pdird,0x00000002);
+
+        /* Wire BRG1 to SCC1 */
+	clrbits32(&immap->im_cpmux.cmx_scr,0x00ffffff);
+
+	iounmap(immap);
+}
+
+static void init_scc4_uart_ioports(void)
+{
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+
+	setbits32(&immap->im_ioport.iop_ppard,0x00000600);
+	clrbits32(&immap->im_ioport.iop_psord,0x00000600);
+	clrbits32(&immap->im_ioport.iop_pdird,0x00000200);
+	setbits32(&immap->im_ioport.iop_pdird,0x00000400);
+
+        /* Wire BRG4 to SCC4 */
+	clrbits32(&immap->im_cpmux.cmx_scr,0x000000ff);
+	setbits32(&immap->im_cpmux.cmx_scr,0x0000001b);
+
+	iounmap(immap);
+}
+
+void init_scc_ioports(struct fs_uart_platform_info *data)
+{
+	int scc_no = fs_get_scc_index(data->fs_no);
+
+	switch (scc_no) {
+	case 0: init_scc1_uart_ioports();
+		data->brg = 1;
+		break;
+	case 3: init_scc4_uart_ioports();
+		data->brg = 4;
+		break;
+	default:
+		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
+		return;
+	}
+}
+/*
+ * Setup the architecture
+ */
+static void __init
+mpc8272_ads_setup_arch(void)
+{
+	if (ppc_md.progress)
+		ppc_md.progress("mpc82xx_ads_setup_arch()", 0);
+	cpm2_reset();
+
+        /* Map I/O region to a 256MB BAT */
+
+	m82xx_board_setup();
+	if (ppc_md.progress)
+		ppc_md.progress("mpc82xx_ads_setup_arch(), finish", 0);
+}
+
+void
+mpc8272_ads_show_cpuinfo(struct seq_file *m)
+{
+	uint pvid, svid, phid1;
+	uint memsize = total_memory;
+
+	pvid = mfspr(SPRN_PVR);
+	svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
+	seq_printf(m, "Machine\t\t: %s\n", CPUINFO_MACHINE);
+	seq_printf(m, "PVR\t\t: 0x%x\n", pvid);
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+
+	/* Display cpu Pll setting */
+	phid1 = mfspr(SPRN_HID1);
+	seq_printf(m, "PLL setting\t: 0x%x\n", ((phid1 >> 24) & 0x3f));
+
+	/* Display the amount of memory */
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init mpc8272_ads_probe(void)
+{
+	/* We always match for now, eventually we should look at
+	 * the flat dev tree to ensure this is the board we are
+	 * supposed to run on
+	 */
+	return 1;
+}
+
+define_machine(mpc8272_ads) {
+	.name		= "MPC8272 ADS",
+	.probe		= mpc8272_ads_probe,
+	.setup_arch	= mpc8272_ads_setup_arch,
+	.init_IRQ	= mpc8272_ads_pic_init,
+	.show_cpuinfo	= mpc8272_ads_show_cpuinfo,
+	.get_irq	= cpm2_get_irq,
+	.calibrate_decr = m8272_calibrate_decr,
+};
diff --git a/arch/powerpc/platforms/82xx/pq2ads.c b/arch/powerpc/platforms/82xx/pq2ads.c
new file mode 100644
index 0000000..57235e9
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2ads.c
@@ -0,0 +1,55 @@
+/*
+ * PQ2ADS platform support
+ *
+ * Author: Kumar Gala <galak@kernel.crashing.org>
+ * Derived from: est8260_setup.c by Allen Curtis
+ *
+ * Copyright 2004 Freescale Semiconductor, Inc.
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *	Merged to arch/powerpc from the respective file in arch/ppc/syslib/
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+
+#include <asm/io.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/immap_cpm2.h>
+
+void __init
+m82xx_board_setup(void)
+{
+	u32 *bcsr = ioremap(BCSR_ADDR+4, sizeof(u32));
+
+	/* Enable the 2nd UART port */
+	clrbits32(bcsr, BCSR1_RS232_EN2);
+
+#ifdef CONFIG_SERIAL_CPM_SCC1
+	clrbits32((u32*)&cpm2_immr->im_scc[0].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+	clrbits32((u32*)&cpm2_immr->im_scc[0].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SCC2
+	clrbits32((u32*)&cpm2_immr->im_scc[1].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+	clrbits32((u32*)&cpm2_immr->im_scc[1].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SCC3
+	clrbits32((u32*)&cpm2_immr->im_scc[2].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+	clrbits32((u32*)&cpm2_immr->im_scc[2].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SCC4
+	clrbits32((u32*)&cpm2_immr->im_scc[3].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+	clrbits32((u32*)&cpm2_immr->im_scc[3].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+#endif
+
+	iounmap(bcsr);
+}
diff --git a/arch/powerpc/platforms/82xx/pq2ads.h b/arch/powerpc/platforms/82xx/pq2ads.h
new file mode 100644
index 0000000..ca9017e
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2ads.h
@@ -0,0 +1,115 @@
+/*
+ * A collection of structures, addresses, and values associated with
+ * the Motorola MPC8260ADS/MPC8266ADS-PCI boards.
+ * Copied from the RPX-Classic and SBS8260 stuff.
+ *
+ * Copyright (c) 2001 Dan Malek (dan@mvista.com)
+ *
+ * 2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *      Merged to arch/powerpc from the respective file in arch/ppc/syslib/
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+     
+#ifdef __KERNEL__
+#ifndef __MACH_ADS8260_DEFS
+#define __MACH_ADS8260_DEFS
+
+#include <linux/config.h>
+
+#include <asm/ppcboot.h>
+
+#if defined(CONFIG_MPC8272_ADS)
+#define BOARD_CHIP_NAME "8272"
+#endif
+
+/* Memory map is configured by the PROM startup.
+ * We just map a few things we need.  The CSR is actually 4 byte-wide
+ * registers that can be accessed as 8-, 16-, or 32-bit values.
+ */
+#define CPM_MAP_ADDR		((uint)0xf0000000)
+#define BCSR_ADDR		((uint)0xf4500000)
+#define BCSR_SIZE		((uint)(32 * 1024))
+
+#define BOOTROM_RESTART_ADDR	((uint)0xff000104)
+
+/* For our show_cpuinfo hooks. */
+#define CPUINFO_VENDOR		"Motorola"
+#define CPUINFO_MACHINE		"PQ2 ADS PowerPC"
+
+/* The ADS8260 has 16, 32-bit wide control/status registers, accessed
+ * only on word boundaries.
+ * Not all are used (yet), or are interesting to us (yet).
+ */
+
+/* Things of interest in the CSR.
+*/
+#define BCSR0_LED0		((uint)0x02000000)	/* 0 == on */
+#define BCSR0_LED1		((uint)0x01000000)	/* 0 == on */
+#define BCSR1_FETHIEN		((uint)0x08000000)	/* 0 == enable */
+#define BCSR1_FETH_RST		((uint)0x04000000)	/* 0 == reset */
+#define BCSR1_RS232_EN1		((uint)0x02000000)	/* 0 == enable */
+#define BCSR1_RS232_EN2		((uint)0x01000000)	/* 0 == enable */
+#define BCSR3_FETHIEN2		((uint)0x10000000)	/* 0 == enable */
+#define BCSR3_FETH2_RST 	((uint)0x80000000)	/* 0 == reset */
+
+#define PHY_INTERRUPT	SIU_INT_IRQ7
+#define CPM_IRQ_OFFSET	0
+
+#define SIU_INT_SMC1		((uint)0x04+CPM_IRQ_OFFSET)
+#define SIU_INT_SMC2		((uint)0x05+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC1		((uint)0x28+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC2		((uint)0x29+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC3		((uint)0x2a+CPM_IRQ_OFFSET)
+#define SIU_INT_SCC4		((uint)0x2b+CPM_IRQ_OFFSET)
+
+#ifdef CONFIG_PCI
+/* PCI interrupt controller */
+#define PCI_INT_STAT_REG	0xF8200000
+#define PCI_INT_MASK_REG	0xF8200004
+#define PIRQA			(NR_CPM_INTS + 0)
+#define PIRQB			(NR_CPM_INTS + 1)
+#define PIRQC			(NR_CPM_INTS + 2)
+#define PIRQD			(NR_CPM_INTS + 3)
+
+/*
+ * PCI memory map definitions for MPC8266ADS-PCI.
+ *
+ * processor view
+ *	local address		PCI address		target
+ *	0x80000000-0x9FFFFFFF	0x80000000-0x9FFFFFFF	PCI mem with prefetch
+ *	0xA0000000-0xBFFFFFFF	0xA0000000-0xBFFFFFFF	PCI mem w/o prefetch
+ *	0xF4000000-0xF7FFFFFF	0x00000000-0x03FFFFFF	PCI IO
+ *
+ * PCI master view
+ *	local address		PCI address		target
+ *	0x00000000-0x1FFFFFFF	0x00000000-0x1FFFFFFF	MPC8266 local memory
+ */
+
+/* All the other PCI memory map definitions reside at syslib/m82xx_pci.h
+   Here we should redefine what is unique for this board */
+#define M82xx_PCI_SLAVE_MEM_LOCAL	0x00000000	/* Local base */
+#define M82xx_PCI_SLAVE_MEM_BUS		0x00000000	/* PCI base */
+#define M82xx_PCI_SLAVE_MEM_SIZE	0x10000000	/* 256 Mb */
+
+#define M82xx_PCI_SLAVE_SEC_WND_SIZE	~(0x40000000 - 1U)	/* 2 x 512Mb  */
+#define M82xx_PCI_SLAVE_SEC_WND_BASE	0x80000000		/* PCI Memory base */
+
+#if defined(CONFIG_MPC8272_ADS)
+#define PCI_INT_TO_SIU 	SIU_INT_IRQ2
+#elif defined(CONFIG_PQ2FADS)
+#define PCI_INT_TO_SIU 	SIU_INT_IRQ6
+#else
+#warning PCI Bridge will be without interrupts support
+#endif
+
+#endif /* CONFIG_PCI */
+
+void m82xx_board_setup (void);
+
+#endif /* __MACH_ADS8260_DEFS */
+#endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/82xx/pq2ads_pd.h b/arch/powerpc/platforms/82xx/pq2ads_pd.h
new file mode 100644
index 0000000..c910617
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2ads_pd.h
@@ -0,0 +1,114 @@
+#ifndef __PQ2ADS_PD_H
+#define __PQ2ADS_PD_H
+/*
+ * arch/ppc/platforms/82xx/pq2ads_pd.h
+ *
+ * Some defines for MPC82xx board-specific PlatformDevice descriptions
+ *
+ * 2005-2006 (c) MontaVista Software, Inc.
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/* FCC1 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK9-12 */
+
+#define F1_RXCLK	11
+#define F1_TXCLK	10
+
+/* FCC2 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#define F2_RXCLK	15
+#define F2_TXCLK	16
+
+/* FCC3 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#define F3_RXCLK	13
+#define F3_TXCLK	14
+
+/* Automatically generates register configurations */
+#define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
+
+#define CMXFCR_RF1CS(x)	((uint)((x-5)<<27))	/* FCC1 Receive Clock Source */
+#define CMXFCR_TF1CS(x)	((uint)((x-5)<<24))	/* FCC1 Transmit Clock Source */
+#define CMXFCR_RF2CS(x)	((uint)((x-9)<<19))	/* FCC2 Receive Clock Source */
+#define CMXFCR_TF2CS(x) ((uint)((x-9)<<16))	/* FCC2 Transmit Clock Source */
+#define CMXFCR_RF3CS(x)	((uint)((x-9)<<11))	/* FCC3 Receive Clock Source */
+#define CMXFCR_TF3CS(x) ((uint)((x-9)<<8))	/* FCC3 Transmit Clock Source */
+
+#define PC_F1RXCLK	PC_CLK(F1_RXCLK)
+#define PC_F1TXCLK	PC_CLK(F1_TXCLK)
+#define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
+#define CMX1_CLK_MASK	((uint)0xff000000)
+
+#define PC_F2RXCLK	PC_CLK(F2_RXCLK)
+#define PC_F2TXCLK	PC_CLK(F2_TXCLK)
+#define CMX2_CLK_ROUTE	(CMXFCR_RF2CS(F2_RXCLK) | CMXFCR_TF2CS(F2_TXCLK))
+#define CMX2_CLK_MASK	((uint)0x00ff0000)
+
+#define PC_F3RXCLK	PC_CLK(F3_RXCLK)
+#define PC_F3TXCLK	PC_CLK(F3_TXCLK)
+#define CMX3_CLK_ROUTE	(CMXFCR_RF3CS(F3_RXCLK) | CMXFCR_TF3CS(F3_TXCLK))
+#define CMX3_CLK_MASK	((uint)0x0000ff00)
+
+/* I/O Pin assignment for FCC1.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PA1_COL		0x00000001U
+#define PA1_CRS		0x00000002U
+#define PA1_TXER	0x00000004U
+#define PA1_TXEN	0x00000008U
+#define PA1_RXDV	0x00000010U
+#define PA1_RXER	0x00000020U
+#define PA1_TXDAT	0x00003c00U
+#define PA1_RXDAT	0x0003c000U
+#define PA1_PSORA0	(PA1_RXDAT | PA1_TXDAT)
+#define PA1_PSORA1	(PA1_COL | PA1_CRS | PA1_TXER | PA1_TXEN | \
+		PA1_RXDV | PA1_RXER)
+#define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
+#define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
+
+
+/* I/O Pin assignment for FCC2.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB2_TXER	0x00000001U
+#define PB2_RXDV	0x00000002U
+#define PB2_TXEN	0x00000004U
+#define PB2_RXER	0x00000008U
+#define PB2_COL		0x00000010U
+#define PB2_CRS		0x00000020U
+#define PB2_TXDAT	0x000003c0U
+#define PB2_RXDAT	0x00003c00U
+#define PB2_PSORB0	(PB2_RXDAT | PB2_TXDAT | PB2_CRS | PB2_COL | \
+		PB2_RXER | PB2_RXDV | PB2_TXER)
+#define PB2_PSORB1	(PB2_TXEN)
+#define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
+#define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
+
+
+/* I/O Pin assignment for FCC3.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB3_RXDV	0x00004000U
+#define PB3_RXER	0x00008000U
+#define PB3_TXER	0x00010000U
+#define PB3_TXEN	0x00020000U
+#define PB3_COL		0x00040000U
+#define PB3_CRS		0x00080000U
+#define PB3_TXDAT	0x0f000000U
+#define PB3_RXDAT	0x00f00000U
+#define PB3_PSORB0	(PB3_RXDAT | PB3_TXDAT | PB3_CRS | PB3_COL | \
+		PB3_RXER | PB3_RXDV | PB3_TXER | PB3_TXEN)
+#define PB3_PSORB1	0
+#define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
+#define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
+
+#define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
+#define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
+#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
+
+#endif
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 5cf46dc..86ca117 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -7,6 +7,7 @@ endif
 endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
+obj-$(CONFIG_PPC_82xx)		+= 82xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_86xx)		+= 86xx/
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index 845a08b..617200e 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -145,7 +145,7 @@ static struct irq_chip cpm2_pic = {
 	.end = cpm2_end_irq,
 };
 
-int cpm2_get_irq(struct pt_regs *regs)
+unsigned int cpm2_get_irq(struct pt_regs *regs)
 {
 	int irq;
         unsigned long bits;
diff --git a/arch/powerpc/sysdev/cpm2_pic.h b/arch/powerpc/sysdev/cpm2_pic.h
index d63e45d..3c513e5 100644
--- a/arch/powerpc/sysdev/cpm2_pic.h
+++ b/arch/powerpc/sysdev/cpm2_pic.h
@@ -3,7 +3,7 @@ #define _PPC_KERNEL_CPM2_H
 
 extern intctl_cpm2_t *cpm2_intctl;
 
-extern int cpm2_get_irq(struct pt_regs *regs);
+extern unsigned int cpm2_get_irq(struct pt_regs *regs);
 
 extern void cpm2_pic_init(struct device_node*);
 
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 7878613..d809717 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -39,6 +39,7 @@ #include <asm/cpm2.h>
 #endif
 
 extern void init_fcc_ioports(struct fs_platform_info*);
+extern void init_scc_ioports(struct fs_uart_platform_info*);
 static phys_addr_t immrbase = -1;
 
 phys_addr_t get_immrbase(void)
@@ -544,6 +545,13 @@ static const char *fcc_regs_c = "fcc_reg
 static const char *fcc_pram = "fcc_pram";
 static char bus_id[9][BUS_ID_SIZE];
 
+#define MAC_ADDR_WHILE	/* TEMPORARILY, while the error exists: second mac-addr
+			   can't be extracted from device tree */
+#ifdef MAC_ADDR_WHILE
+static int ma_init = 0;
+__u8 mac_addr_save [6];
+#endif
+
 static int __init fs_enet_of_init(void)
 {
 	struct device_node *np;
@@ -558,7 +566,7 @@ static int __init fs_enet_of_init(void)
 		struct resource r[4];
 		struct device_node *phy, *mdio;
 		struct fs_platform_info fs_enet_data;
-		unsigned int *id, *phy_addr;
+		unsigned int *id, *phy_addr, *phy_irq;
 		void *mac_addr;
 		phandle *ph;
 		char *model;
@@ -580,6 +588,7 @@ static int __init fs_enet_of_init(void)
 		if (ret)
 			goto err;
 		r[2].name = fcc_regs_c;
+		fs_enet_data.fcc_regs_c = r[2].start;
 
 		r[3].start = r[3].end = irq_of_parse_and_map(np, 0);
 		r[3].flags = IORESOURCE_IRQ;
@@ -598,8 +607,19 @@ static int __init fs_enet_of_init(void)
 			goto unreg;
 		}
 
+#ifdef MAC_ADDR_WHILE	/* TEMPORARYLY, while the error exists: second mac-addr
+			   can't be extracted from device tree */
+		if (!ma_init) {
+			mac_addr = (void*)get_property(np, "address", NULL);
+			memcpy(mac_addr_save, mac_addr, 6);
+			ma_init = 1;
+		} else
+			mac_addr_save[4] += 1;
+		memcpy(fs_enet_data.macaddr, mac_addr_save, 6);
+#else
 		mac_addr = (void *)get_property(np, "mac-address", NULL);
 		memcpy(fs_enet_data.macaddr, mac_addr, 6);
+#endif
 
 		ph = (phandle *) get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
@@ -611,6 +631,7 @@ static int __init fs_enet_of_init(void)
 
 		phy_addr = (u32 *) get_property(phy, "reg", NULL);
 		fs_enet_data.phy_addr = *phy_addr;
+		phy_irq = (u32 *) get_property(phy, "interrupts", NULL);
 
 		id = (u32 *) get_property(np, "device-id", NULL);
 		fs_enet_data.fs_no = *id;
@@ -628,6 +649,7 @@ static int __init fs_enet_of_init(void)
 
 		if (strstr(model, "FCC")) {
 			int fcc_index = fs_get_fcc_index(*id);
+			unsigned char* mdio_bb_prop;
 
 			fs_enet_data.dpram_offset = (u32)cpm_dpram_addr(0);
 			fs_enet_data.rx_ring = 32;
@@ -638,11 +660,47 @@ static int __init fs_enet_of_init(void)
 			fs_enet_data.mem_offset = FCC_MEM_OFFSET(fcc_index);
 			fs_enet_data.cp_page = CPM_CR_FCC_PAGE(fcc_index);
 			fs_enet_data.cp_block = CPM_CR_FCC_SBLOCK(fcc_index);
-
 			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%x:%02x",
 							(u32)res.start, fs_enet_data.phy_addr);
 			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
 			fs_enet_data.init_ioports = init_fcc_ioports;
+			mdio_bb_prop = (unsigned char*)get_property(phy, "bitbang", NULL);
+			if (mdio_bb_prop) {
+				struct platform_device *fs_enet_mdio_bb_dev;
+				struct fs_mii_bb_platform_info fs_enet_mdio_bb_data;
+
+				fs_enet_mdio_bb_dev =
+		    			platform_device_register_simple("fsl-bb-mdio",
+						i, NULL, 0);
+				memset(&fs_enet_mdio_bb_data, 0,
+					sizeof(struct fs_mii_bb_platform_info));
+				fs_enet_mdio_bb_data.mdio_dat.bit = mdio_bb_prop[0];
+				fs_enet_mdio_bb_data.mdio_dir.bit = mdio_bb_prop[1];
+				fs_enet_mdio_bb_data.mdc_dat.bit = mdio_bb_prop[2];
+				fs_enet_mdio_bb_data.mdio_port = mdio_bb_prop[3];
+				fs_enet_mdio_bb_data.mdc_port = mdio_bb_prop[4];
+				fs_enet_mdio_bb_data.delay = mdio_bb_prop[5];
+				fs_enet_mdio_bb_data.irq[0] = phy_irq[0];
+				fs_enet_mdio_bb_data.irq[1] = -1;
+				fs_enet_mdio_bb_data.irq[2] = -1;
+				fs_enet_mdio_bb_data.irq[3] = phy_irq[0];
+				fs_enet_mdio_bb_data.irq[31] = -1;
+				fs_enet_mdio_bb_data.mdio_dat.offset =
+					(u32)&cpm2_immr->im_ioport.iop_pdatc;
+				fs_enet_mdio_bb_data.mdio_dir.offset =
+					(u32)&cpm2_immr->im_ioport.iop_pdirc;
+				fs_enet_mdio_bb_data.mdc_dat.offset =
+					(u32)&cpm2_immr->im_ioport.iop_pdatc;
+				ret = platform_device_add_data(fs_enet_mdio_bb_dev,
+					&fs_enet_mdio_bb_data,
+					sizeof(struct fs_mii_bb_platform_info));
+				if (ret)
+					goto unreg;
+			} else {
+				printk(KERN_ERR "mii-properties isn't found in device tree\n");
+				ret = -ENODEV;
+				goto unreg;
+			}
 		}
 
 		of_node_put(phy);
diff --git a/include/asm-powerpc/mpc8260.h b/include/asm-powerpc/mpc8260.h
new file mode 100644
index 0000000..2dda188
--- /dev/null
+++ b/include/asm-powerpc/mpc8260.h
@@ -0,0 +1,103 @@
+/*
+ * Since there are many different boards and no standard configuration,
+ * we have a unique include file for each.  Rather than change every
+ * file that has to include MPC8260 configuration, they all include
+ * this one and the configuration switching is done here.
+ */
+#ifdef __KERNEL__
+#ifndef __ASM_PPC_MPC8260_H__
+#define __ASM_PPC_MPC8260_H__
+
+#include <linux/config.h>
+
+#ifdef CONFIG_8260
+
+#ifdef CONFIG_EST8260
+#include <platforms/est8260.h>
+#endif
+
+#ifdef CONFIG_SBC82xx
+#include <platforms/sbc82xx.h>
+#endif
+
+#ifdef CONFIG_SBS8260
+#include <platforms/sbs8260.h>
+#endif
+
+#ifdef CONFIG_RPX8260
+#include <platforms/rpx8260.h>
+#endif
+
+#ifdef CONFIG_WILLOW
+#include <platforms/willow.h>
+#endif
+
+#ifdef CONFIG_TQM8260
+#include <platforms/tqm8260.h>
+#endif
+
+#if defined(CONFIG_PQ2ADS) || defined (CONFIG_PQ2FADS)
+#include <platforms/82xx/pq2ads.h>
+#endif
+
+#ifdef CONFIG_PCI_8260
+#include <platforms/82xx/m82xx_pci.h>
+#endif
+
+/* Make sure the memory translation stuff is there if PCI not used.
+ */
+#ifndef _IO_BASE
+#define _IO_BASE        0
+#endif
+
+#ifndef _ISA_MEM_BASE
+#define _ISA_MEM_BASE   0
+#endif
+
+#ifndef PCI_DRAM_OFFSET
+#define PCI_DRAM_OFFSET 0
+#endif
+
+/* Map 256MB I/O region
+ */
+#ifndef IO_PHYS_ADDR
+#define IO_PHYS_ADDR	0xe0000000
+#endif
+#ifndef IO_VIRT_ADDR
+#define IO_VIRT_ADDR	IO_PHYS_ADDR
+#endif
+
+enum ppc_sys_devices {
+	MPC82xx_CPM_FCC1,
+	MPC82xx_CPM_FCC2,
+	MPC82xx_CPM_FCC3,
+	MPC82xx_CPM_I2C,
+	MPC82xx_CPM_SCC1,
+	MPC82xx_CPM_SCC2,
+	MPC82xx_CPM_SCC3,
+	MPC82xx_CPM_SCC4,
+	MPC82xx_CPM_SPI,
+	MPC82xx_CPM_MCC1,
+	MPC82xx_CPM_MCC2,
+	MPC82xx_CPM_SMC1,
+	MPC82xx_CPM_SMC2,
+	MPC82xx_CPM_USB,
+	MPC82xx_SEC1,
+	MPC82xx_MDIO_BB,
+	NUM_PPC_SYS_DEVS,
+};
+
+#ifndef __ASSEMBLY__
+/* The "residual" data board information structure the boot loader
+ * hands to us.
+ */
+extern unsigned char __res[];
+#endif
+
+#ifndef BOARD_CHIP_NAME
+#define BOARD_CHIP_NAME ""
+#endif
+
+#endif /* CONFIG_8260 */
+#endif /* !__ASM_PPC_MPC8260_H__ */
+#endif /* __KERNEL__ */
