Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x241.google.com (mail-pl0-x241.google.com
 [IPv6:2607:f8b0:400e:c01::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40LZxC4Zv7zF1Qh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 17:12:30 +1000 (AEST)
Received: by mail-pl0-x241.google.com with SMTP id 91-v6so715525pld.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Apr 2018 00:12:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/config: powernv_defconfig updates
Date: Wed, 11 Apr 2018 17:12:12 +1000
Message-Id: <20180411071212.27546-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For consideration
* Add PPC_MEMTRACE - Small powernv debugfs driver for getting hardware traces.
* Remove IDE - Deprecated and replaced with ATA.
* Add MEMORY_FAILURE - Machine check exceptions can now drive memory failure.
* Turn on FANOTIFY - This is the current filesystem notification feature.
* Turn on SCOM_DEBUGFS - Handy for hardware/firmware debugging, security risk?
* Remove WIRELESS - We had no drivers included for it.
* Remove RAW - Long deprecated in favour of direct IO.
* Remove floppy, parport, and PS2 input devices - not supported.
* Turn on async SCSI scanning - Let's see what breaks.
* Remove virtio drivers - We're host only.
* Remove PPP - Sorry Paulus.
* Make more things modules, NFS FS, RAM disk, netconsole, MS-DOS fs.

This does not disable FTRACE options, that's just an optimisation the
defconfig target made. make powernv_defconfig adds those to .config.

This results in a significantly smaller vmlinux:

   text	   data	    bss	    dec	    hex	filename
13121779	5284224	1383776	19789779	12df7d3	vmlinux
12067564	4830754	1336008	18234326	1163bd6	vmlinux.patched

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/configs/powernv_defconfig | 52 +++++++++++---------------
 1 file changed, 21 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 9e92aa6a52ba..11af6f5f236b 100644
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
@@ -54,6 +56,8 @@ CONFIG_NUMA=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
 CONFIG_KSM=y
+CONFIG_MEMORY_FAILURE=y
+CONFIG_HWPOISON_INJECT=m
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_PPC_SUBPAGE_PROT=y
@@ -81,32 +85,27 @@ CONFIG_NET_SCHED=y
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
 CONFIG_BLK_DEV_SR=y
 CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_CONSTANTS=y
+CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_SRP_ATTRS=y
 CONFIG_SCSI_CXGB3_ISCSI=m
@@ -121,7 +120,6 @@ CONFIG_SCSI_IPR=y
 CONFIG_SCSI_QLA_FC=m
 CONFIG_SCSI_QLA_ISCSI=m
 CONFIG_SCSI_LPFC=m
-CONFIG_SCSI_VIRTIO=m
 CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_ALUA=m
@@ -152,10 +150,9 @@ CONFIG_DUMMY=m
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
@@ -175,25 +172,21 @@ CONFIG_MLX4_EN=m
 CONFIG_MYRI10GE=m
 CONFIG_QLGE=m
 CONFIG_NETXEN_NIC=m
-CONFIG_PPP=m
-CONFIG_PPP_BSDCOMP=m
-CONFIG_PPP_DEFLATE=m
-CONFIG_PPPOE=m
-CONFIG_PPP_ASYNC=m
-CONFIG_PPP_SYNC_TTY=m
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
@@ -236,8 +229,7 @@ CONFIG_INFINIBAND_SRP=m
 CONFIG_INFINIBAND_ISER=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_GENERIC=y
-CONFIG_VIRTIO_PCI=m
-CONFIG_VIRTIO_BALLOON=m
+# CONFIG_VIRTIO_MENU is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
@@ -253,12 +245,13 @@ CONFIG_XFS_POSIX_ACL=y
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
@@ -270,9 +263,9 @@ CONFIG_SQUASHFS_XATTR=y
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
@@ -291,9 +284,7 @@ CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
 CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_LATENCYTOP=y
-CONFIG_FTRACE=y
 CONFIG_FUNCTION_TRACER=y
-CONFIG_FUNCTION_GRAPH_TRACER=y
 CONFIG_SCHED_TRACER=y
 CONFIG_FTRACE_SYSCALLS=y
 CONFIG_BLK_DEV_IO_TRACE=y
@@ -303,7 +294,6 @@ CONFIG_FTR_FIXUP_SELFTEST=y
 CONFIG_MSI_BITMAP_SELFTEST=y
 CONFIG_XMON=y
 CONFIG_CRYPTO_TEST=m
-CONFIG_CRYPTO_CCM=m
 CONFIG_CRYPTO_PCBC=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_CRC32C_VPMSUM=m
-- 
2.17.0
