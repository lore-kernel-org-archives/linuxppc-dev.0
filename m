Date: Fri, 14 Jun 2002 07:59:30 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020614145930.GI13541@opus.bloom.county>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <20020614002419.GM4228@zax> <20020614003807.GD13541@opus.bloom.county> <20020614004539.GB26146@zax> <20020614005156.GE13541@opus.bloom.county> <20020614051450.GM26146@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614051450.GM26146@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 03:14:50PM +1000, David Gibson wrote:
> On Thu, Jun 13, 2002 at 05:51:56PM -0700, Tom Rini wrote:
> >
> > On Fri, Jun 14, 2002 at 10:45:39AM +1000, David Gibson wrote:
> > > On Thu, Jun 13, 2002 at 05:38:07PM -0700, Tom Rini wrote:
> > [snip]
> > > > Er, the problem of setting dma_handle twice?
> > >
> > > Well, it fixes that and as a bonus gets rid of the ifdefs in
> > > pci_{alloc,free}_consistent() and means that if we ever port a driver
> > > using consistent_{alloc,free}() to a processor that *is* cache
> > > coherent it will Just Work.
> >
> > In theory at that point OCP would either have its API fully flushed out
> > or be applied nicely on top of the generic driver work in 2.5 and it
> > would just work anyhow :)
>
> Well at the moment OCP drivers call consistent_alloc() directly which
> would always fail on cache-coherent processors.

Yes.  And at the moment OCP is still a work in progress too.  As I said
before, by the time that pops up, OCP will either have it's API finished
(and look alot like PCI so drivers shouldn't be calling
consistent_alloc() themselves) or be worked in nicely with the generic
driver work in 2.5, which again will be copying pci_alloc_consistent()
to driver_alloc_consistent().

> > > > My only concern is that are things still consistent on non consistent
> > > > procs?
> > >
> > > Absolutely - no change to the code path at all on non cache coherent
> > > processors.
> >
> > So kmalloc/kfree are equivilent to __get_free_pages/free_pages ?
>
> Read that again: on *non* cache coherent processors the code path is
> the same.  kmalloc() vs. __get_free_pages() is a problem for
> processors which *are* cache coherent.

Yes.  And there's 2 things here which I'm wondering about:
(a) Why do we call __get_fre_pages/free_pages now on coherent procs?
Can we really just call something else and have it work?
(b) Is it really a good idea to have a function called
'consistent_alloc()' which doesn't actually do that, for the sake of
removing 2 ifdefs?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
