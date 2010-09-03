Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ew0-f42.google.com (mail-ew0-f42.google.com
	[209.85.215.42]) by ozlabs.org (Postfix) with ESMTP id 8748DB718D
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Sep 2010 21:36:09 +1000 (EST)
Received: by ewy2 with SMTP id 2so1176183ewy.15
	for <linuxppc-dev@ozlabs.org>; Fri, 03 Sep 2010 04:36:07 -0700 (PDT)
Date: Fri, 3 Sep 2010 15:36:04 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH 3/3][MTD] P4080/nand: Fix the freescale lbc issue with
	36bit mode
Message-ID: <20100903113604.GB11847@oksana.dev.rtsoft.ru>
References: <1281063096-26598-1-git-send-email-tie-fei.zang@freescale.com>
	<1281063096-26598-2-git-send-email-tie-fei.zang@freescale.com>
	<1281063096-26598-3-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1281063096-26598-3-git-send-email-tie-fei.zang@freescale.com>
Cc: B25806@freescale.com, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-mtd@lists.infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 06, 2010 at 10:51:36AM +0800, Roy Zang wrote:
[...]
>  /**
> + * convert_lbc_address - convert the base address
> + * @addr_base:	base address of the memory bank
> + *
> + * This function converts a base address of lbc into the right format for the BR
> + * registers. If the SOC has eLBC then it returns 32bit physical address else
> + * it returns 34bit physical address for local bus(Example: MPC8641).
> + */
> +unsigned int convert_lbc_address(phys_addr_t addr_base)
> +{
> +	void *dev;
> +	int compatible;
> +
> +	dev = of_find_node_by_name(NULL, "localbus");

Nope, you shouldn't do this. Never search by name.

Also, aren't there already a global dev, which was found by the
_probe() stuff?

> +	if (!dev) {
> +		printk(KERN_INFO "fsl-lbc: can't find localbus node\n");
> +		of_node_put(dev);
> +		return 0;
> +	}
> +
> +	compatible = of_device_is_compatible(dev, "fsl,elbc");
> +	of_node_put(dev);
> +	if (compatible)
> +		return addr_base & 0xffff8000;
> +	else
> +		return (addr_base & 0x0ffff8000ull) \
> +			| ((addr_base & 0x300000000ull) >> 19);
> +}
> +EXPORT_SYMBOL(convert_lbc_address);
> +
> +/**
>   * fsl_lbc_find - find Localbus bank
>   * @addr_base:	base address of the memory bank
>   *
> @@ -50,7 +80,8 @@ int fsl_lbc_find(phys_addr_t addr_base)
>  		__be32 br = in_be32(&fsl_lbc_ctrl_dev->regs->bank[i].br);
>  		__be32 or = in_be32(&fsl_lbc_ctrl_dev->regs->bank[i].or);
>  
> -		if (br & BR_V && (br & or & BR_BA) == addr_base)
> +		if (br & BR_V && (br & or & BR_BA) \

No need for "\" at the end of the line, keep == on the same line.

> +				== convert_lbc_address(addr_base))

Would be prettier if you name it fsl_lbc_addr(). Keeps prefix
the same for the rest of the file, plus makes it shorter (so
there probably won't be any need for breaking the line).

>  			return i;
>  	}
>  
> diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
> index 7bbcb3f..0e8dc40 100644
> --- a/drivers/mtd/nand/fsl_elbc_nand.c
> +++ b/drivers/mtd/nand/fsl_elbc_nand.c
> @@ -838,7 +838,7 @@ static int __devinit fsl_elbc_nand_probe(struct of_device *dev,
>  		    (in_be32(&lbc->bank[bank].br) & BR_MSEL) == BR_MS_FCM &&
>  		    (in_be32(&lbc->bank[bank].br) &
>  		     in_be32(&lbc->bank[bank].or) & BR_BA)
> -		     == res.start)
> +		     == convert_lbc_address(res.start))
>  			break;
>  
>  	if (bank >= MAX_BANKS) {
> -- 
> 1.5.6.5

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
