Date: Fri, 14 Jun 2002 10:45:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020614004539.GB26146@zax>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <20020614002419.GM4228@zax> <20020614003807.GD13541@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614003807.GD13541@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 05:38:07PM -0700, Tom Rini wrote:
>
> On Fri, Jun 14, 2002 at 10:24:19AM +1000, David Gibson wrote:
> >
> > On Thu, Jun 13, 2002 at 02:56:35PM -0700, Tom Rini wrote:
> > >
> > > On Thu, Jun 13, 2002 at 05:47:32PM -0400, Dan Malek wrote:
> > > > Tom Rini wrote:
> > > >
> > > > >..... But I don't see (immediatly) why the change to
> > > > >pci_alloc_consistent was needed as well.
> > > >
> > > > It was a mistake on my part......when CONFIG_NOT_COHERENT_CACHE is used,
> > > > the consisten_alloc() returns the dma_handle, and we have to ensure we
> > > > don't do the virt_to_bus later to get it (because it will be wrong once
> > > > iopa() is discarded :-)
> > >
> > > Ah..  So this part is a correct and necessary fix, separate from the
> > > rest of the patch?
> >
> > That's right.  But I think the patch below is a better fix for the
> > problem.  It makes consistent_alloc()/consistent_free() just do the
> > right thing for both cache coherent and cache non-coherent processors,
> > so we can get rid of the ifdef in pci_alloc_consistent() and
> > pci_free_consistent().
>
> Er, the problem of setting dma_handle twice?

Well, it fixes that and as a bonus gets rid of the ifdefs in
pci_{alloc,free}_consistent() and means that if we ever port a driver
using consistent_{alloc,free}() to a processor that *is* cache
coherent it will Just Work.

> My only concern is that are things still consistent on non consistent
> procs?

Absolutely - no change to the code path at all on non cache coherent
processors.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
