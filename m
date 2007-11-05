Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9CFFEDDE27
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Nov 2007 06:04:36 +1100 (EST)
Message-ID: <472F6941.1040302@freescale.com>
Date: Mon, 05 Nov 2007 13:04:33 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [RFC] [POWERPC] Add support for PHY-less fs_enet operation
References: <472CCA98.4000808@scram.de>
In-Reply-To: <472CCA98.4000808@scram.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Jeff Garzik <jeff@garzik.org>,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jochen Friedrich wrote:
> diff --git a/drivers/net/fs_enet/fs_enet-main.c 
> b/drivers/net/fs_enet/fs_enet-main.c
> index f2a4d39..e142eff 100644
> --- a/drivers/net/fs_enet/fs_enet-main.c
> +++ b/drivers/net/fs_enet/fs_enet-main.c
> @@ -702,13 +702,16 @@ static void fs_timeout(struct net_device *dev)
>     spin_lock_irqsave(&fep->lock, flags);
> 
>     if (dev->flags & IFF_UP) {
> -        phy_stop(fep->phydev);
> +        if (fep->phydev)
> +            phy_stop(fep->phydev);
>         (*fep->ops->stop)(dev);
>         (*fep->ops->restart)(dev);
> -        phy_start(fep->phydev);
> +        if (fep->phydev)
> +            phy_start(fep->phydev);
>     }

It might be nice if phy_stop/phy_start/etc. were made to accept NULL 
parameters as no-ops to make things easier on drivers that support 
phyless operation...

-Scott
