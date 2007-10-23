Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37854DDF48
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 01:21:05 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l9NFKeD5016372
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 11:20:40 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9NFKbNr009912
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:20:38 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9NFKbbt008107
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 09:20:37 -0600
Date: Tue, 23 Oct 2007 10:20:35 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support to
	NEW EMAC.
Message-ID: <20071023102035.6d35d3fe@weaponx.rchland.ibm.com>
In-Reply-To: <4713B10B.5000607@garzik.org>
References: <20071015175717.GA4602@ru.mvista.com> <4713B10B.5000607@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 15 Oct 2007 14:27:23 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> Valentine Barshak wrote:
> > This patch adds BCM5248 and Marvell 88E1111 PHY support to NEW EMAC driver.
> > These PHY chips are used on PowerPC 440EPx boards.
> > The PHY code is based on the previous work by Stefan Roese <sr@denx.de>
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> > ---
> >  drivers/net/ibm_newemac/phy.c |   39 +++++++++++++++++++++++++++++++++++++++
> >  1 files changed, 39 insertions(+)
> > 
> > --- linux.orig/drivers/net/ibm_newemac/phy.c	2007-06-15 21:45:18.000000000 +0400
> > +++ linux/drivers/net/ibm_newemac/phy.c	2007-06-15 20:45:15.000000000 +0400
> > @@ -306,8 +306,47 @@
> >  	.ops		= &cis8201_phy_ops
> >  };
> >  
> > +static struct mii_phy_def bcm5248_phy_def = {
> > +
> > +	.phy_id		= 0x0143bc00,
> > +	.phy_id_mask	= 0x0ffffff0,
> > +	.name		= "BCM5248 10/100 SMII Ethernet",
> > +	.ops		= &generic_phy_ops
> > +};
> > +
> > +static int m88e1111_init(struct mii_phy *phy)
> > +{
> > +	printk("%s: Marvell 88E1111 Ethernet\n", __FUNCTION__);
> > +	phy_write(phy, 0x14, 0x0ce3);
> > +	phy_write(phy, 0x18, 0x4101);
> > +	phy_write(phy, 0x09, 0x0e00);
> > +	phy_write(phy, 0x04, 0x01e1);
> > +	phy_write(phy, 0x00, 0x9140);
> > +	phy_write(phy, 0x00, 0x1140);
> > +
> > +	return  0;
> > +}
> > +
> > +static struct mii_phy_ops m88e1111_phy_ops = {
> > +	.init		= m88e1111_init,
> > +	.setup_aneg	= genmii_setup_aneg,
> > +	.setup_forced	= genmii_setup_forced,
> > +	.poll_link	= genmii_poll_link,
> > +	.read_link	= genmii_read_link
> > +};
> > +
> > +static struct mii_phy_def m88e1111_phy_def = {
> > +
> > +	.phy_id		= 0x01410CC0,
> > +	.phy_id_mask	= 0x0ffffff0,
> > +	.name		= "Marvell 88E1111 Ethernet",
> > +	.ops		= &m88e1111_phy_ops,
> > +};
> > +
> >  static struct mii_phy_def *mii_phy_table[] = {
> >  	&cis8201_phy_def,
> > +	&bcm5248_phy_def,
> > +	&m88e1111_phy_def,
> >  	&genmii_phy_def,
> 
> Seems sane to me -- ACK -- but we have multiple people sending me 
> patches for a single driver.  That's normal for janitorial cleanups 
> across the whole tree, but discouraged when multiple people are actively 
> working on the same driver.
> 
> Please coordinate, and have ONE person send me patches...

Jeff, could you please pull in this patch for 2.6.24?  We'll get the
coordination down for any further patches.

thx,
josh
> 
