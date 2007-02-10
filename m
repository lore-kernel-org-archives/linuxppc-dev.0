Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0F50DDEC6
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Feb 2007 09:43:21 +1100 (EST)
Subject: Re: Discussion about iopa()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Malek <dan@embeddedalley.com>
In-Reply-To: <8D2A12A2-EB11-497C-AF4C-FDD95088E968@embeddedalley.com>
References: <989B956029373F45A0B8AF02970818900D444B@zch01exm26.fsl.freescale.net>
	<45CB28A6.3050607@freescale.com>
	<712E63F6-23D6-45EB-92F0-95656FF38BC4@embeddedalley.com>
	<1171075021.20494.0.camel@localhost.localdomain>
	<6CDAEEF1-B0ED-42E6-AA2C-6FD1CFCF462C@embeddedalley.com>
	<1171143649.20494.31.camel@localhost.localdomain>
	<8D2A12A2-EB11-497C-AF4C-FDD95088E968@embeddedalley.com>
Content-Type: text/plain
Date: Sun, 11 Feb 2007 09:42:59 +1100
Message-Id: <1171147379.20494.49.camel@localhost.localdomain>
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


> I'd agree, but we don't have any functions to deal with this.
> It's been an issue ever since I ported the first 8xx many
> years ago.  The arguments range from "it's too specialized"
> or "fit it under something else" that isn't appropriate, or
> it's yet another resource allocator with it's own set of
> management APIs (which I think is silly, but seems to be
> the way of Linux).  Worse, we just hack something to
> "fix another day", which never happens :-)

Heh. Well, I do agree that the vmalloc/ioremap allocator should indeed
be improved to handle multiple constrained areas.

In fact, that's even something I intend to look into to remove ppc64's
imalloc :-)

> Considering it was done before any SMP support,
> and was ignored when support was added, that's
> not really an argument to not use it but rather to fix it.

Sure.

> > ....   though just saying "just
> > sucks" is neither useful nor constructive.
> 
> About in line  with "I don't like it" :-)

Yeah well, that's why I'm trying to explain the reasons why I dislike
the approach :-)

> > .....  If you think that some
> > aspects of linux kernel memory handling should be done differently,  
> > you
> > are much welcome to propose alternatives
> 
> They have always been ignored, and never
> accepted as small changes over time.  It seems
> to be an all or nothing approach that I just
> don't have the time to invest.

I suppose I must have missed those attempts then. As I said, I do agree
that some aspects of the kernel memory address space handling can be
improved to handle more of those cases and I'd be happy to discuss
ideas/proposals/patches in that direction.

> > Now, I don't completely agree with you that there are "fundamental"
> > limitations in the way memory is managed.
> 
> Sure there are, but it's not for discussion here.
> 
> > ...  First let's get off the
> > subject of "VM"
> 
> It's all about VM and the implicit connection Linux
> makes between physical memory and virtual
> addresses that makes this a problem.  There are
> special allocators for the different types of "memory",
> different ways of setting/finding any attributes (if
> you can at all), and the pre-knowledge you need
> about the address spaces so you can call proper
> support functions.  There is no separation of
> VM objects and what backs them, orthogonal
> operations (to do something as simple as get
> a physical address behind a virtual one regardless
> of the backing store), the ridiculous need for something
> like highmem and the yet another way to manage
> that, the inability to have a separate kernel and
> user VM space if I choose, the minimal support and
> horrible hacks for 32-bit systems with greater than
> 32-bit physical addresses, the list goes on and on.....

Highmem and >32 bits physical addresses are two different things.

Highmem is a consequence of a design choice to improve performances on
most 32 bits CPUs which was done at a time where we didn't have
routinely gigabytes of RAM on those machines. The 3G/1G split allows
direct access to user memory from the kernel at no cost, and thus while
causing limitations like the need for highmem if you want more than 1G
(or rather 768Mb on ppc32) it does improve performances overall by a
significant factor.

However, it's not a fundamental limitation of the kernel. A fully
separate kernel address space is what the 4G/4G does on x86 and it can
be implemented (if not already) for pretty much free on some freescale
book-e processors with their load/store insns that take the address
space as an argument without the overhead of constantly mapping/umapping
bits of process space in kernel space.

It would be possible to implement 4G/4G on other CPUs using something
akin to highmem's kmap or a specialized TLB entry or BAT (depending on
the processor) that is used as a "window" to user space on other 32 bits
CPUs. The reason it's not in the kernel yet is that nobody actually did
it. I don't think we would reject patches implementing that (well, at
least not on the principle of the approach, possibly if they are coded
like crap :-)

Now, I'm not sure I see your problem with >32 bits address space. The
main question is wether this is used for memory or IO though.

When used for memory, the approach so far is what is done with PAE on
x86 via a highmem-type mecanism iirc, though I'm not too familiar with
it (heh, there's no other choice really here). When used for IO, then
it's very simple nowadays with 64 bits resources and 64 bits capable
ioremap.

Basically, everything out of the linear mapping is mapped via those
"objects" you are talking about managed by the vmalloc/ioremap core. As
I said, it could/should be improved to better handle different
areas/pools (especially on 64 bits implentation) but it provides a
pretty good base implementation for having virtual memory "objects" and
doesn't care about the physical mapping of those, you can pass
attributes (though we call them "protection bits" in linux, they are the
same).

If you tell us more precisely what you think could be improved in and in
what direction, I'd be happy to discuss the details.

Cheers,
Ben.
