Return-Path: <joel.stan@gmail.com>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DpZ81xhpzF0dq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Sep 2018 13:36:31 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id j26-v6so287854pfi.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Sep 2018 20:36:31 -0700 (PDT)
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
To: linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.ibm.com>
Subject: [PATCH v2] powerpc/configs: Update skiroot defconfig
Date: Tue, 18 Sep 2018 13:06:17 +0930
Message-Id: <20180918033617.15474-1-joel@jms.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Disable new features from recent releases, and clean out some other
unused options:

  - Enable EXPERT, so we can disable some things
  - Disable non-powerpc BPF decoders
  - Disable TASKSTATS
  - Disable unused syscalls
  - Set more things to be modules
  - Turn off unused network vendors
  - PPC_OF_BOOT_TRAMPOLINE and FB_OF are unused on powernv
  - Drop unused Radeon and Matrox GPU drivers
  - IPV6 support landed in petitboot
  - Bringup related command line powersave=off dropped, switch to quiet

Set CONFIG_I2C_CHARDEV=y as the module is not loaded automatically, and
without this i2cget etc. will fail in the skiroot environment.

This defconfig gets us build coverage of KERNEL_XZ, which was broken in
the 4.19 merge window for powerpc.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
v2: re-sync with version used in op-build
---
 arch/powerpc/configs/skiroot_defconfig | 154 +++++++++++++++++--------
 1 file changed, 108 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 6bd5e7261335..cfdd08897a06 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -3,20 +3,17 @@ CONFIG_ALTIVEC=y
 CONFIG_VSX=y
 CONFIG_NR_CPUS=2048
 CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_KERNEL_XZ=y
 # CONFIG_SWAP is not set
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 # CONFIG_CROSS_MEMORY_ATTACH is not set
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
-CONFIG_TASKSTATS=y
-CONFIG_TASK_DELAY_ACCT=y
-CONFIG_TASK_XACCT=y
-CONFIG_TASK_IO_ACCOUNTING=y
+# CONFIG_CPU_ISOLATION is not set
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=20
-CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_GZIP is not set
 # CONFIG_RD_BZIP2 is not set
@@ -24,8 +21,14 @@ CONFIG_BLK_DEV_INITRD=y
 # CONFIG_RD_LZO is not set
 # CONFIG_RD_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_EXPERT=y
+# CONFIG_SGETMASK_SYSCALL is not set
+# CONFIG_SYSFS_SYSCALL is not set
+# CONFIG_SHMEM is not set
+# CONFIG_AIO is not set
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
+CONFIG_SLAB_FREELIST_HARDENED=y
 CONFIG_JUMP_LABEL=y
 CONFIG_STRICT_KERNEL_RWX=y
 CONFIG_MODULES=y
@@ -35,7 +38,9 @@ CONFIG_MODULE_SIG_FORCE=y
 CONFIG_MODULE_SIG_SHA512=y
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_PPC_VAS is not set
 # CONFIG_PPC_PSERIES is not set
+# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
 CONFIG_CPU_IDLE=y
 CONFIG_HZ_100=y
@@ -48,8 +53,9 @@ CONFIG_NUMA=y
 CONFIG_PPC_64K_PAGES=y
 CONFIG_SCHED_SMT=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=tty0 console=hvc0 powersave=off"
+CONFIG_CMDLINE="console=tty0 console=hvc0 ipr.fast_reboot=1 quiet"
 # CONFIG_SECCOMP is not set
+# CONFIG_PPC_MEM_KEYS is not set
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -60,7 +66,6 @@ CONFIG_SYN_COOKIES=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_IPV6 is not set
 CONFIG_DNS_RESOLVER=y
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
@@ -73,8 +78,10 @@ CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=65536
 CONFIG_VIRTIO_BLK=m
 CONFIG_BLK_DEV_NVME=m
-CONFIG_EEPROM_AT24=y
+CONFIG_NVME_MULTIPATH=y
+CONFIG_EEPROM_AT24=m
 # CONFIG_CXL is not set
+# CONFIG_OCXL is not set
 CONFIG_BLK_DEV_SD=m
 CONFIG_BLK_DEV_SR=m
 CONFIG_BLK_DEV_SR_VENDOR=y
@@ -85,7 +92,6 @@ CONFIG_SCSI_FC_ATTRS=y
 CONFIG_SCSI_CXGB3_ISCSI=m
 CONFIG_SCSI_CXGB4_ISCSI=m
 CONFIG_SCSI_BNX2_ISCSI=m
-CONFIG_BE2ISCSI=m
 CONFIG_SCSI_AACRAID=m
 CONFIG_MEGARAID_NEWGEN=y
 CONFIG_MEGARAID_MM=m
@@ -102,7 +108,7 @@ CONFIG_SCSI_VIRTIO=m
 CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_ALUA=m
 CONFIG_ATA=y
-CONFIG_SATA_AHCI=y
+CONFIG_SATA_AHCI=m
 # CONFIG_ATA_SFF is not set
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=m
@@ -119,25 +125,72 @@ CONFIG_DM_SNAPSHOT=m
 CONFIG_DM_MIRROR=m
 CONFIG_DM_ZERO=m
 CONFIG_DM_MULTIPATH=m
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_VENDOR_ADAPTEC is not set
+# CONFIG_NET_VENDOR_AGERE is not set
+# CONFIG_NET_VENDOR_ALACRITECH is not set
 CONFIG_ACENIC=m
 CONFIG_ACENIC_OMIT_TIGON_I=y
-CONFIG_TIGON3=y
+# CONFIG_NET_VENDOR_AMAZON is not set
+# CONFIG_NET_VENDOR_AMD is not set
+# CONFIG_NET_VENDOR_AQUANTIA is not set
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ATHEROS is not set
+CONFIG_TIGON3=m
 CONFIG_BNX2X=m
-CONFIG_CHELSIO_T1=y
+# CONFIG_NET_VENDOR_BROCADE is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_CAVIUM is not set
+CONFIG_CHELSIO_T1=m
+# CONFIG_NET_VENDOR_CISCO is not set
+# CONFIG_NET_VENDOR_CORTINA is not set
+# CONFIG_NET_VENDOR_DEC is not set
+# CONFIG_NET_VENDOR_DLINK is not set
 CONFIG_BE2NET=m
-CONFIG_S2IO=m
-CONFIG_E100=m
+# CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_HP is not set
+# CONFIG_NET_VENDOR_HUAWEI is not set
 CONFIG_E1000=m
-CONFIG_E1000E=m
+CONFIG_IGB=m
 CONFIG_IXGB=m
 CONFIG_IXGBE=m
+CONFIG_I40E=m
+CONFIG_S2IO=m
+# CONFIG_NET_VENDOR_MARVELL is not set
 CONFIG_MLX4_EN=m
+# CONFIG_MLX4_CORE_GEN2 is not set
 CONFIG_MLX5_CORE=m
-CONFIG_MLX5_CORE_EN=y
+# CONFIG_NET_VENDOR_MICREL is not set
 CONFIG_MYRI10GE=m
+# CONFIG_NET_VENDOR_NATSEMI is not set
+# CONFIG_NET_VENDOR_NETRONOME is not set
+# CONFIG_NET_VENDOR_NI is not set
+# CONFIG_NET_VENDOR_NVIDIA is not set
+# CONFIG_NET_VENDOR_OKI is not set
+# CONFIG_NET_PACKET_ENGINE is not set
 CONFIG_QLGE=m
 CONFIG_NETXEN_NIC=m
+# CONFIG_NET_VENDOR_QUALCOMM is not set
+# CONFIG_NET_VENDOR_RDC is not set
+# CONFIG_NET_VENDOR_REALTEK is not set
+# CONFIG_NET_VENDOR_RENESAS is not set
+# CONFIG_NET_VENDOR_ROCKER is not set
+# CONFIG_NET_VENDOR_SAMSUNG is not set
+# CONFIG_NET_VENDOR_SEEQ is not set
 CONFIG_SFC=m
+# CONFIG_NET_VENDOR_SILAN is not set
+# CONFIG_NET_VENDOR_SIS is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_SOCIONEXT is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_SUN is not set
+# CONFIG_NET_VENDOR_SYNOPSYS is not set
+# CONFIG_NET_VENDOR_TEHUTI is not set
+# CONFIG_NET_VENDOR_TI is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
+# CONFIG_NET_VENDOR_XILINX is not set
+CONFIG_PHYLIB=y
 # CONFIG_USB_NET_DRIVERS is not set
 # CONFIG_WLAN is not set
 CONFIG_INPUT_EVDEV=y
@@ -149,39 +202,51 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_IPMI_HANDLER=y
 CONFIG_IPMI_DEVICE_INTERFACE=y
 CONFIG_IPMI_POWERNV=y
+CONFIG_IPMI_WATCHDOG=y
 CONFIG_HW_RANDOM=y
+CONFIG_TCG_TPM=y
 CONFIG_TCG_TIS_I2C_NUVOTON=y
+CONFIG_I2C=y
 # CONFIG_I2C_COMPAT is not set
 CONFIG_I2C_CHARDEV=y
 # CONFIG_I2C_HELPER_AUTO is not set
-CONFIG_DRM=y
-CONFIG_DRM_RADEON=y
+CONFIG_I2C_ALGOBIT=y
+CONFIG_I2C_OPAL=m
+CONFIG_PPS=y
+CONFIG_SENSORS_IBMPOWERNV=m
+CONFIG_DRM=m
 CONFIG_DRM_AST=m
+CONFIG_FB=y
 CONFIG_FIRMWARE_EDID=y
-CONFIG_FB_MODE_HELPERS=y
-CONFIG_FB_OF=y
-CONFIG_FB_MATROX=y
-CONFIG_FB_MATROX_MILLENIUM=y
-CONFIG_FB_MATROX_MYSTIQUE=y
-CONFIG_FB_MATROX_G=y
-# CONFIG_LCD_CLASS_DEVICE is not set
-# CONFIG_BACKLIGHT_GENERIC is not set
 # CONFIG_VGA_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_HID_GENERIC=m
+CONFIG_HID_A4TECH=y
+CONFIG_HID_BELKIN=y
+CONFIG_HID_CHERRY=y
+CONFIG_HID_CHICONY=y
+CONFIG_HID_CYPRESS=y
+CONFIG_HID_EZKEY=y
+CONFIG_HID_ITE=y
+CONFIG_HID_KENSINGTON=y
+CONFIG_HID_LOGITECH=y
+CONFIG_HID_MICROSOFT=y
+CONFIG_HID_MONTEREY=y
 CONFIG_USB_HIDDEV=y
-CONFIG_USB=y
-CONFIG_USB_MON=y
-CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_EHCI_HCD=y
+CONFIG_USB=m
+CONFIG_USB_XHCI_HCD=m
+CONFIG_USB_EHCI_HCD=m
 # CONFIG_USB_EHCI_HCD_PPC_OF is not set
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_STORAGE=y
+CONFIG_USB_OHCI_HCD=m
+CONFIG_USB_STORAGE=m
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_OPAL=m
 CONFIG_RTC_DRV_GENERIC=m
 CONFIG_VIRT_DRIVERS=y
-CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_PCI=m
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT4_FS=m
 CONFIG_EXT4_FS_POSIX_ACL=y
@@ -195,10 +260,9 @@ CONFIG_UDF_FS=m
 CONFIG_MSDOS_FS=m
 CONFIG_VFAT_FS=m
 CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_MISC_FILESYSTEMS is not set
 # CONFIG_NETWORK_FILESYSTEMS is not set
+CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
@@ -207,26 +271,24 @@ CONFIG_NLS_UTF8=y
 CONFIG_CRC16=y
 CONFIG_CRC_ITU_T=y
 CONFIG_LIBCRC32C=y
+# CONFIG_XZ_DEC_X86 is not set
+# CONFIG_XZ_DEC_IA64 is not set
+# CONFIG_XZ_DEC_ARM is not set
+# CONFIG_XZ_DEC_ARMTHUMB is not set
+# CONFIG_XZ_DEC_SPARC is not set
 CONFIG_PRINTK_TIME=y
 CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACKOVERFLOW=y
 CONFIG_SOFTLOCKUP_DETECTOR=y
+CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
 CONFIG_HARDLOCKUP_DETECTOR=y
 CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=y
-CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=y
 CONFIG_WQ_WATCHDOG=y
-CONFIG_SCHEDSTATS=y
+# CONFIG_SCHED_DEBUG is not set
 # CONFIG_FTRACE is not set
+# CONFIG_RUNTIME_TESTING_MENU is not set
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
-CONFIG_SECURITY=y
-CONFIG_IMA=y
-CONFIG_EVM=y
+CONFIG_ENCRYPTED_KEYS=y
 # CONFIG_CRYPTO_ECHAINIV is not set
-CONFIG_CRYPTO_ECB=y
-CONFIG_CRYPTO_CMAC=y
-CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_ARC4=y
-CONFIG_CRYPTO_DES=y
 # CONFIG_CRYPTO_HW is not set
-- 
2.17.1
