Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C81C6DE070
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 02:59:09 +1000 (EST)
Date: Mon, 17 Sep 2007 11:58:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 28/28] mpc82xx: Add pq2fads board support.
Message-ID: <20070917165824.GB6563@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070917165643.GA6545@loki.buserror.net>
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
 arch/powerpc/boot/dts/pq2fads.dts      |  229 ++++++++
 arch/powerpc/configs/pq2fads_defconfig | 1003 ++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/82xx/Kconfig    |   11 +
 arch/powerpc/platforms/82xx/Makefile   |    1 +
 arch/powerpc/platforms/82xx/pq2fads.c  |  198 +++++++
 5 files changed, 1442 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/pq2fads.dts
 create mode 100644 arch/powerpc/configs/pq2fads_defconfig
 create mode 100644 arch/powerpc/platforms/82xx/pq2fads.c

diff --git a/arch/powerpc/boot/dts/pq2fads.dts b/arch/powerpc/boot/dts/pq2fads.dts
new file mode 100644
index 0000000..54e8bd1
--- /dev/null
+++ b/arch/powerpc/boot/dts/pq2fads.dts
@@ -0,0 +1,229 @@
+/*
+ * Device Tree for the PQ2FADS-ZU board with an MPC8280 chip.
+ *
+ * Copyright 2007 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+/ {
+	model = "pq2fads";
+	compatible = "fsl,pq2fads";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <d#32>;
+			i-cache-line-size = <d#32>;
+			d-cache-size = <d#16384>;
+			i-cache-size = <d#16384>;
+			timebase-frequency = <0>;
+			clock-frequency = <0>;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0>;
+	};
+
+	localbus@f0010100 {
+		compatible = "fsl,mpc8280-localbus",
+		             "fsl,pq2-localbus";
+		#address-cells = <2>;
+		#size-cells = <1>;
+		reg = <f0010100 60>;
+
+		ranges = <0 0 fe000000 00800000
+		          1 0 f4500000 00008000
+		          8 0 f8200000 00008000>;
+
+		flash@0,0 {
+			compatible = "jedec-flash";
+			reg = <0 0 800000>;
+			bank-width = <4>;
+			device-width = <1>;
+		};
+
+		bcsr@1,0 {
+			reg = <1 0 20>;
+			compatible = "fsl,pq2fads-bcsr";
+		};
+
+		PCI_PIC: pic@8,0 {
+			#interrupt-cells = <1>;
+			interrupt-controller;
+			reg = <8 0 8>;
+			compatible = "fsl,pq2ads-pci-pic";
+			interrupt-parent = <&PIC>;
+			interrupts = <18 8>;
+		};
+	};
+
+	pci@f0010800 {
+		device_type = "pci";
+		reg = <f0010800 10c f00101ac 8 f00101c4 8>;
+		compatible = "fsl,mpc8280-pci", "fsl,pq2-pci";
+		#interrupt-cells = <1>;
+		#size-cells = <2>;
+		#address-cells = <3>;
+		clock-frequency = <d#66000000>;
+		interrupt-map-mask = <f800 0 0 7>;
+		interrupt-map = <
+		                /* IDSEL 0x16 */
+		                 b000 0 0 1 &PCI_PIC 0
+		                 b000 0 0 2 &PCI_PIC 1
+		                 b000 0 0 3 &PCI_PIC 2
+		                 b000 0 0 4 &PCI_PIC 3
+
+		                /* IDSEL 0x17 */
+		                 b800 0 0 1 &PCI_PIC 4
+		                 b800 0 0 2 &PCI_PIC 5
+		                 b800 0 0 3 &PCI_PIC 6
+		                 b800 0 0 4 &PCI_PIC 7
+
+		                /* IDSEL 0x18 */
+		                 c000 0 0 1 &PCI_PIC 8
+		                 c000 0 0 2 &PCI_PIC 9
+		                 c000 0 0 3 &PCI_PIC a
+		                 c000 0 0 4 &PCI_PIC b>;
+
+		interrupt-parent = <&PIC>;
+		interrupts = <12 8>;
+		ranges = <42000000 0 80000000 80000000 0 20000000
+		          02000000 0 a0000000 a0000000 0 20000000
+		          01000000 0 00000000 f6000000 0 02000000>;
+	};
+
+	soc@f0000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		device_type = "soc";
+		compatible = "fsl,mpc8280", "fsl,pq2-soc";
+		ranges = <00000000 f0000000 00053000>;
+
+		// Temporary -- will go away once kernel uses ranges for get_immrbase().
+		reg = <f0000000 00053000>;
+
+		cpm@119c0 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			compatible = "fsl,mpc8280-cpm", "fsl,cpm2";
+			reg = <119c0 30 0 2000>;
+			ranges;
+
+			brg@119f0 {
+				compatible = "fsl,mpc8280-brg",
+				             "fsl,cpm2-brg",
+				             "fsl,cpm-brg";
+				reg = <119f0 10 115f0 10>;
+			};
+
+			serial@11a00 {
+				device_type = "serial";
+				compatible = "fsl,mpc8280-scc-uart",
+				             "fsl,cpm2-scc-uart";
+				reg = <11a00 20 8000 100>;
+				interrupts = <28 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-brg = <1>;
+				fsl,cpm-command = <00800000>;
+			};
+
+			serial@11a20 {
+				device_type = "serial";
+				compatible = "fsl,mpc8280-scc-uart",
+				             "fsl,cpm2-scc-uart";
+				reg = <11a20 20 8100 100>;
+				interrupts = <29 8>;
+				interrupt-parent = <&PIC>;
+				fsl,cpm-brg = <2>;
+				fsl,cpm-command = <04a00000>;
+			};
+
+			ethernet@11320 {
+				device_type = "network";
+				compatible = "fsl,mpc8280-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <11320 20 8500 100 113b0 1>;
+				interrupts = <21 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&PHY0>;
+				linux,network-index = <0>;
+				fsl,cpm-command = <16200300>;
+			};
+
+			ethernet@11340 {
+				device_type = "network";
+				compatible = "fsl,mpc8280-fcc-enet",
+				             "fsl,cpm2-fcc-enet";
+				reg = <11340 20 8600 100 113d0 1>;
+				interrupts = <22 8>;
+				interrupt-parent = <&PIC>;
+				phy-handle = <&PHY1>;
+				linux,network-index = <1>;
+				fsl,cpm-command = <1a400300>;
+				local-mac-address = [00 e0 0c 00 79 01];
+			};
+
+			mdio@10d40 {
+				device_type = "mdio";
+				compatible = "fsl,pq2fads-mdio-bitbang",
+				             "fsl,mpc8280-mdio-bitbang",
+				             "fsl,cpm2-mdio-bitbang";
+				#address-cells = <1>;
+				#size-cells = <0>;
+				reg = <10d40 14>;
+				fsl,mdio-pin = <9>;
+				fsl,mdc-pin = <a>;
+
+				PHY0: ethernet-phy@0 {
+					interrupt-parent = <&PIC>;
+					interrupts = <19 2>;
+					reg = <0>;
+					device_type = "ethernet-phy";
+				};
+
+				PHY1: ethernet-phy@1 {
+					interrupt-parent = <&PIC>;
+					interrupts = <19 2>;
+					reg = <3>;
+					device_type = "ethernet-phy";
+				};
+			};
+
+			usb@11b60 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "fsl,mpc8280-usb",
+				             "fsl,cpm2-usb";
+				reg = <11b60 18 8b00 100>;
+				interrupt-parent = <&PIC>;
+				interrupts = <b 8>;
+				fsl,cpm-command = <2e600000>;
+			};
+		};
+
+		PIC: interrupt-controller@10c00 {
+			#interrupt-cells = <2>;
+			interrupt-controller;
+			reg = <10c00 80>;
+			compatible = "fsl,mpc8280-pic", "fsl,cpm2-pic";
+		};
+
+	};
+
+	chosen {
+		linux,stdout-path = "/soc/cpm/serial@11a00";
+	};
+};
diff --git a/arch/powerpc/configs/pq2fads_defconfig b/arch/powerpc/configs/pq2fads_defconfig
new file mode 100644
index 0000000..a51fc39
--- /dev/null
+++ b/arch/powerpc/configs/pq2fads_defconfig
@@ -0,0 +1,1003 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.23-rc4
+# Thu Aug 30 11:58:17 2007
+#
+# CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_6xx=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_PPC_FPU=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
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
+CONFIG_DEFAULT_UIMAGE=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+
+#
+# General setup
+#
+# CONFIG_EXPERIMENTAL is not set
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_SYSFS_DEPRECATED is not set
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_ANON_INODES=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_SLAB=y
+# CONFIG_SLUB is not set
+# CONFIG_SLOB is not set
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
+# CONFIG_MODULES is not set
+CONFIG_BLOCK=y
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
+
+#
+# Platform support
+#
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_EMBEDDED6xx is not set
+CONFIG_PPC_82xx=y
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
+# CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_CELL is not set
+# CONFIG_PPC_CELL_NATIVE is not set
+# CONFIG_MPC8272_ADS is not set
+CONFIG_PQ2FADS=y
+# CONFIG_EP8248E is not set
+CONFIG_PQ2ADS=y
+CONFIG_8260=y
+CONFIG_PQ2_ADS_PCI_PIC=y
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
+CONFIG_CPM2=y
+CONFIG_PPC_CPM_NEW_BINDING=y
+# CONFIG_FSL_ULI1575 is not set
+CONFIG_CPM=y
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_300 is not set
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
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
+CONFIG_SECCOMP=y
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE="pq2fads.dts"
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_FSL_SOC=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+CONFIG_PCI_8260=y
+# CONFIG_8260_PCI9 is not set
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+# CONFIG_PCI_DEBUG is not set
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
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_IP_VS is not set
+CONFIG_IPV6=y
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+CONFIG_IPV6_SIT=y
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_NETWORK_SECMARK is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# Core Netfilter Configuration
+#
+# CONFIG_NETFILTER_NETLINK is not set
+# CONFIG_NF_CONNTRACK_ENABLED is not set
+# CONFIG_NF_CONNTRACK is not set
+# CONFIG_NETFILTER_XTABLES is not set
+
+#
+# IP: Netfilter Configuration
+#
+# CONFIG_IP_NF_QUEUE is not set
+# CONFIG_IP_NF_IPTABLES is not set
+# CONFIG_IP_NF_ARPTABLES is not set
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
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+# CONFIG_WIRELESS_EXT is not set
+# CONFIG_IEEE80211 is not set
+# CONFIG_RFKILL is not set
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
+# CONFIG_MTD_CFI is not set
+CONFIG_MTD_JEDECPROBE=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set
+# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set
+CONFIG_MTD_CFI_GEOMETRY=y
+# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+# CONFIG_MTD_CFI_I1 is not set
+# CONFIG_MTD_CFI_I2 is not set
+CONFIG_MTD_CFI_I4=y
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
+CONFIG_MTD_CFI_INTELEXT=y
+# CONFIG_MTD_CFI_AMDSTD is not set
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
+# CONFIG_MTD_SBC8240 is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
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
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_PHANTOM is not set
+# CONFIG_EEPROM_93CX6 is not set
+# CONFIG_SGI_IOC4 is not set
+CONFIG_IDE=y
+CONFIG_IDE_MAX_HWIFS=4
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
+CONFIG_IDE_PROC_FS=y
+
+#
+# IDE chipset support/bugfixes
+#
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_IDEPCI is not set
+# CONFIG_IDEPCI_PCIBUS_ORDER is not set
+# CONFIG_IDE_ARM is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+# CONFIG_BLK_DEV_HD is not set
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
+# An alternative FireWire stack is available with EXPERIMENTAL=y
+#
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
+# CONFIG_MACINTOSH_DRIVERS is not set
+CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+CONFIG_TUN=y
+# CONFIG_ARCNET is not set
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
+CONFIG_MDIO_BITBANG=y
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_PCI is not set
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
+CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
+# CONFIG_QLA3XXX is not set
+CONFIG_NETDEV_10000=y
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TR is not set
+
+#
+# Wireless LAN
+#
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
+# CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+CONFIG_PPP=y
+# CONFIG_PPP_FILTER is not set
+CONFIG_PPP_ASYNC=y
+CONFIG_PPP_SYNC_TTY=y
+CONFIG_PPP_DEFLATE=y
+# CONFIG_PPP_BSDCOMP is not set
+# CONFIG_SLIP is not set
+CONFIG_SLHC=y
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
+# CONFIG_MOUSE_APPLETOUCH is not set
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
+# CONFIG_SERIO_I8042 is not set
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
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
+CONFIG_SERIAL_CPM_SCC1=y
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+CONFIG_SERIAL_CPM_SCC4=y
+# CONFIG_SERIAL_CPM_SMC1 is not set
+# CONFIG_SERIAL_CPM_SMC2 is not set
+# CONFIG_SERIAL_JSM is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_HW_RANDOM=y
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+CONFIG_DEVPORT=y
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
+CONFIG_VIDEO_OUTPUT_CONTROL=y
+# CONFIG_FB is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+CONFIG_USB_SUPPORT=y
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
+CONFIG_USB_GADGET=y
+# CONFIG_USB_GADGET_DEBUG_FILES is not set
+CONFIG_USB_GADGET_SELECTED=y
+# CONFIG_USB_GADGET_AMD5536UDC is not set
+# CONFIG_USB_GADGET_FSL_USB2 is not set
+# CONFIG_USB_GADGET_NET2280 is not set
+# CONFIG_USB_GADGET_PXA2XX is not set
+CONFIG_USB_GADGET_M66592=y
+CONFIG_USB_M66592=y
+# CONFIG_USB_GADGET_GOKU is not set
+# CONFIG_USB_GADGET_LH7A40X is not set
+# CONFIG_USB_GADGET_OMAP is not set
+# CONFIG_USB_GADGET_S3C2410 is not set
+# CONFIG_USB_GADGET_AT91 is not set
+# CONFIG_USB_GADGET_DUMMY_HCD is not set
+CONFIG_USB_GADGET_DUALSPEED=y
+# CONFIG_USB_ZERO is not set
+CONFIG_USB_ETH=y
+# CONFIG_USB_GADGETFS is not set
+# CONFIG_USB_FILE_STORAGE is not set
+# CONFIG_USB_G_SERIAL is not set
+# CONFIG_USB_MIDI_GADGET is not set
+# CONFIG_MMC is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_INFINIBAND is not set
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
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
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
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_HFSPLUS_FS is not set
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
+CONFIG_NFS_V3_ACL=y
+# CONFIG_NFS_DIRECTIO is not set
+# CONFIG_NFSD is not set
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_SMB_FS is not set
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
+# CONFIG_SYSV68_PARTITION is not set
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
+# CONFIG_UCC_SLOW is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_CRC_CCITT=y
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
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
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
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
+# CONFIG_KGDB_CONSOLE is not set
+CONFIG_BDI_SWITCH=y
+# CONFIG_PPC_EARLY_DEBUG is not set
+# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
+# CONFIG_PPC_EARLY_DEBUG_G5 is not set
+# CONFIG_PPC_EARLY_DEBUG_RTAS_PANEL is not set
+# CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
+# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
+# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+# CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
+# CONFIG_PPC_EARLY_DEBUG_BEAT is not set
+# CONFIG_PPC_EARLY_DEBUG_44x is not set
+# CONFIG_PPC_EARLY_DEBUG_CPM is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+CONFIG_CRYPTO_ECB=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=y
+# CONFIG_CRYPTO_CRYPTD is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
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
+# CONFIG_CRYPTO_CAMELLIA is not set
+CONFIG_CRYPTO_HW=y
diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 03f5aeb..541fbb8 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -15,6 +15,17 @@ config MPC8272_ADS
 	help
 	  This option enables support for the MPC8272 ADS board
 
+config PQ2FADS
+	bool "Freescale PQ2FADS"
+	select DEFAULT_UIMAGE
+	select PQ2ADS
+	select 8260
+	select FSL_SOC
+	select PQ2_ADS_PCI_PIC if PCI
+	select PPC_CPM_NEW_BINDING
+	help
+	  This option enables support for the PQ2FADS board
+
 endchoice
 
 config PQ2ADS
diff --git a/arch/powerpc/platforms/82xx/Makefile b/arch/powerpc/platforms/82xx/Makefile
index bfcb64c..68c8b0c 100644
--- a/arch/powerpc/platforms/82xx/Makefile
+++ b/arch/powerpc/platforms/82xx/Makefile
@@ -4,3 +4,4 @@
 obj-$(CONFIG_MPC8272_ADS) += mpc8272_ads.o
 obj-$(CONFIG_CPM2) += pq2.o
 obj-$(CONFIG_PQ2_ADS_PCI_PIC) += pq2ads-pci-pic.o
+obj-$(CONFIG_PQ2FADS) += pq2fads.o
diff --git a/arch/powerpc/platforms/82xx/pq2fads.c b/arch/powerpc/platforms/82xx/pq2fads.c
new file mode 100644
index 0000000..4f457a9
--- /dev/null
+++ b/arch/powerpc/platforms/82xx/pq2fads.c
@@ -0,0 +1,198 @@
+/*
+ * PQ2FADS board support
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.
+ * Author: Scott Wood <scottwood@freescale.com>
+ *
+ * Loosely based on mp82xx ADS support by Vitaly Bordug <vbordug@ru.mvista.com>
+ * Copyright (c) 2006 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/io.h>
+#include <asm/cpm2.h>
+#include <asm/udbg.h>
+#include <asm/machdep.h>
+#include <asm/of_platform.h>
+#include <asm/time.h>
+
+#include <sysdev/fsl_soc.h>
+#include <sysdev/cpm2_pic.h>
+
+#include "pq2ads.h"
+#include "pq2.h"
+
+static void __init pq2fads_pic_init(void)
+{
+	struct device_node *np = of_find_compatible_node(NULL, NULL, "fsl,cpm2-pic");
+	if (!np) {
+		printk(KERN_ERR "PIC init: can not find fsl,cpm2-pic node\n");
+		return;
+	}
+
+	cpm2_pic_init(np);
+	of_node_put(np);
+
+	/* Initialize stuff for the 82xx CPLD IC and install demux  */
+	pq2ads_pci_init_irq();
+}
+
+struct cpm_pin {
+	int port, pin, flags;
+};
+
+static struct cpm_pin pq2fads_pins[] = {
+	/* SCC1 */
+	{3, 30, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{3, 31, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* SCC2 */
+	{3, 27, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{3, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC2 */
+	{1, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 20, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 21, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 22, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 23, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 24, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 25, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 26, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 27, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 28, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 29, CPM_PIN_OUTPUT | CPM_PIN_SECONDARY},
+	{1, 30, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 31, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{2, 18, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 19, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+
+	/* FCC3 */
+	{1, 4, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 5, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 6, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 7, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 8, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 9, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 10, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 11, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 12, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 13, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 14, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 15, CPM_PIN_OUTPUT | CPM_PIN_PRIMARY},
+	{1, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{1, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 16, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+	{2, 17, CPM_PIN_INPUT | CPM_PIN_PRIMARY},
+};
+
+static void __init init_ioports(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(pq2fads_pins); i++) {
+		struct cpm_pin *pin = &pq2fads_pins[i];
+		cpm2_set_pin(pin->port, pin->pin, pin->flags);
+	}
+
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC1, CPM_BRG1, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_SCC2, CPM_BRG2, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK13, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC2, CPM_CLK14, CPM_CLK_TX);
+	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK15, CPM_CLK_RX);
+	cpm2_clk_setup(CPM_CLK_FCC3, CPM_CLK16, CPM_CLK_TX);
+}
+
+static void __init pq2fads_setup_arch(void)
+{
+	struct device_node *np;
+	__be32 __iomem *bcsr;
+
+	if (ppc_md.progress)
+		ppc_md.progress("pq2fads_setup_arch()", 0);
+
+	cpm2_reset();
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,pq2fads-bcsr");
+	if (!np) {
+		printk(KERN_ERR "No fsl,pq2fads-bcsr in device tree\n");
+		return;
+	}
+
+	bcsr = of_iomap(np, 0);
+	if (!bcsr) {
+		printk(KERN_ERR "Cannot map BCSR registers\n");
+		return;
+	}
+
+	of_node_put(np);
+
+	/* Enable the serial and ethernet ports */
+
+	clrbits32(&bcsr[1], BCSR1_RS232_EN1 | BCSR1_RS232_EN2 | BCSR1_FETHIEN);
+	setbits32(&bcsr[1], BCSR1_FETH_RST);
+
+	clrbits32(&bcsr[3], BCSR3_FETHIEN2);
+	setbits32(&bcsr[3], BCSR3_FETH2_RST);
+
+	iounmap(bcsr);
+
+	init_ioports();
+
+	/* Enable external IRQs */
+	clrbits32(&cpm2_immr->im_siu_conf.siu_82xx.sc_siumcr, 0x0c000000);
+
+	pq2_init_pci();
+
+	if (ppc_md.progress)
+		ppc_md.progress("pq2fads_setup_arch(), finish", 0);
+}
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init pq2fads_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+	return of_flat_dt_is_compatible(root, "fsl,pq2fads");
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
+	if (!machine_is(pq2fads))
+		return 0;
+
+	/* Publish the QE devices */
+	of_platform_bus_probe(NULL, of_bus_ids, NULL);
+	return 0;
+}
+device_initcall(declare_of_platform_devices);
+
+define_machine(pq2fads)
+{
+	.name = "Freescale PQ2FADS",
+	.probe = pq2fads_probe,
+	.setup_arch = pq2fads_setup_arch,
+	.init_IRQ = pq2fads_pic_init,
+	.get_irq = cpm2_get_irq,
+	.calibrate_decr = generic_calibrate_decr,
+	.restart = pq2_restart,
+	.progress = udbg_progress,
+};
-- 
1.5.3.1
