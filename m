Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A0A6F2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Oct 2013 22:10:52 +1100 (EST)
Date: Sun, 6 Oct 2013 13:10:38 +0200
From: Gerhard Sittig <gsi@denx.de>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Subject: Re: [PATCH RFC v4 2/5] dma: mpc512x: add support for peripheral
 transfers
Message-ID: <20131006111038.GN14747@book.gsilab.sittig.org>
References: <1380809202-16192-1-git-send-email-a13xp0p0v88@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380809202-16192-1-git-send-email-a13xp0p0v88@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, devicetree-discuss@lists.ozlabs.org,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 03, 2013 at 18:06 +0400, Alexander Popov wrote:
> 
> Introduce support for slave s/g transfer preparation and the associated
> device control callback in the MPC512x DMA controller driver, which adds
> support for data transfers between memory and peripheral I/O to the
> previously supported mem-to-mem transfers.
> 
> Refuse to prepare chunked transfers (transfers with more than one part)
> as long as proper support for scatter/gather is lacking.
> 
> Keep MPC8308 operational by always starting transfers from software,
> this SoC appears to not have request lines for flow control when
> peripherals are involved in transfers.
> 
> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
> ---
>  drivers/dma/mpc512x_dma.c | 201 ++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 193 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
> index f41639f..d0c8950 100644
> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> [ ... ]


> @@ -28,11 +29,6 @@
>   * file called COPYING.
>   */
>  
> -/*
> - * This is initial version of MPC5121 DMA driver. Only memory to memory
> - * transfers are supported (tested using dmatest module).
> - */
> -
>  #include <linux/module.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dma-mapping.h>

You may want to keep the comment in this location after updating
it.  It's worth remaining aware of the current status, missing
features and/or known limitations.  And there _are_ (acceptable
yet worth tracking) issues at this stage of the implementation.

> @@ -187,6 +183,7 @@ struct mpc_dma_desc {
>  	dma_addr_t			tcd_paddr;
>  	int				error;
>  	struct list_head		node;
> +	int				will_access_peripheral;
>  };
>  
>  struct mpc_dma_chan {
> @@ -199,6 +196,10 @@ struct mpc_dma_chan {
>  	struct mpc_dma_tcd		*tcd;
>  	dma_addr_t			tcd_paddr;
>  
> +	/* Settings for access to peripheral FIFO */
> +	dma_addr_t			per_paddr;	/* FIFO address */
> +	u32				tcd_nunits;
> +
>  	/* Lock for this structure */
>  	spinlock_t			lock;
>  };
> @@ -247,10 +248,27 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
>  	struct mpc_dma_desc *first = NULL;
>  	struct mpc_dma_desc *prev = NULL;
>  	struct mpc_dma_desc *mdesc;
> +	int staffed = 0;
>  	int cid = mchan->chan.chan_id;
>  
> -	/* Move all queued descriptors to active list */
> -	list_splice_tail_init(&mchan->queued, &mchan->active);
> +	/*
> +	 * Mem-to-mem transfers can be chained
> +	 * together into one transaction.
> +	 * But each transfer which involves peripherals
> +	 * must be executed separately.
> +	 */
> +	while (!staffed) {
> +		mdesc = list_first_entry(&mchan->queued,
> +						struct mpc_dma_desc, node);
> +
> +		if (!mdesc->will_access_peripheral)
> +			list_move_tail(&mdesc->node, &mchan->active);
> +		else {
> +			staffed = 1;
> +			if (list_empty(&mchan->active))
> +				list_move_tail(&mdesc->node, &mchan->active);
> +		}
> +	}
>  
>  	/* Chain descriptors into one transaction */
>  	list_for_each_entry(mdesc, &mchan->active, node) {

Use of 'break' may eliminate the necessity of the 'staffed'
variable, the name of which somehow feels weird, yet I cannot
come up with a better name.  Having explicit abort checks in the
collection loop might better reflect the intention.

The loop's logic looks suspicious.  I'm afraid daemons start
flying in the absence of peripheral transfers (memory only
transfers won't terminate the loop).

It took me a while to find out what the intension is and whether
the code meets the intention.  A comment could help here (grab
either memory or peripheral transfers, don't mix peripheral and
memory transfers within the same 'active' list, grab at most one
peripheral transfer, assumes that the 'queued' list isn't empty).
Some conditions may be documented above the function and thus the
comment is in the file and only "missing" in the patch's context.
The comment might be obsolete if termination conditions before
'break' already carry useful enough information.

> @@ -264,6 +282,8 @@ static void mpc_dma_execute(struct mpc_dma_chan *mchan)
>  
>  		prev->tcd->dlast_sga = mdesc->tcd_paddr;
>  		prev->tcd->e_sg = 1;
> +
> +		/* software start for mem-to-mem transfers */
>  		mdesc->tcd->start = 1;
>  
>  		prev = mdesc;

This is inside _execute() and the code doesn't tell apart memory
or peripheral transfers.  So either the code does something wrong
or the comment is (has become?) obsolete or misleading.  Needs to
get re-checked.

> @@ -641,6 +672,157 @@ mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
>  	return &mdesc->desc;
>  }
>  
> +static struct dma_async_tx_descriptor *mpc_dma_prep_slave_sg(
> +		struct dma_chan *chan, struct scatterlist *sgl,
> +		unsigned int sg_len, enum dma_transfer_direction direction,
> +		unsigned long flags, void *context)
> +{
> +	struct mpc_dma *mdma = dma_chan_to_mpc_dma(chan);
> +	struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
> +	struct mpc_dma_desc *mdesc = NULL;
> +	dma_addr_t per_paddr;
> +	u32 tcd_nunits = 0;
> +	struct mpc_dma_tcd *tcd;
> +	unsigned long iflags;
> +	struct scatterlist *sg;
> +	size_t len;
> +	int iter, i;
> +
> +	if (!list_empty(&mchan->active))
> +		return NULL;

What's the intention of this check, and is it actually necessary?

Is _preparing_ a transfer forbidden while the hardware is busy
running another transfer (or postprocessing just has not yet
completed)?  I don't think so (but might miss a DMA engine API
requirement).

I feel that the DMA engine driver should happily allow for
preparation and submission of transfers, while the _execute()
logic automatically controls flow of queued transfers to the
hardware execution.  It's a useful feature when clients can setup
the next transfer while the current transfer still is in progress
(isn't this the motivation of having DMA at all?).

> +
> +	/* currently there is no proper support for scatter/gather */
> +	if (sg_len > 1)
> +		return NULL;

That's a TODO or known limitation item for the top of the file.

> +
> +	for_each_sg(sgl, sg, sg_len, i) {
> +		spin_lock_irqsave(&mchan->lock, iflags);
> +
> +		mdesc = list_first_entry(&mchan->free, struct mpc_dma_desc,
> +									node);
> +		if (!mdesc) {
> +			spin_unlock_irqrestore(&mchan->lock, iflags);
> +			/* try to free completed descriptors */
> +			mpc_dma_process_completed(mdma);
> +			return NULL;
> +		}
> +
> +		list_del(&mdesc->node);

>From here on 'mdesc' is neither in the 'free' nor in the
'prepared' lists.  Returning when conditions aren't met will leak
the entry.  Error handling is required.

> +
> +		per_paddr = mchan->per_paddr;
> +		tcd_nunits = mchan->tcd_nunits;
> +
> +		spin_unlock_irqrestore(&mchan->lock, iflags);
> +
> +		mdesc->error = 0;
> +		mdesc->will_access_peripheral = 1;
> +		tcd = mdesc->tcd;
> +
> +		/* Prepare Transfer Control Descriptor for this transaction */
> +		memset(tcd, 0, sizeof(struct mpc_dma_tcd));
> +
> +		if (!IS_ALIGNED(sg_dma_address(sg), 4))
> +			return NULL;
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
> +		} else {
> +			return NULL;
> +		}
> +		tcd->ssize = MPC_DMA_TSIZE_4;
> +		tcd->dsize = MPC_DMA_TSIZE_4;

These checks and assignments hardcode a port size and transfer
item address increment of 4 bytes.  In the future this may need
to become more flexible, until then it's certainly worth keeping
track of (remaining aware of).  If preparation enforces such a
constraint, it may be worth checking/signalling in the setup
phase already as well (the device control routine below).

Remember, use in combination with LPC may be the _motivation_ of
your current work, but this is the DMA controller backend driver
which would be great if it could cooperate with any other
peripheral driver which happens to or tries to use DMA as well
(including future potential UART/SPI/I2S peripheral drivers,
MMC/SD card drivers, or GPIO triggered data transfers with
arbitrary characteristics).


NB:  Is there a means to specify peripheral transfers which
_don't_ increment the RAM address (could be useful for SPI, to
send dummy TX bytes or to ignore RX data of arbitrary length
without allocating huge buffers), or peripheral transfers which
_do_ increment the peripheral "port's" address (might apply to
memory mapped flash controllers).  It's not essential here, just
crossed my mind ...


> +
> +		len = sg_dma_len(sg);
> +
> +		if (tcd_nunits)
> +			tcd->nbytes = tcd_nunits * 4;
> +		else
> +			return NULL;

I'm afraid that _insisting_ in all DMA clients to provide the
'nunits' parameter ('maxburst' in device control) might be too
specific a constraint.

Clients may not be aware of the necessity, since the idea is to
abstract away the specifics of the backend (DMA controller).
Please consider whether a useful default can be applied in the
absence of an explicit client request.  Make the driver as
interoperable as useful, don't restrict yourself to a few
specific clients or just one client that you currently are
focussed on.

> +
> +		if (!IS_ALIGNED(len, tcd->nbytes))
> +			return NULL;
> +
> +		iter = len / tcd->nbytes;
> +		if (iter > ((1 << 15) - 1)) {   /* maximum biter */

nit: 'iter >= 1 << 15' is shorter and maybe easier to read (might
better reflect that you want to not exceed the 15bit field)

> +			return NULL; /* len is too big */
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
> +}
> +
> +static int mpc_dma_device_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +				  unsigned long arg)
> +{
> +	struct mpc_dma_chan *mchan;
> +	struct mpc_dma *mdma;
> +	struct dma_slave_config *cfg;
> +	unsigned long flags;
> +
> +	mchan = dma_chan_to_mpc_dma_chan(chan);
> +	switch (cmd) {
> +	case DMA_TERMINATE_ALL:
> +		/* disable channel requests */
> +		mdma = dma_chan_to_mpc_dma(chan);
> +
> +		spin_lock_irqsave(&mchan->lock, flags);
> +
> +		out_8(&mdma->regs->dmacerq, chan->chan_id);
> +		list_splice_tail_init(&mchan->prepared, &mchan->free);
> +		list_splice_tail_init(&mchan->queued, &mchan->free);
> +		list_splice_tail_init(&mchan->active, &mchan->free);
> +
> +		spin_unlock_irqrestore(&mchan->lock, flags);
> +
> +		return 0;
> +	case DMA_SLAVE_CONFIG:
> +		cfg = (void *)arg;
> +		if (cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES &&
> +		    cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
> +			return -EINVAL;

Ah, the addr_width is getting checked, good.  I've missed this
before.

Might as well want to check maxburst values here, and optionally
apply a default?

> +
> +		spin_lock_irqsave(&mchan->lock, flags);
> +
> +		if (cfg->direction == DMA_DEV_TO_MEM) {

Note that cfg->direction is of a different type than
DMA_DEV_TO_MEM (of different type than the 'direction' parameter
in the preparation routine) -- it's mere coincidence that the
numeric values happen to match at the moment.

> +			mchan->per_paddr = cfg->src_addr;
> +			mchan->tcd_nunits = cfg->src_maxburst;
> +		} else {
> +			mchan->per_paddr = cfg->dst_addr;
> +			mchan->tcd_nunits = cfg->dst_maxburst;
> +		}
> +
> +		spin_unlock_irqrestore(&mchan->lock, flags);
> +
> +		return 0;
> +	default:
> +		return -ENOSYS;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int mpc_dma_probe(struct platform_device *op)
>  {
>  	struct device_node *dn = op->dev.of_node;


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
