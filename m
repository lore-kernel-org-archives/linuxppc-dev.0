Date: Thu, 1 Jul 2004 10:48:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pegasos 2 support patch ...
In-Reply-To: <1088671372.28598.86.camel@localhost>
Message-ID: <Pine.GSO.4.58.0407011045550.9882@waterleaf.sonytel.be>
References: <20040629165029.GA13468@pegasos> <1088587090.28598.3.camel@localhost>
 <20040630155027.GA27912@pegasos> <1088611966.28598.52.camel@localhost>
 <20040630162323.GA28483@pegasos> <1088613575.28598.59.camel@localhost>
 <20040630185231.GA29878@pegasos> <1088622301.28598.68.camel@localhost>
 <20040630193812.GA30391@pegasos> <Pine.GSO.4.58.0407010958050.9322@waterleaf.sonytel.be>
 <1088671372.28598.86.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 1 Jul 2004, Adrian Cox wrote:
> On Thu, 2004-07-01 at 08:59, Geert Uytterhoeven wrote:
> > On Wed, 30 Jun 2004, Sven Luther wrote:
> > > On Wed, Jun 30, 2004 at 08:05:01PM +0100, Adrian Cox wrote:
> > > > What I'm looking for is a tidy way of achieving the same result on a
> > > > platform where the boot firmware did not put the via ide controller at
> > > > the legacy addresses.
> > >
> > > Ok, the main point would be to fins the tidy way for doing this.
> >
> > Cfr. the code in longtrail_pcibios_fixup() and briq_pcibios_fixup() for the
> > SL82C105 IDE interface, which is left in legacy mode by Open Firmware?
>
> Which tree are those boards in?

LongTrail support has been in the main tree since several years. But
longtrail_pcibios_fixup() may still be missing even in the PPC tree (it doesn't
seem to be in plain 2.6.7 yet). Patches floated on the list.

> There's a similar fixup in pplus.c in 2.6.7, but I don't like the way
> IDE works on PowerPC currently. The ppc_ide_md structure and the fixups
> are being used to fool the core ide code into behaving in a specific
> way. The core ide code makes no guarantees that these tricks will
> continue to work, and in my case the necessary tricks changed between
> 2.4 and 2.6. The only platform specific knowledge required for the Via
> 686 is the mapping between the internal i8259 interrupt number and the
> linux interrupt number.

And the internal i8259 interrupt number is always the same as the Linux
interrupt number to support legacy code, right?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
