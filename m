Reply-To: <PaulFagerburg@RenaissanceNT.com>
From: "Paul Fagerburg" <PaulFagerburg@RenaissanceNT.com>
To: "'linuxppc'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RPX CL-LF crashing on MVista Hardhat Linux
Date: Wed, 9 Aug 2000 12:13:19 -0700
Message-ID: <000f01c00235$e16aa9c0$5301a8c0@RenaissanceNT.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0010_01C001FB.350BD1C0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.

------=_NextPart_000_0010_01C001FB.350BD1C0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Thanks to the many people who responded to help me with the earlier
problems - it turned out that the default kernel in hardhat linux expects
the ethernet to be on SCC2, whereas the CLLF board we purchased from
Embedded Planet has the ethernet hooked up to SCC1. Once I rebuilt the
kernel, the CLLF was able to get its IP information over BOOTP, mount an NFS
share, and get to a command line. Very nice!

However, I am now experiencing a new problem: random crashes. The time
interval seems to be completely unpredictable, sometimes before it can get
to INIT, sometimes after several hours, and lots of stuff in between. I am
attaching a minicom log of one such session, along with my .config file.

We are currently using the serial monitor port to work on the console, and
the 10BaseT eth0 for telnet. Eventually, we'll hook up a cable to the
100BaseTX eth1 and use that, but for the time being, the jack is vacant. One
of the crashes (which I didn't log, unfortunately) mentioned something about
floating point, so I emabled math emulation in the kernel, but it was no
help.

Thanks in advance for any help you can provide.

-paul

--
Paul Fagerburg
Renaissance Network Technology
829 De La Vina St., Suite 200
Santa Barbara, CA 93101
805-899-4260 x 115
plf@RenaissanceNT.com

------=_NextPart_000_0010_01C001FB.350BD1C0
Content-Type: application/octet-stream;
	name="minicom.cap"
Content-Disposition: attachment;
	filename="minicom.cap"
Content-Transfer-Encoding: quoted-printable

DRAM1:wwwwwvvvvvCCCCCVVVVV CaV NVRAM:VVVVV CaV =0A=
--------------------------------------------------=0A=
RPX Utility program, Copyright (C) 1998-1999, RPCg LLC, All Rights =
Reserved.=0A=
  Reset(0100): ExHard ExSoft, TESR:0000 Core.Pv/Cp=3D0020.0050/0004=0A=
  BCSR : OK=0A=
  RTC  : OK, battery LOW or absent, tics/sec=3D1, time =3D 7 sec=0A=
  SPIp : OK, I2Cp: OK, STTM: OK, 42.5c, EEcfg: OK, 256b, cs:1F5B=0A=
  ENET : [zero], 0010EC0019F4, INET: 0A000002=0A=
  FLASH: OK, 1*16 Mb(32x8), id=3D01:53, cs:F95D es:F95D OK =
(FFF00000:FFF46200)=0A=
  NVRAM: OK, 128 Kb, NVR battery GOOD=0A=
  DRAM : OK, 16 Mb, 10 columns=0A=
=3D=3D=3D> RPX Main=0A=
     RPX-ClassicLF AY/BW 860T 50Mhz/8Mhz Ic ~Dc RPXU v1.46=0A=
  1  test BCSR                    A  Add-on board tests=0A=
  2  test dip switches            B  rpxBug command line (ctrl-B)=0A=
  3  test LEDs                    C  Configure EEPROM=0A=
  4  test SPI I2C STTM EEPR,CFG   L  Load RAM=0A=
  5  test FLASH firmware chksum   O  On-board I/O tests=0A=
  6  test NVRAM/SRAM              P  Program FLASH=0A=
  7  test DRAM (destructive)      R  hard Reset=0A=
  8                               S  Scan FLASH for executables=0A=
  9  run all tests                T  display Time & Temperature=0A=
RPX Main menu: press 123456789 or ABCLOPRST key : <?> : L=0A=
=3D=3D=3D> RPX Load: (ESC - returns to Main menu)=0A=
  1  Copy one memory range to another range=0A=
  2  Verify one memory range against another range=0A=
  3  Fill memory range with generated data=0A=
  4                               =0A=
  5  load   using S-records received from serial monitor port=0A=
  6  verify using S-records received from serial monitor port=0A=
  7  load   using tftp via Ethernet interface=0A=
  8  set a start address          =0A=
  9  transfer control to start address=0A=
  T  tftp & start using config info with retries=0A=
RPX Load menu: press 123456789T key : <?> : T=0A=
 target IP address : 0A000001=0A=
 target file name  : rntc.srec=0A=
 address bias      : 0=0A=
Starting tftp download: =0A=
inetARP(): OK=0A=
.1.2.4.8.16.32.64.128.256.512.1024.2048.4096.8192=0A=
load_tftp(): OK=0A=
1066196 data bytes, 13497 S-records, 2083 tftp blocks, 0 repeated blocks=0A=
start address =3D 00200000=0A=
load_tftp_toMem(): OK=0A=
Transferring control to downloaded program=0A=
loaded at:     00200000 0020C580=0A=
relocated to:  00100000 0010C580=0A=
board data at: 001001C4 001001E0=0A=
relocated to:  00200100 0020011C=0A=
zimage at:     00207000 00268172=0A=
avail ram:     00269000 01000000=0A=
=0A=
Linux/PPC load: root=3D/dev/nfs rw=0A=
Uncompressing Linux...done.=0A=
Now booting the kernel=0A=
Linux version 2.2.13 (plf@penguin) (gcc version 2.95.2 19991024 =
(release)) #19 Thu Aug 10 12:05:00 PDT 2000=0A=
Boot arguments: root=3D/dev/nfs rw=0A=
time_init: decrementer frequency =3D 180000000/60=0A=
Calibrating delay loop... 47.82 BogoMIPS=0A=
Memory: 15144k available (728k kernel code, 476k data, 36k init) =
[c0000000,c1000000]=0A=
DENTRY hash table entries: 262144 (order: 9, 2097152 bytes)=0A=
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)=0A=
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)=0A=
POSIX conformance testing by UNIFIX=0A=
Linux NET4.0 for Linux 2.2=0A=
Based upon Swansea University Computer Society NET3.039=0A=
NET4: Unix domain sockets 1.0 for Linux NET4.0.=0A=
NET4: Linux TCP/IP 1.0 for NET4.0=0A=
IP Protocols: ICMP, UDP, TCP=0A=
TCP: Hash tables configured (ehash 16384 bhash 16384)=0A=
Starting kswapd v 1.5 =0A=
Serial driver version 4.27 with no serial options enabled=0A=
ttyS00 at 0x03f8 (irq =3D 4) is a 16450=0A=
ttyS01 at 0x02f8 (irq =3D 3) is a 16450=0A=
ttyS02 at 0x03e8 (irq =3D 4) is a 16450=0A=
CPM UART driver version 0.03=0A=
ttyS00 at 0x0280 is a SMC=0A=
ttyS01 at 0x0380 is a SMC=0A=
ttyS02 at 0x0100 is a SCC=0A=
ttyS03 at 0x0200 is a SCC=0A=
pty: 256 Unix98 ptys configured=0A=
loop: registered device at major 7=0A=
eth0: CPM ENET Version 0.2, 00:10:ec:00:19:f4=0A=
eth1: FEC ENET Version 0.1, 00:10:ec:80:19:f4=0A=
fec: Phy @ 0x17, type 0x01814401=0A=
fec: link down=0A=
fec: 100 Mbps, Half-Duplex=0A=
fec: link down, 100 Mbps, Half-Duplex=0A=
Sending BOOTP requests.... OK=0A=
IP-Config: Got BOOTP answer from 10.0.0.1, my address is 10.0.0.2=0A=
Looking up port of RPC 100003/2 on 10.0.0.1=0A=
Looking up port of RPC 100005/1 on 10.0.0.1=0A=
VFS: Mounted root (NFS filesystem).=0A=
Freeing unused kernel memory: 36k init=0A=
INIT: version 2.77 booti=FF=0A=
INIT: Entering runlevel:=FF=0A=
page fault in interrupt handler, addr=3Dc0070b84=0A=
NIP: C0070B84 XER: 8000D77F LR: C00725CC REGS: c013dc90 TRAP: 0400=0A=
MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
TASK =3D c013c000[1] 'init' mm->pgd c01cd000 Last syscall: 106 =0A=
last math 00000000=0A=
GPR00: 00000000 C013DD40 C013C000 C01DD040 0A000002 0A000001 00000000 =
C00DBF94 =0A=
GPR08: C01534A0 C00E0000 00000044 00000000 0005CC60 1001EEB4 FFFFFFFF =
0FEF4EC4 =0A=
GPR16: 30026C20 00000014 FFFFFFFF 10010000 00001032 0013DDB0 00000000 =
C0002544 =0A=
GPR24: C00042B8 C00FABC8 00000472 C00F0000 C00DBF94 C01DD040 C01DD040 =
C01D98DE =0A=
NIP: C0070B84 XER: 8000D77F LR: C00725CC REGS: c013dc90 TRAP: 0400=0A=
MSR: 40009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11=0A=
TASK =3D c013c000[1] 'init' mm->pgd c01cd000 Last syscall: 106 =0A=
last math 00000000=0A=
GPR00: 00000000 C013DD40 C013C000 C01DD040 0A000002 0A000001 00000000 =
C00DBF94 =0A=
GPR08: C01534A0 C00E0000 00000044 00000000 0005CC60 1001EEB4 FFFFFFFF =
0FEF4EC4 =0A=
GPR16: 30026C20 00000014 FFFFFFFF 10010000 00001032 0013DDB0 00000000 =
C0002544 =0A=
GPR24: C00042B8 C00FABC8 00000472 C00F0000 C00DBF94 C01DD040 C01DD040 =
C01D98DE =0A=
Call backtrace: =0A=
C006E230 C0069FB0 C0016BD0 C00025AC C0002544 10004A54 100056C8 =0A=
10005A20 0FF09E78 00000000 =0A=
Kernel panic: kernel access of bad area pc c0070b84 lr c00725cc address =
C0070B84 tsk init/1=0A=
In interrupt handler - not syncing=0A=
Rebooting in 180 seconds..=0A=

------=_NextPart_000_0010_01C001FB.350BD1C0
Content-Type: application/octet-stream;
	name=".config"
Content-Disposition: attachment;
	filename=".config"
Content-Transfer-Encoding: quoted-printable

#=0A=
# Automatically generated make config: don't edit=0A=
#=0A=
=0A=
#=0A=
# Platform support=0A=
#=0A=
CONFIG_PPC=3Dy=0A=
# CONFIG_6xx is not set=0A=
# CONFIG_PPC64 is not set=0A=
CONFIG_8xx=3Dy=0A=
# CONFIG_MPC821 is not set=0A=
# CONFIG_MPC823 is not set=0A=
# CONFIG_MPC850 is not set=0A=
# CONFIG_MPC860 is not set=0A=
CONFIG_MPC860T=3Dy=0A=
CONFIG_SERIAL_CONSOLE=3Dy=0A=
# CONFIG_PMAC is not set=0A=
# CONFIG_PREP is not set=0A=
# CONFIG_CHRP is not set=0A=
# CONFIG_ALL_PPC is not set=0A=
# CONFIG_APUS is not set=0A=
# CONFIG_MBX is not set=0A=
# CONFIG_RPXLITE is not set=0A=
CONFIG_RPXCLASSIC=3Dy=0A=
# CONFIG_EST8xx is not set=0A=
# CONFIG_BSEIP is not set=0A=
# CONFIG_SMP is not set=0A=
CONFIG_MACH_SPECIFIC=3Dy=0A=
=0A=
#=0A=
# General setup=0A=
#=0A=
# CONFIG_EXPERIMENTAL is not set=0A=
CONFIG_MODULES=3Dy=0A=
# CONFIG_MODVERSIONS is not set=0A=
CONFIG_KMOD=3Dy=0A=
# CONFIG_PCI is not set=0A=
CONFIG_MATH_EMULATION=3Dy=0A=
# CONFIG_PCI_QUIRKS is not set=0A=
CONFIG_NET=3Dy=0A=
CONFIG_SYSCTL=3Dy=0A=
CONFIG_SYSVIPC=3Dy=0A=
# CONFIG_BSD_PROCESS_ACCT is not set=0A=
CONFIG_BINFMT_ELF=3Dy=0A=
CONFIG_KERNEL_ELF=3Dy=0A=
# CONFIG_BINFMT_MISC is not set=0A=
# CONFIG_BINFMT_JAVA is not set=0A=
# CONFIG_PARPORT is not set=0A=
# CONFIG_VGA_CONSOLE is not set=0A=
# CONFIG_FB is not set=0A=
=0A=
#=0A=
# Plug and Play support=0A=
#=0A=
# CONFIG_PNP is not set=0A=
=0A=
#=0A=
# Block devices=0A=
#=0A=
# CONFIG_BLK_DEV_FD is not set=0A=
# CONFIG_BLK_DEV_IDE is not set=0A=
=0A=
#=0A=
# Please see Documentation/ide.txt for help/info on IDE drives=0A=
#=0A=
# CONFIG_BLK_DEV_HD_ONLY is not set=0A=
=0A=
#=0A=
# Additional Block Devices=0A=
#=0A=
CONFIG_BLK_DEV_LOOP=3Dy=0A=
CONFIG_BLK_DEV_NBD=3Dy=0A=
# CONFIG_BLK_DEV_MD is not set=0A=
# CONFIG_BLK_DEV_RAM is not set=0A=
# CONFIG_BLK_DEV_XD is not set=0A=
CONFIG_PARIDE_PARPORT=3Dy=0A=
# CONFIG_PARIDE is not set=0A=
# CONFIG_BLK_CPQ_DA is not set=0A=
# CONFIG_BLK_DEV_HD is not set=0A=
=0A=
#=0A=
# Networking options=0A=
#=0A=
CONFIG_PACKET=3Dy=0A=
CONFIG_NETLINK=3Dy=0A=
# CONFIG_RTNETLINK is not set=0A=
CONFIG_NETLINK_DEV=3Dy=0A=
# CONFIG_FIREWALL is not set=0A=
# CONFIG_FILTER is not set=0A=
CONFIG_UNIX=3Dy=0A=
CONFIG_INET=3Dy=0A=
# CONFIG_IP_MULTICAST is not set=0A=
# CONFIG_IP_ADVANCED_ROUTER is not set=0A=
CONFIG_IP_PNP=3Dy=0A=
CONFIG_IP_PNP_BOOTP=3Dy=0A=
# CONFIG_IP_PNP_RARP is not set=0A=
# CONFIG_IP_ROUTER is not set=0A=
# CONFIG_NET_IPIP is not set=0A=
# CONFIG_NET_IPGRE is not set=0A=
# CONFIG_IP_ALIAS is not set=0A=
# CONFIG_SYN_COOKIES is not set=0A=
=0A=
#=0A=
# (it is safe to leave these untouched)=0A=
#=0A=
# CONFIG_INET_RARP is not set=0A=
# CONFIG_SKB_LARGE is not set=0A=
=0A=
#=0A=
#  =0A=
#=0A=
# CONFIG_IPX is not set=0A=
# CONFIG_ATALK is not set=0A=
=0A=
#=0A=
# SCSI support=0A=
#=0A=
# CONFIG_SCSI is not set=0A=
# CONFIG_SCSI_G_NCR5380_PORT is not set=0A=
# CONFIG_SCSI_G_NCR5380_MEM is not set=0A=
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
CONFIG_DUMMY=3Dy=0A=
# CONFIG_EQUALIZER is not set=0A=
# CONFIG_NET_SB1000 is not set=0A=
=0A=
#=0A=
# Ethernet (10 or 100Mbit)=0A=
#=0A=
CONFIG_NET_ETHERNET=3Dy=0A=
# CONFIG_MACE is not set=0A=
# CONFIG_BMAC is not set=0A=
# CONFIG_NET_VENDOR_3COM is not set=0A=
# CONFIG_LANCE is not set=0A=
# CONFIG_NET_VENDOR_SMC is not set=0A=
# CONFIG_NET_VENDOR_RACAL is not set=0A=
# CONFIG_NET_ISA is not set=0A=
# CONFIG_NET_EISA is not set=0A=
# CONFIG_NET_POCKET is not set=0A=
# CONFIG_FDDI is not set=0A=
# CONFIG_PPP is not set=0A=
# CONFIG_SLIP is not set=0A=
# CONFIG_NET_RADIO is not set=0A=
=0A=
#=0A=
# Token ring devices=0A=
#=0A=
# CONFIG_TR is not set=0A=
# CONFIG_NET_FC is not set=0A=
=0A=
#=0A=
# Wan interfaces=0A=
#=0A=
# CONFIG_HOSTESS_SV11 is not set=0A=
# CONFIG_COSA is not set=0A=
# CONFIG_SEALEVEL_4021 is not set=0A=
# CONFIG_DLCI is not set=0A=
# CONFIG_SBNI is not set=0A=
=0A=
#=0A=
# Amateur Radio support=0A=
#=0A=
# CONFIG_HAMRADIO is not set=0A=
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
=0A=
#=0A=
# Character devices=0A=
#=0A=
# CONFIG_VT is not set=0A=
CONFIG_SERIAL=3Dy=0A=
CONFIG_SERIAL_CONSOLE=3Dy=0A=
# CONFIG_SERIAL_EXTENDED is not set=0A=
# CONFIG_SERIAL_NONSTANDARD is not set=0A=
CONFIG_UNIX98_PTYS=3Dy=0A=
CONFIG_UNIX98_PTY_COUNT=3D256=0A=
# CONFIG_MOUSE is not set=0A=
# CONFIG_QIC02_TAPE is not set=0A=
# CONFIG_WATCHDOG is not set=0A=
# CONFIG_NVRAM is not set=0A=
# CONFIG_RTC is not set=0A=
=0A=
#=0A=
# Video For Linux=0A=
#=0A=
# CONFIG_VIDEO_DEV is not set=0A=
=0A=
#=0A=
# Joystick support=0A=
#=0A=
# CONFIG_JOYSTICK is not set=0A=
# CONFIG_DTLK is not set=0A=
=0A=
#=0A=
# Ftape, the floppy tape device driver=0A=
#=0A=
# CONFIG_FTAPE is not set=0A=
# CONFIG_FT_NORMAL_DEBUG is not set=0A=
# CONFIG_FT_FULL_DEBUG is not set=0A=
# CONFIG_FT_NO_TRACE is not set=0A=
# CONFIG_FT_NO_TRACE_AT_ALL is not set=0A=
# CONFIG_FT_STD_FDC is not set=0A=
# CONFIG_FT_MACH2 is not set=0A=
# CONFIG_FT_PROBE_FC10 is not set=0A=
# CONFIG_FT_ALT_FDC is not set=0A=
=0A=
#=0A=
# USB drivers - not for the faint of heart=0A=
#=0A=
=0A=
#=0A=
# Filesystems=0A=
#=0A=
# CONFIG_QUOTA is not set=0A=
# CONFIG_AUTOFS_FS is not set=0A=
# CONFIG_AFFS_FS is not set=0A=
# CONFIG_HFS_FS is not set=0A=
# CONFIG_FAT_FS is not set=0A=
# CONFIG_ISO9660_FS is not set=0A=
# CONFIG_JOLIET is not set=0A=
# CONFIG_MINIX_FS is not set=0A=
# CONFIG_NTFS_FS is not set=0A=
# CONFIG_HPFS_FS is not set=0A=
CONFIG_PROC_FS=3Dy=0A=
CONFIG_DEVPTS_FS=3Dy=0A=
# CONFIG_ROMFS_FS is not set=0A=
CONFIG_EXT2_FS=3Dy=0A=
# CONFIG_SYSV_FS is not set=0A=
# CONFIG_UFS_FS is not set=0A=
=0A=
#=0A=
# Network File Systems=0A=
#=0A=
# CONFIG_CODA_FS is not set=0A=
CONFIG_NFS_FS=3Dy=0A=
CONFIG_ROOT_NFS=3Dy=0A=
CONFIG_SUNRPC=3Dy=0A=
CONFIG_LOCKD=3Dy=0A=
# CONFIG_SMB_FS is not set=0A=
# CONFIG_NCP_FS is not set=0A=
=0A=
#=0A=
# Partition Types=0A=
#=0A=
# CONFIG_BSD_DISKLABEL is not set=0A=
# CONFIG_MAC_PARTITION is not set=0A=
# CONFIG_SMD_DISKLABEL is not set=0A=
# CONFIG_SOLARIS_X86_PARTITION is not set=0A=
# CONFIG_NLS is not set=0A=
=0A=
#=0A=
# Sound=0A=
#=0A=
# CONFIG_SOUND is not set=0A=
=0A=
#=0A=
# MPC8xx Options=0A=
#=0A=
=0A=
#=0A=
# Generic MPC8xx Options=0A=
#=0A=
# CONFIG_8xx_COPYBACK is not set=0A=
# CONFIG_8xx_CPU6 is not set=0A=
=0A=
#=0A=
# MPC8xx CPM Options=0A=
#=0A=
CONFIG_SCC_ENET=3Dy=0A=
CONFIG_SCC1_ENET=3Dy=0A=
CONFIG_FEC_ENET=3Dy=0A=
# CONFIG_CPM_IIC is not set=0A=
# CONFIG_UCODE_PATCH is not set=0A=
=0A=
#=0A=
# Kernel hacking=0A=
#=0A=
# CONFIG_MAGIC_SYSRQ is not set=0A=
# CONFIG_KGDB is not set=0A=
# CONFIG_XMON is not set=0A=

------=_NextPart_000_0010_01C001FB.350BD1C0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
