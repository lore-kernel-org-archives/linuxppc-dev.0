Subject: Re: Pegasos 2 support patch ...
From: Adrian Cox <adrian@humboldt.co.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Sven Luther <sven.luther@wanadoo.fr>,
	Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.58.0407010958050.9322@waterleaf.sonytel.be>
References: <20040629165029.GA13468@pegasos>
	 <1088587090.28598.3.camel@localhost> <20040630155027.GA27912@pegasos>
	 <1088611966.28598.52.camel@localhost> <20040630162323.GA28483@pegasos>
	 <1088613575.28598.59.camel@localhost> <20040630185231.GA29878@pegasos>
	 <1088622301.28598.68.camel@localhost> <20040630193812.GA30391@pegasos>
	 <Pine.GSO.4.58.0407010958050.9322@waterleaf.sonytel.be>
Content-Type: text/plain
Message-Id: <1088671372.28598.86.camel@localhost>
Mime-Version: 1.0
Date: Thu, 01 Jul 2004 09:42:52 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2004-07-01 at 08:59, Geert Uytterhoeven wrote:
> On Wed, 30 Jun 2004, Sven Luther wrote:
> > On Wed, Jun 30, 2004 at 08:05:01PM +0100, Adrian Cox wrote:

> > Ah, ok, so this is just another x86-bug, and there should really be no
> > major problem in rectifying it, and all the code should already be in
> > setup-pci.c. We just need to find some way to detect that we are also in
> > this case. Could this not be probed somehow ? In which case are the irq
> > numbers the same ? Only when the via driver is on a stansalone pci card ?

The via 686 can't go on a standalone pci card, as it's a complete
southbridge.

> > > What I'm looking for is a tidy way of achieving the same result on a
> > > platform where the boot firmware did not put the via ide controller at
> > > the legacy addresses.
> >
> > Ok, the main point would be to fins the tidy way for doing this.
>
> Cfr. the code in longtrail_pcibios_fixup() and briq_pcibios_fixup() for the
> SL82C105 IDE interface, which is left in legacy mode by Open Firmware?

Which tree are those boards in?

There's a similar fixup in pplus.c in 2.6.7, but I don't like the way
IDE works on PowerPC currently. The ppc_ide_md structure and the fixups
are being used to fool the core ide code into behaving in a specific
way. The core ide code makes no guarantees that these tricks will
continue to work, and in my case the necessary tricks changed between
2.4 and 2.6. The only platform specific knowledge required for the Via
686 is the mapping between the internal i8259 interrupt number and the
linux interrupt number.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
