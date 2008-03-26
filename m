Return-Path: <vbarshak@ru.mvista.com>
Message-ID: <47EA445D.9090509@ru.mvista.com>
Date: Wed, 26 Mar 2008 15:41:01 +0300
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/2] pasemi_mac: Netpoll support
References: <20080326015625.GA23103@lixom.net>
	<20080326015801.GC23103@lixom.net>
In-Reply-To: <20080326015801.GC23103@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org, jgarzik@pobox.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> Add netpoll support to allow use of netconsole.
> 
> Signed-off-by: Nate Case <ncase@xes-inc.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> diff --git a/drivers/net/pasemi_mac.c b/drivers/net/pasemi_mac.c
> index abb1dc4..6030ffe 100644
> --- a/drivers/net/pasemi_mac.c
> +++ b/drivers/net/pasemi_mac.c
> @@ -1648,6 +1648,26 @@ static int pasemi_mac_poll(struct napi_struct *napi, int budget)
>  	return pkts;
>  }
>  
> +#ifdef CONFIG_NET_POLL_CONTROLLER
> +/*
> + * Polling 'interrupt' - used by things like netconsole to send skbs
> + * without having to re-enable interrupts. It's not called while
> + * the interrupt routine is executing.
> + */
> +static void pasemi_mac_netpoll(struct net_device *dev)
> +{
> +	const struct pasemi_mac *mac = netdev_priv(dev);
> +
> +	disable_irq(mac->tx->chan.irq);
> +	pasemi_mac_tx_intr(mac->tx->chan.irq, mac->tx);
> +	enable_irq(mac->tx->chan.irq);
> +
> +	disable_irq(mac->rx->chan.irq);
> +	pasemi_mac_rx_intr(mac->rx->chan.irq, dev);

Shouldn't this actually be pasemi_mac_rx_intr(mac->rx->chan.irq, mac->rx)?
Thanks,
Valentine.

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
