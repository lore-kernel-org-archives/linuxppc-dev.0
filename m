Return-Path: <khali@linux-fr.org>
Received: from mallaury.nerim.net (smtp-106-saturday.noc.nerim.net
	[62.4.17.106]) by ozlabs.org (Postfix) with ESMTP id D4F3EDDE9A
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Feb 2008 20:31:26 +1100 (EST)
Date: Sat, 16 Feb 2008 10:31:23 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH 2/2] i2c-ibm_iic driver
Message-ID: <20080216103123.50a0128b@hyperion.delvare>
In-Reply-To: <47B66260.8010902@pikatech.com>
References: <4784FED1.2040206@pikatech.com> <47A14E23.50807@pikatech.com>
	<20080214094516.1b958ae4@hyperion.delvare>
	<47B66260.8010902@pikatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sean,

On Fri, 15 Feb 2008 23:11:12 -0500, Sean MacLennan wrote:
> Here is the of platform patch. I removed the retries and removed the spaces used for spacing.
> 
> Cheers,
>    Sean
> 
> Signed-off-by: Sean MacLennan <smaclennan@pikatech.com>

First of all: please run scripts/checkpatch.pl on your patch and fix
the reported errors. It tells me:
  total: 10 errors, 5 warnings, 222 lines checked
which is definitely too much.

Review:

> ---
> --- old-i2c-ibm_iic.c	2008-02-15 23:01:58.000000000 -0500
> +++ i2c-ibm_iic.c	2008-02-15 23:00:44.000000000 -0500

Please send a proper -p1 patch next time.

> @@ -6,6 +6,9 @@
>   * Copyright (c) 2003, 2004 Zultys Technologies.
>   * Eugene Surovegin <eugene.surovegin@zultys.com> or <ebs@ebshome.net>
>   *
> + * Copyright (c) 2008 PIKA Technologies
> + * Sean MacLennan <smaclennan@pikatech.com>
> + *
>   * Based on original work by
>   * 	Ian DaSilva  <idasilva@mvista.com>
>   *      Armin Kuster <akuster@mvista.com>
> @@ -39,12 +42,17 @@
>  #include <asm/io.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-id.h>
> +
> +#ifdef CONFIG_IBM_OCP

Your patch seems to be incomplete. There is still

config I2C_IBM_IIC
	tristate "IBM PPC 4xx on-chip I2C interface"
	depends on IBM_OCP

in drivers/i2c/busses/Kconfig, so the new code can never be active.

>  #include <asm/ocp.h>
>  #include <asm/ibm4xx.h>
> +#else
> +#include <linux/of_platform.h>
> +#endif
>  
>  #include "i2c-ibm_iic.h"
>  
> -#define DRIVER_VERSION "2.1"
> +#define DRIVER_VERSION "2.2"
>  
>  MODULE_DESCRIPTION("IBM IIC driver v" DRIVER_VERSION);
>  MODULE_LICENSE("GPL");
> @@ -657,6 +665,7 @@
>  	return (u8)((opb + 9) / 10 - 1);
>  }
>  
> +#ifdef CONFIG_IBM_OCP
>  /*
>   * Register single IIC interface
>   */
> @@ -830,3 +839,188 @@
>  
>  module_init(iic_init);
>  module_exit(iic_exit);
> +#else

Please add a comment saying what this #else corresponds to.

> +/*
> + * Register single IIC interface
> + */
> +static int __devinit iic_probe(struct of_device *ofdev,
> +			       const struct of_device_id *match)
> +{
> +	static int index = 0;
> +	struct device_node *np = ofdev->node;
> +	struct ibm_iic_private* dev;

Confusing variable name.

> +	struct i2c_adapter* adap;
> +	const u32 *indexp, *freq;
> +	int ret;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev) {
> +		printk(KERN_ERR "ibm-iic: failed to allocate device data\n");

Please use dev_err. Same for all other messages below.

> +		return -ENOMEM;
> +	}
> +
> +	/* This assumes we don't mix index and non-index entries. */
> +	indexp = of_get_property(np, "index", NULL);
> +	dev->idx = indexp ? *indexp : index++;

I don't like this static index thing much. Can't you just make the
"index" OF property mandatory? Mixing ways to number things can become
very confusing. In particular as you are using dev->idx later to call
i2c_add_numbered_adapter(), the caller is really supposed to know what
they are doing with the bus numbers.

> +
> +	dev_set_drvdata(&ofdev->dev, dev);
> +
> +	dev->vaddr = of_iomap(np, 0);
> +	if (dev->vaddr == NULL) {
> +		printk(KERN_ERR "ibm-iic%d: failed to ioremap device registers\n",
> +			dev->idx);
> +		ret = -ENXIO;
> +		goto fail1;
> +	}
> +
> +	init_waitqueue_head(&dev->wq);
> +
> +	if (iic_force_poll)
> +		dev->irq = NO_IRQ;
> +	else {
> +		dev->irq = irq_of_parse_and_map(np, 0);
> +		if (dev->irq == NO_IRQ)
> +			printk(KERN_ERR __FILE__ ": irq_of_parse_and_map failed\n");
> +		else {
> +			/* Disable interrupts until we finish initialization,
> +			   assumes level-sensitive IRQ setup...
> +			*/
> +			iic_interrupt_mode(dev, 0);
> +			if (request_irq(dev->irq, iic_handler, 0, "IBM IIC", dev)){
> +				printk(KERN_ERR "ibm-iic%d: request_irq %d failed\n",
> +				       dev->idx, dev->irq);
> +				/* Fallback to the polling mode */
> +				dev->irq = NO_IRQ;
> +			}
> +		}
> +	}
> +
> +	if (dev->irq == NO_IRQ)
> +		printk(KERN_WARNING "ibm-iic%d: using polling mode\n",
> +			   dev->idx);
> +
> +	/* Board specific settings */
> +	if (iic_force_fast || of_get_property(np, "fast-mode", NULL))
> +		dev->fast_mode = 1;
> +	else
> +		dev->fast_mode = 0;

The second part is not needed, 0 is the default thanks to kzalloc.

> +
> +	/* clckdiv is the same for *all* IIC interfaces, but I'd rather
> +	 * make a copy than introduce another global. --ebs
> +	 */
> +	freq = of_get_property(np, "clock-frequency", NULL);
> +	if (freq == NULL) {
> +		freq = of_get_property(np->parent, "clock-frequency", NULL);
> +		if (freq == NULL) {
> +			printk(KERN_ERR "ibm-iic%d: Unable to get bus frequency\n",
> +			       dev->idx);
> +			ret = -EBUSY;
> +			goto fail;
> +		}
> +	}
> +
> +	dev->clckdiv = iic_clckdiv(*freq);
> +	DBG("%d: clckdiv = %d\n", dev->idx, dev->clckdiv);
> +
> +	/* Initialize IIC interface */
> +	iic_dev_init(dev);
> +
> +	/* Register it with i2c layer */
> +	adap = &dev->adap;
> +	adap->dev.parent = &ofdev->dev;
> +	strcpy(adap->name, "IBM IIC");

strlcpy please.

> +	i2c_set_adapdata(adap, dev);
> +	adap->id = I2C_HW_OCP;
> +	adap->class = I2C_CLASS_HWMON;
> +	adap->algo = &iic_algo;
> +	adap->client_register = NULL;
> +	adap->client_unregister = NULL;

The last two statements are not needed, again kzalloc did it for you.

> +	adap->timeout = 1;
> +	adap->nr = dev->idx;

Looks to me like the block above has much in common with the original
probe function, maybe it would be worth sharing the code to make future
maintenance easier?

> +
> +	ret = i2c_add_numbered_adapter(adap);
> +	if (ret  < 0) {
> +		printk(KERN_ERR "ibm-iic%d: failed to register i2c adapter\n",
> +			dev->idx);
> +		goto fail;
> +	}
> +
> +	printk(KERN_INFO "ibm-iic%d: using %s mode\n", dev->idx,
> +		dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
> +
> +	return 0;
> +
> +fail:
> +	if (dev->irq != NO_IRQ){
> +		iic_interrupt_mode(dev, 0);
> +		free_irq(dev->irq, dev);
> +	}
> +
> +	iounmap(dev->vaddr);
> +fail1:

I suggest giving explicit names to your labels based on the next
action, e.g. err_free_irq and err_kfree.

> +	dev_set_drvdata(&ofdev->dev, NULL);
> +	kfree(dev);
> +	return ret;
> +}
> +
> +/*
> + * Cleanup initialized IIC interface
> + */
> +static int __devexit iic_remove(struct of_device *ofdev)
> +{
> +	struct ibm_iic_private* dev = dev_get_drvdata(&ofdev->dev);
> +
> +	BUG_ON(dev == NULL);

How could this happen at all?

> +	if (i2c_del_adapter(&dev->adap)){

i2c_del_adapter can't really fail and almost all other drivers don't
even bother checking the error code. But if you do, you should really
return the error code.

> +		printk(KERN_ERR "ibm-iic%d: failed to delete i2c adapter :(\n",
> +			dev->idx);
> +		/* That's *very* bad, just shutdown IRQ ... */
> +		if (dev->irq != NO_IRQ){
> +		    iic_interrupt_mode(dev, 0);
> +		    free_irq(dev->irq, dev);
> +		    dev->irq = NO_IRQ;

Bad indentation.

> +		}
> +	} else {
> +		if (dev->irq != NO_IRQ){
> +		    iic_interrupt_mode(dev, 0);
> +		    free_irq(dev->irq, dev);

Bad indentation.

> +		}
> +		iounmap(dev->vaddr);

May I suggest adding:

		dev_set_drvdata(&ofdev->dev, NULL);

> +		kfree(dev);
> +	}
> +
> +	return 0;
> +}
> +
> +
> +static const struct of_device_id ibm_iic_match[] =
> +{
> +	{ .compatible = "ibm,iic-405ex", },
> +	{ .compatible = "ibm,iic-405gp", },
> +	{ .compatible = "ibm,iic-440gp", },
> +	{ .compatible = "ibm,iic-440gpx", },
> +	{ .compatible = "ibm,iic-440grx", },
> +	{}
> +};
> +
> +static struct of_platform_driver ibm_iic_driver =
> +{
> +	.name	= "ibm-iic",
> +	.match_table = ibm_iic_match,
> +	.probe	= iic_probe,
> +	.remove	= iic_remove,

Missing __devexit_p.

> +};
> +
> +static int __init ibm_iic_init(void)
> +{
> +	printk(KERN_INFO "IBM IIC driver v" DRIVER_VERSION "\n");
> +	return of_register_platform_driver(&ibm_iic_driver);
> +}
> +module_init(ibm_iic_init);
> +
> +static void __exit ibm_iic_exit(void)
> +{
> +	of_unregister_platform_driver(&ibm_iic_driver);
> +}
> +module_exit(ibm_iic_exit);

If you would name these functions iic_init and iic_exit as the original
code does, you wouldn't have to duplicate the module_init and
module_exit statements.

> +#endif

Please add a comment saying what this #endif corresponds to.

Note that I cannot test the code so I am relying on the linuxppc-dev
folks to test it.

-- 
Jean Delvare
