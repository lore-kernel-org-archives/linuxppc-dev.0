Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <1271e7dc7e42a99440e7925475b40547@embeddededge.com>
References: <1116984651.6395.60.camel@gaston>
	<2d61cb60140e879d0c8d46e7f51a9f56@freescale.com>
	<1116987700.6395.64.camel@gaston>
	<4aa09b6017041c7fe43b9138a19d9c65@embeddededge.com>
	<1116998427.6395.86.camel@gaston>
	<1271e7dc7e42a99440e7925475b40547@embeddededge.com>
Content-Type: text/plain
Date: Wed, 25 May 2005 16:00:08 +1000
Message-Id: <1117000809.6395.92.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linuxppc-embedded@ozlabs.org
Subject: Re: RFC: Deprecating io_block_mapping
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2005-05-25 at 01:49 -0400, Dan Malek wrote:
> On May 25, 2005, at 1:20 AM, Benjamin Herrenschmidt wrote:
> 
> > Ok, that was my point... since init page tables can be loaded by it, 
> > why
> > not make ioremap work that early and do the same ?
> 
> Because you lose the efficiency of mapping with BATs or CAMs.
> 
> > ... The problem is of
> > course allocating the pte pages but how does io_block_mapping() do on
> > CPUS without BAT/CAMs/whatever ?
> 
> It just loads init's page tables directly.
>
> > We have the pgdir, but not the PTE pages...
> 
> The PTE pages are allocated as they are needed.  The PTE pages
> are there :-)

Well, you say "loads init's page tables directly"... well, init starts
with a pgdir, it needs to allocate PTE pages in order to "load" the page
tables with PTEs, thus my question, how does io_block_mapping does
this ? It use the bootmem allocator ? If yes, then that means we can
have ioremap working as well. I'm not completely arguing against
io_block_mapping() but I think it's abused, and thus looking into
encouraging different approaches.

> > No, we have a trick with ioremap_bot, we don't need to get vmalloc 
> > space
> > for ioremap to work early.
> 
> That's only if you have already done something to already allocate BATs
> or CAMs.  On processors that don't  have these, ioremap() would fail 
> because it would think it has to allocate VM space.

The ioremap_bot trick works in whatever case provided MMU_init has been
called so ioremap_bot & ioremap_base are initialized. It would be fairly
easy to turn that into a static init though.

> >  ....  In fact, it would be nice to just have
> > io_block_mapping be able to "dynamically" allocate virtual space using
> > the same mecanism instead of beeing passed a virtual address. That 
> > would
> > fix most of the problems with hard coded 1:1 mappings.
> 
> I think we should make ioremap() smarter and have some board 
> initialization that helps it by setting up BATs, CAMs, or unique page table
> mappings. There is also an interdependence between ioremap() and other IO
> initialization.  In the past some of the fixed addressing was necessary 
> due to assumptions built into IO setup, mapping functions, or macros.  I 
> don't know how much of this is still present.

It depends on the platform I suppose. There is still a few bits in PReP
that I can fix, I'm not sure about embedded.

> > Well, my problem is with hard-coded v:p mappings... If we can simply
> > have io_block_mapping take, for example, 0 for v (or -1) and use the
> > ioremap_bot trick to "allocate" virtual space, that would make me happy
> > (it needs to return the allocated address too).
> 
> Somewhere, at some point, prior to VM setup, we need to forcibly map
> virtual to physical addresses.  These are going to be "hard coded"
> mappings, that's exactly how ioremap_bot is set.  This is why
> io_block_mapping was created in the first place.  Somehow you have
> to specify this mapping before you have a VM allocator to give it to 
> you. :-)

No, you just need to have ioremap_bot (which is in fact "top" not
"bottom", bad naming) initialized to something sane. This is currently
done in MMU_init() but could probably be initialized statically instead.
I do just that on ppc64 and thus can ioremap at any time without needing
to allocate vmalloc space. The vmalloc space is automatically "cap'd" by
ioremap_bot anyway.

> Even if you don't call it io_block_mapping(), you are going to need
> a function that does exactly this.
