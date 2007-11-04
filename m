Return-Path: <ntl@pobox.com>
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by ozlabs.org (Postfix) with ESMTP id 87C78DDEFD
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Nov 2007 04:18:24 +1100 (EST)
Date: Sun, 4 Nov 2007 11:18:14 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Roel Kluin <12o3l@tiscali.nl>
Subject: Re: [PATCH] Balance alloc/free and ioremap/iounmap in gpio_mdio_probe
	(powerpc/platforms/pasemi/gpio_mdio.c)
Message-ID: <20071104171814.GI9695@localdomain>
References: <472DF914.7020601@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <472DF914.7020601@tiscali.nl>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Roel Kluin wrote:
> I think this is how it should be done, but
> please review: it was not tested.
> --
> Balance alloc/free and ioremap/iounmap

It would be more helpful if your changelog identified the objects
which could be leaked.  More comments below.


> -static int __devinit gpio_mdio_probe(struct of_device *ofdev,
> -				     const struct of_device_id *match)
> +static int __devinit __gpio_mdio_register_bus(struct of_device *ofdev,
> +					const struct of_device_id *match)
>  {
>  	struct device *dev = &ofdev->dev;
>  	struct device_node *np = ofdev->node;
> -	struct device_node *gpio_np;
>  	struct mii_bus *new_bus;
>  	struct resource res;
>  	struct gpio_priv *priv;
>  	const unsigned int *prop;
> -	int err = 0;
>  	int i;
>  
> -	gpio_np = of_find_compatible_node(NULL, "gpio", "1682m-gpio");
> -
> -	if (!gpio_np)
> -		return -ENODEV;
> -
> -	err = of_address_to_resource(gpio_np, 0, &res);
> -	of_node_put(gpio_np);
> -
> -	if (err)
> -		return -EINVAL;
> -
> -	if (!gpio_regs)
> -		gpio_regs = ioremap(res.start, 0x100);
> -
> -	if (!gpio_regs)
> -		return -EPERM;
> -
>  	priv = kzalloc(sizeof(struct gpio_priv), GFP_KERNEL);
> -	if (priv == NULL)
> +	if (unlikely(priv == NULL))
>  		return -ENOMEM;

Please don't add likely/unlikely to non-hot paths such as this.


>  	new_bus = kzalloc(sizeof(struct mii_bus), GFP_KERNEL);
>  
> -	if (new_bus == NULL)
> -		return -ENOMEM;
> +	if (unlikely(new_bus == NULL))
> +		goto free_priv;

again

>  
>  	new_bus->name = "pasemi gpio mdio bus",
>  	new_bus->read = &gpio_mdio_read,
>  	new_bus->write = &gpio_mdio_write,
>  	new_bus->reset = &gpio_mdio_reset,
>  
>  	prop = of_get_property(np, "reg", NULL);
>  	new_bus->id = *prop;
>  	new_bus->priv = priv;
>  
>  	new_bus->phy_mask = 0;
>  
>  	new_bus->irq = kmalloc(sizeof(int)*PHY_MAX_ADDR, GFP_KERNEL);
> +	if (unlikely(new_bus->irq == NULL))
> +		goto free_new_bus;
> +

again

>  	for(i = 0; i < PHY_MAX_ADDR; ++i)
>  		new_bus->irq[i] = irq_create_mapping(NULL, 10);
>  
>  
>  	prop = of_get_property(np, "mdc-pin", NULL);
>  	priv->mdc_pin = *prop;
>  
>  	prop = of_get_property(np, "mdio-pin", NULL);
>  	priv->mdio_pin = *prop;
>  
>  	new_bus->dev = dev;
>  	dev_set_drvdata(dev, new_bus);
>  
>  	err = mdiobus_register(new_bus);
>  
> -	if (0 != err) {
> +	if (unlikely(0 != err)) {

again

>  		printk(KERN_ERR "%s: Cannot register as MDIO bus, err %d\n",
>  				new_bus->name, err);
>  		goto bus_register_fail;
>  	}
>  
>  	return 0;
>  
>  bus_register_fail:
> +	kfree(new_bus->irq);
> +free_new_bus:
>  	kfree(new_bus);
> +free_priv:
> +	kfree(priv);
> +
> +	return -ENOMEM;
> +}
> +
> +
> +static int __devinit gpio_mdio_probe(struct of_device *ofdev,
> +				     const struct of_device_id *match)
> +{
> +	struct device_node *gpio_np;
> +	int err;
> +
> +	gpio_np = of_find_compatible_node(NULL, "gpio", "1682m-gpio");
> +
> +	if (!gpio_np)
> +		return -ENODEV;
> +
> +	err = of_address_to_resource(gpio_np, 0, &res);

Hmm, where is "res" defined?


> +	of_node_put(gpio_np);
> +
> +	if (err)
> +		return -EINVAL;
> +
> +	if (!gpio_regs) {
> +

Unneeded newline


> +		gpio_regs = ioremap(res.start, 0x100);
> +		if (unlikely(!gpio_regs))
> +			return -EPERM;
> +
> +		err = __gpio_mdio_register_bus(ofdev, match);
> +		if (err < 0)
> +			iounmap(gpio_regs);
> +	} else
> +		err = __gpio_mdio_register_bus(ofdev, match);
>  
>  	return err;
> +

again

>  }
>  
>  
>  static int gpio_mdio_remove(struct of_device *dev)
>  {
>  	struct mii_bus *bus = dev_get_drvdata(&dev->dev);
>  
>  	mdiobus_unregister(bus);
> 
