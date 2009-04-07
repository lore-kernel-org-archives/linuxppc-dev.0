Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id C2A37DDFCE
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Apr 2009 04:40:36 +1000 (EST)
Date: Tue, 7 Apr 2009 22:40:34 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH] powerpc: 85xx: Add PHY fixup to socrates board code
Message-ID: <20090407184034.GA25760@oksana.dev.rtsoft.ru>
References: <1239113988-4579-1-git-send-email-agust@denx.de>
	<20090407143011.GA15727@oksana.dev.rtsoft.ru>
	<49DB8C3C.5080306@denx.de>
	<20090407180957.GA2831@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20090407180957.GA2831@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 07, 2009 at 10:09:57PM +0400, Anton Vorontsov wrote:
[...]
> Still, I think you shouldn't do this in a board-specific fixup.
> Maybe I'm a bit naive, but shouldn't this work too?

Yes, I'm naive. The phydev isn't yet bound to any driver, so we
can't call phy_disable_interrupts().

And I don't see any proper solution. :-( After all, it appears
we'll have to live with the board fixup.

> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index b754020..9052937 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -205,6 +205,16 @@ struct phy_device *mdiobus_scan(struct mii_bus *bus, int addr)
>  
>  	phydev->bus = bus;
>  
> +	/*
> +	 * Some PHYs may have unmasked/pending interrupts, this might
> +	 * cause troubles w/ shared IRQs. So try to put the PHYs into
> +	 * some sane state.
> +	 *
> +	 * NOTE: This won't work if you have two PHYs w/ shared IRQs
> +	 *       on different MDIO buses.
> +	 */
> +	phy_disable_interrupts(phydev);
> +
>  	/* Run all of the fixups for this PHY */
>  	phy_scan_fixups(phydev);
>  

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
