Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 85416DE41A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jun 2008 05:32:17 +1000 (EST)
Date: Tue, 10 Jun 2008 23:32:15 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH] powerpc: 83xx: update mpc83xx_defconfig to support
	MPC8360E-RDK
Message-ID: <20080610193215.GA14162@polina.dev.rtsoft.ru>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190049.GE21203@polina.dev.rtsoft.ru>
	<67EC8BE5-3BF0-4107-8FA9-A058283E7EB5@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <67EC8BE5-3BF0-4107-8FA9-A058283E7EB5@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch updates mpc83xx_defconfig to support MPC8360E-RDK board.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---

On Tue, Jun 10, 2008 at 10:55:39AM -0500, Kumar Gala wrote:
[...]
> Can you do me a favor and update mpc83xx_defconfig and make sure that  
> boots and provide that in a separate patch.  I want to start making sure 
> we have whatever features boards need enabled in the mpc83xx_defconfig.

Done. This is on top of your current powerpc-next branch (HEAD
at 917f0af9e5a9ce) + applied patches (seems like you forgot to push
out the tree).

Thus mpc83xx_defconfig wasn't updated for a long time, so the
patch isn't readable.

Here is what I enabled manually:

CONFIG_MPC836x_RDK=y

CONFIG_SERIAL_QE=y
^ it doesn't actually work on RDK (unable to receive the data), but I
believe it's QE firmware issue, not linux's driver. So with appropriate
firmware it should work.

CONFIG_FB=y
CONFIG_FB_FOREIGN_ENDIAN=y
^ RDK's framebuffer is little endian.

CONFIG_FB_BOTH_ENDIAN=y
^ also support big-endian framebuffers, e.g. on a PCI

CONFIG_FB_OF=y
^ we use generic driver for the RDK's framebuffer

CONFIG_MTD_CFI_INTELEXT=y
^ to support NOR flash.

CONFIG_MTD_NAND_FSL_UPM=y
^ RDK's device tree doesn't specify nand yet, but as soon as bindings will
be approved, I'll post an update to the dts.

CONFIG_PCI=y
^ Without this FB_OF driver doesn't build (will send a fix soon).

Other stuff in the patch was auto selected/updated.

For convenience full list of added =y:

CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_GENERIC_GPIO=y
CONFIG_SYSCTL_SYSCALL_CHECK=y
CONFIG_MPC836x_RDK=y
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_FSL_LBC=y
CONFIG_FSL_GTM=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
CONFIG_PCI_SYSCALL=y
CONFIG_ARCH_SUPPORTS_MSI=y
CONFIG_PCI_LEGACY=y
CONFIG_FW_LOADER=y
CONFIG_MTD_CFI_INTELEXT=y
CONFIG_MTD_NAND_FSL_UPM=y
CONFIG_OF_GPIO=y
CONFIG_OF_I2C=y
CONFIG_SERIAL_QE=y
CONFIG_DEVPORT=y
CONFIG_HAVE_GPIO_LIB=y
CONFIG_FB=y
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_FOREIGN_ENDIAN=y
CONFIG_FB_BOTH_ENDIAN=y
CONFIG_FB_MACMODES=y
CONFIG_FB_OF=y
CONFIG_USB_ARCH_HAS_OHCI=y
CONFIG_UCC_SLOW=y
CONFIG_QE_GPIO=y

 arch/powerpc/configs/mpc83xx_defconfig |  382 +++++++++++++++++++++++++++-----
 1 files changed, 321 insertions(+), 61 deletions(-)

diff --git a/arch/powerpc/configs/mpc83xx_defconfig b/arch/powerpc/configs/mpc83xx_defconfig
index 9e0dd82..1d0c6bf 100644
--- a/arch/powerpc/configs/mpc83xx_defconfig
+++ b/arch/powerpc/configs/mpc83xx_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.25-rc9
-# Tue Apr 15 18:07:36 2008
+# Linux kernel version: 2.6.26-rc5
+# Tue Jun 10 23:19:54 2008
 #
 # CONFIG_PPC64 is not set
 
@@ -31,11 +31,14 @@ CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_HARDIRQS=y
 # CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
 CONFIG_IRQ_PER_CPU=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_ARCH_HAS_ILOG2_U32=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_GPIO=y
 # CONFIG_ARCH_NO_VIRT_TO_BUS is not set
 CONFIG_PPC=y
 CONFIG_EARLY_PRINTK=y
@@ -86,6 +89,7 @@ CONFIG_INITRAMFS_SOURCE=""
 CONFIG_SYSCTL=y
 CONFIG_EMBEDDED=y
 CONFIG_SYSCTL_SYSCALL=y
+CONFIG_SYSCTL_SYSCALL_CHECK=y
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_HOTPLUG=y
@@ -111,12 +115,14 @@ CONFIG_HAVE_OPROFILE=y
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
 # CONFIG_MODULE_FORCE_UNLOAD is not set
 # CONFIG_MODVERSIONS is not set
@@ -161,9 +167,11 @@ CONFIG_MPC832x_RDB=y
 CONFIG_MPC834x_MDS=y
 CONFIG_MPC834x_ITX=y
 CONFIG_MPC836x_MDS=y
+CONFIG_MPC836x_RDK=y
 CONFIG_MPC837x_MDS=y
 CONFIG_MPC837x_RDB=y
 CONFIG_SBC834x=y
+# CONFIG_ASP834x is not set
 CONFIG_PPC_MPC831x=y
 CONFIG_PPC_MPC832x=y
 CONFIG_PPC_MPC834x=y
@@ -201,7 +209,6 @@ CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT is not set
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
-CONFIG_FORCE_MAX_ZONEORDER=11
 CONFIG_MATH_EMULATION=y
 # CONFIG_IOMMU_HELPER is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
@@ -217,11 +224,13 @@ CONFIG_FLATMEM=y
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
@@ -235,11 +244,18 @@ CONFIG_ZONE_DMA=y
 CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_FSL_SOC=y
-# CONFIG_PCI is not set
-# CONFIG_PCI_DOMAINS is not set
-# CONFIG_PCI_SYSCALL is not set
-# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_FSL_LBC=y
+CONFIG_FSL_GTM=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_SYSCALL=y
+# CONFIG_PCIEPORTBUS is not set
+CONFIG_ARCH_SUPPORTS_MSI=y
+# CONFIG_PCI_MSI is not set
+CONFIG_PCI_LEGACY=y
 # CONFIG_PCCARD is not set
+# CONFIG_HOTPLUG_PCI is not set
+# CONFIG_HAS_RAPIDIO is not set
 
 #
 # Advanced setup
@@ -249,11 +265,11 @@ CONFIG_FSL_SOC=y
 #
 # Default settings for advanced configuration options are used
 #
-CONFIG_HIGHMEM_START=0xfe000000
 CONFIG_LOWMEM_SIZE=0x30000000
+CONFIG_PAGE_OFFSET=0xc0000000
 CONFIG_KERNEL_START=0xc0000000
+CONFIG_PHYSICAL_START=0x00000000
 CONFIG_TASK_SIZE=0xc0000000
-CONFIG_BOOT_LOAD=0x00800000
 
 #
 # Networking
@@ -301,8 +317,6 @@ CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
 # CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
 # CONFIG_NETWORK_SECMARK is not set
 # CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
@@ -351,7 +365,7 @@ CONFIG_DEFAULT_TCP_CONG="cubic"
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
-# CONFIG_FW_LOADER is not set
+CONFIG_FW_LOADER=y
 # CONFIG_SYS_HYPERVISOR is not set
 # CONFIG_CONNECTOR is not set
 CONFIG_MTD=y
@@ -361,6 +375,7 @@ CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
 CONFIG_MTD_OF_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -392,7 +407,7 @@ CONFIG_MTD_CFI_I1=y
 CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
-# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 # CONFIG_MTD_CFI_STAA is not set
 CONFIG_MTD_CFI_UTIL=y
@@ -406,11 +421,13 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_COMPLEX_MAPPINGS is not set
 # CONFIG_MTD_PHYSMAP is not set
 CONFIG_MTD_PHYSMAP_OF=y
+# CONFIG_MTD_INTEL_VR_NOR is not set
 # CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
 #
+# CONFIG_MTD_PMC551 is not set
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -428,10 +445,12 @@ CONFIG_MTD_NAND_VERIFY_WRITE=y
 # CONFIG_MTD_NAND_MUSEUM_IDS is not set
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_CAFE is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
 # CONFIG_MTD_NAND_PLATFORM is not set
 # CONFIG_MTD_ALAUDA is not set
 CONFIG_MTD_NAND_FSL_ELBC=y
+CONFIG_MTD_NAND_FSL_UPM=y
 # CONFIG_MTD_ONENAND is not set
 
 #
@@ -439,13 +458,20 @@ CONFIG_MTD_NAND_FSL_ELBC=y
 #
 # CONFIG_MTD_UBI is not set
 CONFIG_OF_DEVICE=y
+CONFIG_OF_GPIO=y
+CONFIG_OF_I2C=y
 # CONFIG_PARPORT is not set
 CONFIG_BLK_DEV=y
 # CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
 # CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_SX8 is not set
 # CONFIG_BLK_DEV_UB is not set
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
@@ -454,7 +480,10 @@ CONFIG_BLK_DEV_RAM_SIZE=32768
 # CONFIG_CDROM_PKTCDVD is not set
 # CONFIG_ATA_OVER_ETH is not set
 CONFIG_MISC_DEVICES=y
+# CONFIG_PHANTOM is not set
 # CONFIG_EEPROM_93CX6 is not set
+# CONFIG_SGI_IOC4 is not set
+# CONFIG_TIFM_CORE is not set
 # CONFIG_ENCLOSURE_SERVICES is not set
 CONFIG_HAVE_IDE=y
 # CONFIG_IDE is not set
@@ -498,13 +527,58 @@ CONFIG_SCSI_WAIT_SCAN=m
 # CONFIG_SCSI_SRP_ATTRS is not set
 CONFIG_SCSI_LOWLEVEL=y
 # CONFIG_ISCSI_TCP is not set
+# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
+# CONFIG_SCSI_3W_9XXX is not set
+# CONFIG_SCSI_ACARD is not set
+# CONFIG_SCSI_AACRAID is not set
+# CONFIG_SCSI_AIC7XXX is not set
+# CONFIG_SCSI_AIC7XXX_OLD is not set
+# CONFIG_SCSI_AIC79XX is not set
+# CONFIG_SCSI_AIC94XX is not set
+# CONFIG_SCSI_DPT_I2O is not set
+# CONFIG_SCSI_ADVANSYS is not set
+# CONFIG_SCSI_ARCMSR is not set
+# CONFIG_MEGARAID_NEWGEN is not set
+# CONFIG_MEGARAID_LEGACY is not set
+# CONFIG_MEGARAID_SAS is not set
+# CONFIG_SCSI_HPTIOP is not set
+# CONFIG_SCSI_BUSLOGIC is not set
+# CONFIG_SCSI_DMX3191D is not set
+# CONFIG_SCSI_EATA is not set
+# CONFIG_SCSI_FUTURE_DOMAIN is not set
+# CONFIG_SCSI_GDTH is not set
+# CONFIG_SCSI_IPS is not set
+# CONFIG_SCSI_INITIO is not set
+# CONFIG_SCSI_INIA100 is not set
+# CONFIG_SCSI_MVSAS is not set
+# CONFIG_SCSI_STEX is not set
+# CONFIG_SCSI_SYM53C8XX_2 is not set
+# CONFIG_SCSI_IPR is not set
+# CONFIG_SCSI_QLOGIC_1280 is not set
+# CONFIG_SCSI_QLA_FC is not set
+# CONFIG_SCSI_QLA_ISCSI is not set
+# CONFIG_SCSI_LPFC is not set
+# CONFIG_SCSI_DC395x is not set
+# CONFIG_SCSI_DC390T is not set
+# CONFIG_SCSI_NSP32 is not set
 # CONFIG_SCSI_DEBUG is not set
+# CONFIG_SCSI_SRP is not set
 CONFIG_ATA=y
 # CONFIG_ATA_NONSTANDARD is not set
-# CONFIG_SATA_MV is not set
+# CONFIG_SATA_PMP is not set
+# CONFIG_SATA_AHCI is not set
+# CONFIG_SATA_SIL24 is not set
 CONFIG_SATA_FSL=y
-# CONFIG_PATA_PLATFORM is not set
+# CONFIG_ATA_SFF is not set
 # CONFIG_MD is not set
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_FIREWIRE is not set
+# CONFIG_IEEE1394 is not set
+# CONFIG_I2O is not set
 # CONFIG_MACINTOSH_DRIVERS is not set
 CONFIG_NETDEVICES=y
 # CONFIG_NETDEVICES_MULTIQUEUE is not set
@@ -514,6 +588,7 @@ CONFIG_NETDEVICES=y
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
 # CONFIG_VETH is not set
+# CONFIG_ARCNET is not set
 CONFIG_PHYLIB=y
 
 #
@@ -533,13 +608,36 @@ CONFIG_ICPLUS_PHY=y
 # CONFIG_MDIO_BITBANG is not set
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
 # CONFIG_IBM_NEW_EMAC_ZMII is not set
 # CONFIG_IBM_NEW_EMAC_RGMII is not set
 # CONFIG_IBM_NEW_EMAC_TAH is not set
 # CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_NET_PCI is not set
 # CONFIG_B44 is not set
 CONFIG_NETDEV_1000=y
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_E1000E is not set
 # CONFIG_E1000E_ENABLED is not set
+# CONFIG_IP1000 is not set
+# CONFIG_IGB is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 # CONFIG_GFAR_NAPI is not set
 CONFIG_UCC_GETH=y
@@ -547,13 +645,29 @@ CONFIG_UCC_GETH=y
 # CONFIG_UGETH_MAGIC_PACKET is not set
 # CONFIG_UGETH_FILTERING is not set
 # CONFIG_UGETH_TX_ON_DEMAND is not set
+# CONFIG_QLA3XXX is not set
+# CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_CHELSIO_T3 is not set
+# CONFIG_IXGBE is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
+# CONFIG_MYRI10GE is not set
+# CONFIG_NETXEN_NIC is not set
+# CONFIG_NIU is not set
+# CONFIG_MLX4_CORE is not set
+# CONFIG_TEHUTI is not set
+# CONFIG_BNX2X is not set
+# CONFIG_SFC is not set
+# CONFIG_TR is not set
 
 #
 # Wireless LAN
 #
 # CONFIG_WLAN_PRE80211 is not set
 # CONFIG_WLAN_80211 is not set
+# CONFIG_IWLWIFI_LEDS is not set
 
 #
 # USB Network Adapters
@@ -564,8 +678,11 @@ CONFIG_NETDEV_10000=y
 # CONFIG_USB_RTL8150 is not set
 # CONFIG_USB_USBNET is not set
 # CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
+# CONFIG_NET_FC is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
@@ -607,13 +724,16 @@ CONFIG_INPUT=y
 # Character devices
 #
 # CONFIG_VT is not set
+# CONFIG_DEVKMEM is not set
 # CONFIG_SERIAL_NONSTANDARD is not set
+# CONFIG_NOZOMI is not set
 
 #
 # Serial drivers
 #
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_PCI is not set
 CONFIG_SERIAL_8250_NR_UARTS=4
 CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_8250_EXTENDED is not set
@@ -624,8 +744,9 @@ CONFIG_SERIAL_8250_RUNTIME_UARTS=4
 # CONFIG_SERIAL_UARTLITE is not set
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 # CONFIG_SERIAL_OF_PLATFORM is not set
-# CONFIG_SERIAL_QE is not set
+CONFIG_SERIAL_QE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -635,29 +756,43 @@ CONFIG_LEGACY_PTY_COUNT=256
 CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
+CONFIG_DEVPORT=y
 CONFIG_I2C=y
 CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_CHARDEV=y
 
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
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
 CONFIG_I2C_MPC=y
+# CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_OCORES is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
 # CONFIG_I2C_TAOS_EVM is not set
 # CONFIG_I2C_STUB is not set
 # CONFIG_I2C_TINY_USB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
 
 #
 # Miscellaneous I2C Chip support
@@ -674,12 +809,22 @@ CONFIG_I2C_MPC=y
 # CONFIG_I2C_DEBUG_ALGO is not set
 # CONFIG_I2C_DEBUG_BUS is not set
 # CONFIG_I2C_DEBUG_CHIP is not set
+# CONFIG_SPI is not set
+CONFIG_HAVE_GPIO_LIB=y
 
 #
-# SPI support
+# GPIO Support
+#
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+
+#
+# SPI GPIO expanders:
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
 # CONFIG_W1 is not set
 # CONFIG_POWER_SUPPLY is not set
 CONFIG_HWMON=y
@@ -695,6 +840,7 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_ADT7473 is not set
 # CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_I5K_AMB is not set
 # CONFIG_SENSORS_F71805F is not set
 # CONFIG_SENSORS_F71882FG is not set
 # CONFIG_SENSORS_F75375S is not set
@@ -716,13 +862,16 @@ CONFIG_HWMON=y
 # CONFIG_SENSORS_MAX6650 is not set
 # CONFIG_SENSORS_PC87360 is not set
 # CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_SIS5595 is not set
 # CONFIG_SENSORS_DME1737 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
 # CONFIG_SENSORS_SMSC47M192 is not set
 # CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_ADS7828 is not set
 # CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_VT8231 is not set
 # CONFIG_SENSORS_W83781D is not set
 # CONFIG_SENSORS_W83791D is not set
 # CONFIG_SENSORS_W83792D is not set
@@ -743,6 +892,12 @@ CONFIG_WATCHDOG=y
 CONFIG_83xx_WDT=y
 
 #
+# PCI-based Watchdog Cards
+#
+# CONFIG_PCIPCWATCHDOG is not set
+# CONFIG_WDTPCI is not set
+
+#
 # USB-based Watchdog Cards
 #
 # CONFIG_USBPCWATCHDOG is not set
@@ -757,27 +912,92 @@ CONFIG_SSB_POSSIBLE=y
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
 # CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
+
+#
+# Multimedia drivers
+#
 CONFIG_DAB=y
 # CONFIG_USB_DABUSB is not set
 
 #
 # Graphics support
 #
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
 # CONFIG_VGASTATE is not set
 CONFIG_VIDEO_OUTPUT_CONTROL=m
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+CONFIG_FB_FOREIGN_ENDIAN=y
+CONFIG_FB_BOTH_ENDIAN=y
+# CONFIG_FB_BIG_ENDIAN is not set
+# CONFIG_FB_LITTLE_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+CONFIG_FB_MACMODES=y
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_CIRRUS is not set
+# CONFIG_FB_PM2 is not set
+# CONFIG_FB_CYBER2000 is not set
+CONFIG_FB_OF=y
+# CONFIG_FB_CT65550 is not set
+# CONFIG_FB_ASILIANT is not set
+# CONFIG_FB_IMSTT is not set
+# CONFIG_FB_VGA16 is not set
+# CONFIG_FB_S1D13XXX is not set
+# CONFIG_FB_NVIDIA is not set
+# CONFIG_FB_RIVA is not set
+# CONFIG_FB_MATROX is not set
+# CONFIG_FB_RADEON is not set
+# CONFIG_FB_ATY128 is not set
+# CONFIG_FB_ATY is not set
+# CONFIG_FB_S3 is not set
+# CONFIG_FB_SAVAGE is not set
+# CONFIG_FB_SIS is not set
+# CONFIG_FB_NEOMAGIC is not set
+# CONFIG_FB_KYRO is not set
+# CONFIG_FB_3DFX is not set
+# CONFIG_FB_VOODOO1 is not set
+# CONFIG_FB_VT8623 is not set
+# CONFIG_FB_TRIDENT is not set
+# CONFIG_FB_ARK is not set
+# CONFIG_FB_PM3 is not set
+# CONFIG_FB_FSL_DIU is not set
+# CONFIG_FB_IBM_GXT4500 is not set
+# CONFIG_FB_VIRTUAL is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Display device support
 #
 # CONFIG_DISPLAY_SUPPORT is not set
+# CONFIG_LOGO is not set
 
 #
 # Sound
@@ -797,7 +1017,7 @@ CONFIG_USB_HID=y
 # CONFIG_USB_HIDDEV is not set
 CONFIG_USB_SUPPORT=y
 CONFIG_USB_ARCH_HAS_HCD=y
-# CONFIG_USB_ARCH_HAS_OHCI is not set
+CONFIG_USB_ARCH_HAS_OHCI=y
 CONFIG_USB_ARCH_HAS_EHCI=y
 CONFIG_USB=y
 # CONFIG_USB_DEBUG is not set
@@ -810,16 +1030,22 @@ CONFIG_USB=y
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
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
 # CONFIG_USB_EHCI_TT_NEWSCHED is not set
 CONFIG_USB_EHCI_FSL=y
 CONFIG_USB_EHCI_HCD_PPC_OF=y
 # CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+# CONFIG_USB_OHCI_HCD is not set
+# CONFIG_USB_UHCI_HCD is not set
 # CONFIG_USB_SL811_HCD is not set
 # CONFIG_USB_R8A66597_HCD is not set
 
@@ -828,6 +1054,7 @@ CONFIG_USB_EHCI_HCD_PPC_OF=y
 #
 # CONFIG_USB_ACM is not set
 # CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
 
 #
 # NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
@@ -873,17 +1100,16 @@ CONFIG_USB_MON=y
 # CONFIG_USB_LD is not set
 # CONFIG_USB_TRANCEVIBRATOR is not set
 # CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_ISIGHTFW is not set
 # CONFIG_USB_GADGET is not set
 # CONFIG_MMC is not set
 # CONFIG_MEMSTICK is not set
 # CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+# CONFIG_INFINIBAND is not set
 # CONFIG_EDAC is not set
 # CONFIG_RTC_CLASS is not set
 # CONFIG_DMADEVICES is not set
-
-#
-# Userspace I/O
-#
 # CONFIG_UIO is not set
 
 #
@@ -903,7 +1129,6 @@ CONFIG_FS_MBCACHE=y
 # CONFIG_JFS_FS is not set
 # CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
 CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
@@ -962,7 +1187,6 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 CONFIG_NFS_V4=y
-# CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
@@ -1002,13 +1226,16 @@ CONFIG_MSDOS_PARTITION=y
 # CONFIG_SYSV68_PARTITION is not set
 # CONFIG_NLS is not set
 # CONFIG_DLM is not set
+CONFIG_UCC_SLOW=y
 CONFIG_UCC_FAST=y
 CONFIG_UCC=y
+CONFIG_QE_GPIO=y
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
+# CONFIG_GENERIC_FIND_FIRST_BIT is not set
 # CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
 # CONFIG_CRC_ITU_T is not set
@@ -1027,6 +1254,7 @@ CONFIG_HAVE_LMB=y
 # CONFIG_PRINTK_TIME is not set
 CONFIG_ENABLE_WARN_DEPRECATED=y
 CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
 # CONFIG_MAGIC_SYSRQ is not set
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
@@ -1034,6 +1262,7 @@ CONFIG_ENABLE_MUST_CHECK=y
 # CONFIG_DEBUG_KERNEL is not set
 # CONFIG_DEBUG_BUGVERBOSE is not set
 # CONFIG_SAMPLES is not set
+# CONFIG_IRQSTACKS is not set
 # CONFIG_PPC_EARLY_DEBUG is not set
 
 #
@@ -1043,51 +1272,82 @@ CONFIG_ENABLE_MUST_CHECK=y
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
+# CONFIG_CRYPTO_PCBC is not set
+# CONFIG_CRYPTO_XTS is not set
+
+#
+# Hash modes
+#
 # CONFIG_CRYPTO_HMAC is not set
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
 # CONFIG_CRYPTO_SHA1 is not set
 # CONFIG_CRYPTO_SHA256 is not set
 # CONFIG_CRYPTO_SHA512 is not set
-# CONFIG_CRYPTO_WP512 is not set
 # CONFIG_CRYPTO_TGR192 is not set
-# CONFIG_CRYPTO_GF128MUL is not set
-CONFIG_CRYPTO_ECB=m
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
+# CONFIG_CRYPTO_DEV_HIFN_795X is not set
 # CONFIG_PPC_CLOCK is not set
 CONFIG_PPC_LIB_RHEAP=y
+# CONFIG_VIRTUALIZATION is not set
-- 
1.5.5.4
