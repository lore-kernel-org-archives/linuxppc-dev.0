Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 261DFDDE39
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 06:40:49 +1100 (EST)
Message-ID: <477BE8F8.9030804@scram.de>
Date: Wed, 02 Jan 2008 20:41:44 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 4/5] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
References: <20071220044136.20091.70984.stgit@terra.home>
	<20071220044144.20091.35917.stgit@terra.home>
In-Reply-To: <20071220044144.20091.35917.stgit@terra.home>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon,

> Convert MPC i2c driver from being a platform_driver to an open firmware version. Error returns were improved. Routine names were changed from fsl_ to mpc_ to make them match the file name

I did the same for my i2c-cpm. Tested with the frontprocessor driver (dbox2 specific) converted to new style. I'll post the new i2c-cpm, as well.

> +static void of_register_i2c_devices(struct i2c_adapter *adap, struct device_node *adap_node)
> +{
> +	struct device_node *node = NULL;
> +
> +	while ((node = of_get_next_child(adap_node, node))) {
> +		struct i2c_board_info info;
> +		const u32 *addr;
> +		const char *compatible;
> +		int len;
> +
> +		addr = of_get_property(node, "reg", &len);
> +		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
> +			printk(KERN_ERR "i2c-mpc.c: invalid entry, missing reg attribute\n");
> +			continue;
> +		}
> +
> +		info.irq = irq_of_parse_and_map(node, 0);
> +		if (info.irq == NO_IRQ)
> +			info.irq = -1;
> +
> +		compatible = of_get_property(node, "compatible", &len);
> +		if (!compatible) {
> +			printk(KERN_ERR "i2c-mpc.c: invalid entry, missing compatible attribute\n");
> +			continue;
> +		}
> +		
> +		/* need full alias i2c:NOF,vendor,device */
> +		strcpy(info.driver_name, I2C_OF_MODULE_PREFIX);
> +		strncat(info.driver_name, compatible, sizeof(info.driver_name));
> +		request_module(info.driver_name);
> +		
> +		/* need module alias OF,vendor,device */
> +		strcpy(info.driver_name, OF_I2C_PREFIX);
> +		strncat(info.driver_name, compatible, sizeof(info.driver_name));
> +		
> +		info.type[0] = '\0';
> +		info.platform_data = NULL;
> +		info.addr = *addr;
> +
> +		if (!i2c_new_device(adap, &info)) {
> +			printk(KERN_ERR "i2c-mpc.c: Failed to load driver for %s\n", info.driver_name);
> +			continue;
> +		}
> +	}
> +}

Should this go into some central file? Else we would have to copy it in any i2c bus driver that supports powerpc.
This would at least be i2c-cpm and i2c-gpio.

> +static int mpc_i2c_probe(struct of_device *op, const struct of_device_id *match)
> +{
> +	int result = 0;
> +	struct mpc_i2c *i2c;
> +
> +	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
> +	if (!i2c)
> +		return -ENOMEM;
> +
> +	if (of_get_property(op->node, "dfsrr", NULL))
> +		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
> +
> +	if (of_device_is_compatible(op->node, "mpc5200-i2c"))
> +		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
> +
> +	init_waitqueue_head(&i2c->queue);
> +
> +	i2c->base = of_iomap(op->node, 0);
> +	if (!i2c->base) {
> +		printk(KERN_ERR "i2c-mpc - failed to map controller\n");
> +		result = -ENOMEM;
> +		goto fail_map;
> +	}
> +
> +	i2c->irq = irq_of_parse_and_map(op->node, 0);
> +	if (i2c->irq == NO_IRQ) {
> +		result = -ENXIO;
> +		goto fail_irq;
> +	}
> +
> +	result = request_irq(i2c->irq, mpc_i2c_isr, IRQF_SHARED, "i2c-mpc", i2c);
> +	if (result < 0) {
> +		printk(KERN_ERR "i2c-mpc - failed to attach interrupt\n");
> +		goto fail_request;
> +	}
> +
> +	mpc_i2c_setclock(i2c);
> +
> +	dev_set_drvdata(&op->dev, i2c);
> +
> +	i2c->adap = mpc_ops;
> +	i2c_set_adapdata(&i2c->adap, i2c);
> +	i2c->adap.dev.parent = &op->dev;
> +
> +	result = i2c_add_adapter(&i2c->adap);
> +	if (result < 0) {
> +		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
> +		goto fail_add;
> +	}
> +
> +	of_register_i2c_devices(&i2c->adap, op->node);
> +
> +	return result;
> +
> +fail_add:
> +	free_irq(i2c->irq, i2c);
> +fail_request:
> +	irq_dispose_mapping(i2c->irq);
> +fail_irq:
> +	iounmap(i2c->base);
> +fail_map:
> +	kfree(i2c);
> +	return result;
> +};

IMHO, there should be a node attribute to override i2c_adapter.class. Legacy i2c drivers (in particular v4l and dvb drivers) use this class to decide which adapter to bind to. dbox2 needs I2C_CLASS_TV_DIGITAL (4).

Thanks,
Jochen
