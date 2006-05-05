Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 9B3DB679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 May 2006 10:21:18 +1000 (EST)
In-Reply-To: <20060403152622.26013.14459.stgit@vitb.ru.mvista.com>
References: <20060403152622.26013.14459.stgit@vitb.ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F785D5DD-4C81-48BE-B63C-FF72E2A648E9@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 1/2] PAL: Support of the fixed PHY
Date: Thu, 4 May 2006 19:21:12 -0500
To: Vitaly Bordug <vbordug@ru.mvista.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What happened to this patch?  It doesn't seem to have been applied to  
any trees.  Well, I'm gonna give it a little review now, since I have  
some time.

On Apr 3, 2006, at 10:26, Vitaly Bordug wrote:

>
> This makes it possible for HW PHY-less boards to utilize PAL goodies.
> Generic routines to connect to fixed PHY are provided, as well as  
> ability
> to specify software callback that fills up link, speed, etc.  
> information
> into PHY descriptor (the latter feature not tested so far).
>
> Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
> ---

[snip]

> +/ 
> *--------------------------------------------------------------------- 
> --------
> + *  This func is used to create all the necessary stuff, bind
> + * the fixed phy driver and register all it on the mdio_bus_type.
> + * speed is either 10 or 100, duplex is boolean.
> + * number is used to create multiple fixed PHYs, so that several  
> devices can
> + * utilize them simultaneously.
> +  
> *--------------------------------------------------------------------- 
> --------*/
> +static int fixed_mdio_register_device(int number, int speed, int  
> duplex)
> +{
> +	struct mii_bus *new_bus;
> +	struct fixed_info *fixed;
> +	struct phy_device *phydev;
> +	int err = 0;
> +
> +	struct device* dev = kzalloc(sizeof(struct device), GFP_KERNEL);
> +
> +	if (NULL == dev)
> +		return -EINVAL;
> +
> +	new_bus = kzalloc(sizeof(struct mii_bus), GFP_KERNEL);
> +	
> +	if (NULL == new_bus)
> +		return -ENOMEM;

You don't free dev, here

> +	
> +	fixed = kzalloc(sizeof(struct fixed_info), GFP_KERNEL);
> +	
> +	if (NULL == fixed) {
> +		kfree(new_bus);
> +		return -ENOMEM;
> +	}

And dev


> +	
> +	fixed->regs = kzalloc(MII_REGS_NUM*sizeof(int), GFP_KERNEL);

You don't check for failure for regs's allocation.

[snip]

> +	/* create phy_device and register it on the mdio bus */
> +	phydev = phy_device_create(new_bus, 0, 0);
> +
> +	/*
> +	 Put the phydev pointer into the fixed pack so that bus read/ 
> write code could be able
> +	 to access for instance attached netdev. Well it doesn't have  to  
> do so, only in case
> +	 of utilizing user-specified link-update...
> +	 */
> +	fixed->phydev = phydev;
> +
> +	if(NULL == phydev) {
> +		err = -ENOMEM;
> +		goto bus_register_fail;
> +	}

You're going to need to change this, because phydev isn't guaranteed  
to be NULL in the event of a failure to allocate.  it will be ERR_PTR 
(-ENOMEM).  I know you changed this in phy_device_create(), but I  
have more on that later.  You should do:

if (IS_ERR(phydev)) {
	err = PTR_ERR(-ENOMEM);
	goto bus_register_fail;
}

[snip]

> +
> +	return 0;
> +
> +bus_register_fail:
> +	kfree(new_bus);

You need to free regs and dev, too



> diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
> index 459443b..c87f89e 100644
> --- a/drivers/net/phy/mdio_bus.c
> +++ b/drivers/net/phy/mdio_bus.c
> @@ -66,7 +66,7 @@ int mdiobus_register(struct mii_bus *bus
>  		phydev = get_phy_device(bus, i);
>
>  		if (IS_ERR(phydev))
> -			return PTR_ERR(phydev);
> +			continue;


No.  Why'd you change that?  Now mdiobus_register doesn't return an  
error if memory runs out.  Here's how the system works:   
get_phy_device() can return one of three things:

1) A pointer to a newly allocated phy_device
2) a NULL pointer, indicating that there is no PHY at that address  
(indicated by the bus returning all Fs)
3) an error (due to bus read failure, or to memory allocation  
failure, as indicated by PTR_ERR(phydev)

This change has several issues:
1) due to the change below, IS_ERR(phydev) is never true
2) If you continue, mdiobus_register() will not inform its caller  
that it failed.

> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/ 
> phy_device.c
> index 7da0e3d..0dffecf 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -46,6 +46,35 @@ static struct phy_driver genphy_driver;
>  extern int mdio_bus_init(void);
>  extern void mdio_bus_exit(void);
>
> +struct phy_device* phy_device_create(struct mii_bus *bus, int  
> addr, int phy_id)
> +{
> +	struct phy_device *dev;
> +	/* We allocate the device, and initialize the
> +	 * default values */
> +	dev = kcalloc(1, sizeof(*dev), GFP_KERNEL);
> +
> +	if (NULL == dev)
> +		return NULL;

Here's the other change which breaks get_phy_device().  Now it  
doesn't return an error when it fails to allocate memory, it returns  
NULL.  Which mdiobus_register doesn't interpret as an error (because  
it isn't.  Not every PHY address has a device on it).

> +
> +	dev->speed = 0;
> +	dev->duplex = -1;
> +	dev->pause = dev->asym_pause = 0;
> +	dev->link = 1;
> +
> +	dev->autoneg = AUTONEG_ENABLE;
> +
> +	dev->addr = addr;
> +	dev->phy_id = phy_id;
> +	dev->bus = bus;
> +
> +	dev->state = PHY_DOWN;
> +
> +	spin_lock_init(&dev->lock);
> +
> +	return dev;
> +}
> +EXPORT_SYMBOL(phy_device_create);

Also, as a side note, I'm not completely convinced you need to go  
through this degree of effort to circumvent the PHY Layer's normal  
operation.  I think it should be possible to make it simpler.  With  
the right implementation, it should even be possible to do really  
"clever" things, like allow users to change the PHY settings with  
ethtool.  However, this code exists and works (I'm assuming), and  
that's good enough for now.  I'll be glad to have this capability  
next time someone asks me to boot linux on a simulator.

Andy Fleming
