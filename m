Date: Mon, 15 Jan 2001 18:32:09 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Iain Sandoe <iain@sandoe.co.uk>, linuxppc-dev@lists.linuxppc.org
Subject: Re: bk 2.4.1pre2 Lombard PCI allocation fails.
In-Reply-To: <Pine.LNX.4.30.0101151710020.9336-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.05.10101151830580.31039-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 15 Jan 2001, Michael Schmitz wrote:
> > as the title says...
> > The machine boots and (seems) OK.
> >
> > FWIW: I boot this machine with BootX [1.2.2] (and always have, without
> > problem, until this time).
> > PCI: Cannot allocate resource region 2 of device 00:11.0
> > PCI: Resource 80880000-80880fff (f=200, d=0, p=0)
> > PCI: Resource 00000c00-00000cff (f=101, d=1, p=1)
> > PCI: Cannot allocate resource region 1 of device 00:11.0
         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The conflict for the overlapping MMIO region.

> >   got res[10000000:10000fff] for resource 2 of ATI Technologies Inc 3D Rage
> > LT Pro

Fixed by the kernel, and reassigned to 0x10000000.

> BootX uses the MacOS PCI mappings which are bogus for the Rage LT Pro.
> Though I'm certain Geert's old PCI resource allocation patch worked fine
> in spite of this. There was some message about resource conflict but that
> was fixed by the kernel.
>
> What's the PCI resourced for the card after the kernel has finished
> booting?

I expect it to be 0x10000000.

BTW, this also means we can start using the secondary aperture as well in
2.4.0. Gives us an additional 4 kB of frame buffer on little-endian boxes.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
