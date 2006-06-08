Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 20E1967BCC
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 23:39:05 +1000 (EST)
Subject: Re: [PATCH 1/10] Add the mpc8641 hpcn Kconfig and Makefiles.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0EC9507F-27EE-46E4-A92A-E4150A2FA312@kernel.crashing.org>
References: <1149719645.23938.184.camel@cashmere.sps.mot.com>
	<0EC9507F-27EE-46E4-A92A-E4150A2FA312@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1149773699.23938.223.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 08:35:00 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-06-07 at 23:44, Kumar Gala wrote:
> On Jun 7, 2006, at 5:34 PM, Jon Loeliger wrote:


> >  config PPC_I8259
> >  	bool
> > +	default y if PPC_86xx
> >  	default n
> 
> This dependancy seems too generic, shouldn't it be based on some  
> board (its not like 86xx actually has an i8259 in it).

> > +# Makefile for the PowerPC 86xx linux kernel.
> > +#
> > +
> > +obj-$(CONFIG_PPC_86xx)		+= mpc86xx_hpcn.o misc.o
> 
> Seems like mpc86xx_hpcn.o is board specific code and should move down  
> one line.

> > +
> > +config I8259_LEVEL_TRIGGER
> > +	bool
> > +	depends on MPC8641
> > +	default y
> 
> again, seems like it should depend on a board & not MPC8641

OK, I'll fix all of those.


> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index d6d4494..fbeae82 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -252,12 +252,12 @@ config I2C_POWERMAC
> >  
> should probably separate this out into its own patch for the I2C  
> maintainer.

Ah, OK.  Who is that then?

Thanks,
jdl
