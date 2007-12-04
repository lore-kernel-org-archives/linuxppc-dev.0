Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1E5F3DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 07:01:13 +1100 (EST)
In-Reply-To: <1196279794.30806.54.camel@pmac.infradead.org>
References: <1196273071.30806.46.camel@pmac.infradead.org>
	<1196279794.30806.54.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8D34458A-2CE9-4FA7-AE28-4D148E08CCDF@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Stop phy code from returning success to unknown ioctls.
Date: Tue, 4 Dec 2007 14:00:42 -0600
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com,
	Domen Puncer <domen.puncer@telargo.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 28, 2007, at 13:56, David Woodhouse wrote:

> This kind of sucks, and prevents the Fedora installer from using the
> device for network installs...
>
> [root@efika phy]# iwconfig eth0
> Warning: Driver for device eth0 has been compiled with an ancient  
> version
> of Wireless Extension, while this program support version 11 and  
> later.
> Some things may be broken...
>
> eth0        ESSID:off/any  Nickname:""
>           NWID:0  Channel:0  Access Point: 00:00:BF:81:14:E0
>           Bit Rate:-1.08206e+06 kb/s   Sensitivity=0/0
>           RTS thr:off   Fragment thr:off
>           Encryption key:<too big>
>           Power Management:off
>
> Signed-off-by: David Woodhouse <dwmw2@infradead.org>

d'oh!

Acked-by: Andy Fleming <afleming@freescale.com>


>
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 9bc1177..7c9e6e3 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -406,6 +406,9 @@ int phy_mii_ioctl(struct phy_device *phydev,
>  				&& phydev->drv->config_init)
>  			phydev->drv->config_init(phydev);
>  		break;
> +
> +	default:
> +		return -ENOTTY;
>  	}
>
>  	return 0;
>
> -- 
> dwmw2
>
> -
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
