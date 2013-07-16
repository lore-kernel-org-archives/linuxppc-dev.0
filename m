Return-Path: <lars@metafoo.de>
Received: from smtp-out-221.synserver.de (smtp-out-221.synserver.de
 [212.40.185.221]) by ozlabs.org (Postfix) with ESMTP id 209212C0163
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 20:36:53 +1000 (EST)
Message-ID: <51E5226D.9050100@metafoo.de>
Date: Tue, 16 Jul 2013 12:37:33 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH RFC v2 2/5] dma: mpc512x: add support for peripheral
 transfers
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
 <1373803321-11628-1-git-send-email-gsi@denx.de>
 <1373803321-11628-3-git-send-email-gsi@denx.de>
In-Reply-To: <1373803321-11628-3-git-send-email-gsi@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, Vinod Koul <vinod.koul@intel.com>,
 devicetree-discuss@lists.ozlabs.org, Alexander Popov <a13xp0p0v88@gmail.com>,
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

On 07/14/2013 02:01 PM, Gerhard Sittig wrote:
> From: Alexander Popov <a13xp0p0v88@gmail.com>
> 
> introduce support for slave s/g transfer preparation and the associated
> device control callback in the MPC512x DMA controller driver, which adds
> support for data transfers between memory and peripheral I/O to the
> previously supported mem-to-mem transfers
> 
> refuse to prepare chunked transfers (transfers with more than one part)
> as long as proper support for scatter/gather is lacking
> 
> keep MPC8308 operational by always starting transfers from software,
> this SoC appears to not have request lines for flow control when
> peripherals are involved in transfers

I had a look at the current driver and it seems that any channel can be used
for memcpy operation not only the MDDRC channel. Since the dmaengine API
will just pick one of the currently free channels when performing a memcpy
operation I think this patch breaks memcpy operations. You probably need to
register two dma controllers, one for memcpy operations one for slave
operations, that way you can ensure that only the MDDRC channel is used for
memcpy operations.

> 
> [ introduction of slave s/g preparation and device control ]
> Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
> [ execute() start condition, mpc8308 compat, terminate all, s/g length check, reworded commit msg ]
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
[...]
> +
> +static int mpc_dma_device_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
> +				  unsigned long arg)
> +{
> +	struct mpc_dma_chan *mchan;
> +	struct mpc_dma *mdma;
> +	struct dma_slave_config *cfg;
> +
> +	mchan = dma_chan_to_mpc_dma_chan(chan);
> +	switch (cmd) {
> +	case DMA_TERMINATE_ALL:
> +		/* disable channel requests */
> +		mdma = dma_chan_to_mpc_dma(chan);
> +		out_8(&mdma->regs->dmacerq, chan->chan_id);
> +		list_splice_tail_init(&mchan->prepared, &mchan->free);
> +		list_splice_tail_init(&mchan->queued, &mchan->free);
> +		list_splice_tail_init(&mchan->active, &mchan->free);

This probably need locking.

> +		return 0;
[...]
> +}
> +
