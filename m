Date: Thu, 1 Jul 2004 09:59:17 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Adrian Cox <adrian@humboldt.co.uk>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Pegasos 2 support patch ...
In-Reply-To: <20040630193812.GA30391@pegasos>
Message-ID: <Pine.GSO.4.58.0407010958050.9322@waterleaf.sonytel.be>
References: <20040629165029.GA13468@pegasos> <1088587090.28598.3.camel@localhost>
 <20040630155027.GA27912@pegasos> <1088611966.28598.52.camel@localhost>
 <20040630162323.GA28483@pegasos> <1088613575.28598.59.camel@localhost>
 <20040630185231.GA29878@pegasos> <1088622301.28598.68.camel@localhost>
 <20040630193812.GA30391@pegasos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 30 Jun 2004, Sven Luther wrote:
> On Wed, Jun 30, 2004 at 08:05:01PM +0100, Adrian Cox wrote:
> > On Wed, 2004-06-30 at 19:52, Sven Luther wrote:
> > > On Wed, Jun 30, 2004 at 05:39:35PM +0100, Adrian Cox wrote:
> > > > The problem is that the via686 ide is hardwired to irqs 14 and 15 of the
> > > > i8259 interrupt controller internally, but the kernel believes that only
> > > > IDE controllers at the legacy address can have separate irqs for each
> > > > channel.
> > >
> > > Is this the case for each via ide controller ? If so why does it work on
> > > x86 ?
> >
> > Because on x86 the BIOS places the IDE controller at the legacy
> > addresses (0x1f0, 0x170), and then setup-pci.c spots that the via ide
> > controller is also the legacy IDE controller, and thus uses the legacy
> > irq numbers 14 and 15.
>
> Ah, ok, so this is just another x86-bug, and there should really be no
> major problem in rectifying it, and all the code should already be in
> setup-pci.c. We just need to find some way to detect that we are also in
> this case. Could this not be probed somehow ? In which case are the irq
> numbers the same ? Only when the via driver is on a stansalone pci card ?
>
> > What I'm looking for is a tidy way of achieving the same result on a
> > platform where the boot firmware did not put the via ide controller at
> > the legacy addresses.
>
> Ok, the main point would be to fins the tidy way for doing this.

Cfr. the code in longtrail_pcibios_fixup() and briq_pcibios_fixup() for the
SL82C105 IDE interface, which is left in legacy mode by Open Firmware?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
