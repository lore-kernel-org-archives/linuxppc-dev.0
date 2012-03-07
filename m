Return-Path: <hartleys@visionengravers.com>
Received: from mail209.messagelabs.com (mail209.messagelabs.com [216.82.255.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail209.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2B1C1B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 11:55:50 +1100 (EST)
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams
 <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Date: Tue, 6 Mar 2012 18:53:27 -0600
Subject: RE: [PATCH 4/9] dmaengine: consolidate assignment of DMA cookies
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF559AB@AUSP01VMBX24.collaborationhost.net>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52xy-0002Ms-Ud@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1S52xy-0002Ms-Ud@rmk-PC.arm.linux.org.uk>
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
> Everyone deals with assigning DMA cookies in the same way (it's part of
> the API so they should be), so lets consolidate the common code into a
> helper function to avoid this duplication.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

<snip>

>  drivers/dma/dmaengine.h     |   20 ++++++++++++++++++++

<snip>

>  drivers/dma/ep93xx_dma.c    |    9 +--------

<snip>

> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 968570d..7692c86 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -7,4 +7,24 @@
> =20
>  #include <linux/dmaengine.h>
> =20
> +/**
> + * dma_cookie_assign - assign a DMA engine cookie to the descriptor
> + * @tx: descriptor needing cookie
> + *
> + * Assign a unique non-zero per-channel cookie to the descriptor.
> + * Note: caller is expected to hold a lock to prevent concurrency.
> + */
> +static inline dma_cookie_t dma_cookie_assign(struct dma_async_tx_descrip=
tor *tx)
> +{
> +	struct dma_chan *chan =3D tx->chan;
> +	dma_cookie_t cookie;
> +
> +	cookie =3D chan->cookie + 1;
> +	if (cookie < DMA_MIN_COOKIE)
> +		cookie =3D DMA_MIN_COOKIE;
> +	tx->cookie =3D chan->cookie =3D cookie;
> +
> +	return cookie;
> +}
> +
>  #endif

<snip>

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index 3260198..e5aaae8 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -783,17 +783,10 @@ static dma_cookie_t ep93xx_dma_tx_submit(struct dma=
_async_tx_descriptor *tx)
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&edmac->lock, flags);
> -
> -	cookie =3D edmac->chan.cookie;
> -
> -	if (++cookie < 0)
> -		cookie =3D 1;
> +	cookie =3D dma_cookie_assign(tx);
> =20
>  	desc =3D container_of(tx, struct ep93xx_dma_desc, txd);
> =20
> -	edmac->chan.cookie =3D cookie;
> -	desc->txd.cookie =3D cookie;
> -
>  	/*
>  	 * If nothing is currently prosessed, we push this descriptor
>  	 * directly to the hardware. Otherwise we put the descriptor

For ep93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
