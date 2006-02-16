Return-Path: <philn@avalon.com.au>
Received: from ash25e.internode.on.net (ash25e.internode.on.net
	[203.16.214.182]) by ozlabs.org (Postfix) with ESMTP id 4F16E679E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Feb 2006 00:52:16 +1100 (EST)
Sender: philn@avalon.com.au
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: scatter/gather DMA and cache coherency
References: <kw4q2zg45r.fsf@lamorak.int.avalon.com.au>
	<20060216080303.GD23150@gate.ebshome.net>
From: Phil Nitschke <phil@avalon.com.au>
Date: 17 Feb 2006 00:22:11 +1030
In-Reply-To: <20060216080303.GD23150@gate.ebshome.net>
Message-ID: <wqfymjif78.fsf@toby.int.avalon.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Reply-To: Phil.Nitschke@avalon.com.au
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "ES" == Eugene Surovegin <ebs@ebshome.net> writes:

  ES> On Thu, Feb 16, 2006 at 05:51:20PM +1030, Phil Nitschke wrote:
  >> Hi,
  >> 
  >> I've been using a PCI device driver developed by a third party
  >> company.  It uses a scatter/gather DMA I/O to transfer data from
  >> the PCI device into user memory.  When using a buffer size of
  >> about 1 MB, the driver achieves a transfer bandwidth of about 60
  >> MB/s, on a 66 MHz, 32-bit bus.
  >> 
  >> The problem is, that sometimes the data is corrupt (usually on
  >> the first transfer).  We've concluded that the problem is related
  >> to cache coherency.  The Artesyn 2.6.10 reference kernel
  >> (branched from the kernel at penguinppc.org) must be built with
  >> CONFIG_NOT_COHERENT_CACHE=y, as Artesyn have never successfully
  >> verified operation with hardware coherency enabled.  My
  >> understanding is that their Marvel system controller (MV64460)
  >> supports cache snooping, but their Linux kernel support hasn't
  >> caught up yet.
  >> 
  >> So if I understand my situation correctly, the device driver must
  >> use software-enforced coherency to avoid data corruption.  Is
  >> this correct?
  >> 
  >> What currently happens is this:
  >> 
  >> The buffers are allocated with get_user_pages(...)
  >> 
  >> After each DMA transfer is complete, the driver invalidates the
  >> cache using __dma_sync_page(...)

  ES> No, buffers must be invalidated _before_ DMA transfer, not
  ES> after.  Also, don't use internal PPC functions like
  ES> __dma_sync_page. Please, read Documentation/DMA-API.txt for
  ES> official API.

Thanks for the suggestions.  I'd like to point out, however, a few
points: 

1/.  I did not write the driver (see my first line above).  I'm
     reading someone else's source and trying to figure out whether it
     is right or wrong, so I can discuss with them authoritatively
     what is going on.

2/.  I'm not _sure_ I understand terms like software-enforced
     coherency, non-consistent platforms, etc.  So should I be looking
     at the API in section I or II of DMA-API.txt ?  (I think section 'Id')

3/.  I think I did not explain the DMA process clearly enough.  This
     is how the third party documentation says the driver should be
     used (my annotations in parenthesis): 

	- Allocate and lock buffer into physical memory
            (Call driver ioctl function to map user DMA buffer using
            get_user_pages()) 
	- Configure DMA chain
	- Start DMA transfer
            (Set ID of the DMA descriptor that the DMA controller
            shall load first.  Allow target to perform bus-mastered
            DMA into platform memory)
	- Wait for DMA transfer to complete
            (interrupt signals end of transfer from target)
	- Do Cache Invalidate
            (Call driver ioctl which calls __dma_sync_page(), to
            invalidate the cache prior to reading the buffer from the
            host CPU.  Then copy data from buffer into other user
            memory.)
	- Unlock and free buffer from physical memory
            (Call device driver ioctl function which calls
            free_user_pages()) 

     So is __dma_sync_page being called by their driver routines at
     the wrong time?

4/.  The DMA-API.txt says:
        "Memory coherency operates at a granularity called the cache
        line width.  In order for memory mapped by this API to operate
        correctly, the mapped region must begin exactly on a cache
        line boundary and end exactly on one (to prevent two
        separately mapped regions from sharing a single cache line)."

     Given that we're not relying on cache snooping, and we call
     functions to invalidate the cache, does this statement still
     apply? 

Thanks again,

-- 
Phil
