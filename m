Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 55DD4DE455
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 23:03:28 +1000 (EST)
Message-Id: <1C19524E-8400-4F61-AEB1-19CF20E71098@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080813025726.26033.29519.stgit@trillian.secretlab.ca>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [RFC/PATCH v2] powerpc: add ioremap_early() function for mapping
	IO regions before MMU_init()
Date: Thu, 14 Aug 2008 08:00:48 -0500
References: <20080813025726.26033.29519.stgit@trillian.secretlab.ca>
Cc: miltonm@bga.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 12, 2008, at 10:03 PM, Grant Likely wrote:

> +/**
> + * ioremap_early - Allow large persistant IO regions to be mapped  
> early.
> + * @addr: physical address of region
> + * @size: size of region
> + *
> + * This routine uses setbat() to set up IO ranges before the MMU is
> + * fully configured.
> + *
> + * This routine can be called really early, before MMU_init() is  
> called.  It
> + * is useful for setting up early debug output consoles and  
> frequently
> + * accessed IO regions, like the internally memory mapped registers  
> (IMMR)
> + * in an SoC.  Ranges mapped with this function persist even after  
> MMU_init()
> + * is called and the MMU is turned on 'for real.'
> + *
> + * The region mapped is large (minimum size of 128k) and virtual  
> mapping must
> + * be aligned against this boundary.  Therefore, to avoid  
> fragmentation all
> + * calls to ioremap_early() are best made before any calls to ioremap
> + * for smaller regions.
> + */
> +void __iomem * __init
> +ioremap_early(phys_addr_t addr, unsigned long size)
> +{
> +	unsigned long v, p;
> +	int i;
> +
> +	/* Be loud and annoying if someone calls this too late.
> +	 * No need to crash the kernel though */
> +	WARN_ON(mem_init_done);
> +	if (mem_init_done)
> +		return NULL;
> +
> +	/* Make sure request is sane */
> +	if (size == 0)
> +		return NULL;
> +
> +	/* If the region is already block mapped, then there is nothing
> +	 * to do; just return the mapped address */
> +	v = p_mapped_by_bats(addr);
> +	if (v)
> +		return (void __iomem *)v;
> +
> +	/* Adjust size to reflect aligned region */
> +	p = _ALIGN_DOWN(addr, 128 << 10); /* BATs align on 128k boundaries  
> */
> +	size = ALIGN(addr - p + size, 128 << 10);
> +
> +	/* Allocate the aligned virtual base address.  ALIGN_DOWN is used
> +	 * to ensure no overlaps occur with normal 4k ioremaps. */
> +	v = ioremap_bot = _ALIGN_DOWN(ioremap_bot, 128 << 10) - size;
> +
> +	/* Set up a BAT for this IO region */
> +	i = loadbat(v, p, size, _PAGE_IO);

what happens if we run out of bats?


does this actually build on any non-BAT based ppc32 system?

>
> +	if (i < 0)
> +		return NULL;
> +
> +	return (void __iomem *) (v + (addr - p));
> +}
> +
