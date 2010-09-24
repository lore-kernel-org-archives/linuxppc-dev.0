Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by ozlabs.org (Postfix) with ESMTP id 4E4F9B6EFF
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 23:08:56 +1000 (EST)
Date: Fri, 24 Sep 2010 08:08:51 -0500
From: Ayman El-Khashab <ayman@elkhashab.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: ppc44x - how do i optimize driver for tlb hits
Message-ID: <20100924130851.GA14016@crust.elkhashab.com>
References: <20100923151246.GA17015@crust.elkhashab.com>
	<1285279264.5158.18.camel@pasglop>
	<20100923223516.GA30033@crust.elkhashab.com>
	<1285290444.14081.6.camel@pasglop>
	<20100924025849.GA5619@crust.elkhashab.com>
	<1285303432.14081.28.camel@pasglop>
	<20100924103034.GA27958@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100924103034.GA27958@zod.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 24, 2010 at 06:30:34AM -0400, Josh Boyer wrote:
> On Fri, Sep 24, 2010 at 02:43:52PM +1000, Benjamin Herrenschmidt wrote:
> >> The DMA is what I use in the "real world case" to get data into and out 
> >> of these buffers.  However, I can disable the DMA completely and do only
> >> the kmalloc.  In this case I still see the same poor performance.  My
> >> prefetching is part of my algo using the dcbt instructions.  I know the
> >> instructions are effective b/c without them the algo is much less 
> >> performant.  So yes, my prefetches are explicit.
> >
> >Could be some "effect" of the cache structure, L2 cache, cache geometry
> >(number of ways etc...). You might be able to alleviate that by changing
> >the "stride" of your prefetch.

My original theory was that it was having lots of cache misses.  But since
the algorithm works standalone fast and uses large enough buffers (4MB),
much of the cache is flushed and replaced with my data.  The cache is 32K,
8 way, 32b/line.  I've crafted the algorithm to use those parameters.

> >
> >Unfortunately, I'm not familiar enough with the 440 micro architecture
> >and its caches to be able to help you much here.
> 
> Also, doesn't kmalloc have a limit to the size of the request it will
> let you allocate?  I know in the distant past you could allocate 128K
> with kmalloc, and 2M with an explicit call to get_free_pages.  Anything
> larger than that had to use vmalloc.  The limit might indeed be higher
> now, but a 4MB kmalloc buffer sounds very large, given that it would be
> contiguous pages.  Two of them even less so.

I thought so too, but at least in the current implementation we found
empirically that we could kmalloc up to but no more than 4MB.  We have 
also tried an approach in user memory and then using "get_user_pages"
and building a scatter-gather.  We found that the compare code doesn't 
perform any better. 

I suppose another option is to to use the kernel profiling option I 
always see but have never used.  Is that a viable option to figure out
what is happening here?  

ayman
