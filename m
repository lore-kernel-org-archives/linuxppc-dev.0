Return-Path: <akpm@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E483ADDE0D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 11:29:45 +1100 (EST)
Date: Thu, 17 Jan 2008 16:29:13 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Matt Mackall <mpm@selenic.com>
Subject: Re: 2.6.24-rc8-mm1: powerpc oopses
Message-Id: <20080117162913.0323c517.akpm@linux-foundation.org>
In-Reply-To: <1200615168.3839.26.camel@cinder.waste.org>
References: <20080117023514.9df393cf.akpm@linux-foundation.org>
	<200801172315.28129.m.kozlowski@tuxland.pl>
	<20080117145105.ad968ea6.akpm@linux-foundation.org>
	<1200613194.3839.22.camel@cinder.waste.org>
	<20080117160513.3456b4eb.akpm@linux-foundation.org>
	<1200615168.3839.26.camel@cinder.waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, m.kozlowski@tuxland.pl, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 17 Jan 2008 18:12:48 -0600
Matt Mackall <mpm@selenic.com> wrote:

> 
> > Do we need the ifdef?  pte_offset_map/pte_unmap should be super-cheap on
> > !CONFIG_HIGHPTE builds.
> 
> In that case, pte_unmap is free, pte_offset_map is just a bit of math.
> So yeah, we can simplify this. How about:
> 
> diff -r 5595adaea70f fs/proc/task_mmu.c
> --- a/fs/proc/task_mmu.c	Thu Jan 17 13:26:54 2008 -0600
> +++ b/fs/proc/task_mmu.c	Thu Jan 17 18:11:13 2008 -0600
> @@ -582,20 +583,20 @@
>  {
>  	struct pagemapread *pm = private;
>  	pte_t *pte;
> -	int err = 0;
> +	int offset = 0, err = 0;
>  
> -	pte = pte_offset_map(pmd, addr);
> -	for (; addr != end; pte++, addr += PAGE_SIZE) {
> +	for (; addr != end; offset++, addr += PAGE_SIZE) {
>  		u64 pfn = PM_NOT_PRESENT;
> -		if (is_swap_pte(*pte))
> -			pfn = swap_pte_to_pagemap_entry(*pte);
> -		else if (pte_present(*pte))
> -			pfn = pte_pfn(*pte);
> +		pte = pte_offset_map(pmd, addr);
> +		if (is_swap_pte(pte[offset]))
> +			pfn = swap_pte_to_pagemap_entry(pte[offset]);
> +		else if (pte_present(pte[offset]))
> +			pfn = pte_pfn(pte[offset]);
> +		pte_unmap(pte);
>  		err = add_to_pagemap(addr, pfn, pm);
>  		if (err)
>  			return err;
>  	}
> -	pte_unmap(pte - 1);
>  
>  	cond_resched();
> 

Do we need `offset' at all?

You have

static int pagemap_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
			     void *private)
{
	struct pagemapread *pm = private;
	pte_t *pte;
	int offset = 0, err = 0;

	for (; addr != end; offset++, addr += PAGE_SIZE) {
		u64 pfn = PM_NOT_PRESENT;
		pte = pte_offset_map(pmd, addr);
		if (is_swap_pte(pte[offset]))
			pfn = swap_pte_to_pagemap_entry(pte[offset]);
		else if (pte_present(pte[offset]))
			pfn = pte_pfn(pte[offset]);
		pte_unmap(pte);
		err = add_to_pagemap(addr, pfn, pm);
		if (err)
			return err;
	}

	cond_resched();

	return err;
}

but I think we just do s/pte[offset]/*pte/.  The virtual address should be
the only thing we need to increment as we walk across the addresses here?
