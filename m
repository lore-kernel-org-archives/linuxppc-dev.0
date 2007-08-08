Return-Path: <geoff@white.local.net>
Received: from outbound7-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AC6DFDDE9C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Aug 2007 13:58:42 +1000 (EST)
Message-Id: <20070808033120.154813767@am.sony.com>
References: <20070808033119.833895506@am.sony.com>
In-Reply-To: <20070808033119.833895506@am.sony.com>
Date: Tue, 07 Aug 2007 20:31:22 -0700
From: geoffrey.levand@am.sony.com
To: paulus@samba.org
Subject: [patch 3/3] PS3: Update ps3_defconfig
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update ps3_defconfig.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/configs/ps3_defconfig |  200 ++++++++++++-------------------------
 1 file changed, 65 insertions(+), 135 deletions(-)

--- a/arch/powerpc/configs/ps3_defconfig
+++ b/arch/powerpc/configs/ps3_defconfig
@@ -1,9 +1,23 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc6
-# Tue Jun 26 14:15:19 2007
+# Linux kernel version: 2.6.23-rc2
+# Tue Aug  7 19:17:26 2007
 #
 CONFIG_PPC64=y
+
+#
+# Processor support
+#
+# CONFIG_POWER4_ONLY is not set
+CONFIG_POWER3=y
+CONFIG_POWER4=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+# CONFIG_PPC_MM_SLICES is not set
+CONFIG_VIRT_CPU_ACCOUNTING=y
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
 CONFIG_64BIT=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -15,6 +29,7 @@ CONFIG_ARCH_HAS_ILOG2_U64=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_ARCH_NO_VIRT_TO_BUS=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_COMPAT=y
@@ -22,50 +37,32 @@ CONFIG_SYSVIPC_COMPAT=y
 CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
+CONFIG_OF=y
 # CONFIG_PPC_UDBG_16550 is not set
 # CONFIG_GENERIC_TBSYNC is not set
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 # CONFIG_DEFAULT_UIMAGE is not set
-
-#
-# Processor support
-#
-# CONFIG_POWER4_ONLY is not set
-CONFIG_POWER3=y
-CONFIG_POWER4=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
 # CONFIG_PPC_OF_PLATFORM_PCI is not set
-CONFIG_ALTIVEC=y
-CONFIG_PPC_STD_MMU=y
-# CONFIG_PPC_MM_SLICES is not set
-CONFIG_VIRT_CPU_ACCOUNTING=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=2
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
+# CONFIG_USER_NS is not set
 # CONFIG_AUDIT is not set
 # CONFIG_IKCONFIG is not set
 CONFIG_LOG_BUF_SHIFT=17
@@ -100,10 +97,6 @@ CONFIG_SLAB=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_FORCE_UNLOAD is not set
@@ -111,12 +104,9 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
 CONFIG_STOP_MACHINE=y
-
-#
-# Block layer
-#
 CONFIG_BLOCK=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
+CONFIG_BLK_DEV_BSG=y
 
 #
 # IO Schedulers
@@ -136,7 +126,9 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_EMBEDDED6xx is not set
-# CONFIG_APUS is not set
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
 # CONFIG_PPC_MPC52xx is not set
@@ -223,6 +215,7 @@ CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
 CONFIG_ZONE_DMA_FLAG=1
+CONFIG_BOUNCE=y
 CONFIG_ARCH_MEMORY_PROBE=y
 # CONFIG_PPC_HAS_HASH_64K is not set
 # CONFIG_PPC_64K_PAGES is not set
@@ -241,6 +234,7 @@ CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PCI is not set
 # CONFIG_PCI_DOMAINS is not set
+# CONFIG_PCI_SYSCALL is not set
 # CONFIG_ARCH_SUPPORTS_MSI is not set
 
 #
@@ -365,6 +359,7 @@ CONFIG_WIRELESS_EXT=y
 # CONFIG_MAC80211 is not set
 # CONFIG_IEEE80211 is not set
 # CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -379,26 +374,11 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_DEBUG_DRIVER is not set
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
 # CONFIG_MTD is not set
-
-#
-# Parallel port support
-#
+CONFIG_OF_DEVICE=y
 # CONFIG_PARPORT is not set
-
-#
-# Plug and Play support
-#
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
+CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
@@ -411,11 +391,8 @@ CONFIG_BLK_DEV_RAM_SIZE=65535
 CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
-#
-# CONFIG_BLINK is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_EEPROM_93CX6 is not set
 # CONFIG_IDE is not set
 
 #
@@ -423,6 +400,7 @@ CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 #
 # CONFIG_RAID_ATTRS is not set
 CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
 # CONFIG_SCSI_TGT is not set
 # CONFIG_SCSI_NETLINK is not set
 CONFIG_SCSI_PROC_FS=y
@@ -455,37 +433,22 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_ISCSI_ATTRS is not set
 # CONFIG_SCSI_SAS_ATTRS is not set
 # CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
-# CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_LOWLEVEL is not set
 # CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+# CONFIG_NETDEVICES_MULTIQUEUE is not set
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 # CONFIG_NET_ETHERNET is not set
 CONFIG_MII=m
 CONFIG_NETDEV_1000=y
-CONFIG_NETDEV_10000=y
 CONFIG_GELIC_NET=y
+# CONFIG_NETDEV_10000 is not set
 
 #
 # Wireless LAN
@@ -518,15 +481,7 @@ CONFIG_USB_NET_MCS7830=m
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
@@ -604,10 +559,6 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=16
-
-#
-# IPMI
-#
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
@@ -616,10 +567,6 @@ CONFIG_GEN_RTC=y
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_HANGCHECK_TIMER is not set
-
-#
-# TPM devices
-#
 # CONFIG_TCG_TPM is not set
 # CONFIG_I2C is not set
 
@@ -628,11 +575,8 @@ CONFIG_GEN_RTC=y
 #
 # CONFIG_SPI is not set
 # CONFIG_SPI_MASTER is not set
-
-#
-# Dallas's 1-wire bus
-#
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
 # CONFIG_HWMON is not set
 
 #
@@ -657,6 +601,7 @@ CONFIG_GEN_RTC=y
 #
 # CONFIG_DISPLAY_SUPPORT is not set
 # CONFIG_VGASTATE is not set
+CONFIG_VIDEO_OUTPUT_CONTROL=m
 CONFIG_FB=y
 # CONFIG_FIRMWARE_EDID is not set
 # CONFIG_FB_DDC is not set
@@ -691,11 +636,13 @@ CONFIG_FB_PS3_DEFAULT_SIZE_M=18
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
 CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
 CONFIG_LOGO=y
+CONFIG_FB_LOGO_EXTRA=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
@@ -709,6 +656,8 @@ CONFIG_SOUND=y
 # Advanced Linux Sound Architecture
 #
 CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
 # CONFIG_SND_SEQUENCER is not set
 # CONFIG_SND_MIXER_OSS is not set
 # CONFIG_SND_PCM_OSS is not set
@@ -735,6 +684,12 @@ CONFIG_SND_VERBOSE_PROCFS=y
 #
 
 #
+# ALSA PowerPC devices
+#
+CONFIG_SND_PS3=y
+CONFIG_SND_PS3_DEFAULT_START_DELAY=2000
+
+#
 # USB devices
 #
 # CONFIG_SND_USB_AUDIO is not set
@@ -747,13 +702,14 @@ CONFIG_SND_VERBOSE_PROCFS=y
 # CONFIG_SND_SOC is not set
 
 #
-# Open Sound System
+# SoC Audio support for SuperH
 #
-# CONFIG_SOUND_PRIME is not set
 
 #
-# HID Devices
+# Open Sound System
 #
+# CONFIG_SOUND_PRIME is not set
+CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
 
@@ -770,10 +726,7 @@ CONFIG_USB_HID=m
 #
 # CONFIG_USB_KBD is not set
 # CONFIG_USB_MOUSE is not set
-
-#
-# USB support
-#
+CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
@@ -803,6 +756,7 @@ CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_BIG_ENDIAN_MMIO=y
 CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
 
 #
 # USB Device Class drivers
@@ -879,31 +833,8 @@ CONFIG_USB_MON=y
 #
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
-
-#
-# LED devices
-#
 # CONFIG_NEW_LEDS is not set
-
-#
-# LED drivers
-#
-
-#
-# LED Triggers
-#
-
-#
-# InfiniBand support
-#
-
-#
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
-#
-
-#
-# Real Time Clock
-#
+# CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
 
 #
@@ -920,6 +851,11 @@ CONFIG_USB_MON=y
 #
 
 #
+# Userspace I/O
+#
+# CONFIG_UIO is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=m
@@ -948,8 +884,8 @@ CONFIG_QUOTA=y
 CONFIG_QFMT_V2=y
 CONFIG_QUOTACTL=y
 CONFIG_DNOTIFY=y
-# CONFIG_AUTOFS_FS is not set
-CONFIG_AUTOFS4_FS=y
+CONFIG_AUTOFS_FS=m
+CONFIG_AUTOFS4_FS=m
 # CONFIG_FUSE_FS is not set
 
 #
@@ -1030,7 +966,6 @@ CONFIG_CIFS=m
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -1096,6 +1031,7 @@ CONFIG_BITREVERSE=y
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
@@ -1120,6 +1056,7 @@ CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 # CONFIG_DEBUG_SHIRQ is not set
 CONFIG_DETECT_SOFTLOCKUP=y
+CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
 # CONFIG_DEBUG_SLAB is not set
@@ -1150,10 +1087,6 @@ CONFIG_IRQSTACKS=y
 #
 # CONFIG_KEYS is not set
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
 CONFIG_CRYPTO=y
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
@@ -1191,7 +1124,4 @@ CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_CRYPTO_HW=y

-- 
