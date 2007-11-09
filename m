Return-Path: <domen.puncer@telargo.com>
Date: Fri, 9 Nov 2007 10:12:45 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Fix buglets in mpc5200 FEC code that are corrupting
	memory.
Message-ID: <20071109091245.GA3148@nd47.coderock.org>
References: <9e4733910711082131v70c4b7bm2b00445b7e62c33f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <9e4733910711082131v70c4b7bm2b00445b7e62c33f@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>, netdev <netdev@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 09/11/07 00:31 -0500, Jon Smirl wrote:
> This is the reason I couldn't get user space started or connect to my
> nfs server. Patch is against current linus git.
> 
> mpc5200 fec driver is corrupting memory. This patch fixes two bugs
> where the wrong skb buffer was being referenced.
> 
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Acked-by: Domen Puncer <domen.puncer@telargo.com>

I can't test it at the moment, but the patch is obviously correct,
mapped buffer should be the _same_ as submitted.

> 
> ---
> 
>  drivers/net/fec_mpc52xx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> 
> diff --git a/drivers/net/fec_mpc52xx.c b/drivers/net/fec_mpc52xx.c
> index a8a0ee2..ddfcc0b 100644
> --- a/drivers/net/fec_mpc52xx.c
> +++ b/drivers/net/fec_mpc52xx.c
> @@ -422,7 +422,7 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int
> irq, void *dev_id)
> 
>  		rskb = bcom_retrieve_buffer(priv->rx_dmatsk, &status,
>  				(struct bcom_bd **)&bd);
> -		dma_unmap_single(&dev->dev, bd->skb_pa, skb->len, DMA_FROM_DEVICE);
> +		dma_unmap_single(&dev->dev, bd->skb_pa, rskb->len, DMA_FROM_DEVICE);
> 
>  		/* Test for errors in received frame */
>  		if (status & BCOM_FEC_RX_BD_ERRORS) {
> @@ -467,7 +467,7 @@ static irqreturn_t mpc52xx_fec_rx_interrupt(int
> irq, void *dev_id)
>  			bcom_prepare_next_buffer(priv->rx_dmatsk);
> 
>  		bd->status = FEC_RX_BUFFER_SIZE;
> -		bd->skb_pa = dma_map_single(&dev->dev, rskb->data,
> +		bd->skb_pa = dma_map_single(&dev->dev, skb->data,
>  				FEC_RX_BUFFER_SIZE, DMA_FROM_DEVICE);
> 
>  		bcom_submit_next_buffer(priv->rx_dmatsk, skb);
> 
> 
> -- 
> Jon Smirl
> jonsmirl@gmail.com

-- 
Domen Puncer | Research & Development
.............................................................................................
Telargo d.o.o. | Zagrebška cesta 20 | 2000 Maribor | Slovenia
.............................................................................................
www.telargo.com
