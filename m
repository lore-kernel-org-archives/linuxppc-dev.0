Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F010CDE5E8
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 08:28:50 +1000 (EST)
Subject: Re: [RFC/PATCH 1/3] powerpc: add ioremap_bat() function for
	setting up BAT translated IO regions.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20080806060223.30717.35175.stgit@trillian.secretlab.ca>
References: <20080806055214.30717.86092.stgit@trillian.secretlab.ca>
	<20080806060223.30717.35175.stgit@trillian.secretlab.ca>
Content-Type: text/plain
Date: Thu, 07 Aug 2008 08:26:25 +1000
Message-Id: <1218061585.24157.246.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, miltonm@bga.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-08-06 at 00:02 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> ioremap_bat() is useful for things like mapping SoC internally memory mapped
> register and early text because it allows mappings to devices to be setup
> early in the boot process where they are needed, and the mappings persist
> after the MMU is configured.
> 
> Without ioremap_bat(), setting up the MMU would cause the early text
> mappings to get lost and mostly likely result in a kernel panic on the next
> attempt at output.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---

First comment, make the name more generic. This facility could be
implemented on processors without BATs using different techniques.

Maybe ioremap_block() or ioremap_early() or something like that.

> diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
> index 066e65c..7b25b57 100644
> --- a/arch/powerpc/kernel/setup_32.c
> +++ b/arch/powerpc/kernel/setup_32.c
> @@ -113,6 +113,15 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
>   */
>  notrace void __init machine_init(unsigned long dt_ptr, unsigned long phys)
>  {
> +	/* Do the bare minimum to start allocting from the IO region so
> +	 * that ioremap_bat() works */
> +#ifdef CONFIG_HIGHMEM
> +	ioremap_base = PKMAP_BASE;
> +#else
> +	ioremap_base = 0xfe000000UL;	/* for now, could be 0xfffff000 */
> +#endif /* CONFIG_HIGHMEM */
> +	ioremap_bot = ioremap_base;
> +

Can't these be statically initialized ? If not, then do a function call
to mm/ please. Something like mm_init_early().

> +	/* BAT mappings must be 128k aligned */
> +	if (addr != _ALIGN_DOWN(addr, 128 << 10))
> +		return NULL;

Mustn't they be naturally aligned on their size ?

Cheers,
Ben.
