Message-ID: <3CE85B40.BF72BB80@taikebj.com.cn>
Date: Mon, 20 May 2002 10:11:12 +0800
From: caokai <tk19@taikebj.com.cn>
MIME-Version: 1.0
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: how do openpic works with VIA VT82C686B interrupt control?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,all
I am porting hhl2.1 sandpoint to a custom 8245 board .
This board have VIA VT82C686B pci south bridge to control the serial
port. VIA VT82C686B have a 8259 compatible interrupt control.
Specifically,the 4 PCI interrupts are routed to EPIC external interrupts
1-4,The PIC INTR line from the VIA southbridge is connected to EPIC
externel interrupt 0.
Now everything seems ok except the serial interrupt seems broken.The
serial port interrupt is controled by VIA VT82C686B interrupt control.
How can I start to solve this problem.Do I need to add a VIA VT82C686B
driver?
I know sandpoint 8245 have a 8259 .but this board we DO NOT have 8259.I
should get rid of these 8259  code?

best regards.
caokai
this is my board's output log.I have added some debug information.
=> go 200000
## Starting application at 0x00200000 ...
loaded at:     00200000 002CA1BC
relocated to:  00800000 008CA1BC
zimage at:     00805960 008C6ECA
avail ram:     00400000 00800000

Linux/PPC load: console=ttyS0,115200 console=ttyS0 root=/dev/nfs
Uncompressing Linux...done.
Now booting the kernel
Memory BAT mapping: BAT2=64Mb, BAT3=0Mb, residual: 0Mb
Linux version 2.4.17_mvl21-sandpoint (root@localhost) (gcc version
2.95.3 200103
15 (release/MontaVista)) #64 Thu May 16 11:44:26 CST 2002
PCI Autoconfig: Found Bus 0, Device 22, Function 0
PCI Autoconfig: Found Bus 0, Device 22, Function 1
PCI Autoconfig: BAR 0x10, I/O, size=0x8, address=0xbffff8
PCI Autoconfig: BAR 0x14, I/O, size=0x4, address=0xbffff4
PCI Autoconfig: BAR 0x18, I/O, size=0x8, address=0xbfffe8
PCI Autoconfig: BAR 0x1c, I/O, size=0x4, address=0xbfffe4
PCI Autoconfig: BAR 0x20, I/O, size=0x10, address=0xbfffd0
PCI Autoconfig: Found Bus 0, Device 22, Function 2
PCI Autoconfig: BAR 0x20, I/O, size=0x20, address=0xbfffa0
PCI Autoconfig: Found Bus 0, Device 22, Function 3
PCI Autoconfig: BAR 0x20, I/O, size=0x20, address=0xbfff80
PCI Autoconfig: Found Bus 0, Device 22, Function 4
PCI Autoconfig: Found Bus 0, Device 22, Function 5
PCI Autoconfig: BAR 0x10, I/O, size=0x100, address=0xbffe00
PCI Autoconfig: BAR 0x14, I/O, size=0x4, address=0xbffdfc
PCI Autoconfig: BAR 0x18, I/O, size=0x4, address=0xbffdf8
PCI Autoconfig: Found Bus 0, Device 22, Function 6
PCI Autoconfig: BAR 0x10, I/O, size=0x100, address=0xbffc00
PCI Autoconfig: Found Bus 0, Device 25, Function 0
PCI Autoconfig: BAR 0x10, Mem size=0x1000, address=0xbffff000
PCI Autoconfig: BAR 0x14, I/O, size=0x40, address=0xbffbc0
PCI Autoconfig: BAR 0x18, Mem size=0x20000, address=0xbffc0000
Motorola SPS Sandpoint Test Platform
Sandpoint port (C) 2000, 2001 MontaVista Software, Inc.
(source@mvista.com)
On node 0 totalpages: 16384
zone(0): 16384 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: console=ttyS0,115200 console=ttyS0 root=/dev/nfs
OpenPIC Version 1.2 (1 CPUs and 26 IRQ sources) at fdfd0000
rtsched version <20011203.1609.50>
time_init: decrementer frequency = 25.001586 MHz
Calibrating delay loop... 199.88 BogoMIPS
Memory: 62244k available (1512k kernel code, 552k data, 120k init, 0k
highmem)
Dentry-cache hash table entries: 8192 (order: 4, 65536 bytes)
Inode-cache hash table entries: 4096 (order: 3, 32768 bytes)
Mount-cache hash table entries: 1024 (order: 1, 8192 bytes)
Buffer-cache hash table entries: 4096 (order: 2, 16384 bytes)
Page-cache hash table entries: 16384 (order: 4, 65536 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
2.retvalue=0x1,idsel=0~~~sandpoint_map_irq *dev=PCI device
1057:0006,idsel= 0x0,
pin=0x1,IRQ=0x1 ~~~
+++pcibios update irq:1+++
1.retvalue=0x13,idsel=22~~~sandpoint_map_irq *dev=PCI device
1106:0686,idsel= 0x
16,pin=0x1,IRQ=0x13 ~~~
+++pcibios update irq:19+++
1.retvalue=0x13,idsel=22~~~sandpoint_map_irq *dev=PCI device
1106:0571,idsel= 0x
16,pin=0x1,IRQ=0x13 ~~~
+++pcibios update irq:19+++
1.retvalue=0x14,idsel=22~~~sandpoint_map_irq *dev=PCI device
1106:3038,idsel= 0x
16,pin=0x4,IRQ=0x14 ~~~
+++pcibios update irq:20+++
1.retvalue=0x14,idsel=22~~~sandpoint_map_irq *dev=PCI device
1106:3038,idsel= 0x
16,pin=0x4,IRQ=0x14 ~~~
+++pcibios update irq:20+++
1.retvalue=0x13,idsel=22~~~sandpoint_map_irq *dev=PCI device
1106:3057,idsel= 0x
16,pin=0x1,IRQ=0x13 ~~~
+++pcibios update irq:19+++
1.retvalue=0x15,idsel=22~~~sandpoint_map_irq *dev=PCI device
1106:3058,idsel= 0x
16,pin=0x3,IRQ=0x15 ~~~
+++pcibios update irq:21+++
1.retvalue=0x15,idsel=22~~~sandpoint_map_irq *dev=PCI device
1106:3068,idsel= 0x
16,pin=0x3,IRQ=0x15 ~~~
+++pcibios update irq:21+++
1.retvalue=0x12,idsel=25~~~sandpoint_map_irq *dev=PCI device
8086:1209,idsel= 0x
19,pin=0x1,IRQ=0x12 ~~~
+++pcibios update irq:18+++
PCI: Via IRQ fixup for 00:16.2, from 20 to 4
PCI: Via IRQ fixup for 00:16.3, from 20 to 4
PCI: Via IRQ fixup for 00:16.5, from 21 to 5
PCI: Via IRQ fixup for 00:16.6, from 21 to 5
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Starting kswapd
Disabling the Out Of Memory Killer
pty: 256 Unix98 ptys configured
Serial driver version 5.05c (2001-07-08) with MANY_PORTS SHARE_IRQ
SERIAL_PCI en
abled
ttyS00 at 0xfe0003f8 (irq = 4) is a 16550A
ttyS01 at 0xfe0002f8 (irq = 3) is a 16550A
block: 128 slots per queue, batch=32
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
VP_IDE: IDE controller on PCI bus 00 dev b1
VP_IDE: chipset revision 6
VP_IDE: 100% native mode on irq 19
    ide0: BM-DMA at 0xbfffd0-0xbfffd7, BIOS settings: hda:pio, hdb:pio
loop: loaded (max 8 devices)
eepro100.c:v1.09j-t 9/29/99 Donald Becker
http://www.scyld.com/network/eepro100.
html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin
<saw@sa
w.sw.com.sg> and others
eth0: PCI device 8086:1209, 00:40:53:06:4C:60, IRQ 18.
  Receiver lock-up bug exists -- enabling work-around.
  Board assembly 000000-000, Physical connectors present: AUI
  Primary interface chip None PHY #0.
  General self-test: passed.
  Serial sub-system self-test: passed.
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x1d68d8db).
  Receiver lock-up workaround activated.
SCSI subsystem driver Revision: 1.00
request_module[scsi_hostadapter]: Root fs not mounted
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 512 buckets, 4Kbytes
TCP: Hash tables configured (established 4096 bind 4096)
Sending BOOTP requests . OK
IP-Config: Got BOOTP answer from 192.9.200.160, my address is
192.9.200.141
IP-Config: Complete:
      device=eth0, addr=192.9.200.141, mask=255.255.255.0,
gw=255.255.255.255,
     host=192.9.200.141, domain=, nis-domain=(none),
     bootserver=192.9.200.160, rootserver=192.9.200.160,
rootpath=/opt/hardhat/d
evkit/ppc/82xx/target
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
Looking up port of RPC 100003/2 on 192.9.200.160
Looking up port of RPC 100005/1 on 192.9.200.160
VFS: Mounted root (nfs filesystem).
Freeing unused kernel memory: 120k init
modprobe: modpro.............................


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
