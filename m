Date: Mon, 4 Nov 2002 13:00:14 +0100
Subject: PrPMC800 as NON-MONARCH
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v482)
From: Anders Blomdell <anders.blomdell@control.lth.se>
To: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20021102121534.F0BB610158@denx.denx.de>
Message-Id: <FA813EBD-EFEC-11D6-8213-0003931C2BFA@control.lth.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Is there anybody that has run the PrPMC800 as NON-MONARCH (and been able to
use the Ethernet). When I try to run a kernel that runs OK as MONARCH, it
fails as a NON-MONARCH. As far as I can understand that is due to

   1. The Harrier is not device 0 on the PCI bus, instead the host PCI
controller
      is picked up (and discarded 'Host bridge 0x48011057 not supported').
   2. The wrong ethernet controller is picked (one that is owned by the pci
      monarch).

Is it at all possible to run this board as a NON-MONARCH and use the
Ethernet-controller if the MONARCH of the PCI-bus is not aware of this (the
card is to be used in a system where the operating system of the MONARCH
can not be changed)?


Regards

Anders Blomdell



Bootlog:

ROMBoot about to Begin... Press <ESC> to Bypass, <SPC> to Continue
loaded at:     F0100014 F02621D0
relocated to:  00800000 009621BC
zimage at:     00805890 008A360E
initrd at:     008A4000 0095E45E
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=128Mb, BAT3=0Mb, residual: 0Mb
Total memory = 128MB; using 256kB for hash table (at c01c0000)
Linux version 2.4.20-pre11 (andersb@aljazari) (gcc version 2.95.3 20010315
(release)) #13 Thu Oct 31 11:01:56 CET 2002
Host bridge 0x48011057 not supported
PrPMC800 port (C) 2001 MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 32768
zone(0): 32768 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600
No OpenPIC found !
Calibrating delay loop... 897.84 BogoMIPS
Memory: 126860k available (1048k kernel code, 384k data, 232k init, 0k
highmem)
Dentry cache hash table entries: 16384 (order: 5, 131072 bytes)
Inode cache hash table entries: 8192 (order: 4, 65536 bytes)
Mount-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 8192 (order: 3, 32768 bytes)
Page-cache hash table entries: 32768 (order: 5, 131072 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 1 of device 00:00.0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI enabled
ttyS00 at 0xfeff00c0 (irq = 16) is a 16550A
eth0: DC21140 at 0xaffd80 (PCI bus 0, device 14), h/w address 00:00:00:00:
00:00,
       and requires IRQ12 (provided by PCI BIOS).
de4x5.c:V0.546 2001/02/22 davies@maniac.ultranet.com
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 1024 buckets, 8Kbytes
TCP: Hash tables configured (established 8192 bind 8192)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 745k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 232k init
Oops: kernel access of bad area, sig: 11
NIP: C000E548 XER: 20000000 LR: C000E628 SP: C036BDA0 REGS: c036bcf0 TRAP:
  0300    Not tainted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 000200A0, DSISR: 40000000
TASK = c036a000[1] 'init' Last syscall: 4
last math c036a000 last altivec 00000000
GPR00: C000E9A0 C036BDA0 C036A000 000200A0 00000000 00000007 C091D048
6C6C2062
GPR08: 696E6172 C0140000 00000049 C01823C0 80808080 100F0418 FFFFFFC7
00000000
GPR16: 00000000 00000000 00000000 00000073 00001032 0036BDD0 00000000
C00064D0
GPR24: C000756C C09D3978 30000000 C09D60A0 00000000 C09D3000 C036BDE0
C036BDE0
Call backtrace:
02000000 C000E9A0 C00075C0 C00064D0 C008A824 C00857D0 C0038480
C000629C 00000000 1003E688 1003E598 1003EA44 1003F380 100326C8
1003DAFC 10017D00 100192E4 1002792C 1002757C 1002D598 00000000
Oops: kernel access of bad area, sig: 11


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
