Date: Sat, 25 Mar 2000 14:35:30 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.LNX.4.10.10003242159010.25227-100000@opal.biophys.uni-duesseldorf.de>
Message-ID: <Pine.LNX.4.05.10003251432500.11322-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 24 Mar 2000, Michael Schmitz wrote:
> > Then X needs to be fixed, perhaps the generic X PCI code needs special
> > hooks for individual drivers to check whether the configuration is
> > acceptable or not. OTOH I don't understand why something there (OF ?)
> > insists in overlapping the registers with the VRAM, the PCI code in the
> > kernel (2.3) should give the registers a separate area, saving 4kB of MMIO
> > space is completely useless.
>
> It should but last time I tried it complained about resource conflicts.
> I've sent BenH a log of this on request.

The kernel code `should' do that, but currently it doesn't. All it does is try
to allocate the PCI resources, as they are set up by the `bootloader' (OF,
MacOS, whatever). If they conflict, you just get a warning.

The code I posted for the LongTrail does assign missing/conflicting resources.
Please adapt it for PowerMac.

And for 2.2.x: sorry, but I don't care what you do there. In theory you should
do the same thing, but then you have to `invent' all code yourself, while in
2.3.x most is already there.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
