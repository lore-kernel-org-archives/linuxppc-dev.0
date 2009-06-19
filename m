Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id C2D71B7269
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 04:26:04 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 15B8FDDD1B
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 04:26:03 +1000 (EST)
Date: Fri, 19 Jun 2009 11:26:00 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: linuxppc-dev@ozlabs.org, Kumar Gala <galak@kernel.crashing.org>,
	Dan Williams <dan.j.williams@intel.com>, Li Yang <leoli@freescale.com>
Subject: Re: [PATCH v2] fsldma: Add DMA_SLAVE support
Message-ID: <20090619182600.GA30992@ovro.caltech.edu>
References: <20090618225345.GB16741@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090618225345.GB16741@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 18, 2009 at 03:53:45PM -0700, Ira Snyder wrote:
> Use the DMA_SLAVE capability of the DMAEngine API to copy/from a
> scatterlist into an arbitrary list of hardware address/length pairs.
> 
> This allows a single DMA transaction to copy data from several different
> devices into a scatterlist at the same time.
> 
> This also adds support to enable some controller-specific features such as
> external start and external pause for a DMA transaction.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> 
> After discussion with Dan Williams, this is the second version of the
> DMA_SLAVE API for the Freescale DMA controller. I've tested it heavily
> with both drivers I have written against this API, an FPGA programmer
> and an FPGA data grabber.
> 
> Kumar, Dan asked me to add you to the CC list, so you can have a look at
> this patch before he adds it to his tree.
> 
> The other two small patches I posted earlier are very helpful in testing
> this functionality. They make the fsldma driver leave the BWC (bandwidth
> control) bits alone on the 83xx controller, as well as making the
> external start feature available on 83xx.
> 
> In order for the external start/pause features to be useful, the
> bandwidth control bits (in the mode register) need to be set before
> attempting to use the controller. I could spin a v3 of this patch that
> adds a field to struct fsl_dma_slave to set the bits appropriately. Or I
> could send another patch for that. Thoughts?
> 
> Many thanks to all that have participated in the discussion about this
> patch.
> 
> v1 -> v2:
> * move fsldma.h from include/linux to arch/powerpc/include/asm
> * add kerneldoc documentation
> 

[snip]

> +
> +	/* Enable extra controller features */
> +	if (fsl_chan->set_src_loop_size)
> +		fsl_chan->set_src_loop_size(fsl_chan, slave->src_loop_size);
> +
> +	if (fsl_chan->set_dest_loop_size)
> +		fsl_chan->set_dest_loop_size(fsl_chan, slave->dst_loop_size);
> +
> +	if (fsl_chan->toggle_ext_start)
> +		fsl_chan->toggle_ext_start(fsl_chan, slave->external_start);
> +
> +	if (fsl_chan->toggle_ext_pause)
> +		fsl_chan->toggle_ext_pause(fsl_chan, slave->external_pause);

I just noticed that I got this wrong for external pause. It takes a
size, not a boolean enable/disable. I'll split the size out from the
external pause feature, and send another patch.

> +
> +	return &first->async_tx;
> +
