Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C18ADDF7C
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Jul 2007 09:36:47 +1000 (EST)
In-Reply-To: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E6C54DC8-3152-4EE6-A1A1-389B41B23FC9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
Date: Sun, 1 Jul 2007 18:36:55 -0500
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 29, 2007, at 2:20 PM, Guennadi Liakhovetski wrote:

> Add of_register_i2c_devices(), which scans the children of the  
> specified
> I2C adapter node, and registers them with the I2C code.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

I'm still against this patch since it means we are stating that I2C  
devices in the device tree must us the linux driver names.  The two  
should be de-coupled.

- k

>
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/ 
> prom_parse.c
> index 3786dcc..9caf96d 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -1067,3 +1067,49 @@ void __iomem *of_iomap(struct device_node  
> *np, int index)
>  	return ioremap(res.start, 1 + res.end - res.start);
>  }
>  EXPORT_SYMBOL(of_iomap);
> +
> +#ifdef CONFIG_I2C
> +#include <linux/i2c.h>
> +
> +void of_register_i2c_devices(struct device_node *adap_node, int  
> bus_num)
> +{
> +	struct device_node *node = NULL;
> +
> +	while ((node = of_get_next_child(adap_node, node))) {
> +		struct i2c_board_info info;
> +		const u32 *addr;
> +		const char *name, *model;
> +		int len;
> +
> +		addr = of_get_property(node, "reg", &len);
> +		if (!addr || len < sizeof(int) || *addr > 0xffff)
> +			continue;
> +
> +		info.irq = irq_of_parse_and_map(node, 0);
> +		if (info.irq == NO_IRQ)
> +			info.irq = -1;
> +
> +		name = of_get_property(node, "compatible", NULL);
> +		if (!name)
> +			name = node->name;
> +		if (!name)
> +			continue;
> +
> +		model = of_get_property(node, "model", NULL);
> +		if (!model)
> +			model = name;
> +
> +		/* FIXME: the i2c code should allow drivers to specify
> +		 * multiple match names; board code shouldn't need to
> +		 * know what driver will handle a given type.
> +		 */
> +
> +		snprintf(info.driver_name, KOBJ_NAME_LEN, name);
> +		snprintf(info.type, KOBJ_NAME_LEN, model);
> +		info.platform_data = NULL;
> +		info.addr = *addr;
> +
> +		i2c_register_board_info(bus_num, &info, 1);
> +	}
> +}
> +#endif /* CONFIG_I2C */
> diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
> index 6845af9..ed085e1 100644
> --- a/include/asm-powerpc/prom.h
> +++ b/include/asm-powerpc/prom.h
> @@ -305,6 +305,7 @@ extern int of_irq_map_raw(struct device_node  
> *parent, const u32 *intspec,
>  			  u32 ointsize, const u32 *addr,
>  			  struct of_irq *out_irq);
>
> +void of_register_i2c_devices(struct device_node *adap_node, int  
> bus_num);
>
>  /**
>   * of_irq_map_one - Resolve an interrupt for a device
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
