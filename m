Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A0D2267C54
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 03:28:57 +1100 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 5/6] [POWERPC] 8xx: Add mpc885ads support and common mpc8xx.
Date: Mon, 11 Dec 2006 19:28:51 +0300
Message-Id: <20061211162851.17227.40137.stgit@localhost.localdomain>
In-Reply-To: <20061211192347.47700906@localhost.localdomain>
References: <20061211192347.47700906@localhost.localdomain>
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


This adds the core 8xx stuff and specifically mpc885ads board-specific
bits to arch/powerpc. Respective Kconfig has been cleaned up from the stuff
not yet ported over to avoid confusion. Updated and cleaned version.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/boot/dts/mpc885ads.dts          |  185 ++++++
 arch/powerpc/configs/mpc885_ads_defconfig    |  827 ++++++++++++++++++++++++++
 arch/powerpc/platforms/8xx/Kconfig           |  276 ---------
 arch/powerpc/platforms/8xx/Makefile          |    5 
 arch/powerpc/platforms/8xx/m8xx_setup.c      |  303 ++++++++++
 arch/powerpc/platforms/8xx/mpc885ads.h       |   95 +++
 arch/powerpc/platforms/8xx/mpc885ads_setup.c |  377 ++++++++++++
 arch/powerpc/platforms/Makefile              |    1 
 8 files changed, 1803 insertions(+), 266 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc885ads.dts b/arch/powerpc/boot/dts/mpc885ads.dts
new file mode 100644
index 0000000..cf1a19f
--- /dev/null
+++ b/arch/powerpc/boot/dts/mpc885ads.dts
@@ -0,0 +1,185 @@
+/*
+ * MPC885 ADS Device Tree Source
+ *
+ * Copyright 2006 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+
+/ {
+	model = "MPC885ADS";
+	compatible = "mpc8xx";
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
+		PowerPC,885@0 {
+			device_type = "cpu";
+			reg = <0>;
+			d-cache-line-size = <20>;	// 32 bytes
+			i-cache-line-size = <20>;	// 32 bytes
+			d-cache-size = <2000>;		// L1, 8K
+			i-cache-size = <2000>;		// L1, 8K
+			timebase-frequency = <0>;
+			bus-frequency = <0>;
+			clock-frequency = <0>;
+			32-bit;
+			interrupts = <f 2>;	// decrementer interrupt
+			interrupt-parent = <ff000000>;
+			linux,phandle = <201>;
+			linux,boot-cpu;
+		};
+	};
+
+	memory {
+		device_type = "memory";
+		linux,phandle = <300>;
+		reg = <00000000 800000>;
+	};
+
+	soc885@ff000000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		#interrupt-cells = <2>;
+		device_type = "soc";
+		ranges = <0 ff000000 00100000>;
+		reg = <ff000000 00000200>;
+		bus-frequency = <0>;
+		mdio@e80 {
+			device_type = "mdio";
+			compatible = "fs_enet";
+			reg = <e80 8>;
+			linux,phandle = <e80>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ethernet-phy@0 {
+				linux,phandle = <e8000>;
+				reg = <0>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@1 {
+				linux,phandle = <e8001>;
+				reg = <1>;
+				device_type = "ethernet-phy";
+			};
+			ethernet-phy@2 {
+				linux,phandle = <e8002>;
+				reg = <2>;
+				device_type = "ethernet-phy";
+			};
+		};
+
+		fec@e00 {
+			device_type = "network";
+			compatible = "fs_enet";
+			model = "FEC";
+			device-id = <1>;
+			reg = <e00 188>;
+			mac-address = [ 00 00 0C 00 01 FD ];
+			interrupts = <3 1>;
+			interrupt-parent = <ff000000>;
+			phy-handle = <e8000>;
+		};
+
+		fec@1e00 {
+			device_type = "network";
+			compatible = "fs_enet";
+			model = "FEC";
+			device-id = <2>;
+			reg = <1e00 188>;
+			mac-address = [ 00 00 0C 00 02 FD ];
+			interrupts = <7 1>;
+			interrupt-parent = <ff000000>;
+			phy-handle = <e8001>;
+		};
+
+		pic@ff000000 {
+			linux,phandle = <ff000000>;
+			interrupt-controller;
+			#address-cells = <0>;
+			#interrupt-cells = <2>;
+			reg = <0 24>;
+			built-in;
+			device_type = "mpc8xx-pic";
+			compatible = "CPM";
+		};
+
+		cpm@ff000000 {
+			linux,phandle = <ff000000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			#interrupt-cells = <2>;
+			device_type = "cpm";
+			model = "CPM";
+			ranges = <0 0 4000>;
+			reg = <860 f0>;
+			command-proc = <9c0>;
+			brg-frequency = <0>;
+			interrupts = <0 2>;	// cpm error interrupt
+			interrupt-parent = <930>;
+
+			pic@930 {
+				linux,phandle = <930>;
+				interrupt-controller;
+				#address-cells = <0>;
+				#interrupt-cells = <2>;
+				interrupts = <5 2 0 2>;
+				interrupt-parent = <ff000000>;
+				reg = <930 20>;
+				built-in;
+				device_type = "cpm-pic";
+				compatible = "CPM";
+			};
+
+			smc@a80 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SMC";
+				device-id = <1>;
+				reg = <a80 10 3e80 40>;
+				clock-setup = <00ffffff 0>;
+				rx-clock = <1>;
+				tx-clock = <1>;
+				current-speed = <0>;
+				interrupts = <4 3>;
+				interrupt-parent = <930>;
+			};
+
+			smc@a90 {
+				device_type = "serial";
+				compatible = "cpm_uart";
+				model = "SMC";
+				device-id = <2>;
+				reg = <a90 20 3f80 40>;
+				clock-setup = <ff00ffff 90000>;
+				rx-clock = <2>;
+				tx-clock = <2>;
+				current-speed = <0>;
+				interrupts = <3 3>;
+				interrupt-parent = <930>;
+			};
+
+			scc@a40 {
+				device_type = "network";
+				compatible = "fs_enet";
+				model = "SCC";
+				device-id = <3>;
+				reg = <a40 18 3e00 80>;
+				mac-address = [ 00 00 0C 00 03 FD ];
+				interrupts = <1c 3>;
+				interrupt-parent = <930>;
+				phy-handle = <e8002>;
+			};
+		};
+	};
+};
diff --git a/arch/powerpc/configs/mpc885_ads_defconfig b/arch/powerpc/configs/mpc885_ads_defconfig
new file mode 100644
index 0000000..e2c17d8
--- /dev/null
+++ b/arch/powerpc/configs/mpc885_ads_defconfig
@@ -0,0 +1,827 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.19-rc4
+# Fri Nov 10 21:30:40 2006
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
+CONFIG_AUDIT_ARCH=y
+# CONFIG_DEFAULT_UIMAGE is not set
+
+#
+# Processor support
+#
+# CONFIG_CLASSIC32 is not set
+# CONFIG_PPC_52xx is not set
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_86xx is not set
+CONFIG_PPC_8xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+CONFIG_8xx=y
+CONFIG_NOT_COHERENT_CACHE=y
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
+# CONFIG_SWAP is not set
+CONFIG_SYSVIPC=y
+# CONFIG_IPC_NS is not set
+# CONFIG_POSIX_MQUEUE is not set
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_UTS_NS is not set
+# CONFIG_AUDIT is not set
+# CONFIG_IKCONFIG is not set
+# CONFIG_RELAY is not set
+CONFIG_INITRAMFS_SOURCE=""
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+# CONFIG_HOTPLUG is not set
+CONFIG_PRINTK=y
+# CONFIG_BUG is not set
+CONFIG_ELF_CORE=y
+# CONFIG_BASE_FULL is not set
+CONFIG_FUTEX=y
+# CONFIG_EPOLL is not set
+CONFIG_SHMEM=y
+CONFIG_SLAB=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+CONFIG_RT_MUTEXES=y
+# CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=1
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
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
+# CONFIG_WANT_EARLY_SERIAL is not set
+CONFIG_EMBEDDEDBOOT=y
+# CONFIG_MPIC is not set
+
+#
+# Platform support
+#
+CONFIG_CPM1=y
+# CONFIG_MPC8XXFADS is not set
+# CONFIG_MPC86XADS is not set
+CONFIG_MPC885ADS=y
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
+CONFIG_NO_UCODE_PATCH=y
+# CONFIG_USB_SOF_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_UCODE_PATCH is not set
+# CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set
+
+#
+# Kernel options
+#
+# CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+# CONFIG_HZ_250 is not set
+CONFIG_HZ_1000=y
+CONFIG_HZ=1000
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_BINFMT_ELF=y
+# CONFIG_BINFMT_MISC is not set
+CONFIG_MATH_EMULATION=y
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
+# CONFIG_PROC_DEVICETREE is not set
+# CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SECCOMP is not set
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
+CONFIG_FSL_SOC=y
+# CONFIG_PCI is not set
+# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_QSPAN is not set
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
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
+# CONFIG_NETDEBUG is not set
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
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
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
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
+# Misc devices
+#
+# CONFIG_TIFM_CORE is not set
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
+CONFIG_DAVICOM_PHY=y
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+# CONFIG_SMSC_PHY is not set
+CONFIG_FIXED_PHY=y
+CONFIG_FIXED_MII_10_FDX=y
+# CONFIG_FIXED_MII_100_FDX is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_FEC_8XX is not set
+CONFIG_FS_ENET=y
+CONFIG_FS_ENET_HAS_SCC=y
+CONFIG_FS_ENET_HAS_FEC=y
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
+CONFIG_INPUT_MOUSEDEV=y
+CONFIG_INPUT_MOUSEDEV_PSAUX=y
+CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
+CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
+# CONFIG_INPUT_JOYDEV is not set
+# CONFIG_INPUT_TSDEV is not set
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
+
+#
+# Ftape, the floppy tape device driver
+#
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
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
+#
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_ABITUGURU is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
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
+
+#
+# DMA Devices
+#
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+# CONFIG_EXT2_FS_POSIX_ACL is not set
+# CONFIG_EXT2_FS_SECURITY is not set
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
+CONFIG_CRC_CCITT=y
+# CONFIG_CRC16 is not set
+CONFIG_CRC32=y
+# CONFIG_LIBCRC32C is not set
+CONFIG_ZLIB_INFLATE=y
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
+CONFIG_ENABLE_MUST_CHECK=y
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_DEBUG_FS is not set
+# CONFIG_UNWIND_INFO is not set
+# CONFIG_HEADERS_CHECK is not set
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
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index c8c0ba3..91a11d9 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -1,217 +1,34 @@
+menu "Platform support"
+        depends on PPC_8xx
+
 config FADS
 	bool
 
+config CPM1
+	bool
+
 choice
 	prompt "8xx Machine Type"
 	depends on 8xx
-	default RPXLITE
-
-config RPXLITE
-	bool "RPX-Lite"
-	---help---
-	  Single-board computers based around the PowerPC MPC8xx chips and
-	  intended for embedded applications.  The following types are
-	  supported:
-
-	  RPX-Lite:
-	  Embedded Planet RPX Lite. PC104 form-factor SBC based on the MPC823.
-
-	  RPX-Classic:
-	  Embedded Planet RPX Classic Low-fat. Credit-card-size SBC based on
-	  the MPC 860
-
-	  BSE-IP:
-	  Bright Star Engineering ip-Engine.
-
-	  TQM823L:
-	  TQM850L:
-	  TQM855L:
-	  TQM860L:
-	  MPC8xx based family of mini modules, half credit card size,
-	  up to 64 MB of RAM, 8 MB Flash, (Fast) Ethernet, 2 x serial ports,
-	  2 x CAN bus interface, ...
-	  Manufacturer: TQ Components, www.tq-group.de
-	  Date of Release: October (?) 1999
-	  End of Life: not yet :-)
-	  URL:
-	  - module: <http://www.denx.de/PDF/TQM8xxLHWM201.pdf>
-	  - starter kit: <http://www.denx.de/PDF/STK8xxLHWM201.pdf>
-	  - images: <http://www.denx.de/embedded-ppc-en.html>
-
-	  FPS850L:
-	  FingerPrint Sensor System (based on TQM850L)
-	  Manufacturer: IKENDI AG, <http://www.ikendi.com/>
-	  Date of Release: November 1999
-	  End of life: end 2000 ?
-	  URL: see TQM850L
-
-	  IVMS8:
-	  MPC860 based board used in the "Integrated Voice Mail System",
-	  Small Version (8 voice channels)
-	  Manufacturer: Speech Design, <http://www.speech-design.de/>
-	  Date of Release: December 2000 (?)
-	  End of life: -
-	  URL: <http://www.speech-design.de/>
-
-	  IVML24:
-	  MPC860 based board used in the "Integrated Voice Mail System",
-	  Large Version (24 voice channels)
-	  Manufacturer: Speech Design, <http://www.speech-design.de/>
-	  Date of Release: March 2001  (?)
-	  End of life: -
-	  URL: <http://www.speech-design.de/>
-
-	  HERMES:
-	  Hermes-Pro ISDN/LAN router with integrated 8 x hub
-	  Manufacturer: Multidata Gesellschaft fur Datentechnik und Informatik
-	  <http://www.multidata.de/>
-	  Date of Release: 2000 (?)
-	  End of life: -
-	  URL: <http://www.multidata.de/english/products/hpro.htm>
-
-	  IP860:
-	  VMEBus IP (Industry Pack) carrier board with MPC860
-	  Manufacturer: MicroSys GmbH, <http://www.microsys.de/>
-	  Date of Release: ?
-	  End of life: -
-	  URL: <http://www.microsys.de/html/ip860.html>
-
-	  PCU_E:
-	  PCU = Peripheral Controller Unit, Extended
-	  Manufacturer: Siemens AG, ICN (Information and Communication Networks)
-	  	<http://www.siemens.de/page/1,3771,224315-1-999_2_226207-0,00.html>
-	  Date of Release: April 2001
-	  End of life: August 2001
-	  URL: n. a.
-
-config RPXCLASSIC
-	bool "RPX-Classic"
-	help
-	  The RPX-Classic is a single-board computer based on the Motorola
-	  MPC860.  It features 16MB of DRAM and a variable amount of flash,
-	  I2C EEPROM, thermal monitoring, a PCMCIA slot, a DIP switch and two
-	  LEDs.  Variants with Ethernet ports exist.  Say Y here to support it
-	  directly.
-
-config BSEIP
-	bool "BSE-IP"
-	help
-	  Say Y here to support the Bright Star Engineering ipEngine SBC.
-	  This is a credit-card-sized device featuring a MPC823 processor,
-	  26MB DRAM, 4MB flash, Ethernet, a 16K-gate FPGA, USB, an LCD/video
-	  controller, and two RS232 ports.
+	default MPC885ADS
 
 config MPC8XXFADS
 	bool "FADS"
 	select FADS
 
-config MPC86XADS
-	bool "MPC86XADS"
-	help
-	  MPC86x Application Development System by Freescale Semiconductor.
-	  The MPC86xADS is meant to serve as a platform for s/w and h/w
-	  development around the MPC86X processor families.
-	select FADS
-
 config MPC885ADS
 	bool "MPC885ADS"
+	select CPM1
 	help
 	  Freescale Semiconductor MPC885 Application Development System (ADS).
 	  Also known as DUET.
 	  The MPC885ADS is meant to serve as a platform for s/w and h/w
 	  development around the MPC885 processor family.
 
-config TQM823L
-	bool "TQM823L"
-	help
-	  Say Y here to support the TQM823L, one of an MPC8xx-based family of
-	  mini SBCs (half credit-card size) from TQ Components first released
-	  in late 1999.  Technical references are at
-	  <http://www.denx.de/PDF/TQM8xxLHWM201.pdf>, and
-	  <http://www.denx.de/PDF/STK8xxLHWM201.pdf>, and an image at
-	  <http://www.denx.de/embedded-ppc-en.html>.
-
-config TQM850L
-	bool "TQM850L"
-	help
-	  Say Y here to support the TQM850L, one of an MPC8xx-based family of
-	  mini SBCs (half credit-card size) from TQ Components first released
-	  in late 1999.  Technical references are at
-	  <http://www.denx.de/PDF/TQM8xxLHWM201.pdf>, and
-	  <http://www.denx.de/PDF/STK8xxLHWM201.pdf>, and an image at
-	  <http://www.denx.de/embedded-ppc-en.html>.
-
-config TQM855L
-	bool "TQM855L"
-	help
-	  Say Y here to support the TQM855L, one of an MPC8xx-based family of
-	  mini SBCs (half credit-card size) from TQ Components first released
-	  in late 1999.  Technical references are at
-	  <http://www.denx.de/PDF/TQM8xxLHWM201.pdf>, and
-	  <http://www.denx.de/PDF/STK8xxLHWM201.pdf>, and an image at
-	  <http://www.denx.de/embedded-ppc-en.html>.
-
-config TQM860L
-	bool "TQM860L"
-	help
-	  Say Y here to support the TQM860L, one of an MPC8xx-based family of
-	  mini SBCs (half credit-card size) from TQ Components first released
-	  in late 1999.  Technical references are at
-	  <http://www.denx.de/PDF/TQM8xxLHWM201.pdf>, and
-	  <http://www.denx.de/PDF/STK8xxLHWM201.pdf>, and an image at
-	  <http://www.denx.de/embedded-ppc-en.html>.
-
-config FPS850L
-	bool "FPS850L"
-
-config IVMS8
-	bool "IVMS8"
-	help
-	  Say Y here to support the Integrated Voice-Mail Small 8-channel SBC
-	  from Speech Design, released March 2001.  The manufacturer's website
-	  is at <http://www.speech-design.de/>.
-
-config IVML24
-	bool "IVML24"
-	help
-	  Say Y here to support the Integrated Voice-Mail Large 24-channel SBC
-	  from Speech Design, released March 2001.  The manufacturer's website
-	  is at <http://www.speech-design.de/>.
-
-config HERMES_PRO
-	bool "HERMES"
-
-config IP860
-	bool "IP860"
-
-config LWMON
-	bool "LWMON"
-
-config PCU_E
-	bool "PCU_E"
-
-config CCM
-	bool "CCM"
-
-config LANTEC
-	bool "LANTEC"
-
-config MBX
-	bool "MBX"
-	help
-	  MBX is a line of Motorola single-board computer based around the
-	  MPC821 and MPC860 processors, and intended for embedded-controller
-	  applications.  Say Y here to support these boards directly.
-
-config WINCEPT
-	bool "WinCept"
-	help
-	  The Wincept 100/110 is a Motorola single-board computer based on the
-	  MPC821 PowerPC, introduced in 1998 and designed to be used in
-	  thin-client machines.  Say Y to support it directly.
-
 endchoice
 
+endmenu
+
 #
 # MPC8xx Communication options
 #
@@ -219,79 +36,6 @@ #
 menu "MPC8xx CPM Options"
 	depends on 8xx
 
-config SCC_ENET
-	bool "CPM SCC Ethernet"
-	depends on NET_ETHERNET
-	help
-	  Enable Ethernet support via the Motorola MPC8xx serial
-	  communications controller.
-
-choice
-	prompt "SCC used for Ethernet"
-	depends on SCC_ENET
-	default SCC1_ENET
-
-config SCC1_ENET
-	bool "SCC1"
-	help
-	  Use MPC8xx serial communications controller 1 to drive Ethernet
-	  (default).
-
-config SCC2_ENET
-	bool "SCC2"
-	help
-	  Use MPC8xx serial communications controller 2 to drive Ethernet.
-
-config SCC3_ENET
-	bool "SCC3"
-	help
-	  Use MPC8xx serial communications controller 3 to drive Ethernet.
-
-endchoice
-
-config FEC_ENET
-	bool "860T FEC Ethernet"
-	depends on NET_ETHERNET
-	help
-	  Enable Ethernet support via the Fast Ethernet Controller (FCC) on
-	  the Motorola MPC8260.
-
-config USE_MDIO
-	bool "Use MDIO for PHY configuration"
-	depends on FEC_ENET
-	help
-	  On some boards the hardware configuration of the ethernet PHY can be
-	  used without any software interaction over the MDIO interface, so
-	  all MII code can be omitted. Say N here if unsure or if you don't
-	  need link status reports.
-
-config  FEC_AM79C874
-	bool "Support AMD79C874 PHY"
-	depends on USE_MDIO
-
-config FEC_LXT970
-	bool "Support LXT970 PHY"
-	depends on USE_MDIO
-
-config FEC_LXT971
-	bool "Support LXT971 PHY"
-	depends on USE_MDIO
-	
-config FEC_QS6612
-	bool "Support QS6612 PHY"
-	depends on USE_MDIO
-	
-config ENET_BIG_BUFFERS
-	bool "Use Big CPM Ethernet Buffers"
-	depends on SCC_ENET || FEC_ENET
-	help
-	  Allocate large buffers for MPC8xx Ethernet. Increases throughput
-	  and decreases the likelihood of dropped packets, but costs memory.
-
-config HTDMSOUND
-	bool "Embedded Planet HIOX Audio"
-	depends on SOUND=y
-
 # This doesn't really belong here, but it is convenient to ask
 # 8xx specific questions.
 comment "Generic MPC8xx Options"
diff --git a/arch/powerpc/platforms/8xx/Makefile b/arch/powerpc/platforms/8xx/Makefile
new file mode 100644
index 0000000..1b59ffa
--- /dev/null
+++ b/arch/powerpc/platforms/8xx/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the PowerPC 8xx linux kernel.
+#
+obj-$(CONFIG_PPC_8xx)	  += m8xx_setup.o
+obj-$(CONFIG_MPC885ADS)   += mpc885ads_setup.o
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
new file mode 100644
index 0000000..9ed7125
--- /dev/null
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -0,0 +1,303 @@
+/*
+ *  Copyright (C) 1995  Linus Torvalds
+ *  Adapted from 'alpha' version by Gary Thomas
+ *  Modified by Cort Dougan (cort@cs.nmt.edu)
+ *  Modified for MBX using prep/chrp/pmac functions by Dan (dmalek@jlc.net)
+ *  Further modified for generic 8xx by Dan.
+ */
+
+/*
+ * bootup setup stuff..
+ */
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/a.out.h>
+#include <linux/tty.h>
+#include <linux/major.h>
+#include <linux/interrupt.h>
+#include <linux/reboot.h>
+#include <linux/init.h>
+#include <linux/initrd.h>
+#include <linux/ioport.h>
+#include <linux/bootmem.h>
+#include <linux/seq_file.h>
+#include <linux/root_dev.h>
+#include <linux/time.h>
+#include <linux/rtc.h>
+
+#include <asm/mmu.h>
+#include <asm/reg.h>
+#include <asm/residual.h>
+#include <asm/io.h>
+#include <asm/pgtable.h>
+#include <asm/mpc8xx.h>
+#include <asm/8xx_immap.h>
+#include <asm/machdep.h>
+#include <asm/bootinfo.h>
+#include <asm/time.h>
+#include <asm/prom.h>
+#include <asm/fs_pd.h>
+#include <mm/mmu_decl.h>
+
+#include "sysdev/mpc8xx_pic.h"
+
+void m8xx_calibrate_decr(void);
+extern void m8xx_wdt_handler_install(bd_t *bp);
+extern int cpm_pic_init(void);
+extern int cpm_get_irq(void);
+
+/* A place holder for time base interrupts, if they are ever enabled. */
+irqreturn_t timebase_interrupt(int irq, void * dev)
+{
+	printk ("timebase_interrupt()\n");
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction tbint_irqaction = {
+	.handler = timebase_interrupt,
+	.mask = CPU_MASK_NONE,
+	.name = "tbint",
+};
+
+/* per-board overridable init_internal_rtc() function. */
+void __init __attribute__ ((weak))
+init_internal_rtc(void)
+{
+	sit8xx_t *sys_tmr = (sit8xx_t *) immr_map(im_sit);
+
+	/* Disable the RTC one second and alarm interrupts. */
+	clrbits16(&sys_tmr->sit_rtcsc, (RTCSC_SIE | RTCSC_ALE));
+
+	/* Enable the RTC */
+	setbits16(&sys_tmr->sit_rtcsc, (RTCSC_RTF | RTCSC_RTE));
+	immr_unmap(sys_tmr);
+}
+
+static int __init get_freq(char *name, unsigned long *val)
+{
+        struct device_node *cpu;
+        unsigned int *fp;
+        int found = 0;
+
+        /* The cpu node should have timebase and clock frequency properties */
+        cpu = of_find_node_by_type(NULL, "cpu");
+
+        if (cpu) {
+                fp = (unsigned int *)get_property(cpu, name, NULL);
+                if (fp) {
+                        found = 1;
+                        *val = *fp++;
+                }
+
+                of_node_put(cpu);
+        }
+
+        return found;
+}
+
+/* The decrementer counts at the system (internal) clock frequency divided by
+ * sixteen, or external oscillator divided by four.  We force the processor
+ * to use system clock divided by sixteen.
+ */
+void __init mpc8xx_calibrate_decr(void)
+{
+	struct device_node *cpu;
+	cark8xx_t *clk_r1;
+	car8xx_t *clk_r2;
+	sitk8xx_t *sys_tmr1;
+	sit8xx_t *sys_tmr2;
+	int irq, virq;
+
+        clk_r1 = (cark8xx_t *) immr_map(im_clkrstk);
+
+	/* Unlock the SCCR. */
+	out_be32(&clk_r1->cark_sccrk, ~KAPWR_KEY);
+	out_be32(&clk_r1->cark_sccrk, KAPWR_KEY);
+	immr_unmap(clk_r1);
+
+	/* Force all 8xx processors to use divide by 16 processor clock. */
+        clk_r2 = (car8xx_t *) immr_map(im_clkrst);
+	setbits32(&clk_r2->car_sccr, 0x02000000);
+	immr_unmap(clk_r2);
+
+	/* Processor frequency is MHz.
+	 */
+        ppc_tb_freq = 50000000;
+        if (!get_freq("bus-frequency", &ppc_tb_freq)) {
+                printk(KERN_ERR "WARNING: Estimating decrementer frequency "
+                                "(not found)\n");
+        }
+        ppc_tb_freq /= 16;
+        ppc_proc_freq = 50000000;
+        if (!get_freq("clock-frequency", &ppc_proc_freq))
+                printk(KERN_ERR "WARNING: Estimating processor frequency"
+                                "(not found)\n");
+
+        printk("Decrementer Frequency = 0x%lx\n", ppc_tb_freq);
+
+	/* Perform some more timer/timebase initialization.  This used
+	 * to be done elsewhere, but other changes caused it to get
+	 * called more than once....that is a bad thing.
+	 *
+	 * First, unlock all of the registers we are going to modify.
+	 * To protect them from corruption during power down, registers
+	 * that are maintained by keep alive power are "locked".  To
+	 * modify these registers we have to write the key value to
+	 * the key location associated with the register.
+	 * Some boards power up with these unlocked, while others
+	 * are locked.  Writing anything (including the unlock code?)
+	 * to the unlocked registers will lock them again.  So, here
+	 * we guarantee the registers are locked, then we unlock them
+	 * for our use.
+	 */
+        sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
+	out_be32(&sys_tmr1->sitk_tbscrk, ~KAPWR_KEY);
+	out_be32(&sys_tmr1->sitk_rtcsck, ~KAPWR_KEY);
+	out_be32(&sys_tmr1->sitk_tbk, ~KAPWR_KEY);
+	out_be32(&sys_tmr1->sitk_tbscrk, KAPWR_KEY);
+	out_be32(&sys_tmr1->sitk_rtcsck, KAPWR_KEY);
+	out_be32(&sys_tmr1->sitk_tbk, KAPWR_KEY);
+	immr_unmap(sys_tmr1);
+
+	init_internal_rtc();
+
+	/* Enabling the decrementer also enables the timebase interrupts
+	 * (or from the other point of view, to get decrementer interrupts
+	 * we have to enable the timebase).  The decrementer interrupt
+	 * is wired into the vector table, nothing to do here for that.
+	 */
+        cpu = of_find_node_by_type(NULL, "cpu");
+        virq= irq_of_parse_and_map(cpu, 0);
+	irq = irq_map[virq].hwirq;
+
+	sys_tmr2 = (sit8xx_t *) immr_map(im_sit);
+	out_be16(&sys_tmr2->sit_tbscr, ((1 << (7 - (irq/2))) << 8) |
+					(TBSCR_TBF | TBSCR_TBE));
+	immr_unmap(sys_tmr2);
+
+	if (setup_irq(virq, &tbint_irqaction))
+		panic("Could not allocate timer IRQ!");
+
+#ifdef CONFIG_8xx_WDT
+	/* Install watchdog timer handler early because it might be
+	 * already enabled by the bootloader
+	 */
+	m8xx_wdt_handler_install(binfo);
+#endif
+}
+
+/* The RTC on the MPC8xx is an internal register.
+ * We want to protect this during power down, so we need to unlock,
+ * modify, and re-lock.
+ */
+
+int mpc8xx_set_rtc_time(struct rtc_time *tm)
+{
+	sitk8xx_t *sys_tmr1;
+	sit8xx_t *sys_tmr2;
+	int time;
+
+        sys_tmr1 = (sitk8xx_t *) immr_map(im_sitk);
+	sys_tmr2 = (sit8xx_t *) immr_map(im_sit);
+	time = mktime(tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
+                      tm->tm_hour, tm->tm_min, tm->tm_sec);
+
+	out_be32(&sys_tmr1->sitk_rtck, KAPWR_KEY);
+	out_be32(&sys_tmr2->sit_rtc, time);
+	out_be32(&sys_tmr1->sitk_rtck, ~KAPWR_KEY);
+
+	immr_unmap(sys_tmr2);
+	immr_unmap(sys_tmr1);
+	return 0;
+}
+
+void mpc8xx_get_rtc_time(struct rtc_time *tm)
+{
+	unsigned long data;
+	sit8xx_t *sys_tmr = (sit8xx_t *) immr_map(im_sit);
+
+	/* Get time from the RTC. */
+	data = in_be32(&sys_tmr->sit_rtc);
+	to_tm(data, tm);
+        tm->tm_year -= 1900;
+        tm->tm_mon -= 1;
+	immr_unmap(sys_tmr);
+	return;
+}
+
+void mpc8xx_restart(char *cmd)
+{
+	__volatile__ unsigned char dummy;
+	car8xx_t * clk_r = (car8xx_t *) immr_map(im_clkrst);
+
+
+	local_irq_disable();
+
+	setbits32(&clk_r->car_plprcr, 0x00000080);
+	/* Clear the ME bit in MSR to cause checkstop on machine check
+	*/
+	mtmsr(mfmsr() & ~0x1000);
+
+	dummy = in_8(&clk_r->res[0]);
+	printk("Restart failed\n");
+	while(1);
+}
+
+void mpc8xx_show_cpuinfo(struct seq_file *m)
+{
+	struct device_node *root;
+	uint memsize = total_memory;
+	const char *model = "";
+
+	seq_printf(m, "Vendor\t\t: Freescale Semiconductor\n");
+
+	root = of_find_node_by_path("/");
+	if (root)
+		model = get_property(root, "model", NULL);
+	seq_printf(m, "Machine\t\t: %s\n", model);
+	of_node_put(root);
+
+	seq_printf(m, "Memory\t\t: %d MB\n", memsize / (1024 * 1024));
+}
+
+static void cpm_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	int cascade_irq;
+
+	if ((cascade_irq = cpm_get_irq()) >= 0) {
+		struct irq_desc *cdesc = irq_desc + cascade_irq;
+
+		generic_handle_irq(cascade_irq);
+		cdesc->chip->eoi(cascade_irq);
+	}
+	desc->chip->eoi(irq);
+}
+
+/* Initialize the internal interrupt controller.  The number of
+ * interrupts supported can vary with the processor type, and the
+ * 82xx family can have up to 64.
+ * External interrupts can be either edge or level triggered, and
+ * need to be initialized by the appropriate driver.
+ */
+void __init m8xx_pic_init(void)
+{
+	int irq;
+
+	if (mpc8xx_pic_init()) {
+                printk(KERN_ERR "Failed interrupt 8xx controller  initialization\n");
+		return;
+	}
+
+	irq = cpm_pic_init();
+	if (irq != NO_IRQ)
+		set_irq_chained_handler(irq, cpm_cascade);
+}
diff --git a/arch/powerpc/platforms/8xx/mpc885ads.h b/arch/powerpc/platforms/8xx/mpc885ads.h
new file mode 100644
index 0000000..30cbebf
--- /dev/null
+++ b/arch/powerpc/platforms/8xx/mpc885ads.h
@@ -0,0 +1,95 @@
+/*
+ * A collection of structures, addresses, and values associated with
+ * the Freescale MPC885ADS board.
+ * Copied from the FADS stuff.
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2005 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#ifdef __KERNEL__
+#ifndef __ASM_MPC885ADS_H__
+#define __ASM_MPC885ADS_H__
+
+#include <asm/ppcboot.h>
+#include <sysdev/fsl_soc.h>
+
+/* U-Boot maps BCSR to 0xff080000 */
+#define BCSR_ADDR		((uint)0xff080000)
+#define BCSR_SIZE		((uint)32)
+#define BCSR0			((uint)(BCSR_ADDR + 0x00))
+#define BCSR1			((uint)(BCSR_ADDR + 0x04))
+#define BCSR2			((uint)(BCSR_ADDR + 0x08))
+#define BCSR3			((uint)(BCSR_ADDR + 0x0c))
+#define BCSR4			((uint)(BCSR_ADDR + 0x10))
+
+#define CFG_PHYDEV_ADDR		((uint)0xff0a0000)
+#define BCSR5			((uint)(CFG_PHYDEV_ADDR + 0x300))
+
+#define IMAP_ADDR		(get_immrbase())
+#define IMAP_SIZE		((uint)(64 * 1024))
+
+#define MPC8xx_CPM_OFFSET	(0x9c0)
+#define CPM_MAP_ADDR		(get_immrbase() + MPC8xx_CPM_OFFSET)
+#define CPM_IRQ_OFFSET		16     // for compability with cpm_uart driver
+
+#define PCMCIA_MEM_ADDR		(uint)0xff020000)
+#define PCMCIA_MEM_SIZE		((uint)(64 * 1024))
+
+/* Bits of interest in the BCSRs.
+ */
+#define BCSR1_ETHEN		((uint)0x20000000)
+#define BCSR1_IRDAEN		((uint)0x10000000)
+#define BCSR1_RS232EN_1		((uint)0x01000000)
+#define BCSR1_PCCEN		((uint)0x00800000)
+#define BCSR1_PCCVCC0		((uint)0x00400000)
+#define BCSR1_PCCVPP0		((uint)0x00200000)
+#define BCSR1_PCCVPP1		((uint)0x00100000)
+#define BCSR1_PCCVPP_MASK	(BCSR1_PCCVPP0 | BCSR1_PCCVPP1)
+#define BCSR1_RS232EN_2		((uint)0x00040000)
+#define BCSR1_PCCVCC1		((uint)0x00010000)
+#define BCSR1_PCCVCC_MASK	(BCSR1_PCCVCC0 | BCSR1_PCCVCC1)
+
+#define BCSR4_ETH10_RST		((uint)0x80000000)	/* 10Base-T PHY reset*/
+#define BCSR4_USB_LO_SPD	((uint)0x04000000)
+#define BCSR4_USB_VCC		((uint)0x02000000)
+#define BCSR4_USB_FULL_SPD	((uint)0x00040000)
+#define BCSR4_USB_EN		((uint)0x00020000)
+
+#define BCSR5_MII2_EN		0x40
+#define BCSR5_MII2_RST		0x20
+#define BCSR5_T1_RST		0x10
+#define BCSR5_ATM155_RST	0x08
+#define BCSR5_ATM25_RST		0x04
+#define BCSR5_MII1_EN		0x02
+#define BCSR5_MII1_RST		0x01
+
+/* Interrupt level assignments */
+#define PHY_INTERRUPT	SIU_IRQ7	/* PHY link change interrupt */
+#define SIU_INT_FEC1	SIU_LEVEL1	/* FEC1 interrupt */
+#define SIU_INT_FEC2	SIU_LEVEL3	/* FEC2 interrupt */
+#define FEC_INTERRUPT	SIU_INT_FEC1	/* FEC interrupt */
+
+/* We don't use the 8259 */
+#define NR_8259_INTS	0
+
+/* CPM Ethernet through SCC3 */
+#define PA_ENET_RXD	((ushort)0x0040)
+#define PA_ENET_TXD	((ushort)0x0080)
+#define PE_ENET_TCLK	((uint)0x00004000)
+#define PE_ENET_RCLK	((uint)0x00008000)
+#define PE_ENET_TENA	((uint)0x00000010)
+#define PC_ENET_CLSN	((ushort)0x0400)
+#define PC_ENET_RENA	((ushort)0x0800)
+
+/* Control bits in the SICR to route TCLK (CLK5) and RCLK (CLK6) to
+ * SCC3.  Also, make sure GR3 (bit 8) and SC3 (bit 9) are zero */
+#define SICR_ENET_MASK	((uint)0x00ff0000)
+#define SICR_ENET_CLKRT	((uint)0x002c0000)
+
+#endif /* __ASM_MPC885ADS_H__ */
+#endif /* __KERNEL__ */
diff --git a/arch/powerpc/platforms/8xx/mpc885ads_setup.c b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
new file mode 100644
index 0000000..369596e
--- /dev/null
+++ b/arch/powerpc/platforms/8xx/mpc885ads_setup.c
@@ -0,0 +1,377 @@
+/*arch/ppc/platforms/mpc885ads-setup.c
+ *
+ * Platform setup for the Freescale mpc885ads board
+ *
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Copyright 2005 MontaVista Software Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/root_dev.h>
+
+#include <linux/fs_enet_pd.h>
+#include <linux/fs_uart_pd.h>
+#include <linux/mii.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/ppcboot.h>
+#include <asm/mpc8xx.h>
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+#include <asm/fs_pd.h>
+#include <asm/prom.h>
+
+extern void cpm_reset(void);
+extern void mpc8xx_show_cpuinfo(struct seq_file*);
+extern void mpc8xx_restart(char *cmd);
+extern void mpc8xx_calibrate_decr(void);
+extern int mpc8xx_set_rtc_time(struct rtc_time *tm);
+extern void mpc8xx_get_rtc_time(struct rtc_time *tm);
+extern void m8xx_pic_init(void);
+extern unsigned int mpc8xx_get_irq(void);
+
+static void init_smc1_uart_ioports(struct fs_uart_platform_info* fpi);
+static void init_smc2_uart_ioports(struct fs_uart_platform_info* fpi);
+static void init_scc3_ioports(struct fs_platform_info* ptr);
+
+void __init mpc885ads_board_setup(void)
+{
+	cpm8xx_t *cp = cpmp;
+ 	unsigned int *bcsr_io;
+	u8 tmpval8;
+
+#ifdef CONFIG_FS_ENET
+	iop8xx_t *io_port;
+#endif
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR\n");
+		return;
+	}
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	clrbits32(bcsr_io, BCSR1_RS232EN_1);
+	clrbits32(&cp->cp_simode, 0xe0000000 >> 17);	/* brg1 */
+	tmpval8 = in_8(&(cp->cp_smc[0].smc_smcm)) | (SMCM_RX | SMCM_TX);
+	out_8(&(cp->cp_smc[0].smc_smcm), tmpval8);
+	clrbits16(&cp->cp_smc[0].smc_smcmr, SMCMR_REN | SMCMR_TEN);	/* brg1 */
+#else
+	setbits32(bcsr_io,BCSR1_RS232EN_1);
+	out_be16(&cp->cp_smc[0].smc_smcmr, 0);
+	out_8(&cp->cp_smc[0].smc_smce, 0);
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SMC2
+	clrbits32(bcsr_io,BCSR1_RS232EN_2);
+	clrbits32(&cp->cp_simode, 0xe0000000 >> 1);
+	setbits32(&cp->cp_simode, 0x20000000 >> 1);	/* brg2 */
+	tmpval8 = in_8(&(cp->cp_smc[1].smc_smcm)) | (SMCM_RX | SMCM_TX);
+	out_8(&(cp->cp_smc[1].smc_smcm), tmpval8);
+	clrbits16(&cp->cp_smc[1].smc_smcmr, SMCMR_REN | SMCMR_TEN);
+
+	init_smc2_uart_ioports(0);
+#else
+	setbits32(bcsr_io,BCSR1_RS232EN_2);
+	out_be16(&cp->cp_smc[1].smc_smcmr, 0);
+	out_8(&cp->cp_smc[1].smc_smce, 0);
+#endif
+	iounmap(bcsr_io);
+
+#ifdef CONFIG_FS_ENET
+	/* use MDC for MII (common) */
+	io_port = (iop8xx_t*)immr_map(im_ioport);
+	setbits16(&io_port->iop_pdpar, 0x0080);
+	clrbits16(&io_port->iop_pddir, 0x0080);
+
+	bcsr_io = ioremap(BCSR5, sizeof(unsigned long));
+	clrbits32(bcsr_io,BCSR5_MII1_EN);
+	clrbits32(bcsr_io,BCSR5_MII1_RST);
+#ifndef CONFIG_FC_ENET_HAS_SCC
+	clrbits32(bcsr_io,BCSR5_MII2_EN);
+	clrbits32(bcsr_io,BCSR5_MII2_RST);
+
+#endif
+	iounmap(bcsr_io);
+	immr_unmap(io_port);
+
+#endif
+}
+
+
+static void init_fec1_ioports(struct fs_platform_info* ptr)
+{
+	cpm8xx_t *cp = cpmp;
+	iop8xx_t *io_port = (iop8xx_t *)immr_map(im_ioport);
+
+	/* configure FEC1 pins  */
+	setbits16(&io_port->iop_papar, 0xf830);
+	setbits16(&io_port->iop_padir, 0x0830);
+	clrbits16(&io_port->iop_padir, 0xf000);
+
+	setbits32(&cp->cp_pbpar, 0x00001001);
+	clrbits32(&cp->cp_pbdir, 0x00001001);
+
+	setbits16(&io_port->iop_pcpar, 0x000c);
+	clrbits16(&io_port->iop_pcdir, 0x000c);
+
+	setbits32(&cp->cp_pepar, 0x00000003);
+	setbits32(&cp->cp_pedir, 0x00000003);
+	clrbits32(&cp->cp_peso, 0x00000003);
+	clrbits32(&cp->cp_cptr, 0x00000100);
+
+	immr_unmap(io_port);
+}
+
+
+static void init_fec2_ioports(struct fs_platform_info* ptr)
+{
+	cpm8xx_t *cp = cpmp;
+	iop8xx_t *io_port = (iop8xx_t *)immr_map(im_ioport);
+
+	/* configure FEC2 pins */
+	setbits32(&cp->cp_pepar, 0x0003fffc);
+	setbits32(&cp->cp_pedir, 0x0003fffc);
+	clrbits32(&cp->cp_peso, 0x000087fc);
+	setbits32(&cp->cp_peso, 0x00037800);
+	clrbits32(&cp->cp_cptr, 0x00000080);
+
+	immr_unmap(io_port);
+}
+
+void init_fec_ioports(struct fs_platform_info *fpi)
+{
+	int fec_no = fs_get_fec_index(fpi->fs_no);
+
+	switch (fec_no) {
+	case 0:
+		init_fec1_ioports(fpi);
+		break;
+	case 1:
+		init_fec2_ioports(fpi);
+		break;
+	default:
+		printk(KERN_ERR "init_fec_ioports: invalid FEC number\n");
+		return;
+	}
+}
+
+static void init_scc3_ioports(struct fs_platform_info* fpi)
+{
+	unsigned *bcsr_io;
+	iop8xx_t *io_port;
+	cpm8xx_t *cp = cpmp;
+
+	bcsr_io = ioremap(BCSR_ADDR, BCSR_SIZE);
+	io_port = (iop8xx_t *)immr_map(im_ioport);
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR\n");
+		return;
+	}
+
+	/* Enable the PHY.
+	 */
+	clrbits32(bcsr_io+4, BCSR4_ETH10_RST);
+	udelay(1000);
+	setbits32(bcsr_io+4, BCSR4_ETH10_RST);
+	/* Configure port A pins for Txd and Rxd.
+	 */
+	setbits16(&io_port->iop_papar, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits16(&io_port->iop_padir, PA_ENET_RXD | PA_ENET_TXD);
+
+	/* Configure port C pins to enable CLSN and RENA.
+	 */
+	clrbits16(&io_port->iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
+	clrbits16(&io_port->iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
+	setbits16(&io_port->iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
+
+	/* Configure port E for TCLK and RCLK.
+	 */
+	setbits32(&cp->cp_pepar, PE_ENET_TCLK | PE_ENET_RCLK);
+	clrbits32(&cp->cp_pepar, PE_ENET_TENA);
+	clrbits32(&cp->cp_pedir,
+		  PE_ENET_TCLK | PE_ENET_RCLK | PE_ENET_TENA);
+	clrbits32(&cp->cp_peso, PE_ENET_TCLK | PE_ENET_RCLK);
+	setbits32(&cp->cp_peso, PE_ENET_TENA);
+
+	/* Configure Serial Interface clock routing.
+	 * First, clear all SCC bits to zero, then set the ones we want.
+	 */
+	clrbits32(&cp->cp_sicr, SICR_ENET_MASK);
+	setbits32(&cp->cp_sicr, SICR_ENET_CLKRT);
+
+	/* Disable Rx and Tx. SMC1 sshould be stopped if SCC3 eternet are used.
+	 */
+	clrbits16(&cp->cp_smc[0].smc_smcmr, SMCMR_REN | SMCMR_TEN);
+	/* On the MPC885ADS SCC ethernet PHY is initialized in the full duplex mode
+	 * by H/W setting after reset. SCC ethernet controller support only half duplex.
+	 * This discrepancy of modes causes a lot of carrier lost errors.
+	 */
+
+	/* In the original SCC enet driver the following code is placed at
+	   the end of the initialization */
+	setbits32(&cp->cp_pepar, PE_ENET_TENA);
+	clrbits32(&cp->cp_pedir, PE_ENET_TENA);
+	setbits32(&cp->cp_peso, PE_ENET_TENA);
+
+	setbits32(bcsr_io+4, BCSR1_ETHEN);
+	iounmap(bcsr_io);
+	immr_unmap(io_port);
+}
+
+void init_scc_ioports(struct fs_platform_info *fpi)
+{
+	int scc_no = fs_get_scc_index(fpi->fs_no);
+
+	switch (scc_no) {
+	case 2:
+		init_scc3_ioports(fpi);
+		break;
+	default:
+		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
+		return;
+	}
+}
+
+
+
+static void init_smc1_uart_ioports(struct fs_uart_platform_info* ptr)
+{
+        unsigned *bcsr_io;
+	cpm8xx_t *cp = cpmp;
+
+	setbits32(&cp->cp_pepar, 0x000000c0);
+	clrbits32(&cp->cp_pedir, 0x000000c0);
+	clrbits32(&cp->cp_peso, 0x00000040);
+	setbits32(&cp->cp_peso, 0x00000080);
+
+        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+        if (bcsr_io == NULL) {
+                printk(KERN_CRIT "Could not remap BCSR1\n");
+                return;
+        }
+        clrbits32(bcsr_io,BCSR1_RS232EN_1);
+        iounmap(bcsr_io);
+}
+
+static void init_smc2_uart_ioports(struct fs_uart_platform_info* fpi)
+{
+        unsigned *bcsr_io;
+	cpm8xx_t *cp = cpmp;
+
+	setbits32(&cp->cp_pepar, 0x00000c00);
+	clrbits32(&cp->cp_pedir, 0x00000c00);
+	clrbits32(&cp->cp_peso, 0x00000400);
+	setbits32(&cp->cp_peso, 0x00000800);
+
+        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+        if (bcsr_io == NULL) {
+                printk(KERN_CRIT "Could not remap BCSR1\n");
+                return;
+        }
+        clrbits32(bcsr_io,BCSR1_RS232EN_2);
+        iounmap(bcsr_io);
+}
+
+void init_smc_ioports(struct fs_uart_platform_info *data)
+{
+	int smc_no = fs_uart_id_fsid2smc(data->fs_no);
+
+	switch (smc_no) {
+	case 0:
+		init_smc1_uart_ioports(data);
+		data->brg = data->clk_rx;
+		break;
+	case 1:
+		init_smc2_uart_ioports(data);
+		data->brg = data->clk_rx;
+		break;
+	default:
+		printk(KERN_ERR "init_scc_ioports: invalid SCC number\n");
+		return;
+	}
+}
+
+int platform_device_skip(char *model, int id)
+{
+#ifdef CONFIG_FS_ENET_HAS_SCC
+	const char *dev = "FEC";
+	int n = 2;
+#else
+	const char *dev = "SCC";
+	int n = 3;
+#endif
+
+	if (!strcmp(model, dev) && n == id)
+		return 1;
+
+	return 0;
+}
+
+static void __init mpc885ads_setup_arch(void)
+{
+	struct device_node *cpu;
+
+	cpu = of_find_node_by_type(NULL, "cpu");
+	if (cpu != 0) {
+		const unsigned int *fp;
+
+		fp = get_property(cpu, "clock-frequency", NULL);
+		if (fp != 0)
+			loops_per_jiffy = *fp / HZ;
+		else
+			loops_per_jiffy = 50000000 / HZ;
+		of_node_put(cpu);
+	}
+
+	cpm_reset();
+
+	mpc885ads_board_setup();
+
+	ROOT_DEV = Root_NFS;
+}
+
+static int __init mpc885ads_probe(void)
+{
+	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
+					  "model", NULL);
+	if (model == NULL)
+		return 0;
+	if (strcmp(model, "MPC885ADS"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(mpc885_ads) {
+	.name			= "MPC885 ADS",
+	.probe			= mpc885ads_probe,
+	.setup_arch		= mpc885ads_setup_arch,
+	.init_IRQ		= m8xx_pic_init,
+	.show_cpuinfo		= mpc8xx_show_cpuinfo,
+	.get_irq		= mpc8xx_get_irq,
+	.restart		= mpc8xx_restart,
+	.calibrate_decr		= mpc8xx_calibrate_decr,
+	.set_rtc_time		= mpc8xx_set_rtc_time,
+	.get_rtc_time		= mpc8xx_get_rtc_time,
+};
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 44d95ea..961021b 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -8,6 +8,7 @@ endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
+obj-$(CONFIG_PPC_8xx)		+= 8xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_86xx)		+= 86xx/
