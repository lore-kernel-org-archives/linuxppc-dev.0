Return-Path: <dgibson@ozlabs.org>
Date: Mon, 17 Sep 2007 11:31:13 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: [PATCH] i2c: devtree-aware iic support for PPC4xx
Message-ID: <20070917013113.GC32725@localhost.localdomain>
References: <200709161352.03459.sr@denx.de>
	<20070916185330.GA32314@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070916185330.GA32314@gate.ebshome.net>
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

On Sun, Sep 16, 2007 at 11:53:30AM -0700, Eugene Surovegin wrote:
> On Sun, Sep 16, 2007 at 01:52:02PM +0200, Stefan Roese wrote:
> > This patch reworks existing ibm-iic driver to an of_platform_device
> > and enables it to talk to device tree directly. The ocp quirks are
> > completely removed by this patch.
> > 
> > This is done to enable I2C support for the PPC4xx platforms now
> > being moved from arch/ppc (OCP) to arch/powerpc (of). The first board
> > using this driver will be the AMCC Sequoia (PPC440EPx).
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > 
> > ---
> > 2nd try with some cleanups. Please let me know if there still are some
> > problems.
> > 
> > Thanks.
> > 
> > commit 5748f81ff53277fa5c16de815b7d6b172ca284e9
> > tree 8284b3f1c836eb6eb06ee6882ee13b9e8f6cbb6b
> > parent d0174640eedc1cd756754f03afe2dbb3d56de74e
> > author Stefan Roese <sr@denx.de> Sun, 16 Sep 2007 13:46:40 +0200
> > committer Stefan Roese <sr@denx.de> Sun, 16 Sep 2007 13:46:40 +0200
> > 
> >  drivers/i2c/busses/Kconfig       |   12 -
> >  drivers/i2c/busses/Makefile      |    1 
> >  drivers/i2c/busses/i2c-ibm_iic.h |    3 
> >  drivers/i2c/busses/i2c-ibm_of.c  |  858 ++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 873 insertions(+), 1 deletions(-)
> > 
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
> > +
> > +	  This driver can also be built as a module.  If so, the module
> > +	  will be called i2c-ibm_iic.
> > +
> > +config I2C_IBM_OF
> > +	tristate "IBM PPC 4xx on-chip I2C interface"
> > +	depends on PPC_MERGE
> >  	help
> >  	  Say Y here if you want to use IIC peripheral found on 
> >  	  embedded IBM PPC 4xx based systems. 
> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> > index 5b752e4..0cd0bac 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -17,6 +17,7 @@ obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
> >  obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
> >  obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
> >  obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
> > +obj-$(CONFIG_I2C_IBM_OF)	+= i2c-ibm_of.o
> >  obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
> >  obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
> >  obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o
> 
> Hmm, I just noticed that you basically added a copy of existing 
> driver with small changes to support OF while keeping OCP one.
> 
> Why not just add OF support to the existing code (under some ifdef), 
> and then remove OCP support as soon as ppc -> powerpc transition is 
> finished? Why have two almost identical code in the tree?
> 
> I also personally don't like this _iic -> _of name change (you 
> removed peripheral name and added something which has nothing to do 
> with iic, I never heard of OF peripheral in 4xx chips). Whether you 
> use OCP or OF to pass a little information is quite irrelevant to the 
> iic driver operation.

I concur on this point.  Especially since on 4xx the device tree will
generally be a flattened device tree which is vaguely OF-like, but not
from an actual Open Firmware.

> If you insist on this approach, please add yourself as a maintainer of 
> this code, because I'm not going to support two identical copies of my 
> code in the kernel tree.
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
