Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6b9F2ndszDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 16:40:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Fix protection of kernel RAM after freeing
 unused memory
In-Reply-To: <20170414131126.AA07A67422@localhost.localdomain>
References: <20170414131126.AA07A67422@localhost.localdomain>
Date: Tue, 18 Apr 2017 16:40:17 +1000
Message-ID: <87mvbe6wxa.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 9ee536ec0739..e95931c4e6cf 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -401,6 +401,9 @@ void free_initmem(void)
>  {
>  	ppc_md.progress = ppc_printk_progress;
>  	free_initmem_default(POISON_FREE_INITMEM);
> +#ifdef CONFIG_PPC32
> +	remap_init_ram();
> +#endif
>  }

Please don't put ifdefs straight in C code like that unless you have to.
In this case it's easy to put an empty version in a header, eg:

> diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
> index f988db655e5b..d39d92600839 100644
> --- a/arch/powerpc/mm/mmu_decl.h
> +++ b/arch/powerpc/mm/mmu_decl.h
> @@ -95,6 +95,7 @@ extern void _tlbia(void);
>  
>  extern void mapin_ram(void);
>  extern int map_page(unsigned long va, phys_addr_t pa, int flags);

  +#ifdef CONFIG_PPC32
> +void remap_init_ram(void);
  +#else
  +static inline void remap_init_ram(void) { }
  +#endif

> diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
> index a65c0b4c0669..d506bd61b629 100644
> --- a/arch/powerpc/mm/pgtable_32.c
> +++ b/arch/powerpc/mm/pgtable_32.c
> @@ -323,6 +323,26 @@ get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t **ptep, pmd_t **pmdp)
>          return(retval);
>  }
>  
> +void remap_init_ram(void)
> +{
> +	unsigned long start = (unsigned long)_sinittext & PAGE_MASK;
> +	unsigned long end = (unsigned long)_einittext;
> +	unsigned long va;
> +
> +	for (va = start; va < end; va += PAGE_SIZE) {
> +		pte_t *kpte;
> +		pmd_t *kpmd;
> +		pte_t pte = pfn_pte(__pa(va) >> PAGE_SHIFT, PAGE_KERNEL);
> +
> +		if (!get_pteptr(&init_mm, va, &kpte, &kpmd))
> +			continue;
> +		__set_pte_at(&init_mm, va, kpte, pte, 0);
> +		wmb();
> +		pte_unmap(kpte);
> +	}
> +	flush_tlb_kernel_range(start, end);
> +}

Can we just use unmap_kernel_range() ?

Is this sufficient on all 32-bit PPC? (I have no idea)

cheers
