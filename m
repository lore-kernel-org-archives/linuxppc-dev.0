Return-Path: <hartleys@visionengravers.com>
Received: from mail209.messagelabs.com (mail209.messagelabs.com [216.82.255.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail209.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C918AB6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 11:41:04 +1100 (EST)
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams
 <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Date: Tue, 6 Mar 2012 18:38:11 -0600
Subject: RE: [PATCH 2/9] dmaengine: move last completed cookie into generic
 dma_chan structure
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF559A5@AUSP01VMBX24.collaborationhost.net>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52xK-0002Mj-Af@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1S52xK-0002Mj-Af@rmk-PC.arm.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Barry Song <baohua.song@csr.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday, March 06, 2012 3:34 PM, Russell King wrote:
>
> Every DMA engine implementation declares a last completed dma cookie
> in their private dma channel structures.  This is pointless, and
> forces driver specific code.  Move this out into the common dma_chan
> structure.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

<snip>

 drivers/dma/ep93xx_dma.c                 |    8 +++-----

<snip>

 include/linux/dmaengine.h                |    2 ++

<snip>

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 59e7a96..bc45787 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -122,7 +122,6 @@ struct ep93xx_dma_desc {
>   * @lock: lock protecting the fields following
>   * @flags: flags for the channel
>   * @buffer: which buffer to use next (0/1)
> - * @last_completed: last completed cookie value
>   * @active: flattened chain of descriptors currently being processed
>   * @queue: pending descriptors which are handled next
>   * @free_list: list of free descriptors which can be used
> @@ -157,7 +156,6 @@ struct ep93xx_dma_chan {
>  #define EP93XX_DMA_IS_CYCLIC		0
> =20
>  	int				buffer;
> -	dma_cookie_t			last_completed;
>  	struct list_head		active;
>  	struct list_head		queue;
>  	struct list_head		free_list;
> @@ -703,7 +701,7 @@ static void ep93xx_dma_tasklet(unsigned long data)
>  	desc =3D ep93xx_dma_get_active(edmac);
>  	if (desc) {
>  		if (desc->complete) {
> -			edmac->last_completed =3D desc->txd.cookie;
> +			edmac->chan.completed_cookie =3D desc->txd.cookie;
>  			list_splice_init(&edmac->active, &list);
>  		}
>  		callback =3D desc->txd.callback;
> @@ -861,7 +859,7 @@ static int ep93xx_dma_alloc_chan_resources(struct dma=
_chan *chan)
>  		goto fail_clk_disable;
> =20
>  	spin_lock_irq(&edmac->lock);
> -	edmac->last_completed =3D 1;
> +	edmac->chan.completed_cookie =3D 1;
>  	edmac->chan.cookie =3D 1;
>  	ret =3D edmac->edma->hw_setup(edmac);
>  	spin_unlock_irq(&edmac->lock);
> @@ -1254,7 +1252,7 @@ static enum dma_status ep93xx_dma_tx_status(struct =
dma_chan *chan,
> =20
>  	spin_lock_irqsave(&edmac->lock, flags);
>  	last_used =3D chan->cookie;
> -	last_completed =3D edmac->last_completed;
> +	last_completed =3D chan->completed_cookie;
>  	spin_unlock_irqrestore(&edmac->lock, flags);
> =20
>  	ret =3D dma_async_is_complete(cookie, last_completed, last_used);

<snip>

> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 679b349..41d0f92 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -257,6 +257,7 @@ struct dma_chan_percpu {
>   * struct dma_chan - devices supply DMA channels, clients use them
>   * @device: ptr to the dma device who supplies this channel, always !%NU=
LL
>   * @cookie: last cookie value returned to client
> + * @completed_cookie: last completed cookie for this channel
>   * @chan_id: channel ID for sysfs
>   * @dev: class device for sysfs
>   * @device_node: used to add this to the device chan list
> @@ -268,6 +269,7 @@ struct dma_chan_percpu {
>  struct dma_chan {
>  	struct dma_device *device;
>  	dma_cookie_t cookie;
> +	dma_cookie_t completed_cookie;
> =20
>  	/* sysfs */
>  	int chan_id;

For ep93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
