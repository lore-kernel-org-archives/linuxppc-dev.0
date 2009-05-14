Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id DA426DE060
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 02:55:04 +1000 (EST)
Date: Thu, 14 May 2009 09:55:02 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [RFC] Using the DMAEngine API for scatter/gather operations
Message-ID: <20090514165502.GB4379@ovro.caltech.edu>
References: <20090514161353.GA4379@ovro.caltech.edu>
	<1242318437.6797.3.camel@dwillia2-mobl1.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1242318437.6797.3.camel@dwillia2-mobl1.amr.corp.intel.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Li Yang <leoli@freescale.com>, Zhang Wei <wei.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 14, 2009 at 09:27:17AM -0700, Dan Williams wrote:
> On Thu, 2009-05-14 at 09:13 -0700, Ira Snyder wrote:
> > Hello all.
> > 
> > I'm working on a driver for a custom board (based heavily on the
> > MPC8349EMDS board) to dump data out of onboard FPGA's. I need to use the
> > onboard DMA controller for this, mostly due to data transfer rate and
> > timing requirements.
> > 
> > Of course, I'd like to "play nice" with the existing Linux
> > infrastructure in my driver, even though I have no plans to submit the
> > driver upstream (since it is only useful for our custom board).
> > 
> > I have been using the DMAEngine API to interact with the DMA controller,
> > and it works without any problems. However it seems that it is missing
> > one of the major features that is supported by almost all DMA
> > controllers: scatter/gather support.
> > 
> > What I'd really like to do is give the controller a scatterlist and list
> > of hardware addresses, and have it set up the transfer. The Freescale
> > hardware can handle this, and I could program it by hand to do so, but I
> > don't want to invent my own DMA API.
> > 
> > I'm aware that the DMAEngine API was designed to offload memcpy, and
> > pretty much nothing else. Is there any chance that such a change would
> > be accepted into the mainline kernel? Any opinions on what such an API
> > should look like?
> > 
> 
> Have you taken a look at the 'slave' interface implemented by dw_dmac
> and other drivers?  It has the following interface:
> 
>        struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
>                 struct dma_chan *chan, struct scatterlist *sgl,
>                 unsigned int sg_len, enum dma_data_direction direction,
>                 unsigned long flags);
> 
> Haavard uses this interface to do sgl transfers on behalf of the
> atmel-mci driver (drivers/mmc/host/atmel-mci.c).
> 

I had started looking at it, though the Freescale device does not
implement DMA_SLAVE support. I was a bit discouraged by the changelog
for commit dc0ee643, which says that the interface is for "DMA with
hardware handshaking", which I do not have. There is not anything
special about accessing the FPGA's, they appear in the processor's
memory map and can be read from/written to just like RAM.

I'll try studying the dw_dmac implementation and atmel-mci example.

Thanks for the response,
Ira
