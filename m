Message-ID: <3AB8995B.F411CEF6@vienna.at>
Date: Wed, 21 Mar 2001 13:06:51 +0100
From: Roman Weissgaerber <weissg@vienna.at>
Reply-To: weissg@vienna.at
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re:More USB questions (for the MPC8xx)
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Low Speed devices (Mouse) does not work on the root hub. They would
require another clock-rate. They may work with an external HUB.

Devices I use include: 4 port HUB (don't know the brand),
Billiton System USB10/100 Ethernet USB-Ethernet
(pegasus.c patched 2.4.2pre6 may include the right patch),
Sandisk SDDR31 Image Mate (Compactflash Reader) (USB Storage of 2.4.2).
Real transfer (Bulk transfer) will need patches of m8xxhci other than
patch1,2.

Board:
TQM850L/STK850L with MPC850DEB-50MHz Sys/48MHZ Clock4
Timer1 for SOF
Philips Tranceiver/Hardware Patch!!!!

With patch 1 and without Hardware Patch and a HUB I get:

...
m8xxhci: device found!
m8xxhci_connect_device()
m8xxhci_alloc_dev(usb_dev=c0f91600)
hub.c: USB hub found
hub.c: 4 ports detected
rx err sc (status 0x1c54)
m8xxhci: device lost
m8xxhci_disconnect_device()
hp->root_hub c0ff7560, hp->root_hub->usb c0f91600
usb.c: USB disconnect on device 1
unlink_urb(urb=c0f92910,qtype=1) status -115
unlink_urb(urb=c0f92910) done
m8xxhci_free_dev(usb_dev=c0f91600)
m8xxhci_free_dev(dev=c0f91600) done
m8xxhci: device found!
m8xxhci_connect_device()
m8xxhci_alloc_dev(usb_dev=c0f91600)
complete urb c0f92890, actual_length 0, status -1
unlink_urb(urb=c0f92890,qtype=2) status -110
unlink_urb(urb=c0f92890) done
complete urb c0f92890, actual_length 0, status -1
unlink_urb(urb=c0f92890,qtype=2) status -110
unlink_urb(urb=c0f92890) done
hub.c: USB hub found
hub.c: 4 ports detected
INIT: version 2.77 booting
rx err sc (status 0x1c54)
----------

with Hardware Patch and Patch 1 I get:
...
m8xxhci: device found!
m8xxhci_connect_device()
m8xxhci_alloc_dev(usb_dev=c0f91600)
hub.c: USB hub found
hub.c: 4 ports detected
INIT: version 2.77 booting
INIT: Entering runlevel: 3
sh-2.03#

hope that helps

- Roman

> Hi,
>
> I managed to get the m8xxhci with the TIMER1 patch to sort of work with
> my board.
> I.e. the SOF seem to be genrated normally and there seem to be some
> traffic on
> the usb bus when I plug in keyspan_pda USB device. Althoug the
> initialization of
> the keyspan_pda fails.
> I have also tried a MS USBMouse but then the m8xxhci is totally silent
> and there
> is no traffic on the USB.
>
> What kind of USB devices have you used to plug to a MPC8xx in HIC mode?
>
> Thanks,
>
> K.D.

Hi,


Low Speed devices does not work on the root hub. They would
require another clock-rate.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
