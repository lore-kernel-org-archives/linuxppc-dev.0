Date: Sun, 18 Jun 2000 17:23:21 -0400 (EDT)
From: "Peter R. Wood" <pwood@gordon.edu>
To: rio500-devel@sourceforge.net
cc: linux-usb@suse.com, linuxppc-dev@lists.linuxppc.org, mlan@cpu.lu
Subject: Rio 500 / UHCI / PowerPC
Message-ID: <Pine.LNX.4.21.0006181710520.726-100000@dyn-133-196.gordon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi all,

In my continuing saga of getting a UHCI card to work on my powerpc
machine...

I've just compiled and tried out the 2.4.0-test1-ac18 kernel. It's working
great when I use the OHCI card with the Diamond Rio... and actually it
seems that things are getting a bit better with the UHCI card. However
there are still some problems.  When booting up, I get some kernel
messages:

usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.232 $ time 17:00:43 Jun 18 2000
usb-uhci.c: High bandwidth mode enabled
PCI: Enabling device 00:0e.0 (0094 -> 0095)
usb-uhci.c: USB UHCI at I/O 0x1000, IRQ 24
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb-uhci.c: interrupt, status 30, frame# 0
usb.c: USB new device connect, assigned device number 1
usb.c: kmalloc IF c02b6320, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: 1000
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: ganged power switching
hub.c: standalone hub
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port 1 is removable
hub.c: port 2 is removable
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c02b6320

lspci -vv tells me this about the card:

00:0e.0 USB Controller: VIA Technologies, Inc. VT82C586B USB (rev
04) (prog-if 00 [UHCI])
	Subsystem: Unknown device 0925:1234
	Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV+ VGASnoop-
ParErr- Stepping+ SERR- FastB2B-
	Status: Cap- 66Mhz- UDF- FastB2B- ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR+ <PERR-
	Latency: 32, cache line size 08
	Interrupt: pin A routed to IRQ 24
	Region 4: I/O ports at 1000 [size=32]

This time it appears that I/O space is enabled... which is a step forward
from the drivers that were in 2.2.16. Also, when I switch on the Rio, it
does seem to respond to the device's activation. But not in the way I'd
like...:

hub.c: port 2 connection change
hub.c: portstatus 101, change 1, 12 Mb/s
hub.c: portstatus 103, change 0, 12 Mb/s
usb.c: USB new device connect, assigned device number 2
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address (error=-110)
usb.c: USB new device connect, assigned device number -1
usb_control/bulk_msg: timeout
usb.c: USB device not accepting new address (error=-110)
usb.c: USB disconnect on device -1
hub.c: hub: disabling port 2

And if I plug the USB cable into the other port, it does the same thing,
only to port 1 instead of 2.

running rio_stat produces the same message as before: that the device or
resource is busy.
--
Peter R. Wood				pwood@gordon.edu
Gordon College				http://www.cs.gordon.edu/~pwood/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
