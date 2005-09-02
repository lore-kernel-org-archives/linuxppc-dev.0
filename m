Return-Path: <mgreer@mvista.com>
Date: Thu, 1 Sep 2005 17:52:28 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Andrew Morton <akpm@osdl.org>
Message-ID: <20050902005228.GB10106@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.13-mm1] ppc32: katana updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Update the katana platform support code:
- if booted as zImage, pass mem size in via bi_req from bootwrapper
- if booted as uImage, get mem size from bd_info passed in from u-boot
- add support for 82544 present on katana 752i's
- set cacheline size on pci devices
- some minor fixups

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

diff -Nur linux-2.6.13-mm1/arch/ppc/boot/simple/misc-katana.c linux-2.6.13-mm1-mag/arch/ppc/boot/simple/misc-katana.c
--- linux-2.6.13-mm1/arch/ppc/boot/simple/misc-katana.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/boot/simple/misc-katana.c	2005-09-01 17:00:31.000000000 -0700
@@ -26,6 +26,8 @@
 #define	min(a,b)	(((a) < (b)) ? (a) : (b))
 #endif
 
+unsigned long mv64360_get_mem_size(void);
+
 void
 mv64x60_board_init(void __iomem *old_base, void __iomem *new_base)
 {
@@ -35,3 +37,9 @@
 		min(katana_bus_freq((void __iomem *)KATANA_CPLD_BASE),
 			MV64x60_TCLK_FREQ_MAX);
 }
+
+unsigned long
+get_mem_size(void)
+{
+	return mv64360_get_mem_size();
+}
diff -Nur linux-2.6.13-mm1/arch/ppc/configs/katana_defconfig linux-2.6.13-mm1-mag/arch/ppc/configs/katana_defconfig
--- linux-2.6.13-mm1/arch/ppc/configs/katana_defconfig	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/configs/katana_defconfig	2005-09-01 17:16:09.000000000 -0700
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11
-# Tue Mar  8 17:31:00 2005
+# Linux kernel version: 2.6.13-mm1
+# Thu Sep  1 17:16:03 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -11,6 +11,7 @@
 CONFIG_PPC=y
 CONFIG_PPC32=y
 CONFIG_GENERIC_NVRAM=y
+CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
 
 #
 # Code maturity level options
@@ -18,28 +19,31 @@
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
 # CONFIG_EMBEDDED is not set
 CONFIG_KALLSYMS=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_PRINTK=y
+CONFIG_BUG=y
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
 CONFIG_SHMEM=y
 CONFIG_CC_ALIGN_FUNCTIONS=0
 CONFIG_CC_ALIGN_LABELS=0
@@ -68,15 +72,23 @@
 # CONFIG_POWER3 is not set
 # CONFIG_POWER4 is not set
 # CONFIG_8xx is not set
+# CONFIG_E200 is not set
 # CONFIG_E500 is not set
+CONFIG_PPC_FPU=y
 CONFIG_ALTIVEC=y
 # CONFIG_TAU is not set
+# CONFIG_KEXEC is not set
 # CONFIG_CPU_FREQ is not set
-# CONFIG_83xx is not set
+# CONFIG_WANT_EARLY_SERIAL is not set
 CONFIG_PPC_STD_MMU=y
 CONFIG_NOT_COHERENT_CACHE=y
 
 #
+# Performance-monitoring counters support
+#
+# CONFIG_PERFCTR is not set
+
+#
 # Platform options
 #
 # CONFIG_PPC_MULTIPLATFORM is not set
@@ -84,21 +96,18 @@
 CONFIG_KATANA=y
 # CONFIG_WILLOW is not set
 # CONFIG_CPCI690 is not set
-# CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
 # CONFIG_CHESTNUT is not set
 # CONFIG_SPRUCE is not set
+# CONFIG_HDPU is not set
 # CONFIG_EV64260 is not set
 # CONFIG_LOPEC is not set
-# CONFIG_MCPN765 is not set
 # CONFIG_MVME5100 is not set
 # CONFIG_PPLUS is not set
 # CONFIG_PRPMC750 is not set
 # CONFIG_PRPMC800 is not set
 # CONFIG_SANDPOINT is not set
 # CONFIG_RADSTONE_PPC7D is not set
-# CONFIG_ADIR is not set
-# CONFIG_K2 is not set
 # CONFIG_PAL4 is not set
 # CONFIG_GEMINI is not set
 # CONFIG_EST8260 is not set
@@ -109,6 +118,8 @@
 # CONFIG_ADS8272 is not set
 # CONFIG_PQ2FADS is not set
 # CONFIG_LITE5200 is not set
+# CONFIG_MPC834x_SYS is not set
+# CONFIG_EV64360 is not set
 CONFIG_MV64360=y
 CONFIG_MV64X60=y
 
@@ -118,12 +129,28 @@
 CONFIG_MV64X60_BASE=0xf8100000
 CONFIG_MV64X60_NEW_BASE=0xf8100000
 # CONFIG_SMP is not set
+CONFIG_HIGHMEM=y
+# CONFIG_HZ_100 is not set
+CONFIG_HZ_250=y
+# CONFIG_HZ_1000 is not set
+CONFIG_HZ=250
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
-# CONFIG_HIGHMEM is not set
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+# CONFIG_SPARSEMEM_STATIC is not set
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_CMDLINE_BOOL=y
-CONFIG_CMDLINE="console=ttyMM0,9600 ip=on"
+CONFIG_CMDLINE="console=ttyMM0 ip=on"
+# CONFIG_PM is not set
+CONFIG_SECCOMP=y
+CONFIG_ISA_DMA_API=y
 
 #
 # Bus options
@@ -132,7 +159,6 @@
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 CONFIG_PCI_LEGACY_PROC=y
-CONFIG_PCI_NAMES=y
 
 #
 # PCCARD (PCMCIA/CardBus) support
@@ -140,13 +166,10 @@
 # CONFIG_PCCARD is not set
 
 #
-# PC-card bridges
-#
-
-#
 # Advanced setup
 #
 CONFIG_ADVANCED_OPTIONS=y
+# CONFIG_HIGHMEM_START_BOOL is not set
 CONFIG_HIGHMEM_START=0xfe000000
 # CONFIG_LOWMEM_SIZE_BOOL is not set
 CONFIG_LOWMEM_SIZE=0x30000000
@@ -162,6 +185,76 @@
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
+# CONFIG_IP_PNP_BOOTP is not set
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
+# CONFIG_NETFILTER_NETLINK is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_IEEE80211 is not set
+
+#
 # Device Drivers
 #
 
@@ -177,8 +270,8 @@
 #
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CONCAT=y
+CONFIG_MTD_PARTITIONS=y
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
 
@@ -212,6 +305,7 @@
 CONFIG_MTD_CFI_I2=y
 # CONFIG_MTD_CFI_I4 is not set
 # CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_OTP is not set
 CONFIG_MTD_CFI_INTELEXT=y
 # CONFIG_MTD_CFI_AMDSTD is not set
 # CONFIG_MTD_CFI_STAA is not set
@@ -219,7 +313,6 @@
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_XIP is not set
 
 #
 # Mapping drivers for chip access
@@ -229,6 +322,7 @@
 CONFIG_MTD_PHYSMAP_START=0xe0000000
 CONFIG_MTD_PHYSMAP_LEN=0x0
 CONFIG_MTD_PHYSMAP_BANKWIDTH=4
+# CONFIG_MTD_PLATRAM is not set
 
 #
 # Self-contained MTD device drivers
@@ -278,7 +372,6 @@
 CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE=""
 # CONFIG_LBD is not set
 # CONFIG_CDROM_PKTCDVD is not set
 
@@ -299,6 +392,7 @@
 #
 # SCSI device support
 #
+# CONFIG_RAID_ATTRS is not set
 # CONFIG_SCSI is not set
 
 #
@@ -309,6 +403,7 @@
 #
 # Fusion MPT device support
 #
+# CONFIG_FUSION is not set
 
 #
 # IEEE 1394 (FireWire) support
@@ -325,71 +420,8 @@
 #
 
 #
-# Networking support
-#
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
-# CONFIG_IP_PNP_BOOTP is not set
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
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
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
-
-#
-# QoS and/or fair queueing
-#
-# CONFIG_NET_SCHED is not set
-# CONFIG_NET_CLS_ROUTE is not set
-
-#
-# Network testing
+# Network device support
 #
-# CONFIG_NET_PKTGEN is not set
-# CONFIG_NETPOLL is not set
-# CONFIG_NET_POLL_CONTROLLER is not set
-# CONFIG_HAMRADIO is not set
-# CONFIG_IRDA is not set
-# CONFIG_BT is not set
 CONFIG_NETDEVICES=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
@@ -402,6 +434,11 @@
 # CONFIG_ARCNET is not set
 
 #
+# PHY device support
+#
+# CONFIG_PHYLIB is not set
+
+#
 # Ethernet (10 or 100Mbit)
 #
 CONFIG_NET_ETHERNET=y
@@ -422,6 +459,7 @@
 # CONFIG_DE4X5 is not set
 # CONFIG_WINBOND_840 is not set
 # CONFIG_DM9102 is not set
+# CONFIG_ULI526X is not set
 # CONFIG_HP100 is not set
 CONFIG_NET_PCI=y
 # CONFIG_PCNET32 is not set
@@ -448,14 +486,19 @@
 #
 # CONFIG_ACENIC is not set
 # CONFIG_DL2K is not set
-# CONFIG_E1000 is not set
+CONFIG_E1000=y
+# CONFIG_E1000_NAPI is not set
 # CONFIG_NS83820 is not set
 # CONFIG_HAMACHI is not set
 # CONFIG_YELLOWFIN is not set
 # CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SKGE is not set
+# CONFIG_SKY2 is not set
 # CONFIG_SK98LIN is not set
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
+# CONFIG_BNX2 is not set
 CONFIG_MV643XX_ETH=y
 CONFIG_MV643XX_ETH_0=y
 CONFIG_MV643XX_ETH_1=y
@@ -464,6 +507,7 @@
 #
 # Ethernet (10000 Mbit)
 #
+# CONFIG_CHELSIO_T1 is not set
 # CONFIG_IXGB is not set
 # CONFIG_S2IO is not set
 
@@ -487,6 +531,11 @@
 # CONFIG_SLIP is not set
 # CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
+# CONFIG_KGDBOE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NETPOLL_RX is not set
+# CONFIG_NETPOLL_TRAP is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
 
 #
 # ISDN subsystem
@@ -516,14 +565,6 @@
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
@@ -533,6 +574,12 @@
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
 CONFIG_VT=y
@@ -552,6 +599,7 @@
 CONFIG_SERIAL_MPSC_CONSOLE=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_JSM is not set
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -580,6 +628,11 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
 # I2C support
 #
 CONFIG_I2C=y
@@ -602,11 +655,10 @@
 # CONFIG_I2C_AMD8111 is not set
 # CONFIG_I2C_I801 is not set
 # CONFIG_I2C_I810 is not set
-# CONFIG_I2C_ISA is not set
+# CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_MPC is not set
 # CONFIG_I2C_NFORCE2 is not set
 # CONFIG_I2C_PARPORT_LIGHT is not set
-# CONFIG_I2C_PIIX4 is not set
 # CONFIG_I2C_PROSAVAGE is not set
 # CONFIG_I2C_SAVAGE4 is not set
 # CONFIG_SCx200_ACB is not set
@@ -621,14 +673,39 @@
 CONFIG_I2C_MV64XXX=y
 
 #
-# Hardware Sensors Chip support
+# Miscellaneous I2C Chip support
 #
-# CONFIG_I2C_SENSOR is not set
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+CONFIG_SENSORS_M41T00=y
+# CONFIG_SENSORS_MAX6875 is not set
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
+#
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
 # CONFIG_SENSORS_FSCPOS is not set
@@ -644,36 +721,26 @@
 # CONFIG_SENSORS_LM85 is not set
 # CONFIG_SENSORS_LM87 is not set
 # CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
 # CONFIG_SENSORS_MAX1619 is not set
 # CONFIG_SENSORS_PC87360 is not set
-# CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_SIS5595 is not set
 # CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
 # CONFIG_SENSORS_VIA686A is not set
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
-CONFIG_SENSORS_M41T00=y
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
@@ -698,6 +765,11 @@
 CONFIG_DUMMY_CONSOLE=y
 
 #
+# Speakup console speech
+#
+# CONFIG_SPEAKUP is not set
+
+#
 # Sound
 #
 # CONFIG_SOUND is not set
@@ -705,13 +777,9 @@
 #
 # USB support
 #
-# CONFIG_USB is not set
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
+# CONFIG_USB is not set
 
 #
 # USB Gadget Support
@@ -729,25 +797,39 @@
 # CONFIG_INFINIBAND is not set
 
 #
+# SN Devices
+#
+
+#
+# Distributed Lock Manager
+#
+# CONFIG_DLM is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
 # CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
 # CONFIG_EXT3_FS is not set
-# CONFIG_JBD is not set
+# CONFIG_REISER4_FS is not set
 # CONFIG_REISERFS_FS is not set
 # CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
 
 #
 # XFS support
 #
 # CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
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
@@ -768,20 +850,18 @@
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_SYSFS=y
-CONFIG_DEVFS_FS=y
-# CONFIG_DEVFS_MOUNT is not set
-# CONFIG_DEVFS_DEBUG is not set
-# CONFIG_DEVPTS_FS_XATTR is not set
 CONFIG_TMPFS=y
-# CONFIG_TMPFS_XATTR is not set
 # CONFIG_HUGETLB_PAGE is not set
 CONFIG_RAMFS=y
+# CONFIG_CONFIGFS_FS is not set
+# CONFIG_RELAYFS_FS is not set
 
 #
 # Miscellaneous filesystems
 #
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
+# CONFIG_ASFS_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
@@ -801,12 +881,14 @@
 #
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
 # CONFIG_NFS_DIRECTIO is not set
 # CONFIG_NFSD is not set
 CONFIG_ROOT_NFS=y
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
@@ -815,6 +897,7 @@
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
+# CONFIG_9P_FS is not set
 
 #
 # Partition Types
@@ -831,6 +914,7 @@
 # Library routines
 #
 # CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
 CONFIG_CRC32=y
 # CONFIG_LIBCRC32C is not set
 
@@ -842,8 +926,10 @@
 #
 # Kernel hacking
 #
-# CONFIG_DEBUG_KERNEL is not set
 # CONFIG_PRINTK_TIME is not set
+# CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
+# CONFIG_SERIAL_TEXT_DEBUG is not set
 
 #
 # Security options
diff -Nur linux-2.6.13-mm1/arch/ppc/platforms/katana.c linux-2.6.13-mm1-mag/arch/ppc/platforms/katana.c
--- linux-2.6.13-mm1/arch/ppc/platforms/katana.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/platforms/katana.c	2005-09-01 17:00:31.000000000 -0700
@@ -33,6 +33,7 @@
 #include <linux/bootimg.h>
 #endif
 #include <asm/io.h>
+#include <asm/unistd.h>
 #include <asm/page.h>
 #include <asm/time.h>
 #include <asm/smp.h>
@@ -42,15 +43,14 @@
 #include <asm/mv64x60.h>
 #include <platforms/katana.h>
 
-static struct		mv64x60_handle bh;
-static katana_id_t	katana_id;
-static void __iomem	*cpld_base;
-static void __iomem	*sram_base;
-
-static u32		katana_flash_size_0;
-static u32		katana_flash_size_1;
-
-static u32		katana_bus_frequency;
+static struct mv64x60_handle	bh;
+static katana_id_t		katana_id;
+static void __iomem		*cpld_base;
+static void __iomem		*sram_base;
+static u32			katana_flash_size_0;
+static u32			katana_flash_size_1;
+static u32			katana_bus_frequency;
+static struct pci_controller	katana_hose_a;
 
 unsigned char	__res[sizeof(bd_t)];
 
@@ -71,8 +71,12 @@
 			KATANA_PCI_INTA_IRQ_750i, KATANA_PCI_INTB_IRQ_750i },
 		/* IDSEL 6 (T8110) */
 		{KATANA_PCI_INTD_IRQ_750i, 0, 0, 0 },
+		/* IDSEL 7 (unused) */
+		{0, 0, 0, 0 },
+		/* IDSEL 8 (Intel 82544) (752i only but doesn't harm 750i) */
+		{KATANA_PCI_INTD_IRQ_750i, 0, 0, 0 },
 	};
-	const long min_idsel = 4, max_idsel = 6, irqs_per_slot = 4;
+	const long min_idsel = 4, max_idsel = 8, irqs_per_slot = 4;
 
 	return PCI_IRQ_TABLE_LOOKUP;
 }
@@ -148,7 +152,7 @@
 			save_exclude = mv64x60_pci_exclude_bridge;
 			mv64x60_pci_exclude_bridge = 0;
 
-			early_read_config_word(bh.hose_a, 0,
+			early_read_config_word(bh.hose_b, 0,
 				PCI_DEVFN(0,0), PCI_DEVICE_ID, &val);
 
 			mv64x60_pci_exclude_bridge = save_exclude;
@@ -191,7 +195,8 @@
 	struct mv64x60_setup_info si;
 	void __iomem *vaddr;
 	int i;
-	u16 val;
+	u32 v;
+	u16 val, type;
 	u8 save_exclude;
 
 	/*
@@ -222,6 +227,20 @@
 			PCI_DEVICE_ID, val);
 	}
 
+	/*
+	 * While we're in here, set the hotswap register correctly.
+	 * Turn off blue LED; mask ENUM#, clear insertion & extraction bits.
+	 */
+	early_read_config_dword(&hose, 0, PCI_DEVFN(0, 0),
+		MV64360_PCICFG_CPCI_HOTSWAP, &v);
+	v &= ~(1<<19);
+	v |= ((1<<17) | (1<<22) | (1<<23));
+	early_write_config_dword(&hose, 0, PCI_DEVFN(0, 0),
+		MV64360_PCICFG_CPCI_HOTSWAP, v);
+
+	/* While we're at it, grab the bridge type for later */
+	early_read_config_word(&hose, 0, PCI_DEVFN(0, 0), PCI_DEVICE_ID, &type);
+
 	mv64x60_pci_exclude_bridge = save_exclude;
 	iounmap(vaddr);
 
@@ -251,21 +270,23 @@
 		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE;
 
 		si.pci_1.acc_cntl_options[i] =
-		    MV64360_PCI_ACC_CNTL_SNOOP_NONE |
-		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
-		    MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
-		    MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
+			MV64360_PCI_ACC_CNTL_SNOOP_NONE |
+			MV64360_PCI_ACC_CNTL_SWAP_NONE |
+			MV64360_PCI_ACC_CNTL_MBURST_128_BYTES |
+			MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES;
 #else
 		si.cpu_prot_options[i] = 0;
-		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_NONE; /* errata */
-		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_NONE; /* errata */
-		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_NONE; /* errata */
+		si.enet_options[i] = MV64360_ENET2MEM_SNOOP_WB;
+		si.mpsc_options[i] = MV64360_MPSC2MEM_SNOOP_WB;
+		si.idma_options[i] = MV64360_IDMA2MEM_SNOOP_WB;
 
 		si.pci_1.acc_cntl_options[i] =
-		    MV64360_PCI_ACC_CNTL_SNOOP_WB |
-		    MV64360_PCI_ACC_CNTL_SWAP_NONE |
-		    MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
-		    MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES;
+			MV64360_PCI_ACC_CNTL_SNOOP_WB |
+			MV64360_PCI_ACC_CNTL_SWAP_NONE |
+			MV64360_PCI_ACC_CNTL_MBURST_32_BYTES |
+			((type == PCI_DEVICE_ID_MARVELL_MV64360) ?
+				MV64360_PCI_ACC_CNTL_RDSIZE_32_BYTES :
+				MV64360_PCI_ACC_CNTL_RDSIZE_256_BYTES);
 #endif
 	}
 
@@ -281,12 +302,26 @@
 	mv64x60_set_bus(&bh, 1, 0);
 	bh.hose_b->first_busno = 0;
 	bh.hose_b->last_busno = 0xff;
+
+	/*
+	 * Need to access hotswap reg which is in the pci config area of the
+	 * bridge's hose 0.  Note that pcibios_alloc_controller() can't be used
+	 * to alloc hose_a b/c that would make hose 0 known to the generic
+	 * pci code which we don't want.
+	 */
+	bh.hose_a = &katana_hose_a;
+	setup_indirect_pci_nomap(bh.hose_a,
+		bh.v_base + MV64x60_PCI0_CONFIG_ADDR,
+		bh.v_base + MV64x60_PCI0_CONFIG_DATA);
 }
 
 /* Bridge & platform setup routines */
 void __init
 katana_intr_setup(void)
 {
+	if (bh.type == MV64x60_TYPE_MV64460) /* As per instns from Marvell */
+		mv64x60_clr_bits(&bh, MV64x60_CPU_MASTER_CNTL, 1 << 15);
+
 	/* MPP 8, 9, and 10 */
 	mv64x60_clr_bits(&bh, MV64x60_MPP_CNTL_1, 0xfff);
 
@@ -309,9 +344,16 @@
 	/* Config GPP intr ctlr to respond to level trigger */
 	mv64x60_set_bits(&bh, MV64x60_COMM_ARBITER_CNTL, (1<<10));
 
-	/* Erranum FEr PCI-#8 */
-	mv64x60_clr_bits(&bh, MV64x60_PCI0_CMD, (1<<5) | (1<<9));
-	mv64x60_clr_bits(&bh, MV64x60_PCI1_CMD, (1<<5) | (1<<9));
+	if (bh.type == MV64x60_TYPE_MV64360) {
+		/* Erratum FEr PCI-#9 */
+		mv64x60_clr_bits(&bh, MV64x60_PCI1_CMD,
+				(1<<4) | (1<<5) | (1<<6) | (1<<7));
+		mv64x60_set_bits(&bh, MV64x60_PCI1_CMD, (1<<8) | (1<<9));
+	} else {
+		mv64x60_clr_bits(&bh, MV64x60_PCI1_CMD, (1<<6) | (1<<7));
+		mv64x60_set_bits(&bh, MV64x60_PCI1_CMD,
+				(1<<4) | (1<<5) | (1<<8) | (1<<9));
+	}
 
 	/*
 	 * Dismiss and then enable interrupt on GPP interrupt cause
@@ -473,17 +515,46 @@
 		ppc_md.progress("katana_setup_arch: exit", 0);
 }
 
+void
+katana_fixup_resources(struct pci_dev *dev)
+{
+	u16	v16;
+
+	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, L1_CACHE_LINE_SIZE>>2);
+
+	pci_read_config_word(dev, PCI_COMMAND, &v16);
+	v16 |= PCI_COMMAND_INVALIDATE | PCI_COMMAND_FAST_BACK;
+	pci_write_config_word(dev, PCI_COMMAND, v16);
+}
+
+static const unsigned int cpu_750xx[32] = { /* 750FX & 750GX */
+	 0,  0,  2,  2,  4,  5,  6,  7,  8,  9, 10, 11, 12, 13, 14, 15,/* 0-15*/
+	16, 17, 18, 19, 20, 22, 24, 26, 28, 30, 32, 34, 36, 38, 40,  0 /*16-31*/
+};
+
+static int
+katana_get_cpu_freq(void)
+{
+	unsigned long	pll_cfg;
+
+	pll_cfg = (mfspr(SPRN_HID1) & 0xf8000000) >> 27;
+	return katana_bus_frequency * cpu_750xx[pll_cfg]/2;
+}
+
 /* Platform device data fixup routines. */
 #if defined(CONFIG_SERIAL_MPSC)
 static void __init
 katana_fixup_mpsc_pdata(struct platform_device *pdev)
 {
-	struct mpsc_pdata *pdata;
+	struct mpsc_pdata *pdata = (struct mpsc_pdata *)pdev->dev.platform_data;
+	bd_t *bdp = (bd_t *)__res;
 
-	pdata = (struct mpsc_pdata *)pdev->dev.platform_data;
+	if (bdp->bi_baudrate)
+		pdata->default_baud = bdp->bi_baudrate;
+	else
+		pdata->default_baud = KATANA_DEFAULT_BAUD;
 
 	pdata->max_idle = 40;
-	pdata->default_baud = KATANA_DEFAULT_BAUD;
 	pdata->brg_clk_src = KATANA_MPSC_CLK_SRC;
 	/*
 	 * TCLK (not SysCLk) is routed to BRG, then to the MPSC.  On most parts,
@@ -513,6 +584,18 @@
 }
 #endif
 
+#if defined(CONFIG_SYSFS)
+static void __init
+katana_fixup_mv64xxx_pdata(struct platform_device *pdev)
+{
+	struct mv64xxx_pdata *pdata = (struct mv64xxx_pdata *)
+		pdev->dev.platform_data;
+
+	/* Katana supports the mv64xxx hotswap register */
+	pdata->hs_reg_valid = 1;
+}
+#endif
+
 static int __init
 katana_platform_notify(struct device *dev)
 {
@@ -529,6 +612,9 @@
 		{ MV643XX_ETH_NAME ".1", katana_fixup_eth_pdata },
 		{ MV643XX_ETH_NAME ".2", katana_fixup_eth_pdata },
 #endif
+#if defined(CONFIG_SYSFS)
+		{ MV64XXX_DEV_NAME ".0", katana_fixup_mv64xxx_pdata },
+#endif
 	};
 	struct platform_device	*pdev;
 	int	i;
@@ -536,8 +622,7 @@
 	if (dev && dev->bus_id)
 		for (i=0; i<ARRAY_SIZE(dev_map); i++)
 			if (!strncmp(dev->bus_id, dev_map[i].bus_id,
-				BUS_ID_SIZE)) {
-
+					BUS_ID_SIZE)) {
 				pdev = container_of(dev,
 					struct platform_device, dev);
 				dev_map[i].rtn(pdev);
@@ -578,8 +663,7 @@
 	ptbl_entries = (size >= (64*MB)) ? 6 : 4;
 
 	if ((ptbl = kmalloc(ptbl_entries * sizeof(struct mtd_partition),
-		GFP_KERNEL)) == NULL) {
-
+			GFP_KERNEL)) == NULL) {
 		printk(KERN_WARNING "Can't alloc MTD partition table\n");
 		return -ENOMEM;
 	}
@@ -611,7 +695,6 @@
 	physmap_set_partitions(ptbl, ptbl_entries);
 	return 0;
 }
-
 arch_initcall(katana_setup_mtd);
 #endif
 
@@ -632,7 +715,22 @@
 {
 	u8	v;
 
-	if (katana_id == KATANA_ID_752I) {
+	/* Turn on blue LED to indicate its okay to remove */
+	if (katana_id == KATANA_ID_750I) {
+		u32	v;
+		u8	save_exclude;
+
+		/* Set LOO bit in cPCI HotSwap reg of hose 0 to turn on LED. */
+		save_exclude = mv64x60_pci_exclude_bridge;
+		mv64x60_pci_exclude_bridge = 0;
+		early_read_config_dword(bh.hose_a, 0, PCI_DEVFN(0, 0),
+			MV64360_PCICFG_CPCI_HOTSWAP, &v);
+		v &= 0xff;
+		v |= (1 << 19);
+		early_write_config_dword(bh.hose_a, 0, PCI_DEVFN(0, 0),
+			MV64360_PCICFG_CPCI_HOTSWAP, v);
+		mv64x60_pci_exclude_bridge = save_exclude;
+	} else if (katana_id == KATANA_ID_752I) {
 		   v = in_8(cpld_base + HSL_PLD_BASE + HSL_PLD_HOT_SWAP_OFF);
 		   v |= HSL_PLD_HOT_SWAP_LED_BIT;
 		   out_8(cpld_base + HSL_PLD_BASE + HSL_PLD_HOT_SWAP_OFF, v);
@@ -652,37 +750,65 @@
 static int
 katana_show_cpuinfo(struct seq_file *m)
 {
+	char	*s;
+
+	seq_printf(m, "cpu freq\t: %dMHz\n",
+		(katana_get_cpu_freq() + 500000) / 1000000);
+	seq_printf(m, "bus freq\t: %ldMHz\n",
+		((long)katana_bus_frequency + 500000) / 1000000);
 	seq_printf(m, "vendor\t\t: Artesyn Communication Products, LLC\n");
 
 	seq_printf(m, "board\t\t: ");
-
 	switch (katana_id) {
 	case KATANA_ID_3750:
-		seq_printf(m, "Katana 3750\n");
+		seq_printf(m, "Katana 3750");
 		break;
 
 	case KATANA_ID_750I:
-		seq_printf(m, "Katana 750i\n");
+		seq_printf(m, "Katana 750i");
 		break;
 
 	case KATANA_ID_752I:
-		seq_printf(m, "Katana 752i\n");
+		seq_printf(m, "Katana 752i");
 		break;
 
 	default:
-		seq_printf(m, "Unknown\n");
+		seq_printf(m, "Unknown");
 		break;
 	}
-
-	seq_printf(m, "product ID\t: 0x%x\n",
+	seq_printf(m, " (product id: 0x%x)\n",
 		   in_8(cpld_base + KATANA_CPLD_PRODUCT_ID));
+
+	seq_printf(m, "pci mode\t: %sMonarch\n",
+		katana_is_monarch()? "" : "Non-");
 	seq_printf(m, "hardware rev\t: 0x%x\n",
 		   in_8(cpld_base+KATANA_CPLD_HARDWARE_VER));
-	seq_printf(m, "PLD rev\t\t: 0x%x\n",
+	seq_printf(m, "pld rev\t\t: 0x%x\n",
 		   in_8(cpld_base + KATANA_CPLD_PLD_VER));
-	seq_printf(m, "PLB freq\t: %ldMhz\n",
-		(long)katana_bus_frequency / 1000000);
-	seq_printf(m, "PCI\t\t: %sMonarch\n", katana_is_monarch()? "" : "Non-");
+
+	switch(bh.type) {
+	case MV64x60_TYPE_GT64260A:
+		s = "gt64260a";
+		break;
+	case MV64x60_TYPE_GT64260B:
+		s = "gt64260b";
+		break;
+	case MV64x60_TYPE_MV64360:
+		s = "mv64360";
+		break;
+	case MV64x60_TYPE_MV64460:
+		s = "mv64460";
+		break;
+	default:
+		s = "Unknown";
+	}
+	seq_printf(m, "bridge type\t: %s\n", s);
+	seq_printf(m, "bridge rev\t: 0x%x\n", bh.rev);
+#if defined(CONFIG_NOT_COHERENT_CACHE)
+	seq_printf(m, "coherency\t: %s\n", "off");
+#else
+	seq_printf(m, "coherency\t: %s\n", "on");
+#endif
 
 	return 0;
 }
@@ -701,11 +827,20 @@
 	tb_to_us = mulhwu_scale_factor(freq, 1000000);
 }
 
+/*
+ * The katana supports both uImage and zImage.  If uImage, get the mem size
+ * from the bd info.  If zImage, the bootwrapper adds a BI_MEMSIZE entry in
+ * the bi_rec data which is sucked out and put into boot_mem_size by
+ * parse_bootinfo().  MMU_init() will then use the boot_mem_size for the mem
+ * size and not call this routine.  The only way this will fail is when a uImage
+ * is used but the fw doesn't pass in a valid bi_memsize.  This should never
+ * happen, though.
+ */
 unsigned long __init
 katana_find_end_of_memory(void)
 {
-	return mv64x60_get_mem_size(CONFIG_MV64X60_NEW_BASE,
-		MV64x60_TYPE_MV64360);
+	bd_t *bdp = (bd_t *)__res;
+	return bdp->bi_memsize;
 }
 
 #if defined(CONFIG_I2C_MV64XXX) && defined(CONFIG_SENSORS_M41T00)
@@ -729,15 +864,6 @@
 late_initcall(katana_rtc_hookup);
 #endif
 
-static inline void
-katana_set_bat(void)
-{
-	mb();
-	mtspr(SPRN_DBAT2U, 0xf0001ffe);
-	mtspr(SPRN_DBAT2L, 0xf000002a);
-	mb();
-}
-
 #if defined(CONFIG_SERIAL_TEXT_DEBUG) && defined(CONFIG_SERIAL_MPSC_CONSOLE)
 static void __init
 katana_map_io(void)
@@ -763,15 +889,24 @@
 	 */
 	if (r3 && r6) {
 		/* copy board info structure */
-		memcpy( (void *)__res,(void *)(r3+KERNELBASE), sizeof(bd_t) );
+		memcpy((void *)__res, (void *)(r3+KERNELBASE), sizeof(bd_t));
 		/* copy command line */
 		*(char *)(r7+KERNELBASE) = 0;
 		strcpy(cmd_line, (char *)(r6+KERNELBASE));
 	}
 
+#ifdef CONFIG_BLK_DEV_INITRD
+	/* take care of initrd if we have one */
+	if (r4) {
+		initrd_start = r4 + KERNELBASE;
+		initrd_end = r5 + KERNELBASE;
+	}
+#endif /* CONFIG_BLK_DEV_INITRD */
+
 	isa_mem_base = 0;
 
 	ppc_md.setup_arch = katana_setup_arch;
+	ppc_md.pcibios_fixup_resources = katana_fixup_resources;
 	ppc_md.show_cpuinfo = katana_show_cpuinfo;
 	ppc_md.init_IRQ = mv64360_init_irq;
 	ppc_md.get_irq = mv64360_get_irq;
@@ -790,6 +925,4 @@
 #if defined(CONFIG_SERIAL_MPSC) || defined(CONFIG_MV643XX_ETH)
 	platform_notify = katana_platform_notify;
 #endif
-
-	katana_set_bat(); /* Need for katana_find_end_of_memory and progress */
 }
diff -Nur linux-2.6.13-mm1/arch/ppc/platforms/katana.h linux-2.6.13-mm1-mag/arch/ppc/platforms/katana.h
--- linux-2.6.13-mm1/arch/ppc/platforms/katana.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.13-mm1-mag/arch/ppc/platforms/katana.h	2005-09-01 17:00:31.000000000 -0700
@@ -56,14 +56,14 @@
 #define KATANA_PCI1_IO_SIZE                     0x04000000 /* 64 MB */
 
 /* Board-specific IRQ info */
-#define  KATANA_PCI_INTA_IRQ_3750		64+8
-#define  KATANA_PCI_INTB_IRQ_3750		64+9
-#define  KATANA_PCI_INTC_IRQ_3750		64+10
-
-#define  KATANA_PCI_INTA_IRQ_750i		64+8
-#define  KATANA_PCI_INTB_IRQ_750i		64+9
-#define  KATANA_PCI_INTC_IRQ_750i		64+10
-#define  KATANA_PCI_INTD_IRQ_750i		64+14
+#define  KATANA_PCI_INTA_IRQ_3750		(64+8)
+#define  KATANA_PCI_INTB_IRQ_3750		(64+9)
+#define  KATANA_PCI_INTC_IRQ_3750		(64+10)
+
+#define  KATANA_PCI_INTA_IRQ_750i		(64+8)
+#define  KATANA_PCI_INTB_IRQ_750i		(64+9)
+#define  KATANA_PCI_INTC_IRQ_750i		(64+10)
+#define  KATANA_PCI_INTD_IRQ_750i		(64+14)
 
 #define KATANA_CPLD_RST_EVENT			0x00000000
 #define KATANA_CPLD_RST_CMD			0x00001000
