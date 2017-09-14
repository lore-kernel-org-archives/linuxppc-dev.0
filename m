Return-Path: <catalin.marinas@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3xtKtC3QkxzDrMd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 00:00:18 +1000 (AEST)
Date: Thu, 14 Sep 2017 15:00:14 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Roy Pledge <roy.pledge@nxp.com>
Cc: leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 mark.rutland@arm.com, arnd@arndb.de, madalin.bucur@nxp.com,
 linux@armlinux.org.uk, oss@buserror.net
Subject: Re: [v4 07/11] soc/fsl/qbman: Rework portal mapping calls for ARM/PPC
Message-ID: <20170914140014.taz7qwphfqm66kw7@localhost>
References: <1503607075-28970-1-git-send-email-roy.pledge@nxp.com>
 <1503607075-28970-8-git-send-email-roy.pledge@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1503607075-28970-8-git-send-email-roy.pledge@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2017 at 04:37:51PM -0400, Roy Pledge wrote:
> diff --git a/drivers/soc/fsl/qbman/bman.c b/drivers/soc/fsl/qbman/bman.c
> index ff8998f..e31c843 100644
> --- a/drivers/soc/fsl/qbman/bman.c
> +++ b/drivers/soc/fsl/qbman/bman.c
> @@ -154,7 +154,7 @@ struct bm_mc {
>  };
>  
>  struct bm_addr {
> -	void __iomem *ce;	/* cache-enabled */
> +	void *ce;		/* cache-enabled */
>  	void __iomem *ci;	/* cache-inhibited */
>  };

You dropped __iomem from ce, which is fine since it is now set via
memremap. However, I haven't seen (at least not in this patch), a change
to bm_ce_in() which still uses __raw_readl().

(it may be worth checking this code with sparse, it may warn about this)

> diff --git a/drivers/soc/fsl/qbman/bman_portal.c b/drivers/soc/fsl/qbman/bman_portal.c
> index 39b39c8..bb03503 100644
> --- a/drivers/soc/fsl/qbman/bman_portal.c
> +++ b/drivers/soc/fsl/qbman/bman_portal.c
> @@ -91,7 +91,6 @@ static int bman_portal_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->of_node;
>  	struct bm_portal_config *pcfg;
>  	struct resource *addr_phys[2];
> -	void __iomem *va;
>  	int irq, cpu;
>  
>  	pcfg = devm_kmalloc(dev, sizeof(*pcfg), GFP_KERNEL);
> @@ -123,23 +122,34 @@ static int bman_portal_probe(struct platform_device *pdev)
>  	}
>  	pcfg->irq = irq;
>  
> -	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
> -	if (!va) {
> -		dev_err(dev, "ioremap::CE failed\n");
> +	/*
> +	 * TODO: Ultimately we would like to use a cacheable/non-shareable
> +	 * (coherent) mapping for the portal on both architectures but that
> +	 * isn't currently available in the kernel.  Because of HW differences
> +	 * PPC needs to be mapped cacheable while ARM SoCs will work with non
> +	 * cacheable mappings
> +	 */

This comment mentions "cacheable/non-shareable (coherent)". Was this
meant for ARM platforms? Because non-shareable is not coherent, nor is
this combination guaranteed to work with different CPUs and
interconnects.

> +#ifdef CONFIG_PPC
> +	/* PPC requires a cacheable/non-coherent mapping of the portal */
> +	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
> +				resource_size(addr_phys[0]), MEMREMAP_WB);
> +#else
> +	/* ARM can use a write combine mapping. */
> +	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
> +				resource_size(addr_phys[0]), MEMREMAP_WC);
> +#endif

Nitpick: you could define something like QBMAN_MAP_ATTR to be different
between PPC and the rest and just keep a single memremap() call.

One may complain that "ce" is no longer "cache enabled" but I'm
personally fine to keep the same name for historical reasons.

> diff --git a/drivers/soc/fsl/qbman/dpaa_sys.h b/drivers/soc/fsl/qbman/dpaa_sys.h
> index 81a9a5e..0a1d573 100644
> --- a/drivers/soc/fsl/qbman/dpaa_sys.h
> +++ b/drivers/soc/fsl/qbman/dpaa_sys.h
> @@ -51,12 +51,12 @@
>  
>  static inline void dpaa_flush(void *p)
>  {
> +	/*
> +	 * Only PPC needs to flush the cache currently - on ARM the mapping
> +	 * is non cacheable
> +	 */
>  #ifdef CONFIG_PPC
>  	flush_dcache_range((unsigned long)p, (unsigned long)p+64);
> -#elif defined(CONFIG_ARM)
> -	__cpuc_flush_dcache_area(p, 64);
> -#elif defined(CONFIG_ARM64)
> -	__flush_dcache_area(p, 64);
>  #endif
>  }

Dropping the private API cache maintenance is fine and the memory is WC
now for ARM (mapping to Normal NonCacheable). However, do you require
any barriers here? Normal NC doesn't guarantee any ordering.

> diff --git a/drivers/soc/fsl/qbman/qman_portal.c b/drivers/soc/fsl/qbman/qman_portal.c
> index cbacdf4..41fe33a 100644
> --- a/drivers/soc/fsl/qbman/qman_portal.c
> +++ b/drivers/soc/fsl/qbman/qman_portal.c
> @@ -224,7 +224,6 @@ static int qman_portal_probe(struct platform_device *pdev)
>  	struct device_node *node = dev->of_node;
>  	struct qm_portal_config *pcfg;
>  	struct resource *addr_phys[2];
> -	void __iomem *va;
>  	int irq, cpu, err;
>  	u32 val;
>  
> @@ -262,23 +261,34 @@ static int qman_portal_probe(struct platform_device *pdev)
>  	}
>  	pcfg->irq = irq;
>  
> -	va = ioremap_prot(addr_phys[0]->start, resource_size(addr_phys[0]), 0);
> -	if (!va) {
> -		dev_err(dev, "ioremap::CE failed\n");
> +	/*
> +	 * TODO: Ultimately we would like to use a cacheable/non-shareable
> +	 * (coherent) mapping for the portal on both architectures but that
> +	 * isn't currently available in the kernel.  Because of HW differences
> +	 * PPC needs to be mapped cacheable while ARM SoCs will work with non
> +	 * cacheable mappings
> +	 */

Same comment as above non non-shareable.

> +#ifdef CONFIG_PPC
> +	/* PPC requires a cacheable mapping of the portal */
> +	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
> +				resource_size(addr_phys[0]), MEMREMAP_WB);
> +#else
> +	/* ARM can use write combine mapping for the cacheable area */
> +	pcfg->addr_virt_ce = memremap(addr_phys[0]->start,
> +				resource_size(addr_phys[0]), MEMREMAP_WT);
> +#endif

Same nitpick: a single memremap() call.

-- 
Catalin
