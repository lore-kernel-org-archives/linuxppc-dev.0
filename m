Date: Mon, 26 Nov 01 14:05:19 PST
From: msokolov@ivan.Harhan.ORG (Michael Sokolov)
Message-Id: <0111262205.AA22280@ivan.Harhan.ORG>
To: linuxppc-dev@lists.linuxppc.org
Subject: VT82C686B IDE and Linux/PPC woes
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi there,

I wonder,

Has anyone here other than us with the Adirondack ever designed a PPC board
with a VT82C686B south bridge and put Linux/PPC on it? If anyone has done this,
what magic did you do for the IDE?

On the Adirondack I have no PC BIOS and no openfirmware, I have my own
minimalist firmware instead. My minimalist firmware does absolutely nothing
with the IDE stuff in the VT82C686B. Since it's already in PCI native mode on
power-up, VT82C686B's IDE function gets enumerated just like any other PCI
device, and the BARs mapping the IDE ports get your typical floating PCI
addresses. It seems like there is no other initialisation needed, as I can then
dingle the addresses in the BARs and see the drive attached to the IDE0 port.
(See session log below. The WD100x/IDE/ATA driver in my firmware knows
absolutely nothing about VT82C686B or even about PCI, it takes the addresses
passed to it and treats the IDE device as if it was an ancient MFM controller
in an ISA slot on the original 286 AT.)

Yet when I boot Linux/PPC, it sees the IDE ports, but doesn't see the drive
attached to the IDE0 port (see the session log below). My port in
arch/ppc/platforms does absolutely nothing IDE-related, in .config I have IDE
and VT82C686B support enabled. Is there something that my Linux/PPC port has to
do explicitly with IDE in order for it to work?

TIA for any help.

MS

SBS ADIRONDACK STARMON T2.0-2

Performing normal system tests
84..83..82..81..80..79..78..77..76..75..74..73..72..71..70..69..
68..67..66..65..64..63..62..61..60..59..58..57..56..55..54..53..
52..51..50..49..48..47..46..45..44..43..42..41..40..39..38..37..
36..35..34..33..32..31..30..29..28..27..26..25..24..23..22..21..
20..19..18..17..16..15..14..13..12..11..10..09..08..07..06..05..
04..03..
Tests completed
>>>
>>>! Let's see what devices the firmware sees
>>>
>>>SHOW DEVICES
WD100x/IDE/ATA device, registers at C0002000 and C000200A, drive 0
-IDE0: ATA autodetected <WDC AC22500L> 4999680 sectors total
WD100x/IDE/ATA device, registers at C0002000 and C000200A, drive 1
-IDE1: ?
WD100x/IDE/ATA device, registers at C0002010 and C000201A, drive 0
-IDE2: ?
WD100x/IDE/ATA device, registers at C0002010 and C000201A, drive 1
-IDE3: ?
ERROR: Driver file not found SYS:FDDPC0.DRV
-ETH0: Intel 8255x (PCI device handle 00000400)
 Ethernet station address 00:A0:F7:4A:00:24
-ETH1: Intel 8255x (PCI device handle 01000300)
 Ethernet station address 00:A0:F7:4A:40:24
>>>
>>>! Now boot Linux
>>>
>>>@"ETH0:10.2.12.201:msokolov/adir-test-linboo.cmd"
-ETH0: Intel 8255x (PCI device handle 00000400)
 Ethernet station address 00:A0:F7:4A:00:24

Using local IP address 10.2.12.121

Resolving IP address 10.2.12.201 to Ethernet address via ARP...
Ethernet address is 00:60:08:CC:C4:14
Loading msokolov/adir-test-linboo.cmd from 10.2.12.201...
240 (000000F0 hex) bytes loaded
Command script loaded, executing...
>>>L "ETH0:10.2.12.201:msokolov/adir-vmlinux.bin"
-ETH0: Intel 8255x (PCI device handle 00000400)
 Ethernet station address 00:A0:F7:4A:00:24

Using local IP address 10.2.12.121

Resolving IP address 10.2.12.201 to Ethernet address via ARP...
Ethernet address is 00:60:08:CC:C4:14
Loading msokolov/adir-vmlinux.bin from 10.2.12.201...
2252972 (002260AC hex) bytes loaded
>>>L/S:800000 "ETH0:10.2.12.201:msokolov/adir-runlnx.bin"
-ETH0: Intel 8255x (PCI device handle 00000400)
 Ethernet station address 00:A0:F7:4A:00:24

Using local IP address 10.2.12.121

Resolving IP address 10.2.12.201 to Ethernet address via ARP...
Ethernet address is 00:60:08:CC:C4:14
Loading msokolov/adir-runlnx.bin from 10.2.12.201...
5728 (00001660 hex) bytes loaded
>>>D R3 0
>>>D/P/B 820000 "ip=10.2.12.121::10.2.12.201:255.255.0.0::eth0 nfsroot=10.1.8.20
4:/ppcroot.test" 0
>>>D R4 820000
>>>D R5 8
>>>S 800000
PPC Linux starter T1.0-4 (for SBS Adirondack)
vmlinux already loaded at 0
Kernel command line: ip=10.2.12.121::10.2.12.201:255.255.0.0::eth0 nfsroot=10.1.
8.204:/ppcroot.test
Constructing kernel bootinfo records...
Starting the kernel (with bootinfo)...
Total memory = 512MB; using 1024kB for hash table (at c0300000)
Linux version 2.4.16 (msokolov@quasar.sbsinternal.com) (gcc version 2.95.3 20010
315 (release)) #28 Mon Nov 26 10:55:34 PST 2001
System Identification: SBS Adirondack - PowerPC 750CXe @ 300 Mhz
SBS Adirondack port (C) 2001 SBS Technologies, Inc.
CPU manufacturer: IBM [rev=2214]
On node 0 totalpages: 131072
zone(0): 131072 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: ip=10.2.12.121::10.2.12.201:255.255.0.0::eth0 nfsroot=10.1.
8.204:/ppcroot.test
Calibrating delay loop... 599.65 BogoMIPS
Memory: 512140k available (1608k kernel code, 668k data, 112k init, 0k highmem)
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 0 of PCI bridge 0
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Starting kswapd
parport0: PC-style at 0x378 (0x778) [PCSPP,TRISTATE]
parport_pc: Via 686A parallel port: io=0x378
parport1: PC-style at 0x3bc [PCSPP]
parport2: PC-style at 0x278 [PCSPP,EPP]
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ SERIAL_PCI en
abled
ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A
ttyS02 at 0x03e8 (irq = 0) is a 16450
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev 19
VP_IDE: chipset revision 6
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: VIA vt82c686b (rev 40) IDE UDMA100 controller on pci00:03.1
VP_IDE: 100% native mode on irq 14
    ide0: BM-DMA at 0xffffd0-0xffffd7, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xffffd8-0xffffdf, BIOS settings: hdc:pio, hdd:pio
Floppy drive(s): fd0 is 2.88M
FDC 0 is a post-1991 82077
SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256).
loop: loaded (max 8 devices)
plip: parport0 has no IRQ. Using IRQ-less mode,which is fairly inefficient!
NET3 PLIP version 2.4-parport gniibe@mri.co.jp
plip0: Parallel port at 0x378, not using IRQ.
plip: parport1 has no IRQ. Using IRQ-less mode,which is fairly inefficient!
NET3 PLIP version 2.4-parport gniibe@mri.co.jp
plip1: Parallel port at 0x3bc, not using IRQ.
plip: parport2 has no IRQ. Using IRQ-less mode,which is fairly inefficient!
NET3 PLIP version 2.4-parport gniibe@mri.co.jp
plip2: Parallel port at 0x278, not using IRQ.
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://cesdis.gsfc.nasa.gov/linux/driv
ers/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@sa
w.sw.com.sg> and others
eth0: OEM i82557/i82558 10/100 Ethernet, 00:A0:F7:4A:00:24, IRQ 26.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x1d68d8db).
eth1: OEM i82557/i82558 10/100 Ethernet, 00:A0:F7:4A:40:24, IRQ 25.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x1d68d8db).
PPP generic driver version 2.4.1
PPP Deflate Compression module registered
SCSI subsystem driver Revision: 1.00
sym0: <1010-66> rev 0x1 on pci bus 1 device 4 function 0 irq 24
sym0: using 64 bit DMA addressing
sym0: No NVRAM, ID 7, Fast-80, LVD, parity checking
sym0: SCSI BUS has been reset.
scsi0 : sym-2.1.16a
scsi1 : SCSI host adapter emulation for IDE ATAPI devices
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.268 $ time 10:57:36 Nov 26 2001
usb-uhci.c: High bandwidth mode enabled
usb-uhci.c: USB UHCI at I/O 0xffffa0, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: USB UHCI at I/O 0xffff80, IRQ 11
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb-uhci.c: v1.268:USB Universal Host Controller Interface driver
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
IP-Config: Complete:
      device=eth0, addr=10.2.12.121, mask=255.255.0.0, gw=10.2.12.201,
     host=10.2.12.121, domain=, nis-domain=(none),
     bootserver=255.255.255.255, rootserver=10.1.8.204, rootpath=
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 10.1.8.204
Looking up port of RPC 100005/1 on 10.1.8.204
VFS: Mounted root (nfs filesystem).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
