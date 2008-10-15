Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id A629FDDF9B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Oct 2008 01:28:58 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so2753527wfg.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Oct 2008 07:28:57 -0700 (PDT)
Date: Wed, 15 Oct 2008 08:28:55 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [patch 1/2] FEC_MPC52XX_PHY: Remove obsolete code
Message-ID: <20081015142855.GE16262@secretlab.ca>
References: <20080816023159.126377505@pengutronix.de>
	<20080816024055.241009929@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080816024055.241009929@pengutronix.de>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Aug 16, 2008 at 04:32:00AM +0200, Wolfram Sang wrote:
> Remove last remains of the former (and broken) irq support code. The
> driver is polling only.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>

I'm not convinced on this one.  At the very least I need a more detailed
description of what is wrong and why the code needs to be removed.  As
far as I can tell, this code affects two different IRQ paths.  First is
the MDIO irq which tells the processor that an MDIO transaction has
completed.  Second is an IRQ from the PHY itself which can come in from
an entirely different path.

As it stands, I'm going to hold off picking this one up.

g.

> ---
>  drivers/net/fec_mpc52xx_phy.c |   20 --------------------
>  1 file changed, 20 deletions(-)
> 
> Index: .kernel/drivers/net/fec_mpc52xx_phy.c
> ===================================================================
> --- .kernel.orig/drivers/net/fec_mpc52xx_phy.c
> +++ .kernel/drivers/net/fec_mpc52xx_phy.c
> @@ -76,7 +76,6 @@
>  {
>  	struct device *dev = &of->dev;
>  	struct device_node *np = of->node;
> -	struct device_node *child = NULL;
>  	struct mii_bus *bus;
>  	struct mpc52xx_fec_mdio_priv *priv;
>  	struct resource res = {};
> @@ -105,15 +104,6 @@
>  	for (i=0; i<PHY_MAX_ADDR; i++)
>  		bus->irq[i] = PHY_POLL;
>  
> -	while ((child = of_get_next_child(np, child)) != NULL) {
> -		int irq = irq_of_parse_and_map(child, 0);
> -		if (irq != NO_IRQ) {
> -			const u32 *id = of_get_property(child, "reg", NULL);
> -			if (id)
> -				bus->irq[*id] = irq;
> -		}
> -	}
> -
>  	/* setup registers */
>  	err = of_address_to_resource(np, 0, &res);
>  	if (err)
> @@ -133,9 +123,6 @@
>  	/* set MII speed */
>  	out_be32(&priv->regs->mii_speed, ((mpc52xx_find_ipb_freq(of->node) >> 20) / 5) << 1);
>  
> -	/* enable MII interrupt */
> -	out_be32(&priv->regs->imask, in_be32(&priv->regs->imask) | FEC_IMASK_MII);
> -
>  	err = mdiobus_register(bus);
>  	if (err)
>  		goto out_unmap;
> @@ -145,9 +132,6 @@
>   out_unmap:
>  	iounmap(priv->regs);
>   out_free:
> -	for (i=0; i<PHY_MAX_ADDR; i++)
> -		if (bus->irq[i] != PHY_POLL)
> -			irq_dispose_mapping(bus->irq[i]);
>  	kfree(bus->irq);
>  	kfree(priv);
>  	kfree(bus);
> @@ -160,15 +144,11 @@
>  	struct device *dev = &of->dev;
>  	struct mii_bus *bus = dev_get_drvdata(dev);
>  	struct mpc52xx_fec_mdio_priv *priv = bus->priv;
> -	int i;
>  
>  	mdiobus_unregister(bus);
>  	dev_set_drvdata(dev, NULL);
>  
>  	iounmap(priv->regs);
> -	for (i=0; i<PHY_MAX_ADDR; i++)
> -		if (bus->irq[i])
> -			irq_dispose_mapping(bus->irq[i]);
>  	kfree(priv);
>  	kfree(bus->irq);
>  	kfree(bus);
> 
> -- 
>   Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
