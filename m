Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9D65AB71A7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 06:50:28 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id ADCA7DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 06:50:27 +1000 (EST)
Date: Thu, 18 Jun 2009 13:50:24 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] fsldma: Add DMA_SLAVE support
Message-ID: <20090618205024.GA16741@ovro.caltech.edu>
References: <20090515225659.GD858@ovro.caltech.edu>
	<4A37EC14.5010005@intel.com>
	<20090616201256.GG15955@ovro.caltech.edu>
	<4A392542.6010306@intel.com>
	<20090617182947.GB4707@ovro.caltech.edu>
	<4A3A8463.7080601@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A3A8463.7080601@intel.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 18, 2009 at 11:16:03AM -0700, Dan Williams wrote:
> Ira Snyder wrote:
>> I can do something similar by calling device_prep_dma_memcpy() lots of
>> times. Once for each page in the scatterlist.
>>
>> This has the advantage of not changing the DMAEngine API.
>>
>> This has the disadvantage of not being a single transaction. The DMA
>> controller will get an interrupt after each memcpy() transaction, clean
>> up descriptors, etc.
>>
>
> Why would it need an interrupt per memcpy?  There is a  
> DMA_PREP_INTERRUPT flag to gate interrupt generation to the last  
> descriptor.  This is how async_tx delays callbacks until the last  
> operation in a chain has completed.  Also, I am not currently seeing how  
> your implementation achieves a single hardware transaction.  It still  
> calls fsl_dma_alloc_descriptor() per address pair?
>

Ok, there are a few things here:

1) an interrupt per memcpy

The *software* using DMAEngine doesn't need one interrupt per memcpy.
That is controlled by the DMA_PREP_INTERRUPT flag, exactly as you
describe.

The Freescale DMA driver DOES use one interrupt per async_tx descriptor.
See drivers/dma/fsldma.c dma_init() and append_ld_queue().

The FSL_DMA_MR_EOTIE flag in dma_init() tells the controller to generate
an interrupt at the end of each transfer. A transfer is (potentially
long) list of address pairs / hardware descriptors.

The FSL_DMA_MR_EOSIE flag in append_ld_queue() tells the controller to
generate an interrupt at the end of transferring this hardware
descriptor (AKA segment). The driver combines multiple memcpy operations
into a single transfer. When the driver combines operations, it adds the
EOSIE flag to the descriptor that would-have-been the end of a transfer.
It uses this interrupt to update the DMA cookie, presumably to speed up
users of dma_sync_wait() when there are lots of users sharing the DMA
controller.

Let me try to explain what will happen with some code:

=== Case 1: Two seperate transfers ===

dma_cookie_t t1, t2;
t1 = dma_async_memcpy_buf_to_buf(...);
dma_async_memcpy_issue_pending();

/*
 * some time goes by, the DMA transfer completes,
 * and the controller gets the end-of-transfer interrupt
 */

t2 = dma_async_memcpy_buf_to_buf(...);
dma_async_memcpy_issue_pending();

/*
 * some time goes by, the DMA transfer completes,
 * and the controller gets the end-of-transfer interrupt
 */

This is exactly what I would expect from the API. There are two seperate
transfers, and there are two hardware interrupts. Here is a crude
timeline.

----|----------|----------------------------|----------|-------
    |          |                            |          |
    t1 start   t1 end, EOT interrupt        t2 start   t2 end, EOT interrupt

=== Case 2: Two seperate transfers, merged by the driver ===

t1 = dma_async_memcpy_buf_to_buf(...);
dma_async_memcpy_issue_pending();

/*
 * the controller starts executing the transfer, but has not
 * finished yet
 */
t2 = dma_async_memcpy_buf_to_buf(...);

/*
 * append_ld_queue() sets the EOSIE flag on the last hardware
 * descriptor in t1, then sets the next link descriptor to the
 * first descriptor in t2
 */

Now there are two transfers, and again two hardware interrupts. Again,
not really a problem. Every part of the API still works as expected.

----|-----------|---------------|---------------------------------|--------
    |           |               |                                 |
    t1 start    t2 tx_submit()  t1 end, EOS interrupt, t2 start   t2 end, EOT interrupt

=== Case 3: Two transfers, merged by the driver ===

t1 = dma_async_memcpy_buf_to_buf(...);
t2 = dma_async_memcpy_buf_to_buf(...);
dma_async_memcpy_issue_pending();

After a very careful reading of the driver, I just noticed that if there
is no transfer in progress (as would be expected on a private channel)
then the EOS interrupt never gets set, and the requests are simply
merged together. This would lead to a timeline like this:

----|----------------|----------------------|--------------------------
    |                |                      |
    t1 start         t1 end, t2 start       t2 end, EOT interrupt

This is perfectly fine as well. It is the behavior I want.

Some more study of the code shows that the Freescale DMA driver will not
halt the channel as long as the channel is busy, meaning that it will
not clear the external start bits during a transfer.

So, in conclusion, I can call memcpy multiple times and have it all
merged into a single transfer by the driver, with a single hardware
interrupt (at the end-of-transfer) and have everything complete without
halting the DMA controller.

2) Single transaction

I think we're using different terms here. I define a single transaction
to be the time while the DMA controller is busy transferring things.

In case #1 above, there are two transfers. In case #2 above, one
transfer, and two interrupts. In case #3 above, one transfer, one
interrupt.

3) Hardware descriptor per address pair

Yes, there can be many hardware descriptors per address pair. And
therefore many hardware descriptors per transaction, with my definition.

> The api currently allows a call to ->prep_* to generate multiple  
> internal descriptors for a single input address (i.e. memcpy in the case  
> where the transfer length exceeds the hardware maximum).  The slave api  
> allows for transfers from a scatterlist to a slave context.  I think  
> what is bothering me is that the fsldma slave implementation is passing  
> a list of sideband addresses rather than a constant address context like  
> the existing dw_dmac, so it is different.  However, I can now see that  
> trying to enforce uniformity in this area is counterproductive.  The  
> DMA_SLAVE interface will always have irreconcilable differences across  
> architectures.
>

Yep, we're in agreement here.

In another driver, I used this DMA_SLAVE API to transfer from hardware
addresses to a scatterlist. I have ~50 blocks, all at different
non-contiguous addresses that I want transferred into a single
scatterlist.

It was awfully convenient to have this happen in a single call, rather
than 50 seperate calls to dma_async_memcpy_buf_to_buf().

>> It also has the disadvantage of not being able to change the
>> controller-specific features I'm using: external start. This feature
>> lets the "3rd device" control the DMA controller. It looks like the
>> atmel-mci driver has a similar feature. The DMAEngine API has no way to
>> expose this type of feature except through DMA_SLAVE.
>
> Yeah, an example of an architecture specific quirk that has no chance of  
> being uniformly handled in a generic api.
>

Again, we're in agreement.

>> If it is just the 3 helper routines that are the issue with this patch,
>> I have no problem dropping them and letting each user re-create them
>> themselves.
>
> I think this makes the most sense at this point.  We can reserve  
> judgement on the approach until the next fsldma-slave user arrives and  
> tries to use this implementation for their device.  Can we move the  
> header file under arch/powerpc/include?
>

Sure, that would be fine.

> [..]
>> A single-transaction scatterlist-to-scatterlist copy would be nice.
>>
>> One of the major advantages of working with the DMA controller is that
>> it automatically handles scatter/gather. Almost all DMA controllers have
>> the feature, but it is totally missing from the high-level API.
>
> The engines I am familiar with (ioatdma and iop-adma) still need a  
> hardware descriptor per address pair I do not see how fsldma does this  
> any more automatically than those engines?  I could see having a helper  
> routine that does the mapping and iterating, but in the end the driver  
> still sees multiple calls to ->prep (unless of course you are doing this  
> in a DMA_SLAVE context, then anything goes).
>

Yep. The Freescale DMA controller behaves exactly as you describe the
ioatdma and iop-dma engines. A helper routine that does the mapping and
iterating would be nice, in my opinion. It took me a while to convince
myself that the nested loops in device_prep_slave_sg() were correct.

Following on the earlier observations in this email, it would be
possible to emulate the slave behavior using just
dma_async_memcpy_buf_to_buf(). With the exception of the external start
bit, of course.

Now, the only thing I would use device_prep_slave_sg() for would be to
set the external start bit. No actual data transfer needs to happen, no
descriptors need to be allocated. Just the "Enable extra controller
features" block from my patch. This seems like an abuse of the DMA_SLAVE
API. What would be returned in that case?  An async_tx descriptor is
wrong, because the controller won't be able to free() it...

So, I see a couple of ways of moving forward:
1) Keep my implementation, moving the includes to arch/powerpc/include.
   Do we drop the allocation functions?

2) Drop the data transfer part of device_prep_slave_sg(), and just use
   it for setting device-specific bits.

Thanks for all the input Dan. I finally feel like we're getting
somewhere :)

Ira
