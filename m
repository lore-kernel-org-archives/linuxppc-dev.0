Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D30FDDE43
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Feb 2007 08:41:10 +1100 (EST)
Subject: Re: Discussion about iopa()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <6CDAEEF1-B0ED-42E6-AA2C-6FD1CFCF462C@embeddedalley.com>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<45CB28A6.3050607@freescale.com>
	<712E63F6-23D6-45EB-92F0-95656FF38BC4@embeddedalley.com>
	<1171075021.20494.0.camel@localhost.localdomain>
	<6CDAEEF1-B0ED-42E6-AA2C-6FD1CFCF462C@embeddedalley.com>
Content-Type: text/plain
Date: Sun, 11 Feb 2007 08:40:49 +1100
Message-Id: <1171143649.20494.31.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-02-10 at 13:04 -0500, Dan Malek wrote:
> On Feb 9, 2007, at 9:37 PM, Benjamin Herrenschmidt wrote:
> 
> > We are fairly careful about not bloating fast path in general.
> 
> This isn't any fast path code, and the way the
> exception handlers are growing it doesn't
> seem to be a concern anyway.

The 64 bits exception handlers are growing a bit due to some optional
process time accounting stuff though I'm not too happy with the growth.
Appart from that, they aren't growing much and we are working hard to
keep them in check. Any specific example of that "growth" you are
talking about ?

> It is only a couple of memory accesses, even
> less code than the TLB exception handlers.

It's more specifically two loads on 2 level page tables we have on 32
bits though on 64 bits, page tables are 3 or 4 levels (64k or 4k page
size) and thus it's 3 or 4 loads, which can be very significant if those
are cache misses. So yes, while it's quite cheap on embedded 32 bits
CPUs that don't use HIGHMEM, it's not that good on other things, and
thus might not be the best approach.

I still think that it's preferable to simply obtain the physical address
along with the virtual one when allocating/creating an object (and thus
have the allocator for those object types, like rheap for MURAM, return
it, the same way the coherent dma allocator does).

There's also another issue with iopa that isn't obvious at first look:
It's racy vs. page tables being disposed on SMP machines (and possibly
with preempt). We handle the race against hash misses on hash-based CPUs
using the hash lock in pte_free but there is nothing in iopa to deal
with that. I don't think this is a problem with kernel mappings though,
but one should be careful.

> Using highmem has a price any time it's
> configured into a system, it's not unique in
> this case.  In fact, in this case highmem
> shouldn't be a concern any different than
> the TLB exceptions.

True, but it's more expensive than keeping track of the physical address
from allocation.

> I just don't understand how such a trivial
> and useful function that does exactly what
> we need in a very clean way generates so
> much polarized discussion.  I'm beginning
> to think it's just personal, since the only
> argument against it is "I don't like it" when
> the alternatives are just hacks at best that
> still need to be "fixed up someday." :-)

The alternatives aren't just hack. The alternative that we recommend and
which is the way to do things in linux is to keep track of the physical
address or the struct page's at allocation time.

> The Linux VM implementation just sucks.

This has very little to do with linux VM. Most if not all the uses of
iopa are purely for kernel mappings which are not handled by the core VM
in most areas. There are design choices in the linux kernel memory
management that you might not agree with, though just saying "just
sucks" is neither useful nor constructive. If you think that some
aspects of linux kernel memory handling should be done differently, you
are much welcome to propose alternatives (with patches) though keep in
mind that the way things are done now is actually very efficient from a
performance standpoint and well adapted to the need of most
architectures.

> The majority of systems running this software
> aren't servers and desktop PCs, it's embedded
> SOCs with application specific peripherals.
> They have attributes and are mapped in ways
> that don't fit the "memory at 0" or "IO" model.
> We have to find solutions to this, together.

Yes, and finding solutions involves more than just saying "sucks" :-)

Now, I don't completely agree with you that there are "fundamental"
limitations in the way memory is managed. First let's get off the
subject of "VM" as this is commonly used to represent the memory
management of user processes which isn't what we are talking about (and
doesnt' suffer from any of the "limitations" you mention anyway.

What we are talking about here is the management of the kernel memory
address space.

Some of the limitations you mention above like "memory at 0" are more
limitations of some architecture ports like x86 or powerpc and mostly
because on those CPUs, it make little sense to do differently due to the
way exceptions work, and even then, they aren't very hard to lift. (See
for example kdump which runs the ppc64 kernel in a reserved area of
memory at 32MB or so).

Some of those "limitations" result from design choices that provide best
performances for 99% of the usage scenario and though they might not be
suitable for the most exotic hardware, that doesn't make them bad
choices in the first place.

I do agree however that in some areas we can do better. For example, the
vmalloc/ioremap allocator should definitely be modified to be able to
allocate in different areas/pools. That's something we could use on
ppc64 as well to replace our imalloc crap and possibly on embedded to
replace rheap.

I'm not sure what you mean by "IO model" here.

Ben.
