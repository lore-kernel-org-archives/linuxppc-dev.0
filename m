Message-ID: <903E17B6FF22A24C96B4E28C2C0214D70146BDA2@sr-bng-exc01.int.tsbu.net>
From: "Hegde, Ashok" <Ashok.Hegde@fci.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: One GB SRAM issue
Date: Wed, 22 Oct 2003 12:58:34 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
We are trying to support 1GB SRAM for PMC. We are using MPC7447 Processor
and MV64360/62 controller.
To support this we are enabling high mem.When we give low mem as 0x40000000
and , it will hang in first statement
i.e. while executing "go" command.
We tried with diff values of low mem and kernel base.When low mem is
0x30000000 and Virtual addr of kernel base is 0xB0000000.
Kernel is comming up but it will hang while executing execve(/sbin/init),
which is in init/main.c

(Boot loader is powerboot and it detects 1024MB)
Logfile for this is--------------->

PowerBoot> golinux 1000000 2000000 33b997dc

esetup_arch: enter                         :ahi
setup_arch: bootmem
ppmc280_setup_arch: enter
ppmc280_setup_arch: find_bridges
ppmc280_setup_arch: Reading Variant Information
mv64360_find_bridges: enter
mv64360_find_bridges: fixup of PCI-X device number
mv64360_bridge_init: enter
mv64360_bridge_init: disable all CPU decodings except memory access
mv64360_bridge_init: after disable all CPU decodings except memory access
mv64360_bridge_init: mv64360_cpu_set_pci_io_window
mv64360_bridge_init: mv64360_check_errata
mv64360_find_bridges: after mv64360_bridge_init
mv64360_find_bridges: before pciauto_bus_scan
mv64360_find_bridges: after pciauto_bus_scan
mv64360_find_bridges: before mv64360_pci_disable_all_windows
mv64360_find_bridges: after mv64360_pci_disable_all_windows
ppmc280_setup_bridge: Programming MPP pins for WD
ppmc280_setup_arch: exit
arch: exit
mv64360_init_irq: enter
mv64360_init_irq: exit
console_init:Enter
CONFIG_VT con_init() Calling
mv64360_mpsc_console_init: Calling
mv64360_mpsc_console_init: enter
gt_console_setup: enter
gt_console_setup: exit
Memory BAT mapping: BAT2=256Mb, BAT3=256Mb, residual: 512Mb
Total memory = 1024MB; using 2048kB for hash table (at b0400000)
Linux version 2.4.20 #18 Tue Oct 21 21:52:44 IST 2003
Force PPMC280 Development Board
Board Version: D/B.0
On node 0 totalpages: 262144
zone(0): 196608 pages.
zone(1): 0 pages.
zone(2): 65536 pages.
Kernel command line: console=ttyS0,115200 root=/dev/ram
mtdparts=0:3072k(kernel)
,22528k(Ramdisk),-(JFFS2)
time_init: decrementer frequency = 33.250000 MHz
mv64360_mpsc_console_init: exit
Calibrating delay loop... 996.14 BogoMIPS
Memory: 1010928k available (1452k kernel code, 732k data, 68k init, 262144k
high
mem)
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount-cache hash table entries: 16384 (order: 5, 131072 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [11ab/6460] 000600 00
Found 00:01 [11ab/6460] 000600 00
Found 00:02 [11ab/6460] 000600 00
Found 00:03 [11ab/6460] 000600 00
Found 00:04 [11ab/6460] 000600 00
Found 00:05 [11ab/6460] 000600 00
Found 00:06 [11ab/6460] 000600 00
Found 00:07 [11ab/6460] 000600 00
Found 00:40 [8086/b154] 000604 01
Fixups for bus 00
Scanning behind PCI bridge 00:08.0, config 010100, pass 0
Scanning bus 01
Found 01:00 [dfff/ffff] 00ffff 7f
PCI: device 01:00.0 has unknown header type 7f, ignoring.
Found 01:08 [dfff/ffff] 00ffff 7f
PCI: device 01:01.0 has unknown header type 7f, ignoring.
Found 01:10 [dfff/ffff] 00ffff 7f
PCI: device 01:02.0 has unknown header type 7f, ignoring.
Found 01:18 [dfff/ffff] 00ffff 7f
PCI: device 01:03.0 has unknown header type 7f, ignoring.
Found 01:40 [dfff/ffff] 00ffff 7f
PCI: device 01:08.0 has unknown header type 7f, ignoring.
Found 01:48 [dfff/ffff] 00ffff 7f
PCI: device 01:09.0 has unknown header type 7f, ignoring.
Found 01:50 [dfff/ffff] 00ffff 7f
PCI: device 01:0a.0 has unknown header type 7f, ignoring.
Found 01:58 [dfff/ffff] 00ffff 7f
PCI: device 01:0b.0 has unknown header type 7f, ignoring.
Found 01:80 [dfff/ffff] 00ffff 7f
PCI: device 01:10.0 has unknown header type 7f, ignoring.
Found 01:88 [dfff/ffff] 00ffff 7f
PCI: device 01:11.0 has unknown header type 7f, ignoring.
Found 01:90 [dfff/ffff] 00ffff 7f
PCI: device 01:12.0 has unknown header type 7f, ignoring.
Found 01:98 [dfff/ffff] 00ffff 7f
PCI: device 01:13.0 has unknown header type 7f, ignoring.
Found 01:c0 [dfff/ffff] 00ffff 7f
PCI: device 01:18.0 has unknown header type 7f, ignoring.
Found 01:c8 [dfff/ffff] 00ffff 7f
PCI: device 01:19.0 has unknown header type 7f, ignoring.
Found 01:d0 [dfff/ffff] 00ffff 7f
PCI: device 01:1a.0 has unknown header type 7f, ignoring.
Found 01:d8 [dfff/ffff] 00ffff 7f
PCI: device 01:1b.0 has unknown header type 7f, ignoring.
Fixups for bus 01
Unknown bridge resource 0: assuming transparent
Unknown bridge resource 1: assuming transparent
Unknown bridge resource 2: assuming transparent
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:08.0, config 010100, pass 1
Bus scan for 00 returning with max=01
pci_assign_all_busses 0, hose->first_busno 0x00000000, bus 0xb120bbec
PCI: Cannot allocate resource region 2 of device 00:00.0
PCI: Cannot allocate resource region 4 of device 00:00.0
PCI: Cannot allocate resource region 4 of device 00:00.1
PCI: Cannot allocate resource region 0 of device 00:00.2
PCI: Cannot allocate resource region 2 of device 00:00.2
PCI: Cannot allocate resource region 4 of device 00:00.3
PCI: Cannot allocate resource region 5 of device 00:00.4

Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
JFFS2 version 2.1. (C) 2001 Red Hat, Inc., designed by Axis Communications
AB.
i2c-core.o: i2c core module
i2c-dev.o: i2c /dev entries driver module
i2c-core.o: driver i2c-dev dummy driver registered.
pty: 256 Unix98 ptys configured
mv64360_mpsc_init: enter
gt_mpsc_init: exit
RAMDISK driver initialized: 16 RAM disks of 131072K size 1024 blocksize
loop: loaded (max 8 devices)
Intel(R) PRO/1000 Network Driver - version 4.4.12-k1
Copyright (c) 1999-2002 Intel Corporation.
SCSI subsystem driver Revision: 1.00
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
kmod: failed to exec /sbin/modprobe -s -k scsi_hostadapter, errno = 2
Fusion MPT base driver 2.02.01
Copyright (c) 1999-2002 LSI Logic Corporation
mptbase: 0 MPT adapters found, 0 installed.
Fusion MPT SCSI Host driver 2.02.01
boardflash: 0x2000000 at 0xa0000000
boardflash: 0x2000000 at 0xa2000000
Concatenating MTD devices:
(0): "PPMC280 flash 1"
(1): "PPMC280 flash 2"
into device "PPMC280 Flash Banks #0 and #1"
Using command line partition definition
Creating 3 MTD partitions on "PPMC280 Flash Banks #0 and #1":
0x00000000-0x00300000 : "kernel"
0x00300000-0x01900000 : "Ramdisk"
0x01900000-0x04000000 : "JFFS2"
 bootflash: 0x800000 at 0xff800000
Found: AMD AM29LV008BB
number of JEDEC chips: 1
i2c-algo-mv64360: I2C MV64360 Module
AT24C64 EEPROM detected.
i2c-dev.o: Registered 'MV64360' as minor 0
i2c-core.o: adapter MV64360 registered as adapter 0.
Initializing MAX9600 RTC driver.
i2c-core.o: driver RTC-MAX6900 registered.
i2c-core.o: client [I2C-RTC] registered to adapter [MV64360](pos. 0).
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 20198k freed
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 68k init

Welcome to your suggestions.

Thanks.
Regards
Ashok

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
