Date: Thu, 13 Jun 2002 17:38:07 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>,
	Eugene Surovegin <ebs@innocent.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020614003807.GD13541@opus.bloom.county>
References: <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <20020614002419.GM4228@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020614002419.GM4228@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Jun 14, 2002 at 10:24:19AM +1000, David Gibson wrote:
>
> On Thu, Jun 13, 2002 at 02:56:35PM -0700, Tom Rini wrote:
> >
> > On Thu, Jun 13, 2002 at 05:47:32PM -0400, Dan Malek wrote:
> > > Tom Rini wrote:
> > >
> > > >..... But I don't see (immediatly) why the change to
> > > >pci_alloc_consistent was needed as well.
> > >
> > > It was a mistake on my part......when CONFIG_NOT_COHERENT_CACHE is used,
> > > the consisten_alloc() returns the dma_handle, and we have to ensure we
> > > don't do the virt_to_bus later to get it (because it will be wrong once
> > > iopa() is discarded :-)
> >
> > Ah..  So this part is a correct and necessary fix, separate from the
> > rest of the patch?
>
> That's right.  But I think the patch below is a better fix for the
> problem.  It makes consistent_alloc()/consistent_free() just do the
> right thing for both cache coherent and cache non-coherent processors,
> so we can get rid of the ifdef in pci_alloc_consistent() and
> pci_free_consistent().

Er, the problem of setting dma_handle twice?

My only concern is that are things still consistent on non consistent
procs?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
