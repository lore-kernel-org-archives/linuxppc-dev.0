Date: Tue, 28 May 2002 16:50:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Armin <akuster@pacbell.net>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Armin Kuster <akuster@mvista.com>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Another OCP enet patch
Message-ID: <20020528065027.GT16537@zax>
References: <20020527040330.GH16537@zax> <20020527162323.GB32718@opus.bloom.county> <20020528005728.GO16537@zax> <20020528012516.GE1295@opus.bloom.county> <3CF32B87.4010908@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3CF32B87.4010908@pacbell.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 28, 2002 at 12:02:31AM -0700, Armin wrote:
> >I agree with them not really belonging in ocp-dma.h either, but it's
> >either a PCI device or an 'Oh Chip Peripheral' of some sort.
> >
> >
> >>For 2.5, I think the proper fix is to remove the PCI_DMA_* constants
> >>entirely and replace them with some arbitrary constants to define DMA
> >>direction.  They can then be used for both PCI and OCP (and sbus,
> >>which also uses the PCI constants despite not being PCI).  But that
> >>means convincing Linus, of course.
> >>
> >
> >2.5 still seems to be in break everything mode, so why not send Linus a
> >patch which creates <linux/dma.h>, for example, and then do a quick
> >search/replace of PCI_DMA_* -> DMA_* and keep the numbers the same even.
>
> Well what I did for the USB ocp drive was to call dma_pool_*,
> dma_*_consistent etc... It would be fairly easy to leave the pci_* in
> place , remove as much common code and place them in to generic dma
> fuctions.  I would leave the need or use of the struct pci_dev in the
> pci_* fuctions to do their business and buffer the new dma API's.  This
> will keep us from changing _all_ pci drivers, give a central location
> for common code and give those arch/drivers who want to use dma
> functions and a way to break away from either having to enable "pci" or
> include pci headers to make things work. the ocp drivers could use these
> generic dma api directly or all use some sort of wrapper.

Um, I think you're overestimating how generic this dma_pool API is or
can be.  In general a peripheral might be hanging of one or several
buses from the CPU with IOMMU(s) or TCE(s) or equivalent between it
and main memory.  That's why pci_alloc_consistent() and friends
require the pci_dev structure and why they don't have an interface as
simple as consistent_*().  This is exactly why dma_cache_wback_inv()
and so on are kinda deprecated - they're not well defined on a machine
whose buses have different address spaces.

The direction constants can be made generic trivially.  Generalising
more of the DMA infrastructure is much harder.

In any case we're talking about consistent_sync() here, not
consistent_alloc() which specifically *isn't* called on specially
allocated blocks of memory - the OCP enet driver calls it on random
SKBs.  In some ways, since we're PPC specific anyway, I think it would
make as much sense as anything just to directly call
dcache_flush_range() and so forth, rather than consistent_sync() or
dma_cache_*().

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
