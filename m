Date: Sat, 15 Jun 2002 16:40:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020615064044.GG1124@zax>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <20020614002419.GM4228@zax> <20020614003807.GD13541@opus.bloom.county> <20020614004539.GB26146@zax> <20020614005156.GE13541@opus.bloom.county> <20020614051450.GM26146@zax> <20020614145930.GI13541@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614145930.GI13541@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 07:59:30AM -0700, Tom Rini wrote:
> > > > > My only concern is that are things still consistent on non consistent
> > > > > procs?
> > > >
> > > > Absolutely - no change to the code path at all on non cache coherent
> > > > processors.
> > >
> > > So kmalloc/kfree are equivilent to __get_free_pages/free_pages ?
> >
> > Read that again: on *non* cache coherent processors the code path is
> > the same.  kmalloc() vs. __get_free_pages() is a problem for
> > processors which *are* cache coherent.
>
> Yes.  And there's 2 things here which I'm wondering about:
> (a) Why do we call __get_fre_pages/free_pages now on coherent procs?
> Can we really just call something else and have it work?

Possibly not (though I'm not sure kmalloc() wouldn't work), which is
why my last patch reverted to using __get_free_pages()/free_pages().
But the only problem with kmalloc() is the page-alignment requirements
specified in DMA-mapping.txt, not the actual consistency/coherence.

> (b) Is it really a good idea to have a function called
> 'consistent_alloc()' which doesn't actually do that, for the sake of
> removing 2 ifdefs?

As paulus already pointer out, it *does* actually do that.  Normal
memory is consistent on cache coherent processsors - that's what cache
coherent means.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
