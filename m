Message-ID: <38C208F3.FD613B63@ncal.verio.com>
Date: Sat, 04 Mar 2000 23:12:51 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: More Powerbook 2000 (Pismo) data
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Here's another kmsg dump and some /proc output. This time I tried
Benjamin Herrenschmidt's 2.2.15pre3 with the debug parm, so there
is some more data from the USB probes. There is a 4-btn Logitech
MM Wheel on Port 2 (USB0) along with the USB kybd on Port 1 (USB1)
this time and I attempted to enable eth0 from the installer before
breaking out.

The attempt to read the PHY registers is returning f's, is this
more likely to be a PCI bridge address translation problem or
misidentified chip?

I'd like to setup a x86 cross-compile environment to build kernels with
more debugging messages. Does anyone know of any current precompiled
packages on the net that'd save me some time?

Michael Schmitz pointed out an interesting discrepancy in the
previous set of kmsgs:

<4>pmac_ide: enabling IDE bus ID 2
<4>pmac_ide: enabling IDE bus ID 1


Looking at ide-pmac.c, AAPL,bus-id 1 is assumed to be the media bay and
APPL,bus-id 2 has the comment "This one exists only for KL, I don't know
about any enable bit" and is reset but not enabled. The above messages
are
logged from the same function with the same AAPL,bus-id number and no
+1.

That would seem to explain the lack of any attempt to probe the DVD-ROM
and I wonder if the media bay enables may have something to do with
interrupts being disabled? Or perhaps the hard disk is on AAPL,bus-id 2
and
it's not being enabled is why interrupts are disabled? Could the PB2K
require n-1 or a 1-n adjustment be applied to the probed bus-id's?

Henry

                   -------------------------------

First the kmsg's:

<6>device tree used 3054760 bytes
<4>Total memory = 256MB; using 1024kB for hash table (at c0600000)
<4>Linux version 2.2.15pre3 (benh@sawtooth.wanadoo.fr) (gcc version
2.95.2 19991024 (release/franzo)) #3 Sat Jan 29 18:02:45 CET 2000
<6>PCI bus 0 controlled by pci at f0000000
<6>PCI buses 0..1 controlled by pci at f2000000
<6>PCI bus 0 controlled by pci at f4000000
<6>Registered 1 feature controller(s)
<6>PMU driver initialized for Core99 (iBook/iMac/G4)
<4>PowerMac using OpenPIC irq controller
<4>OpenPIC Version 1.2 (4 CPUs and 64 IRQ sources) at 80040000
<6>via_calibrate_decr: decrementer_count = 249665 (1497995 ticks)
<4>ide_setup: hda=noautotune
<4>Console: colour dummy device 80x25
<4>Calibrating delay loop... 996.15 BogoMIPS
<4>Memory: 252832k available (1460k kernel code, 4796k data, 152k init)
[c0000000,d0000000]
<4>Dentry hash table entries: 32768 (order 6, 256k)
<4>Buffer cache hash table entries: 262144 (order 8, 1024k)
<4>Page cache hash table entries: 65536 (order 6, 256k)
<4>POSIX conformance testing by UNIFIX
<4>PCI: Probing PCI hardware
<7>adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
<6>media bay 0 contains a floppy disk drive
<6>Registered 1 media-bay(s)
<6>Linux NET4.0 for Linux 2.2
<6>Based upon Swansea University Computer Society NET3.039
<6>NET4: Unix domain sockets 1.0 for Linux NET4.0.
<6>NET4: Linux TCP/IP 1.0 for NET4.0
<6>IP Protocols: ICMP, UDP, TCP, IGMP
<4>TCP: Hash tables configured (ehash 262144 bhash 65536)
<6>NET4: AppleTalk 0.18 for Linux NET4.0
<4>Starting kswapd v 1.5
<6>OHCI USB Driver loading
<7>usb-ohci: 2 root hub ports found
<7>usb-ohci: 2 root hub ports found
<4>usbcore: Registered new driver mouse
<6>USB HID boot protocol mouse driver registered.
<4>usbcore: Registered new driver keyboard
<4>usbcore: Registered new driver hub
<6>Using unsupported 1024x768 MacOS display at a6008000, depth=32,
pitch=4096
<4>Console: switching to colour frame buffer device 128x48
<4>fb0: Open Firmware frame buffer device on MacOS display
<4>ADB keyboard at 2, handler 1
<4>ADB mouse at 3, handler set to 4 (trackpad)
<4>PowerMac Z8530 serial driver version 2.0
<4>tty00 at 0x80013020 (irq = 22) is a Z8530 ESCC (cobalt modem)
<4>tty01 at 0x80013000 (irq = 23) is a Z8530 ESCC (powerbook IR)
<4>pty: 256 Unix98 ptys configured
<6>Macintosh ADB mouse driver installed.
<6>Macintosh non-volatile memory driver v1.0
<4>RAM disk driver initialized:  16 RAM disks of 8192K size
<6>loop: registered device at major 7
<4>pmac_ide: enabling IDE bus ID 2
<4>pmac_ide: enabling IDE bus ID 1
<4>hda: TOSHIBA MK1214GAP, ATA DISK drive
<4>ide0 at 0x8e01f000-0x8e01f007,0x8e01f160 on irq 19
<6>hda: TOSHIBA MK1214GAP, 11513MB w/0kB Cache, CHS=23392/16/63
<4>scsi : 0 hosts.
<4>scsi : detected total.
<6>PPP: version 2.3.7 (demand dialling)
<6>TCP compression code copyright 1989 Regents of the University of
California
<6>PPP line discipline registered.
<6>eth0: GMAC at 00:30:65:4c:a8:58
<4>Partition check:
<4> hda:<7>ohci-control thread code for 0xc05ab0e0 code at 0xc0167d18
<4>New USB bus registered, assigned bus number 1
<7>ohci-control thread code for 0xc05ab020 code at 0xc0167d18
<4>New USB bus registered, assigned bus number 2
<7>usb-ohci: HC c05ab0e0 reset.
<7>usb-ohci: HC c05ab020 reset.
<6>usb-ohci: host controller operational
<6>usb-ohci: host controller operational
<6>USB new device connect, assigned device number 1
<6>USB new device connect, assigned device number 1
<7>Failed control msg - r:06 rt:80 v:0100 i:0000 s:0008 - ret: -101
<7>  80 06 00 01 00 00 08 00
<7>Failed control msg - r:06 rt:80 v:0100 i:0000 s:0008 - ret: -101
<7>  80 06 00 01 00 00 08 00
<7>Failed control msg - r:06 rt:80 v:0100 i:0000 s:0008 - ret: -101
<7>  80 06 00 01 00 00 08 00
<7>Failed control msg - r:06 rt:80 v:0100 i:0000 s:0008 - ret: -101
<7>  80 06 00 01 00 00 08 00
<6>Manufacturer:
<7>Failed control msg - r:06 rt:80 v:0100 i:0000 s:0008 - ret: -101
<7>  80 06 00 01 00 00 08 00
<3>usbcore: USB device not responding, giving up (error=-101)
<7>ohci-control thread sleeping
<6>Product:
<6>SerialNumber:
<6>USB hub found
<6>hub: 3 ports detected
<6>hub: ganged power switching
<6>hub: standalone hub
<6>hub: global over-current protection
<6>hub: power on to power good time: 44ms
<6>hub: hub controller current requirement: 100mA
<6>hub:  port 1 is not removable
<6>hub:  port 2 is removable
<6>hub:  port 3 is removable
<6>hub: local power source is good
<6>hub: no over-current condition exists
<6>hub: enabling power on all ports
<7>usb: usb-bandwidth-alloc: was: 0, new: 11, bustime = 11 us, Pipe
allowed: yes<7>usb: bw_alloc bumped to 11 for 1 requesters
<7>usbcore: hub driver claimed interface c09a6c60
<7>ohci-control thread sleeping
<6>hub: port 1 connection change
<6>USB new device connect, assigned device number 2
<6>usb: skipped 1 class/vendor specific interface descriptors
<6>Manufacturer:
<6>Product:
<6>SerialNumber:
<6>USB HID boot protocol keyboard detected.
<7>usb: usb-bandwidth-alloc: was: 11, new: 28, bustime = 17 us, Pipe
allowed: ye
<7>usb: bw_alloc bumped to 28 for 2 requesters
<7>usbcore: keyboard driver claimed interface c09a6da0
<6>hub: port 1 reset change
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4> hda1hda: lost interrupt
<4>hda: lost interrupt
<7>usb: bw_alloc bumped to 28 for 2 requesters
<7>usbcore: keyboard driver claimed interface c09a6da0
<6>hub: port 1 reset change
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4>hda: lost interrupt
<4> hda1hda: lost interrupt
<4>hda: lost interrupt
<4> hda2 hda3hda: lost interrupt
<4>hda: lost interrupt
<4> hda4 hda5hda: lost interrupt
<4>hda: lost interrupt
<4> hda6 hda7hda: lost interrupt
<4>hda: lost interrupt
<4> hda8 hda9hda: lost interrupt
<4>hda: lost interrupt
<4> hda10 hda11hda: lost interrupt
<4>hda: lost interrupt
<4> hda12 hda13hda: lost interrupt
<4>hda: lost interrupt
<4> hda14 hda15hda: lost interrupt
<4>hda: lost interrupt
<4> hda16 hda17
<5>RAMDISK: Compressed image found at block 0
<4>EXT2-fs warning: maximal mount count reached, running e2fsck is
recommended
<4>VFS: Mounted root (ext2 filesystem).
<4>Freeing unused kernel memory: 152k init 32k prep
<3>GMAC: unknown PHY type ffff
<4>PHY regs:
<4>ffff ffff ffff ffff
<4>ffff ffff ffff ffff
<4>ffff ffff ffff ffff
<4>ffff ffff ffff ffff
<4>ffff ffff ffff ffff
<4>ffff ffff ffff ffff
<4>ffff ffff ffff ffff
<4>ffff ffff ffff ffff
<4>mii_interrupt, phy_status: ffff
<6>cat uses obsolete /proc/pci interface


/proc/interrupts

           CPU0
 19:          0   OpenPIC       ide0
 22:          0   OpenPIC       SCC
 23:          0   OpenPIC       SCC
 25:          0   OpenPIC       VIA-PMU
 27:          0   OpenPIC       usb-ohci
 28:    6795416   OpenPIC       usb-ohci
 41:          0   OpenPIC       GMAC
 47:          0   OpenPIC       GPIO1/ADB
BAD:  396334560


/proc/devicesCharacter devices:

  1 mem
  2 pty
  3 ttyp
  4 ttyS
  5 cua
  7 vcs
 10 misc
 14 sound
 29 fb
 56 adb
128 ptm
136 pts
180 usb

Block devices:
  1 ramdisk
  3 ide0
  7 loop

/proc/pci

PCI devices found:
  Bus  0, device  11, function  0:
    Host bridge: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=20.
      Medium devsel.  Master Capable.  Latency=16.
  Bus  0, device  14, function  0:
    FireWire (IEEE 1394): Apple Unknown device (rev 1).
      Vendor id=106b. Device id=18.
      Medium devsel.  IRQ 40.  Master Capable.  Latency=16.  Min
Gnt=3.Max Lat=4
      Non-prefetchable 32 bit memory at 0xf5000000 [0xf5000000].
  Bus  0, device  15, function  0:
    Ethernet controller: Apple Unknown device (rev 1).
      Vendor id=106b. Device id=21.
      Slow devsel.  Fast back-to-back capable.  IRQ 41.  Master
Capable.  Latency=16.  Min Gnt=64.Max Lat=64.
      Non-prefetchable 32 bit memory at 0xf5200000 [0xf5200000].
  Bus  0, device  16, function  0:
    VGA compatible controller: ATI Unknown device (rev 2).
      Vendor id=1002. Device id=4c46.
      Medium devsel.  Fast back-to-back capable.  IRQ 48.  Master
Capable.  Latency=255.  Min Gnt=8.
      Prefetchable 32 bit memory at 0xa4000000 [0xa4000008].
      I/O at 0x400 [0x401].
      Non-prefetchable 32 bit memory at 0xa0000000 [0xa0000000].
  Bus  0, device  23, function  0:
    Hot Swap Controller: Apple Unknown device (rev 2).
      Vendor id=106b. Device id=22.
      Medium devsel.  Master Capable.  Latency=16.
      Non-prefetchable 32 bit memory at 0x80000000 [0x80000000].
  Bus  0, device  24, function  0:
    USB Controller: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=19.
      Medium devsel.  IRQ 27.  Master Capable.  Latency=16.  Min
Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x80082000 [0x80082000].
  Bus  0, device  25, function  0:
    USB Controller: Apple Unknown device (rev 0).
      Vendor id=106b. Device id=19.
      Medium devsel.  IRQ 28.  Master Capable.  Latency=16.  Min
Gnt=3.Max Lat=86.
      Non-prefetchable 32 bit memory at 0x80081000 [0x80081000].
  Bus  0, device  26, function  0:
    CardBus bridge: Texas Instruments Unknown device (rev 0).
      Vendor id=104c. Device id=ac1e.
      Medium devsel.  IRQ 58.  Master Capable.  Latency=16.  Min
Gnt=64.Max Lat=4.
      Non-prefetchable 32 bit memory at 0x80080000 [0x80080000].

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
