Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id B52CFB70EF
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 08:35:19 +1000 (EST)
Date: Thu, 23 Sep 2010 17:35:16 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ppc44x - how do i optimize driver for tlb hits
Message-ID: <20100923223516.GA30033@crust.elkhashab.com>
References: <20100923151246.GA17015@crust.elkhashab.com>
	<1285279264.5158.18.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285279264.5158.18.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 24, 2010 at 08:01:04AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2010-09-23 at 10:12 -0500, Ayman El-Khashab wrote:
> > I've implemented a working driver on my 460EX.  it allocates a couple
> > of buffers of 4MB each.  I have a custom memcmp algorithm in asm that
> > is extremely fast in user space, but 1/2 as fast when run on these
> > buffers.
> > 
> > my tests are showing that the algorithm seems to be memory bandwidth
> > bound.  my guess is that i am having tlb or cache misses (my algo
> > uses the dbct) that is slowing performance.  curiously when in user
> > space, i can affect the performance by small changes in the size of
> > the buffer, i.e. 4MB + 32B is fast, 4MB + 4K is much worse.
> > 
> > Can i adjust my driver code that is using kmalloc to make sure that
> > the ppc44x has 4MB tlb entries for these and that they stay put?
> 
> Anything you allocate with kmalloc() is going to be mapped by bolted
> 256M TLB entries, so there should be no TLB misses happening in the
> kernel case.
> 

Hi Ben, can you or somebody elaborate?  I saw the pinned tlb in 44x_mmu.c.
Perhaps I don't understand the code fully, but it appears to map 256MB
of "lowmem" into a pinned tlb.  I am not sure what phys address lowmem
means, but I assumed (possibly incorrectly) that it is 0-256MB.  When I
get the physical addresses for my buffers after kmalloc, they all have
addresses that are within my DRAM but start at about the 440MB mark. I
end up passing those phys addresses to my DMA engine.

When my compare runs it takes a huge amount of time in the assembly code
doing memory fetches which makes me think that there are either tons of
cache misses (despite the prefetching) or the entries have been purged
from the TLB and must be obtained again.  As an experiment, I disabled
my cache prefetch code and the algo took forever.  Next I altered the
asm to do the same amount of data but a smaller amount over and over 
so that less if fetched from main memory.  That executed very quickly.
>From that I drew the conclusion that the algorithm is memory bandwidth
limited.

In a standalone configuration (i.e. algorithm just using user memory,
everything else identical), the speedup is 2-3x.  So the limitation 
is not a hardware limit, it must be something that is happening when
I execute the loads.  (it is a compare algorithm, so it only does
loads).

Thanks
Ayman
