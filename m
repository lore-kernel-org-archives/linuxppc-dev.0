Subject: Re: BriQ & Linux 2.6
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jamie Heilman <jamie@audible.transient.net>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <20040521074018.GD8520@audible.transient.net>
References: <20040521074018.GD8520@audible.transient.net>
Content-Type: text/plain
Message-Id: <1085181034.6755.7.camel@gaston>
Mime-Version: 1.0
Date: Sat, 22 May 2004 09:10:34 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2004-05-21 at 17:40, Jamie Heilman wrote:
> I attempted to boot a 2.6.6 kernel on my BriQ today and ran into a
> snag... it appears that the IBM,CPC710 PCI bridge handling stuff
> didn't make it into 2.6.  As such the host won't boot as all the
> goodies hanging off the PCI bus vanish.  Any plans to roll the code
> forward in the near future?

I have a few patches for the briq, I didn't push them upstream yet,
as I'm trying to find a clean way to deal with an issue relative
to the serial port clock setting.

Enclosed is my latest version of that patch (may need some hand-applying
as it's a couple of monthes old).

Ben.

diff -urN linux-2.5/arch/ppc/configs/briq_defconfig linux-briq/arch/ppc/configs/briq_defconfig
--- linux-2.5/arch/ppc/configs/briq_defconfig	Thu Jan 01 10:00:00 1970
+++ linux-briq/arch/ppc/configs/briq_defconfig	Wed Mar 24 13:29:54 2004
@@ -0,0 +1,855 @@
+#
+# Automatically generated make config: don't edit
+#
+CONFIG_MMU=y
+CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_HAVE_DEC_LOCK=y
+CONFIG_PPC=y
+CONFIG_PPC32=y
+CONFIG_GENERIC_NVRAM=y
+
+#
+# Code maturity level options
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_CLEAN_COMPILE=y
+# CONFIG_STANDALONE is not set
+CONFIG_BROKEN_ON_SMP=y
+
+#
+# General setup
+#
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+CONFIG_SYSCTL=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_HOTPLUG=y
+# CONFIG_IKCONFIG is not set
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_IOSCHED_AS=y
+CONFIG_IOSCHED_DEADLINE=y
+# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+
+#
+# Loadable module support
+#
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+CONFIG_OBSOLETE_MODPARM=y
+CONFIG_MODVERSIONS=y
+CONFIG_KMOD=y
+
+#
+# Processor
+#
+CONFIG_6xx=y
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_POWER3 is not set
+# CONFIG_POWER4 is not set
+# CONFIG_8xx is not set
+CONFIG_ALTIVEC=y
+# CONFIG_TAU is not set
+# CONFIG_CPU_FREQ is not set
+# CONFIG_PPC601_SYNC_FIX is not set
+CONFIG_PPC_STD_MMU=y
+
+#
+# Platform options
+#
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_APUS is not set
+# CONFIG_WILLOW is not set
+# CONFIG_PCORE is not set
+# CONFIG_POWERPMC250 is not set
+# CONFIG_EV64260 is not set
+# CONFIG_SPRUCE is not set
+# CONFIG_LOPEC is not set
+# CONFIG_MCPN765 is not set
+# CONFIG_MVME5100 is not set
+# CONFIG_PPLUS is not set
+# CONFIG_PRPMC750 is not set
+# CONFIG_PRPMC800 is not set
+# CONFIG_SANDPOINT is not set
+# CONFIG_ADIR is not set
+# CONFIG_K2 is not set
+# CONFIG_PAL4 is not set
+# CONFIG_GEMINI is not set
+# CONFIG_EST8260 is not set
+# CONFIG_SBS8260 is not set
+# CONFIG_RPX6 is not set
+# CONFIG_TQM8260 is not set
+CONFIG_PPC_CHRP=y
+CONFIG_PPC_PMAC=y
+CONFIG_PPC_PREP=y
+CONFIG_PPC_OF=y
+CONFIG_PPCBUG_NVRAM=y
+# CONFIG_SMP is not set
+# CONFIG_PREEMPT is not set
+CONFIG_HIGHMEM=y
+CONFIG_KERNEL_ELF=y
+CONFIG_BINFMT_ELF=y
+CONFIG_BINFMT_MISC=m
+CONFIG_PROC_DEVICETREE=y
+CONFIG_PPC_RTAS=y
+# CONFIG_PREP_RESIDUAL is not set
+# CONFIG_CMDLINE_BOOL is not set
+
+#
+# Bus options
+#
+CONFIG_ISA=y
+CONFIG_GENERIC_ISA_DMA=y
+CONFIG_PCI=y
+CONFIG_PCI_DOMAINS=y
+CONFIG_PCI_LEGACY_PROC=y
+CONFIG_PCI_NAMES=y
+
+#
+# PCMCIA/CardBus support
+#
+# CONFIG_PCMCIA is not set
+CONFIG_PCMCIA_PROBE=y
+
+#
+# Advanced setup
+#
+CONFIG_ADVANCED_OPTIONS=y
+# CONFIG_HIGHMEM_START_BOOL is not set
+CONFIG_HIGHMEM_START=0xfe000000
+# CONFIG_LOWMEM_SIZE_BOOL is not set
+CONFIG_LOWMEM_SIZE=0x30000000
+# CONFIG_KERNEL_START_BOOL is not set
+CONFIG_KERNEL_START=0xc0000000
+# CONFIG_TASK_SIZE_BOOL is not set
+CONFIG_TASK_SIZE=0x80000000
+CONFIG_BOOT_LOAD=0x00800000
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+# CONFIG_FW_LOADER is not set
+# CONFIG_DEBUG_DRIVER is not set
+
+#
+# Memory Technology Devices (MTD)
+#
+# CONFIG_MTD is not set
+
+#
+# Parallel port support
+#
+# CONFIG_PARPORT is not set
+
+#
+# Plug and Play support
+#
+# CONFIG_PNP is not set
+
+#
+# Block devices
+#
+# CONFIG_BLK_DEV_FD is not set
+# CONFIG_BLK_DEV_XD is not set
+# CONFIG_BLK_CPQ_DA is not set
+# CONFIG_BLK_CPQ_CISS_DA is not set
+# CONFIG_BLK_DEV_DAC960 is not set
+# CONFIG_BLK_DEV_UMEM is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_CARMEL is not set
+CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_SIZE=4096
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_LBD=y
+
+#
+# ATA/ATAPI/MFM/RLL support
+#
+CONFIG_IDE=y
+CONFIG_BLK_DEV_IDE=y
+
+#
+# Please see Documentation/ide.txt for help/info on IDE drives
+#
+CONFIG_BLK_DEV_IDEDISK=y
+# CONFIG_IDEDISK_MULTI_MODE is not set
+# CONFIG_IDEDISK_STROKE is not set
+CONFIG_BLK_DEV_IDECD=y
+# CONFIG_BLK_DEV_IDETAPE is not set
+CONFIG_BLK_DEV_IDEFLOPPY=y
+# CONFIG_IDE_TASK_IOCTL is not set
+# CONFIG_IDE_TASKFILE_IO is not set
+
+#
+# IDE chipset support/bugfixes
+#
+CONFIG_IDE_GENERIC=y
+CONFIG_BLK_DEV_IDEPCI=y
+CONFIG_IDEPCI_SHARE_IRQ=y
+# CONFIG_BLK_DEV_OFFBOARD is not set
+CONFIG_BLK_DEV_GENERIC=y
+# CONFIG_BLK_DEV_OPTI621 is not set
+CONFIG_BLK_DEV_SL82C105=y
+CONFIG_BLK_DEV_IDEDMA_PCI=y
+# CONFIG_BLK_DEV_IDEDMA_FORCED is not set
+CONFIG_IDEDMA_PCI_AUTO=y
+# CONFIG_IDEDMA_ONLYDISK is not set
+CONFIG_BLK_DEV_ADMA=y
+# CONFIG_BLK_DEV_AEC62XX is not set
+# CONFIG_BLK_DEV_ALI15X3 is not set
+# CONFIG_BLK_DEV_AMD74XX is not set
+# CONFIG_BLK_DEV_CMD64X is not set
+# CONFIG_BLK_DEV_TRIFLEX is not set
+# CONFIG_BLK_DEV_CY82C693 is not set
+# CONFIG_BLK_DEV_CS5520 is not set
+# CONFIG_BLK_DEV_CS5530 is not set
+# CONFIG_BLK_DEV_HPT34X is not set
+# CONFIG_BLK_DEV_HPT366 is not set
+# CONFIG_BLK_DEV_SC1200 is not set
+# CONFIG_BLK_DEV_PIIX is not set
+# CONFIG_BLK_DEV_NS87415 is not set
+# CONFIG_BLK_DEV_PDC202XX_OLD is not set
+# CONFIG_BLK_DEV_PDC202XX_NEW is not set
+# CONFIG_BLK_DEV_SVWKS is not set
+# CONFIG_BLK_DEV_SIIMAGE is not set
+# CONFIG_BLK_DEV_SLC90E66 is not set
+# CONFIG_BLK_DEV_TRM290 is not set
+# CONFIG_BLK_DEV_VIA82CXXX is not set
+# CONFIG_BLK_DEV_IDE_PMAC is not set
+# CONFIG_IDE_CHIPSETS is not set
+CONFIG_BLK_DEV_IDEDMA=y
+# CONFIG_IDEDMA_IVB is not set
+CONFIG_IDEDMA_AUTO=y
+# CONFIG_DMA_NONPCI is not set
+# CONFIG_BLK_DEV_HD is not set
+
+#
+# SCSI device support
+#
+# CONFIG_SCSI is not set
+
+#
+# Old CD-ROM drivers (not SCSI, not IDE)
+#
+# CONFIG_CD_NO_IDESCSI is not set
+
+#
+# Multi-device support (RAID and LVM)
+#
+# CONFIG_MD is not set
+
+#
+# Fusion MPT device support
+#
+# CONFIG_FUSION is not set
+
+#
+# IEEE 1394 (FireWire) support
+#
+# CONFIG_IEEE1394 is not set
+
+#
+# I2O device support
+#
+# CONFIG_I2O is not set
+
+#
+# Macintosh device drivers
+#
+# CONFIG_ADB is not set
+# CONFIG_ADB_CUDA is not set
+# CONFIG_ADB_PMU is not set
+# CONFIG_MAC_FLOPPY is not set
+# CONFIG_MAC_SERIAL is not set
+
+#
+# Networking support
+#
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+# CONFIG_PACKET_MMAP is not set
+# CONFIG_NETLINK_DEV is not set
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+# CONFIG_IP_PNP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_INET_ECN is not set
+CONFIG_SYN_COOKIES=y
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+
+#
+# IP: Virtual Server Configuration
+#
+# CONFIG_IP_VS is not set
+# CONFIG_IPV6 is not set
+# CONFIG_DECNET is not set
+# CONFIG_BRIDGE is not set
+CONFIG_NETFILTER=y
+# CONFIG_NETFILTER_DEBUG is not set
+
+#
+# IP: Netfilter Configuration
+#
+CONFIG_IP_NF_CONNTRACK=m
+CONFIG_IP_NF_FTP=m
+CONFIG_IP_NF_IRC=m
+CONFIG_IP_NF_TFTP=m
+CONFIG_IP_NF_AMANDA=m
+# CONFIG_IP_NF_QUEUE is not set
+CONFIG_IP_NF_IPTABLES=m
+CONFIG_IP_NF_MATCH_LIMIT=m
+CONFIG_IP_NF_MATCH_IPRANGE=m
+CONFIG_IP_NF_MATCH_MAC=m
+CONFIG_IP_NF_MATCH_PKTTYPE=m
+CONFIG_IP_NF_MATCH_MARK=m
+CONFIG_IP_NF_MATCH_MULTIPORT=m
+CONFIG_IP_NF_MATCH_TOS=m
+CONFIG_IP_NF_MATCH_RECENT=m
+CONFIG_IP_NF_MATCH_ECN=m
+CONFIG_IP_NF_MATCH_DSCP=m
+CONFIG_IP_NF_MATCH_AH_ESP=m
+CONFIG_IP_NF_MATCH_LENGTH=m
+CONFIG_IP_NF_MATCH_TTL=m
+CONFIG_IP_NF_MATCH_TCPMSS=m
+CONFIG_IP_NF_MATCH_HELPER=m
+CONFIG_IP_NF_MATCH_STATE=m
+CONFIG_IP_NF_MATCH_CONNTRACK=m
+CONFIG_IP_NF_MATCH_OWNER=m
+CONFIG_IP_NF_FILTER=m
+CONFIG_IP_NF_TARGET_REJECT=m
+CONFIG_IP_NF_NAT=m
+CONFIG_IP_NF_NAT_NEEDED=y
+CONFIG_IP_NF_TARGET_MASQUERADE=m
+CONFIG_IP_NF_TARGET_REDIRECT=m
+CONFIG_IP_NF_TARGET_NETMAP=m
+CONFIG_IP_NF_TARGET_SAME=m
+# CONFIG_IP_NF_NAT_LOCAL is not set
+CONFIG_IP_NF_NAT_SNMP_BASIC=m
+CONFIG_IP_NF_NAT_IRC=m
+CONFIG_IP_NF_NAT_FTP=m
+CONFIG_IP_NF_NAT_TFTP=m
+CONFIG_IP_NF_NAT_AMANDA=m
+# CONFIG_IP_NF_MANGLE is not set
+# CONFIG_IP_NF_TARGET_LOG is not set
+# CONFIG_IP_NF_TARGET_ULOG is not set
+CONFIG_IP_NF_TARGET_TCPMSS=m
+CONFIG_IP_NF_ARPTABLES=m
+CONFIG_IP_NF_ARPFILTER=m
+CONFIG_IP_NF_ARP_MANGLE=m
+CONFIG_IP_NF_COMPAT_IPCHAINS=m
+# CONFIG_IP_NF_COMPAT_IPFWADM is not set
+
+#
+# SCTP Configuration (EXPERIMENTAL)
+#
+CONFIG_IPV6_SCTP__=y
+# CONFIG_IP_SCTP is not set
+# CONFIG_ATM is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_NET_DIVERT is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_NET_FASTROUTE is not set
+# CONFIG_NET_HW_FLOWCONTROL is not set
+
+#
+# QoS and/or fair queueing
+#
+# CONFIG_NET_SCHED is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+CONFIG_NETDEVICES=y
+
+#
+# ARCnet devices
+#
+# CONFIG_ARCNET is not set
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+
+#
+# Ethernet (10 or 100Mbit)
+#
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_MACE is not set
+# CONFIG_BMAC is not set
+# CONFIG_OAKNET is not set
+# CONFIG_HAPPYMEAL is not set
+# CONFIG_SUNGEM is not set
+# CONFIG_NET_VENDOR_3COM is not set
+# CONFIG_LANCE is not set
+# CONFIG_NET_VENDOR_SMC is not set
+# CONFIG_NET_VENDOR_RACAL is not set
+
+#
+# Tulip family network device support
+#
+# CONFIG_NET_TULIP is not set
+# CONFIG_AT1700 is not set
+# CONFIG_DEPCA is not set
+# CONFIG_HP100 is not set
+# CONFIG_NET_ISA is not set
+CONFIG_NET_PCI=y
+CONFIG_PCNET32=y
+# CONFIG_AMD8111_ETH is not set
+# CONFIG_ADAPTEC_STARFIRE is not set
+# CONFIG_AC3200 is not set
+# CONFIG_APRICOT is not set
+# CONFIG_B44 is not set
+# CONFIG_FORCEDETH is not set
+# CONFIG_CS89x0 is not set
+# CONFIG_DGRS is not set
+# CONFIG_EEPRO100 is not set
+# CONFIG_E100 is not set
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
+# CONFIG_NET_POCKET is not set
+
+#
+# Ethernet (1000 Mbit)
+#
+# CONFIG_ACENIC is not set
+# CONFIG_DL2K is not set
+# CONFIG_E1000 is not set
+# CONFIG_NS83820 is not set
+# CONFIG_HAMACHI is not set
+# CONFIG_YELLOWFIN is not set
+# CONFIG_R8169 is not set
+# CONFIG_SIS190 is not set
+# CONFIG_SK98LIN is not set
+# CONFIG_TIGON3 is not set
+
+#
+# Ethernet (10000 Mbit)
+#
+# CONFIG_IXGB is not set
+# CONFIG_FDDI is not set
+# CONFIG_HIPPI is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+
+#
+# Wireless LAN (non-hamradio)
+#
+CONFIG_NET_RADIO=y
+
+#
+# Obsolete Wireless cards support (pre-802.11)
+#
+# CONFIG_STRIP is not set
+# CONFIG_ARLAN is not set
+# CONFIG_WAVELAN is not set
+
+#
+# Wireless 802.11b ISA/PCI cards support
+#
+# CONFIG_AIRO is not set
+CONFIG_HERMES=m
+CONFIG_APPLE_AIRPORT=m
+# CONFIG_PLX_HERMES is not set
+# CONFIG_TMD_HERMES is not set
+# CONFIG_PCI_HERMES is not set
+# CONFIG_ATMEL is not set
+
+#
+# Prism GT/Duette 802.11(a/b/g) PCI/PCMCIA support
+#
+# CONFIG_PRISM54 is not set
+CONFIG_NET_WIRELESS=y
+
+#
+# Token Ring devices
+#
+# CONFIG_TR is not set
+# CONFIG_RCPCI is not set
+# CONFIG_SHAPER is not set
+# CONFIG_NETCONSOLE is not set
+
+#
+# Wan interfaces
+#
+# CONFIG_WAN is not set
+
+#
+# Amateur Radio support
+#
+# CONFIG_HAMRADIO is not set
+
+#
+# IrDA (infrared) support
+#
+# CONFIG_IRDA is not set
+
+#
+# Bluetooth support
+#
+# CONFIG_BT is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+
+#
+# ISDN subsystem
+#
+# CONFIG_ISDN is not set
+
+#
+# Telephony Support
+#
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+# CONFIG_INPUT is not set
+
+#
+# Userland interfaces
+#
+
+#
+# Input I/O drivers
+#
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+# CONFIG_SERIO is not set
+# CONFIG_SERIO_I8042 is not set
+
+#
+# Input Device Drivers
+#
+
+#
+# Character devices
+#
+# CONFIG_VT is not set
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+
+#
+# Non-8250 serial port support
+#
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+# CONFIG_SERIAL_PMACZILOG is not set
+CONFIG_UNIX98_PTYS=y
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+CONFIG_BRIQ_PANEL=y
+# CONFIG_QIC02_TAPE is not set
+
+#
+# IPMI
+#
+# CONFIG_IPMI_HANDLER is not set
+
+#
+# Watchdog Cards
+#
+# CONFIG_WATCHDOG is not set
+CONFIG_NVRAM=y
+CONFIG_GEN_RTC=y
+# CONFIG_GEN_RTC_X is not set
+# CONFIG_DTLK is not set
+# CONFIG_R3964 is not set
+# CONFIG_APPLICOM is not set
+
+#
+# Ftape, the floppy tape device driver
+#
+# CONFIG_FTAPE is not set
+# CONFIG_AGP is not set
+# CONFIG_DRM is not set
+# CONFIG_RAW_DRIVER is not set
+
+#
+# I2C support
+#
+# CONFIG_I2C is not set
+
+#
+# Misc devices
+#
+
+#
+# Multimedia devices
+#
+# CONFIG_VIDEO_DEV is not set
+
+#
+# Digital Video Broadcasting Devices
+#
+# CONFIG_DVB is not set
+
+#
+# Graphics support
+#
+# CONFIG_FB is not set
+
+#
+# Sound
+#
+# CONFIG_SOUND is not set
+
+#
+# USB support
+#
+# CONFIG_USB is not set
+
+#
+# USB Gadget Support
+#
+# CONFIG_USB_GADGET is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+CONFIG_EXT2_FS_XATTR=y
+# CONFIG_EXT2_FS_POSIX_ACL is not set
+# CONFIG_EXT2_FS_SECURITY is not set
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_XATTR=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+CONFIG_EXT3_FS_SECURITY=y
+CONFIG_JBD=y
+# CONFIG_JBD_DEBUG is not set
+CONFIG_FS_MBCACHE=y
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+CONFIG_FS_POSIX_ACL=y
+# CONFIG_XFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_ROMFS_FS is not set
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+CONFIG_ISO9660_FS=y
+# CONFIG_JOLIET is not set
+# CONFIG_ZISOFS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+CONFIG_FAT_FS=m
+CONFIG_MSDOS_FS=m
+CONFIG_VFAT_FS=m
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+CONFIG_PROC_KCORE=y
+# CONFIG_DEVFS_FS is not set
+CONFIG_DEVPTS_FS_XATTR=y
+# CONFIG_DEVPTS_FS_SECURITY is not set
+CONFIG_TMPFS=y
+# CONFIG_HUGETLB_PAGE is not set
+CONFIG_RAMFS=y
+
+#
+# Miscellaneous filesystems
+#
+# CONFIG_ADFS_FS is not set
+# CONFIG_AFFS_FS is not set
+# CONFIG_HFS_FS is not set
+# CONFIG_HFSPLUS_FS is not set
+# CONFIG_BEFS_FS is not set
+# CONFIG_BFS_FS is not set
+# CONFIG_EFS_FS is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_VXFS_FS is not set
+# CONFIG_HPFS_FS is not set
+# CONFIG_QNX4FS_FS is not set
+# CONFIG_SYSV_FS is not set
+# CONFIG_UFS_FS is not set
+
+#
+# Network File Systems
+#
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_NFS_V4=y
+# CONFIG_NFS_DIRECTIO is not set
+CONFIG_NFSD=y
+CONFIG_NFSD_V3=y
+CONFIG_NFSD_V4=y
+# CONFIG_NFSD_TCP is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_EXPORTFS=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_RPCSEC_GSS_KRB5=y
+CONFIG_SMB_FS=m
+# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+CONFIG_MAC_PARTITION=y
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+# CONFIG_LDM_PARTITION is not set
+# CONFIG_NEC98_PARTITION is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_EFI_PARTITION is not set
+
+#
+# Native Language Support
+#
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+# CONFIG_NLS_CODEPAGE_437 is not set
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+# CONFIG_NLS_CODEPAGE_850 is not set
+# CONFIG_NLS_CODEPAGE_852 is not set
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ISO8859_1=m
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+# CONFIG_NLS_ISO8859_15 is not set
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+# CONFIG_NLS_UTF8 is not set
+
+#
+# Library routines
+#
+CONFIG_CRC32=y
+
+#
+# Kernel hacking
+#
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SLAB is not set
+# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_HIGHMEM is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_KGDB is not set
+CONFIG_XMON=y
+# CONFIG_BDI_SWITCH is not set
+# CONFIG_DEBUG_INFO is not set
+CONFIG_BOOTX_TEXT=y
+
+#
+# Security options
+#
+# CONFIG_SECURITY is not set
+
+#
+# Cryptographic options
+#
+CONFIG_CRYPTO=y
+# CONFIG_CRYPTO_HMAC is not set
+# CONFIG_CRYPTO_NULL is not set
+# CONFIG_CRYPTO_MD4 is not set
+CONFIG_CRYPTO_MD5=y
+# CONFIG_CRYPTO_SHA1 is not set
+# CONFIG_CRYPTO_SHA256 is not set
+# CONFIG_CRYPTO_SHA512 is not set
+CONFIG_CRYPTO_DES=y
+# CONFIG_CRYPTO_BLOWFISH is not set
+# CONFIG_CRYPTO_TWOFISH is not set
+# CONFIG_CRYPTO_SERPENT is not set
+# CONFIG_CRYPTO_AES is not set
+# CONFIG_CRYPTO_CAST5 is not set
+# CONFIG_CRYPTO_CAST6 is not set
+# CONFIG_CRYPTO_ARC4 is not set
+# CONFIG_CRYPTO_DEFLATE is not set
+# CONFIG_CRYPTO_TEST is not set
diff -urN linux-2.5/arch/ppc/kernel/pci.c linux-briq/arch/ppc/kernel/pci.c
--- linux-2.5/arch/ppc/kernel/pci.c	2004-03-01 18:11:11.000000000 +1100
+++ linux-briq/arch/ppc/kernel/pci.c	2004-03-19 16:03:57.000000000 +1100
@@ -45,11 +45,16 @@
 static int reparent_resources(struct resource *parent, struct resource *res);
 static void fixup_rev1_53c810(struct pci_dev* dev);
 static void fixup_cpc710_pci64(struct pci_dev* dev);
+
+#ifdef CONFIG_PPC_CHRP
+extern void chrp_pci_fixup_winbond_ata(struct pci_dev* dev);
+#endif /* CONFIG_PPC_CHRP */
 #ifdef CONFIG_PPC_PMAC
 extern void pmac_pci_fixup_cardbus(struct pci_dev* dev);
 extern void pmac_pci_fixup_pciata(struct pci_dev* dev);
 extern void pmac_pci_fixup_k2_sata(struct pci_dev* dev);
-#endif
+#endif /* CONFIG_PPC_PMAC */
+
 #ifdef CONFIG_PPC_OF
 static u8* pci_to_OF_bus_map;
 #endif
@@ -69,6 +74,9 @@
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_NCR,	PCI_DEVICE_ID_NCR_53C810,	fixup_rev1_53c810 },
 	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_IBM,	PCI_DEVICE_ID_IBM_CPC710_PCI64,	fixup_cpc710_pci64},
 	{ PCI_FIXUP_HEADER,	PCI_ANY_ID,		PCI_ANY_ID,			pcibios_fixup_resources },
+#ifdef CONFIG_PPC_CHRP
+	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_WINBOND,	PCI_DEVICE_ID_WINBOND_82C105,	chrp_pci_fixup_winbond_ata },
+#endif /* CONFIG_PPC_CHRP */
 #ifdef CONFIG_PPC_PMAC
 	/* We should add per-machine fixup support in xxx_setup.c or xxx_pci.c */
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_TI,	PCI_ANY_ID,			pmac_pci_fixup_cardbus },
diff -urN linux-2.5/arch/ppc/platforms/chrp_pci.c linux-briq/arch/ppc/platforms/chrp_pci.c
--- linux-2.5/arch/ppc/platforms/chrp_pci.c	2004-03-01 18:11:11.000000000 +1100
+++ linux-briq/arch/ppc/platforms/chrp_pci.c	2004-03-19 16:03:58.000000000 +1100
@@ -25,6 +25,9 @@
 /* LongTrail */
 unsigned long gg2_pci_config_base;

+/* BriQ stuff */
+extern int chrp_is_briq;
+
 /*
  * The VLSI Golden Gate II has only 512K of PCI configuration space, so we
  * limit the bus number to 3 bits
@@ -166,6 +169,29 @@
 	}
 }

+/* SL82C105 IDE Control/Status Register */
+#define SL82C105_IDECSR                0x40
+
+void chrp_pci_fixup_winbond_ata(struct pci_dev *sl82c105)
+{
+	u8 progif;
+
+	/* If non-briq machines need that fixup too, please speak up */
+	if (_machine != _MACH_chrp || !chrp_is_briq)
+		return;
+
+	if ((sl82c105->class & 5) != 5) {
+		printk("W83C553: Switching SL82C105 IDE to PCI native mode\n");
+		/* Enable SL82C105 PCI native IDE mode */
+		pci_read_config_byte(sl82c105, PCI_CLASS_PROG, &progif);
+		pci_write_config_byte(sl82c105, PCI_CLASS_PROG, progif | 0x05);
+		sl82c105->class |= 0x05;
+		/* Disable SL82C105 second port */
+		pci_write_config_word(sl82c105, SL82C105_IDECSR, 0x0003);
+	}
+}
+
+
 #define PRG_CL_RESET_VALID 0x00010000

 static void __init
@@ -257,6 +283,19 @@
 			hose->cfg_data = (unsigned char *)
 				ioremap(GG2_PCI_CONFIG_BASE, 0x80000);
 			gg2_pci_config_base = (unsigned long) hose->cfg_data;
+		} else if (!strncmp(model, "IBM,CPC710", 10)) {
+			setup_indirect_pci(hose,
+				dev->addrs[0].address + 0x000f8000,
+				dev->addrs[0].address + 0x000f8010);
+			if (index == 0) {
+				dma = (unsigned int *)
+				get_property(dev, "system-dma-base", &len);
+				if (dma && len >= sizeof(*dma)) {
+					dma = (unsigned int *)(((unsigned long)dma) +
+					len - sizeof(*dma));
+					pci_dram_offset = *dma;
+				}
+			}
 		} else {
 			printk("No methods for %s (model %s), using RTAS\n",
 			       dev->full_name, model);
diff -urN linux-2.5/arch/ppc/platforms/chrp_setup.c linux-briq/arch/ppc/platforms/chrp_setup.c
--- linux-2.5/arch/ppc/platforms/chrp_setup.c	2004-03-01 18:11:11.000000000 +1100
+++ linux-briq/arch/ppc/platforms/chrp_setup.c	2004-03-24 15:59:42.759566376 +1100
@@ -54,6 +54,12 @@
 #include <asm/open_pic.h>
 #include <asm/xmon.h>

+#ifdef CONFIG_SERIAL_8250
+#include <linux/serial.h>
+#include <linux/serialP.h>
+#endif
+
+
 unsigned long chrp_get_rtc_time(void);
 int chrp_set_rtc_time(unsigned long nowtime);
 void chrp_calibrate_decr(void);
@@ -83,6 +89,9 @@
 extern unsigned long loops_per_jiffy;
 static int max_width;

+int chrp_is_briq __chrpdata;
+static unsigned int* briq_SPOR __chrpdata; /* To be replaced by RTAS when available */
+
 #ifdef CONFIG_SMP
 extern struct smp_ops_t chrp_smp_ops;
 #endif
@@ -321,6 +330,15 @@
 	return irq;
 }

+static void __chrp briq_restart(char *cmd)
+{
+	local_irq_disable();
+	if (briq_SPOR)
+		out_be32(briq_SPOR, 0);
+	for(;;)
+		;
+}
+
 /*
  * Finds the open-pic node and sets OpenPIC_Addr based on its reg property.
  * Then checks if it has an interrupt-ranges property.  If it does then
@@ -378,12 +396,39 @@
 	}
 }

-void __init chrp_init_IRQ(void)
+static void __init chrp_init_irq_openpic(unsigned long intack)
 {
-	struct device_node *np;
 	int i;
-	unsigned long chrp_int_ack;
 	unsigned char init_senses[NR_IRQS - NUM_8259_INTERRUPTS];
+
+	chrp_find_openpic();
+
+	prom_get_irq_senses(init_senses, NUM_8259_INTERRUPTS, NR_IRQS);
+	OpenPIC_InitSenses = init_senses;
+	OpenPIC_NumInitSenses = NR_IRQS - NUM_8259_INTERRUPTS;
+
+	openpic_init(NUM_8259_INTERRUPTS);
+
+	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
+		irq_desc[i].handler = &i8259_pic;
+	i8259_init(intack);
+}
+
+static void __init chrp_init_irq_8259(unsigned long intack)
+{
+	int i;
+
+	ppc_md.get_irq = i8259_irq;
+	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
+		irq_desc[i].handler = &i8259_pic;
+	i8259_init(intack);
+}
+
+void __init chrp_init_IRQ(void)
+{
+	struct device_node *np;
+	unsigned long intack = 0;
+	struct device_node *main_irq_ctrler = NULL;
 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
 	struct device_node *kbd;
 #endif
@@ -394,23 +439,28 @@

 		if (addrp == NULL)
 			continue;
-		chrp_int_ack = addrp[prom_n_addr_cells(np)-1];
+		intack = addrp[prom_n_addr_cells(np)-1];
 		break;
 	}
 	if (np == NULL)
 		printk(KERN_ERR "Cannot find PCI interrupt acknowledge address\n");

-	chrp_find_openpic();
-
-	prom_get_irq_senses(init_senses, NUM_8259_INTERRUPTS, NR_IRQS);
-	OpenPIC_InitSenses = init_senses;
-	OpenPIC_NumInitSenses = NR_IRQS - NUM_8259_INTERRUPTS;
+	/* Look for the node of the toplevel interrupt controller.
+	 * If we don't find it, we assume openpic
+	 */
+	np = find_path_device("/chosen");
+	if (np) {
+		phandle *irq_ctrler_ph =
+			(phandle *)get_property(np, "interrupt-controller", NULL);
+		if (irq_ctrler_ph)
+			main_irq_ctrler = find_phandle(*irq_ctrler_ph);
+	}

-	openpic_init(NUM_8259_INTERRUPTS);
+	if (main_irq_ctrler && device_is_compatible(main_irq_ctrler, "8259"))
+		chrp_init_irq_8259(intack);
+	else
+		chrp_init_irq_openpic(intack);

-	for (i = 0; i < NUM_8259_INTERRUPTS; i++)
-		irq_desc[i].handler = &i8259_pic;
-	i8259_init(chrp_int_ack);

 #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) && defined(XMON)
 	/* see if there is a keyboard in the device tree
@@ -427,10 +477,9 @@
 void __init
 chrp_init2(void)
 {
-#ifdef CONFIG_NVRAM
-// XX replace this in a more saner way
-//	pmac_nvram_init();
-#endif
+	/* This is to be replaced by RTAS when available */
+	if (chrp_is_briq)
+		briq_SPOR = (unsigned int *)ioremap(0xff0000e8, 4);

 	request_region(0x20,0x20,"pic1");
 	request_region(0xa0,0x20,"pic2");
@@ -447,6 +496,9 @@
 chrp_init(unsigned long r3, unsigned long r4, unsigned long r5,
 	  unsigned long r6, unsigned long r7)
 {
+	struct device_node *root = find_path_device("/");
+	char *machine;
+
 #ifdef CONFIG_BLK_DEV_INITRD
 	/* take care of initrd if we have one */
 	if ( r6 )
@@ -461,6 +513,17 @@
 	DMA_MODE_WRITE = 0x48;
 	isa_io_base = CHRP_ISA_IO_BASE;		/* default value */

+	/* Check if it's a briq */
+	machine = get_property(root, "model", NULL);
+	chrp_is_briq = machine && strncmp(machine, "TotalImpact,BRIQ-1", 18) == 0;
+#ifdef CONFIG_SERIAL_8250
+	if (chrp_is_briq) {
+		/* briQ has a different serial clock */
+		extern int alternate_serial_clock;
+		alternate_serial_clock = 7372800;
+	}
+#endif /* CONFIG_SERIAL_8250 */
+
 	ppc_md.setup_arch     = chrp_setup_arch;
 	ppc_md.show_percpuinfo = of_show_percpuinfo;
 	ppc_md.show_cpuinfo   = chrp_show_cpuinfo;
@@ -470,7 +533,7 @@

 	ppc_md.init           = chrp_init2;

-	ppc_md.restart        = chrp_restart;
+	ppc_md.restart        = chrp_is_briq ? briq_restart : chrp_restart;
 	ppc_md.power_off      = chrp_power_off;
 	ppc_md.halt           = chrp_halt;

diff -urN linux-2.5/arch/ppc/syslib/prom.c linux-briq/arch/ppc/syslib/prom.c
--- linux-2.5/arch/ppc/syslib/prom.c	2004-03-01 18:11:12.000000000 +1100
+++ linux-briq/arch/ppc/syslib/prom.c	2004-03-24 16:01:34.776537208 +1100
@@ -80,7 +80,7 @@
 static unsigned long finish_node(struct device_node *, unsigned long,
 				 interpret_func *, int, int);
 static unsigned long finish_node_interrupts(struct device_node *, unsigned long);
-static struct device_node *find_phandle(phandle);
+struct device_node *find_phandle(phandle);

 extern void enter_rtas(void *);
 void phys_call_rtas(int, int, int, ...);
@@ -1133,8 +1133,7 @@
 /*
  * Find the device_node with a given phandle.
  */
-static struct device_node * __init
-find_phandle(phandle ph)
+struct device_node * find_phandle(phandle ph)
 {
 	struct device_node *np;

diff -urN linux-2.5/drivers/char/Kconfig linux-briq/drivers/char/Kconfig
--- linux-2.5/drivers/char/Kconfig	2004-03-17 12:02:08.000000000 +1100
+++ linux-briq/drivers/char/Kconfig	2004-03-19 16:04:02.000000000 +1100
@@ -497,6 +497,18 @@
 	  When not in use, each legacy PTY occupies 12 bytes on 32-bit
 	  architectures and 24 bytes on 64-bit architectures.

+config BRIQ_PANEL
+	tristate 'Total Impact briQ front panel driver'
+	---help---
+		The briQ is a small footprint CHRP computer with
+		a frontpanel VFD, a tristate led and two switches.
+		It is the size of a CDROM drive.
+		If you have such one and want anything showing
+		on the VFD then you must answer Y here.
+		This driver can be built as a module.
+		The module name will be "briq_panel.o"
+			It's safe to say N.
+
 config PRINTER
 	tristate "Parallel printer support"
 	depends on PARPORT
diff -urN linux-2.5/drivers/char/Makefile linux-briq/drivers/char/Makefile
--- linux-2.5/drivers/char/Makefile	2004-03-22 10:36:57.000000000 +1100
+++ linux-briq/drivers/char/Makefile	2004-03-24 12:38:23.000000000 +1100
@@ -45,6 +45,7 @@
 obj-$(CONFIG_SGI_L1_SERIAL)	+= sn_serial.o
 obj-$(CONFIG_VIOCONS) += viocons.o
 obj-$(CONFIG_VIOTAPE)		+= viotape.o
+obj-$(CONFIG_BRIQ_PANEL)	+= briq_panel.o

 obj-$(CONFIG_PRINTER) += lp.o
 obj-$(CONFIG_TIPAR) += tipar.o
diff -urN linux-2.5/drivers/char/briq_panel.c linux-briq/drivers/char/briq_panel.c
--- linux-2.5/drivers/char/briq_panel.c	Thu Jan 01 10:00:00 1970
+++ linux-briq/drivers/char/briq_panel.c	Wed Mar 24 16:01:17 2004
@@ -0,0 +1,293 @@
+/*
+ * Drivers for the Total Impact PPC based computer "BRIQ"
+ * by Dr. Karsten Jeppesen
+ *
+ *
+ * 010407		Coding started
+ *
+ * 04/20/2002	1.1	Adapted to 2.4, small cleanups
+ */
+
+#include <linux/module.h>
+
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/tty.h>
+#include <linux/timer.h>
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/wait.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/miscdevice.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/init.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+
+#define		TOTALIMPACT_VFD_MINOR	156
+#define		VFD_IOPORT		0x0390
+#define		LED_IOPORT		0x0398
+#define		TI_VER                  "1.1 (04/20/2002)"
+#define		TI_MSG0			"Loading Linux"
+
+static int		vfd_is_open;
+static unsigned char	vfd[40];
+static int		vfd_cursor;
+static unsigned char	ledpb, led;
+
+
+#if 0
+/*
+  Apparently every PPC machine comes with a PC keyboard.
+  Well - the briQ does NOT.
+  But since you insist....
+  Let us satisfy the PC people
+*/
+void __init pckbd_init_hw(void) {
+}
+#endif
+
+
+static void update_vfd( void )
+{
+	int	i;
+
+	/* cursor home */
+	outb(0x02, VFD_IOPORT);
+	for (i=0; i<20; i++)
+		outb(vfd[i], VFD_IOPORT + 1);
+
+	/* cursor to next line */
+	outb(0xc0, VFD_IOPORT);
+	for (i=20; i<40; i++)
+		outb(vfd[i], VFD_IOPORT + 1);
+
+}
+
+static void set_led( char state)
+{
+	if ( state == 'R' )
+		led = 0x01;
+	else if ( state == 'G' )
+		led = 0x02;
+	else if ( state == 'Y' )
+		led = 0x03;
+	else if ( state == 'X' )
+		led = 0x00;
+	outb(led, LED_IOPORT);
+}
+
+static int do_open(struct inode *ino, struct file *filep)
+{
+	if (vfd_is_open)
+		return -EBUSY;
+
+	MOD_INC_USE_COUNT;
+
+	vfd_is_open = 1;
+
+	return 0;
+}
+
+static int do_release(struct inode *ino, struct file *filep)
+{
+	if (!vfd_is_open)
+		return -ENODEV;
+
+	MOD_DEC_USE_COUNT;
+
+	vfd_is_open = 0;
+
+	return 0;
+}
+
+
+static ssize_t do_read(struct file *file, char *buf, size_t count,
+			 loff_t *ppos)
+{
+	unsigned short c;
+	unsigned char cp;
+
+	/*  Can't seek (pread) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (!vfd_is_open)
+		return -ENODEV;
+
+	c = (inb( LED_IOPORT ) & 0x000c) | (ledpb & 0x0003);
+	set_led(' ');
+	/* upper button released */
+	if ((!(ledpb & 0x0004)) && (c & 0x0004)) {
+		cp = ' ';
+		ledpb = c;
+		if (copy_to_user(buf, &cp, 1))
+			return -EFAULT;
+		return 1;
+	}
+	/* lower button released */
+	else if ((!(ledpb & 0x0008)) && (c & 0x0008)) {
+		cp = '\r';
+		ledpb = c;
+		if (copy_to_user(buf, &cp, 1))
+			return -EFAULT;
+		return 1;
+	} else {
+		ledpb = c;
+		return 0;
+	}
+}
+
+
+static void scroll_vfd( void )
+{
+	int	i;
+
+	for (i=0; i<20; i++) {
+		vfd[i] = vfd[i+20];
+		vfd[i+20] = ' ';
+	}
+	vfd_cursor = 20;
+}
+
+
+static ssize_t do_write(struct file *file, const char *buf, size_t len,
+			  loff_t *ppos)
+{
+	size_t indx = len;
+	int i, esc = 0;
+
+	/*  Can't seek (pwrite) on this device  */
+	if (ppos != &file->f_pos)
+		return -ESPIPE;
+
+	if (!vfd_is_open)
+		return -EBUSY;
+
+	for (;;) {
+		if (!indx)
+			break;
+		if (esc) {
+			set_led(*buf);
+			esc = 0;
+		} else if (*buf == 27) {
+			esc = 1;
+		} else if (*buf == 12) {
+			/* do a form feed */
+			for (i=0; i<40; i++)
+				vfd[i] = ' ';
+			vfd_cursor = 0;
+		} else if (*buf == 10) {
+			if (vfd_cursor < 20)
+				vfd_cursor = 20;
+			else if (vfd_cursor < 40)
+				vfd_cursor = 40;
+			else if (vfd_cursor < 60)
+				vfd_cursor = 60;
+			if (vfd_cursor > 59)
+				scroll_vfd();
+		} else {
+			/* just a character */
+			if (vfd_cursor > 39)
+				scroll_vfd();
+			vfd[vfd_cursor++] = *buf;
+		}
+		indx--;
+		buf++;
+	}
+	update_vfd();
+
+	return len;
+}
+
+
+static struct file_operations vfd_fops = {
+	.read		= do_read,
+	.write		= do_write,
+	.open		= do_open,
+	.release	= do_release,
+};
+
+
+static struct miscdevice ti_vfd_miscdev = {
+	TOTALIMPACT_VFD_MINOR,
+	"vfd",
+	&vfd_fops
+};
+
+
+static int __init briq_panel_init(void)
+{
+	struct device_node *root = find_path_device("/");
+	char *machine;
+	int i;
+
+	machine = get_property(root, "model", NULL);
+	if (!machine || strncmp(machine, "TotalImpact,BRIQ-1", 18) != 0)
+		return -ENODEV;
+
+	printk(KERN_INFO "ti_briq: v%s Dr. Karsten Jeppesen (kj@totalimpact.com)\n",
+	       TI_VER);
+
+	if (!request_region( VFD_IOPORT, 4, "BRIQ Front Panel"))
+		return -EBUSY;
+	if (!request_region( LED_IOPORT, 2, "BRIQ Front Panel")) {
+		release_region(VFD_IOPORT, 4);
+		return -EBUSY;
+	}
+	ledpb = inb( LED_IOPORT ) & 0x000c;
+
+	if (misc_register(&ti_vfd_miscdev) < 0) {
+		release_region(VFD_IOPORT, 4);
+		release_region(LED_IOPORT, 2);
+		return -EBUSY;
+	}
+
+	outb(0x38, VFD_IOPORT);	/* Function set */
+	outb(0x01, VFD_IOPORT);	/* Clear display */
+	outb(0x0c, VFD_IOPORT);	/* Display on */
+	outb(0x06, VFD_IOPORT);	/* Entry normal */
+	for (i=0; i<40; i++)
+		vfd[i]=' ';
+#ifndef MODULE
+	vfd[0] = 'L';
+	vfd[1] = 'o';
+	vfd[2] = 'a';
+	vfd[3] = 'd';
+	vfd[4] = 'i';
+	vfd[5] = 'n';
+	vfd[6] = 'g';
+	vfd[7] = ' ';
+	vfd[8] = '.';
+	vfd[9] = '.';
+	vfd[10] = '.';
+#endif /* !MODULE */
+
+	update_vfd();
+
+	return 0;
+}
+
+
+static void __exit briq_panel_exit(void)
+{
+	misc_deregister(&ti_vfd_miscdev);
+	release_region(VFD_IOPORT, 4);
+	release_region(LED_IOPORT, 2);
+}
+
+
+module_init(briq_panel_init);
+module_exit(briq_panel_exit);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Karsten Jeppesen <karsten@jeppesens.com>");
+MODULE_DESCRIPTION("Driver for the Total Impact briQ front panel");
diff -urN linux-2.5/drivers/serial/8250.c linux-briq/drivers/serial/8250.c
--- linux-2.5/drivers/serial/8250.c	2004-03-17 12:02:09.000000000 +1100
+++ linux-briq/drivers/serial/8250.c	2004-03-19 16:04:07.000000000 +1100
@@ -1830,6 +1830,8 @@

 static struct uart_8250_port serial8250_ports[UART_NR];

+int alternate_serial_clock;
+
 static void __init serial8250_isa_init_ports(void)
 {
 	struct uart_8250_port *up;
@@ -1844,7 +1846,10 @@
 	     i++, up++) {
 		up->port.iobase   = old_serial_port[i].port;
 		up->port.irq      = irq_canonicalize(old_serial_port[i].irq);
-		up->port.uartclk  = old_serial_port[i].baud_base * 16;
+		if (alternate_serial_clock)
+			up->port.uartclk  = alternate_serial_clock;
+		else
+			up->port.uartclk  = old_serial_port[i].baud_base * 16;
 		up->port.flags    = old_serial_port[i].flags |
 				    UPF_RESOURCES;
 		up->port.hub6     = old_serial_port[i].hub6;
diff -urN linux-2.5/include/asm-ppc/prom.h linux-briq/include/asm-ppc/prom.h
--- linux-2.5/include/asm-ppc/prom.h	2004-03-01 18:13:06.000000000 +1100
+++ linux-briq/include/asm-ppc/prom.h	2004-03-24 16:00:47.614706896 +1100
@@ -69,6 +69,7 @@
 extern struct device_node *find_compatible_devices(const char *type,
 						   const char *compat);
 extern struct device_node *find_all_nodes(void);
+extern struct device_node *find_phandle(phandle);

 /* New style node lookup */
 extern struct device_node *of_find_node_by_name(struct device_node *from,

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
