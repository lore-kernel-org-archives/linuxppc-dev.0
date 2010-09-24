Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BBDBAB70E4
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 14:44:07 +1000 (EST)
Subject: Re: ppc44x - how do i optimize driver for tlb hits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20100924025849.GA5619@crust.elkhashab.com>
References: <20100923151246.GA17015@crust.elkhashab.com>
	<1285279264.5158.18.camel@pasglop>
	<20100923223516.GA30033@crust.elkhashab.com>
	<1285290444.14081.6.camel@pasglop>
	<20100924025849.GA5619@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Sep 2010 14:43:52 +1000
Message-ID: <1285303432.14081.28.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > No. The first pinned entry (0...256M) is inserted by the asm code in
> > head_44x.S. The code in 44x_mmu.c will later map the rest of lowmem
> > (typically up to 768M but various settings can change that) using more
> > 256M entries.
> 
> Thanks Ben, appreciate all your wisdom and insight.
> 
> Ok, so my 460ex board has 512MB total, so how does that figure into 
> the 768M?  Is there some other heuristic that determines how these
> are mapped? 

Not really, it all fits in lowmem so it will be mapped with two pinned
256M entries.

Basically, we try to map all memory with those entries in the linear
mapping. But since we only have 1G of address space available when
PAGE_OFFSET is c0000000, and we need some of that for vmalloc, ioremap,
etc... we thus limit that mapping to 768M currently.

If you have more memory, you will see only 768M unless you use
CONFIG_HIGHMEM, which allows the kernel to exploit more physical
memory. 

In this case, only the first 768M are permanently mapped (and
accessible), but you can allocate pages in "highmem" which can still be
mapped into user space and need kmap/kunmap calls to be accessed by the
kernel.

However, in your case you don't need highmem, everything fits in lowmem,
so the kernel will just use 2x256M of bolted TLB entries to map that
permanently.

Note also that kmalloc() always return lowmem.

> So is it reasonable to assume that everything on my system will come from
> pinned TLB entries?

Yes.

> The DMA is what I use in the "real world case" to get data into and out 
> of these buffers.  However, I can disable the DMA completely and do only
> the kmalloc.  In this case I still see the same poor performance.  My
> prefetching is part of my algo using the dcbt instructions.  I know the
> instructions are effective b/c without them the algo is much less 
> performant.  So yes, my prefetches are explicit.

Could be some "effect" of the cache structure, L2 cache, cache geometry
(number of ways etc...). You might be able to alleviate that by changing
the "stride" of your prefetch.

Unfortunately, I'm not familiar enough with the 440 micro architecture
and its caches to be able to help you much here.

> Ok, I will give that a try ... in addition, is there an easy way to use
> any sort of gprof like tool to see the system performance?  What about
> looking at the 44x performance counters in some meaningful way?  All
> the experiments point to the fetching being slower in the full program
> as opposed to the algo in a testbench, so I want to determine what it is
> that could cause that.

Does it have any useful performance counters ? I didn't think it did but
I may be mistaken.

Cheers,
Ben.
