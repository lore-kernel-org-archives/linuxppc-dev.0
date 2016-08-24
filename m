Return-Path: <eric.dumazet@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sK6yx2wtWzDrJy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 23:07:05 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id i6so1232712pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Aug 2016 06:07:05 -0700 (PDT)
Message-ID: <1472044021.14381.71.camel@edumazet-glaptop3.roam.corp.google.com>
Subject: Re: [PATCH 1/3] net: fs_enet: merge NAPI RX and NAPI TX
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>, Vitaly Bordug
 <vbordug@ru.mvista.com>, davem@davemloft.net, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Date: Wed, 24 Aug 2016 06:07:01 -0700
In-Reply-To: <c607324b1322bb5729081808b2f54f5f9da52444.1472033140.git.christophe.leroy@c-s.fr>
References: <cover.1472033140.git.christophe.leroy@c-s.fr>
 <c607324b1322bb5729081808b2f54f5f9da52444.1472033140.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-08-24 at 12:36 +0200, Christophe Leroy wrote:
> Initially, a NAPI TX routine has been implemented separately from
> NAPI RX, as done on the freescale/gianfar driver.
> 
> By merging NAPI RX and NAPI TX, we reduce the amount of TX completion
> interrupts.
> 
> Handling of the budget in association with TX interrupts is based on
> indications provided at https://wiki.linuxfoundation.org/networking/napi
> 
> At the same time, we fix an issue in the handling of fep->tx_free:
> 
> It is only when fep->tx_free goes up to MAX_SKB_FRAGS that
> we need to wake up the queue. There is no need to call
> netif_wake_queue() at every packet successfully transmitted.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  .../net/ethernet/freescale/fs_enet/fs_enet-main.c  | 259 +++++++++------------
>  drivers/net/ethernet/freescale/fs_enet/fs_enet.h   |  16 +-
>  drivers/net/ethernet/freescale/fs_enet/mac-fcc.c   |  57 ++---
>  drivers/net/ethernet/freescale/fs_enet/mac-fec.c   |  57 ++---
>  drivers/net/ethernet/freescale/fs_enet/mac-scc.c   |  57 ++---
>  5 files changed, 153 insertions(+), 293 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> index 61fd486..7cd3ef9 100644
> --- a/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> +++ b/drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c
> @@ -79,8 +79,8 @@ static void skb_align(struct sk_buff *skb, int align)
>  		skb_reserve(skb, align - off);
>  }
>  
> -/* NAPI receive function */
> -static int fs_enet_rx_napi(struct napi_struct *napi, int budget)
> +/* NAPI function */
> +static int fs_enet_napi(struct napi_struct *napi, int budget)
>  {
>  	struct fs_enet_private *fep = container_of(napi, struct fs_enet_private, napi);
>  	struct net_device *dev = fep->ndev;
> @@ -90,9 +90,100 @@ static int fs_enet_rx_napi(struct napi_struct *napi, int budget)
>  	int received = 0;
>  	u16 pkt_len, sc;
>  	int curidx;
> +	int dirtyidx, do_wake, do_restart;
>  
> -	if (budget <= 0)
> -		return received;
> +	spin_lock(&fep->tx_lock);
> +	bdp = fep->dirty_tx;
> +
> +	/* clear status bits for napi*/
> +	(*fep->ops->napi_clear_event)(dev);
> +
> +	do_wake = do_restart = 0;
> +	while (((sc = CBDR_SC(bdp)) & BD_ENET_TX_READY) == 0) {

I am afraid you could live lock here on SMP.

You should make sure you do not loop forever, not assuming cpu is faster
than NIC.



> +		dirtyidx = bdp - fep->tx_bd_base;
> +
> +		if (fep->tx_free == fep->tx_ring)
> +			break;
> +
> +		skb = fep->tx_skbuff[dirtyidx];
> +
> +		/*
> +		 * Check for errors.
> +		 */
> +		if (sc & (BD_ENET_TX_HB | BD_ENET_TX_LC |
> +			  BD_ENET_TX_RL | BD_ENET_TX_UN | BD_ENET_TX_CSL)) {
> +
> +			if (sc & BD_ENET_TX_HB)	/* No heartbeat */
> +				fep->stats.tx_heartbeat_errors++;
> +			if (sc & BD_ENET_TX_LC)	/* Late collision */
> +				fep->stats.tx_window_errors++;
> +			if (sc & BD_ENET_TX_RL)	/* Retrans limit */
> +				fep->stats.tx_aborted_errors++;
> +			if (sc & BD_ENET_TX_UN)	/* Underrun */
> +				fep->stats.tx_fifo_errors++;
> +			if (sc & BD_ENET_TX_CSL)	/* Carrier lost */
> +				fep->stats.tx_carrier_errors++;
> +
> +			if (sc & (BD_ENET_TX_LC | BD_ENET_TX_RL | BD_ENET_TX_UN)) {
> +				fep->stats.tx_errors++;
> +				do_restart = 1;
> +			}
> +		} else
> +			fep->stats.tx_packets++;
> +
> +		if (sc & BD_ENET_TX_READY) {
> +			dev_warn(fep->dev,
> +				 "HEY! Enet xmit interrupt and TX_READY.\n");
> +		}
> +
> +		/*
> +		 * Deferred means some collisions occurred during transmit,
> +		 * but we eventually sent the packet OK.
> +		 */
> +		if (sc & BD_ENET_TX_DEF)
> +			fep->stats.collisions++;
> +
> +		/* unmap */
> +		if (fep->mapped_as_page[dirtyidx])
> +			dma_unmap_page(fep->dev, CBDR_BUFADDR(bdp),
> +				       CBDR_DATLEN(bdp), DMA_TO_DEVICE);
> +		else
> +			dma_unmap_single(fep->dev, CBDR_BUFADDR(bdp),
> +					 CBDR_DATLEN(bdp), DMA_TO_DEVICE);
> +
> +		/*
> +		 * Free the sk buffer associated with this last transmit.
> +		 */
> +		if (skb) {
> +			dev_kfree_skb(skb);
> +			fep->tx_skbuff[dirtyidx] = NULL;
> +		}
> +
> +		/*
> +		 * Update pointer to next buffer descriptor to be transmitted.
> +		 */
> +		if ((sc & BD_ENET_TX_WRAP) == 0)
> +			bdp++;
> +		else
> +			bdp = fep->tx_bd_base;
> +
> +		/*
> +		 * Since we have freed up a buffer, the ring is no longer
> +		 * full.
> +		 */
> +		if (++fep->tx_free == MAX_SKB_FRAGS)
> +			do_wake = 1;
> +	}
> +
> +	fep->dirty_tx = bdp;
> +
> +	if (do_restart)
> +		(*fep->ops->tx_restart)(dev);
> +
> +	spin_unlock(&fep->tx_lock);
> +
> +	if (do_wake)
> +		netif_wake_queue(dev);
>  
