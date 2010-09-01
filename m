Return-Path: <bhutchings@solarflare.com>
Received: from exchange.solarflare.com (exchange.solarflare.com
	[216.237.3.220]) by ozlabs.org (Postfix) with ESMTP id C6578B716C
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Sep 2010 23:42:34 +1000 (EST)
Subject: Re: [v1 PATCH] ucc_geth: fix ethtool set ring param bug
From: Ben Hutchings <bhutchings@solarflare.com>
To: Liang Li <liang.li@windriver.com>
In-Reply-To: <1283305429-8426-1-git-send-email-liang.li@windriver.com>
References: <1283179677-21262-1-git-send-email-liang.li@windriver.com>
	<1283305429-8426-1-git-send-email-liang.li@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 01 Sep 2010 14:42:30 +0100
Message-ID: <1283348550.2268.7.camel@achroite.uk.solarflarecom.com>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, avorontsov@ru.mvista.com, davem@davemloft.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2010-09-01 at 09:43 +0800, Liang Li wrote:
> It's common sense that when we should do change to driver ring
> desc/buffer etc only after 'stop/shutdown' the device. When we
> do change while devices/driver is running, kernel oops occur:
[...]
> -	ug_info->bdRingLenRx[queue] = ring->rx_pending;
> -	ug_info->bdRingLenTx[queue] = ring->tx_pending;
> -
>  	if (netif_running(netdev)) {
> -		/* FIXME: restart automatically */
> -		printk(KERN_INFO
> -			"Please re-open the interface.\n");
> +		u16 rx_t;
> +		u16 tx_t;
> +		printk(KERN_INFO "Stopping interface %s.\n", netdev->name);
> +		ucc_geth_close(netdev);
> +
> +		rx_t = ug_info->bdRingLenRx[queue];
> +		tx_t = ug_info->bdRingLenTx[queue];
> +
> +		ug_info->bdRingLenRx[queue] = ring->rx_pending;
> +		ug_info->bdRingLenTx[queue] = ring->tx_pending;
> +
> +		printk(KERN_INFO "Reactivating interface %s.\n", netdev->name);
> +		ret = ucc_geth_open(netdev);
> +		if (ret) {
> +			printk(KERN_WARNING "uec_set_ringparam: set ring param for running"
> +					" interface %s failed. Please try to make the interface "
> +					" down, then try again.\n", netdev->name);
> +			ug_info->bdRingLenRx[queue] = rx_t;
> +			ug_info->bdRingLenTx[queue] = tx_t;
> +		}
[...]

Bringing the interface down will call ucc_geth_close(), which will try
to free resources that have not been allocated!

If you cannot roll back a failed change then at least use dev_close()
and dev_open() rather than calling ucc_geth_{close,open}() directly, so
that the interface state is updated correctly.  Or just refuse to make
the change if the interface is up.

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.
