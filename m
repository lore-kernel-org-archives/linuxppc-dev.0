Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 820622C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Feb 2014 11:07:49 +1100 (EST)
Date: Thu, 13 Feb 2014 01:07:43 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v7 2/6] dma: mpc512x: add support for peripheral
 transfers
Message-ID: <20140213000743.GI4524@book.gsilab.sittig.org>
References: <1392211508-23615-1-git-send-email-a13xp0p0v88@gmail.com>
 <1392211508-23615-3-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1392211508-23615-3-git-send-email-a13xp0p0v88@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ removed DT from Cc: ]

On Wed, Feb 12, 2014 at 17:25 +0400, Alexander Popov wrote:
> 
> Introduce support for slave s/g transfer preparation and the associated
> device control callback in the MPC512x DMA controller driver, which adds
> support for data transfers between memory and peripheral I/O to the
> previously supported mem-to-mem transfers.
> 
> [ ... ]

> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> [ ... ]

> @@ -29,8 +30,15 @@
>   */
>  
>  /*
> - * This is initial version of MPC5121 DMA driver. Only memory to memory
> - * transfers are supported (tested using dmatest module).
> + * MPC512x and MPC8308 DMA driver. It supports
> + * memory to memory data transfers (tested using dmatest module) and
> + * data transfers between memory and peripheral I/O memory
> + * by means of slave s/g with these limitations:
> + * - chunked transfers (transfers with more than one part) are refused
> + * as long as proper support for scatter/gather is missing;
> + * - transfers on MPC8308 always start from software as this SoC appears
> + * not to have external request lines for peripheral flow control;
> + * - minimal memory <-> I/O memory transfer size is 4 bytes.
>   */

Often I assume people would notice themselves, and apparently I'm
wrong. :)  Can you adjust the formatting such (here and
elsewhere) that the bullet list is clearly visible as such?
Flowing text like above obfuscates the fact that the content may
have a structure ...

There are known limitations which are not listed here, "minimal
transfer size" is incomplete.  It appears that you assume
constraints on start addresses as well as sizes/lengths.  Can you
update the documentation to match the implementation?

> @@ -251,8 +264,21 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
>  	struct mpc_dma_desc *mdesc;
>  	int cid = mchan->chan.chan_id;
>  
> -	/* Move all queued descriptors to active list */
> -	list_splice_tail_init(&mchan->queued, &mchan->active);
> +	while (!list_empty(&mchan->queued)) {
> +		mdesc = list_first_entry(&mchan->queued,
> +						struct mpc_dma_desc, node);
> +
> +		/* Grab either several mem-to-mem transfer descriptors
> +		 * or one peripheral transfer descriptor,
> +		 * don't mix mem-to-mem and peripheral transfer descriptors
> +		 * within the same 'active' list. */
> +		if (mdesc->will_access_peripheral) {
> +			if (list_empty(&mchan->active))
> +				list_move_tail(&mdesc->node, &mchan->active);
> +			break;
> +		} else
> +			list_move_tail(&mdesc->node, &mchan->active);
> +	}
>  
>  	/* Chain descriptors into one transaction */
>  	list_for_each_entry(mdesc, &mchan->active, node) {

There are style issues.  Both in multi line comments, and in the
braces of the if/else block.

> @@ -643,6 +680,186 @@ mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
>  	return &mdesc->desc;
>  }
>  
> +static struct dma_async_tx_descriptor *
> +mpc_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	struct mpc_dma *mdma = dma_chan_to_mpc_dma(chan);
> +	struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
> +	struct mpc_dma_desc *mdesc = NULL;
> +	dma_addr_t per_paddr;
> +	u32 tcd_nunits;
> +	struct mpc_dma_tcd *tcd;
> +	unsigned long iflags;
> +	struct scatterlist *sg;
> +	size_t len;
> +	int iter, i;

Personally I much dislike this style of mixing declarations and
instructions.  But others may disagree, and strongly so.

> +
> +	/* currently there is no proper support for scatter/gather */
> +	if (sg_len != 1)
> +		return NULL;
> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		spin_lock_irqsave(&mchan->lock, iflags);
> +
> +		mdesc = list_first_entry(&mchan->free, struct mpc_dma_desc,
> +									node);

style (continuation and indentation)

> +		if (!mdesc) {
> +			spin_unlock_irqrestore(&mchan->lock, iflags);
> +			/* try to free completed descriptors */
> +			mpc_dma_process_completed(mdma);
> +			return NULL;
> +		}
> +
> +		list_del(&mdesc->node);
> +
> +		per_paddr = mchan->per_paddr;
> +		tcd_nunits = mchan->tcd_nunits;
> +
> +		spin_unlock_irqrestore(&mchan->lock, iflags);
> +
> +		if (per_paddr == 0 || tcd_nunits == 0)
> +			goto err_prep;
> +
> +		mdesc->error = 0;
> +		mdesc->will_access_peripheral = 1;
> +		tcd = mdesc->tcd;
> +
> +		/* Prepare Transfer Control Descriptor for this transaction */
> +
> +		memset(tcd, 0, sizeof(struct mpc_dma_tcd));
> +
> +		if (!IS_ALIGNED(sg_dma_address(sg), 4))
> +			goto err_prep;

You found multiple ways of encoding the "4 byte alignment", using
both the fixed number as well as (several) symbolic identifiers.
Can you look into making them use the same condition if the same
motivation is behind the test?

> +
> +		if (direction == DMA_DEV_TO_MEM) {
> +			tcd->saddr = per_paddr;
> +			tcd->daddr = sg_dma_address(sg);
> +			tcd->soff = 0;
> +			tcd->doff = 4;
> +		} else if (direction == DMA_MEM_TO_DEV) {
> +			tcd->saddr = sg_dma_address(sg);
> +			tcd->daddr = per_paddr;
> +			tcd->soff = 4;
> +			tcd->doff = 0;
> +		} else
> +			goto err_prep;
> +
> +		tcd->ssize = MPC_DMA_TSIZE_4;
> +		tcd->dsize = MPC_DMA_TSIZE_4;
> +
> +		len = sg_dma_len(sg);
> +		tcd->nbytes = tcd_nunits * 4;
> +		if (!IS_ALIGNED(len, tcd->nbytes))
> +			goto err_prep;
> +
> +		iter = len / tcd->nbytes;
> +		if (iter >= 1 << 15) {
> +			/* len is too big */
> +			goto err_prep;
> +		} else {
> +			/* citer_linkch contains the high bits of iter */
> +			tcd->biter = iter & 0x1ff;
> +			tcd->biter_linkch = iter >> 9;
> +			tcd->citer = tcd->biter;
> +			tcd->citer_linkch = tcd->biter_linkch;
> +		}
> +
> +		tcd->e_sg = 0;
> +		tcd->d_req = 1;
> +
> +		/* Place descriptor in prepared list */
> +		spin_lock_irqsave(&mchan->lock, iflags);
> +		list_add_tail(&mdesc->node, &mchan->prepared);
> +		spin_unlock_irqrestore(&mchan->lock, iflags);
> +	}
> +
> +	return &mdesc->desc;
> +
> +err_prep:
> +	/* Put the descriptor back */
> +	spin_lock_irqsave(&mchan->lock, iflags);
> +	list_add_tail(&mdesc->node, &mchan->free);
> +	spin_unlock_irqrestore(&mchan->lock, iflags);
> +
> +	return NULL;
> +}


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
