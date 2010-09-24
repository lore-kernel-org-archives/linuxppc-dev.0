Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 56942B70F2
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 20:30:41 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8OANrVm009763
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 06:23:53 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8OAUbvJ129938
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 06:30:37 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o8OAUbbl010324
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Sep 2010 07:30:37 -0300
Date: Fri, 24 Sep 2010 06:30:34 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ppc44x - how do i optimize driver for tlb hits
Message-ID: <20100924103034.GA27958@zod.rchland.ibm.com>
References: <20100923151246.GA17015@crust.elkhashab.com>
	<1285279264.5158.18.camel@pasglop>
	<20100923223516.GA30033@crust.elkhashab.com>
	<1285290444.14081.6.camel@pasglop>
	<20100924025849.GA5619@crust.elkhashab.com>
	<1285303432.14081.28.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285303432.14081.28.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Ayman El-Khashab <ayman@elkhashab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 24, 2010 at 02:43:52PM +1000, Benjamin Herrenschmidt wrote:
>> The DMA is what I use in the "real world case" to get data into and out 
>> of these buffers.  However, I can disable the DMA completely and do only
>> the kmalloc.  In this case I still see the same poor performance.  My
>> prefetching is part of my algo using the dcbt instructions.  I know the
>> instructions are effective b/c without them the algo is much less 
>> performant.  So yes, my prefetches are explicit.
>
>Could be some "effect" of the cache structure, L2 cache, cache geometry
>(number of ways etc...). You might be able to alleviate that by changing
>the "stride" of your prefetch.
>
>Unfortunately, I'm not familiar enough with the 440 micro architecture
>and its caches to be able to help you much here.

Also, doesn't kmalloc have a limit to the size of the request it will
let you allocate?  I know in the distant past you could allocate 128K
with kmalloc, and 2M with an explicit call to get_free_pages.  Anything
larger than that had to use vmalloc.  The limit might indeed be higher
now, but a 4MB kmalloc buffer sounds very large, given that it would be
contiguous pages.  Two of them even less so.

>> Ok, I will give that a try ... in addition, is there an easy way to use
>> any sort of gprof like tool to see the system performance?  What about
>> looking at the 44x performance counters in some meaningful way?  All
>> the experiments point to the fetching being slower in the full program
>> as opposed to the algo in a testbench, so I want to determine what it is
>> that could cause that.
>
>Does it have any useful performance counters ? I didn't think it did but
>I may be mistaken.

No, it doesn't.

josh
