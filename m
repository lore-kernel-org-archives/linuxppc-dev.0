Return-Path: <tnt@246tNt.com>
Received: from outmx010.isp.belgacom.be (outmx010.isp.belgacom.be
	[195.238.5.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 96EF5DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 May 2007 00:51:17 +1000 (EST)
Received: from outmx010.isp.belgacom.be (localhost [127.0.0.1])
	by outmx010.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id l4PEpB54002954
	for <linuxppc-embedded@ozlabs.org>; Fri, 25 May 2007 16:51:12 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4656F7D2.8050603@246tNt.com>
Date: Fri, 25 May 2007 16:50:58 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Domen Puncer <domen@coderock.org>
Subject: Re: [RFC 1/3] Re: [PATCH] mpc52xx_psc_spi: fix it for CONFIG_PPC_MERGE
References: <20070516073707.GD9667@nd47.coderock.org>
	<464ABE97.7090603@246tNt.com>
	<20070525084304.GA23149@nd47.coderock.org>
In-Reply-To: <20070525084304.GA23149@nd47.coderock.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Dragos Carp <dragos.carp@toptica.com>, domen.puncer@telargo.com,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

NACK

Not at all what I meant ...

We should not modify port config in any automatic way, just let the boot
loader set it up.
If it known not to do it propertly, then in the platform file
(lite5200b, efika, ...)
adjust port config according to what's really on the board.

    Sylvain



Domen Puncer wrote:
> Hi!
>
> I tried to fix these issues, like suggested.
>
> On 16/05/07 10:19 +0200, Sylvain Munaut wrote:
>   
>>  - Chaning port_config in the driver is just wrong ... you should _not_
>> do that. That should have been setup by the bootloader or at worse in
>> the platform setup code.
>>     
>
> [ trimming spi-devel and dbrownell from cc: ]
>
> Setup gpio->port_config to match PSC's set in device tree.
>
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
>
> ---
>  arch/powerpc/platforms/52xx/mpc52xx_common.c |   64 +++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> Index: work-powerpc.git/arch/powerpc/platforms/52xx/mpc52xx_common.c
> ===================================================================
> --- work-powerpc.git.orig/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ work-powerpc.git/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -75,6 +75,68 @@ mpc52xx_find_ipb_freq(struct device_node
>  }
>  EXPORT_SYMBOL(mpc52xx_find_ipb_freq);
>  
> +void __init
> +mpc52xx_setup_port_config(void)
> +{
> +	struct mpc52xx_gpio __iomem *gpio;
> +	struct device_node *np, *child = NULL;
> +	u32 port_config;
> +
> +	/* Map zones */
> +	gpio = mpc52xx_find_and_map("mpc5200-gpio");
> +	if (!gpio) {
> +		printk(KERN_ERR __FILE__ ": "
> +			"Error while mapping GPIO register for port config. "
> +			"Expect some abnormal behavior\n");
> +		return;
> +	}
> +
> +	/* Set port config */
> +	port_config = in_be32(&gpio->port_config);
> +
> +	np = of_find_node_by_type(NULL, "soc");
> +	if (!np) {
> +		printk(KERN_ERR "%s: %i can't find node with type 'soc'\n",
> +				__func__, __LINE__);
> +		iounmap(gpio);
> +		return;
> +	}
> +
> +	while ((child = of_get_next_child(np, child))) {
> +		if (of_device_is_compatible(child, "mpc5200-psc")) {
> +			int ci = -1;
> +			const int *pci;
> +
> +			pci = of_get_property(child, "cell-index", NULL);
> +			if (pci)
> +				ci = *pci;
> +			if (ci < 0 || ci > 5 || ci == 3 || ci == 4) {
> +				printk(KERN_ALERT "%s: %i psc node '%s' has invalid "
> +						"cell-index: %i\n", __func__, __LINE__,
> +						child->name, ci);
> +				continue;
> +			}
> +
> +			port_config &= ~(0x7 << ci*4);
> +			if (strcmp(child->name, "ac97") == 0)
> +				port_config |= 0x2 << ci*4;	/* AC97 functionality */
> +			else if (strcmp(child->name, "serial") == 0)
> +				port_config |= 0x5 << ci*4;	/* UARTe with CD */
> +			else if (strcmp(child->name, "spi") == 0)
> +				port_config |= 0x7 << ci*4;	/* CODEC with MCLK */
> +			else
> +				printk(KERN_ALERT "%s: %i psc node '%s' not handled\n",
> +						__func__, __LINE__, child->name);
> +		}
> +	}
> +	of_node_put(np);
> +
> +	pr_debug("port_config: old:%x new:%x\n",
> +	         in_be32(&gpio->port_config), port_config);
> +	out_be32(&gpio->port_config, port_config);
> +
> +	iounmap(gpio);
> +}
>  
>  void __init
>  mpc52xx_setup_cpu(void)
> @@ -114,6 +176,8 @@ mpc52xx_setup_cpu(void)
>  unmap_regs:
>  	if (cdm) iounmap(cdm);
>  	if (xlb) iounmap(xlb);
> +
> +	mpc52xx_setup_port_config();
>  }
>  
>  void __init
>
>   
