From: George Staikos <staikos@kde.org>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: New TiPB - PCMCIA settings
Date: Mon, 18 Nov 2002 18:29:11 -0500
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200211181829.11725.staikos@kde.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


   After fighting for a short while, I have some settings for config.opts on
the new Ti PowerBook.  These make PCMCIA work for me anyways:

include memory 0xa0003000-0xa0ffffff
include port 0x9100-0x9fff

   Remove any other include memory/port lines to avoid oopses.

   It would really be nice if yenta_socket could be cleaned up and this stuff
could be autodetected.  the algorithm was straightforward I think:

>From /proc/iomem, find the card services region and use a suitable sized
region starting after that (assuming it is free).

>From /proc/ioports, find the PCI entry for cardbus and use the ports available
directly after the last cardbus slot for a suitable sized region.

What doesn't work right now:
- dmasound is aweful (lots of clicking and sounds bad)
- video issues in XFree86 and fbdev, along with sleeping
    - closing the screen causes lots of garbling on the screen.
- v.92 modem (hcfusb doesn't work on it)

--

George Staikos


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
