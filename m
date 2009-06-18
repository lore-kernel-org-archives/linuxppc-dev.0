Return-Path: <dan.j.williams@intel.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A0D74B7280
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Jun 2009 04:16:06 +1000 (EST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by ozlabs.org (Postfix) with ESMTP id 10EBEDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jun 2009 04:16:05 +1000 (EST)
Message-ID: <4A3A8463.7080601@intel.com>
Date: Thu, 18 Jun 2009 11:16:03 -0700
From: Dan Williams <dan.j.williams@intel.com>
MIME-Version: 1.0
To: Ira Snyder <iws@ovro.caltech.edu>
Subject: Re: [RFC PATCH] fsldma: Add DMA_SLAVE support
References: <20090515225659.GD858@ovro.caltech.edu>
	<4A37EC14.5010005@intel.com>
	<20090616201256.GG15955@ovro.caltech.edu>
	<4A392542.6010306@intel.com>
	<20090617182947.GB4707@ovro.caltech.edu>
In-Reply-To: <20090617182947.GB4707@ovro.caltech.edu>
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
> I can do something similar by calling device_prep_dma_memcpy() lots of
> times. Once for each page in the scatterlist.
> 
> This has the advantage of not changing the DMAEngine API.
> 
> This has the disadvantage of not being a single transaction. The DMA
> controller will get an interrupt after each memcpy() transaction, clean
> up descriptors, etc.
>

Why would it need an interrupt per memcpy?  There is a 
DMA_PREP_INTERRUPT flag to gate interrupt generation to the last 
descriptor.  This is how async_tx delays callbacks until the last 
operation in a chain has completed.  Also, I am not currently seeing how 
your implementation achieves a single hardware transaction.  It still 
calls fsl_dma_alloc_descriptor() per address pair?

The api currently allows a call to ->prep_* to generate multiple 
internal descriptors for a single input address (i.e. memcpy in the case 
where the transfer length exceeds the hardware maximum).  The slave api 
allows for transfers from a scatterlist to a slave context.  I think 
what is bothering me is that the fsldma slave implementation is passing 
a list of sideband addresses rather than a constant address context like 
the existing dw_dmac, so it is different.  However, I can now see that 
trying to enforce uniformity in this area is counterproductive.  The 
DMA_SLAVE interface will always have irreconcilable differences across 
architectures.

> It also has the disadvantage of not being able to change the
> controller-specific features I'm using: external start. This feature
> lets the "3rd device" control the DMA controller. It looks like the
> atmel-mci driver has a similar feature. The DMAEngine API has no way to
> expose this type of feature except through DMA_SLAVE.

Yeah, an example of an architecture specific quirk that has no chance of 
being uniformly handled in a generic api.

> If it is just the 3 helper routines that are the issue with this patch,
> I have no problem dropping them and letting each user re-create them
> themselves.

I think this makes the most sense at this point.  We can reserve 
judgement on the approach until the next fsldma-slave user arrives and 
tries to use this implementation for their device.  Can we move the 
header file under arch/powerpc/include?

[..]
> A single-transaction scatterlist-to-scatterlist copy would be nice.
> 
> One of the major advantages of working with the DMA controller is that
> it automatically handles scatter/gather. Almost all DMA controllers have
> the feature, but it is totally missing from the high-level API.

The engines I am familiar with (ioatdma and iop-adma) still need a 
hardware descriptor per address pair I do not see how fsldma does this 
any more automatically than those engines?  I could see having a helper 
routine that does the mapping and iterating, but in the end the driver 
still sees multiple calls to ->prep (unless of course you are doing this 
in a DMA_SLAVE context, then anything goes).

Thanks,
Dan
