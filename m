Message-ID: <005201c387d0$dafdcf80$6401a8c0@sazabimobile>
From: "Shih-Ying Chou" <sschou@mtu.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Question about IBM405 and IRQ
Date: Wed, 1 Oct 2003 00:02:38 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
    I am using EP405 board which has the ibm405gp processor.  I am using
kernel version 2.4.23-pre5.  I used the PC/104 on the EP405 to connect to a
PCI adapter.  Then I plug in a USB card in the PCI slot, but I can't seems
to get the kernel to get the interrupt from USB card.  But when booting up
the log shows that the PCI and the USB gets the IRQ.   I have all the
necessary driver compile in the kernel.

host/usb-ohci.c: USB OHCI at membase 0xc3007000, IRQ 25
host/usb-ohci.c: usb-00:0a.0, NEC Corporation USB
usb.c: new USB bus registered, assigned bus number 1

    I have modified the arch/ppc/platform/ep405.c file's ep405_devtable
structure to make the kernel get the irq for the pci.  But after I plug in
the USB device into the USB card, the following error appear.

usb_control/bulk_msg: timeout
host/usb-ohci.c: unlink URB timeout
usb.c: USB device not accepting new address=2 (error=-110)

>From the FAQ in Linux-USB it says that it is something wrong with the BIOS.
But since it is an Embedded System, I check with the Board Register for the
EP405 board.  But I can't seem to get the right register.

    Can anyone help me?

Thank you !

Shih-Ying Chou

The following is the /proc/pci

PCI devices found:
  Bus  0, device  10, function  0:
    USB Controller: NEC Corporation USB (rev 65).
       IRQ 25
      Master Capable.  Latency=128.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0xbffff000 [0xbfffffff].
  Bus  0, device  10, function  1:
    USB Controller: NEC Corporation USB (#2) (rev 65).
      IRQ 25
      Master Capable.  Latency=128.  Min Gnt=1.Max Lat=42.
      Non-prefetchable 32 bit memory at 0xbfffe000 [0xbfffefff].
  Bus  0, device  10, function  2:
    USB Controller: NEC Corporation USB 2.0 (rev 2).
      IRQ 25
      Master Capable.  Latency=128.  Min Gnt=16.Max Lat=34.
      Non-prefetchable 32 bit memory at 0xbfffdf00 [0xbfffdfff].

The following is the /proc/interrupt
           CPU0
  0:        263  IBM UIC Level     serial
  9:          0  IBM UIC Level     OCP EMAC Wakeup
 10:          0  IBM UIC Level     MAL SERR
 11:        915  IBM UIC Level     MAL TX EOB
 12:       1891  IBM UIC Level     MAL RX EOB
 13:          0  IBM UIC Level     MAL TX DE
 14:          0  IBM UIC Level     MAL RX DE
 15:          0  IBM UIC Level     OCP EMAC MAC
 25:          0  IBM UIC Level     usb-ohci, usb-ohci
BAD:          0


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
