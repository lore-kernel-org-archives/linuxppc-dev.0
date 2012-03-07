Return-Path: <hartleys@visionengravers.com>
Received: from mail209.messagelabs.com (mail209.messagelabs.com [216.82.255.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail209.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A694DB6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 12:07:17 +1100 (EST)
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams
 <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Date: Tue, 6 Mar 2012 19:04:54 -0600
Subject: RE: [PATCH 6/9] dmaengine: consolidate tx_status functions
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF559AF@AUSP01VMBX24.collaborationhost.net>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yd-0002N1-76@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1S52yd-0002N1-76@rmk-PC.arm.linux.org.uk>
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

On Tuesday, March 06, 2012 3:35 PM, Russell King wrote:
>
> Now that we have the completed cookie in the dma_chan structure, we
> can consolidate the tx_status functions by providing a function to set
> the txstate structure and returning the DMA status.  We also provide
> a separate helper to set the residue for cookies which are still in
> progress.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

<snip>

>  drivers/dma/dmaengine.h     |   31 +++++++++++++++++++++++++++++++

<snip>

>  drivers/dma/ep93xx_dma.c    |    7 +------

<snip>

> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 47e0997..1ca5e0e 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -45,4 +45,35 @@ static inline void dma_cookie_complete(struct dma_asyn=
c_tx_descriptor *tx)
>  	tx->cookie =3D 0;
>  }
> =20
> +/**
> + * dma_cookie_status - report cookie status
> + * @chan: dma channel
> + * @cookie: cookie we are interested in
> + * @state: dma_tx_state structure to return last/used cookies
> + *
> + * Report the status of the cookie, filling in the state structure if
> + * non-NULL.  No locking is required.
> + */
> +static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
> +	dma_cookie_t cookie, struct dma_tx_state *state)
> +{
> +	dma_cookie_t used, complete;
> +
> +	used =3D chan->cookie;
> +	complete =3D chan->completed_cookie;
> +	barrier();
> +	if (state) {
> +		state->last =3D complete;
> +		state->used =3D used;
> +		state->residue =3D 0;
> +	}
> +	return dma_async_is_complete(cookie, complete, used);
> +}
> +
> +static inline void dma_set_residue(struct dma_tx_state *state, u32 resid=
ue)
> +{
> +	if (state)
> +		state->residue =3D residue;
> +}
> +
>  #endif

<snip>

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 1c56f75..142ebf0 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -1241,18 +1241,13 @@ static enum dma_status ep93xx_dma_tx_status(struc=
t dma_chan *chan,
>  					    struct dma_tx_state *state)
>  {
>  	struct ep93xx_dma_chan *edmac =3D to_ep93xx_dma_chan(chan);
> -	dma_cookie_t last_used, last_completed;
>  	enum dma_status ret;
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&edmac->lock, flags);
> -	last_used =3D chan->cookie;
> -	last_completed =3D chan->completed_cookie;
> +	ret =3D dma_cookie_status(chan, cookie, state);
>  	spin_unlock_irqrestore(&edmac->lock, flags);
> =20
> -	ret =3D dma_async_is_complete(cookie, last_completed, last_used);
> -	dma_set_tx_state(state, last_completed, last_used, 0);
> -
>  	return ret;
>  }
> =20

For ep93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
