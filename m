Message-ID: <A0CF3E6CD78CD411B369009027B0FCFE04313412@MIMIR>
From: Stan Partridge <SPartridge@CTDI.COM>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Unable to get SCC 4 working as a console port on a 8260ADS
Date: Thu, 29 Apr 2004 18:47:45 -0400
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C42E3B.FCB1DEC0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C42E3B.FCB1DEC0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


I am a newbie to Embedded linux and I am unable to get SCC4 working as =
my
console device for my custom board.  I am using Linux 2.4.24 from ELDK =
3.0.
U-boot works greats with SCC4 defined as my console device.  I must use =
SCC4
as my console device because my board has no more pins left that I can =
use.
In addition, I can not use the hardware handshaking pins as well.  I =
only
have the 2 wires - Rx and Tx available. I am using all 3 FCCs and using =
an
SMC as a serial port is not an option due to its intensive FSM and drag =
on
the CP.

I attemptted to boot linux but it traps at console_printk.  After the =
trap,
the SCC4 Registers look good to me so I guess the port has been =
initialized:

GSMR_L4    00028034    Tx and Rx enabled
GSMR_H4    00000020
PSMR4        B000
TODR4         8000
DSR4           7E7E
SCCE4         0107
SCCM4        0000
SCCS4         03

The log_buf contains the following:

........
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
CPU UART driver version 0.01
ttyS0 on SCC1 at 0x8000 BRG7
ttyS1 on SCC2 at 0x8100 BRG1
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS enabled
Oops: kernel access of bad area, sig: 11
NIP: C00E8EF4  XER: 0000000 LR: C00ED804 SP: C039FE90 REGS: C039FDE0
TRAP:0300 Not tainted
....
TASK=3D c039e000[1] 'swapper' Last syscall: 120
last math 00000000 last altivec 00000000
GPR0: ......
.......
Call backtrace:
 c0198e60 - console_printk
 c01b7e58 - early_serial_setup
 c01af63c - do_initcalls
 c01af684 - do_basic_setup
 c00039d0 - init
 c0008338 - arch_kernel_thread
Kernel panic: Attempted to kill init!
Rebooting in 180 seconds.


A few seconds later the console terminal spews pages and pages of the
following junk:

=BA0@=90=C0!=BA=90@

I'm using the uRamdisk (SELF) image found in ELDK 3.0 as my ram disk.  =
My
boot session and config files are attached

Any suggestions on how I should preceed?

Thanks in advance!
Stan Partridge

 <<bootSession.txt>>  <<ads8260-fs.config>>=20


------_=_NextPart_000_01C42E3B.FCB1DEC0
Content-Type: text/plain;
	name="bootSession.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bootSession.txt"




U-Boot 1.0.2 (Apr 29 2004 - 11:17:37)

MPC8260 Reset Status: External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 2x, VCO Div 2, 60x Bus Freq  50-150, Core Freq =
100-300
 - dfbrg 1, corecnf 0x04, busdf 3, cpmdf 1, plldf 0, pllmf 1
 - vco_out  264000000, scc_clk   66000000, brg_clk   16500000
 - cpu_clk  132000000, cpm_clk  132000000, bus_clk   66000000

CPU:   MPC8260 (HiP3 Rev 01, Mask B.3 3K23A) at 132 MHz
Board: Motorola MPC8260ADS
DRAM:  128 MB
In:    serial
Out:   serial
Err:   serial
DOC:   DiskOnChip Millennium @ 0xFC000000, 32 MB
Net:   FCC3 ETHERNET
Hit any key to stop autoboot:  0

=3D> bootm 2000000 3000000
checkpoint # 1
## Booting image at 02000000 ...
checkpoint # 2
checkpoint # 3
   Image Name:   IMAS Remote load at 0 entry at c
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    817534 Bytes =3D 798.4 kB
   Load Address: 00000000
   Entry Point:  0000000c
   Verifying Checksum ... OK
checkpoint # 4
checkpoint # 5
checkpoint # 6
   Uncompressing Kernel Image ... OK
checkpoint # 7
checkpoint # 8
checkpoint # 9
## Current stack ends at 0x07BC5788 =3D> set upper limit to 0x00800000
bd info to linux 0x007ffeb0 uboot copy at 0x07bc5790
## cmdline at 0x007FFF00 ... 0x007FFF23

cmdline:root=3D/dev/ram rw console=3DttyS3,9600
bd address  =3D 0x07BC5AB4
memstart    =3D 0x00000000
memsize     =3D 0x08000000
flashstart  =3D 0x00000000
flashsize   =3D 0x00000000
flashoffset =3D 0x00000000
sramstart   =3D 0x00000000
sramsize    =3D 0x00000000
immr_base   =3D 0xFA200000
bootflags   =3D 0x00000001
vco         =3D    264 MHz
sccfreq     =3D     66 MHz
brgfreq     =3D 16.500 MHz
intfreq     =3D    132 MHz
cpmfreq     =3D    132 MHz
busfreq     =3D     66 MHz
ethaddr     =3D 00:90:8E:AB:7C:C4
IP addr     =3D 192.168.116.66
baudrate    =3D   9600 bps

## initrd at 0x03000040 ... 0x03186B6A (len=3D1600299=3D0x186B2B)
   Loading Ramdisk to 07a3e000, end 07bc4b2b ... OK
## Transferring control to Linux (at address 0000000c) ...
checkpoint # 15
=C0!p =C0!p @=C0=C0!pP=C0!pP@=C0!p=20

spew .... spew ... spew








------_=_NextPart_000_01C42E3B.FCB1DEC0
Content-Type: application/octet-stream;
	name="ads8260-fs.config"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ads8260-fs.config"

#=0A=
# Automatically generated by make menuconfig: don't edit=0A=
#=0A=
# CONFIG_UID16 is not set=0A=
# CONFIG_RWSEM_GENERIC_SPINLOCK is not set=0A=
CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy=0A=
CONFIG_HAVE_DEC_LOCK=3Dy=0A=
=0A=
#=0A=
# Code maturity level options=0A=
#=0A=
CONFIG_EXPERIMENTAL=3Dy=0A=
CONFIG_ADVANCED_OPTIONS=3Dy=0A=
=0A=
#=0A=
# Loadable module support=0A=
#=0A=
CONFIG_MODULES=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
CONFIG_KMOD=3Dy=0A=
=0A=
#=0A=
# Platform support=0A=
#=0A=
CONFIG_PPC=3Dy=0A=
CONFIG_PPC32=3Dy=0A=
CONFIG_6xx=3Dy=0A=
# CONFIG_40x is not set=0A=
# CONFIG_44x is not set=0A=
# CONFIG_POWER3 is not set=0A=
# CONFIG_POWER4 is not set=0A=
# CONFIG_8xx is not set=0A=
CONFIG_8260=3Dy=0A=
CONFIG_PPC_STD_MMU=3Dy=0A=
CONFIG_SERIAL_CONSOLE=3Dy=0A=
# CONFIG_ATC is not set=0A=
CONFIG_ADS8260=3Dy=0A=
# CONFIG_EST8260 is not set=0A=
# CONFIG_PM826 is not set=0A=
# CONFIG_SBS8260 is not set=0A=
# CONFIG_RPX6 is not set=0A=
# CONFIG_TQM8260 is not set=0A=
# CONFIG_WILLOW is not set=0A=
# CONFIG_SMP is not set=0A=
CONFIG_EMBEDDEDBOOT=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
CONFIG_HIGHMEM=3Dy=0A=
# CONFIG_HIGHMEM_START_BOOL is not set=0A=
# CONFIG_LOWMEM_SIZE_BOOL is not set=0A=
# CONFIG_KERNEL_START_BOOL is not set=0A=
# CONFIG_TASK_SIZE_BOOL is not set=0A=
CONFIG_HIGHMEM_START=3D0xfe000000=0A=
CONFIG_LOWMEM_SIZE=3D0x30000000=0A=
CONFIG_KERNEL_START=3D0xc0000000=0A=
CONFIG_TASK_SIZE=3D0x80000000=0A=
# CONFIG_ISA is not set=0A=
# CONFIG_EISA is not set=0A=
# CONFIG_SBUS is not set=0A=
# CONFIG_MCA is not set=0A=
# CONFIG_PCI is not set=0A=
# CONFIG_8260_PCI9 is not set=0A=
# CONFIG_PC_KEYBOARD is not set=0A=
CONFIG_NET=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_KCORE_ELF=3Dy=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_KERNEL_ELF=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
# CONFIG_HOTPLUG is not set=0A=
# CONFIG_PCMCIA is not set=0A=
=0A=
#=0A=
# Parallel port support=0A=
#=0A=
# CONFIG_PARPORT is not set=0A=
# CONFIG_GEN_RTC is not set=0A=
# CONFIG_PPC_RTC is not set=0A=
# CONFIG_CMDLINE_BOOL is not set=0A=
=0A=
#=0A=
# Memory Technology Devices (MTD)=0A=
#=0A=
# CONFIG_MTD is not set=0A=
=0A=
#=0A=
# Plug and Play configuration=0A=
#=0A=
# CONFIG_PNP is not set=0A=
# CONFIG_ISAPNP is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_CPQ_CISS_DA is not set=0A=
# CONFIG_CISS_SCSI_TAPE is not set=0A=
# CONFIG_CISS_MONITOR_THREAD is not set=0A=
# CONFIG_BLK_DEV_DAC960 is not set=0A=
# CONFIG_BLK_DEV_UMEM is not set=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
# CONFIG_BLK_DEV_NBD is not set=0A=
CONFIG_BLK_DEV_RAM=3Dy=0A=
CONFIG_BLK_DEV_RAM_SIZE=3D4096=0A=
CONFIG_BLK_DEV_INITRD=3Dy=0A=
# CONFIG_BLK_STATS is not set=0A=
=0A=
#=0A=
# Multi-device support (RAID and LVM)=0A=
#=0A=
# CONFIG_MD is not set=0A=
# CONFIG_BLK_DEV_MD is not set=0A=
# CONFIG_MD_LINEAR is not set=0A=
# CONFIG_MD_RAID0 is not set=0A=
# CONFIG_MD_RAID1 is not set=0A=
# CONFIG_MD_RAID5 is not set=0A=
# CONFIG_MD_MULTIPATH is not set=0A=
# CONFIG_BLK_DEV_LVM is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
# CONFIG_PACKET_MMAP is not set=0A=
# CONFIG_NETLINK_DEV is not set=0A=
CONFIG_NETFILTER=3Dy=0A=
# CONFIG_NETFILTER_DEBUG is not set=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
CONFIG_IP_MULTICAST=3Dy=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
CONFIG_IP_PNP=3Dy=0A=
# CONFIG_IP_PNP_DHCP is not set=0A=
CONFIG_IP_PNP_BOOTP=3Dy=0A=
# CONFIG_IP_PNP_RARP is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_MROUTE is not set=0A=
# CONFIG_ARPD is not set=0A=
# CONFIG_INET_ECN is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
=0A=
#=0A=
#   IP: Netfilter Configuration=0A=
#=0A=
# CONFIG_IP_NF_CONNTRACK is not set=0A=
# CONFIG_IP_NF_QUEUE is not set=0A=
# CONFIG_IP_NF_IPTABLES is not set=0A=
# CONFIG_IP_NF_ARPTABLES is not set=0A=
# CONFIG_IP_NF_COMPAT_IPCHAINS is not set=0A=
# CONFIG_IP_NF_COMPAT_IPFWADM is not set=0A=
=0A=
#=0A=
#   IP: Virtual Server Configuration=0A=
#=0A=
# CONFIG_IP_VS is not set=0A=
# CONFIG_IPV6 is not set=0A=
# CONFIG_KHTTPD is not set=0A=
=0A=
#=0A=
#    SCTP Configuration (EXPERIMENTAL)=0A=
#=0A=
CONFIG_IPV6_SCTP__=3Dy=0A=
# CONFIG_IP_SCTP is not set=0A=
# CONFIG_ATM is not set=0A=
# CONFIG_VLAN_8021Q is not set=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
=0A=
#=0A=
# Appletalk devices=0A=
#=0A=
# CONFIG_DEV_APPLETALK is not set=0A=
# CONFIG_DECNET is not set=0A=
# CONFIG_BRIDGE is not set=0A=
# CONFIG_X25 is not set=0A=
# CONFIG_LAPB is not set=0A=
# CONFIG_LLC is not set=0A=
# CONFIG_NET_DIVERT is not set=0A=
# CONFIG_ECONET is not set=0A=
# CONFIG_WAN_ROUTER is not set=0A=
# CONFIG_NET_FASTROUTE is not set=0A=
# CONFIG_NET_HW_FLOWCONTROL is not set=0A=
=0A=
#=0A=
# QoS and/or fair queueing=0A=
#=0A=
# CONFIG_NET_SCHED is not set=0A=
=0A=
#=0A=
# Network testing=0A=
#=0A=
# CONFIG_NET_PKTGEN is not set=0A=
=0A=
#=0A=
# ATA/IDE/MFM/RLL support=0A=
#=0A=
# CONFIG_IDE is not set=0A=
# CONFIG_BLK_DEV_IDE_MODES is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
=0A=
#=0A=
# Fusion MPT device support=0A=
#=0A=
# CONFIG_FUSION is not set=0A=
# CONFIG_FUSION_BOOT is not set=0A=
# CONFIG_FUSION_ISENSE is not set=0A=
# CONFIG_FUSION_CTL is not set=0A=
# CONFIG_FUSION_LAN is not set=0A=
=0A=
#=0A=
# I2O device support=0A=
#=0A=
# CONFIG_I2O is not set=0A=
# CONFIG_I2O_BLOCK is not set=0A=
# CONFIG_I2O_LAN is not set=0A=
# CONFIG_I2O_SCSI is not set=0A=
# CONFIG_I2O_PROC is not set=0A=
=0A=
#=0A=
# Network device support=0A=
#=0A=
CONFIG_NETDEVICES=3Dy=0A=
=0A=
#=0A=
# ARCnet devices=0A=
#=0A=
# CONFIG_ARCNET is not set=0A=
# CONFIG_DUMMY is not set=0A=
# CONFIG_BONDING is not set=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_TUN is not set=0A=
# CONFIG_ETHERTAP is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_MACE is not set=0A=
# CONFIG_BMAC is not set=0A=
# CONFIG_GMAC is not set=0A=
# CONFIG_SUNLANCE is not set=0A=
# CONFIG_SUNBMAC is not set=0A=
# CONFIG_SUNQE is not set=0A=
# CONFIG_SUNGEM is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_NET_ISA is not set=0A=
# CONFIG_NET_PCI is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
=0A=
#=0A=
# Ethernet (1000 Mbit)=0A=
#=0A=
# CONFIG_ACENIC is not set=0A=
# CONFIG_DL2K is not set=0A=
# CONFIG_E1000 is not set=0A=
# CONFIG_MYRI_SBUS is not set=0A=
# CONFIG_NS83820 is not set=0A=
# CONFIG_HAMACHI is not set=0A=
# CONFIG_YELLOWFIN is not set=0A=
# CONFIG_R8169 is not set=0A=
# CONFIG_SK98LIN is not set=0A=
# CONFIG_TIGON3 is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_HIPPI is not set=0A=
# CONFIG_PLIP is not set=0A=
CONFIG_PPP=3Dy=0A=
CONFIG_PPP_MULTILINK=3Dy=0A=
# CONFIG_PPP_FILTER is not set=0A=
CONFIG_PPP_ASYNC=3Dy=0A=
# CONFIG_PPP_SYNC_TTY is not set=0A=
CONFIG_PPP_DEFLATE=3Dy=0A=
# CONFIG_PPP_BSDCOMP is not set=0A=
CONFIG_PPPOE=3Dy=0A=
# CONFIG_SLIP is not set=0A=
=0A=
#=0A=
# Wireless LAN (non-hamradio)=0A=
#=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token Ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
# CONFIG_RCPCI is not set=0A=
# CONFIG_SHAPER is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_WAN is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
=0A=
#=0A=
# IrDA (infrared) support=0A=
#=0A=
# CONFIG_IRDA is not set=0A=
=0A=
#=0A=
# ISDN subsystem=0A=
#=0A=
# CONFIG_ISDN is not set=0A=
=0A=
#=0A=
# Old CD-ROM drivers (not SCSI, not IDE)=0A=
#=0A=
# CONFIG_CD_NO_IDESCSI is not set=0A=
=0A=
#=0A=
# Console drivers=0A=
#=0A=
# CONFIG_VGA_CONSOLE is not set=0A=
=0A=
#=0A=
# Frame-buffer support=0A=
#=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Input core support=0A=
#=0A=
CONFIG_INPUT=3Dy=0A=
CONFIG_INPUT_KEYBDEV=3Dy=0A=
# CONFIG_INPUT_MOUSEDEV is not set=0A=
# CONFIG_INPUT_JOYDEV is not set=0A=
# CONFIG_INPUT_EVDEV is not set=0A=
# CONFIG_INPUT_UINPUT is not set=0A=
=0A=
#=0A=
# Macintosh device drivers=0A=
#=0A=
=0A=
#=0A=
# Character devices=0A=
#=0A=
CONFIG_VT=3Dy=0A=
CONFIG_VT_CONSOLE=3Dy=0A=
CONFIG_SERIAL=3Dy=0A=
CONFIG_SERIAL_CONSOLE=3Dy=0A=
CONFIG_SERIAL_EXTENDED=3Dy=0A=
CONFIG_SERIAL_MANY_PORTS=3Dy=0A=
# CONFIG_SERIAL_SHARE_IRQ is not set=0A=
# CONFIG_SERIAL_DETECT_IRQ is not set=0A=
# CONFIG_SERIAL_MULTIPORT is not set=0A=
# CONFIG_HUB6 is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D32=0A=
=0A=
#=0A=
# I2C support=0A=
#=0A=
# CONFIG_I2C is not set=0A=
=0A=
#=0A=
# Mice=0A=
#=0A=
# CONFIG_BUSMOUSE is not set=0A=
# CONFIG_MOUSE is not set=0A=
=0A=
#=0A=
# Joysticks=0A=
#=0A=
# CONFIG_INPUT_GAMEPORT is not set=0A=
# CONFIG_INPUT_NS558 is not set=0A=
# CONFIG_INPUT_LIGHTNING is not set=0A=
# CONFIG_INPUT_PCIGAME is not set=0A=
# CONFIG_INPUT_CS461X is not set=0A=
# CONFIG_INPUT_EMU10K1 is not set=0A=
# CONFIG_INPUT_SERIO is not set=0A=
# CONFIG_INPUT_SERPORT is not set=0A=
# CONFIG_INPUT_ANALOG is not set=0A=
# CONFIG_INPUT_A3D is not set=0A=
# CONFIG_INPUT_ADI is not set=0A=
# CONFIG_INPUT_COBRA is not set=0A=
# CONFIG_INPUT_GF2K is not set=0A=
# CONFIG_INPUT_GRIP is not set=0A=
# CONFIG_INPUT_INTERACT is not set=0A=
# CONFIG_INPUT_TMDC is not set=0A=
# CONFIG_INPUT_SIDEWINDER is not set=0A=
# CONFIG_INPUT_IFORCE_USB is not set=0A=
# CONFIG_INPUT_IFORCE_232 is not set=0A=
# CONFIG_INPUT_WARRIOR is not set=0A=
# CONFIG_INPUT_MAGELLAN is not set=0A=
# CONFIG_INPUT_SPACEORB is not set=0A=
# CONFIG_INPUT_SPACEBALL is not set=0A=
# CONFIG_INPUT_STINGER is not set=0A=
# CONFIG_INPUT_DB9 is not set=0A=
# CONFIG_INPUT_GAMECON is not set=0A=
# CONFIG_INPUT_TURBOGRAFX is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
# CONFIG_IPMI_HANDLER is not set=0A=
# CONFIG_IPMI_PANIC_EVENT is not set=0A=
# CONFIG_IPMI_DEVICE_INTERFACE is not set=0A=
# CONFIG_IPMI_KCS is not set=0A=
# CONFIG_IPMI_WATCHDOG is not set=0A=
=0A=
#=0A=
# Watchdog Cards=0A=
#=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_SCx200_GPIO is not set=0A=
# CONFIG_AMD_PM768 is not set=0A=
# CONFIG_NVRAM is not set=0A=
# CONFIG_RTC is not set=0A=
# CONFIG_RTC_11_MINUTE_MODE is not set=0A=
# CONFIG_PCF8563_RTC is not set=0A=
# CONFIG_DTLK is not set=0A=
# CONFIG_R3964 is not set=0A=
# CONFIG_APPLICOM is not set=0A=
# CONFIG_FLASH is not set=0A=
# CONFIG_STATUS_LED is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_AGP is not set=0A=
=0A=
#=0A=
# Direct Rendering Manager (XFree86 DRI support)=0A=
#=0A=
# CONFIG_DRM is not set=0A=
=0A=
#=0A=
# Multimedia devices=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# File systems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_QFMT_V2 is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
CONFIG_AUTOFS4_FS=3Dy=0A=
# CONFIG_REISERFS_FS is not set=0A=
# CONFIG_REISERFS_CHECK is not set=0A=
# CONFIG_REISERFS_PROC_INFO is not set=0A=
# CONFIG_ADFS_FS is not set=0A=
# CONFIG_ADFS_FS_RW is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_HFSPLUS_FS is not set=0A=
# CONFIG_BEFS_FS is not set=0A=
# CONFIG_BEFS_DEBUG is not set=0A=
# CONFIG_BFS_FS is not set=0A=
# CONFIG_EXT3_FS is not set=0A=
# CONFIG_JBD is not set=0A=
# CONFIG_JBD_DEBUG is not set=0A=
# CONFIG_FAT_FS is not set=0A=
# CONFIG_MSDOS_FS is not set=0A=
# CONFIG_UMSDOS_FS is not set=0A=
# CONFIG_VFAT_FS is not set=0A=
# CONFIG_EFS_FS is not set=0A=
# CONFIG_JFFS_FS is not set=0A=
# CONFIG_JFFS2_FS is not set=0A=
CONFIG_CRAMFS=3Dy=0A=
# CONFIG_TMPFS is not set=0A=
CONFIG_RAMFS=3Dy=0A=
# CONFIG_ISO9660_FS is not set=0A=
# CONFIG_JOLIET is not set=0A=
# CONFIG_ZISOFS is not set=0A=
# CONFIG_JFS_FS is not set=0A=
# CONFIG_JFS_DEBUG is not set=0A=
# CONFIG_JFS_STATISTICS is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_VXFS_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_NTFS_RW is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_DEVFS_FS=3Dy=0A=
CONFIG_DEVFS_MOUNT=3Dy=0A=
# CONFIG_DEVFS_DEBUG is not set=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_QNX4FS_FS is not set=0A=
# CONFIG_QNX4FS_RW is not set=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UDF_FS is not set=0A=
# CONFIG_UDF_RW is not set=0A=
# CONFIG_UFS_FS is not set=0A=
# CONFIG_UFS_FS_WRITE is not set=0A=
# CONFIG_XFS_FS is not set=0A=
# CONFIG_XFS_QUOTA is not set=0A=
# CONFIG_XFS_RT is not set=0A=
# CONFIG_XFS_TRACE is not set=0A=
# CONFIG_XFS_DEBUG is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
# CONFIG_INTERMEZZO_FS is not set=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_NFS_V3=3Dy=0A=
# CONFIG_NFS_DIRECTIO is not set=0A=
CONFIG_ROOT_NFS=3Dy=0A=
# CONFIG_NFSD is not set=0A=
# CONFIG_NFSD_V3 is not set=0A=
# CONFIG_NFSD_TCP is not set=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
CONFIG_LOCKD_V4=3Dy=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
# CONFIG_NCPFS_PACKET_SIGNING is not set=0A=
# CONFIG_NCPFS_IOCTL_LOCKING is not set=0A=
# CONFIG_NCPFS_STRONG is not set=0A=
# CONFIG_NCPFS_NFS_NS is not set=0A=
# CONFIG_NCPFS_OS2_NS is not set=0A=
# CONFIG_NCPFS_SMALLDOS is not set=0A=
# CONFIG_NCPFS_NLS is not set=0A=
# CONFIG_NCPFS_EXTRAS is not set=0A=
# CONFIG_ZISOFS_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_PARTITION_ADVANCED is not set=0A=
CONFIG_MSDOS_PARTITION=3Dy=0A=
# CONFIG_SMB_NLS is not set=0A=
# CONFIG_NLS is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# MPC8260 CPM Options=0A=
#=0A=
CONFIG_SCC_CONSOLE=3Dy=0A=
# CONFIG_SCC_ENET is not set=0A=
CONFIG_FEC_ENET=3Dy=0A=
# CONFIG_FCC1_ENET is not set=0A=
# CONFIG_FCC2_ENET is not set=0A=
CONFIG_FCC3_ENET=3Dy=0A=
# CONFIG_USE_MDIO is not set=0A=
# CONFIG_FCC_LXT970 is not set=0A=
CONFIG_FCC_LXT971=3Dy=0A=
# CONFIG_FCC_QS6612 is not set=0A=
# CONFIG_FCC_AMD79C873 is not set=0A=
# CONFIG_FCC_DM9131 is not set=0A=
# CONFIG_CPM_SPI is not set=0A=
CONFIG_PORT_CTS1_NONE=3Dy=0A=
# CONFIG_CTS1_15 is not set=0A=
# CONFIG_CTS1_29 is not set=0A=
CONFIG_PORT_RTS1_NONE=3Dy=0A=
# CONFIG_UART_RTS_CONTROL_SCC1 is not set=0A=
CONFIG_PORT_CD1_NONE=3Dy=0A=
# CONFIG_UART_CD_CONTROL_SCC1 is not set=0A=
CONFIG_PORT_DTR1_NONE=3Dy=0A=
# CONFIG_PORT_DTR1_A is not set=0A=
# CONFIG_PORT_DTR1_B is not set=0A=
# CONFIG_PORT_DTR1_C is not set=0A=
# CONFIG_PORT_DTR1_D is not set=0A=
CONFIG_PORT_CTS2_NONE=3Dy=0A=
# CONFIG_CTS2_13 is not set=0A=
# CONFIG_CTS2_28 is not set=0A=
CONFIG_PORT_RTS2_NONE=3Dy=0A=
# CONFIG_UART_RTS_CONTROL_SCC2 is not set=0A=
CONFIG_PORT_CD2_NONE=3Dy=0A=
# CONFIG_UART_CD_CONTROL_SCC2 is not set=0A=
CONFIG_PORT_DTR2_NONE=3Dy=0A=
# CONFIG_PORT_DTR2_A is not set=0A=
# CONFIG_PORT_DTR2_B is not set=0A=
# CONFIG_PORT_DTR2_C is not set=0A=
# CONFIG_PORT_DTR2_D is not set=0A=
CONFIG_PORT_CTS3_NONE=3Dy=0A=
# CONFIG_UART_CTS_CONTROL_SCC3 is not set=0A=
CONFIG_PORT_RTS3_NONE=3Dy=0A=
# CONFIG_UART_RTS_CONTROL_SCC3 is not set=0A=
CONFIG_PORT_CD3_NONE=3Dy=0A=
# CONFIG_UART_CD_CONTROL_SCC3 is not set=0A=
CONFIG_PORT_DTR3_NONE=3Dy=0A=
# CONFIG_PORT_DTR3_A is not set=0A=
# CONFIG_PORT_DTR3_B is not set=0A=
# CONFIG_PORT_DTR3_C is not set=0A=
# CONFIG_PORT_DTR3_D is not set=0A=
CONFIG_PORT_CTS4_NONE=3Dy=0A=
# CONFIG_UART_CTS_CONTROL_SCC4 is not set=0A=
CONFIG_PORT_RTS4_NONE=3Dy=0A=
# CONFIG_UART_RTS_CONTROL_SCC4 is not set=0A=
CONFIG_PORT_CD4_NONE=3Dy=0A=
# CONFIG_UART_CD_CONTROL_SCC4 is not set=0A=
CONFIG_PORT_DTR4_NONE=3Dy=0A=
# CONFIG_PORT_DTR4_A is not set=0A=
# CONFIG_PORT_DTR4_B is not set=0A=
# CONFIG_PORT_DTR4_C is not set=0A=
# CONFIG_PORT_DTR4_D is not set=0A=
=0A=
#=0A=
# USB support=0A=
#=0A=
# CONFIG_USB is not set=0A=
=0A=
#=0A=
# Support for USB gadgets=0A=
#=0A=
# CONFIG_USB_GADGET is not set=0A=
=0A=
#=0A=
# Bluetooth support=0A=
#=0A=
# CONFIG_BLUEZ is not set=0A=
=0A=
#=0A=
# Cryptographic options=0A=
#=0A=
# CONFIG_CRYPTO is not set=0A=
=0A=
#=0A=
# Library routines=0A=
#=0A=
# CONFIG_CRC32 is not set=0A=
CONFIG_ZLIB_INFLATE=3Dy=0A=
CONFIG_ZLIB_DEFLATE=3Dy=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
CONFIG_DEBUG_KERNEL=3Dy=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_DEBUG_HIGHMEM is not set=0A=
# CONFIG_DEBUG_SLAB is not set=0A=
# CONFIG_DEBUG_IOVIRT is not set=0A=
# CONFIG_DEBUG_SPINLOCK is not set=0A=
# CONFIG_DEBUG_WAITQ is not set=0A=
# CONFIG_KGDB is not set=0A=
# CONFIG_KGDB_CONSOLE is not set=0A=
# CONFIG_XMON is not set=0A=
# CONFIG_BDI_SWITCH is not set=0A=
CONFIG_LOG_BUF_SHIFT=3D0=0A=

------_=_NextPart_000_01C42E3B.FCB1DEC0--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
