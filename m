Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4CFB9DE002
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 12:54:53 +1100 (EST)
Subject: Re: [PATCH] powerpc: is_hugepage_only_range() must account for
	both 4kB and 64kB slices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
In-Reply-To: <1231960174.31244.8.camel@norville.austin.ibm.com>
References: <1231960174.31244.8.camel@norville.austin.ibm.com>
Content-Type: text/plain
Date: Thu, 15 Jan 2009 12:54:45 +1100
Message-Id: <1231984485.22571.114.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-01-14 at 13:09 -0600, Dave Kleikamp wrote:
> powerpc: is_hugepage_only_range() must account for both 4kB and 64kB slices
> 
> The subpage_prot syscall fails on second and subsequent calls for a given
> region, because is_hugepage_only_range() is mis-identifying the 4 kB
> slices when the process has a 64 kB page size.
> 
> Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks good. I'll put that in for .29

Cheers,
Ben.

> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index db44e02..ba51948 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -710,9 +710,18 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>  			   unsigned long len)
>  {
>  	struct slice_mask mask, available;
> +	unsigned int psize = mm->context.user_psize;
>  
>  	mask = slice_range_to_mask(addr, len);
> -	available = slice_mask_for_size(mm, mm->context.user_psize);
> +	available = slice_mask_for_size(mm, psize);
> +#ifdef CONFIG_PPC_64K_PAGES
> +	/* We need to account for 4k slices too */
> +	if (psize == MMU_PAGE_64K) {
> +		struct slice_mask compat_mask;
> +		compat_mask = slice_mask_for_size(mm, MMU_PAGE_4K);
> +		or_mask(available, compat_mask);
> +	}
> +#endif
>  
>  #if 0 /* too verbose */
>  	slice_dbg("is_hugepage_only_range(mm=%p, addr=%lx, len=%lx)\n",
> 
