Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 567EF1A088C
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 06:35:09 +1000 (EST)
Date: Fri, 8 Aug 2014 22:34:56 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 1/3] net: ucc_geth: drop acquired references in probe
 error path and remove
Message-ID: <20140808203456.GB5134@pengutronix.de>
References: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1407448106-1819-1-git-send-email-u.kleine-koenig@pengutronix.de>
Cc: netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, kernel@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 07, 2014 at 11:48:24PM +0200, Uwe Kleine-König wrote:
> The ucc_geth_probe function assigns to ug_info->tbi_node and
> ug_info->phy_node a value returned by of_parse_phandle which returns a
> new reference. Put this reference again in the error path of
> ucc_geth_probe and when removing the device.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> No Fixes: footer here. The problem already exists in v2.6.31-rc1 (e.g.
> commit 0b9da337dca9 (net: Rework ucc_geth driver to use of_mdio
> infrastructure)). Didn't continue to research a specific commit.
> ---
>  drivers/net/ethernet/freescale/ucc_geth.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> index 36fc429298e3..5f1aab9c4ee7 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -3864,8 +3864,11 @@ static int ucc_geth_probe(struct platform_device* ofdev)
>  	/* Create an ethernet device instance */
>  	dev = alloc_etherdev(sizeof(*ugeth));
>  
> -	if (dev == NULL)
> +	if (dev == NULL) {
> +		of_node_put(ug_info->tbi_node);
> +		of_node_put(ug_info->phy_node);
>  		return -ENOMEM;
> +	}
>  
>  	ugeth = netdev_priv(dev);
>  	spin_lock_init(&ugeth->lock);
> @@ -3899,6 +3902,8 @@ static int ucc_geth_probe(struct platform_device* ofdev)
>  			pr_err("%s: Cannot register net device, aborting\n",
>  			       dev->name);
>  		free_netdev(dev);
> +		of_node_put(ug_info->tbi_node);
> +		of_node_put(ug_info->phy_node);
>  		return err;
>  	}
>  
> @@ -3922,6 +3927,8 @@ static int ucc_geth_remove(struct platform_device* ofdev)
>  	unregister_netdev(dev);
>  	free_netdev(dev);
>  	ucc_geth_memclean(ugeth);
> +	of_node_put(ugeth->info->tbi_node);
> +	of_node_put(ugeth->info->phy_node);
this must read:

	of_node_put(ugeth->ug_info->tbi_node);
	of_node_put(ugeth->ug_info->phy_node);

otherwise it fails to build.

@davem: Should I send a fixup or a new version?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
