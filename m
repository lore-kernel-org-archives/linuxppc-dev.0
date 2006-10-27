Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nicolas DET <nd@bplan-gmbh.de>
In-Reply-To: <4540EB0E.2090000@bplan-gmbh.de>
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
	<1161866964.27827.2.camel@localhost.localdomain>
	<4540B0A9.6070404@bplan-gmbh.de>
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
	<528646bc0610260909x10c3b242i64387f576e625048@mail.gmail.com>
	<4540EB0E.2090000@bplan-gmbh.de>
Content-Type: text/plain
Date: Fri, 27 Oct 2006 12:49:41 +1000
Message-Id: <1161917381.25682.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: akpm@osdl.org, sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Any reason why this is not static nor __init ? :
> +struct device_node *find_mpc52xx_pic(void)
> +{
> +	struct device_node *dev;
> +	const char *piccompatible_list[] =
> +	{
> +		"mpc5200-interrupt-controller",
> +		"mpc52xx-interrupt-controller",
> +		"mpc52xx-pic",
> +		"mpc5200-pic",
> +		"5200-interrupt-controller",
> +		"52xx-interrupt-controller",
> +		"52xx-pic",
> +		"5200-pic",
> +		NULL
> +	};
> +
> +	/* Look for an MPC52xx interrupt controller */
> +	for_each_node_by_type(dev, "interrupt-controller")
> +	{
> +		const char **piccompatible_entry = piccompatible_list;
> +
> +		for(piccompatible_entry = piccompatible_list; *piccompatible_entry; piccompatible_entry++ )
> +		{
> +			if (device_is_compatible(dev, *piccompatible_entry ))
> +				return dev;
> +		}
> +	}
> +
> +	return NULL;
> +}
> +
> +static int  __init chrp_find_mpc52xx_pic(void)
> +{
> +	if (find_mpc52xx_pic())
> +	{
> +		printk(KERN_INFO "Found MPC52xx Interrupt Controller\n");
> +		ppc_md.get_irq = mpc52xx_get_irq;
> +		mpc52xx_init_irq();
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}

I'm not sure I see any point in splitting in two functions like that
 
>  static void __init chrp_find_8259(void)
>  {
>  	struct device_node *np, *pic = NULL;
> @@ -473,8 +519,11 @@ static void __init chrp_find_8259(void)
>  		break;
>  	}
>  	if (np == NULL)
> -		printk(KERN_WARNING "Cannot find PCI interrupt acknowledge"
> -		       " address, polling\n");
> +	{
> +		printk(KERN_WARNING "Cannot find PCI/i8259 interrupt acknowledge"
> +		       " Fix your tree!\n");
> +		return;
> +	}

Unrelated changes/fix, should probably be in a separate patch.

Cheers,
Ben.
