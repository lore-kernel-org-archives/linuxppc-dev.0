Message-ID: <000e01c32975$ec44f340$d3726b3d@zzucom>
From: "Minkyu, Joo" <zzu@newer.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Question about RAMDISK CRC error...
Date: Tue, 3 Jun 2003 11:14:54 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Currently I working on custom MPC8245 board which was designed on our company. Unlike the Sandpoint and MPC8245 unity board, our custom board only use internal DUART, SDRAM, PCI, Intel flash memory. I ported linux kernel based on src-linuxppc_2_4_devel kernel source. As you can see in below, boot process seems to be okay except root filesystem mount part. In messages, kernel says CRC error was detected but the root filesystem ifself is correctly gzip. On many tests, sometimes there was no crc error but still occurs segmentation faults or illegal instruction error. Sometime I can see the crc error when decompressing root filesystem image. Sometime all boot-up process ok but after running shell, system hang up. I cannot indentify what the problem is.


loaded at:     00800000 008801B8
zimage at:     00804B10 0087C948
avail ram:     00400000 00800000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel
id mach(): done
MMU:enter
MMU_setup() ok...
MMU:hw init
MMU:mapin
MMU:mapin_ram done
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
mpc10x:enter
mpc10x:exit
arch: exit
openpic: enter
openpic: timer
openpic: external
openpic: spurious
openpic: exit
Memory BAT mapping: BAT2=32Mb, BAT3=0Mb, residual: 0Mb
Set IO BATs
Linux version 2.4.20-pre9 (zzu@ppcdev) (gcc version 3.2.1 20020930 (MontaVista)) #332 Sat May 31 15:50:58 KST 2003
PCI Autoconfig: Found Bus 0, Device 16, Function 0
PCI Autoconfig: BAR 0x10, Mem size=0x1000, address=0xfbfff000
PCI Autoconfig: BAR 0x14, I/O, size=0x40, address=0xbfff80
PCI Autoconfig: BAR 0x18, Mem size=0x100000, address=0xfbe00000
Motorola SPS Sandpoint Test Platform
Port by MontaVista Software, Inc. (source@mvista.com)
On node 0 totalpages: 8192
zone(0): 8192 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line:
openpic_set_sources :: NumSources=4
openpic_set_sources :: NumSources=5
OpenPIC Version 1.2 (1 CPUs and 5 IRQ sources) at fc040000
OpenPIC timer frequency is 66.666666 MHz
init_IRQ done...
soft_init done...
time_init done...
cnosole_init done...
sti() done...
Memory: 25056k available (848k kernel code, 260k data, 72k init, 0k highmem)
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 1024 (order: 0, 4096 bytes)
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1057/0006] 000600 00
Found 00:58 [10ad/0565] 000601 00
Found 00:59 [10ad/0105] 000101 00
Found 00:80 [8086/1229] 000200 00
Fixups for bus 00
Bus scan for 00 returning with max=00

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI enabled
Testing ttyS0 (0xfc004500, 0xfc004500)...
ttyS00 at 0xfc004500 (irq = 4) is a 16450
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
eth0: PCI device 8086:1229, 00:03:47:4D:05:0B, IRQ 3.
  Board assembly 741462-005, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x8b51f404).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 2048 bind 4096)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
crc error<6>Freeing initrd memory: 6144k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k init
INIT: version 2.84 booting
INIT: PANIC: segmentation violation! sleeping for 30 seconds.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
