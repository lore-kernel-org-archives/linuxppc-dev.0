Date: Thu, 28 Sep 2000 19:55:41 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display!
In-Reply-To: <19340822140413.1794@192.168.1.10>
Message-ID: <Pine.LNX.4.10.10009281947100.3421-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >Instead of walking the whole device tree, I hope to get away with just
> >picking a free area (assuming pci_dev->base_address[i] == 0 means free)
> >instead. But I won't get to it before the weekend. If BenH implements a
> >cleaner way, the better.
>
> Well, since this concerns only one machine, in a given configuration, I
> beleive it's safe to just hard-code a new mappping we know won't conflict.

It at least concerns Wallstreet and Lombard (Pismo has a r128?). Hardcode
and double check it's free, that be it then.

> How does OF sets up the mapping of the ATI on the Lombard ? Maybe we can
> just stuff that in some fixup routine for the wallstreet...

Broken (VRAM included both LE and BE aperture, and MMIO overlaps the end
of the LE aperture (where MMIO actually shows up even without the
separate mapping. I know nothing about decoding priorities though).

atyfb (and, by extension, the fbdev driver _and_ the ati driver with
UseFBDev) use the MMIO alias at the end of the BE aperture (which is why
we reserve that four k segment to prevent it from being used for
framebuffer).

Sketch:

V -- free --- | VRAM LE ........... (MMIO) | VRAM BE ........... (MMIO) |

M                                 |  MMIO  |

V = PCI BAR 0 for VRAM, M = PCI BAR 2 for MMIO (not in the OF device
tree) IIRC. BAR 1 is the IO mapping.

Can't give you the exact addresses off the cuff, but I've described it
here before a week or two after the 4.01 release.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
