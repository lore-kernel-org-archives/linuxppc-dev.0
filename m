Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id 13820B70DD
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Sep 2010 21:41:58 +1000 (EST)
Received: by eyg24 with SMTP id 24so900186eyg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Sep 2010 04:41:57 -0700 (PDT)
Date: Thu, 9 Sep 2010 15:41:53 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Roy Zang <tie-fei.zang@freescale.com>
Subject: Re: [PATCH v2 3/3][MTD] P4080/mtd: Fix the freescale lbc issue
	with 36bit mode
Message-ID: <20100909114153.GB6622@oksana.dev.rtsoft.ru>
References: <1284027632-32573-1-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-2-git-send-email-tie-fei.zang@freescale.com>
	<1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1284027632-32573-3-git-send-email-tie-fei.zang@freescale.com>
Cc: B07421@freescale.com, dedekind1@gmail.com, B25806@freescale.com,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org, B11780@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 09, 2010 at 06:20:32PM +0800, Roy Zang wrote:
[...]
>  /**
> + * fsl_lbc_addr - convert the base address
> + * @addr_base:	base address of the memory bank
> + *
> + * This function converts a base address of lbc into the right format for the BR
> + * registers. If the SOC has eLBC then it returns 32bit physical address else
> + * it returns 34bit physical address for local bus(Example: MPC8641).
> + */

It returns 34bit physical address encoded in a 32 bit word,
right? Because, IIRC, 'unsigned int' is always 32 bit.

Worth mentioning this fact.

> +unsigned int fsl_lbc_addr(phys_addr_t addr_base)
> +{
> +	void *dev;

struct device_node *np;

> +	int compatible;
> +
> +	dev = fsl_lbc_ctrl_dev->dev->of_node;
> +	compatible = of_device_is_compatible(dev, "fsl,elbc");
> +
> +	if (compatible)
> +		return addr_base & 0xffff8000;
> +	else
> +		return (addr_base & 0x0ffff8000ull)
> +			| ((addr_base & 0x300000000ull) >> 19);
> +}
> +EXPORT_SYMBOL(fsl_lbc_addr);

Almost perfect. I'm not sure if 'unsigned int' is technically
correct return type for this function though. I guess it should
be u32.

Also, the function may be a bit more understandable and shorter:

u32 fsl_lbc_addr(phys_addr_t addr)
{
	struct device_node *np = fsl_lbc_ctrl_dev->dev->of_node;
	u32 addrl = addr & 0xffff8000;

	if (of_device_is_compatible(np, "fsl,elbc"))
		return addrl;

	return addrl | ((addr & 0x300000000ull) >> 19);
}
EXPORT_SYMBOL(fsl_lbc_addr);

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
