Date: Tue, 5 Nov 2002 11:16:08 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gabriel Paubert <paubert@iram.es>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: IDE on LongTrail
In-Reply-To: <3DC79768.107@iram.es>
Message-ID: <Pine.GSO.4.21.0211051111270.27681-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 5 Nov 2002, Gabriel Paubert wrote:
> Geert Uytterhoeven wrote:
> > Anyone using a LongTrail with IDE devices?
> >
> > I just tried adding an IDE disk to mine. The disk is identified correctly, but
> > I always get `hda: lost interrupt' for any other operation. According to lspci
> > the sl82c105 uses IRQ 32 (OpenPIC), but /proc/interrupt shows no interrupts
> > coming in there.
> >
> > However, if I hardcode the IRQ to be 14 in drivers/ide/sl82c105.c, IDE works
> > fine (and is even reasonably fast: when using DMA, I get ca. 17 MB from a new
> > low-end 5400 RPM disk, about the same as the old expensive U2W Viking II on the
> > Sym53c875).
> >
> > Apparently other PPC platforms with a Winbond 83C553 (e.g. PowerPlus and PReP)
> > have some fixup code to disable legacy IRQ mode and route the IDE interrupt to
> > IRQ 14. But wouldn't it be better to route it directly to the OpenPIC, like the
> > PCI config space indicates? Guess I'll have to dive in the 83C553 docs...
> >
>
> AFAIR, the 83C553 IDE interrupts documentation is muddy at best. To be
> able to route directly to OpenPIC you would have to be able to connect
> interrupt outputs from the 83C553 to the OpenPIC. The only hint that it
> may be possible in the 83C553 documentation is that pins IRQC/IRQD are
> documented as Input/OD (open drain outputs), while IRQA/IRQB are shown
> as inputs only.
>
> However to use this it would be necessary to have a connection from the
> IRQC/IRQD to some OpenPIC inputs, which I believe is very unlikely. In
> practice, you will have to go through the 8259 cascade. AFAIU the
> datasheet and barring typos, native mode will use IRQ14/IRQ15, while
> legacy mode gives you more choices. Look strange, but hey, it's based
> on PC's so called architecture, so it's baroque by definition ;-)

According to the IBM LongTrail schematics, PINT[CD] on the W83C553 are
connected to EXT_INT[56] on the Apple Hydra, which are OpenPIC inputs.
The connections are called `IDE_NM_INT_P/S' and 'IDE_NM_INT_S'. So it should be
possible, unless Tatung changed that.

Will do some more W83C553 doc parsing soon :-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
