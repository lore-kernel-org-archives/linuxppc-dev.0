Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by ozlabs.org (Postfix) with ESMTP id 2D55D2C0105
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Mar 2014 20:47:57 +1100 (EST)
Message-ID: <1394790471.28803.247.camel@smile.fi.intel.com>
Subject: Re: [PATCH RFC v9 2/6] dma: mpc512x: add support for peripheral
 transfers
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alexander Popov <a13xp0p0v88@gmail.com>
Date: Fri, 14 Mar 2014 11:47:51 +0200
In-Reply-To: <1394624875-24411-3-git-send-email-a13xp0p0v88@gmail.com>
References: <1394624875-24411-1-git-send-email-a13xp0p0v88@gmail.com>
 <1394624875-24411-3-git-send-email-a13xp0p0v88@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-03-12 at 15:47 +0400, Alexander Popov wrote:
> Introduce support for slave s/g transfer preparation and the associated
> device control callback in the MPC512x DMA controller driver, which adds
> support for data transfers between memory and peripheral I/O to the
> previously supported mem-to-mem transfers.


> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> @@ -2,6 +2,7 @@
>   * Copyright (C) Freescale Semicondutor, Inc. 2007, 2008.
>   * Copyright (C) Semihalf 2009
>   * Copyright (C) Ilya Yanok, Emcraft Systems 2010
> + * Copyright (C) Alexander Popov, Promcontroller 2013

2014?

[]

> +static int mpc_dma_device_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +							unsigned long arg)
> +{
> +	struct mpc_dma_chan *mchan;
> +	struct mpc_dma *mdma;
> +	struct dma_slave_config *cfg;
> +	unsigned long flags;
> +
> +	mchan = dma_chan_to_mpc_dma_chan(chan);
> +	switch (cmd) {
> +	case DMA_TERMINATE_ALL:
> +		/* Disable channel requests */
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
> +		/* Constraints:
> +		 *  - only transfers between a peripheral device and
> +		 *     memory are supported;
> +		 *  - minimal transfer chunk is 4 bytes and consequently
> +		 *     source and destination addresses must be 4-byte aligned
> +		 *     and transfer size must be aligned on (4 * maxburst)
> +		 *     boundary;
> +		 *  - during the transfer RAM address is being incremented by
> +		 *     the size of minimal transfer chunk;
> +		 *  - peripheral port's address is constant during the transfer.
> +		 */
> +
> +		cfg = (void *)arg;
> +
> +		if (!is_slave_direction(cfg->direction))
> +			return -EINVAL;

As far as I understand the intention you have not to use direction field
in the dma_slave_config. It will be removed once.

> +
> +		if (cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES &&
> +			cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
> +			return -EINVAL;
> +
> +		spin_lock_irqsave(&mchan->lock, flags);
> +
> +		if (cfg->direction == DMA_DEV_TO_MEM) {
> +			mchan->per_paddr = cfg->src_addr;
> +			mchan->tcd_nunits = cfg->src_maxburst;
> +		} else {
> +			mchan->per_paddr = cfg->dst_addr;
> +			mchan->tcd_nunits = cfg->dst_maxburst;
> +		}

Ditto.


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
