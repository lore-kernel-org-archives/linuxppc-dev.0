Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C0F5BDDF9B
	for <linuxppc-dev@ozlabs.org>; Thu,  3 May 2007 06:10:44 +1000 (EST)
In-Reply-To: <20070502195712.GA16541@ld0162-tx32.am.freescale.net>
References: <20070502195712.GA16541@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F1B250DD-A472-470F-B3D0-EBB2F042E454@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] gianfar: Add I/O barriers when touching buffer
	descriptor ownership.
Date: Wed, 2 May 2007 15:09:56 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: netdev@vger.kernel.org, jgarzik@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 2, 2007, at 2:57 PM, Scott Wood wrote:

> The hardware must not see that is given ownership of a buffer until  
> it is
> completely written, and when the driver receives ownership of a  
> buffer,
> it must ensure that any other reads to the buffer reflect its final
> state.  Thus, I/O barriers are added where required.
>
> Without this patch, I have observed GCC reordering the setting of
> bdp->length and bdp->status in gfar_new_skb.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This is version 2 of this patch.  I was told that eieio doesn't order
> loads from main memory, so a sync is used instead.  Also, due to
> objectons that iobarrier_* shouldn't be used for main memory, I used
> eieio() instead (a wmb() would be unnecessarily heavy).

I'd rather see a wmb() instead of eieio() to keep this code non-ppc  
specific.  (also, we implement wmb as eieio, so I don't keep the  
comment about it being too heavy, unless you mean generically).

- k

>
>  drivers/net/gianfar.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
> index b666a0c..b014d27 100644
> --- a/drivers/net/gianfar.c
> +++ b/drivers/net/gianfar.c
> @@ -1025,6 +1025,7 @@ static int gfar_start_xmit(struct sk_buff  
> *skb, struct net_device *dev)
>
>  	dev->trans_start = jiffies;
>
> +	eieio();
>  	txbdp->status = status;
>
>  	/* If this was the last BD in the ring, the next one */
> @@ -1301,6 +1302,7 @@ struct sk_buff * gfar_new_skb(struct  
> net_device *dev, struct rxbd8 *bdp)
>  	bdp->length = 0;
>
>  	/* Mark the buffer empty */
> +	eieio();
>  	bdp->status |= (RXBD_EMPTY | RXBD_INTERRUPT);
>
>  	return skb;
> @@ -1484,6 +1486,7 @@ int gfar_clean_rx_ring(struct net_device  
> *dev, int rx_work_limit)
>  	bdp = priv->cur_rx;
>
>  	while (!((bdp->status & RXBD_EMPTY) || (--rx_work_limit < 0))) {
> +		rmb();
>  		skb = priv->rx_skbuff[priv->skb_currx];
>
>  		if (!(bdp->status &
> -- 
> 1.5.0.3
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
