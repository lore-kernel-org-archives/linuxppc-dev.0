Message-ID: <3AB8B894.1C5FCD37@esd-electronics.com>
Date: Wed, 21 Mar 2001 15:20:04 +0100
From: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
MIME-Version: 1.0
To: Frank Rowand <frank_rowand@mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	frank@esd-electronics.com
Subject: possible problem in memory management
Content-Type: multipart/mixed;
 boundary="------------0A49DF62FADC2E3F1ABBF3B0"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------0A49DF62FADC2E3F1ABBF3B0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi,

in the last days we noticed some strange memory problems with Monta
Vista's kernel port for the IBM405GP/CR (kernel 2.4.2 and 2.4.0). Some
userspace programs crash when calling free() and the bash shell cannot
startup because it does not get memory (see attached bootlog).

Here aresome examples:

1) While unloading a custom kernel module, we get:
Trying to vfree() nonexistent vm area (da03c000). We had no problems on
x86 architecture and 2.4.0-test2.

2) see attached bootlog.

3) When using busybox 0.50, the busybox shell crashes, when the command
buffer is free()ed. This is for example done, when you press return at
the console. I put a debug message right before the free and behind it
and only the message before the free is printed !

We are shure that these problem have something todo the 2.4.x kernel for
the 405 !

Are problems like this known and solved issues ?

Matthias
--
-------------------------------------------------
\ Matthias Fuchs                                 \
 \ esd electronic system design Gmbh              \
  \ Vahrenwalder Straße 205                        \
   \ D-30165 Hannover                               \
    \ email: matthias.fuchs@esd-electronics.com      \
     \ phone: +49-511-37298-0                         \
      \ fax:   +49-511-37298-68                        \
       --------------------------------------------------
--------------0A49DF62FADC2E3F1ABBF3B0
Content-Type: text/plain; charset=us-ascii;
 name="bootlog1.txt"
Content-Disposition: inline;
 filename="bootlog1.txt"
Content-Transfer-Encoding: 7bit



ppcboot 0.7.1 (Jan  8 2001 - 16:20:48)

Initializing...
  CPU:   IBM PowerPC 405GP Rev. C at 198 MHz (PLB=99, OPB=49, EBC=33 MHz)
           PCI sync clock at 33 MHz, internal PCI arbiter enabled
           16 kB I-Cache 8 kB D-Cache
  Board: ### No HW ID - assuming CPCI405
  FPGA:  cpci4052.ncd s05xlvq100 2000/11/29 14:57:32
  DRAM:  16 MB
  FLASH:  4 MB
  IDE:   Bus 0: OK
    Device 0: Model: SanDisk SDCFB-64  Serial #: 213006F040  Capacity: 61.3 MB = 0.1 GB
  Input:  serial
  Output: serial

Hit any key to stop autoboot:  3  2  0
=> bootp
ENET Speed is 10 Mbs...
HALF duplex connection
BOOTP broadcast 1
ARP broadcast 1
TFTP from server 10.0.5.190; our IP address is 10.0.3.176
Filename '/tftpboot/pImage'. Size is 580 kB => 91000 Bytes
Load address: 0x100000
Loading: *####################################################################################################################
done

=> bootm
## Booting Linux kernel at 00100000 ...
   Image Name:   Test-Image
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    593782 Bytes = 579 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
----------  progress:  0x200 id mach(): done
Linux version 2.4.2-mvista_010303 (frank@pc-linux-dev) (gcc version 2.95.2 19991030 (2.95.3 prerelease/franzo)) #7 Tue Mar 20 20:43:35 CET 2001
----------  progress:  0x3eab setup_arch: enter
----------  progress:  0x3eab setup_arch: bootmem
----------  progress:  0x3eab arch: exit
On node 0 totalpages: 4096
zone(0): 4096 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: bootargs1=root=/dev/nfs ip=10.0.3.176:10.0.5.190:10.0.0.79:255.255.0.0 nfsroot=10.0.5.190:/opt/hardhat/devkit/ppc/4xx/target
Warning: real time clock seems stuck!
Calibrating delay loop... 197.83 BogoMIPS
Memory: 14500k available (1064k kernel code, 436k data, 64k init, 0k highmem)
Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 4096 (order: 2, 16384 bytes)
Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of device 00:00.0
PCI: Cannot allocate resource region 2 of device 00:00.0
PCI: Cannot allocate resource region 3 of device 00:00.0
PCI: Cannot allocate resource region 4 of device 00:00.0
PCI: Cannot allocate resource region 5 of device 00:00.0
----------  progress:  0xffff
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd v1.8
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
pty: 256 Unix98 ptys configured
block: queued sectors max/low 9554kB/3184kB, 64 slots per queue
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: enabling 8 loop devices
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
cpci405ide: physical address=f0100000
cpci405ide: mapped address=da000000
ide0: CPCI405 IDE interface
hda: SanDisk SDCFB-64, ATA DISK drive
ide0 at 0xda000000-0xda000007,0xda00000e on irq 31
hda: 125440 sectors (64 MB) w/1KiB Cache, CHS=490/8/32
Partition check:
 hda: hda1
phy speed read failed
phy duplex read failed
<5>eth0: PPC405 EMAC 10 Mbs Half duplex MAC 00:02:27:00:00:6b
Serial driver version 5.02 (2000-08-09) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
ttyS00 at 0x0000 (irq = 0) is a 16550A
ttyS01 at 0x0000 (irq = 1) is a 16550A
Real Time Clock Driver v1.10d
PPC 405 gpio driver version 00.08.02.d
PPC 405 watchdog driver v0.3
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
PPC 405 iic (i2c) algorithm module 2001.03.01
iic_ppc405_init: PPC 405 iic adapter module
enable_irq(2) unbalanced
i2c-dev.o: Registered 'PPC405 IIC adapter' as minor 0
i2c-core.o: adapter PPC405 IIC adapter registered as adapter 0.
iic_ppc405_init: found device at 0xef600500.
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 1024 bind 1024)
Reset ethernet interfaces
eth0: PPC405 Enet open completed
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.0.5.190
Looking up port of RPC 100005/2 on 10.0.5.190
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 64k init 4k openfirmware
INIT: version 2.77 booting
sh: xmalloc: cannot INIT: Entering runlevel: 3
sh: xmalloc: cannot allocate 8 bytes (0 bytes allocated)
sh: xmalloc: cannot allocate 8 bytes (0 bytes allocated)
sh: xmalloc: cannot allocate 8 bytes (0 bytes allocated)
sh: xmalloc: cannot allocate 8 bytes (0 bytes allocated)
sh: xmalloc: cannot allocate 8 bytes (0 bytes allocated)
sh: xmalloc: cannot allocate 8 bytes (0 bytes allocated)
sh: xmalloc: cannot allocate 8 bytes (0 bytes allocated)
sh: xmalloc: cannot allocate 8 bytes (0 bytes allocated)
sh: xmalloc: cannot allocate 8 bytes (0 bytes allocated)
INIT: Id "sh" respawning too fast: disabled for 5 minutes
INIT: no more processes left in this runlevel

--------------0A49DF62FADC2E3F1ABBF3B0--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
