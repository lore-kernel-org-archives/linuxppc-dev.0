Date: Wed, 16 Aug 2000 16:45:25 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Riley <oscar@the-rileys.net>
cc: tom_gall@vnet.ibm.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: PCI Buses
In-Reply-To: <3999DE0C.4EF5762F@the-rileys.net>
Message-ID: <Pine.LNX.4.10.10008161641400.576-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 15 Aug 2000, David Riley wrote:
> tom_gall@vnet.ibm.com wrote:
> > It's definately interesting to hear that AGP is really just another PCI... or at
> > least treated that way. Being PCI/AGP stupid I appreciate the info... if it's
> > just another "PCI" of sorts, doesn't that have performance implications or is
> > that addressed really by the hardware implementation as apposed to the Linux
> > side of things?
>
> It really is just another PCI (there is a 66 MHz PCI specification, and AGP uses
> it), though there are improvements made (for example, sidebanding, which gives us
> the 2x and 4x modes).  Additionally, it's adapted on the Intel side of things for
> "write combining" (if anyone comes up with an exact definition of how that works,
> please let me know).  I'm not sure what you mean by performance implications, but
> PCI isn't a horrible bus to start with...

`write combining' means that the PCI bridge will buffer successive writes to
successive addresses and combine them into one burst of writes. Since burst
writes are more efficient than individual writes (which require an address
setup operation for every write), this is a win. Of course you cannot always
use write combining (think about register writes), but for frame buffer
accesses it's nice.

BTW, if you look at the specs for the host bridge IBM used in the (dead?) POP
design, you'll see that it actually has 2 PCI buses: one at 33 MHz and one at
66 MHz. The 66 MHz can be used as an AGP bus as well, as is done in the POP
design.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
