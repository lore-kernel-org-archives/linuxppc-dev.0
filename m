Date: Mon, 18 Sep 2000 17:16:27 +0300
From: Alex Shnitman <alexsh@hectic.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: kgdb/Sandpoint -- patch & help needed
Message-ID: <20000918171627.B4328@hectic.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Could somebody help me get kgdb working on this platform? I'm totally
stuck with this problem of stuff crashing on my Sandpoint, and there's
no way I could do anything about it without a debugger.

Here are my humble attempts. Basically there's already support for
kgdb on the ppc, but not for Sandpoint specifically. getDebugChar and
putDebugChar are defined for the 8xx UART, but the Sandpoint uses the
standard 16650 UART. So I took the i386 kgdb patch and took out the
parts that I need from it -- gdbserial.c, some Makefile diffs, and
some changes in serial.c and main.c (left as is from the i386 patch, I
just changed #ifdef CONFIG_X86_REMOTE_DEBUG to CONFIG_KGDB). For the
rest of the stuff (traps, stub) I rely on the existing kgdb support
that's in the ppc tree already. However, with this patch the kernel
hangs right after saying "Now booting the kernel". I don't even see
how these changes could affect the boot process so early.

I'm attaching the patch. It's against Mark's latest 2.4.0-test2
snapshot (that's in Area51 on ftp.mvista.com). Could someone please
look at it and see what I did wrong and why it doesn't work?

Thanks a lot in advance!

(I'm also attaching the .config that I'm using, for what it's worth.)


--
Alex Shnitman                            | http://www.debian.org
alexsh@hectic.net, alexsh@linux.org.il   +-----------------------
http://alexsh.hectic.net    UIN 188956    PGP key on web page
       E1 F2 7B 6C A0 31 80 28  63 B8 02 BA 65 C7 8B BA

A bit of irony for you: Bill Gates claims to be trying to make a stable
operating system, while Linus Torvalds claims to be trying to take over
the world.
	-- Ernie Miller

--YZ5djTAD1cGYuMQK
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="kgdb-patch.gz"
Content-Transfer-Encoding: base64

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

--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=config-kgdb

#
# Automatically generated by make menuconfig: don't edit
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
CONFIG_6xx=y
# CONFIG_4xx is not set
# CONFIG_PPC64BRIDGE is not set
# CONFIG_8260 is not set
# CONFIG_8xx is not set
# CONFIG_ALL_PPC is not set
# CONFIG_GEMINI is not set
# CONFIG_EST8260 is not set
CONFIG_SANDPOINT=y
# CONFIG_APUS is not set
# CONFIG_SMP is not set
# CONFIG_RTSCHED is not set
CONFIG_ALTIVEC=y
CONFIG_MACH_SPECIFIC=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# General setup
#
# CONFIG_ISA is not set
# CONFIG_SBUS is not set
CONFIG_PCI=y
CONFIG_CHRP_MAPB=y
CONFIG_NET=y
CONFIG_SYSCTL=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_KERNEL_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_PCI_NAMES=y
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
# CONFIG_ISAPNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_XD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_LVM is not set
# CONFIG_BLK_DEV_MD is not set
# CONFIG_MD_LINEAR is not set
# CONFIG_MD_RAID0 is not set
# CONFIG_MD_RAID1 is not set
# CONFIG_MD_RAID5 is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_BLK_DEV_FLASH is not set

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
CONFIG_IP_PNP_BOOTP=y
# CONFIG_IP_PNP_RARP is not set
# CONFIG_IP_ROUTER is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_ALIAS is not set
# CONFIG_SYN_COOKIES is not set
CONFIG_SKB_LARGE=y
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
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
# IEEE 1394 (FireWire) support
#
# CONFIG_IEEE1394 is not set

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
CONFIG_NET_PCI=y
# CONFIG_PCNET32 is not set
# CONFIG_ADAPTEC_STARFIRE is not set
# CONFIG_AC3200 is not set
# CONFIG_APRICOT is not set
# CONFIG_CS89x0 is not set
# CONFIG_DE4X5 is not set
# CONFIG_TULIP is not set
# CONFIG_DGRS is not set
# CONFIG_DM9102 is not set
CONFIG_EEPRO100=y
# CONFIG_EEPRO100_PM is not set
# CONFIG_LNE390 is not set
# CONFIG_NE3210 is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_RTL8129 is not set
# CONFIG_8139TOO is not set
# CONFIG_SIS900 is not set
# CONFIG_TLAN is not set
# CONFIG_VIA_RHINE is not set
# CONFIG_ES3210 is not set
# CONFIG_EPIC100 is not set
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
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
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
# CONFIG_INTEL_RNG is not set
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
# CONFIG_DRM_TDFX is not set
# CONFIG_AGP is not set

#
# File systems
#
# CONFIG_QUOTA is not set
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_ADFS_FS_RW is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_FAT_FS is not set
# CONFIG_MSDOS_FS is not set
# CONFIG_UMSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
# CONFIG_DEVFS_FS is not set
# CONFIG_DEVFS_MOUNT is not set
# CONFIG_DEVFS_DEBUG is not set
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_EXT2_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_SYSV_FS_WRITE is not set
# CONFIG_UDF_FS is not set
# CONFIG_UDF_RW is not set
# CONFIG_UFS_FS is not set
# CONFIG_UFS_FS_WRITE is not set

#
# Network File Systems
#
# CONFIG_CODA_FS is not set
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
# CONFIG_NCPFS_MOUNT_SUBDIR is not set
# CONFIG_NCPFS_NDS_DOMAINS is not set
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

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
# USB support
#
# CONFIG_USB is not set

#
# Kernel hacking
#
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_KGDB=y
# CONFIG_XMON is not set

--YZ5djTAD1cGYuMQK--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
