Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EC91BB71D8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 04:29:50 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 50683DDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 04:29:49 +1000 (EST)
Date: Wed, 17 Jun 2009 11:29:47 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC PATCH] fsldma: Add DMA_SLAVE support
Message-ID: <20090617182947.GB4707@ovro.caltech.edu>
References: <20090515225659.GD858@ovro.caltech.edu>
	<4A37EC14.5010005@intel.com>
	<20090616201256.GG15955@ovro.caltech.edu>
	<4A392542.6010306@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A392542.6010306@intel.com>
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

On Wed, Jun 17, 2009 at 10:17:54AM -0700, Dan Williams wrote:
> Ira Snyder wrote:
>>> Using EXPORT_SYMBOL would defeat the purpose of conforming to the
>>> dmaengine api which should allow other subsystems to generically
>>> discover an fsldma resource.
>>>
>>
>> Any driver would still use dma_request_channel(), etc. to get access to
>> a DMA channel. AFAICT, DMA_SLAVE is intended for doing something
>> completely hardware-specific with the DMA controller.
>
> Yes.  Specifically DMA_SLAVE operations imply a pre-established context  
> with a 3rd device (the other 2 devices being system memory and the dma  
> channel), as compared to plain memcpy.  The assumption is that a dma  
> device with this capability may not be shared with other requesters  
> until the context is torn down.
>
> [..]
>> What I've implemented is this: (sorry about the poor drawing)
>>
>> scatterlist           fsl_dma_hw_addr
>> +--------+            +-------+
>> |  DATA  | -------->  | DEST1 |
>> |  DATA  | ----+      +-------+
>> |  DATA  |     |
>> |  DATA  |     |      +-------+
>> |  DATA  |     +--->  | DEST2 |
>> |  DATA  |            +-------+
>> +--------+
>>                           .
>>                           .
>>                           .
>>
>> Of course, the reverse works as well. You can copy from a list of
>> hardware address/length pairs to a scatterlist.
>>
>> So, using my implementation of the DMA_SLAVE feature, you can take a big
>> chunk of data (which is organized into a scatterlist) and DMA it
>> directly to a set of hardware addresses, all in a single, unbroken
>> transaction.
>
> Could the same effect be achieved by calling ->prep_slave_sg multiple  
> times?  Once you need to add dma-driver specific helper routines you are  
> effectively extending the dmaengine interface in an fsldma specific  
> fashion.  Can we reduce this to just the existing primitives?  If it  
> turns out that this is untenable can we extend dmaengine to make this a  
> generic capability?  My preference is the former.
>

I can do something similar by calling device_prep_dma_memcpy() lots of
times. Once for each page in the scatterlist.

This has the advantage of not changing the DMAEngine API.

This has the disadvantage of not being a single transaction. The DMA
controller will get an interrupt after each memcpy() transaction, clean
up descriptors, etc.

It also has the disadvantage of not being able to change the
controller-specific features I'm using: external start. This feature
lets the "3rd device" control the DMA controller. It looks like the
atmel-mci driver has a similar feature. The DMAEngine API has no way to
expose this type of feature except through DMA_SLAVE.

If it is just the 3 helper routines that are the issue with this patch,
I have no problem dropping them and letting each user re-create them
themselves.

>> I've inlined the driver for the FPGA programmer below. I don't think it
>> is appropriate to push into mainline, since it will only work for our
>> board, and nothing else.
>
> If we find that we need to extend the dmaengine interface we will need  
> an in-tree user.  In my opinion, as long as it passes the Voyager test  
> [1] then I do not see why it should be barred from upstream.
>

Yep, I understand the Voyager test. I just didn't think it would be
useful to anyone to try and push it upstream, especially since the
hardware is in-house only.

The virtio-over-pci patches I've posted a while back may benefit from
this as well. They look more likely to go upstream. I've been really
busy and haven't had time to work on them recently, but Grant Likely is
working on them at the moment.

> [..]
>> He also used platform data to get the register addresses. I'm unaware of
>> a way to put arbitrary platform data into the OF tree used on PowerPC.
>>
>
> Anybody else on ppc-dev know if this is possible??
>
>> I didn't want to force other users to implement the allocation routines
>> for the struct fsl_dma_hw_addr themselves, so I provided routines to do
>> so.
>
> It depends on how many users of this feature there ends up being,  
> pushing this into each driver that needs it would not be too horrible  
> especially if it just the three straightforward routines  
> (fsl_dma_slave_append, fsl_dma_slave_free, and fsl_dma_slave_alloc).
>

Right, the routines are very simple. I wouldn't have any problem leaving
it up to users.

> So, the three options in order of preference are:
> 1/ arrange to call ->prep multiple times to handle each dma address

This doesn't seem quite right. I'd end up doing something like:

struct fsl_dma_slave slave;
slave.external_start = true;
slave.address = 0xf0003000;
slave.length = 4096;
chan->private = &slave;

for_each_sg(sgl, sg, sg_len, i) {
	device_prep_slave_sg(chan, sg, 1, DMA_TO_DEVICE, 0);
}

That pretty much defeats the purpose of the scatterlist argument,
doesn't it? Also, it is no better than just calling
device_prep_dma_memcpy() lots of times. You don't get a single DMA
transaction.

It is trivial to implement a dma_addr_t to dma_addr_t memcpy function.
Here is a version I've used in the past, based very heavily on
dma_async_memcpy_buf_to_buf():

static dma_cookie_t dma_async_memcpy_raw_to_raw(struct dma_chan *chan,
                                               dma_addr_t dst,
                                               dma_addr_t src,
                                               size_t len)
{
        struct dma_device *dev = chan->device;
        struct dma_async_tx_descriptor *tx;
        enum dma_ctrl_flags flags;
        dma_cookie_t cookie;
        int cpu;

        flags = DMA_COMPL_SKIP_SRC_UNMAP | DMA_COMPL_SKIP_DEST_UNMAP;
        tx = dev->device_prep_dma_memcpy(chan, dst, src, len, flags);
        if (!tx)
                return -ENOMEM;

        tx->callback = NULL;
        cookie = tx->tx_submit(tx);

        cpu = get_cpu();
        per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
        per_cpu_ptr(chan->local, cpu)->memcpy_count++;
        put_cpu();

        return cookie;
}

I've used it when copying data from another machine over PCI, and for
copying to peripherals, such as the FPGA programmer.

> 2/ push the functionality down into the individual drivers that need it
> 3/ up level the functionality into dmaengine to make it generically  
> available

A single-transaction scatterlist-to-scatterlist copy would be nice.

One of the major advantages of working with the DMA controller is that
it automatically handles scatter/gather. Almost all DMA controllers have
the feature, but it is totally missing from the high-level API.

Thanks,
Ira
