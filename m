Return-Path: <wg@grandegger.com>
Message-ID: <4868DAB1.5050108@grandegger.com>
Date: Mon, 30 Jun 2008 15:08:01 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 85xx: TQM8548: add missing support for RTC
	and LM75
References: <4863967F.8060806@grandegger.com>
	<D6CBABD3-569E-4BED-894C-4F86696E4DD6@kernel.crashing.org>
	<4863A424.5080904@grandegger.com>
	<D0B930D5-3211-4199-94B9-586065A0F116@kernel.crashing.org>
In-Reply-To: <D0B930D5-3211-4199-94B9-586065A0F116@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Jun 26, 2008, at 9:13 AM, Wolfgang Grandegger wrote:
> 
>> Kumar Gala wrote:
>>> On Jun 26, 2008, at 8:15 AM, Wolfgang Grandegger wrote:
>>>> It adds the missing RTC node to tqm8548.dts and enables support for
>>>> I2C, DS1307 and LM75 in the default configuration.
>>>>
>>>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>>>> ---
>>>> arch/powerpc/boot/dts/tqm8548.dts           |    5 
>>>> arch/powerpc/configs/85xx/tqm8548_defconfig |  143 
>>>> ++++++++++++++++++++++++++--
>>>> 2 files changed, 142 insertions(+), 6 deletions(-)
>>> your mailer is wrapping things.
>>
>> Hm, I can apply the patch extracted from my mail without problems.
>>
>>> Also, can you test out the mpc85xx_defconfig and make sure it works 
>>> with the tqm85xx boards (and provide a second patch that enables 
>>> whatever drivers you need in there)
>>
>> OK, will do so beginning of next week. For the TQM8548 I use the ELDK 
>> ppc_85xxDP and for all others the ppc_85xx tool chain. Does a mixed 
>> image for both types of MPC85xx CPUs make sense?
> 
> I'm just trying to keep the mpc85xx_defconfig as a subset of all the 
> other defconfigs for 85xx so it gives people doing testing one defconfig 
> to build and try and sure that the other defconfigs will continue to work.

A subset or superset? The existing mpc85xx_defconfig does not work on
the TQM8560, because support for the CPM2 UART is missing. I have
attached the patch for mpc85xx_defconfig to support the TQM85xx modules
(tested with TQM8540, TQM8548 and TQM8560) with one image.

Hope it's what you are looking for.

BTW: "WARNING: modpost: Found 1 section mismatch(es)." shows up when
enabling the FS ENET driver.

Wolfgang.

---
 arch/powerpc/configs/mpc85xx_defconfig |  382 ++++++++++++++++++++++++++-------
 1 file changed, 302 insertions(+), 80 deletions(-)

Index: linux-2.6-galak/arch/powerpc/configs/mpc85xx_defconfig
===================================================================
--- linux-2.6-galak.orig/arch/powerpc/configs/mpc85xx_defconfig
+++ linux-2.6-galak/arch/powerpc/configs/mpc85xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc7
-# Mon Mar 31 11:37:08 2008
+# Linux kernel version: 2.6.26-rc5
+# Mon Jun 30 14:22:18 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -15,6 +15,7 @@ CONFIG_PPC_85xx=y
 # CONFIG_44x is not set
 # CONFIG_E200 is not set
 CONFIG_E500=y
+# CONFIG_PPC_E500MC is not set
 CONFIG_BOOKE=y
 CONFIG_FSL_BOOKE=y
 CONFIG_FSL_EMB_PERFMON=y
@@ -32,6 +33,8 @@ CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
 # CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
 CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
@@ -90,6 +93,7 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
@@ -117,12 +121,14 @@ CONFIG_HAVE_OPROFILE=y
 # CONFIG_KPROBES is not set
 CONFIG_HAVE_KPROBES=y
 CONFIG_HAVE_KRETPROBES=y
+# CONFIG_HAVE_DMA_ATTRS is not set
 CONFIG_PROC_PAGE_MONITOR=y
 CONFIG_SLABINFO=y
 CONFIG_RT_MUTEXES=y
 # CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
 CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
@@ -162,9 +168,11 @@ CONFIG_MPC8560_ADS=y
 CONFIG_MPC85xx_CDS=y
 CONFIG_MPC85xx_MDS=y
 CONFIG_MPC85xx_DS=y
+# CONFIG_KSI8560 is not set
 # CONFIG_STX_GP3 is not set
 CONFIG_TQM8540=y
 CONFIG_TQM8541=y
+# CONFIG_TQM8548 is not set
 CONFIG_TQM8555=y
 CONFIG_TQM8560=y
 CONFIG_SBC8548=y
@@ -221,11 +229,13 @@ CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
 # CONFIG_SPARSEMEM_STATIC is not set
 # CONFIG_SPARSEMEM_VMEMMAP_ENABLE is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
 # CONFIG_RESOURCES_64BIT is not set
 CONFIG_ZONE_DMA_FLAG=1
 CONFIG_BOUNCE=y
 CONFIG_VIRT_TO_BUS=y
+CONFIG_FORCE_MAX_ZONEORDER=11
 CONFIG_PROC_DEVICETREE=y
 # CONFIG_CMDLINE_BOOL is not set
 # CONFIG_PM is not set
@@ -240,16 +250,20 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_FSL_SOC=y
 CONFIG_FSL_PCI=y
+CONFIG_FSL_LBC=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_SYSCALL=y
-# CONFIG_PCIEPORTBUS is not set
+CONFIG_PCIEPORTBUS=y
+CONFIG_PCIEAER=y
+# CONFIG_PCIEASPM is not set
 CONFIG_ARCH_SUPPORTS_MSI=y
 # CONFIG_PCI_MSI is not set
 CONFIG_PCI_LEGACY=y
 # CONFIG_PCI_DEBUG is not set
 # CONFIG_PCCARD is not set
 # CONFIG_HOTPLUG_PCI is not set
+# CONFIG_HAS_RAPIDIO is not set
 
 #
 # Advanced setup
@@ -259,11 +273,12 @@ CONFIG_PCI_LEGACY=y
 #
 # Default settings for advanced configuration options are used
 #
-CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
+CONFIG_PHYSICAL_START=0x00000000
+CONFIG_PHYSICAL_ALIGN=0x10000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_BOOT_LOAD=0x00800000
 
 #
 # Networking
@@ -334,8 +349,10 @@ CONFIG_INET6_XFRM_MODE_TUNNEL=y
 CONFIG_INET6_XFRM_MODE_BEET=y
 # CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
 CONFIG_IPV6_SIT=y
+CONFIG_IPV6_NDISC_NODETYPE=y
 # CONFIG_IPV6_TUNNEL is not set
 # CONFIG_IPV6_MULTIPLE_TABLES is not set
+# CONFIG_IPV6_MROUTE is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
@@ -395,8 +412,97 @@ CONFIG_FW_LOADER=y
 # CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
-# CONFIG_MTD is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+# CONFIG_MTD_CMDLINE_PARTS is not set
+CONFIG_MTD_OF_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+# CONFIG_MTD_PHYSMAP is not set
+CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_INTEL_VR_NOR is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_PMC551 is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_CAFE is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+# CONFIG_MTD_NAND_PLATFORM is not set
+# CONFIG_MTD_ALAUDA is not set
+# CONFIG_MTD_NAND_FSL_ELBC is not set
+CONFIG_MTD_NAND_FSL_UPM=y
+# CONFIG_MTD_ONENAND is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
+CONFIG_OF_I2C=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
@@ -503,7 +609,11 @@ CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_SCSI_SRP is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
+CONFIG_SATA_PMP=y
 CONFIG_SATA_AHCI=y
+# CONFIG_SATA_SIL24 is not set
+# CONFIG_SATA_FSL is not set
+CONFIG_ATA_SFF=y
 # CONFIG_SATA_SVW is not set
 # CONFIG_ATA_PIIX is not set
 # CONFIG_SATA_MV is not set
@@ -513,13 +623,11 @@ CONFIG_SATA_AHCI=y
 # CONFIG_SATA_PROMISE is not set
 # CONFIG_SATA_SX4 is not set
 # CONFIG_SATA_SIL is not set
-# CONFIG_SATA_SIL24 is not set
 # CONFIG_SATA_SIS is not set
 # CONFIG_SATA_ULI is not set
 # CONFIG_SATA_VIA is not set
 # CONFIG_SATA_VITESSE is not set
 # CONFIG_SATA_INIC162X is not set
-# CONFIG_SATA_FSL is not set
 CONFIG_PATA_ALI=y
 # CONFIG_PATA_AMD is not set
 # CONFIG_PATA_ARTOP is not set
@@ -559,6 +667,7 @@ CONFIG_PATA_ALI=y
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
 # CONFIG_PATA_PLATFORM is not set
+# CONFIG_PATA_SCH is not set
 # CONFIG_MD is not set
 # CONFIG_FUSION is not set
 
@@ -594,7 +703,7 @@ CONFIG_VITESSE_PHY=y
 # CONFIG_ICPLUS_PHY is not set
 # CONFIG_REALTEK_PHY is not set
 # CONFIG_FIXED_PHY is not set
-# CONFIG_MDIO_BITBANG is not set
+CONFIG_MDIO_BITBANG=y
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 # CONFIG_HAPPYMEAL is not set
@@ -609,7 +718,10 @@ CONFIG_MII=y
 # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
 # CONFIG_NET_PCI is not set
 # CONFIG_B44 is not set
-# CONFIG_FS_ENET is not set
+CONFIG_FS_ENET=y
+# CONFIG_FS_ENET_HAS_SCC is not set
+CONFIG_FS_ENET_HAS_FCC=y
+CONFIG_FS_ENET_MDIO_FCC=y
 CONFIG_NETDEV_1000=y
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
@@ -625,7 +737,6 @@ CONFIG_NETDEV_1000=y
 # CONFIG_SIS190 is not set
 # CONFIG_SKGE is not set
 # CONFIG_SKY2 is not set
-# CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
@@ -646,6 +757,7 @@ CONFIG_NETDEV_10000=y
 # CONFIG_MLX4_CORE is not set
 # CONFIG_TEHUTI is not set
 # CONFIG_BNX2X is not set
+# CONFIG_SFC is not set
 # CONFIG_TR is not set
 
 #
@@ -653,6 +765,7 @@ CONFIG_NETDEV_10000=y
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # USB Network Adapters
@@ -717,6 +830,7 @@ CONFIG_VT=y
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
 # CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
 # CONFIG_NOZOMI is not set
 
@@ -740,7 +854,14 @@ CONFIG_SERIAL_8250_RSA=y
 # CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
-# CONFIG_SERIAL_CPM is not set
+CONFIG_SERIAL_CPM=y
+CONFIG_SERIAL_CPM_CONSOLE=y
+CONFIG_SERIAL_CPM_SCC1=y
+# CONFIG_SERIAL_CPM_SCC2 is not set
+# CONFIG_SERIAL_CPM_SCC3 is not set
+# CONFIG_SERIAL_CPM_SCC4 is not set
+# CONFIG_SERIAL_CPM_SMC1 is not set
+# CONFIG_SERIAL_CPM_SMC2 is not set
 # CONFIG_SERIAL_JSM is not set
 # CONFIG_SERIAL_OF_PLATFORM is not set
 # CONFIG_SERIAL_QE is not set
@@ -750,7 +871,6 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_IPMI_HANDLER is not set
 # CONFIG_HW_RANDOM is not set
 CONFIG_NVRAM=y
-# CONFIG_GEN_RTC is not set
 # CONFIG_R3964 is not set
 # CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
@@ -761,13 +881,6 @@ CONFIG_I2C_BOARDINFO=y
 # CONFIG_I2C_CHARDEV is not set
 
 #
-# I2C Algorithms
-#
-# CONFIG_I2C_ALGOBIT is not set
-# CONFIG_I2C_ALGOPCF is not set
-# CONFIG_I2C_ALGOPCA is not set
-
-#
 # I2C Hardware Bus support
 #
 # CONFIG_I2C_ALI1535 is not set
@@ -794,6 +907,7 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_VIA is not set
 # CONFIG_I2C_VIAPRO is not set
 # CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -803,22 +917,69 @@ CONFIG_SENSORS_EEPROM=y
 # CONFIG_SENSORS_PCF8574 is not set
 # CONFIG_PCF8575 is not set
 # CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_TPS65010 is not set
 # CONFIG_SENSORS_MAX6875 is not set
 # CONFIG_SENSORS_TSL2550 is not set
 # CONFIG_I2C_DEBUG_CORE is not set
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
-
-#
-# SPI support
-#
 # CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
-# CONFIG_HWMON is not set
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
+# CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7473 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_I5K_AMB is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_F71882FG is not set
+# CONFIG_SENSORS_F75375S is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+CONFIG_SENSORS_LM75=y
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX6650 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_SIS5595 is not set
+# CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_VT8231 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83L786NG is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
 # CONFIG_THERMAL is not set
 # CONFIG_WATCHDOG is not set
 
@@ -832,13 +993,33 @@ CONFIG_SSB_POSSIBLE=y
 # Multifunction device drivers
 #
 # CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
 
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
 CONFIG_DVB_CORE=m
-# CONFIG_DVB_CORE_ATTACH is not set
+CONFIG_VIDEO_MEDIA=m
+
+#
+# Multimedia drivers
+#
+# CONFIG_MEDIA_ATTACH is not set
+CONFIG_MEDIA_TUNER=m
+# CONFIG_MEDIA_TUNER_CUSTOMIZE is not set
+CONFIG_MEDIA_TUNER_SIMPLE=m
+CONFIG_MEDIA_TUNER_TDA8290=m
+CONFIG_MEDIA_TUNER_TDA9887=m
+CONFIG_MEDIA_TUNER_TEA5761=m
+CONFIG_MEDIA_TUNER_TEA5767=m
+CONFIG_MEDIA_TUNER_MT20XX=m
+CONFIG_MEDIA_TUNER_XC2028=m
+CONFIG_MEDIA_TUNER_XC5000=m
 CONFIG_DVB_CAPTURE_DRIVERS=y
 
 #
@@ -881,14 +1062,17 @@ CONFIG_DVB_CAPTURE_DRIVERS=y
 #
 # DVB-S (satellite) frontends
 #
-# CONFIG_DVB_STV0299 is not set
 # CONFIG_DVB_CX24110 is not set
 # CONFIG_DVB_CX24123 is not set
-# CONFIG_DVB_TDA8083 is not set
 # CONFIG_DVB_MT312 is not set
-# CONFIG_DVB_VES1X93 is not set
 # CONFIG_DVB_S5H1420 is not set
+# CONFIG_DVB_STV0299 is not set
+# CONFIG_DVB_TDA8083 is not set
 # CONFIG_DVB_TDA10086 is not set
+# CONFIG_DVB_VES1X93 is not set
+# CONFIG_DVB_TUNER_ITD1000 is not set
+# CONFIG_DVB_TDA826X is not set
+# CONFIG_DVB_TUA6100 is not set
 
 #
 # DVB-T (terrestrial) frontends
@@ -906,6 +1090,7 @@ CONFIG_DVB_CAPTURE_DRIVERS=y
 # CONFIG_DVB_DIB3000MC is not set
 # CONFIG_DVB_DIB7000M is not set
 # CONFIG_DVB_DIB7000P is not set
+# CONFIG_DVB_TDA10048 is not set
 
 #
 # DVB-C (cable) frontends
@@ -924,27 +1109,21 @@ CONFIG_DVB_CAPTURE_DRIVERS=y
 # CONFIG_DVB_BCM3510 is not set
 # CONFIG_DVB_LGDT330X is not set
 # CONFIG_DVB_S5H1409 is not set
+# CONFIG_DVB_AU8522 is not set
+# CONFIG_DVB_S5H1411 is not set
 
 #
-# Tuners/PLL support
+# Digital terrestrial only tuners/PLL
 #
 # CONFIG_DVB_PLL is not set
-# CONFIG_DVB_TDA826X is not set
-# CONFIG_DVB_TDA827X is not set
-# CONFIG_DVB_TDA18271 is not set
-# CONFIG_DVB_TUNER_QT1010 is not set
-# CONFIG_DVB_TUNER_MT2060 is not set
-# CONFIG_DVB_TUNER_MT2266 is not set
-# CONFIG_DVB_TUNER_MT2131 is not set
 # CONFIG_DVB_TUNER_DIB0070 is not set
-# CONFIG_DVB_TUNER_XC5000 is not set
 
 #
-# Miscellaneous devices
+# SEC control devices for DVB-S
 #
 # CONFIG_DVB_LNBP21 is not set
+# CONFIG_DVB_ISL6405 is not set
 # CONFIG_DVB_ISL6421 is not set
-# CONFIG_DVB_TUA6100 is not set
 CONFIG_DAB=y
 # CONFIG_USB_DABUSB is not set
 
@@ -1011,6 +1190,7 @@ CONFIG_SND_AC97_CODEC=y
 # CONFIG_SND_AU8810 is not set
 # CONFIG_SND_AU8820 is not set
 # CONFIG_SND_AU8830 is not set
+# CONFIG_SND_AW2 is not set
 # CONFIG_SND_AZT3328 is not set
 # CONFIG_SND_BT87X is not set
 # CONFIG_SND_CA0106 is not set
@@ -1085,11 +1265,11 @@ CONFIG_SND_INTEL8X0=y
 # CONFIG_SND_SOC is not set
 
 #
-# SoC Audio support for SuperH
+# ALSA SoC audio for Freescale SOCs
 #
 
 #
-# ALSA SoC audio for Freescale SOCs
+# SoC Audio for the Texas Instruments OMAP
 #
 
 #
@@ -1124,16 +1304,20 @@ CONFIG_USB_DEVICEFS=y
 CONFIG_USB_DEVICE_CLASS=y
 # CONFIG_USB_DYNAMIC_MINORS is not set
 # CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
 
 #
 # USB Host Controller Drivers
 #
+# CONFIG_USB_C67X00_HCD is not set
 CONFIG_USB_EHCI_HCD=y
 # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 # CONFIG_USB_EHCI_FSL is not set
 CONFIG_USB_EHCI_HCD_PPC_OF=y
 # CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_PPC_OF=y
 CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
@@ -1151,6 +1335,7 @@ CONFIG_USB_OHCI_LITTLE_ENDIAN=y
 #
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -1170,7 +1355,9 @@ CONFIG_USB_STORAGE=y
 # CONFIG_USB_STORAGE_SDDR55 is not set
 # CONFIG_USB_STORAGE_JUMPSHOT is not set
 # CONFIG_USB_STORAGE_ALAUDA is not set
+# CONFIG_USB_STORAGE_ONETOUCH is not set
 # CONFIG_USB_STORAGE_KARMA is not set
+# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
 # CONFIG_USB_LIBUSUAL is not set
 
 #
@@ -1208,10 +1395,12 @@ CONFIG_USB_MON=y
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
 # CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
 # CONFIG_INFINIBAND is not set
 # CONFIG_EDAC is not set
 CONFIG_RTC_LIB=y
@@ -1232,7 +1421,7 @@ CONFIG_RTC_INTF_DEV=y
 #
 # I2C RTC drivers
 #
-# CONFIG_RTC_DRV_DS1307 is not set
+CONFIG_RTC_DRV_DS1307=y
 # CONFIG_RTC_DRV_DS1374 is not set
 # CONFIG_RTC_DRV_DS1672 is not set
 # CONFIG_RTC_DRV_MAX6900 is not set
@@ -1263,11 +1452,8 @@ CONFIG_RTC_DRV_CMOS=y
 #
 # on-CPU RTC drivers
 #
+# CONFIG_RTC_DRV_PPC is not set
 # CONFIG_DMADEVICES is not set
-
-#
-# Userspace I/O
-#
 # CONFIG_UIO is not set
 
 #
@@ -1287,7 +1473,6 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
@@ -1342,6 +1527,7 @@ CONFIG_BEFS_FS=m
 # CONFIG_BEFS_DEBUG is not set
 CONFIG_BFS_FS=m
 CONFIG_EFS_FS=m
+# CONFIG_JFFS2_FS is not set
 CONFIG_CRAMFS=y
 CONFIG_VXFS_FS=m
 # CONFIG_MINIX_FS is not set
@@ -1357,10 +1543,9 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
-# CONFIG_NFS_DIRECTIO is not set
 CONFIG_NFSD=y
 # CONFIG_NFSD_V3 is not set
-CONFIG_NFSD_TCP=y
+# CONFIG_NFSD_V4 is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
@@ -1439,14 +1624,16 @@ CONFIG_NLS_DEFAULT="iso8859-1"
 # CONFIG_NLS_KOI8_U is not set
 CONFIG_NLS_UTF8=m
 # CONFIG_DLM is not set
+# CONFIG_QE_GPIO is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
-# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC_ITU_T=m
 CONFIG_CRC32=y
 # CONFIG_CRC7 is not set
 CONFIG_LIBCRC32C=m
@@ -1455,6 +1642,7 @@ CONFIG_PLIST=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
 CONFIG_HAS_DMA=y
+CONFIG_HAVE_LMB=y
 
 #
 # Kernel hacking
@@ -1462,6 +1650,7 @@ CONFIG_HAS_DMA=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
@@ -1472,6 +1661,7 @@ CONFIG_DETECT_SOFTLOCKUP=y
 CONFIG_SCHED_DEBUG=y
 # CONFIG_SCHEDSTATS is not set
 # CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
 # CONFIG_SLUB_DEBUG_ON is not set
 # CONFIG_SLUB_STATS is not set
 # CONFIG_DEBUG_RT_MUTEXES is not set
@@ -1485,6 +1675,7 @@ CONFIG_SCHED_DEBUG=y
 # CONFIG_DEBUG_BUGVERBOSE is not set
 CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
 # CONFIG_DEBUG_LIST is not set
 # CONFIG_DEBUG_SG is not set
 # CONFIG_BOOT_PRINTK_DELAY is not set
@@ -1497,6 +1688,7 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_DEBUG_PAGEALLOC is not set
 # CONFIG_DEBUGGER is not set
 # CONFIG_KGDB_CONSOLE is not set
+# CONFIG_IRQSTACKS is not set
 # CONFIG_BDI_SWITCH is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
@@ -1507,53 +1699,83 @@ CONFIG_DEBUG_INFO=y
 # CONFIG_SECURITY is not set
 # CONFIG_SECURITY_FILE_CAPABILITIES is not set
 CONFIG_CRYPTO=y
+
+#
+# Crypto core or helper
+#
 CONFIG_CRYPTO_ALGAPI=y
 CONFIG_CRYPTO_BLKCIPHER=y
-# CONFIG_CRYPTO_SEQIV is not set
 CONFIG_CRYPTO_HASH=y
 CONFIG_CRYPTO_MANAGER=y
+# CONFIG_CRYPTO_GF128MUL is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_CRYPTD is not set
+# CONFIG_CRYPTO_AUTHENC is not set
+# CONFIG_CRYPTO_TEST is not set
+
+#
+# Authenticated Encryption with Associated Data
+#
+# CONFIG_CRYPTO_CCM is not set
+# CONFIG_CRYPTO_GCM is not set
+# CONFIG_CRYPTO_SEQIV is not set
+
+#
+# Block modes
+#
+CONFIG_CRYPTO_CBC=y
+# CONFIG_CRYPTO_CTR is not set
+# CONFIG_CRYPTO_CTS is not set
+# CONFIG_CRYPTO_ECB is not set
+# CONFIG_CRYPTO_LRW is not set
+CONFIG_CRYPTO_PCBC=m
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 CONFIG_CRYPTO_HMAC=y
 # CONFIG_CRYPTO_XCBC is not set
-# CONFIG_CRYPTO_NULL is not set
+
+#
+# Digest
+#
+# CONFIG_CRYPTO_CRC32C is not set
 # CONFIG_CRYPTO_MD4 is not set
 CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_MICHAEL_MIC is not set
 CONFIG_CRYPTO_SHA1=m
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-# CONFIG_CRYPTO_ECB is not set
-CONFIG_CRYPTO_CBC=y
-CONFIG_CRYPTO_PCBC=m
-# CONFIG_CRYPTO_LRW is not set
-# CONFIG_CRYPTO_XTS is not set
-# CONFIG_CRYPTO_CTR is not set
-# CONFIG_CRYPTO_GCM is not set
-# CONFIG_CRYPTO_CCM is not set
-# CONFIG_CRYPTO_CRYPTD is not set
-CONFIG_CRYPTO_DES=y
-# CONFIG_CRYPTO_FCRYPT is not set
-# CONFIG_CRYPTO_BLOWFISH is not set
-# CONFIG_CRYPTO_TWOFISH is not set
-# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_WP512 is not set
+
+#
+# Ciphers
+#
 # CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_ANUBIS is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_CAMELLIA is not set
 # CONFIG_CRYPTO_CAST5 is not set
 # CONFIG_CRYPTO_CAST6 is not set
-# CONFIG_CRYPTO_TEA is not set
-# CONFIG_CRYPTO_ARC4 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_FCRYPT is not set
 # CONFIG_CRYPTO_KHAZAD is not set
-# CONFIG_CRYPTO_ANUBIS is not set
-# CONFIG_CRYPTO_SEED is not set
 # CONFIG_CRYPTO_SALSA20 is not set
+# CONFIG_CRYPTO_SEED is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_TEA is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+
+#
+# Compression
+#
 # CONFIG_CRYPTO_DEFLATE is not set
-# CONFIG_CRYPTO_MICHAEL_MIC is not set
-# CONFIG_CRYPTO_CRC32C is not set
-# CONFIG_CRYPTO_CAMELLIA is not set
-# CONFIG_CRYPTO_TEST is not set
-# CONFIG_CRYPTO_AUTHENC is not set
 # CONFIG_CRYPTO_LZO is not set
 CONFIG_CRYPTO_HW=y
 # CONFIG_CRYPTO_DEV_HIFN_795X is not set
 # CONFIG_PPC_CLOCK is not set
 CONFIG_PPC_LIB_RHEAP=y
+# CONFIG_VIRTUALIZATION is not set
