Date: Sun, 11 Jan 2004 22:54:47 -0800
From: mutex <mutex@cryptobackpack.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: DMA timing issues with promise controllers
Message-ID: <20040112065447.GD7303@heliosphan.in.cryptobackpack.org>
Reply-To: mutex <mutex@cryptobackpack.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="A6N2fC+uXW/VQSAv"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all ;-)
I spoke with benh briefly on irc about a problem I was having with
some promise controllers on my quicksilver G4(867).
During boot I get a slew of 'DriveReady SeekComplete Error' and
'DriveStatusError BadCRC' during what looks like some dma timing
tests.
I attached my dmesg.  I did a few tests and this problem manifests
itself irregardless of harddrive(multiple size/version of maxtor
harddrives) and with multiple versions of the promise
chipset(PDC20267, PDC20268)
The drives work fine after a ide reset, but the reset sequence happens
again when I attempt to use fdisk or mount a partition.

I'm willing to do some of the debugging myself, just not sure where to
start.
clues anyone ?

--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg.log"

Memory BAT mapping: BAT2=256Mb, BAT3=256Mb, residual: 1024Mb
Total memory = 1024MB; using 2048kB for hash table (at c0400000)
Linux version 2.4.21-ppc-r2 (root@TiBook.GentooPPC) (gcc version 3.2.3 20030422 (Gentoo Linux 1.4 3.2.3-r1, propolice)) #1 Thu Jul 24 03:30:14 Local time zone must be set--see zic manu
Found Uninorth memory controller & host bridge, revision: 17
Mapped at 0xfdebc000
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfde3c000
Processor NAP mode on idle enabled.
PowerMac motherboard: PowerMac G4 Silver
CPU MSCCR0 : 0x00008003
CPU HID1   : 0x8000ac80
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
hose pci, pci_mem_offset: 00000000, start0: f1000000
  io_base_virt: fd638000, io_base_phys: f0000000, isa_mem_base: 00000000
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
hose pci, pci_mem_offset: 00000000, start0: f3000000
  io_base_virt: fce36000, io_base_phys: f2000000, isa_mem_base: 00000000
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
hose pci, pci_mem_offset: 00000000, start0: f5000000
  io_base_virt: fc634000, io_base_phys: f4000000, isa_mem_base: 00000000
PMU driver 2 initialized for Core99, firmware: 0c
On node 0 totalpages: 262144
zone(0): 196608 pages.
zone(1): 0 pages.
zone(2): 65536 pages.
Kernel command line: root=/dev/ram rw ramdisk_size=11000 init=/linuxrc
PowerMac using OpenPIC irq controller
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc5ed000
OpenPIC timer frequency is 4.166666 MHz
GMT Delta read from XPRAM: -360 minutes, DST: on
time_init: decrementer frequency = 33.290001 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 865.07 BogoMIPS
Memory: 1026496k available (2368k kernel code, 1120k data, 176k init, 262144k highmem)
AGP special page: 0xeffff000
Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
Inode cache hash table entries: 65536 (order: 7, 524288 bytes)
Mount cache hash table entries: 512 (order: 0, 4096 bytes)
Buffer-cache hash table entries: 65536 (order: 6, 262144 bytes)
Page-cache hash table entries: 262144 (order: 8, 1048576 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:58 [106b/002d] 000600 00
Found 00:80 [1002/4966] 000300 00
Fixup res 1 (101) of dev 00:10.0: 400 -> 802400
Fixups for bus 00
Bus scan for 00 returning with max=00
Scanning bus 10
Found 10:58 [106b/002e] 000600 00
Found 10:90 [14e4/5820] 000b40 00
Found 10:98 [13a3/0012] 000b40 00
Found 10:a0 [13a3/0012] 000b40 00
Found 10:a8 [105a/4d69] 000180 00
Found 10:b8 [106b/0022] 00ff00 00
Found 10:c0 [106b/0019] 000c03 00
Found 10:c8 [106b/0019] 000c03 00
Fixups for bus 10
Bus scan for 10 returning with max=10
Scanning bus 20
Found 20:58 [106b/002f] 000600 00
Found 20:70 [11c1/5811] 000c00 00
Found 20:78 [106b/0021] 000200 00
Fixups for bus 20
Bus scan for 20 returning with max=20
PCI->OF bus map:
0 -> 0
16 -> 0
32 -> 0
PCI: bridge rsrc 802000..1001fff (100), parent c02a7164
PCI: bridge rsrc f1000000..f1ffffff (200), parent c02a7180
PCI: bridge rsrc 90000000..9fffffff (200), parent c02a7180
PCI: bridge rsrc 0..7fffff (100), parent c02a7164
PCI: bridge rsrc f3000000..f3ffffff (200), parent c02a7180
PCI: bridge rsrc 80000000..8fffffff (200), parent c02a7180
PCI: bridge rsrc ff7fe000..ffffdfff (100), parent c02a7164
PCI: bridge rsrc f5000000..f5ffffff (200), parent c02a7180
PCI:00:10.0: Resource 0: 98000000-9fffffff (f=1208), vd: 1002, dev: 4966
PCI:00:10.0: Resource 2: 90000000-9000ffff (f=200), vd: 1002, dev: 4966
PCI:10:17.0: Resource 0: 80000000-8007ffff (f=200), vd: 106b, dev: 0022
PCI:20:0f.0: Resource 0: f5200000-f53fffff (f=200), vd: 106b, dev: 0021
PCI:00:10.0: Resource 1: 00802400-008024ff (f=101), vd: 1002, dev: 4966
PCI:10:12.0: Resource 0: 80090000-8009ffff (f=200), vd: 14e4, dev: 5820
PCI:10:13.0: Resource 0: 80085000-80085fff (f=200), vd: 13a3, dev: 0012
PCI:10:13.0: Resource 1: 80084000-80084fff (f=200), vd: 13a3, dev: 0012
PCI:10:14.0: Resource 0: 80083000-80083fff (f=200), vd: 13a3, dev: 0012
PCI:10:14.0: Resource 1: 80082000-80082fff (f=200), vd: 13a3, dev: 0012
PCI:10:15.0: Resource 0: 00000440-00000447 (f=101), vd: 105a, dev: 4d69
PCI:10:15.0: Resource 1: 00000430-00000433 (f=101), vd: 105a, dev: 4d69
PCI:10:15.0: Resource 2: 00000420-00000427 (f=101), vd: 105a, dev: 4d69
PCI:10:15.0: Resource 3: 00000410-00000413 (f=101), vd: 105a, dev: 4d69
PCI:10:15.0: Resource 4: 00000400-0000040f (f=101), vd: 105a, dev: 4d69
PCI:10:15.0: Resource 5: 8008c000-8008ffff (f=200), vd: 105a, dev: 4d69
PCI:10:18.0: Resource 0: 80081000-80081fff (f=200), vd: 106b, dev: 0019
PCI:10:19.0: Resource 0: 80080000-80080fff (f=200), vd: 106b, dev: 0019
PCI:20:0e.0: Resource 0: f5000000-f5000fff (f=200), vd: 11c1, dev: 5811
PCI: Enabling device 10:15.0 (0004 -> 0007)
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Thermal assist unit not available
Starting kswapd
allocated 32 pages and 32 bhs reserved for the highmem bounces
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
PCI: Enabling device 00:10.0 (0086 -> 0087)
radeonfb: ref_clk=2700, ref_div=12, xclk=24975 from OF
radeonfb: detected DFP panel size from EDID: 1280x1024
Console: switching to colour frame buffer device 160x64
radeonfb: ATI Radeon 9000 If DDR SGRAM 64 MB
radeonfb: DVI port no monitor connected
radeonfb: CRT port DFP monitor connected
input0: Macintosh mouse button emulation
pty: 256 Unix98 ptys configured
RAMDISK driver initialized: 16 RAM disks of 11000K size 1024 blocksize
loop: loaded (max 8 devices)
sungem.c:v0.97 3/20/02 David S. Miller (davem@redhat.com)
eth0: Sun GEM (PCI) 10/100/1000BaseT Ethernet 00:03:93:1b:09:3a
eth0: Found BCM5411 PHY
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
PDC20269: IDE controller at PCI slot 10:15.0
PDC20269: chipset revision 2
PDC20269: not 100% native mode: will probe irqs later
PDC20269: ROM enabled at 0x80088000
    ide0: BM-DMA at 0x0400-0x0407, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0x0408-0x040f, BIOS settings: hdc:pio, hdd:pio
ide2: Found Apple KeyLargo ATA-4 controller, bus ID 2
ide3: Found Apple KeyLargo ATA-3 controller, bus ID 0
ide4: Found Apple KeyLargo ATA-3 controller, bus ID 1
Probing IDE interface ide0...
hda: Maxtor 6Y160P0, ATA DISK drive
blk: queue c0379d30, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide1...
hdc: Maxtor 6Y160P0, ATA DISK drive
blk: queue c037a1a0, I/O limit 4095Mb (mask 0xffffffff)
Probing IDE interface ide2...
Probing IDE interface ide3...
hdg: PIONEER DVD-RW DVR-103, ATAPI CD/DVD-ROM drive
hdg: Enabling MultiWord DMA 2
Probing IDE interface ide4...
ide0 at 0x440-0x447,0x432 on irq 58
ide1 at 0x420-0x427,0x412 on irq 58
ide3 at 0xf5359000-0xf5359007,0xf5359160 on irq 20
hda: attached ide-disk driver.
hda: max request size: 1024KiB
hda: host protected area => 1
hda: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
hdc: attached ide-disk driver.
hdc: max request size: 1024KiB
hdc: host protected area => 1
hdc: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)
hdg: attached ide-cdrom driver.
hdg: ATAPI 24X DVD-ROM DVD-R CD-R/RW drive, 2000kB Cache, DMA
Uniform CD-ROM driver Revision: 3.12
Partition check:
 /dev/ide/host0/bus0/target0/lun0:hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
blk: queue c0379d30, I/O limit 4095Mb (mask 0xffffffff)
PDC202XX: Primary channel reset.
ide0: reset: success
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_timer_expiry: dma status == 0x21
hda: timeout waiting for DMA
PDC202XX: Primary channel reset.
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
 p1
 /dev/ide/host0/bus1/target0/lun0:hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
hdc: dma_timer_expiry: dma status == 0x21
hdc: timeout waiting for DMA
PDC202XX: Secondary channel reset.
hdc: timeout waiting for DMA
hdc: (__ide_dma_test_irq) called while not waiting
blk: queue c037a1a0, I/O limit 4095Mb (mask 0xffffffff)
 p1
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
mesh: configured for synchronous 5 MB/s
orinoco.c 0.13d (David Gibson <hermes@gibson.dropbear.id.au> and others)
hermes.c: 4 Dec 2002 David Gibson <hermes@gibson.dropbear.id.au>
airport.c 0.13d (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
Macintosh non-volatile memory driver v1.0
apm_emu: APM Emulation 0.5 initialized.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 10:18.0 (0000 -> 0002)
PCI: Enabling bus mastering for device 10:18.0
host/usb-ohci.c: USB OHCI at membase 0xf5365000, IRQ 27
host/usb-ohci.c: usb-10:18.0, Apple Computer Inc. KeyLargo USB
adb: starting probe task...
adb: finished probe task...
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 10:19.0 (0000 -> 0002)
PCI: Enabling bus mastering for device 10:19.0
host/usb-ohci.c: USB OHCI at membase 0xf5367000, IRQ 28
host/usb-ohci.c: usb-10:19.0, Apple Computer Inc. KeyLargo USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
usb.c: registered new driver rio500
rio500.c: v1.1:USB Rio 500 driver
usb.c: registered new driver auerswald
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 8192 buckets, 64Kbytes
TCP: Hash tables configured (established 262144 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
IPv6 v0.8 for NET4.0
IPv6 over IPv4 tunneling driver
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 3206k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 176k init 4k chrp 36k prep
ISO 9660 Extensions: Microsoft Joliet Level 3
hub.c: new USB device 10:19.0-1, assigned address 2
hub.c: USB hub found
hub.c: 3 ports detected
ISO 9660 Extensions: RRIP_1991A
hub.c: new USB device 10:19.0-1.1, assigned address 3
cloop: Welcome to cloop v0.66
usb_control/bulk_msg: timeout
input1: USB HID v10.01 Keyboard [Mitsumi Electric Apple Extended USB Keyboard] on usb2:3.0
input2: USB HID v10.01 Pointer [Mitsumi Electric Apple Extended USB Keyboard] on usb2:3.1
hub.c: new USB device 10:19.0-1.2, assigned address 4
input3: USB HID v10.01 Mouse [Fujitsu Takamisawa Component Apple Optical USB Mouse] on usb2:4.0
hub.c: new USB device 10:18.0-2, assigned address 2
hub.c: USB hub found
hub.c: 3 ports detected
hub.c: new USB device 10:18.0-2.3, assigned address 3
: USB HID v0.01 Pointer [05ac:9217] on usb1:3.0
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
eth0: no IPv6 routers present
eth0: Link is up at 100 Mbps, full-duplex.
eth0: Pause is enabled (rxfifo: 10240 off: 7168 on: 5632)
eth0: no IPv6 routers present
md: md driver 0.90.0 MAX_MD_DEVS=256, MD_SB_DISKS=27

--A6N2fC+uXW/VQSAv--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
