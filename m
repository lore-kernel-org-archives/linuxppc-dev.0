Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDXQ80qyxzDvLb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 03:56:30 +1100 (AEDT)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Yangbo Lu <yangbo.lu@nxp.com>,
 Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 7/7] soc: renesas: Identify SoC and register with the
 SoC bus
Date: Wed, 09 Nov 2016 17:55:28 +0100
Message-ID: <3693445.TSdZGaiT9S@wuerfel>
In-Reply-To: <1477913455-5314-8-git-send-email-geert+renesas@glider.be>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <1477913455-5314-8-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, October 31, 2016 12:30:55 PM CET Geert Uytterhoeven wrote:

> v2:
>   - Drop SoC families and family names; use fixed "Renesas" instead,

I think I'd rather have seen the family names left in there, but it's
not important, so up to you.

>   - Use "renesas,prr" and "renesas,cccr" device nodes in DT if
>     available, else fall back to hardcoded addresses for compatibility
>     with existing DTBs,

I only see patches 2, 3, 5, and 7 in my inbox, so I'm lacking the DT
binding for these, among other things.

It does seem wrong to have a device node for a specific register though.
Shouldn't the node be for the block of registers that these are inside
of?

>   - Don't register the SoC bus if the chip ID register is missing,

Why? My objection was to hardcoding the register, not to registering
the device? I think I'd rather see the device registered with an
empty revision string.

> +#define CCCR   0xe600101c      /* Common Chip Code Register */
> +#define PRR    0xff000044      /* Product Register */
> +#define PRR3   0xfff00044      /* Product Register on R-Car Gen3 */
> +
> +static const struct of_device_id renesas_socs[] __initconst = {
> +#ifdef CONFIG_ARCH_R8A73A4
> +       { .compatible = "renesas,r8a73a4",      .data = (void *)PRR, },
> +#endif
> +#ifdef CONFIG_ARCH_R8A7740
> +       { .compatible = "renesas,r8a7740",      .data = (void *)CCCR, },
> +#endif

My preference here would be to list the register address only for
SoCs that are known to need them, while also having .dtb files that
don't have the nodes.

> +static int __init renesas_soc_init(void)
> +{
> +       struct soc_device_attribute *soc_dev_attr;
> +       const struct of_device_id *match;
> +       void __iomem *chipid = NULL;
> +       struct soc_device *soc_dev;
> +       struct device_node *np;
> +       unsigned int product;
> +
> +       np = of_find_matching_node_and_match(NULL, renesas_socs, &match);
> +       if (!np)
> +               return -ENODEV;
> +
> +       of_node_put(np);
> +
> +       /* Try PRR first, then CCCR, then hardcoded fallback */
> +       np = of_find_compatible_node(NULL, NULL, "renesas,prr");
> +       if (!np)
> +               np = of_find_compatible_node(NULL, NULL, "renesas,cccr");
> +       if (np) {
> +               chipid = of_iomap(np, 0);
> +               of_node_put(np);
> +       } else if (match->data) {
> +               chipid = ioremap((uintptr_t)match->data, 4);
> +       }
> +       if (!chipid)
> 

Here, I'd turn the order around and look for the DT nodes of the
devices first. Only if they are not found, look at the compatible
string of the root node. No need to search for a node though,
you know which one it is when you look for a compatible =
"renesas,r8a73a4".

	Arnd
