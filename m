Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 506E4679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Feb 2006 03:33:24 +1100 (EST)
Date: Thu, 16 Feb 2006 08:33:21 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Phil.Nitschke@avalon.com.au
Subject: Re: scatter/gather DMA and cache coherency
Message-ID: <20060216163321.GE23150@gate.ebshome.net>
References: <kw4q2zg45r.fsf@lamorak.int.avalon.com.au>
	<20060216080303.GD23150@gate.ebshome.net>
	<wqfymjif78.fsf@toby.int.avalon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <wqfymjif78.fsf@toby.int.avalon.com.au>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Feb 17, 2006 at 12:22:11AM +1030, Phil Nitschke wrote:
> >>>>> "ES" == Eugene Surovegin <ebs@ebshome.net> writes:
> 
>   ES> On Thu, Feb 16, 2006 at 05:51:20PM +1030, Phil Nitschke wrote:
>   >> Hi,
>   >> 
>   >> I've been using a PCI device driver developed by a third party
>   >> company.  It uses a scatter/gather DMA I/O to transfer data from
>   >> the PCI device into user memory.  When using a buffer size of
>   >> about 1 MB, the driver achieves a transfer bandwidth of about 60
>   >> MB/s, on a 66 MHz, 32-bit bus.
>   >> 
>   >> The problem is, that sometimes the data is corrupt (usually on
>   >> the first transfer).  We've concluded that the problem is related
>   >> to cache coherency.  The Artesyn 2.6.10 reference kernel
>   >> (branched from the kernel at penguinppc.org) must be built with
>   >> CONFIG_NOT_COHERENT_CACHE=y, as Artesyn have never successfully
>   >> verified operation with hardware coherency enabled.  My
>   >> understanding is that their Marvel system controller (MV64460)
>   >> supports cache snooping, but their Linux kernel support hasn't
>   >> caught up yet.
>   >> 
>   >> So if I understand my situation correctly, the device driver must
>   >> use software-enforced coherency to avoid data corruption.  Is
>   >> this correct?
>   >> 
>   >> What currently happens is this:
>   >> 
>   >> The buffers are allocated with get_user_pages(...)
>   >> 
>   >> After each DMA transfer is complete, the driver invalidates the
>   >> cache using __dma_sync_page(...)
> 
>   ES> No, buffers must be invalidated _before_ DMA transfer, not
>   ES> after.  Also, don't use internal PPC functions like
>   ES> __dma_sync_page. Please, read Documentation/DMA-API.txt for
>   ES> official API.
> 

[snip]

> 2/.  I'm not _sure_ I understand terms like software-enforced
>      coherency, non-consistent platforms, etc.  So should I be looking
>      at the API in section I or II of DMA-API.txt ?  (I think section 'Id')

Non-consistent means without cache snooping. On such platforms you 
have to use software enforced cache coherency or non-cached memory for 
DMA.

> 
> 3/.  I think I did not explain the DMA process clearly enough.  This
>      is how the third party documentation says the driver should be
>      used (my annotations in parenthesis): 
> 
> 	- Allocate and lock buffer into physical memory
>             (Call driver ioctl function to map user DMA buffer using
>             get_user_pages()) 
> 	- Configure DMA chain
> 	- Start DMA transfer
>             (Set ID of the DMA descriptor that the DMA controller
>             shall load first.  Allow target to perform bus-mastered
>             DMA into platform memory)
> 	- Wait for DMA transfer to complete
>             (interrupt signals end of transfer from target)
> 	- Do Cache Invalidate
>             (Call driver ioctl which calls __dma_sync_page(), to
>             invalidate the cache prior to reading the buffer from the
>             host CPU.  Then copy data from buffer into other user
>             memory.)
> 	- Unlock and free buffer from physical memory
>             (Call device driver ioctl function which calls
>             free_user_pages()) 
> 
>      So is __dma_sync_page being called by their driver routines at
>      the wrong time?

As I said before, invalidate must be done _before_ initiating DMA 
transfer. If that "third party documentation" states otherwise, that 
means people who wrote it didn't understand how caches work.

Consider the following scenario, you allocated page from kernel page 
allocator. Some parts of that page are in L1 cache and are dirty 
(e.g. because they were recently used), I'm assuming cache is 
write-back. You start DMA transfer and go on with some other tasks. 
For some reason, those dirty lines are forced out of cache, e.g. 
because L1 needs cache lines for some other data. During this write 
back you overwrite already DMAed data and end up with memory 
corruption.

> 
> 4/.  The DMA-API.txt says:
>         "Memory coherency operates at a granularity called the cache
>         line width.  In order for memory mapped by this API to operate
>         correctly, the mapped region must begin exactly on a cache
>         line boundary and end exactly on one (to prevent two
>         separately mapped regions from sharing a single cache line)."
> 
>      Given that we're not relying on cache snooping, and we call
>      functions to invalidate the cache, does this statement still
>      apply? 

Yes. Cache line granularity is very important for software enforced 
cache coherency.

I'd recommend you look at any driver which works on non-coherent cache 
platform like 4xx or 8xx for good examples on how to manage cache 
coherency.

-- 
Eugene
