Date: Wed, 6 Dec 2000 19:02:09 -0500
From: Jonathan Lane <jingai@shell.faradic.net>
Message-Id: <200012070002.eB7029M16485@shell.faradic.net>
To: bh40@calva.net, jingai@shell.faradic.net
Subject: Re: r128 driver still borked in XF4.0.1-9pre10
Cc: debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> It's possible that the black screen was caused by a font path issue that,
> I think, was recently fixed in XFree CVS. The PCI problems are of a
> different nature.

Nope, it was a PCI problem -- moved the card to slot 1 (bus 0) and it
works fine now... however, my second ethernet card, which now resides
in slot 5 (bus 1 card 2) now doesn't function properly...
(it *seems* to work, but ceases to function after a short while
saying "no interrupts being serviced" or something similar).

> >PS.  If it helps, it appears that the kernel is incorrectly assigning the
> >     IRQ for my video board to IRQ 1.. Looking at /proc/interrupts, I don't
> >     see that there have been any interrupts serviced for IRQ 1, so I'm
> >     assuming either it is intentionally hidden from the kernel, or is
> >     unused and may actually be used by a PCI card.. anyone care to
> >     comment on this?
>
> No, IRQ 1 may well be correct. I don't think the video driver uses it's
> interrupts in Linux.
>
> You more probably have a machine with 2 host bridges (and no PCI<->PCI
> bridge), so you can either try with Michel Lanners patches for 2.2, or try
> a recent 2.4.

Tried both 2.4.0test11 and 2.2.17 & 2.2.18pre21 w/ Michel Lanners patches;
none of them solved the problem.  I will check the 2.4 bitkeeper kernel,
though.

> Do you have 2 "bandit" chips in the device-tree ?

colour:~> cat /proc/pci
PCI devices found:
  Bus  0, device  11, function  0:
    Host bridge: Apple Bandit (rev 3).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.
  Bus  0, device  13, function  0:
    VGA compatible controller: ATI Unknown device (rev 0).
      Vendor id=1002. Device id=5245.
      Medium devsel.  Fast back-to-back capable.  IRQ 23.  Master Capable.  Latency=32.  Min Gnt=8.
      Prefetchable 32 bit memory at 0x84000000 [0x84000008].
      I/O at 0x400 [0x401].
      Non-prefetchable 32 bit memory at 0x80904000 [0x80904000].
  Bus  0, device  14, function  0:
    USB Controller: OPTi Unknown device (rev 16).
      Vendor id=1045. Device id=c861.
      Medium devsel.  Fast back-to-back capable.  IRQ 24.  Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0x80900000 [0x80900000].
  Bus  0, device  15, function  0:
    PCI bridge: DEC DC21052 (rev 1).
      Medium devsel.  Fast back-to-back capable.  Master Capable.  Latency=32.  Min Gnt=4.
  Bus  0, device  16, function  0:
    Hot Swap Controller: Apple Grand Central (rev 2).
      Medium devsel.  Master Capable.  Latency=32.
      Non-prefetchable 32 bit memory at 0xf3000000 [0xf3000000].
  Bus  1, device   2, function  0:
    Ethernet controller: 3Com Unknown device (rev 48).
      Vendor id=10b7. Device id=9200.
      Medium devsel.  IRQ 1.  Master Capable.  Latency=32.  Min Gnt=10.Max Lat=10.
      I/O at 0x1000 [0x1001].
      Non-prefetchable 32 bit memory at 0x80800000 [0x80800000].

Regards,
Jonathan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
