Date: Sat, 14 Oct 2000 12:21:02 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: dual head r128
In-Reply-To: <19340907150812.9049@192.168.1.10>
Message-ID: <Pine.LNX.4.10.10010141217300.570-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 13 Oct 2000, Benjamin Herrenschmidt wrote:
> >But you can fixup all pci_dev's so bus 0 takes 0x00000-0x0fffff, bus 1 takes
> >0x10000-0x1ffff, and so on. ioportremap() finds out the bus by looking at the
> >region.
> >
> >I/O space is not limited to 64 kB on non-ia32, we can use the full size of an
> >unsigned long.
> >
> >Legacy I/O mappings (`I have legacy lp0 on bus 0 and legacy lp1 on bus
> 1') can
> >be sorted out in ioportremap() as well.
>
> Ok, If I follow you correctly, that mean that if we have, for example,
> bus 1 set to 0x10000-0x1ffff, ioportremap() would return, for an address
> in this range, the address + bus_io_base - 0x10000. At least on Macs,
> AFAIK, we have only 64k or 128k of IOs available.

Right.

After that `#define inb	readb' etc. and almost all overhead is gone.

And if you want to map legacy VGA I/O to bus X, you can handle this in
ioportremap(). Since ioportremap() is called only once, the complexity there
isn't of much importance.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
