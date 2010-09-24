Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25935B70EC
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 11:07:39 +1000 (EST)
Subject: Re: ppc44x - how do i optimize driver for tlb hits
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ayman El-Khashab <ayman@elkhashab.com>
In-Reply-To: <20100923223516.GA30033@crust.elkhashab.com>
References: <20100923151246.GA17015@crust.elkhashab.com>
	<1285279264.5158.18.camel@pasglop>
	<20100923223516.GA30033@crust.elkhashab.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Sep 2010 11:07:24 +1000
Message-ID: <1285290444.14081.6.camel@pasglop>
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

On Thu, 2010-09-23 at 17:35 -0500, Ayman El-Khashab wrote:
> Anything you allocate with kmalloc() is going to be mapped by bolted
> > 256M TLB entries, so there should be no TLB misses happening in the
> > kernel case.
> > 
> 
> Hi Ben, can you or somebody elaborate?  I saw the pinned tlb in
> 44x_mmu.c.
> Perhaps I don't understand the code fully, but it appears to map 256MB
> of "lowmem" into a pinned tlb.  I am not sure what phys address lowmem
> means, but I assumed (possibly incorrectly) that it is 0-256MB. 

No. The first pinned entry (0...256M) is inserted by the asm code in
head_44x.S. The code in 44x_mmu.c will later map the rest of lowmem
(typically up to 768M but various settings can change that) using more
256M entries.

Basically, all of lowmem is permanently mapped with such entries. 

> When I get the physical addresses for my buffers after kmalloc, they
> all have addresses that are within my DRAM but start at about the
> 440MB mark. I end up passing those phys addresses to my DMA engine.

Anything you get from kmalloc is going to come from lowmem, and thus be
covered by those bolted TLB entries.

> When my compare runs it takes a huge amount of time in the assembly
> code doing memory fetches which makes me think that there are either
> tons of cache misses (despite the prefetching) or the entries have
> been purged

What prefetching ? IE. The DMA operation -will- flush things out of the
cache due to the DMA being not cache coherent on 44x. The 440 also
doesn't have a working HW prefetch engine afaik (it should be disabled
in FW or early asm on 440 cores and fused out in HW on 460 cores afaik).

So only explicit SW prefetching will help.

> from the TLB and must be obtained again.  As an experiment, I disabled
> my cache prefetch code and the algo took forever.  Next I altered the
> asm to do the same amount of data but a smaller amount over and over 
> so that less if fetched from main memory.  That executed very quickly.
> >From that I drew the conclusion that the algorithm is memory
> bandwidth limited.

I don't know what exactly is going on, maybe your prefetch stride isn't
right for the HW setup, or something like that. You can use xmon 'u'
command to look at the TLB content. Check that we have the 256M entries
mapping your data, they should be there.

> In a standalone configuration (i.e. algorithm just using user memory,
> everything else identical), the speedup is 2-3x.  So the limitation 
> is not a hardware limit, it must be something that is happening when
> I execute the loads.  (it is a compare algorithm, so it only does
> loads). 

Cheers,
Ben.
