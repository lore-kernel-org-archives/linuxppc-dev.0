Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 62226B70AE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 03:24:00 +1000 (EST)
Date: Mon, 27 Sep 2010 10:23:56 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH RFCv2 1/2] dmaengine: add support for scatterlist to
	scatterlist transfers
Message-ID: <20100927172356.GA805@ovro.caltech.edu>
References: <1285370032-16937-1-git-send-email-iws@ovro.caltech.edu>
	<1285370032-16937-2-git-send-email-iws@ovro.caltech.edu>
	<AANLkTimzdEhAZ=oXbbB3Ge5=YY7OXq3fjaRH4roPNB-k@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimzdEhAZ=oXbbB3Ge5=YY7OXq3fjaRH4roPNB-k@mail.gmail.com>
Cc: Per =?iso-8859-1?Q?Frid=E9n?= <per.friden@stericsson.com>,
	Dan Williams <dan.j.williams@intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 27, 2010 at 05:23:34PM +0200, Linus Walleij wrote:
> 2010/9/25 Ira W. Snyder <iws@ovro.caltech.edu>:
> 
> > This adds support for scatterlist to scatterlist DMA transfers.
> 
> This is a good idea, we have a local function to do this in DMA40 already,
> stedma40_memcpy_sg().
> 

I think that having two devices that want to implement this
functionality as part of the DMAEngine API is a good argument for making
it available as part of the core API. I think it would be good to add
this to struct dma_device, and add a capability (DMA_SG?) for it as
well.

I have looked at the stedma40_memcpy_sg() function, and I think we would
want to extend it slightly for the generic API. Is there any good reason
to prohibit scatterlists with different numbers of elements?

For example:
src scatterlist: 10 elements, each with 4K length (40K total)
dst scatterlist: 40 elements, each with 1K length (40K total)

The total length of both scatterlists is equal, but the number of
scatterlist entries is different. The freescale DMA controller can
handle this just fine.

I'm proposing this function signature:
struct dma_async_tx_descriptor *
dma_memcpy_sg(struct dma_chan *chan,
	      struct scatterlist *dst_sg, unsigned int dst_nents,
	      struct scatterlist *src_sg, unsigned int src_nents,
	      unsigned long flags);

> > This is
> > currently hidden behind a configuration option, which will allow drivers
> > which need this functionality to select it individually.
> 
> Why? Isn't it better to add this as a new capability flag
> if you don't want to announce it? Or is the intent to save
> memory footprint?
> 

Dan wanted this, probably for memory footprint. If >1 driver is using
it, I would rather have it as part of struct dma_device along with a
capability.

Thanks for the feedback,
Ira
