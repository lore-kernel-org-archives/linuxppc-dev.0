Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (dsl027-180-168.sfo1.dsl.speakeasy.net
	[216.27.180.168]) by ozlabs.org (Postfix) with ESMTP id 7EF5E679E9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 10:30:02 +1000 (EST)
Date: Mon, 21 Aug 2006 17:30:16 -0700 (PDT)
Message-Id: <20060821.173016.116359572.davem@davemloft.net>
To: linas@austin.ibm.com
Subject: Re: [PATCH 2/4]: powerpc/cell spidernet low watermark patch.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20060822001311.GK5427@austin.ibm.com>
References: <20060818234532.GA8644@austin.ibm.com>
	<1155962022.5803.68.camel@localhost.localdomain>
	<20060822001311.GK5427@austin.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: arnd@arndb.de, jklewis@us.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Jens.Osterkamp@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: linas@austin.ibm.com (Linas Vepstas)
Date: Mon, 21 Aug 2006 19:13:11 -0500

> @@ -1495,16 +1500,16 @@ spider_net_interrupt(int irq, void *ptr,
>  	if (!status_reg)
>  		return IRQ_NONE;
>  
> -	if (status_reg & SPIDER_NET_RXINT ) {
> +	if (status_reg & SPIDER_NET_RXINT) {
>  		spider_net_rx_irq_off(card);
>  		netif_rx_schedule(netdev);
>  	}
> -	if (status_reg & SPIDER_NET_TXINT ) {
> -		spider_net_cleanup_tx_ring(card);
> -		netif_wake_queue(netdev);
> -	}
>  
> -	if (status_reg & SPIDER_NET_ERRINT )
> +	/* Call rx_schedule from the tx interrupt, so that NAPI poll runs. */
> +	if (status_reg & SPIDER_NET_TXINT)
> +		netif_rx_schedule(netdev);
> +
> +	if (status_reg & SPIDER_NET_ERRINT)

This should be:

	if ((status_reg & (SPIDET_NET_RXINT | SPIDET_NET_TXINT))) {
		spider_net_rx_and_tx_irq_off(card);
		netif_rx_schedule();
	}
