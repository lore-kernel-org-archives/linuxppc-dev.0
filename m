Message-Id: <m12kcXk-001SyZC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Baud rate problems with the EST SBC8260 board
To: linuxppc-embedded@lists.linuxppc.org, dan@netx4.com
Date: Wed, 26 Apr 2000 20:52:36 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Yesterday afternoon, I pulled down the Linux 2.3 Bitkeeper
	tree with rsync.

	rsync -avz --delete hq.fsmlabs.com::linuxppc_2_3 linuxppc_2_3

	This pile of bits includes Dan Malek (dan@netx4.com) MPC8260 port
	for the EST SBC8260 board.  I configured the kernel, but ran into
	problems with arch/ppc/kernel/ppc_ksyms.c referencing things that
	don't exist.  I remove the items that were giving me grief, but
	this was only a quick hack.  A longer term solution would make
	them configureable, so they don't get in the way.

	dell 110} rcsdiff -r1.1 -c arch/ppc/kernel/ppc_ksyms.c
	===================================================================
	RCS file: arch/ppc/kernel/RCS/ppc_ksyms.c,v
	retrieving revision 1.1
	diff -c -r1.1 arch/ppc/kernel/ppc_ksyms.c
	*** arch/ppc/kernel/ppc_ksyms.c 2000/04/26 14:26:56     1.1
	--- arch/ppc/kernel/ppc_ksyms.c 2000/04/26 14:57:28
	***************
	*** 81,91 ****
	  EXPORT_SYMBOL(kernel_flag);
	  #endif /* __SMP__ */

	- #if !defined(CONFIG_4xx) && !defined(CONFIG_8xx)
	- EXPORT_SYMBOL(isa_io_base);
	- EXPORT_SYMBOL(isa_mem_base);
	- EXPORT_SYMBOL(pci_dram_offset);
	- #endif
	  EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
	  EXPORT_SYMBOL(DMA_MODE_READ);
	  EXPORT_SYMBOL(DMA_MODE_WRITE);
	--- 81,86 ----
	***************
	*** 263,279 ****
	  EXPORT_SYMBOL(xmon);
	  #endif
	  EXPORT_SYMBOL(down_read_failed);
	-
	- extern void (*debugger)(struct pt_regs *regs);
	- extern int (*debugger_bpt)(struct pt_regs *regs);
	- extern int (*debugger_sstep)(struct pt_regs *regs);
	- extern int (*debugger_iabr_match)(struct pt_regs *regs);
	- extern int (*debugger_dabr_match)(struct pt_regs *regs);
	- extern void (*debugger_fault_handler)(struct pt_regs *regs);
	-
	- EXPORT_SYMBOL(debugger);
	- EXPORT_SYMBOL(debugger_bpt);
	- EXPORT_SYMBOL(debugger_sstep);
	- EXPORT_SYMBOL(debugger_iabr_match);
	- EXPORT_SYMBOL(debugger_dabr_match);
	- EXPORT_SYMBOL(debugger_fault_handler);
	--- 258,260 ----

	I was able to compile and link the Linux kernel, but when I ran
	it on the EST SBC8260 board the baud rate appeared to be wrong.  A
	few characters were appearing, but they appeared to be random
	noise.

	I have a few questions concerning the serial console port
	configuration:

	- What serial port is used for the console?  I am assuming that is
	  SMC1.

	  The comments in arch/ppc/mbxboot/m8260_tty.c, indicate the
	  console is on SMC1.  Who calls serial_init?  It doesn't appear
	  to get called from head_8260.S?

	  Are you relying on the monitor do this initialization for you?

	  We are using the VxWorks BSP monitor, is this what is being
	  used by Dan Malek?

	  CPU: EST Corp. est8260 -- MPC8260 PowerQUICC II SBC
	  Version: 5.4
          BSP version: 1.2/3

	  In
	  http://lists.linuxppc.org/listarcs/linuxppc-embedded/200004/msg00158.html
	  Dan talks about
	  "MontaVista has a boot rom with minimal debug support."  Is this
	  different from the VxWorks BSP monitor?

	- What is the baud rate of the console port?

	- What is the speed of the crystal on SBC8260 board?  25 Mhz, 33Mhz,
	  or 50 Mhz?

	- What clock multiplier are you using for the CPM?

Kernel .config file:

#
# Automatically generated make config: don't edit
#
# CONFIG_UID16 is not set

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

#
# Platform support
#
CONFIG_PPC=y
# CONFIG_6xx is not set
# CONFIG_4xx is not set
# CONFIG_PPC64 is not set
CONFIG_8260=y
# CONFIG_8xx is not set
CONFIG_6xx=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_ALL_PPC is not set
# CONFIG_GEMINI is not set
CONFIG_EST8260=y
# CONFIG_APUS is not set
# CONFIG_ALL_PPC is not set
# CONFIG_SMP is not set
# CONFIG_ALTIVEC is not set
CONFIG_MACH_SPECIFIC=y

#
# Loadable module support
#
CONFIG_MODULES=y
# CONFIG_MODVERSIONS is not set
CONFIG_KMOD=y

#
# General setup
#
# CONFIG_ISA is not set
# CONFIG_SBUS is not set
# CONFIG_PCI is not set
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
CONFIG_BINFMT_MISC=y
# CONFIG_HOTPLUG is not set
# CONFIG_PCMCIA is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set
# CONFIG_VGA_CONSOLE is not set
# CONFIG_FB is not set
# CONFIG_PMAC_PBOOK is not set
# CONFIG_MAC_FLOPPY is not set
# CONFIG_MAC_SERIAL is not set
# CONFIG_ADB is not set
# CONFIG_PROC_DEVICETREE is not set
# CONFIG_BOOTX_TEXT is not set
# CONFIG_MOTOROLA_HOTSWAP is not set

#
# Plug and Play configuration
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set

#
# Additional Block Devices
#
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_MD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_INITRD=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
CONFIG_NETLINK=y
# CONFIG_RTNETLINK is not set
# CONFIG_NETLINK_DEV is not set
# CONFIG_NETFILTER is not set
# CONFIG_FILTER is not set
CONFIG_UNIX=y
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
# CONFIG_IP_PNP_BOOTP is not set
CONFIG_IP_PNP_RARP=y
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_IP_ALIAS=y
# CONFIG_SYN_COOKIES is not set

#
# (it is safe to leave these untouched)
#
CONFIG_SKB_LARGE=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_BRIDGE is not set
# CONFIG_LLC is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_FASTROUTE is not set
# CONFIG_NET_HW_FLOWCONTROL is not set

#
# QoS and/or fair queueing
#
# CONFIG_NET_SCHED is not set

#
# ATA/IDE/MFM/RLL support
#
# CONFIG_IDE is not set
# CONFIG_BLK_DEV_IDE_MODES is not set
# CONFIG_BLK_DEV_HD is not set

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
# CONFIG_ETHERTAP is not set
# CONFIG_NET_SB1000 is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_GMAC is not set
# CONFIG_NCR885E is not set
# CONFIG_OAKNET is not set
# CONFIG_NET_VENDOR_3COM is not set
# CONFIG_LANCE is not set
# CONFIG_NET_VENDOR_SMC is not set
# CONFIG_NET_VENDOR_RACAL is not set
# CONFIG_AT1700 is not set
# CONFIG_DEPCA is not set
# CONFIG_NET_ISA is not set
# CONFIG_NET_PCI is not set
# CONFIG_NET_POCKET is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_YELLOWFIN is not set
# CONFIG_ACENIC is not set
# CONFIG_SK98LIN is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
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
# CONFIG_RCPCI is not set
# CONFIG_SHAPER is not set

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

#
# Frame-buffer support
#
# CONFIG_FB is not set

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
# CONFIG_JOYSTICK is not set
# CONFIG_QIC02_TAPE is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_RTC is not set

#
# Video For Linux
#
# CONFIG_VIDEO_DEV is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_DRM is not set
# CONFIG_AGP is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_ROMFS_FS is not set
CONFIG_EXT2_FS=y
# CONFIG_SYSV_FS is not set
# CONFIG_UDF_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFSD is not set
CONFIG_SUNRPC=y
CONFIG_LOCKD=y
# CONFIG_SMB_FS is not set
# CONFIG_NCP_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_NLS is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# MPC8260 Communication Options
#
CONFIG_SCC_ENET=y
CONFIG_SCC1_ENET=y
# CONFIG_FCC_ENET is not set

#
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
