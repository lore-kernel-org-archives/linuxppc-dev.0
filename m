Return-Path: <Lijun.Pan@freescale.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8D01B1A04C5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2015 13:10:19 +1000 (AEST)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bn0108.outbound.protection.outlook.com [157.56.110.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48699140290
 for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2015 13:10:16 +1000 (AEST)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
CC: Lijun Pan <Lijun.Pan@freescale.com>
Subject: [PATCH v4] powerpc/defconfig: new way of writing defconfig
Date: Fri, 12 Jun 2015 21:52:12 -0500
Message-ID: <1434163932-32741-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is always a headache dealing with different defconfigs
though they only differ in a few places. Hence we are proposing a new
way of writing the defconfig:
1. Define a basic defconfig say mpc85xx_basic_defconfig
2. Spin off as much features as possible from the current mpc85xx_defconfig
	and create a separate config file, say, smp.config, kvm_500.config
Every time we add a new feature, we don't need to change several
defconfigs, we just add a new *.config
And you could merge any fragments you want into .config with the
current kconfig in Kernel.

With the new rules added into arch/powerpc/Makefile,
you can make it like before, e.g.
make mpc85xx_smp_defconfig

In order to keep the final .config the same as before,
we must first merge all the fragments (without make) repeatedly,
and at last do "make" only once.

The make steps below will generate a different .config as above.
We should not take the following steps.
e.g.
make mpc85xx_basic_defconfig
make smp.config
make kvm_guest.config

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
v4 changes:
 1. removed many fragments according to the review feedback in v3
 2. I cannot reuse the code in http://patchwork.ozlabs.org/patch/476345/ 
    since I have multiple fragments to merge while the that patch only
    has one fragment.

v3 changes:
 http://patchwork.ozlabs.org/patch/471126/

 arch/powerpc/Makefile                              |  34 +++
 arch/powerpc/configs/altivec.config                |   1 +
 arch/powerpc/configs/book3e-64.config              |   2 +
 arch/powerpc/configs/corenet32_misc.config         |  35 +++
 arch/powerpc/configs/corenet32_smp_defconfig       | 185 ---------------
 arch/powerpc/configs/corenet64_misc.config         |  16 ++
 ...net64_smp_defconfig => corenet_basic_defconfig} |  29 +--
 arch/powerpc/configs/dma.config                    |   2 +
 arch/powerpc/configs/kvm_guest.config              |   2 +
 arch/powerpc/configs/math_emulation.config         |   2 +
 arch/powerpc/configs/mpc85xx.config                |   1 +
 ...c85xx_smp_defconfig => mpc85xx_basic_defconfig} |   8 +-
 arch/powerpc/configs/mpc85xx_defconfig             | 252 ---------------------
 arch/powerpc/configs/mpc85xx_misc.config           |  11 +
 arch/powerpc/configs/non-hardware.config           |   4 +
 arch/powerpc/configs/smp.config                    |   1 +
 16 files changed, 116 insertions(+), 469 deletions(-)
 create mode 100644 arch/powerpc/configs/altivec.config
 create mode 100644 arch/powerpc/configs/book3e-64.config
 create mode 100644 arch/powerpc/configs/corenet32_misc.config
 delete mode 100644 arch/powerpc/configs/corenet32_smp_defconfig
 create mode 100644 arch/powerpc/configs/corenet64_misc.config
 rename arch/powerpc/configs/{corenet64_smp_defconfig => corenet_basic_defconfig} (84%)
 create mode 100644 arch/powerpc/configs/dma.config
 create mode 100644 arch/powerpc/configs/kvm_guest.config
 create mode 100644 arch/powerpc/configs/math_emulation.config
 create mode 100644 arch/powerpc/configs/mpc85xx.config
 rename arch/powerpc/configs/{mpc85xx_smp_defconfig => mpc85xx_basic_defconfig} (98%)
 delete mode 100644 arch/powerpc/configs/mpc85xx_defconfig
 create mode 100644 arch/powerpc/configs/mpc85xx_misc.config
 create mode 100644 arch/powerpc/configs/non-hardware.config
 create mode 100644 arch/powerpc/configs/smp.config

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index fc502e0..40b6a81 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -269,6 +269,40 @@ bootwrapper_install:
 %.dtb: scripts
 	$(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
 
+configfiles=$(wildcard $(srctree)/kernel/configs/$(1).config $(srctree)/arch/$(SRCARCH)/configs/$(1).config)
+
+define mergeconfig
+$(Q)$(CONFIG_SHELL) $(srctree)/scripts/kconfig/merge_config.sh -m -O $(objtree) $(srctree)/.config $(call configfiles,$(1))
+endef
+
+PHONY += mpc85xx_defconfig mpc85xx_smp_defconfig corenet32_smp_defconfig corenet64_smp_defconfig
+mpc85xx_defconfig:
+	$(Q)cp $(srctree)/arch/$(SRCARCH)/configs/mpc85xx_basic_defconfig $(srctree)/.config
+	$(call mergeconfig,mpc85xx_misc)
+	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
+
+mpc85xx_smp_defconfig:
+	$(Q)cp $(srctree)/arch/$(SRCARCH)/configs/mpc85xx_basic_defconfig $(srctree)/.config
+	$(call mergeconfig,smp)
+	$(call mergeconfig,kvm_guest)
+	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
+
+corenet32_smp_defconfig:
+	$(Q)cp $(srctree)/arch/$(SRCARCH)/configs/corenet_basic_defconfig $(srctree)/.config
+	$(call mergeconfig,mpc85xx)
+	$(call mergeconfig,corenet32_misc)
+	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
+
+corenet64_smp_defconfig:
+	$(Q)cp $(srctree)/arch/$(SRCARCH)/configs/corenet_basic_defconfig $(srctree)/.config
+	$(call mergeconfig,book3e-64)
+	$(call mergeconfig,altivec)
+	$(call mergeconfig,dma)
+	$(call mergeconfig,math_emulation)
+	$(call mergeconfig,non-hardware)
+	$(call mergeconfig,corenet64_misc)
+	$(Q)$(MAKE) -f $(srctree)/Makefile olddefconfig
+
 define archhelp
   @echo '* zImage          - Build default images selected by kernel config'
   @echo '  zImage.*        - Compressed kernel image (arch/$(ARCH)/boot/zImage.*)'
diff --git a/arch/powerpc/configs/altivec.config b/arch/powerpc/configs/altivec.config
new file mode 100644
index 0000000..58a697c
--- /dev/null
+++ b/arch/powerpc/configs/altivec.config
@@ -0,0 +1 @@
+CONFIG_ALTIVEC=y
diff --git a/arch/powerpc/configs/book3e-64.config b/arch/powerpc/configs/book3e-64.config
new file mode 100644
index 0000000..85f4cf2
--- /dev/null
+++ b/arch/powerpc/configs/book3e-64.config
@@ -0,0 +1,2 @@
+CONFIG_PPC64=y
+CONFIG_PPC_BOOK3E_64=y
diff --git a/arch/powerpc/configs/corenet32_misc.config b/arch/powerpc/configs/corenet32_misc.config
new file mode 100644
index 0000000..0b32130
--- /dev/null
+++ b/arch/powerpc/configs/corenet32_misc.config
@@ -0,0 +1,35 @@
+CONFIG_AT803X_PHY=y
+CONFIG_AUDIT=y
+CONFIG_CHR_DEV_ST=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=n
+CONFIG_CRAMFS=y
+CONFIG_E1000=y
+CONFIG_EDAC_MPC85XX=y
+CONFIG_EMBEDDED=y
+CONFIG_EXT3_DEFAULTS_TO_ORDERED=n
+CONFIG_FORCE_MAX_ZONEORDER=13
+CONFIG_HIGHMEM=y
+CONFIG_INET_AH=y
+CONFIG_INET_IPCOMP=y
+CONFIG_KEXEC=y
+CONFIG_LEGACY_PTYS=n
+CONFIG_NET_KEY_MIGRATE=y
+CONFIG_NVRAM=y
+CONFIG_PATA_SIL680=y
+CONFIG_PCI=y
+CONFIG_PCIEASPM=n
+CONFIG_PERF_EVENTS=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_RCU_TRACE=y
+CONFIG_SATA_AHCI=y
+CONFIG_SATA_SIL=y
+CONFIG_SCSI_LOGGING=y
+CONFIG_SCSI_SYM53C8XX_2=y
+CONFIG_SLAB=y
+CONFIG_STAGING=y
+CONFIG_UIO=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
+CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
+CONFIG_XFRM_STATISTICS=y
+CONFIG_XFRM_SUB_POLICY=y
diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
deleted file mode 100644
index 3765993..0000000
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ /dev/null
@@ -1,185 +0,0 @@
-CONFIG_PPC_85xx=y
-CONFIG_SMP=y
-CONFIG_NR_CPUS=8
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_AUDIT=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_EMBEDDED=y
-CONFIG_PERF_EVENTS=y
-CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAC_PARTITION=y
-CONFIG_CORENET_GENERIC=y
-CONFIG_HIGHMEM=y
-# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
-CONFIG_BINFMT_MISC=m
-CONFIG_KEXEC=y
-CONFIG_FORCE_MAX_ZONEORDER=13
-CONFIG_PCI=y
-CONFIG_PCIEPORTBUS=y
-# CONFIG_PCIEASPM is not set
-CONFIG_PCI_MSI=y
-CONFIG_RAPIDIO=y
-CONFIG_FSL_RIO=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=y
-CONFIG_XFRM_SUB_POLICY=y
-CONFIG_XFRM_STATISTICS=y
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_NET_IPIP=y
-CONFIG_IP_MROUTE=y
-CONFIG_IP_PIMSM_V1=y
-CONFIG_IP_PIMSM_V2=y
-CONFIG_INET_AH=y
-CONFIG_INET_ESP=y
-CONFIG_INET_IPCOMP=y
-# CONFIG_INET_LRO is not set
-CONFIG_IPV6=y
-CONFIG_IP_SCTP=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_FSL_ELBC=y
-CONFIG_MTD_NAND_FSL_IFC=y
-CONFIG_MTD_SPI_NOR=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=y
-CONFIG_BLK_DEV_SR=y
-CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_LOGGING=y
-CONFIG_SCSI_SYM53C8XX_2=y
-CONFIG_ATA=y
-CONFIG_SATA_AHCI=y
-CONFIG_SATA_FSL=y
-CONFIG_SATA_SIL24=y
-CONFIG_SATA_SIL=y
-CONFIG_PATA_SIL680=y
-CONFIG_NETDEVICES=y
-CONFIG_FSL_PQ_MDIO=y
-CONFIG_FSL_XGMAC_MDIO=y
-CONFIG_E1000=y
-CONFIG_E1000E=y
-CONFIG_AT803X_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_FIXED_PHY=y
-CONFIG_MDIO_BUS_MUX_GPIO=y
-CONFIG_MDIO_BUS_MUX_MMIOREG=y
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_SERIO_LIBPS2=y
-# CONFIG_LEGACY_PTYS is not set
-CONFIG_PPC_EPAPR_HV_BYTECHAN=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_MANY_PORTS=y
-CONFIG_SERIAL_8250_DETECT_IRQ=y
-CONFIG_SERIAL_8250_RSA=y
-CONFIG_NVRAM=y
-CONFIG_I2C=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_MPC=y
-CONFIG_I2C_MUX=y
-CONFIG_I2C_MUX_PCA954x=y
-CONFIG_SPI=y
-CONFIG_SPI_GPIO=y
-CONFIG_SPI_FSL_SPI=y
-CONFIG_SPI_FSL_ESPI=y
-CONFIG_SENSORS_LM90=y
-CONFIG_SENSORS_INA2XX=y
-CONFIG_USB_HID=m
-CONFIG_USB=y
-CONFIG_USB_MON=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
-CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
-CONFIG_USB_STORAGE=y
-CONFIG_MMC=y
-CONFIG_MMC_SDHCI=y
-CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
-CONFIG_EDAC_MPC85XX=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_DS1307=y
-CONFIG_RTC_DRV_DS1374=y
-CONFIG_RTC_DRV_DS3232=y
-CONFIG_UIO=y
-CONFIG_VIRT_DRIVERS=y
-CONFIG_FSL_HV_MANAGER=y
-CONFIG_STAGING=y
-CONFIG_FSL_CORENET_CF=y
-CONFIG_CLK_QORIQ=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=y
-CONFIG_NTFS_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_HUGETLBFS=y
-CONFIG_JFFS2_FS=y
-CONFIG_CRAMFS=y
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=m
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_NLS_UTF8=m
-CONFIG_DEBUG_INFO=y
-CONFIG_MAGIC_SYSRQ=y
-CONFIG_DEBUG_SHIRQ=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_RCU_TRACE=y
-CONFIG_CRYPTO_NULL=y
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_MD4=y
-CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_SHA512=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_DEV_FSL_CAAM=y
diff --git a/arch/powerpc/configs/corenet64_misc.config b/arch/powerpc/configs/corenet64_misc.config
new file mode 100644
index 0000000..c079055
--- /dev/null
+++ b/arch/powerpc/configs/corenet64_misc.config
@@ -0,0 +1,16 @@
+CONFIG_BLK_DEV_SR_VENDOR=y
+CONFIG_CRC_T10DIF=y
+CONFIG_DEBUG_FS=y
+CONFIG_DUMMY=y
+CONFIG_EEPROM_LEGACY=y
+CONFIG_EXPERT=y
+CONFIG_FHANDLE=y
+CONFIG_FRAME_WARN=1024
+CONFIG_FTL=y
+CONFIG_INET_XFRM_MODE_BEET=n
+CONFIG_INPUT_FF_MEMLESS=m
+CONFIG_IRQ_DOMAIN_DEBUG=y
+CONFIG_JFFS2_FS_DEBUG=1
+CONFIG_MTD_UBI=y
+CONFIG_PPC_OF_BOOT_TRAMPOLINE=n
+CONFIG_UBIFS_FS=y
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet_basic_defconfig
similarity index 84%
rename from arch/powerpc/configs/corenet64_smp_defconfig
rename to arch/powerpc/configs/corenet_basic_defconfig
index 33cd1df..5603820 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet_basic_defconfig
@@ -1,23 +1,13 @@
-CONFIG_PPC64=y
-CONFIG_PPC_BOOK3E_64=y
-CONFIG_ALTIVEC=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=24
 CONFIG_SYSVIPC=y
-CONFIG_FHANDLE=y
-CONFIG_IRQ_DOMAIN_DEBUG=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BSD_PROCESS_ACCT=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
 CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CGROUPS=y
-CONFIG_CPUSETS=y
-CONFIG_CGROUP_CPUACCT=y
-CONFIG_CGROUP_SCHED=y
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
@@ -27,10 +17,7 @@ CONFIG_MODVERSIONS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 CONFIG_CORENET_GENERIC=y
-# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
-CONFIG_MATH_EMULATION=y
-CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
 CONFIG_RAPIDIO=y
@@ -55,7 +42,6 @@ CONFIG_IP_MROUTE=y
 CONFIG_IP_PIMSM_V1=y
 CONFIG_IP_PIMSM_V2=y
 CONFIG_INET_ESP=y
-# CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_INET_LRO is not set
 CONFIG_IPV6=y
 CONFIG_IP_SCTP=m
@@ -65,7 +51,6 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_BLOCK=y
-CONFIG_FTL=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
@@ -74,20 +59,16 @@ CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
 CONFIG_MTD_SPI_NOR=y
-CONFIG_MTD_UBI=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_EEPROM_LEGACY=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
-CONFIG_BLK_DEV_SR_VENDOR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_ATA=y
 CONFIG_SATA_FSL=y
 CONFIG_SATA_SIL24=y
 CONFIG_NETDEVICES=y
-CONFIG_DUMMY=y
 CONFIG_FSL_PQ_MDIO=y
 CONFIG_FSL_XGMAC_MDIO=y
 CONFIG_E1000E=y
@@ -95,7 +76,6 @@ CONFIG_VITESSE_PHY=y
 CONFIG_FIXED_PHY=y
 CONFIG_MDIO_BUS_MUX_GPIO=y
 CONFIG_MDIO_BUS_MUX_MMIOREG=y
-CONFIG_INPUT_FF_MEMLESS=m
 # CONFIG_INPUT_MOUSEDEV is not set
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
@@ -131,12 +111,10 @@ CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_DS1374=y
 CONFIG_RTC_DRV_DS3232=y
-CONFIG_DMADEVICES=y
-CONFIG_FSL_DMA=y
 CONFIG_VIRT_DRIVERS=y
 CONFIG_FSL_HV_MANAGER=y
-CONFIG_CLK_QORIQ=y
 CONFIG_FSL_CORENET_CF=y
+CONFIG_CLK_QORIQ=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_ISO9660_FS=m
@@ -150,8 +128,6 @@ CONFIG_PROC_KCORE=y
 CONFIG_TMPFS=y
 CONFIG_HUGETLBFS=y
 CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_DEBUG=1
-CONFIG_UBIFS_FS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
@@ -160,10 +136,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=m
-CONFIG_CRC_T10DIF=y
 CONFIG_DEBUG_INFO=y
-CONFIG_FRAME_WARN=1024
-CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_DETECT_HUNG_TASK=y
diff --git a/arch/powerpc/configs/dma.config b/arch/powerpc/configs/dma.config
new file mode 100644
index 0000000..f0e66b5
--- /dev/null
+++ b/arch/powerpc/configs/dma.config
@@ -0,0 +1,2 @@
+CONFIG_DMADEVICES=y
+CONFIG_FSL_DMA=y
diff --git a/arch/powerpc/configs/kvm_guest.config b/arch/powerpc/configs/kvm_guest.config
new file mode 100644
index 0000000..9e7eef9
--- /dev/null
+++ b/arch/powerpc/configs/kvm_guest.config
@@ -0,0 +1,2 @@
+CONFIG_KVM_GUEST=y
+CONFIG_VIRT_DRIVERS=y
diff --git a/arch/powerpc/configs/math_emulation.config b/arch/powerpc/configs/math_emulation.config
new file mode 100644
index 0000000..fa2fb66
--- /dev/null
+++ b/arch/powerpc/configs/math_emulation.config
@@ -0,0 +1,2 @@
+CONFIG_MATH_EMULATION=y
+CONFIG_MATH_EMULATION_HW_UNIMPLEMENTED=y
diff --git a/arch/powerpc/configs/mpc85xx.config b/arch/powerpc/configs/mpc85xx.config
new file mode 100644
index 0000000..3b8b43b
--- /dev/null
+++ b/arch/powerpc/configs/mpc85xx.config
@@ -0,0 +1 @@
+CONFIG_PPC_85xx=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_basic_defconfig
similarity index 98%
rename from arch/powerpc/configs/mpc85xx_smp_defconfig
rename to arch/powerpc/configs/mpc85xx_basic_defconfig
index b6c7111..a17d23c 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_basic_defconfig
@@ -1,7 +1,6 @@
 CONFIG_PPC_85xx=y
-CONFIG_PHYS_64BIT=y
-CONFIG_SMP=y
 CONFIG_NR_CPUS=8
+CONFIG_PHYS_64BIT=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
@@ -44,6 +43,7 @@ CONFIG_TQM8548=y
 CONFIG_TQM8555=y
 CONFIG_TQM8560=y
 CONFIG_SBC8548=y
+CONFIG_PPC_QEMU_E500=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_HIGHMEM=y
@@ -128,8 +128,8 @@ CONFIG_INPUT_FF_MEMLESS=m
 CONFIG_SERIO_LIBPS2=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=2
-CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_NR_UARTS=6
+CONFIG_SERIAL_8250_RUNTIME_UARTS=6
 CONFIG_SERIAL_8250_MANY_PORTS=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
deleted file mode 100644
index 6ecf7bd..0000000
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ /dev/null
@@ -1,252 +0,0 @@
-CONFIG_PPC_85xx=y
-CONFIG_PHYS_64BIT=y
-CONFIG_SYSVIPC=y
-CONFIG_POSIX_MQUEUE=y
-CONFIG_AUDIT=y
-CONFIG_IRQ_DOMAIN_DEBUG=y
-CONFIG_NO_HZ=y
-CONFIG_HIGH_RES_TIMERS=y
-CONFIG_BSD_PROCESS_ACCT=y
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_BLK_DEV_INITRD=y
-CONFIG_EXPERT=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-CONFIG_MODULE_FORCE_UNLOAD=y
-CONFIG_MODVERSIONS=y
-# CONFIG_BLK_DEV_BSG is not set
-CONFIG_PARTITION_ADVANCED=y
-CONFIG_MAC_PARTITION=y
-CONFIG_C293_PCIE=y
-CONFIG_MPC8540_ADS=y
-CONFIG_MPC8560_ADS=y
-CONFIG_MPC85xx_CDS=y
-CONFIG_MPC85xx_MDS=y
-CONFIG_MPC8536_DS=y
-CONFIG_MPC85xx_DS=y
-CONFIG_MPC85xx_RDB=y
-CONFIG_P1010_RDB=y
-CONFIG_P1022_DS=y
-CONFIG_P1022_RDK=y
-CONFIG_P1023_RDB=y
-CONFIG_SOCRATES=y
-CONFIG_KSI8560=y
-CONFIG_XES_MPC85xx=y
-CONFIG_STX_GP3=y
-CONFIG_TQM8540=y
-CONFIG_TQM8541=y
-CONFIG_TQM8548=y
-CONFIG_TQM8555=y
-CONFIG_TQM8560=y
-CONFIG_SBC8548=y
-CONFIG_MVME2500=y
-CONFIG_QUICC_ENGINE=y
-CONFIG_QE_GPIO=y
-CONFIG_HIGHMEM=y
-CONFIG_BINFMT_MISC=m
-CONFIG_MATH_EMULATION=y
-CONFIG_FORCE_MAX_ZONEORDER=12
-CONFIG_PCI=y
-CONFIG_PCIEPORTBUS=y
-# CONFIG_PCIEASPM is not set
-CONFIG_PCI_MSI=y
-CONFIG_RAPIDIO=y
-CONFIG_NET=y
-CONFIG_PACKET=y
-CONFIG_UNIX=y
-CONFIG_XFRM_USER=y
-CONFIG_NET_KEY=y
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-CONFIG_IP_ADVANCED_ROUTER=y
-CONFIG_IP_MULTIPLE_TABLES=y
-CONFIG_IP_ROUTE_MULTIPATH=y
-CONFIG_IP_ROUTE_VERBOSE=y
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-CONFIG_IP_PNP_RARP=y
-CONFIG_NET_IPIP=y
-CONFIG_IP_MROUTE=y
-CONFIG_IP_PIMSM_V1=y
-CONFIG_IP_PIMSM_V2=y
-CONFIG_INET_ESP=y
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_LRO is not set
-CONFIG_IPV6=y
-CONFIG_IP_SCTP=m
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
-CONFIG_DEVTMPFS=y
-CONFIG_DEVTMPFS_MOUNT=y
-CONFIG_MTD=y
-CONFIG_MTD_CMDLINE_PARTS=y
-CONFIG_MTD_BLOCK=y
-CONFIG_FTL=y
-CONFIG_MTD_CFI=y
-CONFIG_MTD_CFI_INTELEXT=y
-CONFIG_MTD_CFI_AMDSTD=y
-CONFIG_MTD_PHYSMAP=y
-CONFIG_MTD_PHYSMAP_OF=y
-CONFIG_MTD_PLATRAM=y
-CONFIG_MTD_M25P80=y
-CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_FSL_ELBC=y
-CONFIG_MTD_NAND_FSL_IFC=y
-CONFIG_MTD_SPI_NOR=y
-CONFIG_MTD_UBI=y
-CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_NBD=y
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_SIZE=131072
-CONFIG_EEPROM_AT24=y
-CONFIG_EEPROM_LEGACY=y
-CONFIG_BLK_DEV_SD=y
-CONFIG_CHR_DEV_ST=y
-CONFIG_BLK_DEV_SR=y
-CONFIG_CHR_DEV_SG=y
-CONFIG_SCSI_LOGGING=y
-CONFIG_ATA=y
-CONFIG_SATA_AHCI=y
-CONFIG_SATA_FSL=y
-CONFIG_SATA_SIL24=y
-CONFIG_PATA_ALI=y
-CONFIG_PATA_VIA=y
-CONFIG_NETDEVICES=y
-CONFIG_DUMMY=y
-CONFIG_FS_ENET=y
-CONFIG_UCC_GETH=y
-CONFIG_GIANFAR=y
-CONFIG_E1000=y
-CONFIG_E1000E=y
-CONFIG_IGB=y
-CONFIG_AT803X_PHY=y
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_FIXED_PHY=y
-CONFIG_INPUT_FF_MEMLESS=m
-# CONFIG_INPUT_MOUSEDEV is not set
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-CONFIG_SERIO_LIBPS2=y
-CONFIG_SERIAL_8250=y
-CONFIG_SERIAL_8250_CONSOLE=y
-CONFIG_SERIAL_8250_NR_UARTS=6
-CONFIG_SERIAL_8250_RUNTIME_UARTS=6
-CONFIG_SERIAL_8250_MANY_PORTS=y
-CONFIG_SERIAL_8250_DETECT_IRQ=y
-CONFIG_SERIAL_8250_RSA=y
-CONFIG_SERIAL_QE=m
-CONFIG_NVRAM=y
-CONFIG_I2C_CHARDEV=y
-CONFIG_I2C_CPM=m
-CONFIG_I2C_MPC=y
-CONFIG_SPI=y
-CONFIG_SPI_FSL_SPI=y
-CONFIG_SPI_FSL_ESPI=y
-CONFIG_GPIO_MPC8XXX=y
-CONFIG_SENSORS_LM90=y
-CONFIG_FB=y
-CONFIG_FB_FSL_DIU=y
-# CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_SOUND=y
-CONFIG_SND=y
-# CONFIG_SND_SUPPORT_OLD_API is not set
-# CONFIG_SND_DRIVERS is not set
-CONFIG_SND_INTEL8X0=y
-# CONFIG_SND_PPC is not set
-# CONFIG_SND_USB is not set
-CONFIG_SND_SOC=y
-CONFIG_SND_POWERPC_SOC=y
-CONFIG_HID_A4TECH=y
-CONFIG_HID_APPLE=y
-CONFIG_HID_BELKIN=y
-CONFIG_HID_CHERRY=y
-CONFIG_HID_CHICONY=y
-CONFIG_HID_CYPRESS=y
-CONFIG_HID_EZKEY=y
-CONFIG_HID_GYRATION=y
-CONFIG_HID_LOGITECH=y
-CONFIG_HID_MICROSOFT=y
-CONFIG_HID_MONTEREY=y
-CONFIG_HID_PANTHERLORD=y
-CONFIG_HID_PETALYNX=y
-CONFIG_HID_SAMSUNG=y
-CONFIG_HID_SUNPLUS=y
-CONFIG_USB=y
-CONFIG_USB_MON=y
-CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_FSL=y
-CONFIG_USB_OHCI_HCD=y
-CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
-CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
-CONFIG_USB_STORAGE=y
-CONFIG_MMC=y
-CONFIG_MMC_SDHCI=y
-CONFIG_MMC_SDHCI_PLTFM=y
-CONFIG_MMC_SDHCI_OF_ESDHC=y
-CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
-CONFIG_EDAC_MPC85XX=y
-CONFIG_RTC_CLASS=y
-CONFIG_RTC_DRV_DS1307=y
-CONFIG_RTC_DRV_DS1374=y
-CONFIG_RTC_DRV_DS3232=y
-CONFIG_RTC_DRV_CMOS=y
-CONFIG_DMADEVICES=y
-CONFIG_FSL_DMA=y
-CONFIG_EXT2_FS=y
-CONFIG_EXT3_FS=y
-# CONFIG_EXT3_DEFAULTS_TO_ORDERED is not set
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=y
-CONFIG_NTFS_FS=y
-CONFIG_PROC_KCORE=y
-CONFIG_TMPFS=y
-CONFIG_HUGETLBFS=y
-CONFIG_ADFS_FS=m
-CONFIG_AFFS_FS=m
-CONFIG_HFS_FS=m
-CONFIG_HFSPLUS_FS=m
-CONFIG_BEFS_FS=m
-CONFIG_BFS_FS=m
-CONFIG_EFS_FS=m
-CONFIG_JFFS2_FS=y
-CONFIG_JFFS2_FS_DEBUG=1
-CONFIG_UBIFS_FS=y
-CONFIG_CRAMFS=y
-CONFIG_VXFS_FS=m
-CONFIG_HPFS_FS=m
-CONFIG_QNX4FS_FS=m
-CONFIG_SYSV_FS=m
-CONFIG_UFS_FS=m
-CONFIG_NFS_FS=y
-CONFIG_NFS_V4=y
-CONFIG_ROOT_NFS=y
-CONFIG_NFSD=y
-CONFIG_NLS_CODEPAGE_437=y
-CONFIG_NLS_CODEPAGE_850=y
-CONFIG_NLS_ISO8859_1=y
-CONFIG_CRC_T10DIF=y
-CONFIG_FONTS=y
-CONFIG_FONT_8x8=y
-CONFIG_FONT_8x16=y
-CONFIG_DEBUG_INFO=y
-CONFIG_DEBUG_FS=y
-CONFIG_DETECT_HUNG_TASK=y
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_SHA256=y
-CONFIG_CRYPTO_SHA512=y
-# CONFIG_CRYPTO_ANSI_CPRNG is not set
-CONFIG_CRYPTO_DEV_FSL_CAAM=y
-CONFIG_CRYPTO_DEV_TALITOS=y
diff --git a/arch/powerpc/configs/mpc85xx_misc.config b/arch/powerpc/configs/mpc85xx_misc.config
new file mode 100644
index 0000000..3f554d5
--- /dev/null
+++ b/arch/powerpc/configs/mpc85xx_misc.config
@@ -0,0 +1,11 @@
+CONFIG_BROADCOM_PHY=y
+CONFIG_E1000=y
+CONFIG_EDAC_MPC85XX=y
+CONFIG_IGB=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_PLATRAM=y
+CONFIG_MVME2500=y
+CONFIG_PATA_VIA=y
+CONFIG_PCIEASPM=n
+CONFIG_PCIEPORTBUS=y
diff --git a/arch/powerpc/configs/non-hardware.config b/arch/powerpc/configs/non-hardware.config
new file mode 100644
index 0000000..a6012a3
--- /dev/null
+++ b/arch/powerpc/configs/non-hardware.config
@@ -0,0 +1,4 @@
+CONFIG_CGROUPS=y
+CONFIG_CPUSETS=y
+CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_SCHED=y
diff --git a/arch/powerpc/configs/smp.config b/arch/powerpc/configs/smp.config
new file mode 100644
index 0000000..1cbf7ec
--- /dev/null
+++ b/arch/powerpc/configs/smp.config
@@ -0,0 +1 @@
+CONFIG_SMP=y
-- 
1.9.3
