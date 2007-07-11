Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 47364DDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 02:34:49 +1000 (EST)
Date: Wed, 11 Jul 2007 11:34:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Zhang Wei <wei.zhang@freescale.com>
Subject: Re: [PATCH 4/4] Add DMA engine driver for Freescale MPC8xxx
	processors.
Message-ID: <20070711163438.GA17293@ld0162-tx32.am.freescale.net>
References: <11840607262279-git-send-email-wei.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11840607262279-git-send-email-wei.zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 05:45:26PM +0800, Zhang Wei wrote:
> +config FSL_DMA
> +	bool "Freescale MPC8xxx DMA support"
> +	depends on DMA_ENGINE && (PPC_86xx || PPC_85xx)

Remove the dependency on specific PPC chips...  let the device tree say
whether the hardware is present.

> +static inline int fsl_dma_idle(struct fsl_dma_chan *fsl_chan)
> +{
> +	return (((in_be32(&fsl_chan->reg_base->sr) & FSL_DMA_SR_CB) == 0) &&
> +		((in_be32(&fsl_chan->reg_base->mr) & FSL_DMA_MR_CC) == 0));
> +}

I'm still not convinced that there's any reason to check MR_CC, even if
the driver *did* set it.

> +	/* We need the descriptor to be aligned to 32bytes
> +	 * for meeting FSL DMA specification requirement.
> +	 */
> +	fsl_chan->desc_pool = dma_pool_create("fsl_dma_engine_desc_pool",
> +			fsl_chan->device->dev, sizeof(struct fsl_desc_sw),
> +			32, 0);
> +	if (unlikely(!fsl_chan->desc_pool)) {
> +		dev_err(fsl_chan->device->dev, "No memory for channel %d "
> +			"descriptor dma pool.\n", fsl_chan->id);
> +		return 0;
> +	}
> +
> +	/* Allocate list ring, and form the static list ring */
> +	for (i = 0; i < FSLDMA_LD_INIT_RING_SIZE; i++) {
> +		desc = fsl_dma_alloc_descriptor(fsl_chan->desc_pool,
> +				GFP_KERNEL);

It'd be much simpler to allocate the entire ring at once.  No need for
linked lists, DMA pools, etc.  Just a single dma_alloc_coherent.

In general, this driver seems far more complex than it needs to be.

> +		switch (fsl_chan->mode) {
> +		case FSL_DMA_EXTENDED:

What benefit do we get out of using extended mode?  If the driver can do
everything it needs to with basic, with no performance penalty, why not
always use basic?

> +static dma_cookie_t do_fsl_dma_memcpy(struct fsl_dma_chan *fsl_chan,
> +				      dma_addr_t dest,
> +				      dma_addr_t src, size_t len,
> +				      dma_xfer_callback cb, void *data)
> +{
> +	struct fsl_desc_sw *first = NULL, *prev = NULL, *list, *new;
> +	size_t copy;
> +	dma_cookie_t cookie;
> +	unsigned long flags;
> +	struct fsl_dma_device *fdev = fsl_chan->device;
> +	int err = 0;
> +	LIST_HEAD(link_chain);
> +
> +	if (unlikely(!fsl_chan || !dest || !src))
> +		return -EFAULT;

-EINVAL for fsl_chan, if you bother checking at all (I wouldn't; it
doesn't come from untrusted code.  Better to show a nasty-looking oops to
bring attention to the problem).

Don't check dest and src against NULL; zero is a potentially valid DMA
address.

> +		/* Stop the DMA */
> +		fsl_dma_halt(fsl_chan);
> +		/* Insert the ld descriptor to the LD ring */
> +		list_add(&ld->node, fsl_chan->enque);
> +		switch (fsl_chan->mode) {
> +		case FSL_DMA_EXTENDED:
> +			INSERT_LD_RING(fsl_chan, ld, list, next_ls_addr);
> +			break;
> +		case FSL_DMA_BASIC:
> +			INSERT_LD_RING(fsl_chan, ld, link, next_ln_addr);
> +			break;
> +		}
> +		spin_unlock_irqrestore(&fsl_chan->desc_lock, flags);

It'd be nice if we didn't have to stop the DMA in order to insert new
descriptors.

> +	/* cookie incr and addition to used_list must be atomic */
> +	cookie = fsl_chan->common.cookie;
> +	cookie++;
> +	if (cookie < 0)
> +		cookie = 1;

Why not just use the index into the ring as the cookie?

> +	stat = in_be32(&fsl_chan->reg_base->sr);
> +	dev_dbg(fsl_chan->device->dev, "event: channel %d, stat = 0x%x\n",
> +						fsl_chan->id, stat);
> +	if (!stat)
> +		return IRQ_NONE;
> +	busy = stat & (FSL_DMA_SR_CB);
> +	stat &= ~(FSL_DMA_SR_CB | FSL_DMA_SR_CH);

This masking must happen *before* the IRQ_NONE check.

-Scott
