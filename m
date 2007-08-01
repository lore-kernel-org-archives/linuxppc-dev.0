Return-Path: <joe.hamman@embeddedspecialties.com>
Received: from mail.embeddedspecialties.com (mail.embeddedspecialties.com
	[74.94.113.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 95142DDDF4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Aug 2007 11:17:30 +1000 (EST)
Subject: [PATCH] Add support for Wind River SBC8641D board
From: Joe Hamman <joe.hamman@embeddedspecialties.com>
To: galak@kernel.crashing.org
Content-Type: text/plain
Date: Tue, 31 Jul 2007 19:36:08 -0500
Message-Id: <1185928568.21198.10.camel@server>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: joe.hamman@embeddedspecialties.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Add support for Wind River's SBC8641D reference board.

Signed-off by: Joe Hamman <joe.hamman@embeddedspecialties.com>

diff -purN -X dontdiff linux-2.6/arch/powerpc/boot/dts/sbc8641d.dts linux-2.6-esi/arch/powerpc/boot/dts/sbc8641d.dts
--- linux-2.6/arch/powerpc/boot/dts/sbc8641d.dts	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6-esi/arch/powerpc/boot/dts/sbc8641d.dts	2007-07-31 13:15:15.000000000 -0500
@@ -0,0 +1,160 @@
+/*
+ * SBC8641D Device Tree Source
+ *
+ * Copyright 2007 Embedded Specialties, Inc.
+ * Joe Hamman joe.hamman@embeddedspecialties.com
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "SBC8641D";
+	compatible = "mpc86xx";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		PowerPC,8641@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <8000>;		// L1, 32K
+			i-cache-size = <8000>;		// L1, 32K
+			timebase-frequency = <0>;	// 33 MHz, from uboot
+			bus-frequency = <0>;		// From uboot
+			clock-frequency = <0>;		// From uboot
+			32-bit;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <00000000 20000000>;	// 512M at 0x0
+	};
+
+	soc8641@f8000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 f8000000 00100000>;
+		reg = <f8000000 00100000>;	// CCSRBAR 1M
+		bus-frequency = <0>;
+
+		mdio@24520 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "mdio";
+			compatible = "gianfar";
+			reg = <24520 20>;
+			phy1f: ethernet-phy@1f {
+				reg = <1f>;
+				device_type = "ethernet-phy";
+			};
+			phy0: ethernet-phy@0 {
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			phy1: ethernet-phy@1 {
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			phy2: ethernet-phy@2 {
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		ethernet@24000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <24000 1000>;
+			mac-address = [ 00 E0 0C 00 73 00 ];
+			interrupts = <1d 2 1e 2 22 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1f>;
+		};
+
+		ethernet@25000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <25000 1000>;
+			mac-address = [ 00 E0 0C 00 73 01 ];
+			interrupts = <23 2 24 2 28 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy0>;
+		};
+		
+		ethernet@26000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <26000 1000>;
+			mac-address = [ 00 E0 0C 00 02 FD ];
+			interrupts = <1F 2 20 2 21 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy1>;
+		};
+
+		ethernet@27000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			device_type = "network";
+			model = "eTSEC";
+			compatible = "gianfar";
+			reg = <27000 1000>;
+			mac-address = [ 00 E0 0C 00 03 FD ];
+			interrupts = <25 2 26 2 27 2>;
+			interrupt-parent = <&mpic>;
+			phy-handle = <&phy2>;
+		};
+
+		serial@4500 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4500 100>;
+			clock-frequency = <0>;
+			interrupts = <2a 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		serial@4600 {
+			device_type = "serial";
+			compatible = "ns16550";
+			reg = <4600 100>;
+			clock-frequency = <0>;
+			interrupts = <1c 2>;
+			interrupt-parent = <&mpic>;
+		};
+
+		mpic: pic@40000 {
+			clock-frequency = <0>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <40000 40000>;
+			built-in;
+			compatible = "chrp,open-pic";
+			device_type = "open-pic";
+			big-endian;
+		};
+	};
+};
diff -purN -X dontdiff linux-2.6/arch/powerpc/configs/sbc8641d_defconfig linux-2.6-esi/arch/powerpc/configs/sbc8641d_defconfig
--- linux-2.6/arch/powerpc/configs/sbc8641d_defconfig	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6-esi/arch/powerpc/configs/sbc8641d_defconfig	2007-04-25 21:40:54.000000000 -0500
@@ -0,0 +1,924 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.21-rc7
+# Wed Apr 25 21:39:17 2007
+#
+# CONFIG_PPC64 is not set
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
+CONFIG_PPC=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
+CONFIG_PPC_OF=y
+CONFIG_PPC_UDBG_16550=y
+# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_AUDIT_ARCH=y
+CONFIG_GENERIC_BUG=y
+CONFIG_DEFAULT_UIMAGE=y
+
+#
+# Processor support
+#
+# CONFIG_CLASSIC32 is not set
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_85xx is not set
+CONFIG_PPC_86xx=y
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_6xx=y
+CONFIG_PPC_FPU=y
+# CONFIG_PPC_DCR_NATIVE is not set
+# CONFIG_PPC_DCR_MMIO is not set
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_SMP is not set
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
+# CONFIG_LOCALVERSION_AUTO is not set
+# CONFIG_SWAP is not set
+# CONFIG_SYSVIPC is not set
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
+# CONFIG_AUDIT is not set
+CONFIG_IKCONFIG=y
+CONFIG_IKCONFIG_PROC=y
+CONFIG_SYSFS_DEPRECATED=y
+# CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+# CONFIG_ELF_CORE is not set
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_RT_MUTEXES=y
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
+CONFIG_BLOCK=y
+# CONFIG_LBD is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_LSF is not set
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
+# CONFIG_WANT_EARLY_SERIAL is not set
+CONFIG_PPC_INDIRECT_PCI_BE=y
+CONFIG_MPIC=y
+
+#
+# Platform Support
+#
+# CONFIG_MPC8641_HPCN is not set
+CONFIG_SBC8641D=y
+CONFIG_MPC8641=y
+
+#
+# Kernel options
+#
+CONFIG_HIGHMEM=y
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
+CONFIG_PROC_DEVICETREE=y
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_GENERIC_ISA_DMA=y
+# CONFIG_MPIC_WEIRD is not set
+CONFIG_PPC_I8259=y
+CONFIG_PPC_INDIRECT_PCI=y
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
+CONFIG_XFRM_USER=y
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+# CONFIG_IP_MULTICAST is not set
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
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
+# CONFIG_TCP_MD5SIG is not set
+CONFIG_IPV6=y
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
+# CONFIG_INET6_XFRM_TUNNEL is not set
+# CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+CONFIG_IPV6_SIT=y
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
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
+CONFIG_FW_LOADER=y
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
+# CONFIG_PNPACPI is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=131072
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+
+#
+# Misc devices
+#
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
+# CONFIG_SCSI_NETLINK is not set
+
+#
+# Serial ATA (prod) and Parallel ATA (experimental) drivers
+#
+# CONFIG_ATA is not set
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
+# CONFIG_MAC_EMUMOUSEBTN is not set
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
+# PHY device support
+#
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_FIXED_PHY is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+
+#
+# Ethernet (1000 Mbit)
+#
+CONFIG_GIANFAR=y
+# CONFIG_GFAR_NAPI is not set
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
+# CONFIG_INPUT_FF_MEMLESS is not set
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
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_MANY_PORTS=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+CONFIG_SERIAL_8250_DETECT_IRQ=y
+CONFIG_SERIAL_8250_RSA=y
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_UARTLITE is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_OF_PLATFORM is not set
+CONFIG_UNIX98_PTYS=y
+# CONFIG_LEGACY_PTYS is not set
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
+# CONFIG_HW_RANDOM is not set
+# CONFIG_NVRAM is not set
+# CONFIG_GEN_RTC is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
+# I2C support
+#
+CONFIG_I2C=y
+# CONFIG_I2C_CHARDEV is not set
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_MPC8260 is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PCA_ISA is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+CONFIG_SENSORS_EEPROM=y
+# CONFIG_SENSORS_MAX6900 is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
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
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+# CONFIG_HWMON is not set
+# CONFIG_HWMON_VID is not set
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
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+# CONFIG_FB is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# HID Devices
+#
+# CONFIG_HID is not set
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
+# CONFIG_ASYNC_TX_DMA is not set
+
+#
+# DMA Devices
+#
+
+#
+# Auxiliary Display support
+#
+
+#
+# Virtualization
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
+# CONFIG_EXT4DEV_FS is not set
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
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
+CONFIG_PROC_KCORE=y
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
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+# CONFIG_NFS_DIRECTIO is not set
+CONFIG_NFSD=y
+# CONFIG_NFSD_V3 is not set
+CONFIG_NFSD_TCP=y
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
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
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+CONFIG_LDM_PARTITION=y
+# CONFIG_LDM_DEBUG is not set
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
+# CONFIG_NLS_CODEPAGE_437 is not set
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
+# CONFIG_NLS_ASCII is not set
+# CONFIG_NLS_ISO8859_1 is not set
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
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
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
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_BUGVERBOSE is not set
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
diff -purN -X dontdiff linux-2.6/arch/powerpc/platforms/86xx/Kconfig linux-2.6-esi/arch/powerpc/platforms/86xx/Kconfig
--- linux-2.6/arch/powerpc/platforms/86xx/Kconfig	2007-07-31 10:15:36.000000000 -0500
+++ linux-2.6-esi/arch/powerpc/platforms/86xx/Kconfig	2007-07-31 10:36:45.000000000 -0500
@@ -10,6 +10,12 @@ config MPC8641_HPCN
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
+config SBC8641D
+	bool "Wind River SBC8641D"
+	select DEFAULT_UIMAGE
+	help
+	  This option enables support for the SBC8641D board.
+
 endchoice
 
 config MPC8641
@@ -18,3 +24,4 @@ config MPC8641
 	select PPC_UDBG_16550
 	select MPIC
 	default y if MPC8641_HPCN
+	default y if SBC8641D
diff -purN -X dontdiff linux-2.6/arch/powerpc/platforms/86xx/Makefile linux-2.6-esi/arch/powerpc/platforms/86xx/Makefile
--- linux-2.6/arch/powerpc/platforms/86xx/Makefile	2007-07-31 10:15:36.000000000 -0500
+++ linux-2.6-esi/arch/powerpc/platforms/86xx/Makefile	2007-07-31 10:37:30.000000000 -0500
@@ -4,3 +4,4 @@
 
 obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
+obj-$(CONFIG_SBC8641D)		+= sbc8641d.o
diff -purN -X dontdiff linux-2.6/arch/powerpc/platforms/86xx/sbc8641d.c linux-2.6-esi/arch/powerpc/platforms/86xx/sbc8641d.c
--- linux-2.6/arch/powerpc/platforms/86xx/sbc8641d.c	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6-esi/arch/powerpc/platforms/86xx/sbc8641d.c	2007-07-31 15:55:59.000000000 -0500
@@ -0,0 +1,206 @@
+/*
+ * SBC8641D board specific routines
+ *
+ * Copyright 2007 Embedded Specialties, Inc.
+ * Joe Hamman <joe.hamman@embeddedspecialties.com>
+ *
+ * Recode: ZHANG WEI <wei.zhang@freescale.com>
+ * Initial author: Xianghua Xiao <x.xiao@freescale.com>
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/kdev_t.h>
+#include <linux/delay.h>
+#include <linux/seq_file.h>
+
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/pci-bridge.h>
+#include <asm/mpc86xx.h>
+#include <asm/prom.h>
+#include <mm/mmu_decl.h>
+#include <asm/udbg.h>
+#include <asm/i8259.h>
+#include <asm-generic/rtc.h>
+#include <asm/mpic.h>
+
+#include <sysdev/fsl_soc.h>
+
+#include "mpc86xx.h"
+#include "sbc8641d.h"
+
+#define DEBUG
+
+#ifdef DEBUG
+#define DBG(fmt...) do { printk(KERN_ERR fmt); } while(0)
+#else
+#define DBG(fmt...) do { } while(0)
+#endif
+
+/* unsigned long isa_io_base = 0;
+unsigned long isa_mem_base = 0;
+unsigned long pci_dram_offset = 0; */
+
+
+void __init
+sbc8641d_init_irq(void)
+{
+	struct mpic *mpic1;
+	struct device_node *np;
+	struct resource res;
+
+	/* Determine PIC address. */
+	np = of_find_node_by_type(NULL, "open-pic");
+	if (np == NULL)
+		return;
+	of_address_to_resource(np, 0, &res);
+
+	/* Alloc mpic structure and per isu has 16 INT entries. */
+	mpic1 = mpic_alloc(np, res.start,
+			MPIC_PRIMARY | MPIC_WANTS_RESET | MPIC_BIG_ENDIAN,
+			16, NR_IRQS - 4,
+			" MPIC     ");
+	BUG_ON(mpic1 == NULL);
+
+	mpic_assign_isu(mpic1, 0, res.start + 0x10000);
+
+	/* 48 Internal Interrupts */
+	mpic_assign_isu(mpic1, 1, res.start + 0x10200);
+	mpic_assign_isu(mpic1, 2, res.start + 0x10400);
+	mpic_assign_isu(mpic1, 3, res.start + 0x10600);
+
+	/* 16 External interrupts
+	 * Moving them from [0 - 15] to [64 - 79]
+	 */
+	mpic_assign_isu(mpic1, 4, res.start + 0x10000);
+
+	mpic_init(mpic1);
+
+}
+
+
+static void __init
+sbc8641d_setup_arch(void)
+{
+	struct device_node *np;
+
+	if (ppc_md.progress)
+		ppc_md.progress("sbc8641d_setup_arch()", 0);
+
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np != 0) {
+		const unsigned int *fp;
+
+		fp = get_property(np, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(np);
+	}
+
+	printk("SBC8641D board from Wind River Systems\n");
+
+#ifdef CONFIG_SMP
+	mpc86xx_smp_init();
+#endif
+}
+
+
+void
+sbc8641d_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	uint memsize = total_memory;
+	const char *model = "";
+	uint svid = mfspr(SPRN_SVR);
+
+	seq_printf(m, "Vendor\t\t: Wind River Systems\n");
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = get_property(root, "model", NULL);
+	seq_printf(m, "Machine\t\t: %s\n", model);
+	of_node_put(root);
+
+	seq_printf(m, "SVR\t\t: 0x%x\n", svid);
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+
+/*
+ * Called very early, device-tree isn't unflattened
+ */
+static int __init sbc8641d_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "mpc86xx"))
+		return 1;	/* Looks good */
+
+	return 0;
+}
+
+
+void
+sbc8641d_restart(char *cmd)
+{
+	void __iomem *rstcr;
+
+	rstcr = ioremap(get_immrbase() + MPC86XX_RSTCR_OFFSET, 0x100);
+
+	local_irq_disable();
+
+	/* Assert reset request to Reset Control Register */
+	out_be32(rstcr, 0x2);
+
+	/* not reached */
+}
+
+
+long __init
+sbc8641d_time_init(void)
+{
+	unsigned int temp;
+
+	/* Set the time base to zero */
+	mtspr(SPRN_TBWL, 0);
+	mtspr(SPRN_TBWU, 0);
+
+	temp = mfspr(SPRN_HID0);
+	temp |= HID0_TBEN;
+	mtspr(SPRN_HID0, temp);
+	asm volatile("isync");
+
+	return 0;
+}
+
+
+define_machine(sbc8641d) {
+	.name			= "SBC8641D",
+	.probe			= sbc8641d_probe,
+	.setup_arch		= sbc8641d_setup_arch,
+	.init_IRQ		= sbc8641d_init_irq,
+	.show_cpuinfo		= sbc8641d_show_cpuinfo,
+	.get_irq		= mpic_get_irq,
+	.restart		= sbc8641d_restart,
+	.time_init		= sbc8641d_time_init,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+
+#ifdef CONFIG_GEN_RTC
+	/* RTC interface, using functions in include/asm-generic/rtc.h */
+	.get_rtc_time		= get_rtc_time,
+	.set_rtc_time		= set_rtc_time,
+#endif
+};
diff -purN -X dontdiff linux-2.6/arch/powerpc/platforms/86xx/sbc8641d.h linux-2.6-esi/arch/powerpc/platforms/86xx/sbc8641d.h
--- linux-2.6/arch/powerpc/platforms/86xx/sbc8641d.h	1969-12-31 18:00:00.000000000 -0600
+++ linux-2.6-esi/arch/powerpc/platforms/86xx/sbc8641d.h	2007-07-31 15:57:01.000000000 -0500
@@ -0,0 +1,24 @@
+/*
+ * SBC8641D board definitions
+ *
+ * Copyright 2007 Embedded Specialties, Inc.
+ * Joe Hamman <joe.hamman@embeddedspecialties.com>
+ *
+ * Copyright 2006 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * Author: Xianghua Xiao <x.xiao@freescale.com>
+ */
+
+#ifndef __SBC8641D_H__
+#define __SBC8641D_H__
+
+#include <linux/init.h>
+
+#define MPC86XX_RSTCR_OFFSET	(0xe00b0)	/* Reset Control Register */
+
+#endif	/* __SBC8641D_H__ */
diff -purN -X dontdiff linux-2.6/drivers/net/gianfar.h linux-2.6-esi/drivers/net/gianfar.h
--- linux-2.6/drivers/net/gianfar.h	2007-07-31 10:15:39.000000000 -0500
+++ linux-2.6-esi/drivers/net/gianfar.h	2007-07-31 10:39:10.000000000 -0500
@@ -131,7 +131,7 @@ extern const char gfar_driver_version[];
 #define DEFAULT_RXCOUNT	16
 #define DEFAULT_RXTIME	4
 
-#define TBIPA_VALUE		0x1f
+#define TBIPA_VALUE		0x1e
 #define MIIMCFG_INIT_VALUE	0x00000007
 #define MIIMCFG_RESET           0x80000000
 #define MIIMIND_BUSY            0x00000001
