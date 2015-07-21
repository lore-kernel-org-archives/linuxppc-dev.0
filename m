Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5467A1A01C8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jul 2015 20:21:30 +1000 (AEST)
In-Reply-To: <1437461926-8908-6-git-send-email-khandual@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org
Subject: Re: [RFC,
 6/8] powerpc/prom: Simplify the logic while fetching SLB size
Message-Id: <20150721102130.37D3B140DF7@ozlabs.org>
Date: Tue, 21 Jul 2015 20:21:30 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-21-07 at 06:58:44 UTC, Anshuman Khandual wrote:
> From: "khandual@linux.vnet.ibm.com" <khandual@linux.vnet.ibm.com>
> 
> This patch just simplifies the existing code logic while fetching
> the SLB size property from the device tree.
> 
> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/prom.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 8b888b1..f6168e2 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -223,14 +223,12 @@ static void __init check_cpu_slb_size(unsigned long node)
>  	const __be32 *slb_size_ptr;
>  
>  	slb_size_ptr = of_get_flat_dt_prop(node, "slb-size", NULL);
> -	if (slb_size_ptr != NULL) {
> -		mmu_slb_size = be32_to_cpup(slb_size_ptr);
> -		return;
> -	}
> -	slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
> -	if (slb_size_ptr != NULL) {
> -		mmu_slb_size = be32_to_cpup(slb_size_ptr);
> +	if (!slb_size_ptr) {
> +		slb_size_ptr = of_get_flat_dt_prop(node, "ibm,slb-size", NULL);
> +		if (!slb_size_ptr)
> +			return;
>  	}
> +	mmu_slb_size = be32_to_cpup(slb_size_ptr);
>  }

It's still ugly. Why not go the whole way:


	p = of_get_flat_dt_prop(node, "slb-size", NULL) ? :
	    of_get_flat_dt_prop(node, "ibm,slb-size", NULL);

	if (p)
		mmu_slb_size = be32_to_cpup(p);


And while you're at it, rename the function, it doesn't check anything. It
initialises mmu_slb_size, so call it init_mmu_slb_size()?

cheers
