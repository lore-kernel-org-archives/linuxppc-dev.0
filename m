Date: Mon, 1 Dec 2003 23:24:59 +0100
Subject: Re: 2.6 PReP issues, still freezing
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v553)
Cc: Christian Kujau <evil@g-house.de>,
	linuxppc-dev@lists.linuxppc.org
To: Tom Rini <trini@kernel.crashing.org>
From: Remco Post <r.post@sara.nl>
In-Reply-To: <20031201191617.GF1166@stop.crashing.org>
Message-Id: <3318B418-244D-11D8-A10A-000393911DE2@sara.nl>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday, Dec 1, 2003, at 20:16 Europe/Amsterdam, Tom Rini wrote:

> On Mon, Dec 01, 2003 at 12:11:19PM +0100, Remco Post wrote:
>>
>> On Sun, 30 Nov 2003 14:21:10 +0100
>> Christian Kujau <evil@g-house.de> wrote:
>>
>>>
>>> hi,
>>>
>>> after more days of compiling (at least now i know my ppc has good RAM
>>> :-) ) and testing serveral kernels, i think now it's not a
>>> network-related but a ppc-specific problem.
>>>
>>> Andrew Morton gave me the hint to just copy drivers/net/tulip/ from
>>> the
>>> working 2.5.30 kernel to a recent one. i've done so; i've copied all
>>> tulip stuff to a fresh 2.6.0-test11 kernel, after booting i was able
>>> to
>>> load the module, but a following "ifconfig eth1 192.168.2.1" freezed
>>> the
>>> machine -- as every kernel after 2.5.30 i was able to compile.
>>>
>>> a fix from Jeff Garzik went to linuxppc-dev (i saw it on lkml too),
>>> subject was "2.6 PReP fix? (Was: [jgarzik@pobox.com: [PATCH/CFT]
>>> de2104x
>>> fixes])". i found out, that i can load 3 different modules for my
>>> card:
>>>
>>> 00:0e.0 Ethernet controller: Digital Equipment Corporation DECchip
>>> 21140
>>> [FasterNet] (rev 22)
>>>          Flags: bus master, medium devsel, latency 0, IRQ 11
>>>          I/O ports at 1800 [size=128]
>>>          Memory at c300a000 (32-bit, non-prefetchable) [size=128]
>>>          Expansion ROM at c1040000 [disabled] [size=256K]
>>>
>>>
>>> /lib/modules/2.6.0-test11/kernel/drivers/net/tulip:
>>> de2104x.ko  de4x5.ko  tulip.ko
>>>
>>> /lib/modules/2.5.30/kernel/drivers/net/tulip:
>>> de2104x.o  de4x5.o  tulip.o
>>>
>>> and every module gave me a freeze with 2.6.0-test11 (oh, i forgot to
>>> test, if de2104x.o and de4x5.o are working correctly with 2.5.30
>>> since
>>> i've used always "tulip")
>>>
>>> and so, this makes me think it's a ppc-specific problem. no, i don't
>>> say
>>> it's easier now to fix, perhaps it's even harder, because a lot has
>>> changed in the ppc port too. if we could blame the device-driver, the
>>> codesize to play with would be a lot smaller...
>>>
>>> but since really no other PReP people complain, i think i'll stay
>>> with
>>> 2.4. a while. the machine is not that fast and i need a faster one
>>> anyway...
>>>
>>
>> I stopped complaining a while back (2.5.60 something) since I got
>> absolutely
>> no response. I'm one of the lucky (?) few who have a motorola
>> powerstack
>> (II) mobo.
>
> I suppose part of the problem is that my PowerStack (Series E) doesn't
> have any problems. :)
>
> What I've just done is put up all of the patches I have pending to try
> and get into 2.6.0, once Linus either becomes more open to !ia32
> patches
> or Andrew Morton takes over.  They're over at:
> http://stop.crashing.org:16080/~trini/
>
> The combination of 011 and 012 should allow for kgdb to work on any
> PReP
> box, and this should help people debug problems, if they have the time.
>
>

Ok, this is what happes. This is a stock 2.6.0-test11 kernel, .config
at the end,

the kernel boots ok, and properly configures it's ip via dhcp. I can
log in, the ethernet driver complains about link going up, and again up
and maybe even a few times more. Then when I do a ping to the default
gw (which does answer to ping) no reply's. Disconnecting the ethernet
cable yields the following:

flops:~# ping 172.16.5.1
PING 172.16.5.1 (172.16.5.1): 56 data bytes

--- 172.16.5.1 ping statistics ---
2 packets transmitted, 0 packets received, 100% packet loss
flops:~# eth0: link down
eth0: timeout expired stopping DMA
kernel BUG in de_set_media at drivers/net/tulip/de2104x.c:926!
Oops: Exception in kernel mode, sig: 5 [#1]
NIP: C01517B4 LR: C0151AF4 SP: C02DBDF0 REGS: c02dbd40 TRAP: 0700    Not
tainted
MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = c02711e0[0] 'swapper' Last syscall: 120
GPR00: FC120000 C02DBDF0 C02711E0 C0447A00 3F4A2FED 3B9ACA00 C0300040
C031AA0C
GPR08: C031AA08 00120000 00000008 C5000E80 FCC6954E 00000000 00000000
00000000
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
GPR24: 00000000 00000000 00000002 00001032 C0447800 00009032 FFFFFFCE
C0447A00
Call trace:
  [c0151af4] de21040_media_timer+0x12c/0x1c8
  [c0021970] run_timer_softirq+0x168/0x1ac
  [c001cb5c] do_softirq+0x88/0xfc
  [c00080b4] timer_interrupt+0x284/0x298
  [c00060ec] ret_from_except+0x0/0x14
  [c0007e2c] cpu_idle+0x34/0x38
  [c00038d8] rest_init+0x24/0x34
  [c02dc520] start_kernel+0x130/0x144
  [00003564] 0x3564
Kernel panic: Aiee, killing interrupt handler!
In interrupt handler - not syncing


remco@pipmac:/usr/src/linux-2.6.0-test11$ cat .config
#
# Automatically generated make config: don't edit
#
CONFIG_MMU=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_HAVE_DEC_LOCK=y
CONFIG_PPC=y
CONFIG_PPC32=y

#
# Code maturity level options
#
CONFIG_EXPERIMENTAL=y
CONFIG_CLEAN_COMPILE=y
CONFIG_STANDALONE=y
CONFIG_BROKEN_ON_SMP=y

#
# General setup
#
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
# CONFIG_BSD_PROCESS_ACCT is not set
CONFIG_SYSCTL=y
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_IKCONFIG is not set
# CONFIG_EMBEDDED is not set
CONFIG_KALLSYMS=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_AS=y
CONFIG_IOSCHED_DEADLINE=y

#
# Loadable module support
#
# CONFIG_MODULES is not set

#
# Processor
#
CONFIG_6xx=y
# CONFIG_40x is not set
# CONFIG_44x is not set
# CONFIG_POWER3 is not set
# CONFIG_POWER4 is not set
# CONFIG_8xx is not set
# CONFIG_ALTIVEC is not set
# CONFIG_TAU is not set
# CONFIG_CPU_FREQ is not set
# CONFIG_PPC601_SYNC_FIX is not set
CONFIG_PPC_STD_MMU=y

#
# Platform options
#
CONFIG_PPC_MULTIPLATFORM=y
# CONFIG_APUS is not set
# CONFIG_WILLOW is not set
# CONFIG_PCORE is not set
# CONFIG_POWERPMC250 is not set
# CONFIG_EV64260 is not set
# CONFIG_SPRUCE is not set
# CONFIG_LOPEC is not set
# CONFIG_MCPN765 is not set
# CONFIG_MVME5100 is not set
# CONFIG_PPLUS is not set
# CONFIG_PRPMC750 is not set
# CONFIG_PRPMC800 is not set
# CONFIG_SANDPOINT is not set
# CONFIG_ADIR is not set
# CONFIG_K2 is not set
# CONFIG_PAL4 is not set
# CONFIG_GEMINI is not set
# CONFIG_EST8260 is not set
# CONFIG_SBS8260 is not set
# CONFIG_RPX6 is not set
# CONFIG_TQM8260 is not set
CONFIG_PPC_CHRP=y
CONFIG_PPC_PMAC=y
CONFIG_PPC_PREP=y
CONFIG_PPC_OF=y
CONFIG_PPCBUG_NVRAM=y
# CONFIG_SMP is not set
# CONFIG_PREEMPT is not set
# CONFIG_HIGHMEM is not set
CONFIG_KERNEL_ELF=y
CONFIG_BINFMT_ELF=y
# CONFIG_BINFMT_MISC is not set
CONFIG_PROC_DEVICETREE=y
CONFIG_PPC_RTAS=y
CONFIG_PREP_RESIDUAL=y
# CONFIG_PROC_PREPRESIDUAL is not set
CONFIG_CMDLINE_BOOL=y
CONFIG_CMDLINE="console=ttyS0,9600 root=/dev/sda2"

#
# Bus options
#
# CONFIG_ISA is not set
CONFIG_GENERIC_ISA_DMA=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCI_LEGACY_PROC is not set
CONFIG_PCI_NAMES=y
CONFIG_HOTPLUG=y

#
# PCMCIA/CardBus support
#
# CONFIG_PCMCIA is not set

#
# Parallel port support
#
CONFIG_PARPORT=y
CONFIG_PARPORT_PC=y
CONFIG_PARPORT_PC_CML1=y
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_OTHER is not set
CONFIG_PARPORT_1284=y

#
# Advanced setup
#
CONFIG_ADVANCED_OPTIONS=y
CONFIG_HIGHMEM_START=0xfe000000
# CONFIG_LOWMEM_SIZE_BOOL is not set
CONFIG_LOWMEM_SIZE=0x30000000
# CONFIG_KERNEL_START_BOOL is not set
CONFIG_KERNEL_START=0xc0000000
# CONFIG_TASK_SIZE_BOOL is not set
CONFIG_TASK_SIZE=0x80000000
CONFIG_BOOT_LOAD=0x00800000

#
# Generic Driver Options
#
# CONFIG_FW_LOADER is not set

#
# Memory Technology Devices (MTD)
#
# CONFIG_MTD is not set

#
# Plug and Play support
#
# CONFIG_PNP is not set

#
# Block devices
#
# CONFIG_BLK_DEV_FD is not set
# CONFIG_PARIDE is not set
# CONFIG_BLK_CPQ_DA is not set
# CONFIG_BLK_CPQ_CISS_DA is not set
# CONFIG_BLK_DEV_DAC960 is not set
# CONFIG_BLK_DEV_UMEM is not set
CONFIG_BLK_DEV_LOOP=y
# CONFIG_BLK_DEV_CRYPTOLOOP is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_RAM is not set
# CONFIG_BLK_DEV_INITRD is not set
# CONFIG_LBD is not set

#
# Multi-device support (RAID and LVM)
#
# CONFIG_MD is not set

#
# ATA/ATAPI/MFM/RLL support
#
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y

#
# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
#
# CONFIG_SCSI_MULTI_LUN is not set
# CONFIG_SCSI_REPORT_LUNS is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set

#
# SCSI low-level drivers
#
# CONFIG_BLK_DEV_3W_XXXX_RAID is not set
# CONFIG_SCSI_ACARD is not set
# CONFIG_SCSI_AACRAID is not set
# CONFIG_SCSI_AIC7XXX is not set
# CONFIG_SCSI_AIC7XXX_OLD is not set
# CONFIG_SCSI_AIC79XX is not set
# CONFIG_SCSI_ADVANSYS is not set
# CONFIG_SCSI_MEGARAID is not set
# CONFIG_SCSI_SATA is not set
# CONFIG_SCSI_BUSLOGIC is not set
# CONFIG_SCSI_CPQFCTS is not set
# CONFIG_SCSI_DMX3191D is not set
# CONFIG_SCSI_EATA is not set
# CONFIG_SCSI_EATA_PIO is not set
# CONFIG_SCSI_FUTURE_DOMAIN is not set
# CONFIG_SCSI_GDTH is not set
# CONFIG_SCSI_IPS is not set
# CONFIG_SCSI_INIA100 is not set
# CONFIG_SCSI_PPA is not set
# CONFIG_SCSI_IMM is not set
CONFIG_SCSI_SYM53C8XX_2=y
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=0
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
# CONFIG_SCSI_SYM53C8XX_IOMAPPED is not set
# CONFIG_SCSI_QLOGIC_ISP is not set
# CONFIG_SCSI_QLOGIC_FC is not set
# CONFIG_SCSI_QLOGIC_1280 is not set
# CONFIG_SCSI_DC395x is not set
# CONFIG_SCSI_NSP32 is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_MESH is not set
# CONFIG_SCSI_MAC53C94 is not set

#
# Fusion MPT device support
#
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support (EXPERIMENTAL)
#
# CONFIG_IEEE1394 is not set

#
# I2O device support
#
# CONFIG_I2O is not set

#
# Networking support
#
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_MMAP is not set
# CONFIG_NETLINK_DEV is not set
CONFIG_UNIX=y
# CONFIG_NET_KEY is not set
CONFIG_INET=y
CONFIG_IP_MULTICAST=y
# CONFIG_IP_ADVANCED_ROUTER is not set
# CONFIG_IP_PNP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE is not set
# CONFIG_IP_MROUTE is not set
# CONFIG_ARPD is not set
# CONFIG_INET_ECN is not set
CONFIG_SYN_COOKIES=y
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set

#
# IP: Virtual Server Configuration
#
# CONFIG_IP_VS is not set
CONFIG_IPV6=y
# CONFIG_IPV6_PRIVACY is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_DECNET is not set
# CONFIG_BRIDGE is not set
CONFIG_NETFILTER=y
# CONFIG_NETFILTER_DEBUG is not set

#
# IP: Netfilter Configuration
#
CONFIG_IP_NF_CONNTRACK=y
# CONFIG_IP_NF_FTP is not set
# CONFIG_IP_NF_IRC is not set
# CONFIG_IP_NF_TFTP is not set
# CONFIG_IP_NF_AMANDA is not set
# CONFIG_IP_NF_QUEUE is not set
CONFIG_IP_NF_IPTABLES=y
# CONFIG_IP_NF_MATCH_LIMIT is not set
# CONFIG_IP_NF_MATCH_IPRANGE is not set
# CONFIG_IP_NF_MATCH_MAC is not set
# CONFIG_IP_NF_MATCH_PKTTYPE is not set
# CONFIG_IP_NF_MATCH_MARK is not set
# CONFIG_IP_NF_MATCH_MULTIPORT is not set
# CONFIG_IP_NF_MATCH_TOS is not set
# CONFIG_IP_NF_MATCH_RECENT is not set
# CONFIG_IP_NF_MATCH_ECN is not set
# CONFIG_IP_NF_MATCH_DSCP is not set
# CONFIG_IP_NF_MATCH_AH_ESP is not set
# CONFIG_IP_NF_MATCH_LENGTH is not set
# CONFIG_IP_NF_MATCH_TTL is not set
# CONFIG_IP_NF_MATCH_TCPMSS is not set
# CONFIG_IP_NF_MATCH_HELPER is not set
# CONFIG_IP_NF_MATCH_STATE is not set
# CONFIG_IP_NF_MATCH_CONNTRACK is not set
# CONFIG_IP_NF_MATCH_OWNER is not set
# CONFIG_IP_NF_FILTER is not set
# CONFIG_IP_NF_NAT is not set
# CONFIG_IP_NF_MANGLE is not set
# CONFIG_IP_NF_TARGET_LOG is not set
# CONFIG_IP_NF_TARGET_ULOG is not set
# CONFIG_IP_NF_TARGET_TCPMSS is not set
# CONFIG_IP_NF_ARPTABLES is not set

#
# IPv6: Netfilter Configuration
#
# CONFIG_IP6_NF_QUEUE is not set
CONFIG_IP6_NF_IPTABLES=y
# CONFIG_IP6_NF_MATCH_LIMIT is not set
# CONFIG_IP6_NF_MATCH_MAC is not set
# CONFIG_IP6_NF_MATCH_RT is not set
# CONFIG_IP6_NF_MATCH_OPTS is not set
# CONFIG_IP6_NF_MATCH_FRAG is not set
# CONFIG_IP6_NF_MATCH_HL is not set
# CONFIG_IP6_NF_MATCH_MULTIPORT is not set
# CONFIG_IP6_NF_MATCH_OWNER is not set
# CONFIG_IP6_NF_MATCH_MARK is not set
# CONFIG_IP6_NF_MATCH_IPV6HEADER is not set
# CONFIG_IP6_NF_MATCH_AHESP is not set
# CONFIG_IP6_NF_MATCH_LENGTH is not set
# CONFIG_IP6_NF_MATCH_EUI64 is not set
# CONFIG_IP6_NF_FILTER is not set
# CONFIG_IP6_NF_MANGLE is not set

#
# SCTP Configuration (EXPERIMENTAL)
#
CONFIG_IPV6_SCTP__=y
# CONFIG_IP_SCTP is not set
# CONFIG_ATM is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
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
# Network testing
#
# CONFIG_NET_PKTGEN is not set
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
# CONFIG_MII is not set
# CONFIG_MACE is not set
# CONFIG_BMAC is not set
# CONFIG_OAKNET is not set
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
CONFIG_NET_VENDOR_3COM=y
CONFIG_VORTEX=y
# CONFIG_TYPHOON is not set

#
# Tulip family network device support
#
CONFIG_NET_TULIP=y
CONFIG_DE2104X=y
# CONFIG_TULIP is not set
# CONFIG_DE4X5 is not set
# CONFIG_WINBOND_840 is not set
# CONFIG_DM9102 is not set
# CONFIG_HP100 is not set
# CONFIG_NET_PCI is not set

#
# Ethernet (1000 Mbit)
#
# CONFIG_ACENIC is not set
# CONFIG_DL2K is not set
# CONFIG_E1000 is not set
# CONFIG_NS83820 is not set
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
# CONFIG_R8169 is not set
# CONFIG_SIS190 is not set
# CONFIG_SK98LIN is not set
# CONFIG_TIGON3 is not set

#
# Ethernet (10000 Mbit)
#
# CONFIG_IXGB is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
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
# Bluetooth support
#
# CONFIG_BT is not set

#
# ISDN subsystem
#
# CONFIG_ISDN_BOOL is not set

#
# Graphics support
#
# CONFIG_FB is not set

#
# Console display driver support
#
# CONFIG_VGA_CONSOLE is not set
# CONFIG_MDA_CONSOLE is not set
CONFIG_DUMMY_CONSOLE=y

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
# Input I/O drivers
#
# CONFIG_GAMEPORT is not set
CONFIG_SOUND_GAMEPORT=y
CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set

#
# Input Device Drivers
#
# CONFIG_INPUT_KEYBOARD is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TOUCHSCREEN is not set
# CONFIG_INPUT_MISC is not set

#
# Macintosh device drivers
#
# CONFIG_ADB_CUDA is not set
# CONFIG_ADB_PMU is not set
# CONFIG_MAC_FLOPPY is not set
# CONFIG_MAC_SERIAL is not set
# CONFIG_ADB is not set

#
# Character devices
#
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
# CONFIG_SERIAL_NONSTANDARD is not set

#
# Serial drivers
#
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
# CONFIG_SERIAL_8250_MANY_PORTS is not set
CONFIG_SERIAL_8250_SHARE_IRQ=y
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
# CONFIG_SERIAL_8250_MULTIPORT is not set
# CONFIG_SERIAL_8250_RSA is not set

#
# Non-8250 serial port support
#
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_PMACZILOG is not set
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
# CONFIG_PRINTER is not set
# CONFIG_PPDEV is not set
# CONFIG_TIPAR is not set

#
# I2C support
#
# CONFIG_I2C is not set

#
# I2C Algorithms
#

#
# I2C Hardware Bus support
#

#
# I2C Hardware Sensors Chip support
#
# CONFIG_I2C_SENSOR is not set

#
# Mice
#
# CONFIG_BUSMOUSE is not set
# CONFIG_QIC02_TAPE is not set

#
# IPMI
#
# CONFIG_IPMI_HANDLER is not set

#
# Watchdog Cards
#
# CONFIG_WATCHDOG is not set
CONFIG_NVRAM=y
# CONFIG_GEN_RTC is not set
# CONFIG_DTLK is not set
# CONFIG_R3964 is not set
# CONFIG_APPLICOM is not set

#
# Ftape, the floppy tape device driver
#
# CONFIG_FTAPE is not set
# CONFIG_AGP is not set
# CONFIG_DRM is not set
# CONFIG_RAW_DRIVER is not set

#
# Multimedia devices
#
# CONFIG_VIDEO_DEV is not set

#
# Digital Video Broadcasting Devices
#
# CONFIG_DVB is not set

#
# File systems
#
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_JBD is not set
CONFIG_REISERFS_FS=y
# CONFIG_REISERFS_CHECK is not set
# CONFIG_REISERFS_PROC_INFO is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_ROMFS_FS is not set
# CONFIG_QUOTA is not set
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
# CONFIG_FAT_FS is not set
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_KCORE=y
# CONFIG_DEVFS_FS is not set
CONFIG_DEVPTS_FS=y
# CONFIG_DEVPTS_FS_XATTR is not set
CONFIG_TMPFS=y
# CONFIG_HUGETLB_PAGE is not set
CONFIG_RAMFS=y

#
# Miscellaneous filesystems
#
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
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
CONFIG_NFS_V3=y
CONFIG_NFS_V4=y
# CONFIG_NFS_DIRECTIO is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
CONFIG_NFSD_V4=y
CONFIG_NFSD_TCP=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_EXPORTFS=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=y
# CONFIG_SMB_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_INTERMEZZO_FS is not set
# CONFIG_AFS_FS is not set

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
# CONFIG_NEC98_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_EFI_PARTITION is not set

#
# Sound
#
# CONFIG_SOUND is not set

#
# USB support
#
# CONFIG_USB is not set
# CONFIG_USB_GADGET is not set

#
# Library routines
#
CONFIG_CRC32=y

#
# Kernel hacking
#
CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_SLAB is not set
# CONFIG_MAGIC_SYSRQ is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_KGDB is not set
# CONFIG_XMON is not set
# CONFIG_BDI_SWITCH is not set
# CONFIG_DEBUG_INFO is not set
CONFIG_BOOTX_TEXT=y

#
# Security options
#
# CONFIG_SECURITY is not set

#
# Cryptographic options
#
# CONFIG_CRYPTO is not set
remco@pipmac:/usr/src/linux-2.6.0-test11$

--
Met vriendelijke groeten,

Remco Post

SARA - Reken- en Netwerkdiensten                      http://www.sara.nl
High Performance Computing  Tel. +31 20 592 8008    Fax. +31 20 668 3167

"I really didn't foresee the Internet. But then, neither did the
computer
industry. Not that that tells us very much of course - the computer
industry
didn't even foresee that the century was going to end." -- Douglas Adams


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
