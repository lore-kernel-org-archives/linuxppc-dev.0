Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8034DDF1A
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 13:33:24 +1000 (EST)
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support
	to NEW EMAC.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
In-Reply-To: <20071015175717.GA4602@ru.mvista.com>
References: <20071015175717.GA4602@ru.mvista.com>
Content-Type: text/plain
Date: Wed, 24 Oct 2007 13:31:58 +1000
Message-Id: <1193196718.2085.35.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, jeff@garzik.org, netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-10-23 at 20:57 -0500, Valentine Barshak wrote:

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

Care to put a few comments on why the above is necessary and what it
does ?

Thanks !
Ben.

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
