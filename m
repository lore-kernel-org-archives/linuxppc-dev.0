Return-Path: <dan.j.williams@intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ECC19B71E8
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Jun 2009 03:27:54 +1000 (EST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id 4E728DDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Jun 2009 03:27:51 +1000 (EST)
Message-ID: <4A392542.6010306@intel.com>
Date: Wed, 17 Jun 2009 10:17:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [RFC PATCH] fsldma: Add DMA_SLAVE support
References: <20090515225659.GD858@ovro.caltech.edu>
	<4A37EC14.5010005@intel.com>
	<20090616201256.GG15955@ovro.caltech.edu>
In-Reply-To: <20090616201256.GG15955@ovro.caltech.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Ira Snyder wrote:
>> Using EXPORT_SYMBOL would defeat the purpose of conforming to the
>> dmaengine api which should allow other subsystems to generically
>> discover an fsldma resource.
>>
> 
> Any driver would still use dma_request_channel(), etc. to get access to
> a DMA channel. AFAICT, DMA_SLAVE is intended for doing something
> completely hardware-specific with the DMA controller.

Yes.  Specifically DMA_SLAVE operations imply a pre-established context 
with a 3rd device (the other 2 devices being system memory and the dma 
channel), as compared to plain memcpy.  The assumption is that a dma 
device with this capability may not be shared with other requesters 
until the context is torn down.

[..]
> What I've implemented is this: (sorry about the poor drawing)
> 
> scatterlist           fsl_dma_hw_addr
> +--------+            +-------+
> |  DATA  | -------->  | DEST1 |
> |  DATA  | ----+      +-------+
> |  DATA  |     |
> |  DATA  |     |      +-------+
> |  DATA  |     +--->  | DEST2 |
> |  DATA  |            +-------+
> +--------+
>                           .
>                           .
>                           .
> 
> Of course, the reverse works as well. You can copy from a list of
> hardware address/length pairs to a scatterlist.
> 
> So, using my implementation of the DMA_SLAVE feature, you can take a big
> chunk of data (which is organized into a scatterlist) and DMA it
> directly to a set of hardware addresses, all in a single, unbroken
> transaction.

Could the same effect be achieved by calling ->prep_slave_sg multiple 
times?  Once you need to add dma-driver specific helper routines you are 
effectively extending the dmaengine interface in an fsldma specific 
fashion.  Can we reduce this to just the existing primitives?  If it 
turns out that this is untenable can we extend dmaengine to make this a 
generic capability?  My preference is the former.

> I've inlined the driver for the FPGA programmer below. I don't think it
> is appropriate to push into mainline, since it will only work for our
> board, and nothing else.

If we find that we need to extend the dmaengine interface we will need 
an in-tree user.  In my opinion, as long as it passes the Voyager test 
[1] then I do not see why it should be barred from upstream.

[..]
> He also used platform data to get the register addresses. I'm unaware of
> a way to put arbitrary platform data into the OF tree used on PowerPC.
> 

Anybody else on ppc-dev know if this is possible??

> I didn't want to force other users to implement the allocation routines
> for the struct fsl_dma_hw_addr themselves, so I provided routines to do
> so.

It depends on how many users of this feature there ends up being, 
pushing this into each driver that needs it would not be too horrible 
especially if it just the three straightforward routines 
(fsl_dma_slave_append, fsl_dma_slave_free, and fsl_dma_slave_alloc).

So, the three options in order of preference are:
1/ arrange to call ->prep multiple times to handle each dma address
2/ push the functionality down into the individual drivers that need it
3/ up level the functionality into dmaengine to make it generically 
available

Thanks,
Dan

[1]: The Voyager test refers to James Bottomley's maintenance of the 
Voyager x86-sub-architecture.  If at least one person cares about a 
feature, is willing to maintain the code, and it does not impose a 
maintenance burden on other parts of the tree then it can go upstream.
