Date: Wed, 7 Nov 2001 22:22:42 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>,
	Sven.Dickert@planb.de, davidm@amberdata.demon.co.uk,
	hollis@austin.ibm.com, Gabriel Paubert <paubert@iram.es>
Subject: Re: RFC: i8259.c cleanup
In-Reply-To: <0111072113.AA06255@ivan.Harhan.ORG>
Message-ID: <Pine.GSO.4.21.0111072219060.10862-100000@mullein.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 7 Nov 2001, Michael Sokolov wrote:
> Gabriel Paubert <paubert@iram.es> wrote:
> > The address is not always 0xbffffff0, it is bridge dependent. However this
> > address is normally found in OF device tree, in residual data and as a
> > last resort could be made host bridge dependent. It has to be ioremapped
> > anyway...
>
> OF device tree, residual data, etc. all assume PREP/CHRP/PMAC mentality. There
> are also other PPC boards supported in the tree. Those embody all machine
> knowledge in the board port. They already have to have full knowledge of every
> chip on the board, including the host bridge.

That address is passed by board-specific code to the generic OpenPIC code
during OpenPIC initialization.

> > I actually wonder
> > whether it would be better to split it in two cases:
> >
> > - 8259 is the only interrupt controller in the system
> >
> > - 8259 is cascaded interrupt controller on an openpic
>
> These are not the only possibilities. Adirondack, for example, has the PC-style
> 8259 pair cascaded to the Adirondack interrupt controller (completely original
> design), which drives the INT# lines to the two CPUs.

So s/an openpic/another interrupt controller/.

There's no single reason why you can't pass a magic interrupt acknowledge
address to the initialization code for the Adirondack interrupt controller.

Well, this assumes you have generic `building block' interrupt controller code
that can be cascaded arbitrarily by board-specific code.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
