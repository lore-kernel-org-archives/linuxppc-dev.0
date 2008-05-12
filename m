Return-Path: <romieu@electric-eye.fr.zoreil.com>
Received: from electric-eye.fr.zoreil.com (electric-eye.fr.zoreil.com
	[213.41.134.224])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F724DDF29
	for <linuxppc-dev@ozlabs.org>; Tue, 13 May 2008 03:18:59 +1000 (EST)
Date: Mon, 12 May 2008 18:51:42 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 4/6] drivers/net/fs_enet: remove null pointer dereference
Message-ID: <20080512165142.GC22190@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.64.0805121537590.3694@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0805121537590.3694@ask.diku.dk>
Cc: netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	vbordug@ru.mvista.com, jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Julia Lawall <julia@diku.dk> :
[...]
> diff -u -p a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
> --- a/drivers/net/fs_enet/fs_enet-main.c	2008-04-27 11:41:11.000000000 +0200
> +++ b/drivers/net/fs_enet/fs_enet-main.c	2008-05-12 09:41:52.000000000 +0200
> @@ -1093,7 +1093,7 @@ err:
>  		if (registered)
>  			unregister_netdev(ndev);
>  
> -		if (fep != NULL) {
> +		if (fep && fep->ops) {
>  			(*fep->ops->free_bd)(ndev);
>  			(*fep->ops->cleanup_data)(ndev);
>  		}

Extra cookies for the nice soul who:
- removes the 'if (registered)' test (it can not happen)
- uses different error lablels and unrolls the error path. I can not claim
  that the current error path is wrong but it would not hurt if it was more
  trivially balanced.

-- 
Ueimor
