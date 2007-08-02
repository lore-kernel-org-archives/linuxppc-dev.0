Return-Path: <Sergej.Stepanov@ids.de>
Subject: [PATCH] Add support for IDS8247 board
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: Linuxppc-embedded@ozlabs.org
Date: Thu, 02 Aug 2007 11:36:43 +0200
Message-Id: <1186047403.11555.3.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello!

Add support for IDS8247 board from IDS GmbH, Germany

Regards
Sergej Stepanov.
---

diff -ruN linux-2.6.22.1_orig/arch/powerpc/boot/dts/mpc8247ids.dts linux-2.6.22.1_ids8247/arch/powerpc/boot/dts/mpc8247ids.dts
--- linux-2.6.22.1_orig/arch/powerpc/boot/dts/mpc8247ids.dts	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22.1_ids8247/arch/powerpc/boot/dts/mpc8247ids.dts	2007-08-02 10:15:22.000000000 +0200
@@ -0,0 +1,146 @@
+/*
+ * IDS8247 Device Tree Source
+ *
+ * Copyright 2007 IDS GmbH, Germany
+ * Sergej Steapnov <Sergej.Stepanov@ids.de>
+ * 
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ * Compiled: dtc -O dtb -o mpc8247ids.dtb -b 0 mpc8247ids.dts
+ */
+
+/ {
+       model = "MPC8247IDS";
+       compatible = "IDSLinuxFamily";
+       #address-cells = <1>;
+       #size-cells = <1>;
+
+       cpus {
+               #cpus = <1>;
+               #address-cells = <1>;
+               #size-cells = <0>;
+
+               PowerPC,8247@0 {
+            	       name="PowerPC,8247";
+                       device_type = "cpu";
+                       reg = <0>;
+                       d-cache-line-size = <20>;       // 32 bytes
+                       i-cache-line-size = <20>;       // 32 bytes
+                       d-cache-size = <4000>;          // L1, 16K
+                       i-cache-size = <4000>;          // L1, 16K
+                       timebase-frequency = <FBC520>;
+                       bus-frequency = <3EF1480>;
+                       clock-frequency = <FBC5200>;
+                       32-bit;
+               };
+       };
+
+       memory {
+               name="memory";
+               device_type = "memory";
+               reg = <0 2000000>;
+       };
+       
+       soc8247@f0000000 {
+                 #address-cells = <1>;
+                 #size-cells = <1>;
+                 #interrupt-cells = <2>;
+                 device_type = "soc";
+		 reg = <f0000000 21000>;
+		 serial8250@e0008000 {
+ 				 #address-cells = <1>;
+				 #size-cells = <1>;
+				 #interrupt-cells = <1>;
+				 device_type = "serial";
+				 compatible = "ns16550";	
+				 reg = <e0008000 0000100>;
+				 interrputs = <19>;
+				 //bus-frequency = <BEBC200>;
+				 clock-frequency = <E10000>;
+				 current-speed = <1C200>;
+		 };
+                 mdio@0 {
+                        device_type = "mdio";
+                        compatible = "fs_enet";
+                        reg = <0 0>;
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+                        #interrupt-cells = <2>;
+                        interrupt-parent = <&cpmpic>;
+                        phy0: ethernet-phy@1 {
+			        #address-cells = <0>;
+                                #interrupt-cells = <2>;
+			        interrupts = <14 2>;
+                                interrupt-parent = <&cpmpic>;
+                                bitbang = [07 07 15 00 00 01];
+                                bboffsets = <10d70 10d60 10d50>;
+                                reg = <1>;
+                                device_type = "ethernet-phy";
+                        };
+                };
+                ethernet@24000 {
+                       #address-cells = <1>;
+                       #size-cells = <0>;
+                       device_type = "network";
+                       compatible = "fs_enet";
+		       device-id=<1>;
+                       model = "FCC";
+                       reg = <f0011300 20 f0008400 100 f0011380 30>;
+                       interrupts = <20 2>;
+                       interrupt-parent = <&cpmpic>;
+                       phy-handle = <&phy0>;
+                       rx-clock = <a>;
+                       tx-clock = <9>;
+                };
+                cpm2: cpm@f0000000 {
+                       #address-cells = <1>;
+                       #size-cells = <1>;
+                       device_type = "cpm";
+                       model = "CPM2";
+                       ranges = <00000000 00000000 20000>;
+                       reg = <0 20000>;
+                       command-proc = <119c0>;
+                       brg-frequency = <5E69EC0>;
+                       cpm_clk = <BCD3D80>;
+                       compatible = "8272";
+		};
+                cpmpic: interrupt-controller@10c00 {
+                         #address-cells = <0>;
+			 #interrupt-cells = <2>;
+                         interrupt-controller;
+                         reg = <10c00 80>;
+                         built-in;
+                         device_type = "cpm-pic";
+		         compatible = "CPM2";
+                };
+	};
+
+       	flash@ff800000 {
+		       device_type = "rom";
+		       compatible = "direct-mapped";
+		       reg = <ff800000 800000>; /* Default (64MB) */
+		       probe-type = "CFI";
+		       bank-width = <1>;
+		       partitions = <00000000 00200000 /* RO */
+		       		    00200000 00700000 /* R0 */
+		      		    00700000 00740000 /* RO */
+		      		    00740000 00780000>; /* RO */
+				    partition-names = "kernel", "cramfs", "u-boot", "env";
+	};
+       	flash@e1000000 {
+		       device_type = "gen_nand";
+		       compatible = "direct-mapped";
+		       reg = <e1000000 1000>;
+		       partitions = <00000000 01000000  /* RW */
+		       		     01000000 01000000>;/* RO */
+		       partition-names = "IDS8247-NANDBIN", "IDS8247-NANDDATA";
+	};
+        chosen {
+               name = "chosen";
+	       bootargs = "root=/dev/nfs rtc-pcf8563.probe=1,0x51 rw nfsroot=192.168.30.54:/home/opt/eldk-4.1/ppc_6xx ip=192.168.30.131:192.168.30.54:192.168.30.1:255.255.255.0:ids8247:eth0:off netconsole=@/,@192.168.30.54";
+	       linux,platform = <0>;	 
+	       linux,stdout-path = "/soc8247@f0000000/serial8250@e0008000";
+	};
+};
diff -ruN linux-2.6.22.1_orig/arch/powerpc/configs/ids8247_defconfig linux-2.6.22.1_ids8247/arch/powerpc/configs/ids8247_defconfig
--- linux-2.6.22.1_orig/arch/powerpc/configs/ids8247_defconfig	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22.1_ids8247/arch/powerpc/configs/ids8247_defconfig	2007-08-02 10:15:22.000000000 +0200
@@ -0,0 +1,637 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.22.1
+# Tue Jul 31 09:34:17 2007
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
+CONFIG_PPC_82xx=y
+CONFIG_6xx=y
+CONFIG_PPC_FPU=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
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
+CONFIG_IPC_NS=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_BSD_PROCESS_ACCT=y
+CONFIG_BSD_PROCESS_ACCT_V3=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_SYSCTL=y
+CONFIG_EMBEDDED=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
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
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_KMOD=y
+
+#
+# Block layer
+#
+CONFIG_BLOCK=y
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_DEADLINE=y
+CONFIG_DEFAULT_DEADLINE=y
+CONFIG_DEFAULT_IOSCHED="deadline"
+
+#
+# Platform support
+#
+CONFIG_MPC82xx_IDS8247=y
+CONFIG_8260=y
+CONFIG_8272=y
+CONFIG_PPC_NATIVE=y
+CONFIG_CPM2=y
+
+#
+# Kernel options
+#
+CONFIG_HZ_250=y
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=y
+CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_ZONE_DMA_FLAG=1
+CONFIG_PROC_DEVICETREE=y
+CONFIG_SECCOMP=y
+CONFIG_WANT_DEVICE_TREE=y
+CONFIG_DEVICE_TREE=""
+CONFIG_ISA_DMA_API=y
+
+#
+# Bus options
+#
+CONFIG_ZONE_DMA=y
+CONFIG_FSL_SOC=y
+
+#
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# Advanced setup
+#
+CONFIG_ADVANCED_OPTIONS=y
+CONFIG_HIGHMEM_START=0xfe000000
+# CONFIG_LOWMEM_SIZE_BOOL is not set
+CONFIG_LOWMEM_SIZE=0x30000000
+# CONFIG_KERNEL_START_BOOL is not set
+CONFIG_KERNEL_START=0xc0000000
+# CONFIG_TASK_SIZE_BOOL is not set
+CONFIG_TASK_SIZE=0x80000000
+# CONFIG_BOOT_LOAD_BOOL is not set
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
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_SYN_COOKIES=y
+CONFIG_INET_XFRM_MODE_TRANSPORT=y
+CONFIG_INET_XFRM_MODE_TUNNEL=y
+CONFIG_INET_XFRM_MODE_BEET=y
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_IPV6 is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+
+#
+# Wireless
+#
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
+CONFIG_DEBUG_DRIVER=y
+
+#
+# Connector - unified userspace <-> kernelspace linker
+#
+CONFIG_MTD=y
+CONFIG_MTD_PARTITIONS=y
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_NFTL=y
+CONFIG_NFTL_RW=y
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_CFI_ADV_OPTIONS=y
+CONFIG_MTD_CFI_NOSWAP=y
+CONFIG_MTD_CFI_GEOMETRY=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_UTIL=y
+
+#
+# Mapping drivers for chip access
+#
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PHYSMAP_START=0xFF800000
+CONFIG_MTD_PHYSMAP_LEN=0x800000
+CONFIG_MTD_PHYSMAP_BANKWIDTH=1
+
+#
+# Self-contained MTD device drivers
+#
+
+#
+# Disk-On-Chip Device Drivers
+#
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_VERIFY_WRITE=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_PLATFORM=y
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
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
+CONFIG_BLK_DEV_LOOP=y
+
+#
+# Misc devices
+#
+# CONFIG_IDE is not set
+
+#
+# SCSI device support
+#
+
+#
+# Multi-device support (RAID and LVM)
+#
+
+#
+# Network device support
+#
+CONFIG_NETDEVICES=y
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+CONFIG_MICREL_PHY=y
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+
+#
+# Wireless LAN
+#
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
+
+#
+# Input Device Drivers
+#
+
+#
+# Hardware I/O ports
+#
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=1
+CONFIG_SERIAL_8250_RUNTIME_UARTS=1
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_8250_SHARE_IRQ=y
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+
+#
+# IPMI
+#
+CONFIG_NVRAM=y
+CONFIG_GEN_RTC=y
+
+#
+# TPM devices
+#
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+CONFIG_I2C_ALGOBIT=y
+
+#
+# I2C Hardware Bus support
+#
+CONFIG_I2C_IDS8247=y
+
+#
+# Miscellaneous I2C Chip support
+#
+CONFIG_SENSORS_EEPROM=y
+CONFIG_I2C_DEBUG_CORE=y
+CONFIG_I2C_DEBUG_ALGO=y
+CONFIG_I2C_DEBUG_BUS=y
+CONFIG_I2C_DEBUG_CHIP=y
+
+#
+# SPI support
+#
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+CONFIG_HWMON=y
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
+# Multimedia devices
+#
+
+#
+# Graphics support
+#
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+
+#
+# Console display driver support
+#
+CONFIG_VGA_CONSOLE=y
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
+
+#
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+#
+
+#
+# USB Gadget Support
+#
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
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+
+#
+# I2C RTC drivers
+#
+CONFIG_RTC_DRV_PCF8563=y
+
+#
+# SPI RTC drivers
+#
+
+#
+# Platform RTC drivers
+#
+
+#
+# on-CPU RTC drivers
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
+CONFIG_FS_POSIX_ACL=y
+CONFIG_ROMFS_FS=y
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+CONFIG_AUTOFS_FS=y
+CONFIG_GENERIC_ACL=y
+
+#
+# CD-ROM/DVD Filesystems
+#
+
+#
+# DOS/FAT/NT Filesystems
+#
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_CRAMFS=y
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_DIRECTIO=y
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+
+#
+# Native Language Support
+#
+# CONFIG_NLS is not set
+
+#
+# Distributed Lock Manager
+#
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_CRC32=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_PLIST=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+
+#
+# Instrumentation Support
+#
+
+#
+# Kernel hacking
+#
+CONFIG_PRINTK_TIME=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_KOBJECT=y
+CONFIG_DEBUG_BUGVERBOSE=y
+CONFIG_DEBUG_INFO=y
+CONFIG_DEBUGGER=y
+CONFIG_BDI_SWITCH=y
+
+#
+# Security options
+#
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MD5=y
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_DES=y
+CONFIG_CRYPTO_BLOWFISH=y
+
+#
+# Hardware crypto devices
+#
diff -ruN linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/ids8247.h linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/ids8247.h
--- linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/ids8247.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/ids8247.h	2007-08-02 10:15:22.000000000 +0200
@@ -0,0 +1,52 @@
+/*
+ * MPC8247 IDS8274 board platform setup
+ *
+ * Author: Sergej Stepanov <Sergej.Stepanov@ids.de>
+ *   Copyright (c) 2007, IDS GmbH, Germany 
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifdef __KERNEL__
+#ifndef __IDS8247_PLATFORM
+#define __IDS8247_PLATFORM
+
+
+#include <linux/seq_file.h>
+#include <asm/ppcboot.h>
+#include <asm/irq.h>
+
+#define IO_PHYS_ADDR            ((uint)0xE0000000)
+
+#define CPM_MAP_ADDR		((uint)get_immrbase())
+#define CPM_IRQ_OFFSET          0
+
+#define PHY_INTERRUPT		SIU_INT_IRQ2
+
+/* For our show_cpuinfo hooks. */
+#define CPUINFO_VENDOR		"Freescale Semiconductor"
+#define CPUINFO_MACHINE         "IDS8247 PowerPC Port by IDS GmbH"
+
+/* some info stuff */
+#define BOOTROM_RESTART_ADDR	((uint)0xFFF00104)
+
+#define	I2C_ADDR_RTC		0x51
+#define CFG_NAND_BASE		0xE1000000
+#define IDS8247_UART_BASE       0xE0008000
+#define RS_TABLE_SIZE           1
+#define BASE_BAUD               115200
+#define IDS8247UARTIRQ          SIU_INT_IRQ7
+#define SERIAL_PORT_DFNS						\
+  { 0, 14745600, 0, IDS8247UARTIRQ,					\
+      ASYNC_BOOT_AUTOCONF|ASYNC_SKIP_TEST,				\
+      iomem_base: (unsigned char *) 0xE0008000,				\
+      io_type: SERIAL_IO_MEM},
+
+
+void m82xx_calibrate_decr(void);
+void mpc82xx_ads_show_cpuinfo(struct seq_file*);
+
+#endif	/* __IDS8274_PLATFORM */
+#endif  /* __KERNEL__ */
diff -ruN linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/Kconfig linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/Kconfig
--- linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/Kconfig	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/Kconfig	2007-08-02 10:15:22.000000000 +0200
@@ -13,6 +13,19 @@
 	help
 	This option enables support for the MPC8272 ADS board
 
+config MPC82xx_IDS8247
+	bool "IDS8247 based on MPC8247"
+	select DEFAULT_UIMAGE
+	select 8272
+	select 8260
+	select FSL_SOC
+	select PPC_NATIVE
+	select PPC_UDBG_16550 if SERIAL_8250
+	select WANT_DEVICE_TREE
+	select MTD_NAND
+	help
+	This option enables support for the IDS8247 board
+
 endchoice
 
 config PQ2ADS
diff -ruN linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/Makefile linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/Makefile
--- linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/Makefile	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/Makefile	2007-08-02 10:15:22.000000000 +0200
@@ -3,3 +3,4 @@
 #
 obj-$(CONFIG_PPC_82xx) += mpc82xx.o
 obj-$(CONFIG_MPC82xx_ADS) += mpc82xx_ads.o
+obj-$(CONFIG_MPC82xx_IDS8247) += mpc8247_ids.o
diff -ruN linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/mpc8247_ids.c linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/mpc8247_ids.c
--- linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/mpc8247_ids.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/mpc8247_ids.c	2007-08-02 10:15:22.000000000 +0200
@@ -0,0 +1,390 @@
+/*
+ * MPC8247 IDS8274 platform setup
+ *
+ * Adapted by Sergej Stepanov <Sergej.Stepanov@ids.de>
+ *   Copyright (c) 2007, IDS GmbH, Germany 
+ *
+ * Derived from: mpc82xx_ads.c
+ *   Author: Vitaly Bordug <vbordug@ru.mvista.com>
+ *   Copyright (c) 2007, IDS GmbH, Germany 
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
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
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/physmap.h>
+#include <linux/mtd/partitions.h>
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
+#include <linux/i2c-id.h>
+
+#include <sysdev/fsl_soc.h>
+#include <../sysdev/cpm2_pic.h>
+
+#include "ids8247.h"
+
+/* FCC1 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK9-10 */
+#define F1_RXCLK      10
+#define F1_TXCLK      9
+
+/*
+  Callback function from fs_enet driver.
+*/
+void init_fcc_ioports(struct fs_platform_info *fpi)
+{
+	int fcc_no = fs_get_fcc_index(fpi->fs_no);
+	struct io_port *io;
+	u32 tempval;
+	
+	if( fcc_no > 0)
+	{
+		printk(KERN_ERR "init_fcc_ioports: invalid FCC number\n");
+		return;
+	}
+
+	io = &((cpm2_map_t *) cpm2_immr)->im_ioport;
+
+	/* FCC1 are port A/C. */
+	/* Configure port A and C pins for FCC1 Ethernet. */
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
+	tempval = PC_F1TXCLK|PC_F1RXCLK;
+
+	clrbits32(&io->iop_psorc, tempval);
+	clrbits32(&io->iop_pdirc, tempval);
+	setbits32(&io->iop_pparc, tempval);
+
+	clrbits32(&cpm2_immr->im_cpmux.cmx_fcr, CMX1_CLK_MASK);
+	setbits32(&cpm2_immr->im_cpmux.cmx_fcr, CMX1_CLK_ROUTE);
+
+}
+
+/*
+  General board setup
+*/
+int __init m82xx_board_setup( void)
+{
+	struct device_node *np;
+	struct io_port *io;
+	io = &((cpm2_map_t *) cpm2_immr)->im_ioport;
+
+	np = of_find_node_by_type(NULL, "memory");
+	if (!np) {
+		printk(KERN_INFO "No memory node in device tree\n");
+		return 1;
+	}
+	of_node_put(np);
+	
+	/* setup for bb-mdio */
+  	setbits32(&io->iop_pdird, (0x1 <<  (31 - 7)));
+  	clrbits32(&io->iop_ppard, (0x1 <<  (31 - 7)));
+  	setbits32(&io->iop_pdirc, (0x1 <<  (31 - 21)));
+  	clrbits32(&io->iop_pparc, (0x1 <<  (31 - 21)));
+
+	return 1;
+}
+
+/*
+  Init stuff for MPC8247_IDS
+  Copied from mpc82xx_ads.c
+*/
+static void __init mpc8247ids_setup_arch(void)
+{
+	cpm2_reset();
+	m82xx_board_setup();
+
+	if (ppc_md.progress)
+		ppc_md.progress("mpc8247ids_setup_arch(), finish", 0);
+}
+
+static int __init mpc8247_ids_probe(void)
+{
+	return 1;
+}
+
+/*  Copied from mpc82xx_ads.c */
+#define RMR_CSRE 0x00000001
+static void m82xx_restart(char *cmd)
+{
+	__volatile__ unsigned char dummy;
+
+	local_irq_disable();
+	((cpm2_map_t *) cpm2_immr)->im_clkrst.car_rmr |= RMR_CSRE;
+
+	/* Clear the ME,EE,IR & DR bits in MSR to cause checkstop */
+	mtmsr(mfmsr() & ~(MSR_ME | MSR_EE | MSR_IR | MSR_DR));
+	dummy = ((cpm2_map_t *) cpm2_immr)->im_clkrst.res[0];
+	printk("Restart failed\n");
+	while (1) ;
+}
+
+/*  Copied from mpc82xx_ads.c */
+static void m82xx_halt(void)
+{
+	local_irq_disable();
+	while (1) ;
+}
+
+static void __init mpc8247_ids_init_IRQ(void)
+{
+	struct device_node *np = of_find_compatible_node(NULL,
+							 "cpm-pic", "CPM2");
+	struct resource r;
+	if (np == NULL) {
+		printk(KERN_ERR "PIC init: can not find cpm-pic node\n");
+		return;
+	}
+	if (of_address_to_resource(np, 0, &r)) {
+		printk(KERN_ERR "PIC init: invalid resource\n");
+		of_node_put(np);
+		return;
+	}
+	cpm2_pic_init(np);
+	of_node_put(np);
+}
+
+#ifdef 	CONFIG_MTD_PHYSMAP
+/*
+  TODO: the table has to be build in physmap_of
+*/
+static struct mtd_partition ids8247_cramfs_partitions[] = {
+	{
+ 		.name = "kernel",
+		.size = 0x200000,
+		.offset = 0,
+		.mask_flags = 0,
+	},
+	{
+		.name = "cramfs",
+		.offset = 0x200000,
+		.size = 0x500000,
+		.mask_flags = 0,
+	},
+	{
+		.name = "u-boot",
+		.offset = 0x700000,
+		.size = 0x40000,
+		.mask_flags = 0,
+	},
+	{
+		.name = "env",
+		.offset = 0x740000,
+		.size = 0x40000,
+		.mask_flags = 0,
+	}
+};
+
+static int __init mpc82xx_ids8247_setup_mtd(void)
+{
+ 	physmap_set_partitions(ids8247_cramfs_partitions, 4);
+ 	return 0;
+}
+arch_initcall(mpc82xx_ids8247_setup_mtd);
+#endif /* CONFIG_MTD_PHYSMAP */
+
+#ifdef CONFIG_MTD_NAND_PLATFORM
+static struct mtd_partition *mpc82xx_ids8247_nand_partitions;
+
+/*
+  NAND HW special for IDS8247
+  Derived from 2.4 kernel for NC650/IDS8247
+*/
+static void mpc82xx_ids8247_nandhwcontrol(struct mtd_info *mtd, int cmd, unsigned int ctrl)
+{
+	struct nand_chip *chip = mtd->priv;
+	if( ctrl & NAND_CTRL_CHANGE) {
+		ctrl &= ~NAND_CTRL_CHANGE;
+		switch( ctrl )
+		{
+		case NAND_CTRL_CLE:
+			*(((volatile __u8 *) chip->IO_ADDR_W) + 0xa) = 0; 
+			break;
+		case NAND_CTRL_ALE:
+			*(((volatile __u8 *) chip->IO_ADDR_W) + 0x9) = 0; 
+			break;
+		case NAND_NCE:
+  			*(((volatile __u8 *) chip->IO_ADDR_W) + 0x8) = 0; 
+			break;
+		default:
+  			*(((volatile __u8 *) chip->IO_ADDR_W) + 0xc) = 0;
+		}
+	}
+	if (cmd != NAND_CMD_NONE)
+		out_8(chip->IO_ADDR_W, (char)cmd);
+}
+
+/*
+  Makes init for gen_nand device with config from OF
+  Some part of the function derived from physmap_of.c
+*/
+static int __init mpc8247_ids8247_nand_setup(void)
+{
+	int ret = 0;
+	struct device_node *np = NULL;
+	struct platform_device *nanddevice;
+	struct platform_nand_data *pdata;
+	struct resource r[1];
+	int i, plen, retval = -ENOMEM;
+	const  u32  *part;
+	const  char *name;
+	
+	memset(&r, 0, sizeof(r));
+
+ 	pdata = kzalloc(sizeof(struct platform_nand_data), GFP_KERNEL);
+ 	if( !pdata) {
+ 		ret = -ENOMEM;
+ 		return ret;
+ 	}
+
+	np = of_find_compatible_node(np, "gen_nand", "direct-mapped");
+
+	ret = of_address_to_resource(np, 0, &r[0]);
+
+	nanddevice = platform_device_register_simple("gen_nand", 0, r, 1);
+ 	if( !nanddevice) {
+ 		ret = -ENOMEM;
+ 		return ret;
+ 	}
+
+	part = of_get_property(np, "partitions", &plen);
+	if (part == NULL)
+		goto error;
+
+	retval = plen / (2 * sizeof(u32));
+
+	mpc82xx_ids8247_nand_partitions 
+		= kzalloc(retval * sizeof(struct mtd_partition), GFP_KERNEL);
+
+	if (mpc82xx_ids8247_nand_partitions == NULL) {
+		printk(KERN_ERR "Can't allocate the flash partition data!\n");
+		goto error;
+	}
+
+	name = of_get_property(np, "partition-names", &plen);
+
+	for (i = 0; i < retval; i++) {
+		mpc82xx_ids8247_nand_partitions[i].offset = *part++;
+		mpc82xx_ids8247_nand_partitions[i].size   = *part & ~1;
+
+		if (name != NULL && plen > 0) {
+			int len = strlen(name) + 1;
+
+			mpc82xx_ids8247_nand_partitions[i].name = (char *)name;
+			plen -= len;
+			name += len;
+		} else
+			mpc82xx_ids8247_nand_partitions[i].name = "unnamed";
+	}
+
+	pdata->chip.partitions    = mpc82xx_ids8247_nand_partitions;
+	pdata->chip.nr_partitions = retval;
+	pdata->ctrl.cmd_ctrl      = mpc82xx_ids8247_nandhwcontrol;
+	pdata->chip.chip_delay    = 12;
+	pdata->chip.options       = 0;
+	ret = platform_device_add_data(nanddevice, 
+				       pdata,
+				       sizeof(struct platform_nand_data));
+
+	if (IS_ERR(nanddevice)) {
+		ret = PTR_ERR(nanddevice);
+		goto error;
+	}
+	of_node_put(np);
+	return 0;
+
+error:
+	of_node_put(np);
+        kfree(pdata);
+        platform_device_unregister(nanddevice);
+	return ret;
+
+}
+
+arch_initcall(mpc8247_ids8247_nand_setup);
+#endif /* CONFIG_MTD_NAND_PARTITIONS */
+
+static int __init mpc82xx_ids8247_i2c_setup(void)
+{
+	int ret = 0;
+	struct platform_device *i2c_dev;
+	struct fsl_i2c_platform_data i2c_data;
+
+	i2c_data.device_flags = 0;
+	i2c_dev = platform_device_register_simple("bb-i2c", 0, NULL, 0);
+	if (IS_ERR(i2c_dev)) {
+		ret = PTR_ERR(i2c_dev);
+		return ret;
+	}
+	ret = platform_device_add_data(i2c_dev, 
+				       &i2c_data,
+				       sizeof(struct fsl_i2c_platform_data));
+	if(ret)
+	{
+		platform_device_unregister(i2c_dev);
+		return ret;
+	}
+
+	return 0;
+}
+arch_initcall(mpc82xx_ids8247_i2c_setup);
+
+define_machine(mpc8247_ids)
+{
+	.name = "MPC8247 IDS",
+	.probe = mpc8247_ids_probe,
+	.setup_arch = mpc8247ids_setup_arch,
+	.show_cpuinfo = mpc82xx_ads_show_cpuinfo,
+	.get_irq = cpm2_get_irq,
+	.init_IRQ =    mpc8247_ids_init_IRQ,
+	.calibrate_decr = m82xx_calibrate_decr,
+	.restart = m82xx_restart,
+	.halt = m82xx_halt,
+};
diff -ruN linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/mpc82xx.c linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/mpc82xx.c
--- linux-2.6.22.1_orig/arch/powerpc/platforms/82xx/mpc82xx.c	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/arch/powerpc/platforms/82xx/mpc82xx.c	2007-08-02 10:15:22.000000000 +0200
@@ -50,7 +50,13 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/cpm2_pic.h>
 
+#ifdef CONFIG_MPC82xx_ADS
 #include "pq2ads.h"
+#endif
+
+#ifdef CONFIG_MPC82xx_IDS8247
+#include "ids8247.h"
+#endif
 
 static int __init get_freq(char *name, unsigned long *val)
 {
diff -ruN linux-2.6.22.1_orig/arch/powerpc/sysdev/fsl_soc.c linux-2.6.22.1_ids8247/arch/powerpc/sysdev/fsl_soc.c
--- linux-2.6.22.1_orig/arch/powerpc/sysdev/fsl_soc.c	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/arch/powerpc/sysdev/fsl_soc.c	2007-08-02 10:15:22.000000000 +0200
@@ -677,7 +677,7 @@
 		if (strstr(model, "FCC")) {
 			int fcc_index = *id - 1;
 			const unsigned char *mdio_bb_prop;
-
+			const unsigned int *bboffsets;
 			fs_enet_data.dpram_offset = (u32)cpm_dpram_addr(0);
 			fs_enet_data.rx_ring = 32;
 			fs_enet_data.tx_ring = 32;
@@ -697,6 +697,7 @@
 			if (mdio_bb_prop) {
 				struct platform_device *fs_enet_mdio_bb_dev;
 				struct fs_mii_bb_platform_info fs_enet_mdio_bb_data;
+				struct resource phyr[1];
 
 				fs_enet_mdio_bb_dev =
 					platform_device_register_simple("fsl-bb-mdio",
@@ -728,7 +729,23 @@
 					(u32)&cpm2_immr->im_ioport.iop_pdirc;
 				fs_enet_mdio_bb_data.mdc_dat.offset =
 					(u32)&cpm2_immr->im_ioport.iop_pdatc;
-
+				
+				bboffsets = of_get_property(phy, "bboffsets", NULL);
+				if( bboffsets ) {
+					fs_enet_mdio_bb_data.mdio_dat.offset =
+						(u32)((cpm2_map_t *) cpm2_immr) + bboffsets[0];
+					fs_enet_mdio_bb_data.mdio_dir.offset = 
+						(u32)((cpm2_map_t *) cpm2_immr) + bboffsets[1];
+					fs_enet_mdio_bb_data.mdc_dat.offset = 
+						(u32)((cpm2_map_t *) cpm2_immr) + bboffsets[2];
+					fs_enet_mdio_bb_data.irq[0] = -1;
+					fs_enet_mdio_bb_data.irq[1] = phy_irq[0];
+					fs_enet_mdio_bb_data.irq[2] = -1;
+					fs_enet_mdio_bb_data.irq[3] = -1;
+					fs_enet_mdio_bb_data.irq[31] = -1;
+					of_irq_to_resource(phy, 0, &phyr[0]);
+				}
+				
 				ret = platform_device_add_data(
 						fs_enet_mdio_bb_dev,
 						&fs_enet_mdio_bb_data,
diff -ruN linux-2.6.22.1_orig/drivers/i2c/busses/i2c-ids8247.c linux-2.6.22.1_ids8247/drivers/i2c/busses/i2c-ids8247.c
--- linux-2.6.22.1_orig/drivers/i2c/busses/i2c-ids8247.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22.1_ids8247/drivers/i2c/busses/i2c-ids8247.c	2007-08-02 10:15:22.000000000 +0200
@@ -0,0 +1,203 @@
+/*
+ * File i2c-ids8247.c
+ *
+ * Copyright (c) 2007 IDS GmbH, Germany
+ * Author: Sergej Stepanov, <Sergej.Stepanov@ids.de>
+ * Derived from i2c-tqm8272 and i2c-i801.c
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <asm/mpc8260.h>
+#include <asm/immap_cpm2.h>
+#include <asm/io.h>
+
+
+/* delays */
+#define CYCLE_DELAY		10
+#define TIMEOUT			100 /*(HZ / 2)*/
+
+#define SCL1	0x20000	/* PD 14 */
+#define SDA1	0x10000	/* PD 15 */
+
+#define SCL2	0x00100	/* PC 23 */
+#define SDA2	0x00080	/* PC 24 */
+
+#define PAR1	cpm2_immr->im_ioport.iop_ppard
+#define DIR1	cpm2_immr->im_ioport.iop_pdird
+#define DAT1	cpm2_immr->im_ioport.iop_pdatd
+
+#define PAR2	cpm2_immr->im_ioport.iop_ppara
+#define DIR2	cpm2_immr->im_ioport.iop_pdira
+#define DAT2	cpm2_immr->im_ioport.iop_pdata
+
+static void ids8247_bit_setscl1(void *data, int val)
+{
+	if (val)
+		DAT1 |= SCL1;
+	else {
+		DAT1 &=	~SCL1;
+	}
+}
+
+static void ids8247_bit_setscl2(void *data, int val)
+{
+	if (val)
+		DAT2 |= SCL2;
+	else {
+		DAT2 &=	~SCL2;
+	}
+}
+
+static void ids8247_bit_setsda1(void *data, int val)
+{
+	if (val)
+		DIR1 &= ~SDA1;
+	else {
+		DAT1 &= ~SDA1;
+		DIR1 |= SDA1;
+	}
+}
+
+static void ids8247_bit_setsda2(void *data, int val)
+{
+	if (val)
+		DIR2 &= ~SDA2;
+	else {
+		DAT2 &= ~SDA2;
+		DIR2 |= SDA2;
+	}
+}
+
+static int ids8247_bit_getscl1(void *data)
+{
+	return (DAT1 & SCL1) != 0;
+}
+
+static int ids8247_bit_getscl2(void *data)
+{
+	return (DAT2 & SCL2) != 0;
+}
+
+static int ids8247_bit_getsda1(void *data)
+{
+	int res;
+
+	res = (DAT1 & SDA1) != 0;
+
+	return res;
+}
+
+static int ids8247_bit_getsda2(void *data)
+{
+	int res;
+
+	res = (DAT2 & SDA2) != 0;
+
+	return res;
+}
+
+static void ids8247_i2c_line_init1 (void)
+{
+	PAR1 &= ~(SCL1 | SDA1); DIR1 |= SCL1;
+}
+
+static void ids8247_i2c_line_init2 (void)
+{
+	PAR2 &= ~(SCL2 | SDA2); DIR2 |= SCL2;
+}
+
+static struct i2c_algo_bit_data ids8247_i2c_bit_data1 = {
+	.setsda		= ids8247_bit_setsda1,
+	.setscl		= ids8247_bit_setscl1,
+	.getsda		= ids8247_bit_getsda1,
+	.getscl		= ids8247_bit_getscl1,
+	.udelay		= CYCLE_DELAY,
+	.timeout	= TIMEOUT,
+};
+
+static struct i2c_algo_bit_data ids8247_i2c_bit_data2 = {
+	.setsda		= ids8247_bit_setsda2,
+	.setscl		= ids8247_bit_setscl2,
+	.getsda		= ids8247_bit_getsda2,
+	.getscl		= ids8247_bit_getscl2,
+	.udelay		= CYCLE_DELAY,
+	.timeout	= TIMEOUT,
+};
+
+static struct i2c_adapter ids8247_i2c_adapter1 = {
+	.owner		= THIS_MODULE,
+	.name		= "IDS8247 I2C Adapter1",
+	.algo_data	= &ids8247_i2c_bit_data1,
+	.id             = I2C_HW_BB_MPC8247,
+	.class          = I2C_CLASS_HWMON,
+};
+
+static struct i2c_adapter ids8247_i2c_adapter2 = {
+	.owner		= THIS_MODULE,
+	.name		= "IDS8247 I2C Adapter2",
+	.algo_data	= &ids8247_i2c_bit_data2,
+	.id             = I2C_HW_BB_MPC8247,
+	.class          = I2C_CLASS_HWMON,
+};
+
+static int ids8247_i2c_remove(struct platform_device *plat_dev)
+{
+	i2c_del_adapter(&ids8247_i2c_adapter1);
+	i2c_del_adapter(&ids8247_i2c_adapter2);
+	return 0;
+}
+
+static int ids8247_i2c_probe(struct platform_device *plat_dev)
+{
+	int err;
+
+	ids8247_i2c_line_init1();
+	ids8247_i2c_line_init2();
+	ids8247_i2c_adapter1.dev.parent = &plat_dev->dev;
+	ids8247_i2c_adapter2.dev.parent = &plat_dev->dev;
+
+ 	if ((err = i2c_bit_add_bus( &ids8247_i2c_adapter1) != 0)) {
+ 		printk(KERN_ERR "ERROR: Could not install %s\n", ids8247_i2c_adapter1.name);
+ 		return err;
+ 	}
+
+	if ((err = i2c_bit_add_bus( &ids8247_i2c_adapter2) != 0)) {
+		printk(KERN_ERR "ERROR: Could not install %s\n", ids8247_i2c_adapter2.name);
+		return err;
+	}
+	return 0;
+}
+
+
+/* Structure for a device driver */
+static struct platform_driver bb_i2c_driver = {
+	.probe = ids8247_i2c_probe,
+	.remove = __devexit_p(ids8247_i2c_remove),
+	.driver	= {
+		.owner = THIS_MODULE,
+		.name = "bb-i2c",
+	},
+};
+
+static int __init ids8247_i2c_init(void)
+{
+	return platform_driver_register(&bb_i2c_driver);
+}
+
+static void __exit ids8247_i2c_exit(void)
+{
+	platform_driver_unregister(&bb_i2c_driver);
+}
+
+MODULE_DESCRIPTION("MPC82xx-based BB-I2C adapter on IDS8247");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Sergej Stepanov, <Sergej.Stepanov@ids.de>");
+
+module_init(ids8247_i2c_init);
+module_exit(ids8247_i2c_exit);
diff -ruN linux-2.6.22.1_orig/drivers/i2c/busses/Kconfig linux-2.6.22.1_ids8247/drivers/i2c/busses/Kconfig
--- linux-2.6.22.1_orig/drivers/i2c/busses/Kconfig	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/drivers/i2c/busses/Kconfig	2007-08-02 10:15:22.000000000 +0200
@@ -267,6 +267,16 @@
 	  This driver is deprecated and will be dropped soon. Use i2c-gpio
 	  instead.
 
+config I2C_IDS8247
+	tristate "IDS8247 Bitbanged I2C Interface"
+	depends on I2C && MPC82xx_IDS8247
+	select I2C_ALGOBIT
+	help
+	  Say Y here if you have a IDS8247 board.
+
+	  This support is also available as a module. If so, the module
+	  will be called i2c-ids8247.
+
 config I2C_POWERMAC
 	tristate "Powermac I2C interface"
 	depends on PPC_PMAC
diff -ruN linux-2.6.22.1_orig/drivers/i2c/busses/Makefile linux-2.6.22.1_ids8247/drivers/i2c/busses/Makefile
--- linux-2.6.22.1_orig/drivers/i2c/busses/Makefile	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/drivers/i2c/busses/Makefile	2007-08-02 10:15:22.000000000 +0200
@@ -50,6 +50,7 @@
 obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
 obj-$(CONFIG_I2C_VOODOO3)	+= i2c-voodoo3.o
+obj-$(CONFIG_I2C_IDS8247)	+= i2c-ids8247.o
 obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
 obj-$(CONFIG_SCx200_I2C)	+= scx200_i2c.o
 
diff -ruN linux-2.6.22.1_orig/drivers/mtd/nand/plat_nand.c linux-2.6.22.1_ids8247/drivers/mtd/nand/plat_nand.c
--- linux-2.6.22.1_orig/drivers/mtd/nand/plat_nand.c	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/drivers/mtd/nand/plat_nand.c	2007-08-02 10:15:22.000000000 +0200
@@ -66,7 +66,7 @@
 	data->chip.ecc.hwctl = pdata->ctrl.hwcontrol;
 	data->chip.ecc.layout = pdata->chip.ecclayout;
 	data->chip.ecc.mode = NAND_ECC_SOFT;
-
+	data->chip.cmd_ctrl = pdata->ctrl.cmd_ctrl;
 	platform_set_drvdata(pdev, data);
 
 	/* Scan to find existance of the device */
diff -ruN linux-2.6.22.1_orig/drivers/net/fs_enet/mii-bitbang.c linux-2.6.22.1_ids8247/drivers/net/fs_enet/mii-bitbang.c
--- linux-2.6.22.1_orig/drivers/net/fs_enet/mii-bitbang.c	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/drivers/net/fs_enet/mii-bitbang.c	2007-08-02 10:15:22.000000000 +0200
@@ -336,7 +336,11 @@
 	new_bus->reset = &fs_enet_mii_bb_reset,
 	new_bus->id = pdev->id;
 
+#ifndef CONFIG_MPC82xx_IDS8247
 	new_bus->phy_mask = ~0x9;
+#else
+	new_bus->phy_mask = ~0x2;
+#endif
 	pdata = (struct fs_mii_bb_platform_info *)pdev->dev.platform_data;
 
 	if (NULL == pdata) {
diff -ruN linux-2.6.22.1_orig/drivers/net/phy/Kconfig linux-2.6.22.1_ids8247/drivers/net/phy/Kconfig
--- linux-2.6.22.1_orig/drivers/net/phy/Kconfig	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/drivers/net/phy/Kconfig	2007-08-02 10:15:22.000000000 +0200
@@ -55,6 +55,11 @@
 	---help---
 	  Currently supports the BCM5411, BCM5421 and BCM5461 PHYs.
 
+config MICREL_PHY
+	tristate "Drivers for MICREL KS8721BL PHYs"
+	---help---
+	  Currently supports on MPC82xx_IDS8247 board.
+
 config FIXED_PHY
 	tristate "Drivers for PHY emulation on fixed speed/link"
 	---help---
diff -ruN linux-2.6.22.1_orig/drivers/net/phy/Makefile linux-2.6.22.1_ids8247/drivers/net/phy/Makefile
--- linux-2.6.22.1_orig/drivers/net/phy/Makefile	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/drivers/net/phy/Makefile	2007-08-02 10:15:22.000000000 +0200
@@ -11,4 +11,5 @@
 obj-$(CONFIG_SMSC_PHY)		+= smsc.o
 obj-$(CONFIG_VITESSE_PHY)	+= vitesse.o
 obj-$(CONFIG_BROADCOM_PHY)	+= broadcom.o
+obj-$(CONFIG_MICREL_PHY)	+= micrel.o
 obj-$(CONFIG_FIXED_PHY)		+= fixed.o
diff -ruN linux-2.6.22.1_orig/drivers/net/phy/micrel.c linux-2.6.22.1_ids8247/drivers/net/phy/micrel.c
--- linux-2.6.22.1_orig/drivers/net/phy/micrel.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.22.1_ids8247/drivers/net/phy/micrel.c	2007-08-02 10:15:22.000000000 +0200
@@ -0,0 +1,109 @@
+/*
+ * drivers/net/phy/micrel.c
+ *
+ * Driver for Micrel KS8721BL PHY
+ * based on drivers/net/phy/lxt.c from Andy Fleming
+ *
+ * Author: Sergej Stepanov, IDS
+ * Copyright (c) 2007 IDS GmbH, Germany
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+
+#define MII_KS8721BL_RXERCR	0x15
+#define MII_KS8721BL_ICSR	0x1B
+#define	MII_KS8721BL_PHYCR	0x1F
+
+
+MODULE_DESCRIPTION("Micrel KS8721BL driver");
+MODULE_AUTHOR("Sergej Stepanov");
+MODULE_LICENSE("GPL");
+
+
+static int ks8721bl_config_intr(struct phy_device *phydev)
+{
+  int err1;
+
+	if(phydev->interrupts == PHY_INTERRUPT_ENABLED)
+	{
+	  err1 = phy_write(phydev, MII_KS8721BL_ICSR, 0xFF00);
+	  err1 = phy_write(phydev, 0, 0x1200); /* control register */
+	}
+	else
+		err1 = phy_write(phydev, MII_KS8721BL_ICSR, 0);
+
+	return err1;
+}
+
+static int ks8721bl_config_init(struct phy_device *phydev)
+{
+        phy_write(phydev, MII_KS8721BL_ICSR, 0);
+	return 0;
+}
+
+
+static int ks8721bl_ack_interrupt(struct phy_device *phydev)
+{
+	int err = phy_read(phydev, MII_KS8721BL_ICSR);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static struct phy_driver ks8721bl_driver = {
+	.phy_id		= 0x000221619,
+	.name		= "KS8721BL",
+	.phy_id_mask	= 0xfffffff0, /*??*/
+	.features	= PHY_BASIC_FEATURES,
+	.flags		= PHY_HAS_INTERRUPT,
+	.config_init	= ks8721bl_config_init,
+	.config_aneg	= genphy_config_aneg,
+	.read_status	= genphy_read_status,
+	.ack_interrupt	= ks8721bl_ack_interrupt,
+	.config_intr	= ks8721bl_config_intr,
+	.driver 	= { .owner = THIS_MODULE,},
+};
+
+static int __init ks8721_init(void)
+{
+	int ret;
+
+	ret = phy_driver_register(&ks8721bl_driver);
+	if (ret)
+		goto err1;
+	
+	return 0;
+ err1:
+	return ret;
+}
+
+static void __exit ks8721_exit(void)
+{
+	phy_driver_unregister(&ks8721bl_driver);
+}
+
+module_init(ks8721_init);
+module_exit(ks8721_exit);
diff -ruN linux-2.6.22.1_orig/include/asm-powerpc/mpc8260.h linux-2.6.22.1_ids8247/include/asm-powerpc/mpc8260.h
--- linux-2.6.22.1_orig/include/asm-powerpc/mpc8260.h	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/include/asm-powerpc/mpc8260.h	2007-08-02 10:15:22.000000000 +0200
@@ -19,6 +19,10 @@
 #include <platforms/82xx/m82xx_pci.h>
 #endif
 
+#ifdef CONFIG_MPC82xx_IDS8247
+#include <platforms/82xx/ids8247.h>
+#endif
+
 #endif /* CONFIG_8260 */
 #endif /* !__ASM_POWERPC_MPC8260_H__ */
 #endif /* __KERNEL__ */
diff -ruN linux-2.6.22.1_orig/include/linux/i2c-id.h linux-2.6.22.1_ids8247/include/linux/i2c-id.h
--- linux-2.6.22.1_orig/include/linux/i2c-id.h	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/include/linux/i2c-id.h	2007-08-02 10:15:22.000000000 +0200
@@ -209,6 +209,7 @@
 
 /* --- MPC824x PowerPC adapters						*/
 #define I2C_HW_MPC824X		0x100001 /* Motorola 8240 / 8245 */
+#define I2C_HW_BB_MPC8247	0x100002 /* */
 
 /* --- MPC8xx PowerPC adapters						*/
 #define I2C_HW_MPC8XX_EPON	0x110000 /* Eponymous MPC8xx I2C adapter */
