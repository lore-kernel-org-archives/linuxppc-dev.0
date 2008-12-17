Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63ED8DDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 08:21:46 +1100 (EST)
Message-Id: <F5CAFB16-FADD-4DB6-B18D-ED3AA02AE992@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20081215054607.5DF5DDDFB7@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 14/16] powerpc/mm: Runtime allocation of mmu context maps
	for nohash CPUs v2
Date: Wed, 17 Dec 2008 15:21:39 -0600
References: <20081215054607.5DF5DDDFB7@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> /*
>  * Initialize the context management stuff.
> @@ -326,13 +344,56 @@ void __init mmu_context_init(void)
> 	init_mm.context.active = NR_CPUS;
>
> 	/*
> +	 *   The MPC8xx has only 16 contexts.  We rotate through them on  
> each
> +	 * task switch.  A better way would be to keep track of tasks that
> +	 * own contexts, and implement an LRU usage.  That way very active
> +	 * tasks don't always have to pay the TLB reload overhead.  The
> +	 * kernel pages are mapped shared, so the kernel can run on behalf
> +	 * of any task that makes a kernel entry.  Shared does not mean they
> +	 * are not protected, just that the ASID comparison is not  
> performed.
> +	 *      -- Dan
> +	 *
> +	 * The IBM4xx has 256 contexts, so we can just rotate through these
> +	 * as a way of "switching" contexts.  If the TID of the TLB is zero,
> +	 * the PID/TID comparison is disabled, so we can use a TID of zero
> +	 * to represent all kernel pages as shared among all contexts.

can expand the comment of change it to say all other nonhash parts  
40x, 4xx, fsl-booke right now have 256 contexts.

>
> +	 * 	-- Dan
> +	 */
> +	if (mmu_has_feature(MMU_FTR_TYPE_8xx)) {
> +		first_context = 0;
> +		last_context = 15;
> +	} else {
> +		first_context = 1;
> +		last_context = 255;
> +	}
