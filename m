Return-Path: <galak@gate.crashing.org>
Date: Mon, 7 Nov 2005 16:17:59 -0600 (CST)
From: galak@gate.crashing.org
To: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0511071614070.15332-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH] ppc32: Update MPC834x platform to work with new phylib
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC834x uses the gianfar network driver which now uses the new phylib.
We need to update the platform code to create a gianfar platform MDIO
bus and pass the right intializations to the gianfar driver to make
things work again.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit bc8310fb525f2174b0a1e3a970da38b664ead6c1
tree 5d692f91fbd625f4413c4f6873292e5f2ecac42c
parent c51e3a417bb0f295e13a5bad86302b5212eafdf3
author Kumar Gala <galak@kernel.crashing.org> Mon, 07 Nov 2005 16:06:56 -0600
committer Kumar Gala <galak@kernel.crashing.org> Mon, 07 Nov 2005 16:06:56 -0600

 arch/ppc/configs/mpc834x_sys_defconfig |  431 +++++++++++++++++++++++---------
 arch/ppc/platforms/83xx/mpc834x_sys.c  |   23 +-
 arch/ppc/syslib/mpc83xx_devices.c      |   12 +
 arch/ppc/syslib/mpc83xx_sys.c          |   24 +-
 include/asm-ppc/mpc83xx.h              |    1 
 5 files changed, 353 insertions(+), 138 deletions(-)

diff --git a/arch/ppc/configs/mpc834x_sys_defconfig b/arch/ppc/configs/mpc834x_sys_defconfig
index 4a5522c..673dc64 100644
--- a/arch/ppc/configs/mpc834x_sys_defconfig
+++ b/arch/ppc/configs/mpc834x_sys_defconfig
@@ -1,16 +1,17 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Thu Feb 17 16:12:23 2005
+# Linux kernel version: 2.6.14
+# Mon Nov  7 15:38:29 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
-CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
 CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
+CONFIG_ARCH_MAY_HAVE_PC_FDC=y
 
 #
 # Code maturity level options
@@ -18,23 +19,28 @@ CONFIG_GENERIC_NVRAM=y
 CONFIG_EXPERIMENTAL=y
 CONFIG_CLEAN_COMPILE=y
 CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 
 #
 # General setup
 #
 CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
 # CONFIG_POSIX_MQUEUE is not set
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
+CONFIG_INITRAMFS_SOURCE=""
 CONFIG_EMBEDDED=y
 # CONFIG_KALLSYMS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 # CONFIG_EPOLL is not set
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -44,6 +50,7 @@ CONFIG_CC_ALIGN_LABELS=0
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -59,34 +66,84 @@ CONFIG_6xx=y
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_E200 is not set
 # CONFIG_E500 is not set
+CONFIG_PPC_FPU=y
+# CONFIG_KEXEC is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
 CONFIG_PPC_GEN550=y
-CONFIG_83xx=y
-
-#
-# Freescale 83xx options
-#
-CONFIG_MPC834x_SYS=y
-CONFIG_MPC834x=y
 CONFIG_PPC_STD_MMU=y
 
 #
 # Platform options
 #
+# CONFIG_PPC_MULTIPLATFORM is not set
+# CONFIG_APUS is not set
+# CONFIG_KATANA is not set
+# CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_CHESTNUT is not set
+# CONFIG_SPRUCE is not set
+# CONFIG_HDPU is not set
+# CONFIG_EV64260 is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_RADSTONE_PPC7D is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBC82xx is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX8260 is not set
+# CONFIG_TQM8260 is not set
+# CONFIG_ADS8272 is not set
+# CONFIG_PQ2FADS is not set
+# CONFIG_LITE5200 is not set
+CONFIG_MPC834x_SYS=y
+# CONFIG_EV64360 is not set
+CONFIG_83xx=y
+CONFIG_MPC834x=y
 # CONFIG_SMP is not set
-# CONFIG_PREEMPT is not set
 # CONFIG_HIGHMEM is not set
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_SPLIT_PTLOCK_CPUS=4
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 # CONFIG_CMDLINE_BOOL is not set
+# CONFIG_PM is not set
+# CONFIG_SOFTWARE_SUSPEND is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
 #
 CONFIG_GENERIC_ISA_DMA=y
-# CONFIG_PCI is not set
-# CONFIG_PCI_DOMAINS is not set
+# CONFIG_PPC_I8259 is not set
+CONFIG_PPC_INDIRECT_PCI=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+# CONFIG_MPC83xx_PCI2 is not set
+CONFIG_PCI_LEGACY_PROC=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -94,10 +151,6 @@ CONFIG_GENERIC_ISA_DMA=y
 # CONFIG_PCCARD is not set
 
 #
-# PC-card bridges
-#
-
-#
 # Advanced setup
 #
 # CONFIG_ADVANCED_OPTIONS is not set
@@ -112,6 +165,75 @@ CONFIG_TASK_SIZE=0x80000000
 CONFIG_BOOT_LOAD=0x00800000
 
 #
+# Networking
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_TUNNEL is not set
+CONFIG_INET_DIAG=y
+CONFIG_INET_TCP_DIAG=y
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_BIC=y
+# CONFIG_IPV6 is not set
+# CONFIG_NETFILTER is not set
+
+#
+# DCCP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_DCCP is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_NET_CLS_ROUTE is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
+
+#
 # Device Drivers
 #
 
@@ -123,6 +245,11 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # CONFIG_FW_LOADER is not set
 
 #
+# Connector - unified userspace <-> kernelspace linker
+#
+# CONFIG_CONNECTOR is not set
+
+#
 # Memory Technology Devices (MTD)
 #
 # CONFIG_MTD is not set
@@ -140,15 +267,19 @@ CONFIG_PREVENT_FIRMWARE_BUILD=y
 # Block devices
 #
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
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=32768
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_LBD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 
@@ -159,6 +290,11 @@ CONFIG_IOSCHED_NOOP=y
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+CONFIG_DEFAULT_AS=y
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+# CONFIG_DEFAULT_NOOP is not set
+CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_ATA_OVER_ETH is not set
 
 #
@@ -169,6 +305,7 @@ CONFIG_IOSCHED_CFQ=y
 #
 # SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 
 #
@@ -179,110 +316,116 @@ CONFIG_IOSCHED_CFQ=y
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
 #
+# CONFIG_IEEE1394 is not set
 
 #
 # I2O device support
 #
+# CONFIG_I2O is not set
 
 #
 # Macintosh device drivers
 #
 
 #
-# Networking support
+# Network device support
 #
-CONFIG_NET=y
-
-#
-# Networking options
-#
-CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
-# CONFIG_NETLINK_DEV is not set
-CONFIG_UNIX=y
-# CONFIG_NET_KEY is not set
-CONFIG_INET=y
-CONFIG_IP_MULTICAST=y
-# CONFIG_IP_ADVANCED_ROUTER is not set
-CONFIG_IP_PNP=y
-CONFIG_IP_PNP_DHCP=y
-CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IP_PNP_RARP is not set
-# CONFIG_NET_IPIP is not set
-# CONFIG_NET_IPGRE is not set
-# CONFIG_IP_MROUTE is not set
-# CONFIG_ARPD is not set
-CONFIG_SYN_COOKIES=y
-# CONFIG_INET_AH is not set
-# CONFIG_INET_ESP is not set
-# CONFIG_INET_IPCOMP is not set
-# CONFIG_INET_TUNNEL is not set
-CONFIG_IP_TCPDIAG=y
-# CONFIG_IP_TCPDIAG_IPV6 is not set
-# CONFIG_IPV6 is not set
-# CONFIG_NETFILTER is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
 
 #
-# SCTP Configuration (EXPERIMENTAL)
+# ARCnet devices
 #
-# CONFIG_IP_SCTP is not set
-# CONFIG_ATM is not set
-# CONFIG_BRIDGE is not set
-# CONFIG_VLAN_8021Q is not set
-# CONFIG_DECNET is not set
-# CONFIG_LLC2 is not set
-# CONFIG_IPX is not set
-# CONFIG_ATALK is not set
-# CONFIG_X25 is not set
-# CONFIG_LAPB is not set
-# CONFIG_NET_DIVERT is not set
-# CONFIG_ECONET is not set
-# CONFIG_WAN_ROUTER is not set
+# CONFIG_ARCNET is not set
 
 #
-# QoS and/or fair queueing
+# PHY device support
 #
-# CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
+CONFIG_PHYLIB=y
 
 #
-# Network testing
+# MII PHY device drivers
 #
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
-CONFIG_NETDEVICES=y
-# CONFIG_DUMMY is not set
-# CONFIG_BONDING is not set
-# CONFIG_EQUALIZER is not set
-# CONFIG_TUN is not set
+CONFIG_MARVELL_PHY=y
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
 
 #
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_CASSINI is not set
+# CONFIG_NET_VENDOR_3COM is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_HP100 is not set
+CONFIG_NET_PCI=y
+# CONFIG_PCNET32 is not set
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+CONFIG_E100=y
+# CONFIG_FEALNX is not set
+# CONFIG_NATSEMI is not set
+# CONFIG_NE2K_PCI is not set
+# CONFIG_8139CP is not set
+# CONFIG_8139TOO is not set
+# CONFIG_SIS900 is not set
+# CONFIG_EPIC100 is not set
+# CONFIG_SUNDANCE is not set
+# CONFIG_TLAN is not set
+# CONFIG_VIA_RHINE is not set
 
 #
 # Ethernet (1000 Mbit)
 #
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+CONFIG_E1000=y
+# CONFIG_E1000_NAPI is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_VIA_VELOCITY is not set
+# CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 # CONFIG_GFAR_NAPI is not set
 
 #
 # Ethernet (10000 Mbit)
 #
+# CONFIG_CHELSIO_T1 is not set
+# CONFIG_IXGB is not set
+# CONFIG_S2IO is not set
 
 #
 # Token Ring devices
 #
+# CONFIG_TR is not set
 
 #
 # Wireless LAN (non-hamradio)
@@ -293,10 +436,14 @@ CONFIG_GIANFAR=y
 # Wan interfaces
 #
 # CONFIG_WAN is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
@@ -323,14 +470,6 @@ CONFIG_INPUT=y
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-# CONFIG_SERIO is not set
-# CONFIG_SERIO_I8042 is not set
-
-#
 # Input Device Drivers
 #
 # CONFIG_INPUT_KEYBOARD is not set
@@ -340,6 +479,12 @@ CONFIG_SOUND_GAMEPORT=y
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
 # Character devices
 #
 # CONFIG_VT is not set
@@ -358,6 +503,7 @@ CONFIG_SERIAL_8250_NR_UARTS=4
 #
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -376,6 +522,7 @@ CONFIG_GEN_RTC=y
 # CONFIG_GEN_RTC_X is not set
 # CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
 
 #
 # Ftape, the floppy tape device driver
@@ -385,6 +532,12 @@ CONFIG_GEN_RTC=y
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+# CONFIG_TELCLOCK is not set
+
+#
 # I2C support
 #
 CONFIG_I2C=y
@@ -400,23 +553,68 @@ CONFIG_I2C_CHARDEV=y
 #
 # I2C Hardware Bus support
 #
-# CONFIG_I2C_ISA is not set
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_PIIX4 is not set
 CONFIG_I2C_MPC=y
+# CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
 # CONFIG_I2C_PCA_ISA is not set
 
 #
-# Hardware Sensors Chip support
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_RTC_X1205_I2C is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+
+#
+# Dallas's 1-wire bus
+#
+# CONFIG_W1 is not set
+
+#
+# Hardware Monitoring support
 #
-# CONFIG_I2C_SENSOR is not set
+CONFIG_HWMON=y
+# CONFIG_HWMON_VID is not set
 # CONFIG_SENSORS_ADM1021 is not set
 # CONFIG_SENSORS_ADM1025 is not set
 # CONFIG_SENSORS_ADM1026 is not set
 # CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
 # CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_ATXP1 is not set
 # CONFIG_SENSORS_DS1621 is not set
 # CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
 # CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
 # CONFIG_SENSORS_IT87 is not set
 # CONFIG_SENSORS_LM63 is not set
 # CONFIG_SENSORS_LM75 is not set
@@ -427,33 +625,26 @@ CONFIG_I2C_MPC=y
 # CONFIG_SENSORS_LM85 is not set
 # CONFIG_SENSORS_LM87 is not set
 # CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_PC87360 is not set
-# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_SIS5595 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_VIA686A is not set
 # CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83792D is not set
 # CONFIG_SENSORS_W83L785TS is not set
 # CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_HWMON_DEBUG_CHIP is not set
 
 #
-# Other I2C Chip support
-#
-# CONFIG_SENSORS_EEPROM is not set
-# CONFIG_SENSORS_PCF8574 is not set
-# CONFIG_SENSORS_PCF8591 is not set
-# CONFIG_SENSORS_RTC8564 is not set
-# CONFIG_I2C_DEBUG_CORE is not set
-# CONFIG_I2C_DEBUG_ALGO is not set
-# CONFIG_I2C_DEBUG_BUS is not set
-# CONFIG_I2C_DEBUG_CHIP is not set
-
-#
-# Dallas's 1-wire bus
+# Misc devices
 #
-# CONFIG_W1 is not set
 
 #
-# Misc devices
+# Multimedia Capabilities Port drivers
 #
 
 #
@@ -479,11 +670,12 @@ CONFIG_I2C_MPC=y
 #
 # USB support
 #
-# CONFIG_USB_ARCH_HAS_HCD is not set
-# CONFIG_USB_ARCH_HAS_OHCI is not set
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+# CONFIG_USB is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
 #
 
 #
@@ -502,10 +694,15 @@ CONFIG_I2C_MPC=y
 # CONFIG_INFINIBAND is not set
 
 #
+# SN Devices
+#
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 CONFIG_EXT3_FS=y
 CONFIG_EXT3_FS_XATTR=y
 # CONFIG_EXT3_FS_POSIX_ACL is not set
@@ -515,17 +712,16 @@ CONFIG_JBD=y
 CONFIG_FS_MBCACHE=y
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
-
-#
-# XFS support
-#
+# CONFIG_FS_POSIX_ACL is not set
 # CONFIG_XFS_FS is not set
 # CONFIG_MINIX_FS is not set
 # CONFIG_ROMFS_FS is not set
+CONFIG_INOTIFY=y
 # CONFIG_QUOTA is not set
 CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
 
 #
 # CD-ROM/DVD Filesystems
@@ -546,12 +742,10 @@ CONFIG_DNOTIFY=y
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-# CONFIG_DEVFS_FS is not set
-# CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_RELAYFS_FS is not set
 
 #
 # Miscellaneous filesystems
@@ -580,6 +774,7 @@ CONFIG_NFS_FS=y
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -588,6 +783,7 @@ CONFIG_SUNRPC=y
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -614,6 +810,7 @@ CONFIG_PARTITION_ADVANCED=y
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 
@@ -625,7 +822,9 @@ CONFIG_CRC32=y
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 
 #
diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c b/arch/ppc/platforms/83xx/mpc834x_sys.c
index 79b3f53..98edc75 100644
--- a/arch/ppc/platforms/83xx/mpc834x_sys.c
+++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
@@ -51,6 +51,9 @@
 
 #include <syslib/ppc83xx_setup.h>
 
+static const char *GFAR_PHY_0 = "phy0:0";
+static const char *GFAR_PHY_1 = "phy0:1";
+
 #ifndef CONFIG_PCI
 unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
@@ -97,6 +100,7 @@ mpc834x_sys_setup_arch(void)
 	bd_t *binfo = (bd_t *) __res;
 	unsigned int freq;
 	struct gianfar_platform_data *pdata;
+	struct gianfar_mdio_data *mdata;
 
 	/* get the core frequency */
 	freq = binfo->bi_intfreq;
@@ -111,24 +115,27 @@ mpc834x_sys_setup_arch(void)
 #endif
 	mpc83xx_early_serial_map();
 
+	/* setup the board related info for the MDIO bus */
+	mdata = (struct gianfar_mdio_data *) ppc_sys_get_pdata(MPC83xx_MDIO);
+
+	mdata->irq[0] = MPC83xx_IRQ_EXT1;
+	mdata->irq[1] = MPC83xx_IRQ_EXT2;
+	mdata->irq[2] = -1;
+	mdata->irq[31] = -1;
+	mdata->paddr += binfo->bi_immr_base;
+
 	/* setup the board related information for the enet controllers */
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC1);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC83xx_IRQ_EXT1;
-		pdata->phyid = 0;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_0;
 		memcpy(pdata->mac_addr, binfo->bi_enetaddr, 6);
 	}
 
 	pdata = (struct gianfar_platform_data *) ppc_sys_get_pdata(MPC83xx_TSEC2);
 	if (pdata) {
 		pdata->board_flags = FSL_GIANFAR_BRD_HAS_PHY_INTR;
-		pdata->interruptPHY = MPC83xx_IRQ_EXT2;
-		pdata->phyid = 1;
-		/* fixup phy address */
-		pdata->phy_reg_addr += binfo->bi_immr_base;
+		pdata->bus_id = GFAR_PHY_1;
 		memcpy(pdata->mac_addr, binfo->bi_enet1addr, 6);
 	}
 
diff --git a/arch/ppc/syslib/mpc83xx_devices.c b/arch/ppc/syslib/mpc83xx_devices.c
index dbf8aca..f43fbf9 100644
--- a/arch/ppc/syslib/mpc83xx_devices.c
+++ b/arch/ppc/syslib/mpc83xx_devices.c
@@ -27,18 +27,20 @@
  * what IMMRBAR is, will get fixed up by mach_mpc83xx_fixup
  */
 
+struct gianfar_mdio_data mpc83xx_mdio_pdata = {
+	.paddr = 0x24520,
+};
+
 static struct gianfar_platform_data mpc83xx_tsec1_pdata = {
 	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
 	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
 	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
-	.phy_reg_addr = 0x24000,
 };
 
 static struct gianfar_platform_data mpc83xx_tsec2_pdata = {
 	.device_flags = FSL_GIANFAR_DEV_HAS_GIGABIT |
 	    FSL_GIANFAR_DEV_HAS_COALESCE | FSL_GIANFAR_DEV_HAS_RMON |
 	    FSL_GIANFAR_DEV_HAS_MULTI_INTR,
-	.phy_reg_addr = 0x24000,
 };
 
 static struct fsl_i2c_platform_data mpc83xx_fsl_i2c1_pdata = {
@@ -220,6 +222,12 @@ struct platform_device ppc_sys_platform_
 			},
 		},
 	},
+	[MPC83xx_MDIO] = {
+		.name = "fsl-gianfar_mdio",
+		.id = 0,
+		.dev.platform_data = &mpc83xx_mdio_pdata,
+		.num_resources = 0,
+	},
 };
 
 static int __init mach_mpc83xx_fixup(struct platform_device *pdev)
diff --git a/arch/ppc/syslib/mpc83xx_sys.c b/arch/ppc/syslib/mpc83xx_sys.c
index 29aa633..da74344 100644
--- a/arch/ppc/syslib/mpc83xx_sys.c
+++ b/arch/ppc/syslib/mpc83xx_sys.c
@@ -24,72 +24,72 @@ struct ppc_sys_spec ppc_sys_specs[] = {
 		.ppc_sys_name	= "8349E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80500000,
-		.num_devices	= 8,
+		.num_devices	= 9,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
 		},
 	},
 	{
 		.ppc_sys_name	= "8349",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80510000,
-		.num_devices	= 7,
+		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
 		},
 	},
 	{
 		.ppc_sys_name	= "8347E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80520000,
-		.num_devices	= 8,
+		.num_devices	= 9,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
 		},
 	},
 	{
 		.ppc_sys_name	= "8347",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80530000,
-		.num_devices	= 7,
+		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR, MPC83xx_USB2_MPH
+			MPC83xx_USB2_DR, MPC83xx_USB2_MPH, MPC83xx_MDIO
 		},
 	},
 	{
 		.ppc_sys_name	= "8343E",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80540000,
-		.num_devices	= 7,
+		.num_devices	= 8,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART, MPC83xx_SEC2,
-			MPC83xx_USB2_DR,
+			MPC83xx_USB2_DR, MPC83xx_MDIO
 		},
 	},
 	{
 		.ppc_sys_name	= "8343",
 		.mask 		= 0xFFFF0000,
 		.value 		= 0x80550000,
-		.num_devices	= 6,
+		.num_devices	= 7,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			MPC83xx_TSEC1, MPC83xx_TSEC2, MPC83xx_IIC1,
 			MPC83xx_IIC2, MPC83xx_DUART,
-			MPC83xx_USB2_DR,
+			MPC83xx_USB2_DR, MPC83xx_MDIO
 		},
 	},
 	{	/* default match */
diff --git a/include/asm-ppc/mpc83xx.h b/include/asm-ppc/mpc83xx.h
index bb1b057..ce21220 100644
--- a/include/asm-ppc/mpc83xx.h
+++ b/include/asm-ppc/mpc83xx.h
@@ -107,6 +107,7 @@ enum ppc_sys_devices {
 	MPC83xx_SEC2,
 	MPC83xx_USB2_DR,
 	MPC83xx_USB2_MPH,
+	MPC83xx_MDIO,
 };
 
 #endif /* CONFIG_83xx */
