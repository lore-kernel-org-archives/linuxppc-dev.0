Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE0FC1A0823
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 04:36:28 +1000 (EST)
Date: Sun, 10 Aug 2014 20:36:22 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] net: ugg_geth: Fix build error in -next
Message-ID: <20140810183622.GC5134@pengutronix.de>
References: <1407687554-14539-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1407687554-14539-1-git-send-email-linux@roeck-us.net>
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Guenter,

On Sun, Aug 10, 2014 at 09:19:14AM -0700, Guenter Roeck wrote:
> powerpc:mpc83xx_defconfig and other builds fail with
> 
> drivers/net/ethernet/freescale/ucc_geth.c: In function 'ucc_geth_remove':
> drivers/net/ethernet/freescale/ucc_geth.c:3927:19: error:
> 	'struct ucc_geth_private' has no member named 'info'
>   of_node_put(ugeth->info->tbi_node);
>                      ^
> drivers/net/ethernet/freescale/ucc_geth.c:3928:19: error:
> 	     'struct ucc_geth_private' has no member named 'info'
>   of_node_put(ugeth->info->phy_node);
>   		     ^
> 
> Introduced by commit "net: ucc_geth: drop acquired references in probe error
> path and remove".
> 
> From the context, it appears that the variable is named ug_info.
> 
> Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Only seen in -next.
My patch was only sent just now, but it has the subject right:

	http://mid.gmane.org/1407695525-32227-1-git-send-email-u.kleine-koenig@pengutronix.de

Another upside is that it contains a Fixes: header.

Other than that my patch is the same. In case davem picks up yours:

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards and thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
