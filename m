Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 0AFEBDDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jun 2009 04:10:41 +1000 (EST)
Date: Wed, 3 Jun 2009 11:10:38 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] fsldma: Add DMA_SLAVE support
Message-ID: <20090603181038.GC7292@ovro.caltech.edu>
References: <20090515225659.GD858@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090515225659.GD858@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 15, 2009 at 03:56:59PM -0700, Ira Snyder wrote:
> Use the DMA_SLAVE capability of the DMAEngine API to copy/from a
> scatterlist into an arbitrary list of hardware address/length pairs.
> 
> This allows a single DMA transaction to copy data from several different
> devices into a scatterlist at the same time.
> 
> This also adds support to enable some controller-specific features such as
> external start and external pause of a DMA transaction.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> This is a request for comments on this patch. I hunch it is not quite
> ready for inclusion, though it is certainly ready for review. Correct
> functioning of this patch depends on the patches submitted earlier.
> 
> As suggested by Dan Williams, I implemented DMA_SLAVE support for the
> fsldma controller to allow me to use the hardware to transfer to/from a
> scatterlist to a list of hardware address/length pairs.
> 
> I implemented support for the extra features available in the DMA
> controller, such as external pause and external start. I have not tested
> the features yet. I am willing to drop the support if everything else
> looks good.
> 
> I have implemented helper functions for creating the list of hardware
> address/length pairs as static inline functions in the linux/fsldma.h
> header. Should I incorporate these into the driver itself and use
> EXPORT_SYMBOL()? I've never done this before :)
> 

Any comments on this patch?

I've tested the external start feature, and it works great. I had to set
the DMA Request Count (in the mode register) after the driver was in
control. There is no interface for doing this in the existing driver. I
just ioremap()ed the registers and added the value from my driver after
claiming the channel with dma_request_channel().

There are ways to get the DMA controller into a state where the CB bit
stays set no matter what you do. I have only seen this during an
externally controlled transfer, when the external master does weird
things. I would fix this state in terminate_all(), but I have been
unsuccessful in getting the DMA controller working again after it has
been messed up.

Ira
