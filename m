Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6FB48DDEC8
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 08:36:08 +1100 (EST)
Message-ID: <4751D3C3.5090908@pobox.com>
Date: Sat, 01 Dec 2007 16:36:03 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Stop phy code from returning success to unknown ioctls.
References: <1196273071.30806.46.camel@pmac.infradead.org>
	<1196279794.30806.54.camel@pmac.infradead.org>
In-Reply-To: <1196279794.30806.54.camel@pmac.infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Domen Puncer <domen.puncer@telargo.com>,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse wrote:
> This kind of sucks, and prevents the Fedora installer from using the
> device for network installs...
> 
> [root@efika phy]# iwconfig eth0                                                                                                                
> Warning: Driver for device eth0 has been compiled with an ancient version                                                                      
> of Wireless Extension, while this program support version 11 and later.                                                                        
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

applied
