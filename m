Date: Fri, 14 Jun 2002 11:33:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eugene Surovegin <ebs@innocent.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Dan Malek <dan@embeddededge.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] pci_alloc_consistent in an interrupt context
Message-ID: <20020614013352.GF26146@zax>
References: <20020613215635.GB13541@opus.bloom.county> <5.1.0.14.2.20020613122317.02e34480@mail.zultys.com> <20020613205824.GX13541@opus.bloom.county> <3D0912F4.4020300@embeddededge.com> <20020613215635.GB13541@opus.bloom.county> <5.1.0.14.2.20020613180327.02e11f68@pop.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5.1.0.14.2.20020613180327.02e11f68@pop.prodigy.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jun 13, 2002 at 06:25:11PM -0700, Eugene Surovegin wrote:
>
> At 05:24 PM 6/13/2002, David Gibson wrote:
> >That's right.  But I think the patch below is a better fix for the
> >problem.  It makes consistent_alloc()/consistent_free() just do the
> >right thing for both cache coherent and cache non-coherent processors,
> >so we can get rid of the ifdef in pci_alloc_consistent() and
> >pci_free_consistent().
>
> So, kmalloc will allocate non-cacheable memory?
>
> I seriously doubt it (actually I've just tested it:).

No, but on cache coherent processors we don't need non-cacheable
memory.  That's the whole point.  Likewise with __get_free_pages()
which is what pci_alloc_consistent() uses on cache-coherent processors
now.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
