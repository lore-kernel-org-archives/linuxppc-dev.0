Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 14D3167D0D
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 09:04:41 +1100 (EST)
In-Reply-To: <20061207173524.GF22989@ld0162-tx32.am.freescale.net>
References: <20061207173524.GF22989@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ED05EA34-EDC3-4215-A77A-3D2A0DFE79F8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/4] powerpc: Add of_register_i2c_devices().
Date: Thu, 7 Dec 2006 16:04:36 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 7, 2006, at 11:35 AM, Scott Wood wrote:

> Add of_register_i2c_devices(), which scans the children of the  
> specified
> I2C adapter node, and registers them with the I2C code.
>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> This patch depends on David Brownell's patchset at
> http://lists.lm-sensors.org/pipermail/i2c/2006-November/000516.html
>
>  arch/powerpc/kernel/prom_parse.c |   37 +++++++++++++++++++++++++++ 
> ++++++++++
>  include/asm-powerpc/prom.h       |    1 +
>  2 files changed, 38 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/ 
> prom_parse.c
> index 346fb7b..0566d32 100644
> --- a/arch/powerpc/kernel/prom_parse.c
> +++ b/arch/powerpc/kernel/prom_parse.c
> @@ -990,3 +990,40 @@ int of_irq_map_one(struct device_node *d
>  	return res;
>  }
>  EXPORT_SYMBOL_GPL(of_irq_map_one);
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
> +		const char *name;
> +		int len;
> +
> +		addr = get_property(node, "reg", &len);
> +		if (!addr || len < sizeof(int) || *addr > 0xffff)
> +			continue;
> +
> +		info.irq = irq_of_parse_and_map(node, 0);
> +		if (info.irq == NO_IRQ)
> +			info.irq = -1;
> +
> +		name = get_property(node, "compatible", NULL);
> +		if (!name)
> +			name = node->name;
> +		if (!name)
> +			continue;
> +
> +		snprintf(info.driver, KOBJ_NAME_LEN, name);
> +		info.bus_num = bus_num;
> +		info.platform_data = NULL;
> +		info.dev_addr = *addr;
> +
> +		i2c_register_board_info(&info, 1);
> +	}
> +}

We have to be careful with bus_num here.  The way you are calling  
this may get us into trouble in the future.  The problem that can  
occur is if you have a I2C mux we may have additional I2C busses  
behind the bus we are on.  We need to make sure we know how we are  
going to describe this situation.


> +#endif /* CONFIG_I2C */
> diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
> index 0afee17..78c6829 100644
> --- a/include/asm-powerpc/prom.h
> +++ b/include/asm-powerpc/prom.h
> @@ -348,6 +348,7 @@ static inline int of_irq_to_resource(str
>  	return irq;
>  }
>
> +void of_register_i2c_devices(struct device_node *adap_node, int  
> bus_num);
>
>  #endif /* __KERNEL__ */
>  #endif /* _POWERPC_PROM_H */
> -- 
> 1.4.2.3
>
>
>
>
>
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
