Return-Path: <linux@roeck-us.net>
Received: from mail.active-venture.com (mail.active-venture.com
 [67.228.131.205])
 by lists.ozlabs.org (Postfix) with ESMTP id 455C21A0823
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 03:46:50 +1000 (EST)
Message-ID: <53E7B006.9050605@roeck-us.net>
Date: Sun, 10 Aug 2014 10:46:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH] net: ugg_geth: Fix build error in -next
References: <1407687554-14539-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1407687554-14539-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: netdev@vger.kernel.org,
 =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grumble. Headline should be s/ugg/ucc, obviously.

Guenter

On 08/10/2014 09:19 AM, Guenter Roeck wrote:
> powerpc:mpc83xx_defconfig and other builds fail with
>
> drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_remove':
> drivers/net/ethernet/freescale/ucc_geth.c:3927:19: error:
> 	'struct ucc_geth_private' has no member named 'info'
>    of_node_put(ugeth->info->tbi_node);
>                       ^
> drivers/net/ethernet/freescale/ucc_geth.c:3928:19: error:
> 	     'struct ucc_geth_private' has no member named 'info'
>    of_node_put(ugeth->info->phy_node);
>    		     ^
>
> Introduced by commit "net: ucc_geth: drop acquired references in probe error
> path and remove".
>
>>From the context, it appears that the variable is named ug_info.
>
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Only seen in -next.
>
>   drivers/net/ethernet/freescale/ucc_geth.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
> index d6b64e3..3cf0478 100644
> --- a/drivers/net/ethernet/freescale/ucc_geth.c
> +++ b/drivers/net/ethernet/freescale/ucc_geth.c
> @@ -3924,8 +3924,8 @@ static int ucc_geth_remove(struct platform_device* ofdev)
>   	unregister_netdev(dev);
>   	free_netdev(dev);
>   	ucc_geth_memclean(ugeth);
> -	of_node_put(ugeth->info->tbi_node);
> -	of_node_put(ugeth->info->phy_node);
> +	of_node_put(ugeth->ug_info->tbi_node);
> +	of_node_put(ugeth->ug_info->phy_node);
>
>   	return 0;
>   }
>
