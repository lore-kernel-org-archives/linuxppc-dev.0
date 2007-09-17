Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Sep 2007 11:32:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Message-ID: <20070917013236.GD32725@localhost.localdomain>
References: <200709161352.03459.sr@denx.de>
	<20070916162747.GV23573@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070916162747.GV23573@pengutronix.de>
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

On Sun, Sep 16, 2007 at 06:27:47PM +0200, Robert Schwebel wrote:
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

The dual nomenclature comes because linux uses i2c throughout the
subsystem, but all the hardware documentation refers to the controller
ASIC in question as 'IIC'.  So I think the convention is that 'i2c' is
used to refer to the type of bus in general, 'iic' is used to refer to
this particular type of bus controller.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
