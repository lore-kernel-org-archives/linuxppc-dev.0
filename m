Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RAMDISK problem
Date: Tue, 11 Nov 2003 15:44:48 -0000
Message-ID: <DEF39A0710293E489D45B10E06645CBD026718F8@dub-msx1.spectelcorp.com>
From: "Joao Vicente" <joao.vicente@spectel.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi

I am struggling with a problem where I dont seem to be able to mount a boot filesystem from a RAMDISK.
I am using the sample RAMDisk root filesystem available from Denx's ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/images/ppc_82xx/

On the config file I have the following lines:
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=4096
CONFIG_BLK_DEV_INITRD=y
CONFIG_CRAMFS=y
CONFIG_RAMFS=y
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y

I've browsed through a lot of threads relating to problems mounting the root filsystem from RAM but I failed to see a similar  symptom to this, with a response.

I would appreciate any suggestion from perhaps somebody that has gone through this problem already.

Thanks in advance

Joao Vicente




U-Boot 0.4.5 (Nov 10 2003 - 18:11:40)

MPC8260 Reset Status: External Soft, External Hard

MPC8260 Clock Configuration
 - Bus-to-Core Mult 4x, VCO Div 2, 60x Bus Freq  25-75 , Core Freq 100-300
 - dfbrg 1, corecnf 0x0a, busdf 7, cpmdf 1, plldf 0, pllmf 3
 - vco_out  266666664, scc_clk   66666666, brg_clk   16666666
 - cpu_clk  133333332, cpm_clk  133333332, bus_clk   33333333

CPU:   MPC8260 (HiP3 Rev 01, Mask C.2 6K23A) at 133.333 MHz
Board: Spectel MC3
DRAM:  (60x:?COL - 16 MB, 16 MB
Top of RAM usable for U-Boot at: 01000000
Reserving 170k for U-Boot at: 00fd5000
Reserving 136k for malloc() at: 00fb3000
Reserving 76 Bytes for Board Info at: 00fb2fb4
Reserving 72 Bytes for Global Data at: 00fb2f6c
Stack Pointer at: 00fb2f48
New Stack Pointer is: 00fb2f48
Now running in RAM - U-Boot at: 00fd5000
FLASH:   4 MB
In:    serial
Out:   serial
Err:   serial
Reset Ethernet PHY
miiphy_read(0x4) @ 0x0 = 0x01e1
U-Boot relocated to 00fd5000
Net:   FCC1 ETHERNET
### main_loop entered: bootdelay=5

### main_loop: bootcmd="tftp 0x100000 $(bootfile);bootm"
Hit any key to stop autoboot:  0
=> run ramboot
Trying FCC1 ETHERNET
TFTP from server 10.121.10.150; our IP address is 10.121.10.23
Filename './spc_mc3/uImage'.
Load address: 0x100000
Loading: ######################T ##########T T
##################################
         ###T #################################################
done
Bytes transferred = 595080 (91488 hex)

## Checking Image at 03000000 ...
   Image Name:   Simple Ramdisk-Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    567988 Bytes = 554.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## Booting image at 00100000 ...
   Image Name:   Linux-2.4.20
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    595016 Bytes = 581.1 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Current stack ends at 0x00FB2928 => set upper limit to 0x00800000
## cmdline at 0x007FFF00 ... 0x007FFF60
bd address  = 0x00FB2FB4
memstart    = 0x00000000
memsize     = 0x01000000
flashstart  = 0x03000000
flashsize   = 0x00400000
flashoffset = 0x00000000
sramstart   = 0x00000000
sramsize    = 0x00000000
immr_base   = 0xF0000000
bootflags   = 0x00000001
vco         = 266.666 MHz
sccfreq     = 66.666 MHz
brgfreq     = 16.666 MHz
intfreq     = 133.333 MHz
cpmfreq     = 133.333 MHz
busfreq     = 33.333 MHz
ethaddr     = 00:D0:9B:00:00:F9
IP addr     = 10.121.10.23
baudrate    = 115200 bps
## Loading RAMDisk Image at 03000000 ...
   Image Name:   Simple Ramdisk-Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip compressed)
   Data Size:    567988 Bytes = 554.7 kB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
## initrd at 0x03000040 ... 0x0308AAF3 (len=567988=0x8AAB4)
   Loading Ramdisk to 00f27000, end 00fb1ab4 ... OK
## Transferring control to Linux (at address 00000000) ...
REVISIT - MMU_setup entered
Memory BAT mapping: BAT2=16Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.20 (jvicente@lab00056l.localdomain) (gcc version 2.95.4
20010319 (prerelease/franzo/20011204)) #1 Tue Nov 11 11:29:23 GMT 2003
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/ram rw
ip=10.121.10.23:10.121.10.150:10.121.10.254:255.255.255.0:mc3_joao::off
mem=16M
IP-Config: Parameter #0: `10.121.10.23'
IP-Config: Parameter #1: `10.121.10.150'
IP-Config: Parameter #2: `10.121.10.254'
IP-Config: Parameter #3: `255.255.255.0'
IP-Config: Parameter #4: `mc3_joao'
IP-Config: Parameter #6: `off'
Warning: real time clock seems stuck!
Calibrating delay loop... 88.67 BogoMIPS
Memory: 14096k available (1084k kernel code, 400k data, 52k init, 0k highmem)
Dentry cache hash table entries: 2048 (order: 2, 16384 bytes)
Inode cache hash table entries: 1024 (order: 1, 8192 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
POSIX conformance testing by UNIFIX
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications AB.
CPM UART driver version 0.01
ttyS0 on SCC1 at 0x8000, BRG7
ttyS1 on SCC2 at 0x8100, BRG1
ttyS2 on SCC3 at 0x8200, BRG2
ttyS3 on SCC5 at 0x8300, BRG4
pty: 256 Unix98 ptys configured
eth0: FCC1 ENET Version 0.4, 00:D0:9B:00:00:F9
eth0: Phy @ 0x0, type LXT971 (0x001378e2)
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
CFI: Found no TQM8260 Bank 0 device at location zero
TQM8260: No supported flash chips found!
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
IP-Config: Entered.
eth0: config: auto-negotiation on, 100FDX, 100HDX, 10FDX, 10HDX.
IP-Config: eth0 UP (able=0, xid=00000000)
IP-Config: Complete:
      device=eth0, addr=10.121.10.23, mask=255.255.255.0, gw=10.121.10.254,
     host=mc3_joao, domain=, nis-domain=(none),
     bootserver=10.121.10.150, rootserver=10.121.10.150, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Machine check in kernel mode.
Caused by (from SRR1=41000): Transfer error ack signal
Oops: machine check, sig: 7
NIP: 0000113C XER: 00000000 LR: C0006628 SP: C0FBD4F0 REGS: c0fbd440 TRAP:
0200
   Not tainted
MSR: 00041000 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00
TASK = c0fbc000[59392] '' Last syscall: 3
last math 00000000 last altivec 00000000
GPR00: 00000000 C0FBD4F0 C0FBC000 C0FBD540 00000000 00000120 00000005 00000005
GPR08: C0FBD4F8 4E81001B 00000000 00000000 22004042 950A0000 0000003F C0110000
GPR16: C0150000 C0EE4008 C0EE7008 C0150000 00009032 00FBD530 00000000 C0006074
GPR24: C0006610 4E80FFFF 00000000 00000001 C0FBD540 00000004 00000009 4E81001B
Call backtrace:
0000007B C0006628 C0006074 000000BB C0006074 C00304D0 C001EA88
C001EAB4 C000A9D4 C0005EA4 00000000 00000083 Machine check in kernel mode.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
