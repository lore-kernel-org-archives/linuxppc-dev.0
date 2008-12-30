Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E05F7DDE1D
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 04:32:27 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id mBUHWNTU006821
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Dec 2008 11:32:23 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/85xx: Add SMP support to MPC8572 DS
Date: Tue, 30 Dec 2008 11:32:21 -0600
Message-Id: <1230658341-20124-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1230658341-20124-1-git-send-email-galak@kernel.crashing.org>
References: <1230658341-20124-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable SMP support on the MPC8572 DS reference board.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/configs/85xx/mpc8572_ds_defconfig |   43 +++++++++++++++--------
 arch/powerpc/platforms/85xx/mpc85xx_ds.c       |    7 ++++
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/configs/85xx/mpc8572_ds_defconfig b/arch/powerpc/configs/85xx/mpc8572_ds_defconfig
index 6355883..32aeb79 100644
--- a/arch/powerpc/configs/85xx/mpc8572_ds_defconfig
+++ b/arch/powerpc/configs/85xx/mpc8572_ds_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.28-rc3
-# Sat Nov  8 12:40:13 2008
+# Linux kernel version: 2.6.28-rc8
+# Tue Dec 30 11:17:46 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -21,7 +21,10 @@ CONFIG_FSL_BOOKE=y
 CONFIG_FSL_EMB_PERFMON=y
 # CONFIG_PHYS_64BIT is not set
 CONFIG_SPE=y
+CONFIG_PPC_MMU_NOHASH=y
 # CONFIG_PPC_MM_SLICES is not set
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
 CONFIG_PPC32=y
 CONFIG_WORD_SIZE=32
 # CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
@@ -50,7 +53,7 @@ CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 CONFIG_PPC_OF=y
 CONFIG_OF=y
 CONFIG_PPC_UDBG_16550=y
-# CONFIG_GENERIC_TBSYNC is not set
+CONFIG_GENERIC_TBSYNC=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
@@ -62,7 +65,7 @@ CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 # General setup
 #
 CONFIG_EXPERIMENTAL=y
-CONFIG_BROKEN_ON_SMP=y
+CONFIG_LOCK_KERNEL=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION=""
 CONFIG_LOCALVERSION_AUTO=y
@@ -126,6 +129,7 @@ CONFIG_HAVE_IOREMAP_PROT=y
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
 CONFIG_HAVE_ARCH_TRACEHOOK=y
+CONFIG_USE_GENERIC_SMP_HELPERS=y
 # CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
@@ -138,6 +142,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_KMOD=y
+CONFIG_STOP_MACHINE=y
 CONFIG_BLOCK=y
 CONFIG_LBD=y
 # CONFIG_BLK_DEV_IO_TRACE is not set
@@ -197,6 +202,7 @@ CONFIG_PPC_I8259=y
 # CONFIG_CPM2 is not set
 CONFIG_FSL_ULI1575=y
 # CONFIG_MPC8xxx_GPIO is not set
+# CONFIG_SIMPLE_GPIO is not set
 
 #
 # Kernel options
@@ -224,6 +230,7 @@ CONFIG_MATH_EMULATION=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
 CONFIG_ARCH_HAS_WALK_MEMORY=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=y
+# CONFIG_IRQ_ALL_CPUS is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -241,6 +248,9 @@ CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
 CONFIG_UNEVICTABLE_LRU=y
+CONFIG_PPC_4K_PAGES=y
+# CONFIG_PPC_16K_PAGES is not set
+# CONFIG_PPC_64K_PAGES is not set
 CONFIG_FORCE_MAX_ZONEORDER=11
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
@@ -443,8 +453,10 @@ CONFIG_MISC_DEVICES=y
 # CONFIG_EEPROM_93CX6 is not set
 # CONFIG_SGI_IOC4 is not set
 # CONFIG_TIFM_CORE is not set
+# CONFIG_ICS932S401 is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
 # CONFIG_HP_ILO is not set
+# CONFIG_C2PORT is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
 
@@ -784,6 +796,7 @@ CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_HVC_UDBG is not set
 # CONFIG_IPMI_HANDLER is not set
 CONFIG_HW_RANDOM=y
 CONFIG_NVRAM=y
@@ -869,11 +882,11 @@ CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
 # CONFIG_THERMAL is not set
 # CONFIG_THERMAL_HWMON is not set
 # CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
 # Sonics Silicon Backplane
 #
-CONFIG_SSB_POSSIBLE=y
 # CONFIG_SSB is not set
 
 #
@@ -886,14 +899,7 @@ CONFIG_SSB_POSSIBLE=y
 # CONFIG_PMIC_DA903X is not set
 # CONFIG_MFD_WM8400 is not set
 # CONFIG_MFD_WM8350_I2C is not set
-
-#
-# Voltage and Current regulators
-#
 # CONFIG_REGULATOR is not set
-# CONFIG_REGULATOR_FIXED_VOLTAGE is not set
-# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
-# CONFIG_REGULATOR_BQ24022 is not set
 
 #
 # Multimedia devices
@@ -1252,11 +1258,11 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 # CONFIG_USB_TMC is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed;
 #
 
 #
-# may also be needed; see USB_STORAGE Help for more information
+# see USB_STORAGE Help for more information
 #
 CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_DEBUG is not set
@@ -1348,6 +1354,7 @@ CONFIG_RTC_INTF_DEV=y
 # CONFIG_RTC_DRV_M41T80 is not set
 # CONFIG_RTC_DRV_S35390A is not set
 # CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
 
 #
 # SPI RTC drivers
@@ -1624,6 +1631,7 @@ CONFIG_HAVE_FUNCTION_TRACER=y
 # CONFIG_SAMPLES is not set
 CONFIG_HAVE_ARCH_KGDB=y
 # CONFIG_KGDB is not set
+CONFIG_PRINT_STACK_DEPTH=64
 # CONFIG_DEBUG_STACKOVERFLOW is not set
 # CONFIG_DEBUG_STACK_USAGE is not set
 # CONFIG_DEBUG_PAGEALLOC is not set
@@ -1649,11 +1657,16 @@ CONFIG_CRYPTO=y
 #
 # CONFIG_CRYPTO_FIPS is not set
 CONFIG_CRYPTO_ALGAPI=y
+CONFIG_CRYPTO_ALGAPI2=y
 CONFIG_CRYPTO_AEAD=y
+CONFIG_CRYPTO_AEAD2=y
 CONFIG_CRYPTO_BLKCIPHER=y
+CONFIG_CRYPTO_BLKCIPHER2=y
 CONFIG_CRYPTO_HASH=y
-CONFIG_CRYPTO_RNG=y
+CONFIG_CRYPTO_HASH2=y
+CONFIG_CRYPTO_RNG2=y
 CONFIG_CRYPTO_MANAGER=y
+CONFIG_CRYPTO_MANAGER2=y
 # CONFIG_CRYPTO_GF128MUL is not set
 # CONFIG_CRYPTO_NULL is not set
 # CONFIG_CRYPTO_CRYPTD is not set
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index a8301c8..7326d90 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -148,6 +148,9 @@ static int mpc85xx_exclude_device(struct pci_controller *hose,
 /*
  * Setup the architecture
  */
+#ifdef CONFIG_SMP
+extern void __init mpc85xx_smp_init(void);
+#endif
 static void __init mpc85xx_ds_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -173,6 +176,10 @@ static void __init mpc85xx_ds_setup_arch(void)
 	ppc_md.pci_exclude_device = mpc85xx_exclude_device;
 #endif
 
+#ifdef CONFIG_SMP
+	mpc85xx_smp_init();
+#endif
+
 	printk("MPC85xx DS board from Freescale Semiconductor\n");
 }
 
-- 
1.5.6.5
