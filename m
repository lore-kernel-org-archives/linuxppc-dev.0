Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id E8D6ADDF13
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 12:02:55 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 9/13] powerpc: Add arch/powerpc mv64x60 I2C platform data
	setup
Date: Thu, 26 Apr 2007 04:02:16 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260255.04490.arnd@arndb.de>
	<20070426011328.GR4046@mag.az.mvista.com>
In-Reply-To: <20070426011328.GR4046@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260402.17248.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Mark A. Greer wrote:
> > location is the smaller part of the problem. Even if it was the right
> > thing to scan the tree and then create platform_data instead of using
> > the of_device, that code would still belong into the device driver.
> 
> I don't think of_device is going to work very well on MIPS.

Ok, I see your point there. But after looking at the i2c and net drivers,
I believe that they can easily be split into an architecture dependent
part that is either an of_platform_driver or a platform_driver, and
a common part that does not know about either of these.

With the example of the i2c driver, you can have something like:

i2c-mv64xxx.c:
=============
int __devinit mv64xxx_i2c_probe(struct device *dev, struct mv64xxx_i2c_pdata *data,
		struct resource *regs, int irq)
{
	...
}
EXPORT_SYMBOL_GPL(mv64xxx_i2c_probe);

int __devexit mv64xxx_i2c_remove(struct device *dev)
{
	...
}
EXPORT_SYMBOL_GPL(mv64xxx_i2c_remove);

i2c-mv64xxx-pdev.c:
========================
static int __devinit mv64xxx_i2c_probe_pdev(struct platform_device *pd)
{
	return mv64xxx_i2c_probe(&pd->dev, &pd->dev.platform_data, 
			platform_get_resource(pd, IORESOURCE_MEM, 0)),
			platform_get_irq(pd, 0));
}
static int __devexit mv64xxx_i2c_remove_pdev(struct platform_device *pd)
{
	return mv64xxx_i2c_remove(&pd->dev);
}
static struct platform_driver mv64xxx_i2c_driver = {
	.probe	= mv64xxx_i2c_probe_pdev,
	.remove	= mv64xxx_i2c_remove_pdev,
	.driver	= {
		.owner	= THIS_MODULE,
		.name	= MV64XXX_I2C_CTLR_NAME,
	},
};
static int __init
mv64xxx_i2c_init_pdev(void)
{
	return platform_driver_register(&mv64xxx_i2c_driver);
}
static void __exit
mv64xxx_i2c_exit_pdev(void)
{
	platform_driver_unregister(&mv64xxx_i2c_driver);
}
module_init(mv64xxx_i2c_init_pdev);
module_exit(mv64xxx_i2c_exit_pdev);

i2c-mv64xxx-of.c:
========================
static int __devinit mv64xxx_i2c_probe_of(struct of_device *dev)
{
	struct mv64xxx_i2c_pdata pdata;
	struct resource resource;
	int irq;

	of_address_to_resource(&dev->node, 0, &resource);
	of_map_irq(&dev->node, 0, &irq);
	return mv64xxx_i2c_probe(&dev->dev, &pdata, &resource, irq);
}
static int __devexit mv64xxx_i2c_remove_pdev(struct of_device *dev)
{
	return mv64xxx_i2c_remove(&dev->dev);
}
static struct of_device_id mv64xxx_i2c_device_ids = {
	{ .type = "i2c", .compatible = "mv64x60-i2c" },
	{ },
};
static struct of_platform_driver mv64xxx_i2c_of_driver = {
	.probe	= mv64xxx_i2c_probe_of,
	.remove	= mv64xxx_i2c_remove_of,
	.ids = &mv64xxx_i2c_device_ids,
	.driver	= {
		.owner	= THIS_MODULE,
		.name	= MV64XXX_I2C_CTLR_NAME,
	},
};
static int __init
mv64xxx_i2c_init_of(void)
{
	return of_platform_driver_register(&mv64xxx_i2c_of_driver);
}
static void __exit
mv64xxx_i2c_exit_of(void)
{
	of_platform_driver_unregister(&mv64xxx_i2c_driver);
}
module_init(mv64xxx_i2c_init_of);
module_exit(mv64xxx_i2c_exit_of);
