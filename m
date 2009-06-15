Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 58694B712F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 15 Jun 2009 16:57:15 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8A543DDD1B
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Jun 2009 16:57:14 +1000 (EST)
Subject: Re: [PATCH v3] powerpc: add ioremap_early() for mapping IO regions
	before MMU_init()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20090527185422.15186.46133.stgit@localhost.localdomain>
References: <20090527185422.15186.46133.stgit@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 15 Jun 2009 16:55:02 +1000
Message-Id: <1245048902.19217.47.camel@pasglop>
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-05-27 at 12:55 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> ioremap_early() is useful for things like mapping SoC internally registers
> and early debug output because it allows mappings to devices to be setup
> early in the boot process where they are needed.  It also give a
> performance boost since BAT mapped registers don't get flushed out of
> the TLB.
> 
> Without ioremap_early(), early mappings are set up in an ad-hoc manner
> and they get lost when the MMU is set up.  Drivers then have to perform
> hacky fixups to transition over to new mappings.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

Approach looks sane at first glance.

However, I'm reluctant to but that in until we have all MMU types
covered or we'll have "interesting" surprises. Also, the CPM patch
doesn't actually fix the massive bogon in there :-)

> +	/* Be loud and annoying if someone calls this too late.
> +	 * No need to crash the kernel though */
> +	WARN_ON(mem_init_done);
> +	if (mem_init_done)
> +		return NULL;

Can't we write

	if (WARN_ON(mem_init_done))
		return NULL;

nowadays ?

> +	/* Make sure request is sane */
> +	if (size == 0)
> +		return NULL;
> +
> +	/* If the region is already block mapped, then there is nothing
> +	 * to do; just return the mapped address */
> +	v = p_mapped_by_bats(addr);
> +	if (v)
> +		return (void __iomem *)v;

Should we check the size ?

> +	/* Align region size */
> +	for (bl = 128<<10; bl < (256<<20); bl <<= 1) {
> +		p = _ALIGN_DOWN(addr, bl); /* BATs align on 128k boundaries */
> +		size = ALIGN(addr - p + size, bl);
> +		if (bl >= size)
> +			break;
> +	}
> +
> +	/* Complain loudly if too much is requested */
> +	if (bl >= (256<<20)) {
> +		WARN_ON(1);
> +		return NULL;
> +	}

Do we avoid that running into the linear mapping ?

> +	/* Allocate the aligned virtual base address.  ALIGN_DOWN is used
> +	 * to ensure no overlaps occur with normal 4k ioremaps. */
> +	ioremap_bot = _ALIGN_DOWN(ioremap_bot, bl) - size;
> +
> +	/* Set up a BAT for this IO region */
> +	i = loadbat(ioremap_bot, p, size, PAGE_KERNEL_NCG);
> +	if (i < 0)
> +		return NULL;
> +
> +	return (void __iomem *) (ioremap_bot + (addr - p));
>  }
>  
>  /*
> diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> index 8e3dd5a..2c49148 100644
> --- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
> +++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -146,7 +146,20 @@ static struct of_device_id mpc52xx_cdm_ids[] __initdata = {
>  void __init
>  mpc52xx_map_common_devices(void)
>  {
> +	const struct of_device_id immr_ids[] = {
> +		{ .compatible = "fsl,mpc5200-immr", },
> +		{ .compatible = "fsl,mpc5200b-immr", },
> +		{ .type = "soc", .compatible = "mpc5200", }, /* lite5200 */
> +		{ .type = "builtin", .compatible = "mpc5200", }, /* efika */
> +		{}
> +	};
>  	struct device_node *np;
> +	struct resource res;
> +
> +	/* Pre-map the whole register space using a BAT entry */
> +	np = of_find_matching_node(NULL, immr_ids);
> +	if (np && (of_address_to_resource(np, 0, &res) == 0))
> +		ioremap_early(res.start, res.end - res.start + 1);
>  
>  	/* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
>  	 * possibly from a interrupt context. wdt is only implement
> diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
> index e4b6d66..370723e 100644
> --- a/arch/powerpc/sysdev/cpm_common.c
> +++ b/arch/powerpc/sysdev/cpm_common.c
> @@ -56,7 +56,7 @@ void __init udbg_init_cpm(void)
>  {
>  	if (cpm_udbg_txdesc) {
>  #ifdef CONFIG_CPM2
> -		setbat(1, 0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
> +		setbat(0xf0000000, 0xf0000000, 1024*1024, PAGE_KERNEL_NCG);
>  #endif
>  		udbg_putc = udbg_putc_cpm;
>  	}

That needs to be properly fixed ... maybe using ioremap_early() ? :-)

Also, make the initial call ioremap_early_init() just to make things
clear that one can't just call ioremap(), we are limited to a very
specific thing here.

For 8xx I'm not sure what the right approach is. For 40x, 440 and FSL
BookE we probably want to allow to bolt some TLB entries.

Cheers,
Ben.

Cheers,
Ben.
