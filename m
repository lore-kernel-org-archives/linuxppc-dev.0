Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 178A8DE3BD
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jun 2008 02:34:26 +1000 (EST)
Date: Mon, 16 Jun 2008 11:34:00 -0500
From: Scott Wood <scottwood@freescale.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 2/2] fs_enet: MDIO on GPIO support
Message-ID: <20080616163400.GA13996@loki.buserror.net>
References: <200805261152.37636.laurentp@cse-semaphore.com>
	<200805261153.46131.laurentp@cse-semaphore.com>
	<200806161057.03158.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200806161057.03158.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, vbordug@ru.mvista.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 16, 2008 at 10:57:02AM +0200, Laurent Pinchart wrote:
> On Monday 26 May 2008 11:53, Laurent Pinchart wrote:
> > Port the fs_enet driver to support the MDIO on GPIO driver for PHY access
> > in addition to the mii-bitbang driver.
> 
> Now that 1/2 has been applied by Jeff, could this one make it to 
> powerpc-next ?

This patch should probably go through Jeff as well...

Acked-by: Scott Wood <scottwood@freescale.com>

> > -	data = of_get_property(phynode, "reg", &len);
> > -	if (!data || len != 4)
> > -		goto out_put_mdio;
> > +	bus_id = of_get_gpio(mdionode, 0);
> > +	if (bus_id < 0) {
> > +		struct resource res;
> > +		ret = of_address_to_resource(mdionode, 0, &res);
> > +		if (ret)
> > +			goto out_put_mdio;
> > +		bus_id = res.start;
> > +	}
> >  
> > -	snprintf(fpi->bus_id, 16, "%x:%02x", res.start, *data);
> > +	snprintf(fpi->bus_id, 16, "%x:%02x", bus_id, *data);

It'd be nice if this sort of thing could be moved to phylib, so the latter
could simply be passed a device node (in addition to current mechanisms for
the benefit of unfortunate device-tree-less architectures).

-Scott
