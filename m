Message-ID: <4118282C375DF64EA700135193EEB8CA9E0356@ACUSH02>
From: "Dixon, Myron @ GNS" <Myron.Dixon@L-3com.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Recognizing compact flash in IDE mode on 8260
Date: Tue, 27 Apr 2004 18:12:57 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have a custom board that contains two PPC8260 processors.  One of the two

boots from PPCBoot 1.1.5 and runs linux kernel 2.4.18. I have written
several
drivers to exercise our on-board hardware.  Two books that have been
tremendous
resources are "Linux Device Drivers" by Rubin & Corbet and "Building
Embedded
Linux Systems" by Yaghmour.

We are currently booting to an NFS mounted root file system.  The next step
is
to boot to an on-board compact flash device configured in IDE mode per the
Toshiba "Compact Flash and MPC8260 Interface Design Guide".

While I am a reasonbly experienced programmer, my knowledge of the linux
kernel
is limited to the two books I've cited, searching on this and other mailing
lists, and the kernel source.

We have gotten PPC Boot to recognize the compact flash device as follows:


	PPCBoot 1.1.5 (Apr  5 2004 - 11:25:22)

	MPC8260 Reset Status: External Soft, External Hard

	MPC8260 Clock Configuration
	- Bus-to-Core Mult 3x, VCO Div 2, 60x Bus Freq  33-100, Core Freq
100-300
	- dfbrg 0, corecnf 0x08, busdf 4, cpmdf 1, plldf 1, pllmf 4
	- vco_out  333335000, scc_clk   83333750, brg_clk   83333750
	- cpu_clk  200001000, cpm_clk  166667500, bus_clk   66667000

	CPU:   MPC8260 (Rev 14, Mask B.1 4K25A) at 200.001 MHz
	Board: MAIN 8260
	DRAM: . . . Testing
	DRAM SIZE: 64 MB
	Length of PPCBOOT:  257020 bytes
	Top of RAM usable for PPCBoot at: 04000000
	Reserving 256k for PPCBoot at: 03fc0000
	Reserving 384k for malloc() at: 03f60000
	Reserving 76 Bytes for Board Info at: 03f5ff00
	Stack Pointer at: 03f5fee8
	Board info at: 03f5ff00
	Available 384k for malloc() at: 03f60000
	Stack Pointer at: 03f5fee8
	MAC ADDR: 00:a0:1e:a8:7b:cf
	Now running in RAM - PPCBoot at: 03fc0000
	FLASH:  1 MB
	mem_malloc_init: start = 66453504  len = 393216
	*** Warning - bad CRC, using default environment

	In:    serial
	Out:   serial
	Err:   serial
	Reset Ethernet PHY
	PPCBoot relocated to 03fc0000
	IDE:   Bus 0: OK
	Device 0: Model: LEXAR ATA FLASH Firm:  Ser#: 11303282139099090092
		Type: Removable Hard Disk
		Capacity: 30.4 MB = 0.0 GB (62336 x 512)
	->

While booting the linux kernel to detect the compact flash device as ide0,
I have attempted to use the following command line options
	idebus=66
	ide0=0xea000000,0xeb000000,7

The parameters for ide0= represent the our UPM settings for chip selects
CS0 and CS1 as well as the hardware IRQ7 line.
The "ide0=" parameter causes the kernel to crash.
A snap shot of this occurrence is as follows.

	-> bootp
	BOOTP broadcast 1
	got BOOTP packet (src=67, dst=68, len=331 want_len=300)
	Filtering pkt = 0
	Bootfile: /tftpboot/sbc/boot/tm_boot
	Got good BOOTP
	ARP broadcast 1
	Got good ARP - start TFTP
	TFTP from server 166.20.228.230; our IP address is 166.20.228.225
	Filename '/tftpboot/sbc/boot/tm_boot'.
	Load address: 0x800000
	Loading:
*#################################################################
		##################################################
	done
	Bytes transferred = 586168 (8f1b8 hex)
	-> bootm
	## Booting image at 00800000 ...
	Image Name:
	Created:      2004-04-27  14:56:09 UTC
	Image Type:   PowerPC Linux Kernel Image (gzip compressed)
	Data Size:    586104 Bytes = 572 kB = 0 MB
	Load Address: 00000000
	Entry Point:  00000000
	Verifying Checksum ... OK
	Uncompressing Kernel Image ... OK
	## Current stack ends at 0x03F5FB40 => set upper limit to 0x03F5F340
	## cmdline at 0x03F5F240 ... 0x03F5F240
	bd address  = 0x03F5F1F0
	memstart    = 0x00000000
	memsize     = 0x04000000
	flashstart  = 0xFE000000
	flashsize   = 0x00100000
	flashoffset = 0x00000000
	sramstart   = 0x03F60000
	sramsize    = 0x00060000
	immr_base   = 0xF0000000
	bootflags   = 0x00000001
	vco         = 333.335 MHz
	sccfreq     = 83.333 MHz
	brgfreq     = 83.333 MHz
	intfreq     = 200.001 MHz
	cpmfreq     = 166.667 MHz
	busfreq     = 66.667 MHz
	ethaddr     = 00:A0:1E:A8:7B:CF
	IP addr     = 166.20.228.225
	baudrate    =  19200 bps
	No initrd
	## Transferring control to Linux (at address 00000000) ...
	Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
	Linux version 2.4.18 (mdixon@telecom2.aydin-telecom.com) (gcc
version 2.95.3 20010315 //
(release)) #835 Tue Apr 27 10:53:07 EDT 2004
	On node 0 totalpages: 16384
	zone(0): 16384 pages.
	zone(1): 0 pages.
	zone(2): 0 pages.
	Kernel command line: root=/dev/nfs ip=166.20.228.225:166.20.228.230:
//
166.20.228.1:255.255.252.0:tm12::off nfsroot=166.20.228.230:/tftpboot/tm12
rw //
idebus=66 ide0=0xea000000,0xeb000000,7
	ide_setup: idebus=66
	ide_setup: ide0=0xea000000,0xeb000000,7

	Warning: real time clock seems stuck!
	Calibrating delay loop... 133.12 BogoMIPS
	Memory: 62880k available (1072k kernel code, 428k data, 56k init, 0k
highmem)
	Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
	Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
	Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
	Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
	Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
	POSIX conformance testing by UNIFIX
	Linux NET4.0 for Linux 2.4
	Based upon Swansea University Computer Society NET3.039
	Initializing RT netlink socket
	Starting kswapd
	JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis //
Communications AB.
	CPM UART driver version 0.01
	ttyS3 on SCC2 at 0x8100, BRG4
	pty: 256 Unix98 ptys configured
	block: 128 slots per queue, batch=32
	RAMDISK driver initialized: 16 RAM disks of 8192K size 1024
blocksize
	Uniform Multi-Platform E-IDE driver Revision: 6.31
	ide: Assuming 66MHz system bus speed for PIO modes
	Oops: kernel access of bad area, sig: 11
	NIP: C00A1D14 XER: 00000000 LR: C00A1CF4 SP: C02EFEE0 REGS: c02efe30
//
TRAP: 0300    Not tainted
	MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
	DAR: 00000000, DSISR: 22000000
	TASK = c02ee000[1] 'swapper' Last syscall: 120
	last math 00000000 last altivec 00000000
	GPR00: 000000A0 C02EFEE0 C02EE000 000103C4 000000EC 00000000
C02EFF54 C015DDDD
	GPR08: 00000655 00000000 C017D4BC 00000000 24008028 1001EF88
03FF6010 00000001
	GPR16: 00000000 03F5F1F0 FFFFFFFF 03F5F240 003FF000 00000000
03F5FDE8 00000001
	GPR24: 00000000 03FFC27C 40000000 C017B988 000000EC C017B840
C017B988 C017B8A8
	Call backtrace:
	C00A1CF4 C00A2544 C00A308C C015290C C0152984 C0150E68 C0150E90
	C014A7B0 C014A7F8 C0003BD8 C000641C
	Kernel panic: Attempted to kill init!
	<0>Rebooting in 180 seconds..

As shown, the chip select addresses result in the "Oops: kernel access of
bad area,
sig: 11" message. At this point I could use some assistance to identify what
I
am either not doing or doing incorrectly.

I have scoured the this website as well as others and have found no one else
trying to
boot compact flash on an 8260 processor.  Surely this must be possible.  I
have, however,
seen much disscussion and solutions on this issue for 8xx devices.

Also, here are my configuration settings. Note the configuration options for
our custom
hardware.

	#
	# Automatically generated make config: don't edit
	#
	# CONFIG_UID16 is not set
	# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
	CONFIG_RWSEM_XCHGADD_ALGORITHM=y
	CONFIG_HAVE_DEC_LOCK=y

	#
	# Code maturity level options
	#
	# CONFIG_EXPERIMENTAL is not set

	#
	# Loadable module support
	#
	CONFIG_MODULES=y
	# CONFIG_MODVERSIONS is not set
	CONFIG_KMOD=y

	#
	# Platform support
	#
	CONFIG_PPC=y
	CONFIG_PPC32=y
	CONFIG_6xx=y
	# CONFIG_4xx is not set
	# CONFIG_POWER3 is not set
	# CONFIG_POWER4 is not set
	# CONFIG_8xx is not set
	CONFIG_8260=y
	CONFIG_PPC_STD_MMU=y
	CONFIG_SERIAL_CONSOLE=y
	CONFIG_EST8260=y
	# CONFIG_SMP is not set

	#
	# General setup
	#
	# CONFIG_HIGHMEM is not set
	# CONFIG_ISA is not set
	# CONFIG_EISA is not set
	# CONFIG_SBUS is not set
	# CONFIG_MCA is not set
	# CONFIG_PCI is not set
	CONFIG_NET=y
	CONFIG_SYSCTL=y
	CONFIG_SYSVIPC=y
	# CONFIG_BSD_PROCESS_ACCT is not set
	CONFIG_KCORE_ELF=y
	CONFIG_BINFMT_ELF=y
	CONFIG_KERNEL_ELF=y
	# CONFIG_BINFMT_MISC is not set
	# CONFIG_HOTPLUG is not set
	# CONFIG_PCMCIA is not set

	#
	# Parallel port support
	#
	# CONFIG_PARPORT is not set

	#
	# Transcoder HW  support
	#
	CONFIG_THW=y
	CONFIG_THW_PORT=y
	CONFIG_THW_FRAMER=y
	CONFIG_THW_TSI=y
	CONFIG_THW_FPGA=y
	CONFIG_THW_I2C=y
	CONFIG_THW_SSN=y
	CONFIG_THW_RTC=y
	CONFIG_PPC_RTC=y
	CONFIG_CMDLINE_BOOL=y
	CONFIG_CMDLINE="root=/dev/nfs
ip=166.20.228.225:166.20.228.230:166.20.228.1: //
255.255.252.0:tm12::off nfsroot=166.20.228.230:/tftpboot/tm12 rw idebus=66
//
ide0=0xea000000,0xeb000000,7"

	#
	# Memory Technology Devices (MTD)
	#
	CONFIG_MTD=y
	# CONFIG_MTD_DEBUG is not set
	# CONFIG_MTD_PARTITIONS is not set
	# CONFIG_MTD_REDBOOT_PARTS is not set

	#
	# User Modules And Translation Layers
	#
	# CONFIG_MTD_CHAR is not set
	# CONFIG_MTD_BLOCK is not set
	# CONFIG_MTD_BLOCK_RO is not set
	# CONFIG_FTL is not set
	# CONFIG_NFTL is not set

	#
	# RAM/ROM/Flash chip drivers
	#
	# CONFIG_MTD_CFI is not set
	# CONFIG_MTD_JEDECPROBE is not set
	# CONFIG_MTD_GEN_PROBE is not set
	# CONFIG_MTD_CFI_INTELEXT is not set
	# CONFIG_MTD_CFI_AMDSTD is not set
	# CONFIG_MTD_RAM is not set
	# CONFIG_MTD_ROM is not set
	# CONFIG_MTD_ABSENT is not set
	# CONFIG_MTD_OBSOLETE_CHIPS is not set
	# CONFIG_MTD_AMDSTD is not set
	# CONFIG_MTD_SHARP is not set
	# CONFIG_MTD_JEDEC is not set

	#
	# Mapping drivers for chip access
	#
	# CONFIG_MTD_PHYSMAP is not set
	# CONFIG_MTD_TQM8XXL is not set
	# CONFIG_MTD_RPXLITE is not set
	# CONFIG_MTD_DBOX2 is not set
	# CONFIG_MTD_CFI_FLAGADM is not set

	#
	# Self-contained MTD device drivers
	#
	# CONFIG_MTD_PMC551 is not set
	# CONFIG_MTD_SLRAM is not set
	# CONFIG_MTD_MTDRAM is not set
	# CONFIG_MTD_BLKMTD is not set

	#
	# Disk-On-Chip Device Drivers
	#
	# CONFIG_MTD_DOC1000 is not set
	# CONFIG_MTD_DOC2000 is not set
	# CONFIG_MTD_DOC2001 is not set
	# CONFIG_MTD_DOCPROBE is not set

	#
	# NAND Flash Device Drivers
	#
	# CONFIG_MTD_NAND is not set

	#
	# Plug and Play configuration
	#
	# CONFIG_PNP is not set
	# CONFIG_ISAPNP is not set

	#
	# Block devices
	#
	# CONFIG_BLK_DEV_FD is not set
	# CONFIG_BLK_DEV_XD is not set
	# CONFIG_PARIDE is not set
	# CONFIG_BLK_CPQ_DA is not set
	# CONFIG_BLK_CPQ_CISS_DA is not set
	# CONFIG_BLK_DEV_DAC960 is not set
	# CONFIG_BLK_DEV_LOOP is not set
	# CONFIG_BLK_DEV_NBD is not set
	CONFIG_BLK_DEV_RAM=y
	CONFIG_BLK_DEV_RAM_SIZE=8192
	CONFIG_BLK_DEV_INITRD=y

	#
	# Multi-device support (RAID and LVM)
	#
	# CONFIG_MD is not set
	# CONFIG_BLK_DEV_MD is not set
	# CONFIG_MD_LINEAR is not set
	# CONFIG_MD_RAID0 is not set
	# CONFIG_MD_RAID1 is not set
	# CONFIG_MD_RAID5 is not set
	# CONFIG_MD_MULTIPATH is not set
	# CONFIG_BLK_DEV_LVM is not set

	#
	# Networking options
	#
	CONFIG_PACKET=y
	# CONFIG_PACKET_MMAP is not set
	# CONFIG_NETLINK_DEV is not set
	# CONFIG_NETFILTER is not set
	# CONFIG_FILTER is not set
	CONFIG_UNIX=y
	CONFIG_INET=y
	CONFIG_IP_MULTICAST=y
	# CONFIG_IP_ADVANCED_ROUTER is not set
	CONFIG_IP_PNP=y
	# CONFIG_IP_PNP_DHCP is not set
	CONFIG_IP_PNP_BOOTP=y
	# CONFIG_IP_PNP_RARP is not set
	# CONFIG_NET_IPIP is not set
	# CONFIG_NET_IPGRE is not set
	# CONFIG_IP_MROUTE is not set
	# CONFIG_INET_ECN is not set
	# CONFIG_SYN_COOKIES is not set

	#
	#
	#
	# CONFIG_IPX is not set
	# CONFIG_ATALK is not set
	# CONFIG_DECNET is not set
	# CONFIG_BRIDGE is not set

	#
	# QoS and/or fair queueing
	#
	# CONFIG_NET_SCHED is not set

	#
	# ATA/IDE/MFM/RLL support
	#
	CONFIG_IDE=y

	#
	# IDE, ATA and ATAPI Block devices
	#
	CONFIG_BLK_DEV_IDE=y

	#
	# Please see Documentation/ide.txt for help/info on IDE drives
	#
	# CONFIG_BLK_DEV_HD_IDE is not set
	# CONFIG_BLK_DEV_HD is not set
	CONFIG_BLK_DEV_IDEDISK=y
	CONFIG_IDEDISK_MULTI_MODE=y
	# CONFIG_BLK_DEV_IDEDISK_VENDOR is not set
	# CONFIG_BLK_DEV_IDEDISK_FUJITSU is not set
	# CONFIG_BLK_DEV_IDEDISK_IBM is not set
	# CONFIG_BLK_DEV_IDEDISK_MAXTOR is not set
	# CONFIG_BLK_DEV_IDEDISK_QUANTUM is not set
	# CONFIG_BLK_DEV_IDEDISK_SEAGATE is not set
	# CONFIG_BLK_DEV_IDEDISK_WD is not set
	# CONFIG_BLK_DEV_COMMERIAL is not set
	# CONFIG_BLK_DEV_TIVO is not set
	# CONFIG_BLK_DEV_IDECS is not set
	# CONFIG_BLK_DEV_IDECD is not set
	# CONFIG_BLK_DEV_IDETAPE is not set
	# CONFIG_BLK_DEV_IDEFLOPPY is not set
	# CONFIG_BLK_DEV_IDESCSI is not set

	#
	# IDE chipset support/bugfixes
	#
	# CONFIG_BLK_DEV_CMD640 is not set
	# CONFIG_BLK_DEV_CMD640_ENHANCED is not set
	# CONFIG_BLK_DEV_ISAPNP is not set
	# CONFIG_IDE_CHIPSETS is not set
	# CONFIG_IDEDMA_AUTO is not set
	# CONFIG_DMA_NONPCI is not set
	# CONFIG_BLK_DEV_IDE_MODES is not set
	# CONFIG_BLK_DEV_ATARAID is not set
	# CONFIG_BLK_DEV_ATARAID_PDC is not set
	# CONFIG_BLK_DEV_ATARAID_HPT is not set

	#
	# SCSI support
	#
	# CONFIG_SCSI is not set

	#
	# Network device support
	#
	CONFIG_NETDEVICES=y

	#
	# ARCnet devices
	#
	# CONFIG_ARCNET is not set
	# CONFIG_DUMMY is not set
	# CONFIG_BONDING is not set
	# CONFIG_EQUALIZER is not set
	# CONFIG_TUN is not set

	#
	# Ethernet (10 or 100Mbit)
	#
	CONFIG_NET_ETHERNET=y
	# CONFIG_MACE is not set
	# CONFIG_BMAC is not set
	# CONFIG_GMAC is not set
	# CONFIG_SUNLANCE is not set
	# CONFIG_SUNBMAC is not set
	# CONFIG_SUNQE is not set
	# CONFIG_SUNGEM is not set
	# CONFIG_NET_VENDOR_3COM is not set
	# CONFIG_LANCE is not set
	# CONFIG_NET_VENDOR_SMC is not set
	# CONFIG_NET_VENDOR_RACAL is not set
	# CONFIG_NET_ISA is not set
	# CONFIG_NET_PCI is not set
	# CONFIG_NET_POCKET is not set

	#
	# Ethernet (1000 Mbit)
	#
	# CONFIG_ACENIC is not set
	# CONFIG_DL2K is not set
	# CONFIG_MYRI_SBUS is not set
	# CONFIG_NS83820 is not set
	# CONFIG_HAMACHI is not set
	# CONFIG_YELLOWFIN is not set
	# CONFIG_SK98LIN is not set
	# CONFIG_FDDI is not set
	# CONFIG_PLIP is not set
	# CONFIG_PPP is not set
	# CONFIG_SLIP is not set

	#
	# Wireless LAN (non-hamradio)
	#
	# CONFIG_NET_RADIO is not set

	#
	# Token Ring devices
	#
	# CONFIG_TR is not set
	# CONFIG_NET_FC is not set

	#
	# Wan interfaces
	#
	# CONFIG_WAN is not set

	#
	# Amateur Radio support
	#
	# CONFIG_HAMRADIO is not set

	#
	# IrDA (infrared) support
	#
	# CONFIG_IRDA is not set

	#
	# ISDN subsystem
	#
	# CONFIG_ISDN is not set

	#
	# Old CD-ROM drivers (not SCSI, not IDE)
	#
	# CONFIG_CD_NO_IDESCSI is not set

	#
	# Console drivers
	#
	# CONFIG_VGA_CONSOLE is not set

	#
	# Frame-buffer support
	#
	# CONFIG_FB is not set

	#
	# Input core support
	#
	# CONFIG_INPUT is not set
	# CONFIG_INPUT_KEYBDEV is not set
	# CONFIG_INPUT_MOUSEDEV is not set
	# CONFIG_INPUT_JOYDEV is not set
	# CONFIG_INPUT_EVDEV is not set

	#
	# Macintosh device drivers
	#

	#
	# Character devices
	#
	# CONFIG_VT is not set
	# CONFIG_SERIAL is not set
	# CONFIG_SERIAL_EXTENDED is not set
	# CONFIG_SERIAL_NONSTANDARD is not set
	CONFIG_UNIX98_PTYS=y
	CONFIG_UNIX98_PTY_COUNT=256

	#
	# I2C support
	#
	# CONFIG_I2C is not set

	#
	# Mice
	#
	# CONFIG_BUSMOUSE is not set
	# CONFIG_MOUSE is not set

	#
	# Joysticks
	#
	# CONFIG_INPUT_GAMEPORT is not set

	#
	# Input core support is needed for gameports
	#

	#
	# Input core support is needed for joysticks
	#
	# CONFIG_QIC02_TAPE is not set

	#
	# Watchdog Cards
	#
	# CONFIG_WATCHDOG is not set
	# CONFIG_INTEL_RNG is not set
	# CONFIG_NVRAM is not set
	# CONFIG_RTC is not set
	# CONFIG_DTLK is not set
	# CONFIG_R3964 is not set
	# CONFIG_APPLICOM is not set

	#
	# Ftape, the floppy tape device driver
	#
	# CONFIG_FTAPE is not set
	# CONFIG_AGP is not set
	# CONFIG_DRM is not set

	#
	# Multimedia devices
	#
	# CONFIG_VIDEO_DEV is not set

	#
	# File systems
	#
	# CONFIG_QUOTA is not set
	# CONFIG_AUTOFS_FS is not set
	# CONFIG_AUTOFS4_FS is not set
	# CONFIG_REISERFS_FS is not set
	# CONFIG_REISERFS_CHECK is not set
	# CONFIG_REISERFS_PROC_INFO is not set
	# CONFIG_ADFS_FS is not set
	# CONFIG_ADFS_FS_RW is not set
	# CONFIG_AFFS_FS is not set
	# CONFIG_HFS_FS is not set
	# CONFIG_BFS_FS is not set
	# CONFIG_EXT3_FS is not set
	# CONFIG_JBD is not set
	# CONFIG_JBD_DEBUG is not set
	# CONFIG_FAT_FS is not set
	# CONFIG_MSDOS_FS is not set
	# CONFIG_UMSDOS_FS is not set
	# CONFIG_VFAT_FS is not set
	# CONFIG_EFS_FS is not set
	# CONFIG_JFFS_FS is not set
	CONFIG_JFFS2_FS=y
	CONFIG_JFFS2_FS_DEBUG=0
	# CONFIG_JFFS2_FS_NAND is not set
	# CONFIG_CRAMFS is not set
	# CONFIG_TMPFS is not set
	# CONFIG_RAMFS is not set
	# CONFIG_ISO9660_FS is not set
	# CONFIG_JOLIET is not set
	# CONFIG_ZISOFS is not set
	# CONFIG_MINIX_FS is not set
	# CONFIG_VXFS_FS is not set
	# CONFIG_NTFS_FS is not set
	# CONFIG_NTFS_RW is not set
	# CONFIG_HPFS_FS is not set
	CONFIG_PROC_FS=y
	# CONFIG_DEVFS_FS is not set
	# CONFIG_DEVFS_MOUNT is not set
	# CONFIG_DEVFS_DEBUG is not set
	# CONFIG_DEVPTS_FS is not set
	# CONFIG_QNX4FS_FS is not set
	# CONFIG_QNX4FS_RW is not set
	# CONFIG_ROMFS_FS is not set
	CONFIG_EXT2_FS=y
	# CONFIG_SYSV_FS is not set
	# CONFIG_UDF_FS is not set
	# CONFIG_UDF_RW is not set
	# CONFIG_UFS_FS is not set
	# CONFIG_UFS_FS_WRITE is not set

	#
	# Network File Systems
	#
	# CONFIG_CODA_FS is not set
	# CONFIG_INTERMEZZO_FS is not set
	CONFIG_NFS_FS=y
	# CONFIG_NFS_V3 is not set
	CONFIG_ROOT_NFS=y
	# CONFIG_NFSD is not set
	# CONFIG_NFSD_V3 is not set
	CONFIG_SUNRPC=y
	CONFIG_LOCKD=y
	# CONFIG_SMB_FS is not set
	# CONFIG_NCP_FS is not set
	# CONFIG_NCPFS_PACKET_SIGNING is not set
	# CONFIG_NCPFS_IOCTL_LOCKING is not set
	# CONFIG_NCPFS_STRONG is not set
	# CONFIG_NCPFS_NFS_NS is not set
	# CONFIG_NCPFS_OS2_NS is not set
	# CONFIG_NCPFS_SMALLDOS is not set
	# CONFIG_NCPFS_NLS is not set
	# CONFIG_NCPFS_EXTRAS is not set
	# CONFIG_ZISOFS_FS is not set
	# CONFIG_ZLIB_FS_INFLATE is not set

	#
	# Partition Types
	#
	CONFIG_PARTITION_ADVANCED=y
	# CONFIG_ACORN_PARTITION is not set
	# CONFIG_OSF_PARTITION is not set
	# CONFIG_AMIGA_PARTITION is not set
	# CONFIG_ATARI_PARTITION is not set
	# CONFIG_MAC_PARTITION is not set
	CONFIG_MSDOS_PARTITION=y
	# CONFIG_BSD_DISKLABEL is not set
	# CONFIG_MINIX_SUBPARTITION is not set
	# CONFIG_SOLARIS_X86_PARTITION is not set
	# CONFIG_UNIXWARE_DISKLABEL is not set
	# CONFIG_LDM_PARTITION is not set
	# CONFIG_SGI_PARTITION is not set
	# CONFIG_ULTRIX_PARTITION is not set
	# CONFIG_SUN_PARTITION is not set
	# CONFIG_SMB_NLS is not set
	# CONFIG_NLS is not set

	#
	# Sound
	#
	# CONFIG_SOUND is not set

	#
	# MPC8260 CPM Options
	#
	# CONFIG_SCC_ENET is not set
	CONFIG_FEC_ENET=y
	CONFIG_FCC1_ENET=y
	# CONFIG_FCC2_ENET is not set
	# CONFIG_FCC3_ENET is not set
	# CONFIG_USE_MDIO is not set
	CONFIG_SMC_UART=y
	# CONFIG_SMC1_UART is not set
	# CONFIG_SMC2_UART is not set
	CONFIG_SCC_UART=y
	# CONFIG_SCC1_UART is not set
	CONFIG_SCC2_UART=y
	# CONFIG_SCC2_PRIMARY is not set
	CONFIG_SCC2_SECONDARY=y
	# CONFIG_SCC3_UART is not set
	# CONFIG_SCC4_UART is not set
	# CONFIG_SERIAL_CONSOLE_NONCPM is not set
	# CONFIG_SERIAL_CONSOLE_SMC1 is not set
	# CONFIG_SERIAL_CONSOLE_SMC2 is not set
	# CONFIG_SERIAL_CONSOLE_SCC1 is not set
	CONFIG_SERIAL_CONSOLE_SCC2=y
	# CONFIG_SERIAL_CONSOLE_SCC3 is not set
	# CONFIG_SERIAL_CONSOLE_SCC4 is not set
	CONFIG_SERIAL_KGDB_NONCPM=y
	# CONFIG_SERIAL_KGDB_SMC1 is not set
	# CONFIG_SERIAL_KGDB_SMC2 is not set
	# CONFIG_SERIAL_KGDB_SCC1 is not set
	# CONFIG_SERIAL_KGDB_SCC2 is not set
	# CONFIG_SERIAL_KGDB_SCC3 is not set
	# CONFIG_SERIAL_KGDB_SCC4 is not set

	#
	# USB support
	#
	# CONFIG_USB is not set

	#
	# USB Controllers
	#
	# CONFIG_USB_UHCI is not set
	# CONFIG_USB_UHCI_ALT is not set
	# CONFIG_USB_OHCI is not set

	#
	# USB Device Class drivers
	#
	# CONFIG_USB_AUDIO is not set
	# CONFIG_USB_BLUETOOTH is not set

	#
	#   SCSI support is needed for USB Storage
	#
	# CONFIG_USB_STORAGE is not set
	# CONFIG_USB_STORAGE_DEBUG is not set
	# CONFIG_USB_STORAGE_DATAFAB is not set
	# CONFIG_USB_STORAGE_FREECOM is not set
	# CONFIG_USB_STORAGE_ISD200 is not set
	# CONFIG_USB_STORAGE_DPCM is not set
	# CONFIG_USB_STORAGE_HP8200e is not set
	# CONFIG_USB_STORAGE_SDDR09 is not set
	# CONFIG_USB_STORAGE_JUMPSHOT is not set
	# CONFIG_USB_ACM is not set
	# CONFIG_USB_PRINTER is not set

	#
	# USB Human Interface Devices (HID)
	#

	#
	#   Input core support is needed for USB HID
	#

	#
	# USB Imaging devices
	#
	# CONFIG_USB_DC2XX is not set
	# CONFIG_USB_MDC800 is not set
	# CONFIG_USB_SCANNER is not set
	# CONFIG_USB_MICROTEK is not set
	# CONFIG_USB_HPUSBSCSI is not set

	#
	# USB Multimedia devices
	#

	#
	#   Video4Linux support is needed for USB Multimedia device support
	#

	#
	# USB Network adaptors
	#
	# CONFIG_USB_PEGASUS is not set
	# CONFIG_USB_KAWETH is not set
	# CONFIG_USB_CATC is not set
	# CONFIG_USB_CDCETHER is not set
	# CONFIG_USB_USBNET is not set

	#
	# USB port drivers
	#
	# CONFIG_USB_USS720 is not set

	#
	# USB Serial Converter support
	#
	# CONFIG_USB_SERIAL is not set
	# CONFIG_USB_SERIAL_GENERIC is not set
	# CONFIG_USB_SERIAL_BELKIN is not set
	# CONFIG_USB_SERIAL_WHITEHEAT is not set
	# CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
	# CONFIG_USB_SERIAL_EMPEG is not set
	# CONFIG_USB_SERIAL_FTDI_SIO is not set
	# CONFIG_USB_SERIAL_VISOR is not set
	# CONFIG_USB_SERIAL_IPAQ is not set
	# CONFIG_USB_SERIAL_IR is not set
	# CONFIG_USB_SERIAL_EDGEPORT is not set
	# CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
	# CONFIG_USB_SERIAL_KEYSPAN is not set
	# CONFIG_USB_SERIAL_KEYSPAN_USA28 is not set
	# CONFIG_USB_SERIAL_KEYSPAN_USA28X is not set
	# CONFIG_USB_SERIAL_KEYSPAN_USA28XA is not set
	# CONFIG_USB_SERIAL_KEYSPAN_USA28XB is not set
	# CONFIG_USB_SERIAL_KEYSPAN_USA19 is not set
	# CONFIG_USB_SERIAL_KEYSPAN_USA18X is not set
	# CONFIG_USB_SERIAL_KEYSPAN_USA19W is not set
	# CONFIG_USB_SERIAL_KEYSPAN_USA49W is not set
	# CONFIG_USB_SERIAL_MCT_U232 is not set
	# CONFIG_USB_SERIAL_KLSI is not set
	# CONFIG_USB_SERIAL_PL2303 is not set
	# CONFIG_USB_SERIAL_CYBERJACK is not set
	# CONFIG_USB_SERIAL_XIRCOM is not set
	# CONFIG_USB_SERIAL_OMNINET is not set

	#
	# USB Miscellaneous drivers
	#
	# CONFIG_USB_RIO500 is not set

	#
	# Kernel hacking
	#
	# CONFIG_MAGIC_SYSRQ is not set
	# CONFIG_KGDB is not set
	# CONFIG_XMON is not set


Myron L. Dixon

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
