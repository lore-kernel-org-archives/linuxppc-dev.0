Subject: ibook2r2 & strange freeze.
From: Brice Figureau <brice@tincell.com>
To: "Linuxppc-Dev@Lists.  " "Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Content-Type: text/plain
Message-Id: <1051284468.2467.179.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 25 Apr 2003 17:27:49 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

I apologize if this is the wrong list to ask my questions...
I don't know if anyone here could have an answer to my problem.

I have an Apple iBook 2.rev2 from last mid year.
I was running almost perfectly one of the Benjamin Herrenschmidt's
2.4.19 kernel.
A few days ago I completely re-installed the beast with the latest
Mandrake PPC 9.1 which is shipping with a non working kernel for those
ibooks.

I then compiled & installed the latest benh stable kernel (2.4.20-ben10)
which is really unstable on my computer when booted with the default
parameters.

When I boot with video=ofonly there are no problem at all (except that
the backlight controller does not work anymore...).
Several other mandrake user owning ibook2r2 reported that their computer
where not stable without video=ofonly.

By unstable I mean that the computer completely freeze during boot time,
around the time rc.sysinit is launched. Unfortunately I'm rather new to
linux kernel so I don't know how to provide more information on the
crash (maybe should I configure the kernel with xmon ?).
In a divide&conquer approach I found that the part of rc.sysinit which
'uploads' the console font to the font layer was triggering the crash.

I then re-installed from scratch everything (because I thought there
could have been a fs corruption somewhere which had corrupted the
fonts), but no chance it crashed again.

I then commented-out this part of rc.sysinit and then I could boot up to
the login prompt.

But the kernel was still unstable, and still froze at completely random
time (mounting a cdrom, vi'ing some text files, rsyncing a kernel,
compiling the kernel).

I decided to have a look to the latest devel kernel (namely
2.4.21-pre7-ben0 and 2.4.21-rc1-ben0) but no chance again, when booted
with video=radeonfb (or with nothing) they're oopsing during the boot (I
can provide more information if needed). With video=ofonly, everything
went smooth.

As I wasn't sure the crash came from my compiled kernel, I also tried
pre-built kernel from penguinppc.org (the following dmesg output has
been taken from this kernel). This kernel was relatively stable with my
modified rc.sysinit, but failed with the original rc.sysinit.

So, what should I do to have a stable kernel with radeonfb ?

Many thanks,
Regards,

Brice


------------------------------- cpuinfo output ----------------------

# cat /proc/cpuinfo
cpu             : 750FX
temperature     : 72 C (uncalibrated)
clock           : 700MHz
revision        : 1.2 (pvr 7000 0102)
bogomips        : 1389.36
machine         : PowerBook4,3
motherboard     : PowerBook4,3 MacRISC2 MacRISC Power Macintosh
detected as     : 257 (iBook 2 rev. 2)
pmac flags      : 0000000b
L2 cache        : 512K unified
memory          : 384MB
pmac-generation : NewWorld


--------------------------- lspci output ---------------------------

# lspci -v
00:0b.0 Host bridge: Apple Computer Inc. UniNorth/Pangea AGP
        Flags: bus master, 66Mhz, medium devsel, latency 16
        Capabilities: [80] AGP version 1.0

00:10.0 VGA compatible controller: ATI Technologies Inc Radeon Mobility
M6 LY (prog-if 00 [VGA])
        Subsystem: ATI Technologies Inc Radeon Mobility M6 LY
        Flags: bus master, stepping, 66Mhz, medium devsel, latency 255,
IRQ 48
        Memory at 98000000 (32-bit, prefetchable) [size=128M]
        I/O ports at 802400 [disabled] [size=256]
        Memory at 90000000 (32-bit, non-prefetchable) [size=64K]
        Expansion ROM at 90020000 [disabled] [size=128K]
        Capabilities: [58] AGP version 2.0
        Capabilities: [50] Power Management version 2

10:0b.0 Host bridge: Apple Computer Inc. UniNorth/Pangea PCI
        Flags: bus master, 66Mhz, medium devsel, latency 16

10:17.0 Class ff00: Apple Computer Inc. KeyLargo/Pangea Mac I/O
        Flags: bus master, medium devsel, latency 16
        Memory at 80000000 (32-bit, non-prefetchable) [size=512K]

10:18.0 USB Controller: Apple Computer Inc. KeyLargo/Pangea USB (prog-if
10 [OHCI])
        Flags: bus master, medium devsel, latency 16, IRQ 27
        Memory at 80081000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2

10:19.0 USB Controller: Apple Computer Inc. KeyLargo/Pangea USB (prog-if
10 [OHCI])
        Flags: bus master, medium devsel, latency 16, IRQ 28
        Memory at 80080000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [50] Power Management version 2

20:0b.0 Host bridge: Apple Computer Inc. UniNorth/Pangea Internal PCI
        Flags: bus master, 66Mhz, medium devsel, latency 16

20:0e.0 FireWire (IEEE 1394): Apple Computer Inc. UniNorth/Pangea
FireWire (prog-if 10 [OHCI])
        Subsystem: Apple Computer Inc. UniNorth/Pangea FireWire
        Flags: bus master, 66Mhz, medium devsel, latency 16, IRQ 40
        Memory at f5000000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [44] Power Management version 2

20:0f.0 Ethernet controller: Apple Computer Inc. UniNorth/Pangea GMAC
(Sun GEM)
        Flags: bus master, 66Mhz, slow devsel, latency 6, IRQ 41
        Memory at f5200000 (32-bit, non-prefetchable) [size=2M]
        Expansion ROM at f5100000 [disabled] [size=1M]

-------------------------- 2.4.20-ben10 dmesg --------------------------

Memory BAT mapping: BAT2=256Mb, BAT3=128Mb, residual: 0Mb
Total memory = 384MB; using 1024kB for hash table (at c0400000)
Linux version 2.4.20-ben10 (tmcnulty@dual) (gcc version 3.2.1) #1 Wed
Apr 2 21:07:23 EST 2003
Found Uninorth memory controller & host bridge, revision: 192
Mapped at 0xfdf3c000
Found a Pangea mac-io controller, rev: 0, mapped at 0xfdebc000
Processor NAP mode on idle enabled.
PowerMac motherboard: iBook 2 rev. 2
PMU driver 2 initialized for Core99, firmware: 0c
CPU HID1 : 0x70000044
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
hose pci, pci_mem_offset: 00000000, start0: f1000000
  io_base_virt: fd6b5000, io_base_phys: f0000000, isa_mem_base: 00000000
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->0
hose pci, pci_mem_offset: 00000000, start0: f3000000
  io_base_virt: fceb3000, io_base_phys: f2000000, isa_mem_base: 00000000
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
hose pci, pci_mem_offset: 00000000, start0: f5000000
  io_base_virt: fc6b1000, io_base_phys: f4000000, isa_mem_base: 00000000
On node 0 totalpages: 98304
zone(0): 98304 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda13 ro  devfs=mount hdb=ide-scsi 3
ide_setup: hdb=ide-scsi
PowerMac using OpenPIC irq controller
OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at fc66d000
OpenPIC timer frequency is 4.160000 MHz
GMT Delta read from XPRAM: 120 minutes, DST: on
time_init: decrementer frequency = 24.835245 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 1389.36 BogoMIPS
Memory: 383744k available (1992k kernel code, 892k data, 288k init, 0k
highmem)
AGP special page: 0xd7fff000
Dentry cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:58 [106b/0027] 000600 00
Found 00:80 [1002/4c59] 000300 00
Fixup res 1 (101) of dev 00:10.0: 400 -> 802400
Fixups for bus 00
Bus scan for 00 returning with max=00
Scanning bus 10
Found 10:58 [106b/0028] 000600 00
Found 10:b8 [106b/0025] 00ff00 00
Found 10:c0 [106b/0026] 000c03 00
Found 10:c8 [106b/0026] 000c03 00
Fixups for bus 10
Bus scan for 10 returning with max=10
Scanning bus 20
Found 20:58 [106b/0029] 000600 00
Found 20:70 [106b/0030] 000c00 00
Found 20:78 [106b/0024] 000200 00
Fixups for bus 20
Bus scan for 20 returning with max=20
PCI->OF bus map:
0 -> 0
16 -> 0
32 -> 0
PCI:00:10.0: Resource 0: 98000000-9fffffff (f=1208), vd: 1002, dev: 4c59
PCI:00:10.0: Resource 2: 90000000-9000ffff (f=200), vd: 1002, dev: 4c59
PCI:10:17.0: Resource 0: 80000000-8007ffff (f=200), vd: 106b, dev: 0025
PCI:20:0f.0: Resource 0: f5200000-f53fffff (f=200), vd: 106b, dev: 0024
PCI:00:10.0: Resource 1: 00802400-008024ff (f=101), vd: 1002, dev: 4c59
PCI:10:18.0: Resource 0: 80081000-80081fff (f=200), vd: 106b, dev: 0026
PCI:10:19.0: Resource 0: 80080000-80080fff (f=200), vd: 106b, dev: 0026
PCI:20:0e.0: Resource 0: f5000000-f5000fff (f=200), vd: 106b, dev: 0030
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Initializing RT netlink socket
Thermal assist unit using timers, shrink_timer: 200 jiffies
Starting kswapd
Journalled Block Device driver loaded
devfs: v1.12c (20020818) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x1
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
PCI: Enabling device 00:10.0 (0086 -> 0087)
radeonfb: ref_clk=2700, ref_div=12, xclk=16615 from OF
radeonfb: detected DFP panel size from EDID: 1024x768
Console: switching to colour frame buffer device 128x48
Registered "ati" backlight controller, level: 15/15
radeonfb: ATI Radeon M6 LY DDR SGRAM 16 MB
radeonfb: DVI port LCD monitor connected
radeonfb: CRT port no monitor connected
radeonfb: Power Management enabled for Mobility chipsets
input0: Macintosh mouse button emulation
pty: 256 Unix98 ptys configured
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx
ide0: Found Apple KeyLargo ATA-4 controller, bus ID 2
Probing IDE interface ide0...
hda: IBM-IC25N040ATCS04-0, ATA DISK drive
hdb: TOSHIBA DVD-ROM SD-R2102, ATAPI CD/DVD-ROM drive
ide0 at 0xdd153000-0xdd153007,0xdd153160 on irq 19
hda: Enabling Ultra DMA 2
blk: queue c02fe780, I/O limit 4095Mb (mask 0xffffffff)
hda: 78140160 sectors (40008 MB) w/1768KiB Cache, CHS=77520/16/63,
UDMA(33)
ide-floppy driver 0.99.newide
hdb: Enabling Ultra DMA 2
Partition check:
 /dev/ide/host0/bus0/target0/lun0: [mac] p1 p2 p3 p4 p5 p6 p7 p8 p9 p10
p11 p12 p13 p14 p15 p16 p17
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
PPP generic driver version 2.4.2
PPP Deflate Compression module registered
ide-floppy driver 0.99.newide
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: DVD-ROM SD-R2102  Rev: 1K27
  Type:   CD-ROM                             ANSI SCSI revision: 02
mesh: configured for synchronous 5 MB/s
Attached scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.12
orinoco.c 0.11b (David Gibson <hermes@gibson.dropbear.id.au> and others)
hermes.c: 5 Apr 2002 David Gibson <hermes@gibson.dropbear.id.au>
PowerMac Z8530 serial driver version 2.0
tty00 at 0xda00e020 (irq = 22) is a Z8530 ESCC
tty01 at 0xda015000 (irq = 23) is a Z8530 ESCC
Macintosh non-volatile memory driver v1.0
apm_emu: APM Emulation 0.5 initialized.
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 10:18.0 (0000 -> 0002)
PCI: Enabling bus mastering for device 10:18.0
usb-ohci.c: USB OHCI at membase 0xda01b000, IRQ 27
usb-ohci.c: usb-10:18.0, Apple Computer Inc. KeyLargo/Pangea USB
adb: starting probe task...
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 10:19.0 (0000 -> 0002)
PCI: Enabling bus mastering for device 10:19.0
usb-ohci.c: USB OHCI at membase 0xda01d000, IRQ 28
usb-ohci.c: usb-10:19.0, Apple Computer Inc. KeyLargo/Pangea USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 32768 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 592k freed
VFS: Mounted root (ext2 filesystem).
Mounted devfs on /dev
adb devices: [2]: 2 c4 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ISO, swapping keys.
input1: ADB HID on ID 2:2.c4
input2: ADB HID on ID 7:7.1f
ADB mouse at 3, handler set to 4 (trackpad)<6>kjournald starting.
Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.

input3: ADB HID on ID 3:3.01
adb: finished probe task...
Mounted devfs on /dev
Freeing unused kernel memory: 288k init 8k chrp 8k prep
hub.c: new USB device 10:19.0-1, assigned address 2
input4: USB HID v10.01 Mouse [Logitech USB-PS/2 Optical Mouse] on
usb2:2.0
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,13), internal journal
Adding Swap: 516088k swap-space (priority -1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,17), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,15), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS 2.4-0.9.19, 19 August 2002 on ide0(3,16), internal journal
EXT3-fs: mounted filesystem with ordered data mode.
eth0: GMAC at 00:03:93:9d:5f:18, driver v1.5k4
i2c-core.o: i2c core module
i2c-core.o: adapter uni-n 0 registered as adapter 0.
i2c-core.o: adapter uni-n 1 registered as adapter 1.
Found KeyWest i2c on "uni-n", 2 channels, stepping: 4 bits
i2c-core.o: adapter mac-io 0 registered as adapter 2.
Found KeyWest i2c on "mac-io", 1 channel, stepping: 4 bits
tas driver [TAS3004 driver V 0.3])
using i2c address: 0x35 from device-tree
i2c-core.o: driver TAS3004 driver V 0.3 registered.
i2c-core.o: client [tas Digital Equalizer] registered to adapter [mac-io
0](pos. 0).
Audio jack unplugged, enabling speakers.
AE-Init snapper mixer
PowerMac Snapper  DMA sound driver rev 016 installed
Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.07
Write will use    4 fragments of   32768 bytes as default
eth0: PHY ID: 0x004061e4
eth0: Found Broadcom BCM5221 PHY
eth0: Link state change, phy_status: 0x782d
eth0:    Link up ! BCM5201/5221 aux_stat: 0x003f
eth0:    Full Duplex: 1, Speed: 100
svc: unknown version (3)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
