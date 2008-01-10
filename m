Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8AF90DE027
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 04:28:12 +1100 (EST)
Message-ID: <4786556C.8040108@freescale.com>
Date: Thu, 10 Jan 2008 11:27:08 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: hs@denx.de
Subject: Re: [PATCH for 2.6.24][NET] fs_enet: check for phydev existence in
	the ethtool handlers
References: <1199875566.3408.11.camel@p60365-ste> <4784C509.5030507@denx.de>
	<20080109182038.GA4337@loki.buserror.net>
	<4785D3D8.7080300@denx.de> <4785E014.4040709@denx.de>
In-Reply-To: <4785E014.4040709@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Heiko Schocher wrote:
> diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
> index f2a4d39..f432a18 100644
> --- a/drivers/net/fs_enet/fs_enet-main.c
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -810,6 +810,10 @@ static int fs_enet_open(struct net_device *dev)
>  	if (fep->fpi->use_napi)
>  		napi_enable(&fep->napi);
> 
> +	/* to initialize the fep->cur_rx,... */
> +	/* not doing this, will cause a crash in fs_enet_rx_napi */
> +	fs_init_bds(fep->ndev);

We should do this just before napi_enable() rather than just after, to 
eliminate any chance of a race window.

Looks good otherwise.

-Scott
