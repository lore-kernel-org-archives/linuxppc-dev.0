Message-ID: <20021018051243.97405.qmail@web8004.mail.in.yahoo.com>
Date: Thu, 17 Oct 2002 22:12:43 -0700 (PDT)
From: rekha gvv <rekhagvvc@yahoo.co.in>
Subject: Re: IMMR for fads mpc860/problems to boot linux version 2.4.4
To: wd@denx.de
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-2002850627-1034917963=:96900"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0-2002850627-1034917963=:96900
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
I had read this from the readme file

CFG_IMMR:     Physical address of the Internal Memory

              Mapped Register; DO NOT CHANGE! (11-4)
                [MPC8xx systems only]
and found that in file

/ppcboot /include/ config_FADS860T.h
#define CFG_IMMR                        0xFF000000
#define CFG_IMMR_SIZE           ((uint)(64 * 1024))

and linux-kernel/include/asm-ppc/fads.h
#define IMAP_ADDR               ((uint)0xff000000)
#define IMAP_SIZE               ((uint)(64 * 1024))

Are the values 0xff000000 okay for fads board..
I am sure the above #defines satisfies the rule

Just make sure your machine specific header file (for
instance
include/asm-ppc/tqm8xx.h) includes the same definition
of the Board
Information structure as we define in
include/ppcboot.h, and make
sure that your definition of IMAP_ADDR uses the same
value as your
PPCBoot configuration in CFG_IMMR.

MY main problem is that the fadsboard is not booting
up
it hangs after "Uncompressing Kernel Image OK"
I have checked the faq at the denx site ..and have
done those changes also but of no use...I have
attatched the config file after doing menuconfig ..if
there is any errors possibly please let me know..
also after the kernel compiles i opened the vmlinux
file and saw somwhere in the middle i found these
warnings..
******************************************************
*/usr/src/linux-2.4.4-2002-03-21/include/linux/mount.h.../usr/src/linux-2.4.4-2002-03-21/include
.init=...Kernel command line: %s
....<2>initrd overwritten (0x%08lx < 0x%08lx) -
disabling it.
..POSIX conformance testing by UNIFIX
....linuxrc./dev/console..../linuxrc..../initrd.<3>Change
root to /initrd: error %d
....Warning: unable to open an initial console.
..../sbin/init../etc/init.../bin/init.../bin/sh.No
init found.  Try passing init= option to kernel
..........kernel BUG at %s:%d!
.../usr/src/linux-2.4.4-2002-03-21/include/linux/mount.h.../usr/src/linux-2.4.4-2002-03-21/includ............
****************************************************
there is a warning unable to open initial console...
could u strees on that warning ..and tell me if i
shoul create any /dev/console device in the
kernel...before compiling..
these are the problems ....so hopefully expecting some
hints .
thankyou!
bye!!!!






--- Wolfgang Denk <wd@denx.de> wrote:
> In message
>
<20021017100442.71539.qmail@web8005.mail.in.yahoo.com>
> you wrote:
> >
> > I would like to know what is the physical address
> of
> > Internal memory mapped register for the fads
> mpc860
> > board ..
>
> As the name says, the IMMR is a _register_ and  as
> such  it  has  no
> address, neither a phyical or a virtual one. The
> IMMR contains (among
> some  other  bits) the physical address of the
> internal memory of the
> MPC8xx. We do not know which value you load into
> this  register  (or
> how you initialize your CPU), so which sort of
> answer do you expect?
>
> > and please verify if the values of the registers
> are
> > correct in the file
>
> These are no register values, but just some
> #define'd  constants.  I
> see no problems here.
>
>
> Ummm... what is your real problem?
>
> Best regards,
>
> Wolfgang Denk
>
> --
> Software Engineering:  Embedded and Realtime
> Systems,  Embedded Linux
> Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88
> Email: wd@denx.de
> core error - bus dumped



--0-2002850627-1034917963=:96900
Content-Type: text/plain; name=config
Content-Description: config
Content-Disposition: inline; filename=config

#
# Automatically generated make config: don't edit
#
# CONFIG_UID16 is not set
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set
CONFIG_RWSEM_XCHGADD_ALGORITHM=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y

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
# CONFIG_6xx is not set
# CONFIG_8240 is not set
# CONFIG_4xx is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
CONFIG_8xx=y
# CONFIG_CU824 is not set
CONFIG_SERIAL_CONSOLE=y
# CONFIG_AMX860 is not set
# CONFIG_BSEIP is not set
# CONFIG_C2MON is not set
# CONFIG_CCM is not set
# CONFIG_ETX094 is not set
CONFIG_FADS860=y
# CONFIG_FPS850L is not set
# CONFIG_HERMES is not set
# CONFIG_HERMES_SH is not set
# CONFIG_ICU862 is not set
# CONFIG_IP860 is not set
# CONFIG_IVML24 is not set
# CONFIG_IVMS8 is not set
# CONFIG_LANTEC is not set
# CONFIG_LWMON is not set
# CONFIG_MBX is not set
# CONFIG_PCU_E is not set
# CONFIG_RPXCLASSIC is not set
# CONFIG_RPXLITE is not set
# CONFIG_SM850 is not set
# CONFIG_SPD823TS is not set
# CONFIG_TQM823L is not set
# CONFIG_TQM850L is not set
# CONFIG_TQM855L is not set
# CONFIG_TQM860 is not set
# CONFIG_TQM860L is not set
# CONFIG_TQM823L is not set
# CONFIG_WINCEPT is not set
# CONFIG_PPC601_SYNC_FIX is not set
# CONFIG_ALL_PPC is not set
# CONFIG_SMP is not set
CONFIG_MACH_SPECIFIC=y
CONFIG_MATH_EMULATION=y
# CONFIG_SASH is not set

#
# General setup
#
# CONFIG_HIGHMEM is not set
# CONFIG_ISA is not set
# CONFIG_EISA is not set
# CONFIG_SBUS is not set
# CONFIG_MCA is not set
# CONFIG_PCI_QSPAN is not set
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

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

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
CONFIG_BLK_DEV_RAM_SIZE=4096
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
# CONFIG_BLK_DEV_LVM is not set

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
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_INET_ECN is not set
# CONFIG_SYN_COOKIES is not set
# CONFIG_IPV6 is not set
# CONFIG_KHTTPD is not set
# CONFIG_ATM is not set

#
#
#
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_LLC is not set
# CONFIG_NET_DIVERT is not set
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
# CONFIG_TUN is not set
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
# CONFIG_ACENIC is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
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
# Input core support
#
# CONFIG_INPUT is not set

#
# Macintosh device drivers
#

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_SERIAL_EXTENDED is not set
# CONFIG_SERIAL_NONSTANDARD is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=32

#
# I2C support
#
# CONFIG_I2C is not set
# CONFIG_I2C_ALGOBIT is not set
# CONFIG_I2C_ALGOPCF is not set
# CONFIG_I2C_ELEKTOR is not set
# CONFIG_I2C_ALGO8XX is not set
# CONFIG_I2C_RPXLITE is not set
# CONFIG_I2C_LWMON is not set
# CONFIG_I2C_CHARDEV is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_MOUSE is not set

#
# Joysticks
#
# CONFIG_JOYSTICK is not set

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
# CONFIG_PCF8563_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set
# CONFIG_FLASH is not set

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
# CONFIG_JFFS_FS is not set
# CONFIG_JFFS2_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_TMPFS is not set
# CONFIG_RAMFS is not set
# CONFIG_ISO9660_FS is not set
# CONFIG_JOLIET is not set
# CONFIG_MINIX_FS is not set
# CONFIG_NTFS_FS is not set
# CONFIG_NTFS_RW is not set
# CONFIG_HPFS_FS is not set
CONFIG_PROC_FS=y
CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVFS_DEBUG=y
CONFIG_DEVPTS_FS=y
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX4FS_RW is not set
CONFIG_ROMFS_FS=y
CONFIG_EXT2_FS=y
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
# CONFIG_NCPFS_NLS is not set
# CONFIG_NCPFS_EXTRAS is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
# CONFIG_MSDOS_PARTITION is not set
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
# MPC8xx CPM Options
#
# CONFIG_SCC_ENET is not set
# CONFIG_SCC1_ENET is not set
# CONFIG_SCC2_ENET is not set
# CONFIG_SCC3_ENET is not set
CONFIG_FEC_ENET=y
# CONFIG_USE_MDIO is not set
# CONFIG_FEC_AM79C874 is not set
# CONFIG_FEC_LXT970 is not set
# CONFIG_FEC_LXT971 is not set
# CONFIG_FEC_QS6612 is not set
# CONFIG_ENET_BIG_BUFFERS is not set
CONFIG_SMC1_UART=y
CONFIG_CONS_SMC1=y
CONFIG_UART_MAXIDL_SMC1=1
CONFIG_SMC1_UART_RX_BDNUM=4
CONFIG_SMC1_UART_RX_BDSIZE=32
CONFIG_SMC1_UART_TX_BDNUM=4
CONFIG_SMC1_UART_TX_BDSIZE=32
CONFIG_SMC2_UART=y
# CONFIG_ALTSMC2 is not set
# CONFIG_CONS_SMC2 is not set
CONFIG_UART_MAXIDL_SMC2=1
CONFIG_SMC2_UART_RX_BDNUM=4
CONFIG_SMC2_UART_RX_BDSIZE=32
CONFIG_SMC2_UART_TX_BDNUM=4
CONFIG_SMC2_UART_TX_BDSIZE=32
# CONFIG_USE_SCC_IO is not set

#
# Generic MPC8xx Options
#
CONFIG_8xx_COPYBACK=y
# CONFIG_8xx_CPU6 is not set
# CONFIG_UCODE_PATCH is not set
# CONFIG_8XX_USE_RISC_TIMERS is not set
# CONFIG_8xx_LCD is not set
# CONFIG_8xx_PWM is not set

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
CONFIG_BDI_SWITCH=y

--0-2002850627-1034917963=:96900--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
