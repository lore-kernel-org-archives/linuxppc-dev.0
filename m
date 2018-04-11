Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LdcY3LgMzDqyW
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 19:13:17 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id f4so489378pgs.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 02:13:17 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2] powerpc/config: powernv_defconfig updates
Date: Wed, 11 Apr 2018 19:12:03 +1000
Message-Id: <20180411091203.28141-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For consideration:

* Add IPv6 support built in + additional modules - Because it's 2018 maan.
* Add DEFERRED_STRUCT_PAGE_INIT - Let's see what breaks.
* Add PPC_MEMTRACE - Small powernv debugfs driver for getting hardware traces.
* Add MEMORY_FAILURE - Machine check exceptions can now drive memory failure.
* Turn on FANOTIFY - This is the current filesystem notification feature.
* Turn on SCOM_DEBUGFS - Handy for hardware/firmware debugging, security risk?
* Turn on async SCSI scanning - Let's see what breaks.

* Make a bunch of USB hid drivers modules.
* Make SCSI SG, SR, and FC modules - FC is huge.
* Make video drivers (except AST GPU) modules - Also huge.
* Add MLX5 driver as a module - Popular demand.
* Make PCI serial driver a module - Uncommon?

* Get rid of /dev/port - Not used.
* Remove legacy BSD ttys - Long dead.
* Remove IDE - Deprecated and replaced with ATA.
* Remove WIRELESS - Until we get POWER9 laptops.
* Remove RAW - Long deprecated in favour of direct IO.
* Remove floppy, parport, and PS2 input devices - not supported.
* Remove virtio drivers, ballooning - We're host only.
* Remove PPP - Sorry Paulus.
* Make more things modules, NFS FS, RAM disk, netconsole, MS-DOS fs.

This does not disable FTRACE options, that's just an optimisation the
defconfig target made. make powernv_defconfig adds those to .config.

This results in a significantly smaller vmlinux:

   text	   data	    bss	    dec	    hex	filename
13121779	5284224	1383776	19789779	12df7d3	vmlinux
12126273	4771930	1341464	18239667	11650b3	vmlinux

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v1:
- Imagine the "I have no idea what I'm doing" scientist dog meme.
 
 arch/powerpc/configs/powernv_defconfig | 105 +++++++++++++++----------
 1 file changed, 62 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 9e92aa6a52ba..371169362683 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -38,7 +38,9 @@ CONFIG_MODULE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PARTITION_ADVANCED=y
+CONFIG_SCOM_DEBUGFS=y
 CONFIG_OPAL_PRD=y
+CONFIG_PPC_MEMTRACE=y
 # CONFIG_PPC_PSERIES is not set
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
@@ -54,7 +56,10 @@ CONFIG_NUMA=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
+CONFIG_MEMORY_FAILURE=y
+CONFIG_HWPOISON_INJECT=m
 CONFIG_TRANSPARENT_HUGEPAGE=y
+CONFIG_DEFERRED_STRUCT_PAGE_INIT=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_PPC_SUBPAGE_PROT=y
 CONFIG_SCHED_SMT=y
@@ -72,7 +77,13 @@ CONFIG_SYN_COOKIES=y
 CONFIG_INET_AH=m
 CONFIG_INET_ESP=m
 CONFIG_INET_IPCOMP=m
-# CONFIG_IPV6 is not set
+CONFIG_INET6_AH=m
+CONFIG_INET6_ESP=m
+CONFIG_INET6_IPCOMP=m
+CONFIG_INET6_XFRM_MODE_TRANSPORT=m
+CONFIG_INET6_XFRM_MODE_TUNNEL=m
+CONFIG_INET6_XFRM_MODE_BEET=m
+CONFIG_IPV6_SIT=m
 CONFIG_NETFILTER=y
 # CONFIG_NETFILTER_ADVANCED is not set
 CONFIG_BRIDGE=m
@@ -81,33 +92,28 @@ CONFIG_NET_SCHED=y
 CONFIG_NET_CLS_BPF=m
 CONFIG_NET_CLS_ACT=y
 CONFIG_NET_ACT_BPF=m
+CONFIG_DNS_RESOLVER=y
 CONFIG_BPF_JIT=y
+# CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_POWERNV_FLASH=y
-CONFIG_PARPORT=m
-CONFIG_PARPORT_PC=m
-CONFIG_BLK_DEV_FD=m
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_NBD=m
-CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM=m
 CONFIG_BLK_DEV_RAM_SIZE=65536
-CONFIG_VIRTIO_BLK=m
 CONFIG_BLK_DEV_NVME=y
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECD=y
-CONFIG_BLK_DEV_GENERIC=y
-CONFIG_BLK_DEV_AMD74XX=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_CHR_DEV_ST=m
-CONFIG_BLK_DEV_SR=y
+CONFIG_BLK_DEV_SR=m
 CONFIG_BLK_DEV_SR_VENDOR=y
-CONFIG_CHR_DEV_SG=y
+CONFIG_CHR_DEV_SG=m
 CONFIG_SCSI_CONSTANTS=y
-CONFIG_SCSI_FC_ATTRS=y
+CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_SCSI_FC_ATTRS=m
 CONFIG_SCSI_SRP_ATTRS=y
 CONFIG_SCSI_CXGB3_ISCSI=m
 CONFIG_SCSI_CXGB4_ISCSI=m
@@ -121,7 +127,6 @@ CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
 CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
-CONFIG_SCSI_VIRTIO=m
 CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
@@ -152,16 +157,16 @@ CONFIG_DUMMY=m
 CONFIG_MACVLAN=m
 CONFIG_MACVTAP=m
 CONFIG_VXLAN=m
-CONFIG_NETCONSOLE=y
+CONFIG_NETCONSOLE=m
 CONFIG_TUN=m
 CONFIG_VETH=m
-CONFIG_VIRTIO_NET=m
 CONFIG_VORTEX=m
 CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
 CONFIG_PCNET32=m
 CONFIG_TIGON3=y
 CONFIG_BNX2X=m
+# CONFIG_CAVIUM_PTP is not set
 CONFIG_CHELSIO_T1=m
 CONFIG_BE2NET=m
 CONFIG_S2IO=m
@@ -172,46 +177,62 @@ CONFIG_IXGB=m
 CONFIG_IXGBE=m
 CONFIG_I40E=m
 CONFIG_MLX4_EN=m
+CONFIG_MLX5_CORE=m
+CONFIG_MLX5_FPGA=y
+CONFIG_MLX5_CORE_EN=y
+CONFIG_MLX5_CORE_IPOIB=y
 CONFIG_MYRI10GE=m
 CONFIG_QLGE=m
 CONFIG_NETXEN_NIC=m
-CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPPOE=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
+CONFIG_USB_NET_DRIVERS=m
+# CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=m
-CONFIG_INPUT_MISC=y
-# CONFIG_SERIO_SERPORT is not set
+# CONFIG_INPUT_KEYBOARD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_SERIO is not set
+# CONFIG_LEGACY_PTYS is not set
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_PCI=m
 CONFIG_SERIAL_JSM=m
-CONFIG_VIRTIO_CONSOLE=m
 CONFIG_IPMI_HANDLER=y
 CONFIG_IPMI_DEVICE_INTERFACE=y
 CONFIG_IPMI_POWERNV=y
-CONFIG_RAW_DRIVER=y
-CONFIG_MAX_RAW_DEVS=1024
+# CONFIG_DEVPORT is not set
 CONFIG_I2C_CHARDEV=y
+# CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=y
 CONFIG_DRM_AST=y
 CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_OF=y
-CONFIG_FB_MATROX=y
+CONFIG_FB_MATROX=m
 CONFIG_FB_MATROX_MILLENIUM=y
 CONFIG_FB_MATROX_MYSTIQUE=y
 CONFIG_FB_MATROX_G=y
-CONFIG_FB_RADEON=y
-CONFIG_FB_IBM_GXT4500=y
+CONFIG_FB_RADEON=m
+CONFIG_FB_IBM_GXT4500=m
 CONFIG_LCD_PLATFORM=m
+CONFIG_BACKLIGHT_GENERIC=m
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_LOGO=y
-CONFIG_HID_GYRATION=y
-CONFIG_HID_PANTHERLORD=y
-CONFIG_HID_PETALYNX=y
-CONFIG_HID_SAMSUNG=y
-CONFIG_HID_SUNPLUS=y
+CONFIG_HID_A4TECH=m
+CONFIG_HID_APPLE=m
+CONFIG_HID_BELKIN=m
+CONFIG_HID_CHERRY=m
+CONFIG_HID_CHICONY=m
+CONFIG_HID_CYPRESS=m
+CONFIG_HID_EZKEY=m
+CONFIG_HID_GYRATION=m
+CONFIG_HID_ITE=m
+CONFIG_HID_KENSINGTON=m
+CONFIG_HID_LOGITECH=m
+CONFIG_HID_MICROSOFT=m
+CONFIG_HID_MONTEREY=m
+CONFIG_HID_PANTHERLORD=m
+CONFIG_HID_PETALYNX=m
+CONFIG_HID_SAMSUNG=m
+CONFIG_HID_SUNPLUS=m
+CONFIG_USB_HID=m
 CONFIG_USB_HIDDEV=y
 CONFIG_USB=y
 CONFIG_USB_MON=m
@@ -219,6 +240,7 @@ CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_HCD_PPC_OF is not set
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PCI=m
 CONFIG_USB_STORAGE=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
@@ -236,8 +258,7 @@ CONFIG_INFINIBAND_SRP=m
 CONFIG_INFINIBAND_ISER=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
-CONFIG_VIRTIO_PCI=m
-CONFIG_VIRTIO_BALLOON=m
+# CONFIG_VIRTIO_MENU is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -253,12 +274,13 @@ CONFIG_XFS_POSIX_ACL=y
 CONFIG_BTRFS_FS=m
 CONFIG_BTRFS_FS_POSIX_ACL=y
 CONFIG_NILFS2_FS=m
+CONFIG_FANOTIFY=y
 CONFIG_AUTOFS4_FS=m
 CONFIG_FUSE_FS=m
 CONFIG_OVERLAY_FS=m
 CONFIG_ISO9660_FS=y
 CONFIG_UDF_FS=m
-CONFIG_MSDOS_FS=y
+CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
@@ -270,9 +292,9 @@ CONFIG_SQUASHFS_XATTR=y
 CONFIG_SQUASHFS_LZO=y
 CONFIG_SQUASHFS_XZ=y
 CONFIG_PSTORE=y
-CONFIG_NFS_FS=y
+CONFIG_NFS_FS=m
 CONFIG_NFS_V3_ACL=y
-CONFIG_NFS_V4=y
+CONFIG_NFS_V4=m
 CONFIG_NFSD=m
 CONFIG_NFSD_V3_ACL=y
 CONFIG_NFSD_V4=y
@@ -291,9 +313,7 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_LATENCYTOP=y
-CONFIG_FTRACE=y
 CONFIG_FUNCTION_TRACER=y
-CONFIG_FUNCTION_GRAPH_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
@@ -303,7 +323,6 @@ CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
 CONFIG_CRYPTO_TEST=m
-CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_CRC32C_VPMSUM=m
-- 
2.17.0
