Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BA709DDDF3
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Nov 2007 08:07:15 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lA1L7Clg016763
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 17:07:12 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	lA1L7Bdi118908
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 15:07:11 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lA1L7B2T000845
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Nov 2007 15:07:11 -0600
Date: Thu, 1 Nov 2007 16:07:09 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [PATCH] net: Add 405EX support to new EMAC driver
Message-ID: <20071101160709.7e7c0181@weaponx.rchland.ibm.com>
In-Reply-To: <1193949421.6541.10.camel@pasglop>
References: <200711011554.04935.sr@denx.de> <1193949421.6541.10.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 02 Nov 2007 07:37:01 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> On Thu, 2007-11-01 at 15:54 +0100, Stefan Roese wrote:
> > This patch adds support for the 405EX to the new EMAC driver.
> > 
> > Tested on AMCC Kilauea.
> 
>  .../...
> 
> > diff --git a/drivers/net/ibm_newemac/rgmii.c b/drivers/net/ibm_newemac/rgmii.c
> > index de41695..e393f68 100644
> > --- a/drivers/net/ibm_newemac/rgmii.c
> > +++ b/drivers/net/ibm_newemac/rgmii.c
> > @@ -140,9 +140,6 @@ void rgmii_get_mdio(struct of_device *ofdev, int input)
> >  
> >  	RGMII_DBG2(dev, "get_mdio(%d)" NL, input);
> >  
> > -	if (dev->type != RGMII_AXON)
> > -		return;
> > -
> >  	mutex_lock(&dev->lock);
> 
> That will break 440GX boards that need to use the RGMII for data and the
> ZMII for MDIO.
> 
> You may want to change the name RGMII_AXON something like RGMII_HAS_MDIO
> instead and set that for 405EX as well instead.

And perhaps adding a comment about that since the meaning of that code
isn't very obvious. That way people that aren't the original author
of the driver don't get confused again.

josh
