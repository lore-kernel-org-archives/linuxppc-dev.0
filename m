Date: Fri, 14 Jun 2002 15:14:50 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Dan Malek <dan@embeddededge.com>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020614051450.GM26146@zax>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <20020614002419.GM4228@zax> <20020614003807.GD13541@opus.bloom.county> <20020614004539.GB26146@zax> <20020614005156.GE13541@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614005156.GE13541@opus.bloom.county>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 05:51:56PM -0700, Tom Rini wrote:
>
> On Fri, Jun 14, 2002 at 10:45:39AM +1000, David Gibson wrote:
> > On Thu, Jun 13, 2002 at 05:38:07PM -0700, Tom Rini wrote:
> [snip]
> > > Er, the problem of setting dma_handle twice?
> >
> > Well, it fixes that and as a bonus gets rid of the ifdefs in
> > pci_{alloc,free}_consistent() and means that if we ever port a driver
> > using consistent_{alloc,free}() to a processor that *is* cache
> > coherent it will Just Work.
>
> In theory at that point OCP would either have its API fully flushed out
> or be applied nicely on top of the generic driver work in 2.5 and it
> would just work anyhow :)

Well at the moment OCP drivers call consistent_alloc() directly which
would always fail on cache-coherent processors.

> > > My only concern is that are things still consistent on non consistent
> > > procs?
> >
> > Absolutely - no change to the code path at all on non cache coherent
> > processors.
>
> So kmalloc/kfree are equivilent to __get_free_pages/free_pages ?

Read that again: on *non* cache coherent processors the code path is
the same.  kmalloc() vs. __get_free_pages() is a problem for
processors which *are* cache coherent.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
