Message-ID: <3BDE79F7.4080801@waitaki.otago.ac.nz>
Date: Tue, 30 Oct 2001 22:59:19 +1300
From: Bryce McKinlay <bryce@waitaki.otago.ac.nz>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: benh's kernel is unable to compile.
References: <3BDE0FEB.1050206@waitaki.otago.ac.nz> <20011030091724.4260@smtp.adsl.oleane.com>
Content-Type: multipart/mixed;
 boundary="------------020305090209080006070303"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020305090209080006070303
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt wrote:

>>FYI I built 2.4.14-pre2-ben0 out of rsync about 2 hours ago and it seems
>>to be working. It does get some IDE errors about lost IRQs during bootup
>>that didn't happen with 2.4.13-ben0. Eventually it said "ide0: reset"
>>and now appears to be working normally. This is on a Powebook G4.
>>
>
>That's absolutely not normal. Can you send me a dmesg log of this
>situation ? The ide:reset will have disabled DMA, thus causing your
>to be very slow.
>

Yep - I've attached the log below.

>If you re-enable DMA later one (hdparm -d1 /dev/hda), to you again
>get lost IRQs & ide reset or does it stick ?
>

Re-enabling DMA causes the same messages and another reset.

BTW, thanks so much for all the wonderful work you do on linux-ppc. I am
very impressed with how well my Powerbook runs - particularly with the
PMU and Airport support. I get better battery life under Linux than OS X!

regards

Bryce.



--------------020305090209080006070303
Content-Type: text/plain;
 name="dmesg-2.4.14-pre2-ben0"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="dmesg-2.4.14-pre2-ben0"

Total memory = 512MB; using 1024kB for hash table (at c0300000)
Linux version 2.4.14-pre2-ben0 (root@localhost.localdomain) (gcc version 2.95.3 20010111 (prerelease/franzo/20010111)) #8 Tue Oct 30 14:56:22 NZDT 2001
Found Uninorth memory controller & host bridge, revision: 8
Found a Keylargo mac-io controller, rev: 3, mapped at 0xfde8f000
PowerMac motherboard: PowerBook Titanium
PMU driver 2 initialized for Core99, firmware: 0c
Found UniNorth PCI host bridge at 0xf0000000. Firmware bus number: 0->0
Found UniNorth PCI host bridge at 0xf2000000. Firmware bus number: 0->1
Found UniNorth PCI host bridge at 0xf4000000. Firmware bus number: 0->0
On node 0 totalpages: 131072
zone(0): 131072 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=/dev/hda13
PowerMac using OpenPIC irq controller
OpenPIC Version 1.2 (4 CPUs and 256 IRQ sources) at fc640000
OpenPIC timer frequency is 4.166666 MHz
GMT Delta read from XPRAM: 720 minutes, DST: off
time_init: decrementer frequency = 24.966218 MHz
Console: colour dummy device 80x25
Calibrating delay loop... 996.14 BogoMIPS
Memory: 511748k available (1568k kernel code, 900k data, 276k init, 0k highmem)
AGP special page: 0xdffff000
Dentry-cache hash table entries: 65536 (order: 7, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 6, 262144 bytes)
Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
Buffer-cache hash table entries: 32768 (order: 5, 131072 bytes)
Page-cache hash table entries: 131072 (order: 7, 524288 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Can't get bus-range for /pci@f2000000/cardbus@1a
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039
Thermal assist unit using timers, shrink_timer: 200 jiffies
Starting kswapd
devfs: v0.119 (20011009) Richard Gooch (rgooch@atnf.csiro.au)
devfs: boot_options: 0x0
PCI: Enabling device 00:10.0 (0086 -> 0087)
aty128fb: Rage Mobility M3 (AGP) [chip rev 0x0] 8M 128-bit SDR SGRAM (1:1)
Console: switching to colour frame buffer device 144x48
Registered "ati" backlight controller, level: 14/15
fb0: ATY Rage128 frame buffer device on PCI
no framebuffer address found for /pci@f0000000/ATY,RageM3p12Parent@10/ATY,RageM3p12B
input0: Macintosh mouse button emulation
pty: 256 Unix98 ptys configured
block: 128 slots per queue, batch=42
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
Uniform Multi-Platform E-IDE driver Revision: 6.31
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
pmac_ide: enabling IDE bus ID 2
pmac_ide: enabling IDE bus ID 0
pmac_ide: enabling IDE bus ID 1
hda: IC25N030ATDA04-0, ATA DISK drive
hdc: MATSHITADVD-ROM SR-8187, ATAPI CD/DVD-ROM drive
ide0 at 0xe4a57000-0xe4a57007,0xe4a57160 on irq 19
ide1 at 0xe4a5b000-0xe4a5b007,0xe4a5b160 on irq 20
hda: Enabling Ultra DMA 4
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c584526
hda: 58605120 sectors (30006 MB) w/1806KiB Cache, CHS=58140/16/63, (U)DMA
hdc: Enabling MultiWord DMA 2
ide_pmac: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
ide_pmac: Set MDMA timing for mode 2, reg: 0x00011b8c
hdc: ATAPI 24X DVD-ROM drive, 512kB Cache, (U)DMA
Uniform CD-ROM driver Revision: 3.12
ide-floppy driver 0.97.sv
Partition check:
 /dev/ide/host0/bus0/target0/lun0:<4>ide_pmac_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide_pmac_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide_pmac_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide_pmac_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
hda: DMA disabled
ide0: reset: success
 [mac] p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14
loop: loaded (max 8 devices)
eth0: GMAC at 00:30:65:f9:7f:7c, driver v1.5k4
Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 440M
agpgart: Detected Apple UniNorth chipset
agp: configuring for size idx: 4
agpgart: AGP aperture is 16M @ 0x0
ide-floppy driver 0.97.sv
Macintosh non-volatile memory driver v1.0
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
PCI: Enabling device 01:18.0 (0000 -> 0002)
usb-ohci.c: USB OHCI at membase 0xe1903000, IRQ 27
usb-ohci.c: usb-01:18.0, Apple Computer Inc. KeyLargo USB
adb: starting probe task...
usb.c: new USB bus registered, assigned bus number 1
hub.c: USB hub found
hub.c: 2 ports detected
PCI: Enabling device 01:19.0 (0000 -> 0002)
usb-ohci.c: USB OHCI at membase 0xe1905000, IRQ 28
usb-ohci.c: usb-01:19.0, Apple Computer Inc. KeyLargo USB (#2)
usb.c: new USB bus registered, assigned bus number 2
hub.c: USB hub found
hub.c: 2 ports detected
usb.c: registered new driver hid
hid-core.c: v1.8 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
mice: PS/2 mouse device common for all mice
NET4: Linux TCP/IP 1.0 for NET4.0
IP Protocols: ICMP, UDP, TCP, IGMP
IP: routing cache hash table of 4096 buckets, 32Kbytes
TCP: Hash tables configured (established 131072 bind 65536)
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
Detected ADB keyboard, type ANSI.
input1: ADB HID on ID 2:2.c3
input2: ADB HID on ID 7:7.1f
ADB mouse at 3, handler set to 4 (trackpad)
input3: ADB HID on ID 3:3.01
adb: finished probe task...
EXT2-fs warning: feature flags set on rev 0 fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 276k init 8k chrp 36k prep
Adding Swap: 131064k swap-space (priority -1)
i2c-core.o: i2c core module
dmasound_pmac: Awacs/Screamer Codec Mfct: 1 Rev 3
dmasound_pmac: found Keylargo rev 2 or later - H/W byte-swap disabled
PowerMac Screamer  DMA sound driver rev 016 installed
Core driver edition 01.06 : PowerMac Built-in Sound driver edition 00.06
Write will use    4 fragments of   32768 bytes as default
Read  will use    4 fragments of   32768 bytes as default
hfs_fs: WARNING: mounting unclean filesystem.
hfs_fs: WARNING: mounting unclean filesystem.
hermes.c: 3 Oct 2001 David Gibson <hermes@gibson.dropbear.id.au>
orinoco.c 0.08a (David Gibson <hermes@gibson.dropbear.id.au> and others)
airport.c 0.06f (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
eth1: Station identity 001f:0001:0007:001c
eth1: Looks like a Lucent/Agere firmware version 7.28
eth1: Ad-hoc demo mode supported.
eth1: IEEE standard IBSS ad-hoc mode supported.
eth1: WEP supported, "128"-bit key.
eth1: MAC address 00:30:65:00:EE:AC
eth1: Station name "HERMES I"
eth1: Allowed channels mask: 0x00001fff
eth1: ready
airport: card registered for interface eth1
hub.c: USB new device connect on bus1/1, assigned device number 2
input4: USB HID v0.01 Mouse [Microsoft Microsoft IntelliMouse ® with IntelliEye] on usb1:2.0
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
usb-ohci.c: USB suspend: usb-01:18.0
usb-ohci.c: USB suspend: usb-01:19.0
eth1: Airport entering sleep mode
VFS: Disk change detected on device ide1(22,0)
hdc: Enabling MultiWord DMA 2
ide_pmac: MDMA, cycleTime: 120, accessTime: 90, recTime: 30
ide_pmac: Set MDMA timing for mode 2, reg: 0x00011b8c
eth1: Airport waking up
usb-ohci.c: USB continue: usb-01:18.0 from host wakeup
usb-ohci.c: USB continue: usb-01:19.0 from host wakeup
adb: starting probe task...
adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
ADB keyboard at 2, handler 1
ADB mouse at 3, handler set to 4 (trackpad)
adb: finished probe task...
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
NETDEV WATCHDOG: eth1: transmit timed out
eth1: Tx timeout! Resetting card.
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
hda: Enabling Ultra DMA 4
ide_pmac: Set UDMA timing for mode 4, reg: 0x0c584526
ide_pmac_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide_pmac_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide_pmac_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
ide_pmac_dmaproc: chipset supported ide_dma_lostirq func only: 13
hda: lost interrupt
hda: dma_intr: status=0x58 { DriveReady SeekComplete DataRequest }
hda: DMA disabled
ide0: reset: success

--------------020305090209080006070303--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
