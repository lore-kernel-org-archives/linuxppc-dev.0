Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1B0991A1BD7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 18:02:20 +1000 (AEST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 Claudiu Manoil <claudiu.manoil@freescale.com>,
 Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] gianfar: Fix warnings when built on 64-bit
Date: Wed, 29 Jul 2015 10:02:07 +0200
Message-ID: <4498062.4y369pLSmO@wuerfel>
In-Reply-To: <1438147477-393-1-git-send-email-scottwood@freescale.com>
References: <1438147477-393-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wednesday 29 July 2015 00:24:37 Scott Wood wrote:

> Alternatively, if there's a desire to not mess with this code (I don't
> know how to trigger this code path to test it), this driver should be
> given dependencies that ensure that it only builds on 32-bit.

These are obvious fixes, they should definitely go in.

>  drivers/net/ethernet/freescale/gianfar.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index ff87502..7c682ac 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -565,6 +565,7 @@ static void gfar_ints_enable(struct gfar_private *priv)
>  	}
>  }
>  
> +#ifdef CONFIG_PM
>  static void lock_tx_qs(struct gfar_private *priv)
>  {
>  	int i;
> @@ -580,6 +581,7 @@ static void unlock_tx_qs(struct gfar_private *priv)
>  	for (i = 0; i < priv->num_tx_queues; i++)
>  		spin_unlock(&priv->tx_queue[i]->txlock);
>  }
> +#endif
>  

This seems unrelated and should probably be a separate fix.

> @@ -2964,8 +2967,13 @@ int gfar_clean_rx_ring(struct gfar_priv_rx_q *rx_queue, int rx_work_limit)
>  		gfar_init_rxbdp(rx_queue, bdp, bufaddr);
>  
>  		/* Update Last Free RxBD pointer for LFC */
> -		if (unlikely(rx_queue->rfbptr && priv->tx_actual_en))
> -			gfar_write(rx_queue->rfbptr, (u32)bdp);
> +		if (unlikely(rx_queue->rfbptr && priv->tx_actual_en)) {
> +			u32 bdp_dma;
> +
> +			bdp_dma = lower_32_bits(rx_queue->rx_bd_dma_base);
> +			bdp_dma += (uintptr_t)bdp - (uintptr_t)base;
> +			gfar_write(rx_queue->rfbptr, bdp_dma);
> +		}
>  
>  		/* Update to the next pointer */
>  		bdp = next_bd(bdp, base, rx_queue->rx_ring_size);

You are fixing two problems here: the warning about a size cast, and
the fact that the driver is using the wrong pointer. I'd suggest
explaining it in the changelog.

Note that we normally rely on void pointer arithmetic in the kernel, so
I'd write it without the uintptr_t casts as 

	bdp_dma = lower_32_bits(rx_queue->rx_bd_dma_base + (base - bdp));

	Arnd
