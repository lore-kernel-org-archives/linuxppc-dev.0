Message-ID: <001601c37d51$019c2860$6401a8c0@sazabimobile>
From: "Shih-Ying Chou" <sschou@mtu.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: EP405 and PCI and irq problem
Date: Wed, 17 Sep 2003 15:22:16 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All,
    Currently, I am using Embedded Planet's EP405 development board.  I
would like to use a USB device with it, but there is no USB connection on
the EP405 board.  So I connect a PCI to PC104-plus adapter to the EP405,
then connnect a PCI to USB 2.0 card.  But right now the USB driver is
complain about it can't not get a irq.

    I have tried to move the jumper on the adapter to different setting, but
there is no use.  Also, I have changed the register on the EP405 board to
the appropriate setting, like enable local PCI IRQ controller and changed
the PCI  (INTA compliment) to enable.  But it still not working.

    Have anyone does anything similar to this or can give me hint or
pointer?  I am running out of idea.

The following is the info and the bootup log

kernel version : 2.4.22 download from http://penguinppc.org/
USB 2.0 board is using VIA chipset
the PCI to PC104-plus adapter is Sensoray's Model 328.

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
hcd.c: Found HC with no IRQ.  Check BIOS/PCI 00:0a.2 setup!
host/usb-uhci.c: $Revision: 1.275 $ time 18:49:57 Sep 16 2003
host/usb-uhci.c: High bandwidth mode enabled
host/usb-uhci.c: v1.275:USB Universal Host Controller Interface driver
host/usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS
settings!
host/usb-ohci.c: found OHCI device with no IRQ assigned. check BIOS
settings!
usb.c: registered new driver hiddev
usb.c: registered new driver hid
hid-core.c: v1.8.1 Andreas Gal, Vojtech Pavlik <vojtech@suse.cz>
hid-core.c: USB HID support drivers
Initializing USB Mass Storage driver...
usb.c: registered new driver usb-storage
USB Mass Storage support registered.

The following is the info I got from /proc after it boots up.

PCI devices found:
  Bus  0, device  10, function  0:
    USB Controller: NEC Corporation USB (rev 65).
      Master Capable.  Latency=128.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0xbffff000 [0xbfffffff].
  Bus  0, device  10, function  1:
    USB Controller: NEC Corporation USB (#2) (rev 65).
      Master Capable.  Latency=128.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0xbfffe000 [0xbfffefff].
  Bus  0, device  10, function  2:
    USB Controller: NEC Corporation USB 2.0 (rev 2).
      Master Capable.  Latency=128.  Min Gnt=16.Max Lat=34.
      Non-prefetchable 32 bit memory at 0xbfffdf00 [0xbfffdfff].

and the following is the info I get after I mount the usbfs and look at the
driver file
         usbdevfs
         hub
 96-111: hiddev
         hid
         usb-storage

Thank you very much

Shih-Ying Chou


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
