Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8ECB8DE172
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 15:54:03 +1000 (EST)
Message-ID: <48004E71.4040805@pobox.com>
Date: Sat, 12 Apr 2008 01:53:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH] fs_enet: Don't call NAPI functions when NAPI is not used.
References: <200804111405.50896.laurentp@cse-semaphore.com>
In-Reply-To: <200804111405.50896.laurentp@cse-semaphore.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Laurent Pinchart wrote:
> fs_enet_close() calls napi_disable() unconditionally. This patch skips the
> call when use_napi isn't set.
> 
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
>  drivers/net/fs_enet/fs_enet-main.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
> index c83bd65..1801ce3 100644
> --- a/drivers/net/fs_enet/fs_enet-main.c
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -835,7 +835,8 @@ static int fs_enet_close(struct net_device *dev)
>  
>  	netif_stop_queue(dev);
>  	netif_carrier_off(dev);
> -	napi_disable(&fep->napi);
> +	if (fep->fpi->use_napi)
> +		napi_disable(&fep->napi);
>  	phy_stop(fep->phydev);

applied
