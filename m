Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id DBF22DDF39
	for <linuxppc-dev@ozlabs.org>; Tue,  1 May 2007 07:12:46 +1000 (EST)
Message-ID: <46365917.2050507@am.sony.com>
Date: Mon, 30 Apr 2007 14:01:11 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [patch 6/6] PS3: Defconfig updates
References: <20070430202420.872228544@am.sony.com>
In-Reply-To: <20070430202420.872228544@am.sony.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updates to ps3_defconfig for linux-2.6.21.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/configs/ps3_defconfig |  329 ++++++++++++++++++++++++++++---------
 1 file changed, 255 insertions(+), 74 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/configs/ps3_defconfig
+++ ps3-linux-dev/arch/powerpc/configs/ps3_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20-rc6
-# Thu Jan 25 13:35:34 2007
+# Linux kernel version: 2.6.21
+# Mon Apr 30 12:03:35 2007
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -60,6 +60,7 @@ CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_IPC_NS is not set
+CONFIG_SYSVIPC_SYSCTL=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
@@ -69,6 +70,7 @@ CONFIG_SYSVIPC=y
 # CONFIG_CPUSETS is not set
 CONFIG_SYSFS_DEPRECATED=y
 # CONFIG_RELAY is not set
+CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
@@ -131,13 +133,36 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_ISERIES is not set
 # CONFIG_PPC_MPC52xx is not set
+# CONFIG_PPC_MPC5200 is not set
 # CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_MAPLE is not set
 # CONFIG_PPC_PASEMI is not set
+# CONFIG_PPC_CELLEB is not set
+CONFIG_PPC_PS3=y
+
+#
+# PS3 Platform Options
+#
+# CONFIG_PS3_ADVANCED is not set
+CONFIG_PS3_HTAB_SIZE=20
+# CONFIG_PS3_DYNAMIC_DMA is not set
+CONFIG_PS3_USE_LPAR_ADDR=y
+CONFIG_PS3_VUART=y
+CONFIG_PS3_PS3AV=y
+CONFIG_PS3_SYS_MANAGER=y
 CONFIG_PPC_CELL=y
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PPC_IBM_CELL_BLADE is not set
-CONFIG_PPC_PS3=y
+
+#
+# Cell Broadband Engine options
+#
+CONFIG_SPU_FS=y
+CONFIG_SPU_BASE=y
+# CONFIG_PQ2ADS is not set
+# CONFIG_MPIC is not set
+# CONFIG_MPIC_WEIRD is not set
+# CONFIG_PPC_I8259 is not set
 # CONFIG_U3_DART is not set
 # CONFIG_PPC_RTAS is not set
 # CONFIG_MMIO_NVRAM is not set
@@ -146,24 +171,7 @@ CONFIG_PPC_PS3=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
-# CONFIG_WANT_EARLY_SERIAL is not set
-# CONFIG_MPIC is not set
-
-#
-# Cell Broadband Engine options
-#
-CONFIG_SPU_FS=y
-CONFIG_SPU_BASE=y
-# CONFIG_CBE_RAS is not set
-
-#
-# PS3 Platform Options
-#
-CONFIG_PS3_HTAB_SIZE=20
-# CONFIG_PS3_DYNAMIC_DMA is not set
-CONFIG_PS3_USE_LPAR_ADDR=y
-CONFIG_PS3_VUART=y
-CONFIG_PS3_PS3AV=y
+# CONFIG_CPM2 is not set
 
 #
 # Kernel options
@@ -179,10 +187,10 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_BKL is not set
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
-CONFIG_FORCE_MAX_ZONEORDER=9
+CONFIG_FORCE_MAX_ZONEORDER=13
 # CONFIG_IOMMU_VMERGE is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
-# CONFIG_KEXEC is not set
+CONFIG_KEXEC=y
 # CONFIG_CRASH_DUMP is not set
 # CONFIG_IRQ_ALL_CPUS is not set
 # CONFIG_NUMA is not set
@@ -203,22 +211,22 @@ CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTPLUG_SPARSE=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_RESOURCES_64BIT=y
+CONFIG_ZONE_DMA_FLAG=1
 CONFIG_ARCH_MEMORY_PROBE=y
-CONFIG_PPC_64K_PAGES=y
+# CONFIG_PPC_64K_PAGES is not set
 # CONFIG_SCHED_SMT is not set
 CONFIG_PROC_DEVICETREE=y
-CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="root=/dev/sda1 ip=dhcp"
+# CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
 # CONFIG_SECCOMP is not set
+# CONFIG_WANT_DEVICE_TREE is not set
 CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
+CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
-# CONFIG_MPIC_WEIRD is not set
-# CONFIG_PPC_I8259 is not set
 # CONFIG_PCI is not set
 # CONFIG_PCI_DOMAINS is not set
 
@@ -240,10 +248,13 @@ CONFIG_NET=y
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
 CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
+CONFIG_XFRM=y
+# CONFIG_XFRM_USER is not set
+# CONFIG_XFRM_SUB_POLICY is not set
+# CONFIG_XFRM_MIGRATE is not set
 # CONFIG_NET_KEY is not set
 CONFIG_INET=y
 # CONFIG_IP_MULTICAST is not set
@@ -261,7 +272,7 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_ESP is not set
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
-# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_TUNNEL=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
@@ -270,9 +281,23 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
-# CONFIG_IPV6 is not set
+CONFIG_IPV6=y
+# CONFIG_IPV6_PRIVACY is not set
+# CONFIG_IPV6_ROUTER_PREF is not set
+# CONFIG_IPV6_OPTIMISTIC_DAD is not set
+# CONFIG_INET6_AH is not set
+# CONFIG_INET6_ESP is not set
+# CONFIG_INET6_IPCOMP is not set
+# CONFIG_IPV6_MIP6 is not set
 # CONFIG_INET6_XFRM_TUNNEL is not set
 # CONFIG_INET6_TUNNEL is not set
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
+CONFIG_IPV6_SIT=y
+# CONFIG_IPV6_TUNNEL is not set
+# CONFIG_IPV6_MULTIPLE_TABLES is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 
@@ -313,7 +338,31 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
 # CONFIG_IRDA is not set
-# CONFIG_BT is not set
+CONFIG_BT=m
+CONFIG_BT_L2CAP=m
+CONFIG_BT_SCO=m
+CONFIG_BT_RFCOMM=m
+# CONFIG_BT_RFCOMM_TTY is not set
+# CONFIG_BT_BNEP is not set
+CONFIG_BT_HIDP=m
+
+#
+# Bluetooth device drivers
+#
+CONFIG_BT_HCIUSB=m
+CONFIG_BT_HCIUSB_SCO=y
+# CONFIG_BT_HCIUART is not set
+# CONFIG_BT_HCIBCM203X is not set
+# CONFIG_BT_HCIBPA10X is not set
+# CONFIG_BT_HCIBFUSB is not set
+# CONFIG_BT_HCIVHCI is not set
+# CONFIG_AF_RXRPC is not set
+
+#
+# Wireless
+#
+# CONFIG_CFG80211 is not set
+CONFIG_WIRELESS_EXT=y
 # CONFIG_IEEE80211 is not set
 
 #
@@ -327,16 +376,13 @@ CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 # CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 
 #
 # Connector - unified userspace <-> kernelspace linker
 #
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 # CONFIG_MTD is not set
 
 #
@@ -347,24 +393,27 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 #
 # Plug and Play support
 #
+# CONFIG_PNPACPI is not set
 
 #
 # Block devices
 #
 # CONFIG_BLK_DEV_FD is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
-# CONFIG_BLK_DEV_LOOP is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_UB is not set
-# CONFIG_BLK_DEV_RAM is not set
-# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
+CONFIG_BLK_DEV_RAM_SIZE=65535
+CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 
 #
 # Misc devices
 #
-# CONFIG_TIFM_CORE is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -388,7 +437,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_CHR_DEV_OSST is not set
 CONFIG_BLK_DEV_SR=y
 # CONFIG_BLK_DEV_SR_VENDOR is not set
-# CONFIG_CHR_DEV_SG is not set
+CONFIG_CHR_DEV_SG=m
 # CONFIG_CHR_DEV_SCH is not set
 
 #
@@ -413,6 +462,7 @@ CONFIG_BLK_DEV_SR=y
 #
 # CONFIG_ISCSI_TCP is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_ESP_CORE is not set
 
 #
 # Serial ATA (prod) and Parallel ATA (experimental) drivers
@@ -460,7 +510,7 @@ CONFIG_NETDEVICES=y
 # Ethernet (10 or 100Mbit)
 #
 # CONFIG_NET_ETHERNET is not set
-CONFIG_MII=y
+CONFIG_MII=m
 
 #
 # Ethernet (1000 Mbit)
@@ -475,9 +525,10 @@ CONFIG_MII=y
 #
 
 #
-# Wireless LAN (non-hamradio)
+# Wireless LAN
 #
-# CONFIG_NET_RADIO is not set
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 
 #
 # Wan interfaces
@@ -551,7 +602,8 @@ CONFIG_HW_CONSOLE=y
 # Non-8250 serial port support
 #
 CONFIG_UNIX98_PTYS=y
-# CONFIG_LEGACY_PTYS is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=16
 
 #
 # IPMI
@@ -598,6 +650,11 @@ CONFIG_GEN_RTC=y
 # CONFIG_HWMON_VID is not set
 
 #
+# Multifunction device drivers
+#
+# CONFIG_MFD_SM501 is not set
+
+#
 # Multimedia devices
 #
 # CONFIG_VIDEO_DEV is not set
@@ -611,15 +668,22 @@ CONFIG_GEN_RTC=y
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
 # CONFIG_FB_OF is not set
 # CONFIG_FB_VGA16 is not set
 # CONFIG_FB_S1D13XXX is not set
@@ -634,7 +698,7 @@ CONFIG_FB_PS3_DEFAULT_SIZE_M=18
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
 # CONFIG_FONTS is not set
 CONFIG_FONT_8x8=y
 CONFIG_FONT_8x16=y
@@ -646,17 +710,62 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
 #
-# CONFIG_SOUND is not set
+CONFIG_SOUND=y
+
+#
+# Advanced Linux Sound Architecture
+#
+CONFIG_SND=y
+# CONFIG_SND_SEQUENCER is not set
+# CONFIG_SND_MIXER_OSS is not set
+# CONFIG_SND_PCM_OSS is not set
+# CONFIG_SND_DYNAMIC_MINORS is not set
+CONFIG_SND_SUPPORT_OLD_API=y
+CONFIG_SND_VERBOSE_PROCFS=y
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+
+#
+# Generic devices
+#
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+
+#
+# ALSA PowerMac devices
+#
+
+#
+# ALSA PowerMac requires I2C
+#
+
+#
+# USB devices
+#
+# CONFIG_SND_USB_AUDIO is not set
+# CONFIG_SND_USB_USX2Y is not set
+
+#
+# SoC audio support
+#
+# CONFIG_SND_SOC is not set
+
+#
+# Open Sound System
+#
+# CONFIG_SOUND_PRIME is not set
 
 #
 # HID Devices
 #
 CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
 
 #
 # USB support
@@ -665,13 +774,13 @@ CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
-CONFIG_USB_DEBUG=y
+# CONFIG_USB_DEBUG is not set
 
 #
 # Miscellaneous USB options
 #
-# CONFIG_USB_DEVICEFS is not set
-# CONFIG_USB_BANDWIDTH is not set
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_DEVICE_CLASS is not set
 # CONFIG_USB_DYNAMIC_MINORS is not set
 # CONFIG_USB_OTG is not set
 
@@ -704,7 +813,7 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 #
 # may also be needed; see USB_STORAGE Help for more information
 #
-CONFIG_USB_STORAGE=y
+CONFIG_USB_STORAGE=m
 # CONFIG_USB_STORAGE_DEBUG is not set
 # CONFIG_USB_STORAGE_DATAFAB is not set
 # CONFIG_USB_STORAGE_FREECOM is not set
@@ -720,10 +829,16 @@ CONFIG_USB_STORAGE=y
 #
 # USB Input Devices
 #
-CONFIG_USB_HID=y
+CONFIG_USB_HID=m
 # CONFIG_USB_HIDINPUT_POWERBOOK is not set
 # CONFIG_HID_FF is not set
 # CONFIG_USB_HIDDEV is not set
+
+#
+# USB HID Boot Protocol drivers
+#
+# CONFIG_USB_KBD is not set
+# CONFIG_USB_MOUSE is not set
 # CONFIG_USB_AIPTEK is not set
 # CONFIG_USB_WACOM is not set
 # CONFIG_USB_ACECAD is not set
@@ -736,6 +851,7 @@ CONFIG_USB_HID=y
 # CONFIG_USB_ATI_REMOTE2 is not set
 # CONFIG_USB_KEYSPAN_REMOTE is not set
 # CONFIG_USB_APPLETOUCH is not set
+# CONFIG_USB_GTCO is not set
 
 #
 # USB Imaging devices
@@ -748,15 +864,16 @@ CONFIG_USB_HID=y
 #
 # CONFIG_USB_CATC is not set
 # CONFIG_USB_KAWETH is not set
-# CONFIG_USB_PEGASUS is not set
+CONFIG_USB_PEGASUS=m
 # CONFIG_USB_RTL8150 is not set
-CONFIG_USB_USBNET_MII=y
-CONFIG_USB_USBNET=y
-CONFIG_USB_NET_CDCETHER=y
+CONFIG_USB_USBNET_MII=m
+CONFIG_USB_USBNET=m
+# CONFIG_USB_NET_CDCETHER is not set
+# CONFIG_USB_NET_DM9601 is not set
 # CONFIG_USB_NET_GL620A is not set
 # CONFIG_USB_NET_NET1080 is not set
 # CONFIG_USB_NET_PLUSB is not set
-CONFIG_USB_NET_MCS7830=y
+CONFIG_USB_NET_MCS7830=m
 # CONFIG_USB_NET_RNDIS_HOST is not set
 # CONFIG_USB_NET_CDC_SUBSET is not set
 # CONFIG_USB_NET_ZAURUS is not set
@@ -781,6 +898,7 @@ CONFIG_USB_MON=y
 # CONFIG_USB_RIO500 is not set
 # CONFIG_USB_LEGOTOWER is not set
 # CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
 # CONFIG_USB_LED is not set
 # CONFIG_USB_CYPRESS_CY7C63 is not set
 # CONFIG_USB_CYTHERM is not set
@@ -791,6 +909,8 @@ CONFIG_USB_MON=y
 # CONFIG_USB_SISUSBVGA is not set
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
 
 #
 # USB DSL modem support
@@ -846,13 +966,19 @@ CONFIG_USB_MON=y
 #
 
 #
+# Auxiliary Display support
+#
+
+#
 # Virtualization
 #
 
 #
 # File systems
 #
-# CONFIG_EXT2_FS is not set
+CONFIG_EXT2_FS=m
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
@@ -871,27 +997,30 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
-# CONFIG_QUOTA is not set
+CONFIG_QUOTA=y
+# CONFIG_QFMT_V1 is not set
+CONFIG_QFMT_V2=y
+CONFIG_QUOTACTL=y
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
-# CONFIG_AUTOFS4_FS is not set
+CONFIG_AUTOFS4_FS=y
 # CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
 #
-CONFIG_ISO9660_FS=y
+CONFIG_ISO9660_FS=m
 CONFIG_JOLIET=y
 # CONFIG_ZISOFS is not set
-CONFIG_UDF_FS=y
+CONFIG_UDF_FS=m
 CONFIG_UDF_NLS=y
 
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=y
+CONFIG_FAT_FS=m
 # CONFIG_MSDOS_FS is not set
-CONFIG_VFAT_FS=y
+CONFIG_VFAT_FS=m
 CONFIG_FAT_DEFAULT_CODEPAGE=437
 CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
@@ -933,7 +1062,7 @@ CONFIG_RAMFS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
-# CONFIG_NFS_V4 is not set
+CONFIG_NFS_V4=y
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
@@ -941,10 +1070,16 @@ CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
 CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
-# CONFIG_RPCSEC_GSS_KRB5 is not set
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
 # CONFIG_SMB_FS is not set
-# CONFIG_CIFS is not set
+CONFIG_CIFS=m
+# CONFIG_CIFS_STATS is not set
+# CONFIG_CIFS_WEAK_PW_HASH is not set
+# CONFIG_CIFS_XATTR is not set
+# CONFIG_CIFS_DEBUG2 is not set
+# CONFIG_CIFS_EXPERIMENTAL is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
@@ -1004,6 +1139,8 @@ CONFIG_NLS_ISO8859_1=y
 # Distributed Lock Manager
 #
 # CONFIG_DLM is not set
+# CONFIG_UCC_SLOW is not set
+# CONFIG_UCC_FAST is not set
 
 #
 # Library routines
@@ -1014,7 +1151,8 @@ CONFIG_BITREVERSE=y
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 CONFIG_PLIST=y
-CONFIG_IOMAP_COPY=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
 
 #
 # Instrumentation Support
@@ -1032,16 +1170,16 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
 CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
 CONFIG_LOG_BUF_SHIFT=17
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
-CONFIG_DEBUG_SLAB=y
-# CONFIG_DEBUG_SLAB_LEAK is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_SLAB is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
 # CONFIG_RT_MUTEX_TESTER is not set
 CONFIG_DEBUG_SPINLOCK=y
 CONFIG_DEBUG_MUTEXES=y
-CONFIG_DEBUG_RWSEMS=y
 CONFIG_DEBUG_SPINLOCK_SLEEP=y
 # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1051,8 +1189,10 @@ CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_LIST=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_FAULT_INJECTION is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_DEBUGGER is not set
 CONFIG_IRQSTACKS=y
 # CONFIG_BOOTX_TEXT is not set
@@ -1063,6 +1203,8 @@ CONFIG_PPC_EARLY_DEBUG=y
 # CONFIG_PPC_EARLY_DEBUG_RTAS_CONSOLE is not set
 # CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
 # CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+# CONFIG_PPC_EARLY_DEBUG_PAS_REALMODE is not set
+# CONFIG_PPC_EARLY_DEBUG_BEAT is not set
 
 #
 # Security options
@@ -1073,4 +1215,43 @@ CONFIG_PPC_EARLY_DEBUG=y
 #
 # Cryptographic options
 #
-# CONFIG_CRYPTO is not set
+CONFIG_CRYPTO=y
+CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_XCBC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+# CONFIG_CRYPTO_WP512 is not set
+# CONFIG_CRYPTO_TGR192 is not set
+# CONFIG_CRYPTO_GF128MUL is not set
+CONFIG_CRYPTO_ECB=m
+CONFIG_CRYPTO_CBC=y
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_LRW is not set
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
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Hardware crypto devices
+#

-- 
