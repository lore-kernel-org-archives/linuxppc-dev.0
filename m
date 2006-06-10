Return-Path: <anton@ozlabs.org>
Date: Sat, 10 Jun 2006 20:37:24 +1000
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Update pseries defconfig
Message-ID: <20060610103724.GL23891@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


pseries defconfig updates:

- Enable jsm and re-enable qlogic FC drivers as modules.
- Enable ocfs2, autofs4 and fuse filesystems as modules.
- Enable Kprobes.
- Enable ebus, binfmt_misc, sas attrs, md5 reshape, hvc rtas backend and
  some infiniband options.
- Finally disable debug options: DEBUG_MUTEXES and DEBUG_STACK_USAGE.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: build/arch/powerpc/configs/pseries_defconfig
===================================================================
--- build.orig/arch/powerpc/configs/pseries_defconfig	2006-05-28 07:36:12.000000000 +1000
+++ build/arch/powerpc/configs/pseries_defconfig	2006-05-28 07:36:31.000000000 +1000
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.17-rc1
-# Wed Apr 19 11:48:00 2006
+# Linux kernel version: 2.6.17-rc4
+# Sun May 28 07:26:56 2006
 #
 CONFIG_PPC64=y
 CONFIG_64BIT=y
@@ -11,6 +11,7 @@ CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
 CONFIG_COMPAT=y
@@ -126,8 +127,9 @@ CONFIG_RTAS_PROC=y
 CONFIG_RTAS_FLASH=m
 # CONFIG_MMIO_NVRAM is not set
 CONFIG_IBMVIO=y
-# CONFIG_IBMEBUS is not set
+CONFIG_IBMEBUS=y
 # CONFIG_PPC_MPC106 is not set
+# CONFIG_PPC_970_NAP is not set
 # CONFIG_CPU_FREQ is not set
 # CONFIG_WANT_EARLY_SERIAL is not set
 
@@ -143,7 +145,7 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT is not set
 # CONFIG_PREEMPT_BKL is not set
 CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
+CONFIG_BINFMT_MISC=m
 CONFIG_FORCE_MAX_ZONEORDER=13
 CONFIG_IOMMU_VMERGE=y
 CONFIG_HOTPLUG_CPU=y
@@ -155,6 +157,7 @@ CONFIG_EEH=y
 CONFIG_SCANLOG=m
 CONFIG_LPARCFG=y
 CONFIG_NUMA=y
+CONFIG_NODES_SHIFT=4
 CONFIG_ARCH_SELECT_MEMORY_MODEL=y
 CONFIG_ARCH_SPARSEMEM_ENABLE=y
 CONFIG_ARCH_SPARSEMEM_DEFAULT=y
@@ -467,7 +470,7 @@ CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SPI_ATTRS=y
 CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_ISCSI_ATTRS=m
-# CONFIG_SCSI_SAS_ATTRS is not set
+CONFIG_SCSI_SAS_ATTRS=m
 
 #
 # SCSI low-level drivers
@@ -499,13 +502,18 @@ CONFIG_SCSI_SYM53C8XX_2=y
 CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
 CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
 CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
-# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
+CONFIG_SCSI_SYM53C8XX_MMIO=y
 CONFIG_SCSI_IPR=y
 CONFIG_SCSI_IPR_TRACE=y
 CONFIG_SCSI_IPR_DUMP=y
-# CONFIG_SCSI_QLOGIC_FC is not set
 # CONFIG_SCSI_QLOGIC_1280 is not set
-# CONFIG_SCSI_QLA_FC is not set
+CONFIG_SCSI_QLA_FC=m
+CONFIG_SCSI_QLA2XXX_EMBEDDED_FIRMWARE=y
+CONFIG_SCSI_QLA21XX=m
+CONFIG_SCSI_QLA22XX=m
+CONFIG_SCSI_QLA2300=m
+CONFIG_SCSI_QLA2322=m
+CONFIG_SCSI_QLA24XX=m
 CONFIG_SCSI_LPFC=m
 # CONFIG_SCSI_DC395x is not set
 # CONFIG_SCSI_DC390T is not set
@@ -521,7 +529,7 @@ CONFIG_MD_RAID0=y
 CONFIG_MD_RAID1=y
 CONFIG_MD_RAID10=m
 CONFIG_MD_RAID5=y
-# CONFIG_MD_RAID5_RESHAPE is not set
+CONFIG_MD_RAID5_RESHAPE=y
 CONFIG_MD_RAID6=m
 CONFIG_MD_MULTIPATH=m
 CONFIG_MD_FAULTY=m
@@ -764,7 +772,7 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_SERIAL_ICOM=m
-# CONFIG_SERIAL_JSM is not set
+CONFIG_SERIAL_JSM=m
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -773,7 +781,7 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_TIPAR is not set
 CONFIG_HVC_DRIVER=y
 CONFIG_HVC_CONSOLE=y
-# CONFIG_HVC_RTAS is not set
+CONFIG_HVC_RTAS=y
 CONFIG_HVCS=m
 
 #
@@ -1031,9 +1039,7 @@ CONFIG_USB_HIDDEV=y
 # CONFIG_USB_ACECAD is not set
 # CONFIG_USB_KBTAB is not set
 # CONFIG_USB_POWERMATE is not set
-# CONFIG_USB_MTOUCH is not set
-# CONFIG_USB_ITMTOUCH is not set
-# CONFIG_USB_EGALAX is not set
+# CONFIG_USB_TOUCHSCREEN is not set
 # CONFIG_USB_YEALINK is not set
 # CONFIG_USB_XPAD is not set
 # CONFIG_USB_ATI_REMOTE is not set
@@ -1105,16 +1111,25 @@ CONFIG_USB_MON=y
 # CONFIG_NEW_LEDS is not set
 
 #
+# LED drivers
+#
+
+#
+# LED Triggers
+#
+
+#
 # InfiniBand support
 #
 CONFIG_INFINIBAND=m
-# CONFIG_INFINIBAND_USER_MAD is not set
-# CONFIG_INFINIBAND_USER_ACCESS is not set
+CONFIG_INFINIBAND_USER_MAD=m
+CONFIG_INFINIBAND_USER_ACCESS=m
 CONFIG_INFINIBAND_MTHCA=m
-# CONFIG_INFINIBAND_MTHCA_DEBUG is not set
+CONFIG_INFINIBAND_MTHCA_DEBUG=y
 CONFIG_INFINIBAND_IPOIB=m
-# CONFIG_INFINIBAND_IPOIB_DEBUG is not set
-# CONFIG_INFINIBAND_SRP is not set
+CONFIG_INFINIBAND_IPOIB_DEBUG=y
+# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
+CONFIG_INFINIBAND_SRP=m
 
 #
 # EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
@@ -1159,15 +1174,15 @@ CONFIG_XFS_EXPORT=y
 CONFIG_XFS_SECURITY=y
 CONFIG_XFS_POSIX_ACL=y
 # CONFIG_XFS_RT is not set
-# CONFIG_OCFS2_FS is not set
+CONFIG_OCFS2_FS=m
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
 CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
-CONFIG_AUTOFS_FS=m
-# CONFIG_AUTOFS4_FS is not set
-# CONFIG_FUSE_FS is not set
+# CONFIG_AUTOFS_FS is not set
+CONFIG_AUTOFS4_FS=m
+CONFIG_FUSE_FS=m
 
 #
 # CD-ROM/DVD Filesystems
@@ -1199,7 +1214,7 @@ CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 CONFIG_HUGETLB_PAGE=y
 CONFIG_RAMFS=y
-# CONFIG_CONFIGFS_FS is not set
+CONFIG_CONFIGFS_FS=m
 
 #
 # Miscellaneous filesystems
@@ -1317,7 +1332,7 @@ CONFIG_ZLIB_DEFLATE=m
 #
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
-# CONFIG_KPROBES is not set
+CONFIG_KPROBES=y
 
 #
 # Kernel hacking
@@ -1329,7 +1344,7 @@ CONFIG_LOG_BUF_SHIFT=17
 CONFIG_DETECT_SOFTLOCKUP=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_DEBUG_SLAB is not set
-CONFIG_DEBUG_MUTEXES=y
+# CONFIG_DEBUG_MUTEXES is not set
 # CONFIG_DEBUG_SPINLOCK is not set
 # CONFIG_DEBUG_SPINLOCK_SLEEP is not set
 # CONFIG_DEBUG_KOBJECT is not set
@@ -1339,17 +1354,13 @@ CONFIG_DEBUG_FS=y
 CONFIG_FORCED_INLINING=y
 # CONFIG_RCU_TORTURE_TEST is not set
 CONFIG_DEBUG_STACKOVERFLOW=y
-CONFIG_DEBUG_STACK_USAGE=y
+# CONFIG_DEBUG_STACK_USAGE is not set
 CONFIG_DEBUGGER=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_IRQSTACKS=y
 # CONFIG_BOOTX_TEXT is not set
-# CONFIG_PPC_EARLY_DEBUG_LPAR is not set
-# CONFIG_PPC_EARLY_DEBUG_G5 is not set
-# CONFIG_PPC_EARLY_DEBUG_RTAS is not set
-# CONFIG_PPC_EARLY_DEBUG_MAPLE is not set
-# CONFIG_PPC_EARLY_DEBUG_ISERIES is not set
+# CONFIG_PPC_EARLY_DEBUG is not set
 
 #
 # Security options
