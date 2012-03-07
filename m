Return-Path: <hartleys@visionengravers.com>
Received: from mail131.messagelabs.com (mail131.messagelabs.com
 [216.82.242.99])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail131.messagelabs.com",
 Issuer "VeriSign Class 3 International Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 57062B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 11:59:09 +1100 (EST)
From: H Hartley Sweeten <hartleys@visionengravers.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Dan Williams
 <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>
Date: Tue, 6 Mar 2012 18:56:45 -0600
Subject: RE: [PATCH 5/9] dmaengine: provide a common function for completing
 a dma descriptor
Message-ID: <ADE657CA350FB648AAC2C43247A983F001F41FF559AD@AUSP01VMBX24.collaborationhost.net>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
 <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
In-Reply-To: <E1S52yJ-0002Mx-2e@rmk-PC.arm.linux.org.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
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
> Provide a common function to do the cookie mechanics for completing
> a DMA descriptor.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

<snip>

>  drivers/dma/dmaengine.h     |   18 ++++++++++++++++++

<snip>

>  drivers/dma/ep93xx_dma.c    |    2 +-

<snip>

> diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
> index 7692c86..47e0997 100644
> --- a/drivers/dma/dmaengine.h
> +++ b/drivers/dma/dmaengine.h
> @@ -5,6 +5,7 @@
>  #ifndef DMAENGINE_H
>  #define DMAENGINE_H
> =20
> +#include <linux/bug.h>
>  #include <linux/dmaengine.h>
> =20
>  /**
> @@ -27,4 +28,21 @@ static inline dma_cookie_t dma_cookie_assign(struct dm=
a_async_tx_descriptor *tx)
>  	return cookie;
>  }
> =20
> +/**
> + * dma_cookie_complete - complete a descriptor
> + * @tx: descriptor to complete
> + *
> + * Mark this descriptor complete by updating the channels completed
> + * cookie marker.  Zero the descriptors cookie to prevent accidental
> + * repeated completions.
> + *
> + * Note: caller is expected to hold a lock to prevent concurrency.
> + */
> +static inline void dma_cookie_complete(struct dma_async_tx_descriptor *t=
x)
> +{
> +	BUG_ON(tx->cookie < DMA_MIN_COOKIE);
> +	tx->chan->completed_cookie =3D tx->cookie;
> +	tx->cookie =3D 0;
> +}
> +
>  #endif

<snip>

> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index e5aaae8..1c56f75 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -703,7 +703,7 @@ static void ep93xx_dma_tasklet(unsigned long data)
>  	desc =3D ep93xx_dma_get_active(edmac);
>  	if (desc) {
>  		if (desc->complete) {
> -			edmac->chan.completed_cookie =3D desc->txd.cookie;
> +			dma_cookie_complete(&desc->txd);
>  			list_splice_init(&edmac->active, &list);
>  		}
>  		callback =3D desc->txd.callback;

For ep93xx:

Tested-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
