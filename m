Date: Thu, 13 Jun 2002 21:42:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Eugene Surovegin <ebs@innocent.com>,
	Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020614044257.GH13541@opus.bloom.county>
References: <20020613215635.GB13541@opus.bloom.county> <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <5.1.0.14.2.20020613180327.02e11f68@pop.prodigy.net> <5.1.0.14.2.20020613184104.026b9910@pop.prodigy.net> <20020614020640.GI26146@zax> <20020614021523.GG13541@opus.bloom.county> <20020614035803.GJ26146@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614035803.GJ26146@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 01:58:03PM +1000, David Gibson wrote:
> On Thu, Jun 13, 2002 at 07:15:23PM -0700, Tom Rini wrote:
> >
> > On Fri, Jun 14, 2002 at 12:06:40PM +1000, David Gibson wrote:
> > > On Thu, Jun 13, 2002 at 06:57:45PM -0700, Eugene Surovegin wrote:
> > > >
> > > > At 06:33 PM 6/13/2002, David Gibson wrote:
> > > > >On Thu, Jun 13, 2002 at 06:25:11PM -0700, Eugene Surovegin wrote:
> > > > >>
> > > > >> At 05:24 PM 6/13/2002, David Gibson wrote:
> > > > >> >That's right.  But I think the patch below is a better fix for the
> > > > >> >problem.  It makes consistent_alloc()/consistent_free() just do the
> > > > >> >right thing for both cache coherent and cache non-coherent processors,
> > > > >> >so we can get rid of the ifdef in pci_alloc_consistent() and
> > > > >> >pci_free_consistent().
> > > > >>
> > > > >> So, kmalloc will allocate non-cacheable memory?
> > > > >>
> > > > >> I seriously doubt it (actually I've just tested it:).
> > > > >
> > > > >No, but on cache coherent processors we don't need non-cacheable
> > > > >memory.  That's the whole point.  Likewise with __get_free_pages()
> > > > >which is what pci_alloc_consistent() uses on cache-coherent processors
> > > > >now.
> > > >
> > > > OK, I got it :)
> > > >
> > > > One problem though, kmalloc allocated memory will not be necessarily
> > > > properly aligned
> > > > as required by DMA-mappings.txt
> > > >
> > > > Some PCI drivers may break because of this.
> > >
> > > Ah, yes, indeed.  How about this:
> >
> > One last thing, did you mean to keep consistent_free as kfree() still
> > and not free_pages() ?
>
> No I didn't.  Working on a fixed version - just running into some
> other technical hitches.

So are we sure it's worth it to remove now 2 #ifdefs ?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
