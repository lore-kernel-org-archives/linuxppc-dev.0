Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B24BFDDF96
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 04:27:42 +1000 (EST)
Message-ID: <4713B10B.5000607@garzik.org>
Date: Mon, 15 Oct 2007 14:27:23 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Valentine Barshak <vbarshak@ru.mvista.com>,
	jwboyer@linux.vnet.ibm.com, Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support
	to NEW EMAC.
References: <20071015175717.GA4602@ru.mvista.com>
In-Reply-To: <20071015175717.GA4602@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak wrote:
> This patch adds BCM5248 and Marvell 88E1111 PHY support to NEW EMAC driver.
> These PHY chips are used on PowerPC 440EPx boards.
> The PHY code is based on the previous work by Stefan Roese <sr@denx.de>
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  drivers/net/ibm_newemac/phy.c |   39 +++++++++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+)
> 
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

Seems sane to me -- ACK -- but we have multiple people sending me 
patches for a single driver.  That's normal for janitorial cleanups 
across the whole tree, but discouraged when multiple people are actively 
working on the same driver.

Please coordinate, and have ONE person send me patches...
