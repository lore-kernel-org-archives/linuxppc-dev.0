Date: Tue, 28 May 2002 10:57:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
Message-ID: <20020528005728.GO16537@zax>
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020527162323.GB32718@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, May 27, 2002 at 09:23:23AM -0700, Tom Rini wrote:
>
> On Mon, May 27, 2002 at 02:03:30PM +1000, David Gibson wrote:
>
> > I realise that logically the OCP enet driver, and the
> > consistent_sync() has nothing to do with PCI.  However using the pci.h
> > constants seems a better approach than defining new constants with the
> > same values, when the switch in consistent_sync() explicitly checks
> > against the PCI constants.
> >
> > In the longer term consistent_sync() itself should be changed not to
> > reference the PCI constants - in fact the PCI constants should
> > probably be moved and renamed since they have no inherent connection
> > with PCI at all.
>
> At this point I think I should give my 2 cents, so...
>
> I think we should keep ocp-dma.h around for now (2.4.x timeframe) and
> change consistent_sync() to not check for the PCI versions (which I
> believe happened just because it's a cut&paste&fix of the ARM code) and
> for 2.5 hope that a more general fix comes out..

I disagree.  Using the constants from pci.h is the least-wrong simple
fix for now - yes it's conceptually wrong, but they're just arbitrary
constants, it doesn't do any real damage.

Changing consistent_sync() to use its own constants isn't completely
trivial, because asm/pci.h calls consistent_sync() with the constants
passed as arguments to pci_map_single() et al, assuming they have the
correct values.  So, to decouple the consistent_sync() constants from
the PCI direction constants we would have to put a switch in every
time consistent_sync() is used in asm/pci.h.  The PCI constants could
be defined in terms of the non-PCI constants, but that means changing
generic code (linux/pci.h).

If/when we do add non-PCI constants for consistent_sync() they
shouldn't go in ocp-dma.h, since they have no more to do with OCP than
they do with PCI.  In io.h along with the prototype for
consistent_sync() would be a better idea.

For 2.5, I think the proper fix is to remove the PCI_DMA_* constants
entirely and replace them with some arbitrary constants to define DMA
direction.  They can then be used for both PCI and OCP (and sbus,
which also uses the PCI constants despite not being PCI).  But that
means convincing Linus, of course.

PS.  In reinstating ocp-dma.h you seem to have deleted ocp.h.  I'm
guessing that's not what you meant to do.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
