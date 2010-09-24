Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id BE248B70EA
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 12:58:58 +1000 (EST)
Date: Thu, 23 Sep 2010 21:58:50 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ppc44x - how do i optimize driver for tlb hits
Message-ID: <20100924025849.GA5619@crust.elkhashab.com>
References: <20100923151246.GA17015@crust.elkhashab.com>
	<1285279264.5158.18.camel@pasglop>
	<20100923223516.GA30033@crust.elkhashab.com>
	<1285290444.14081.6.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285290444.14081.6.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 24, 2010 at 11:07:24AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2010-09-23 at 17:35 -0500, Ayman El-Khashab wrote:
> > Anything you allocate with kmalloc() is going to be mapped by bolted
> > > 256M TLB entries, so there should be no TLB misses happening in the
> > > kernel case.
> > > 
> > 
> > Hi Ben, can you or somebody elaborate?  I saw the pinned tlb in
> > 44x_mmu.c.
> > Perhaps I don't understand the code fully, but it appears to map 256MB
> > of "lowmem" into a pinned tlb.  I am not sure what phys address lowmem
> > means, but I assumed (possibly incorrectly) that it is 0-256MB. 
> 
> No. The first pinned entry (0...256M) is inserted by the asm code in
> head_44x.S. The code in 44x_mmu.c will later map the rest of lowmem
> (typically up to 768M but various settings can change that) using more
> 256M entries.

Thanks Ben, appreciate all your wisdom and insight.

Ok, so my 460ex board has 512MB total, so how does that figure into 
the 768M?  Is there some other heuristic that determines how these
are mapped? 

> Basically, all of lowmem is permanently mapped with such entries. 
> 
> > When I get the physical addresses for my buffers after kmalloc, they
> > all have addresses that are within my DRAM but start at about the
> > 440MB mark. I end up passing those phys addresses to my DMA engine.
> 
> Anything you get from kmalloc is going to come from lowmem, and thus be
> covered by those bolted TLB entries.

So is it reasonable to assume that everything on my system will come from
pinned TLB entries?

> 
> > When my compare runs it takes a huge amount of time in the assembly
> > code doing memory fetches which makes me think that there are either
> > tons of cache misses (despite the prefetching) or the entries have
> > been purged
> 
> What prefetching ? IE. The DMA operation -will- flush things out of the
> cache due to the DMA being not cache coherent on 44x. The 440 also
> doesn't have a working HW prefetch engine afaik (it should be disabled
> in FW or early asm on 440 cores and fused out in HW on 460 cores afaik).
>
> So only explicit SW prefetching will help.
> 

The DMA is what I use in the "real world case" to get data into and out 
of these buffers.  However, I can disable the DMA completely and do only
the kmalloc.  In this case I still see the same poor performance.  My
prefetching is part of my algo using the dcbt instructions.  I know the
instructions are effective b/c without them the algo is much less 
performant.  So yes, my prefetches are explicit.

> > from the TLB and must be obtained again.  As an experiment, I disabled
> > my cache prefetch code and the algo took forever.  Next I altered the
> > asm to do the same amount of data but a smaller amount over and over 
> > so that less if fetched from main memory.  That executed very quickly.
> > >From that I drew the conclusion that the algorithm is memory
> > bandwidth limited.
> 
> I don't know what exactly is going on, maybe your prefetch stride isn't
> right for the HW setup, or something like that. You can use xmon 'u'
> command to look at the TLB content. Check that we have the 256M entries
> mapping your data, they should be there.

Ok, I will give that a try ... in addition, is there an easy way to use
any sort of gprof like tool to see the system performance?  What about
looking at the 44x performance counters in some meaningful way?  All
the experiments point to the fetching being slower in the full program
as opposed to the algo in a testbench, so I want to determine what it is
that could cause that.

thanks
ayman
