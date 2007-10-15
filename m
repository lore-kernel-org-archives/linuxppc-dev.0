Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 879A5DDF92
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 07:01:08 +1000 (EST)
Subject: Re: [PATCH] PowerPC: Add NEW EMAC driver support to 440EPx Sequoia
	board.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20071012130305.GA14682@ru.mvista.com>
References: <20071012130305.GA14682@ru.mvista.com>
Content-Type: text/plain
Date: Tue, 16 Oct 2007 07:01:00 +1000
Message-Id: <1192482060.11795.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-10-12 at 17:03 +0400, Valentine Barshak wrote:
> This patch enables NEW EMAC support for PowerPC 440EPx Sequoia board
> and adds BCM5248 and Marvell 88E1111 PHY support to NEW EMAC driver.
> These PHY chips are used on PowerPC440EPx boards.
> The PHY code is based on the previous work by Stefan Roese <sr@denx.de>
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> ---
>  arch/powerpc/platforms/44x/Kconfig |    7 ++----
>  drivers/net/ibm_newemac/phy.c      |   39 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+), 4 deletions(-)
> 
> --- linux.orig/arch/powerpc/platforms/44x/Kconfig	2007-07-30 15:05:50.000000000 +0400
> +++ linux/arch/powerpc/platforms/44x/Kconfig	2007-07-30 17:59:05.000000000 +0400
> @@ -48,10 +48,9 @@
>  config 440EPX
>  	bool
>  	select PPC_FPU
> -# Disabled until the new EMAC Driver is merged.
> -#	select IBM_NEW_EMAC_EMAC4
> -#	select IBM_NEW_EMAC_RGMII
> -#	select IBM_NEW_EMAC_ZMII
> +	select IBM_NEW_EMAC_EMAC4
> +	select IBM_NEW_EMAC_RGMII
> +	select IBM_NEW_EMAC_ZMII
>  
>  config 440GP
>  	bool
> --- linux.orig/drivers/net/ibm_newemac/phy.c	2007-06-15 21:45:18.000000000 +0400
> +++ linux/drivers/net/ibm_newemac/phy.c	2007-06-15 20:45:15.000000000 +0400
> @@ -306,8 +306,47 @@
>  	.ops		= &cis8201_phy_ops
>  };
>  
> +static struct mii_phy_def bcm5248_phy_def = {
> +
> +	.phy_id		= 0x0143bc00,
> +	.phy_id_mask	= 0x0ffffff0,
> +	.name		= "BCM5248 10/100 SMII Ethernet",
> +	.ops		= &generic_phy_ops
> +};
> +
> +static int m88e1111_init(struct mii_phy *phy)
> +{
> +	printk("%s: Marvell 88E1111 Ethernet\n", __FUNCTION__);
> +	phy_write(phy, 0x14, 0x0ce3);
> +	phy_write(phy, 0x18, 0x4101);
> +	phy_write(phy, 0x09, 0x0e00);
> +	phy_write(phy, 0x04, 0x01e1);
> +	phy_write(phy, 0x00, 0x9140);
> +	phy_write(phy, 0x00, 0x1140);
> +
> +	return  0;
> +}
> +
> +static struct mii_phy_ops m88e1111_phy_ops = {
> +	.init		= m88e1111_init,
> +	.setup_aneg	= genmii_setup_aneg,
> +	.setup_forced	= genmii_setup_forced,
> +	.poll_link	= genmii_poll_link,
> +	.read_link	= genmii_read_link
> +};
> +
> +static struct mii_phy_def m88e1111_phy_def = {
> +
> +	.phy_id		= 0x01410CC0,
> +	.phy_id_mask	= 0x0ffffff0,
> +	.name		= "Marvell 88E1111 Ethernet",
> +	.ops		= &m88e1111_phy_ops,
> +};
> +
>  static struct mii_phy_def *mii_phy_table[] = {
>  	&cis8201_phy_def,
> +	&bcm5248_phy_def,
> +	&m88e1111_phy_def,
>  	&genmii_phy_def,
>  	NULL
>  };
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
