Return-Path: <cpvjagadeesh@yahoo.com>
Received: from web50406.mail.yahoo.com (web50406.mail.yahoo.com
	[206.190.38.71]) by ozlabs.org (Postfix) with SMTP id E578A6894D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 29 Dec 2005 16:28:38 +1100 (EST)
Message-ID: <20051229052837.33192.qmail@web50406.mail.yahoo.com>
Date: Wed, 28 Dec 2005 21:28:37 -0800 (PST)
From: venkatajagadeesh p <cpvjagadeesh@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1883380506-1135834117=:31882"
Subject: re: Porting Linux2.6.13 on MPC860T custom build board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1883380506-1135834117=:31882
Content-Type: multipart/alternative; boundary="0-835740560-1135834117=:31882"

--0-835740560-1135834117=:31882
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

  venkatajagadeesh p wrote:
> 
> Hi,
>      We are trying to port Linux-2.6.13 on Custom build MPC860T, board, 
> We are unable to see any messages on console. We got the output given 
> below. Please help us in porting the kernel.
> I am attaching the config file .
>  
> =>bootm 0x100000
> ## Booting image at 00100000 ...
>    Image Name:   Linux-2.6.13
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    958189 Bytes = 935.7 kB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... gunzip function called
> OK
> do_bootm_linux called ...do_bootm_linux  after ...part2 do_boot_linux 
> before RAM
>  Disk image loading ...
> No initrd
> ## Transferring control to Linux (at address 00000000) ...
> 
> >Most probably, something odd with serial setup.
> >You have enabled just all the stuff (SCC/SMC), but (on 8xx at least)
>>they can hardly live together, having alternative - conflicting IO pin configurations.

   
  We enabling only SMC2, still it is showing the same problem. In U-boot loader we have modified the default console to SMC2. We have not done any modifications to the original linux-2.6.13 code.
   
  I am sending config file as an attachment.
   
  I am sending U-boot env varibles also
  
=>printenv
bootcmd=bootm;setenv bootargs root=/dev/ram rw
bootdelay=5
baudrate=57600
loads_echo=1
ethaddr=9a:52:63:15:85:25
bootfile=uImage
filesize=95f0a
ipaddr=192.168.3.2
serverip=192.168.3.6
netdev=eth0
netmask=255.255.255.0
addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmas
k}:${hostname}:${netdev}:off
ramargs=setenv bootargs root=/dev/ram rw
kernel_addr=0xfc0a0000
ramdisk_addr=0xfc160000
flash_ram=run ramargs addip;bootm 0xfc0a0000 0xfc160000
net_ram=tftpboot 0x100000 uImage;tftpboot 0x400000 rambb2;run ramargs addip;boot
m 0x100000 0x400000
stdin=serial
stdout=serial
stderr=serial
bootargs=root=/dev/ram rw
  Environment size: 638/262140 bytes
   
   


		
---------------------------------
Yahoo! Photos
 Ring in the New Year with Photo Calendars. Add photos, events, holidays, whatever.
--0-835740560-1135834117=:31882
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<DIV id=RTEContent>  <DIV>venkatajagadeesh p wrote:<BR>&gt;<I> <BR></I>&gt;<I> Hi,<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; We are trying to port Linux-2.6.13 on Custom build MPC860T, board, <BR></I>&gt;<I> We are unable to see any messages on console. We got the output given <BR></I>&gt;<I> below. Please help us in porting the kernel.<BR></I>&gt;<I> I am attaching the config file .<BR></I>&gt;<I>&nbsp; <BR></I>&gt;<I> =&gt;bootm 0x100000<BR></I>&gt;<I> ## Booting image at 00100000 ...<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp; Image Name:&nbsp;&nbsp; Linux-2.6.13<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp; Image Type:&nbsp;&nbsp; PowerPC Linux Kernel Image (gzip compressed)<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp; Data Size:&nbsp;&nbsp;&nbsp; 958189 Bytes = 935.7 kB<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp; Load Address: 00000000<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp; Entry Point:&nbsp; 00000000<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp; Verifying Checksum ... OK<BR></I>&gt;<I>&nbsp;&nbsp;&nbsp; Uncompressing Kernel Image ...
 gunzip function called<BR></I>&gt;<I> OK<BR></I>&gt;<I> do_bootm_linux called ...do_bootm_linux&nbsp; after ...part2 do_boot_linux <BR></I>&gt;<I> before RAM<BR></I>&gt;<I>&nbsp; Disk image loading ...<BR></I>&gt;<I> No initrd<BR></I>&gt;<I> ## Transferring control to Linux (at address 00000000) ...<BR></I>&gt;<I> <BR></I>&gt; &gt;Most probably, something odd with serial setup.<BR>&gt; &gt;You have enabled just all the stuff (SCC/SMC), but (on 8xx at least)<BR>&gt;&gt;they can hardly live together, having alternative - conflicting IO pin configurations.<BR></DIV>  <DIV>&nbsp;</DIV>  <DIV>We&nbsp;enabling only SMC2, still it is showing the same&nbsp;problem. In U-boot loader we have modified the default console to SMC2. We have not done any modifications to the original linux-2.6.13 code.</DIV>  <DIV>&nbsp;</DIV>  <DIV>I am sending config file as an attachment.</DIV>  <DIV>&nbsp;</DIV>  <DIV>I am sending&nbsp;U-boot env varibles also</DIV> 
 <DIV><BR>=&gt;printenv<BR>bootcmd=bootm;setenv bootargs root=/dev/ram rw<BR>bootdelay=5<BR>baudrate=57600<BR>loads_echo=1<BR>ethaddr=9a:52:63:15:85:25<BR>bootfile=uImage<BR>filesize=95f0a<BR>ipaddr=192.168.3.2<BR>serverip=192.168.3.6<BR>netdev=eth0<BR>netmask=255.255.255.0<BR>addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmas<BR>k}:${hostname}:${netdev}:off<BR>ramargs=setenv bootargs root=/dev/ram rw<BR>kernel_addr=0xfc0a0000<BR>ramdisk_addr=0xfc160000<BR>flash_ram=run ramargs addip;bootm 0xfc0a0000 0xfc160000<BR>net_ram=tftpboot 0x100000 uImage;tftpboot 0x400000 rambb2;run ramargs addip;boot<BR>m 0x100000 0x400000<BR>stdin=serial<BR>stdout=serial<BR>stderr=serial<BR>bootargs=root=/dev/ram rw</DIV>  <DIV>Environment size: 638/262140 bytes</DIV>  <DIV>&nbsp;</DIV>  <DIV>&nbsp;</DIV></DIV><p>
		<hr size=1>Yahoo! Photos<br> 
Ring in the New Year with <a href="http://us.rd.yahoo.com/mail_us/taglines/photos/*http://pg.photos.yahoo.com/ph//page?.file=calendar_splash.html&.dir=">Photo Calendars</a>. Add photos, events, holidays, whatever.
--0-835740560-1135834117=:31882--

--0-1883380506-1135834117=:31882
Content-Type: text/plain; name=".config"
Content-Description: 172188218-.config
Content-Disposition: inline; filename=".config"

#
# Automatically generated make config: don't edit
# Linux kernel version: 2.6.13
# Thu Dec 29 10:54:14 2005
#
CONFIG_MMU=y
CONFIG_GENERIC_HARDIRQS=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_GENERIC_NVRAM=y
CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32

#
# General setup
#
CONFIG_LOCALVERSION=""
# CONFIG_SWAP is not set
CONFIG_SYSVIPC=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
# CONFIG_AUDIT is not set
# CONFIG_HOTPLUG is not set
CONFIG_KOBJECT_UEVENT=y
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
# CONFIG_KALLSYMS_EXTRA_PASS is not set
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SHMEM=y
CONFIG_CC_ALIGN_FUNCTIONS=0
CONFIG_CC_ALIGN_LABELS=0
CONFIG_CC_ALIGN_LOOPS=0
CONFIG_CC_ALIGN_JUMPS=0
# CONFIG_TINY_SHMEM is not set
CONFIG_BASE_SMALL=0

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor
#
# CONFIG_6xx is not set
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
CONFIG_8xx=y
# CONFIG_E200 is not set
# CONFIG_E500 is not set
# CONFIG_MATH_EMULATION is not set
# CONFIG_KEXEC is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_WANT_EARLY_SERIAL is not set
CONFIG_EMBEDDEDBOOT=y
CONFIG_NOT_COHERENT_CACHE=y

#
# Platform options
#
CONFIG_FADS=y
# CONFIG_RPXLITE is not set
# CONFIG_RPXCLASSIC is not set
# CONFIG_BSEIP is not set
CONFIG_MPC8XXFADS=y
# CONFIG_MPC86XADS is not set
# CONFIG_MPC885ADS is not set
# CONFIG_TQM823L is not set
# CONFIG_TQM850L is not set
# CONFIG_TQM855L is not set
# CONFIG_TQM860L is not set
# CONFIG_FPS850L is not set
# CONFIG_SPD823TS is not set
# CONFIG_IVMS8 is not set
# CONFIG_IVML24 is not set
# CONFIG_SM850 is not set
# CONFIG_HERMES_PRO is not set
# CONFIG_IP860 is not set
# CONFIG_LWMON is not set
# CONFIG_PCU_E is not set
# CONFIG_CCM is not set
# CONFIG_LANTEC is not set
# CONFIG_MBX is not set
# CONFIG_WINCEPT is not set
# CONFIG_HIGHMEM is not set
CONFIG_HZ_100=y
# CONFIG_HZ_250 is not set
# CONFIG_HZ_1000 is not set
CONFIG_HZ=100
CONFIG_PREEMPT_NONE=y
# CONFIG_PREEMPT_VOLUNTARY is not set
# CONFIG_PREEMPT is not set
CONFIG_SELECT_MEMORY_MODEL=y
CONFIG_FLATMEM_MANUAL=y
# CONFIG_DISCONTIGMEM_MANUAL is not set
# CONFIG_SPARSEMEM_MANUAL is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyS1,57600 console=tty1 root=/dev/ram"
# CONFIG_PM is not set
CONFIG_SECCOMP=y
CONFIG_ISA_DMA_API=y

#
# Bus options
#
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS is not set
# CONFIG_PCI_QSPAN is not set

#
# PCCARD (PCMCIA/CardBus) support
#
# CONFIG_PCCARD is not set

#
# Advanced setup
#
# CONFIG_ADVANCED_OPTIONS is not set

#
# Default settings for advanced configuration options are used
#
CONFIG_HIGHMEM_START=0xfe000000
CONFIG_LOWMEM_SIZE=0x30000000
CONFIG_KERNEL_START=0xc0000000
CONFIG_TASK_SIZE=0x80000000
CONFIG_CONSISTENT_START=0xff100000
CONFIG_CONSISTENT_SIZE=0x00200000
CONFIG_BOOT_LOAD=0x00400000

#
# Networking
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
CONFIG_PACKET_MMAP=y
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_FIB_HASH=y
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
CONFIG_ARPD=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_TUNNEL is not set
CONFIG_IP_TCPDIAG=y
CONFIG_IP_TCPDIAG_IPV6=y
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_BIC=y
CONFIG_IPV6=y
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_INET6_TUNNEL is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_NETFILTER is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
CONFIG_BRIDGE=y
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_NET_DIVERT is not set
# CONFIG_ECONET is not set
# CONFIG_WAN_ROUTER is not set
# CONFIG_NET_SCHED is not set
# CONFIG_NET_CLS_ROUTE is not set

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set

#
# Device Drivers
#

#
# Generic Driver Options
#
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Parallel port support
#
# CONFIG_PARPORT is not set

#
# Plug and Play support
#

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
# CONFIG_LBD is not set
# CONFIG_CDROM_PKTCDVD is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
# CONFIG_IOSCHED_AS is not set
# CONFIG_IOSCHED_DEADLINE is not set
# CONFIG_IOSCHED_CFQ is not set
# CONFIG_ATA_OVER_ETH is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
# CONFIG_SCSI is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#

#
# I2O device support
#

#
# Macintosh device drivers
#

#
# Network device support
#
CONFIG_NETDEVICES=y
# CONFIG_DUMMY is not set
# CONFIG_BONDING is not set
# CONFIG_EQUALIZER is not set
# CONFIG_TUN is not set

#
# Ethernet (10 or 100Mbit)
#
CONFIG_NET_ETHERNET=y
CONFIG_MII=y

#
# Ethernet (1000 Mbit)
#

#
# Ethernet (10000 Mbit)
#

#
# Token Ring devices
#

#
# Wireless LAN (non-hamradio)
#
# CONFIG_NET_RADIO is not set

#
# Wan interfaces
#
# CONFIG_WAN is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
# CONFIG_SHAPER is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set

#
# ISDN subsystem
#
# CONFIG_ISDN is not set

#
# Telephony Support
#
# CONFIG_PHONE is not set

#
# Input device support
#
CONFIG_INPUT=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
# CONFIG_INPUT_EVDEV is not set
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Hardware I/O ports
#
# CONFIG_SERIO is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_COMPUTONE is not set
# CONFIG_ROCKETPORT is not set
# CONFIG_CYCLADES is not set
# CONFIG_DIGIEPCA is not set
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_ISI is not set
# CONFIG_SYNCLINKMP is not set
# CONFIG_N_HDLC is not set
# CONFIG_RISCOM8 is not set
# CONFIG_SPECIALIX is not set
# CONFIG_SX is not set
# CONFIG_RIO is not set
# CONFIG_STALDRV is not set

#
# Serial drivers
#
# CONFIG_SERIAL_8250 is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
# CONFIG_SERIAL_CPM_SCC1 is not set
# CONFIG_SERIAL_CPM_SCC2 is not set
# CONFIG_SERIAL_CPM_SCC3 is not set
# CONFIG_SERIAL_CPM_SCC4 is not set
# CONFIG_SERIAL_CPM_SMC1 is not set
CONFIG_SERIAL_CPM_SMC2=y
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
# CONFIG_NVRAM is not set
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_AGP is not set
# CONFIG_RAW_DRIVER is not set

#
# TPM devices
#

#
# I2C support
#
# CONFIG_I2C is not set
# CONFIG_I2C_SENSOR is not set

#
# Dallas's 1-wire bus
#
# CONFIG_W1 is not set

#
# Hardware Monitoring support
#
# CONFIG_HWMON is not set

#
# Misc devices
#

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# Graphics support
#
# CONFIG_FB is not set

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB_ARCH_HAS_HCD is not set
# CONFIG_USB_ARCH_HAS_OHCI is not set

#
# USB Gadget Support
#
# CONFIG_USB_GADGET is not set

#
# MMC/SD Card support
#
# CONFIG_MMC is not set

#
# InfiniBand support
#

#
# SN Devices
#

#
# File systems
#
CONFIG_EXT2_FS=y
CONFIG_EXT2_FS_XATTR=y
CONFIG_EXT2_FS_POSIX_ACL=y
CONFIG_EXT2_FS_SECURITY=y
CONFIG_EXT2_FS_XIP=y
CONFIG_FS_XIP=y
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
CONFIG_FS_POSIX_ACL=y

#
# XFS support
#
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_INOTIFY=y
# CONFIG_QUOTA is not set
CONFIG_DNOTIFY=y
# CONFIG_AUTOFS_FS is not set
# CONFIG_AUTOFS4_FS is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
# CONFIG_MSDOS_FS is not set
# CONFIG_VFAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_SYSFS=y
# CONFIG_DEVPTS_FS_XATTR is not set
# CONFIG_TMPFS is not set
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_CRAMFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set

#
# Network File Systems
#
CONFIG_NFS_FS=y
# CONFIG_NFS_V3 is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_DIRECTIO is not set
# CONFIG_NFSD is not set
CONFIG_ROOT_NFS=y
CONFIG_LOCKD=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_RPCSEC_GSS_KRB5 is not set
# CONFIG_RPCSEC_GSS_SPKM3 is not set
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y

#
# Native Language Support
#
# CONFIG_NLS is not set

#
# MPC8xx CPM Options
#
# CONFIG_SCC_ENET is not set
CONFIG_FEC_ENET=y
CONFIG_USE_MDIO=y
CONFIG_FEC_AM79C874=y
# CONFIG_FEC_LXT970 is not set
# CONFIG_FEC_LXT971 is not set
# CONFIG_FEC_QS6612 is not set
CONFIG_ENET_BIG_BUFFERS=y

#
# Generic MPC8xx Options
#
# CONFIG_8xx_COPYBACK is not set
# CONFIG_8xx_CPU6 is not set
CONFIG_NO_UCODE_PATCH=y
# CONFIG_USB_SOF_UCODE_PATCH is not set
# CONFIG_I2C_SPI_UCODE_PATCH is not set
# CONFIG_I2C_SPI_SMC1_UCODE_PATCH is not set

#
# Library routines
#
# CONFIG_CRC_CCITT is not set
# CONFIG_CRC32 is not set
# CONFIG_LIBCRC32C is not set

#
# Profiling support
#
# CONFIG_PROFILING is not set

#
# Kernel hacking
#
# CONFIG_PRINTK_TIME is not set
# CONFIG_DEBUG_KERNEL is not set
CONFIG_LOG_BUF_SHIFT=14

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set

#
# Hardware crypto devices
#

--0-1883380506-1135834117=:31882--
