Date: Sat, 15 Jun 2002 16:57:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Dan Malek <dan@embeddededge.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: consistent_free()
Message-ID: <20020615065752.GH1124@zax>
References: <20020614042928.GK26146@zax> <20020614153954.GL13541@opus.bloom.county> <15626.55392.839931.746121@argo.ozlabs.ibm.com> <3D0ADE69.6040905@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D0ADE69.6040905@embeddededge.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Jun 15, 2002 at 02:27:53AM -0400, Dan Malek wrote:
>
> Paul Mackerras wrote:
>
> >"Consistent" means "the cpu and the device see the same stuff in
> >memory".  On a cache-coherent system that is true of all normal
> >memory.  Surely that is obvious?
>
> Not really.  You have seen enough messages about people wanting to
> get "uncached" memory, even though this isn't necessary.
>
> We also don't want to be remapping 'consistent' space on those
> processors that don't require it, one of the primary functions
> of consistent_alloc() so it works properly on noncoherent processors.

We don't.

> Basically, David Gibson moved an 'ifdef' from one place to another,
> and then had to write a consistent_alloc function for processors that
> didn't need it before, placing more code in an include file no less.
> How does that add value to the kernel?  It just complicated the
> maintenance of a function that is similar across multiple architectures.

Oh fer cryin' out loud.  Before any non-PCI driver that wanted DMA
consistent memory and wanted to work on both cache-coherent and
non-cache coherent would have to have an ifdef on
CONFIG_NOT_COHERENT_CACHE.  If it was on, it would have to use
consistent_alloc(), other wise it could just allocate the memory
normally (with kmalloc() or get_free_pages()) since consistency comes
for free on cache coherent processors.

I just made consistent_alloc() do for cache coherent processors
exactly what the driver would have to do anyway if
CONFIG_NOT_COHERENT_CACHE were not set.  The cache coherent
implementation of consistent_alloc() is utterly trivial, and does not
remapping.  If we really don't want to be calling consistent_alloc()
on cache coherent processors it should BUG() or cause a link error,
rather than just failing.

Admittedly pci_alloc_consistent() was (so far) the only place this
happened, because every other user of consistent_alloc() was basically
in a driver which would only ever be used on non cache coherent
processors.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
