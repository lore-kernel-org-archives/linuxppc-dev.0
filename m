Date: Fri, 24 Aug 2001 16:03:21 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: status of linuxppc_2_4_devel for ppc405gp
Message-ID: <20010824160321.B1324@zax>
References: <20010823074100.31846@smtp.wanadoo.fr> <20010823110818.2847@smtp.adsl.oleane.com> <20010824114153.A790@zax> <3B85E0D2.21BC306E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B85E0D2.21BC306E@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 24, 2001 at 01:06:26AM -0400, Dan Malek wrote:
>
> David Gibson wrote:
> to break.
> >
> > Ah yes, I ran into that one when I started converting the ppc405_enet
> > driver to use ioremap() and in_beXX() instead of the godawful mess of
> > direct access and explicit eieio()s it uses now.
>
> Umm....what are you doing?  Those registers are already mapped via
> ioremap(), so that isn't necessary.  What you consider a "godawful mess"
> is a personal preference, and I prefer the programming style that
> currently exists.  I don't have any love for the driver, but it
> certainly isn't a patch I would check in.......
>
> The only modification that _should_ be done is moving the generic
> on-board I/O mapping done during board initialization to be a specific
> ioremap() in the driver, and actually looking at the eieio() to ensure
> they are really necessary.

By "use ioremap()" I mean moving the mapping into an explicit
ioremap() in the driver and away from board setup just as you suggest
- in the process removing the assumption that the registers are always
mapped at a fixed virtual address (not particularly problematic, but
not necessary either). (I couldn't find where the mapping was made in
the board setup during a brief search, but I assume it is more-or-less
the equivalent of an io_block_mapping()).

Now, as a general rule registers which are accessed through ioremap()
should be accessed only with {in,out}_*() rather than assuming the
addresses can be dereferenced directly.  Obviously the portability
reasons for this don't apply in the case of the ppc405 EMAC, but to my
mind it still makes sense to keep that convention for clarity.  I
guess "godawful mess" is a bit of an overstatement in the case of this
driver - but anyone coming from the generic parts of the kernel is
likely to be conditioned to think that way, since in any portable
driver directly dereferencing pointers from ioremap() or equivalent
would be Just Plain Wrong.

Of course using in*() and out*() would generate more eieio()s than
necessary, and I could be convinced that's a problem, but my first
instinct is to suspect that they wouldn't make a significant
difference.

--
David Gibson			| Microsoft: Making the easy things hard
david@gibson.dropbear.id.au	| and the hard things buggy
http://www.ozlabs.org/people/dgibson


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
