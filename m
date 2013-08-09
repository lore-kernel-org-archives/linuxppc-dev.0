Return-Path: <anton@scarybugs.org>
Received: from mail-pb0-f50.google.com (mail-pb0-f50.google.com
 [209.85.160.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78E7C2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Aug 2013 10:20:20 +1000 (EST)
Received: by mail-pb0-f50.google.com with SMTP id uo5so4086114pbc.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Aug 2013 17:20:18 -0700 (PDT)
Sender: Anton Vorontsov <anton@scarybugs.org>
Date: Thu, 8 Aug 2013 17:15:40 -0700
From: Anton Vorontsov <anton@enomsg.org>
To: Haijun Zhang <Haijun.Zhang@freescale.com>
Subject: Re: [PATCH 1/3 V2] mmc:core: parse voltage from device-tree
Message-ID: <20130809001540.GB7427@lizard.mcd01528.sjc.wayport.net>
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, cjb@laptop.org,
 linux-mmc@vger.kernel.org, AFLEMING@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 31, 2013 at 02:25:25PM +0800, Haijun Zhang wrote:
> Add function to support get voltage from device-tree.
> If there are voltage-range specified in device-tree node, this function
> will parse it and return the avail voltage mask.
> 
> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
> ---
> changes for v2:
> 	- Update the parameters of function
> 
>  drivers/mmc/core/core.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mmc/core.h |  1 +
>  2 files changed, 47 insertions(+)
> 
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 49a5bca..ce9c957 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -27,6 +27,7 @@
>  #include <linux/fault-inject.h>
>  #include <linux/random.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  
>  #include <linux/mmc/card.h>
>  #include <linux/mmc/host.h>
> @@ -1196,6 +1197,51 @@ u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max)
>  }
>  EXPORT_SYMBOL(mmc_vddrange_to_ocrmask);
>  
> +#ifdef CONFIG_OF
> +
> +/*

This is not kernel-doc formatted comment for the function.. it should
start with /**...

> + * mmc_of_parse_voltage - return mask of supported voltages
> + * @np: The device node need to be parsed.
> + *
> + * 1. Return zero: voltage-ranges unspecified in device-tree.
> + * 2. Return negative errno: voltage-range is invalid.

This doesn't seem right... the function returns the unsigned mask... You
can change the prototype of this func to something like this:

int mmc_of_parse_voltage(struct device_node *np, u32 *mask);

So the function will fill the mask and return 0 on success, and will
return negtive errno on errors.

> + * 3. Return ocr_mask: a mask of voltages that parse from device-tree
> + * node can be provided to MMC/SD/SDIO devices.
> + */
> +

No need for this empty line...

> +u32 mmc_of_parse_voltage(struct device_node *np)
> +{
> +	const u32 *voltage_ranges;
> +	int num_ranges, i;
> +	u32 ocr_mask = 0;
> +
> +	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
> +	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
> +	if (!voltage_ranges || !num_ranges) {
> +		pr_info("%s: voltage-ranges unspecified\n", np->full_name);
> +		return 0;
> +	}
> +
> +	for (i = 0; i < num_ranges; i++) {
> +		const int j = i * 2;
> +		u32 mask;
> +
> +		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
> +				be32_to_cpu(voltage_ranges[j + 1]));

You lost some [pretty] formatting to line up the two arguments. :)

> +		if (!mask) {
> +			pr_err("%s: voltage-range #%d is invalid\n",
> +				np->full_name, i);
> +			return -EINVAL;
> +		}
> +		ocr_mask |= mask;
> +	}
> +
> +	return ocr_mask;
> +}
> +EXPORT_SYMBOL(mmc_of_parse_voltage);
> +
> +#endif /* CONFIG_OF */
> +
>  #ifdef CONFIG_REGULATOR
>  
>  /**
> diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> index 443243b..e3f8fe3 100644
> --- a/include/linux/mmc/core.h
> +++ b/include/linux/mmc/core.h
> @@ -209,5 +209,6 @@ static inline void mmc_claim_host(struct mmc_host *host)
>  }
>  
>  extern u32 mmc_vddrange_to_ocrmask(int vdd_min, int vdd_max);
> +extern u32 mmc_of_parse_voltage(struct device_node *np);

You need to add a 'struct device_node;' forward-declaration, otherwise
non-OF code might fail to compile...

Thanks,

Anton
