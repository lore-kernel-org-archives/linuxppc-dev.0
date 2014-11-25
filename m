Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A6351A045F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Nov 2014 07:36:20 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 59B811401DA
 for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2014 07:36:19 +1100 (AEDT)
Message-ID: <1416947765.4998.69.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] i2c: Driver to expose PowerNV platform i2c busses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Wed, 26 Nov 2014 07:36:05 +1100
In-Reply-To: <20141125175316.GB9716@katana>
References: <20141116171605.4750.17472.stgit@localhost.localdomain>
 <20141125175316.GB9716@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-11-25 at 18:53 +0100, Wolfram Sang wrote:
> On Sun, Nov 16, 2014 at 10:47:46PM +0530, Neelesh Gupta wrote:
> > The patch exposes the available i2c busses on the PowerNV platform
> > to the kernel and implements the bus driver to support i2c and
> > smbus commands.
> > The driver uses the platform device infrastructure to probe the busses
> > on the platform and registers them with the i2c driver framework.
> > 
> > Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> ...
> 
> > diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
> > index 917c358..71ad6e1 100644
> > --- a/drivers/i2c/busses/Kconfig
> > +++ b/drivers/i2c/busses/Kconfig
> > @@ -1044,4 +1044,15 @@ config SCx200_ACB
> >  	  This support is also available as a module.  If so, the module
> >  	  will be called scx200_acb.
> >  
> > +config I2C_OPAL
> > +	tristate "IBM OPAL I2C driver"
> > +	depends on PPC_POWERNV
> > +	default y
> > +	help
> > +	  This exposes the PowerNV platform i2c busses to the linux i2c layer,
> > +	  the driver is based on the OPAL interfaces.
> > +
> > +	  This driver can also be built as a module. If so, the module will be
> > +	  called as i2c-opal.
> > +
> >  endmenu
> > diff --git a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
> > index 78d56c5..350aa86 100644
> > --- a/drivers/i2c/busses/Makefile
> > +++ b/drivers/i2c/busses/Makefile
> > @@ -102,5 +102,6 @@ obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
> >  obj-$(CONFIG_I2C_PCA_ISA)	+= i2c-pca-isa.o
> >  obj-$(CONFIG_I2C_SIBYTE)	+= i2c-sibyte.o
> >  obj-$(CONFIG_SCx200_ACB)	+= scx200_acb.o
> > +obj-$(CONFIG_I2C_OPAL)		+= i2c-opal.o
> 
> Please keep it proprly sorted.
> 
> > +	rc = of_property_read_u32(pdev->dev.of_node, "ibm,opal-id", &opal_id);
> > +	if (rc) {
> > +		dev_err(&pdev->dev, "Missing ibm,opal-id property !\n");
> > +		return -EIO;
> > +	}
> 
> You introduce new bindings which need to be documented in
> Docuemntation/devicetree/bindings/i2c.

Ugh ... thanks god the powerpc maintainer (me) didn't request binding
document for everything that went into the device-tree on those
platforms or we would still be writing them....

> They should be posted as a seperate patch with
> devicetree@vger.kernel.org CCed, so they can comment on it. This is
> required these days and especially important..

Suuure, let's create more process and committees, and make sure nothing
gets done in any reasonable amount of time. Have we gone completely
insane ?

This is completely useless as an exercise. It's not like I'm going to
change the firmware interfaces anymore anyway so the "comments" are
going to be at best bike shed painting.

I'm getting close to just put that driver in powerpc.git ...
 
The point of publicly discussing bindings in the ARM world was in part
because we attacked a community with no understanding of the DT, but in
LARGE part because we had to define them for components and SoC that
would potentially be re-used in different platforms etc..

Here we are talking about a representation specific to a given FW
interface on PowerPC only which isn't going to be used by any other
platform that PowerNV (since the OPAL fw is what makes PowerNV) by the
people who invented the frigging flat device tree in the first place, so
give me a break.

It's getting quite tempting to just throw that driver into powerpc.git

> > +	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
> > +	if (!adapter)
> > +		return -ENOMEM;
> > +
> > +	adapter->algo = &i2c_opal_algo;
> > +	adapter->algo_data = (void *)(unsigned long)opal_id;
> > +	adapter->dev.parent = &pdev->dev;
> > +	adapter->dev.of_node = of_node_get(pdev->dev.of_node);
> > +	pname = of_get_property(pdev->dev.of_node, "ibm,port-name", NULL);
> > +	if (pname)
> > +		strlcpy(adapter->name, pname, sizeof(adapter->name));
> > +	else
> > +		strlcpy(adapter->name, "opal", sizeof(adapter->name));
> 
> ... because I'd like to get an ack from them because of this binding.

And I don't give a flying crap about what random ARM SOC vendor thinks
of my powerpc FW interface for a powerpc unique FW interface.

>  I
> don't know if we can just say "this comes from firmware, so we must
> support it" (although you wrote the firmware IIUC) or if we have to
> judge if this is a HW description which should go into DT? I am open
> meanwhile that the adapter name does not need to be static anymore.
> However, I don't know much about server world and FW, so maybe they can
> assist.

I doubt it, all we're going to do is waste a few more monthes and make
it more painful for us to get our support into distros in time with 0
benefit whatsoever.

> An example binding in that document would also be very helpful.
> 
> 
> > +static struct platform_driver i2c_opal_driver = {
> > +	.probe	= i2c_opal_probe,
> > +	.remove	= i2c_opal_remove,
> > +	.driver	= {
> > +		.name		= "i2c-opal",
> > +		.owner		= THIS_MODULE,
> 
> owner not needed.
> 
> Thanks,
> 
>    Wolfram
