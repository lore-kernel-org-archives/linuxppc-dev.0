Message-Id: <5.1.0.14.0.20020307090127.01b7c750@sgss.com>
Date: Thu, 07 Mar 2002 09:44:07 -0500
To: linuxppc-embedded@lists.linuxppc.org
From: Dean McBride <dmcbride@sgss.com>
Subject: Memory Check Crash when loading modules
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello everyone,

I'm having a problem loading modules on a 2.4.10-pre10 system.
I'm new at linux & I need to develop a module, so I attempted coding
up the hello.o module from the Linux Device Driver O'Reilly book.  I
load the module using insmod & get the following crash dump (Not
OOPS though?!?).  I've also tried loading modules delivered with the
kernel and get the same affect.

It's crashing in the sys_create_module() call when it calls memset:

         memset(mod, 0, sizeof(*mod));

the address of mod is 0xe1000000, obtained from the module_map()
call which is using vmalloc().  I did notice in the pgtable.h file a comment
where the VMALLOC_OFFSET is defined:

  * We no longer map larger than phys RAM with the BATs so we don't have
  * to worry about the VMALLOC_OFFSET causing problems.  We do have to worry
  * about clashes between our early calls to ioremap() that start growing down
  * from ioremap_base being run into the VM area allocations (growing upwards
  * from VMALLOC_START).  For this reason we have ioremap_bot to check when
  * we actually run into our mappings setup in the early boot with the VM
  * system.  This really does become a problem for machines with good amounts
  * of RAM.  -- Cort

Any help, suggestions, debug tips would be greatly appreciated.  I've included
the crash & other info below.

Thanks
Dean

Here's the output when I have the noload set on insmod:
---------------------------------------------------------------------------------
sh-2.03# insmod -vmn ./hello.o
Using ./hello.o
Symbol version prefix 'smp_'
Sections:       Size      Address   Align
.this           00000060  12340000  2**2
.text           00000080  12340060  2**2
.rodata         00000028  123400e0  2**2
.data           00000000  12340108  2**0
.kstrtab        00000079  12340108  2**0
.bss            00000000  12340181  2**0
.plt            00000010  12340190  2**4
__ksymtab       00000018  123401a0  2**2
__archdata      00000000  123401c0  2**4

Symbols:
00000000 a hello.c
12340000 d __this_module
12340000 D __insmod_hello_O/opt/ds/src/hello/hello.o_M3C86C918_V132106
12340060 T __insmod_hello_S.text_L128
12340060 t .text
12340060 t init_module
123400a4 t cleanup_module
123400e0 r .rodata
123400e0 t Letext
123400e0 R __insmod_hello_S.rodata_L40
12340108 d .data
12340181 d .bss

Here's the Crash info:
--------------------------------
sh-2.03# insmod -vm ./hello.o
Using ./hello.o
Symbol version prefix 'smp_'
Machine check in kernel mode.
Machine check in kernel mode.
Caused by (from SRR1=89032): Caused by (from SRR1=89032): Machine check signal
Machine check signal
Kernel stack overflow in process c017c490, r1=c017c780
Kernel stack overflow in process dee6a000, r1=dee6a270

Hardware Info:
---------------------
Motorola PowerPC 7400 @ 400MHz with 512MB SDRAM. (4 processors)


Here's my boot output:
---------------------------------
DNA Enterprises, Inc.
VQG4 Board
ROM Startup
System Processor A
Sep 27 2001  09:56:31
Motorola PowerPC 7400 @ 400MHz with 512MB SDRAM.
dp0










                             DNA Boot


CPU: DNA VQG4 7400
Boot Version: 1.2 BOOT Rev 3.0
Creation date: Sep 27 2001, 09:56:46


Press any key to stop auto-boot...
  0
auto-booting...


boot device          : dp
unit number          : 0
processor number     : 0
host name            :
file name            : /tmp/zImage.initrd
inet on ethernet (e) : 192.168.77.21
host inet (h)        : 192.168.77.20
gateway inet (g)     : 192.168.77.1
user (u)             :
ftp password (pw)    :
flags (f)            : 0x0
target name (tn)     : vq750
other (o)            : linux

Attached TCP/IP interface to dp0.
Attaching network interface lo0... done.
Loading... binary Module found...size=4869138
Starting at 0x200000...

loaded at:     00200000 00211BE0
relocated to:  00800000 00811BE0
board data at: 0080B0C4 00811AD0
relocated to:  0080B0C4 00811AD0
zimage at:     00208000 002B56E5
relocated to:  00812000 008BF6E5
initrd at:     002B56E5 006A3442
relocated to:  008C0000 00CADD5D
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,9600n8 root=/dev/ram rw
ip=192.168.1.250:192.168.1
.249:192.168.1.2:255.255.255.0:ds ramdisk_size=15360
Uncompressing Linux...done.
Now booting the kernel
Total memory = 512MB; using 2048kB for hash table (at c0200000)
Linux version 2.4.10-pre10 (dean@redhat.sgss.com) (gcc version 2.95.3
20010315 (
release/MontaVista)) #23 SMP Wed Mar 6 22:46:18 EST 2002
Dna Vx750 linux port: Ver# 3.1
L2 Cache Enabled: cpu=0,bus=100MHz,core=400MHz,L2CR=89000000
FPGA setup complete
On node 0 totalpages: 131072
zone(0): 131072 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,9600n8 root=/dev/ram rw
ip=192.168.1.250:192.
168.1.249:192.168.1.2:255.255.255.0:ds ramdisk_size=15360
Decrementer Freq = 25.0MHz
Warning: real time clock seems stuck!
Calibrating delay loop... 799.53 BogoMIPS
Memory: 506704k available (1248k kernel code, 596k data, 172k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
POSIX conformance testing by UNIFIX
Entering SMP Mode...
number of CPUS found= 4
L2 Cache Enabled: cpu=1,bus=100MHz,core=400MHz,L2CR=89000000
syncing 1
syncing 0
smp_vq750_setup_cpu cpu 1
Processor 1 found.
L2 Cache Enabled: cpu=2,bus=100MHz,core=400MHz,L2CR=89000000
syncing 0
syncing 2
Processor 2 found.
smp_vq750_setup_cpu cpu 2
L2 Cache Enabled: cpu=3,bus=100MHz,core=400MHz,L2CR=89000000
syncing 0
syncing 3
Processor 3 found.
smp_vq750_setup_cpu cpu 3
smp_vq750_setup_cpu cpu 0
PCI: Probing PCI hardware
Memory resource not set for host bridge 0
Memory resource not set for host bridge 1
running VQ750 PCI bios Fixups
No interrupt requested.
Interrupt line(000,01,1) = 23
Interrupt line(000,02,1) = 13
Interrupt line(000,04,1) = 12
Interrupt line(000,05,1) = 0
No interrupt requested.
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
register vq proc
Starting kswapd v1.8
Serial driver version 5.05c (2001-07-08) with no serial options enabled
ttyS00 at 0x0001 (irq = 27) is a ST16654
block: 128 slots per queue, batch=16
RAMDISK driver initialized: 16 RAM disks of 15360K size 1024 blocksize
natsemi.c:v1.07 1/9/2001  Written by Donald Becker <becker@scyld.com>
   http://www.scyld.com/network/natsemi.html
   (unofficial 2.4.x kernel port, version 1.07+LK1.0.8, Aug 07, 2001  Jeff
Garzik
, Tjeerd Mulder)
eth0: NatSemi DP83815 at 0xafffe000, 00:30:ea:00:01:b6, IRQ 13.
eth0: Transceiver status 0x7869 advertising 05e1.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
eth0: link is back. Enabling watchdog.
IP-Config: Complete:
       device=eth0, addr=192.168.1.250, mask=255.255.255.0, gw=192.168.1.2,
      host=ds, domain=, nis-domain=(none),
      bootserver=192.168.1.249, rootserver=192.168.1.249, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4023k freed
EXT2-fs warning: maximal mount count reached, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 172k init 4k openfirmware
INIT: version 2.78 booting
Hostname: ds.
Starting portmap daemon: portmap.
Starting portmapper... Mounting remote filesystems...
INIT: Entering runlevel: 3
Starting system log daemon: syslogdsh-2.03#  klogd.
Starting internet superserver: inetd.

d

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
