Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC734DDDF9
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Sep 2007 02:37:40 +1000 (EST)
Date: Sun, 16 Sep 2007 11:37:27 -0500
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Message-ID: <20070916113727.20b9f786@vader.jdub.homelinux.org>
In-Reply-To: <20070916162747.GV23573@pengutronix.de>
References: <200709161352.03459.sr@denx.de>
	<20070916162747.GV23573@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Jean Delvare <khali@linux-fr.org>, linuxppc-dev@ozlabs.org,
	Stefan Roese <sr@denx.de>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 16 Sep 2007 18:27:47 +0200
Robert Schwebel <r.schwebel@pengutronix.de> wrote:

> On Sun, Sep 16, 2007 at 01:52:02PM +0200, Stefan Roese wrote:
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 9f3a4cd..12453e2 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -220,7 +220,17 @@ config I2C_PIIX4
> >  
> >  config I2C_IBM_IIC
> >  	tristate "IBM PPC 4xx on-chip I2C interface"
> > -	depends on IBM_OCP
> > +	depends on !PPC_MERGE
> > +	help
> > +	  Say Y here if you want to use IIC peripheral found on 
> > +	  embedded IBM PPC 4xx based systems. 
> 
> Can we agree on one nomenclature - either i2c or iic?
> 
> > +	  This driver can also be built as a module.  If so, the module
> > +	  will be called i2c-ibm_iic.
> 
> Are these drivers the same functionality (host i2c driver for 4xx)? If
> yes, shouldn't all in-tree users be migrated over and the old style
> driver be removed (with deprecation period)?

They are the same functionality, but for two different versions of the
arch.  The old one is arch/ppc, the new one is arch/powerpc.  4xx is
being migrated to arch/powerpc so eventually what you say will happen.
The arch/ppc tree is scheduled for removal in June of 2008.  For now,
we need both drivers since not everything in 4xx has moved yet.

josh
