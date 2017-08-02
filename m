Return-Path: <srs0=yth1=7e=c-s.fr=christophe.leroy@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMrN747h4zDsRN
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 21:20:55 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xMrN73c0Qz8sy1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 21:20:55 +1000 (AEST)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xMrN64Cgyz9sPt
 for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2017 21:20:54 +1000 (AEST)
Subject: Re: [PATCH 3/3] powerpc/mm: Mark __init memory no-execute when
 STRICT_KERNEL_RWX=y
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
References: <1500015083-23511-1-git-send-email-mpe@ellerman.id.au>
 <1500015083-23511-3-git-send-email-mpe@ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <2111e0d8-3b77-20a0-aab9-3572467eb0d4@c-s.fr>
Date: Wed, 2 Aug 2017 13:01:36 +0200
MIME-Version: 1.0
In-Reply-To: <1500015083-23511-3-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 14/07/2017 à 08:51, Michael Ellerman a écrit :
> Currently even with STRICT_KERNEL_RWX we leave the __init text marked
> executable after init, which is bad.
> 
> Add a hook to mark it NX (no-execute) before we free it, and implement
> it for radix and hash.
> 
> Note that we use __init_end as the end address, not _einittext,
> because overlaps_kernel_text() uses __init_end, because there are
> additional executable sections other than .init.text between
> __init_begin and __init_end.
> 
> Tested on radix and hash with:
> 
>    0:mon> p $__init_begin
>    *** 400 exception occurred
> 
> Fixes: 1e0fc9d1eb2b ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>   arch/powerpc/include/asm/book3s/64/hash.h    |  1 +
>   arch/powerpc/include/asm/book3s/64/pgtable.h |  7 +++++++
>   arch/powerpc/include/asm/book3s/64/radix.h   |  1 +
>   arch/powerpc/mm/mem.c                        |  1 +
>   arch/powerpc/mm/pgtable-hash64.c             | 12 ++++++++++++
>   arch/powerpc/mm/pgtable-radix.c              |  8 ++++++++
>   arch/powerpc/mm/pgtable_64.c                 |  8 ++++++++
>   7 files changed, 38 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
> index 0ce513f2926f..36fc7bfe9e11 100644
> --- a/arch/powerpc/include/asm/book3s/64/hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/hash.h
> @@ -91,6 +91,7 @@ static inline int hash__pgd_bad(pgd_t pgd)
>   }
>   #ifdef CONFIG_STRICT_KERNEL_RWX
>   extern void hash__mark_rodata_ro(void);
> +extern void hash__mark_initmem_nx(void);
>   #endif
>   
>   extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index c0737c86a362..3d562b210c65 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1192,5 +1192,12 @@ static inline const int pud_pfn(pud_t pud)
>   	BUILD_BUG();
>   	return 0;
>   }
> +
> +#ifdef CONFIG_STRICT_KERNEL_RWX
> +void mark_initmem_nx(void);
> +#else
> +static inline void mark_initmem_nx(void) { }
> +#endif
> +

Why do we want to limit that to CONFIG_STRICT_KERNEL_RWX ?
Only the kernel text is marked X, even without CONFIG_STRICT_KERNEL_RWX 
(at least on PPC32), so I believe we should clear X on init text in any 
case, shouldn't we ?

Christophe

>   #endif /* __ASSEMBLY__ */
>   #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index 487709ff6875..544440b5aff3 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -118,6 +118,7 @@
>   
>   #ifdef CONFIG_STRICT_KERNEL_RWX
>   extern void radix__mark_rodata_ro(void);
> +extern void radix__mark_initmem_nx(void);
>   #endif
>   
>   static inline unsigned long __radix_pte_update(pte_t *ptep, unsigned long clr,
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index 8541f18694a4..46b4e67d2372 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -402,6 +402,7 @@ void __init mem_init(void)
>   void free_initmem(void)
>   {
>   	ppc_md.progress = ppc_printk_progress;
> +	mark_initmem_nx();
>   	free_initmem_default(POISON_FREE_INITMEM);
>   }
>   
> diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
> index 73019c52141f..443a2c66a304 100644
> --- a/arch/powerpc/mm/pgtable-hash64.c
> +++ b/arch/powerpc/mm/pgtable-hash64.c
> @@ -460,4 +460,16 @@ void hash__mark_rodata_ro(void)
>   
>   	WARN_ON(!hash__change_memory_range(start, end, PP_RXXX));
>   }
> +
> +void hash__mark_initmem_nx(void)
> +{
> +	unsigned long start, end, pp;
> +
> +	start = (unsigned long)__init_begin;
> +	end = (unsigned long)__init_end;
> +
> +	pp = htab_convert_pte_flags(pgprot_val(PAGE_KERNEL));
> +
> +	WARN_ON(!hash__change_memory_range(start, end, pp));
> +}
>   #endif
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 336e52ec652c..5cc50d47ce3f 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -162,6 +162,14 @@ void radix__mark_rodata_ro(void)
>   
>   	radix__change_memory_range(start, end, _PAGE_WRITE);
>   }
> +
> +void radix__mark_initmem_nx(void)
> +{
> +	unsigned long start = (unsigned long)__init_begin;
> +	unsigned long end = (unsigned long)__init_end;
> +
> +	radix__change_memory_range(start, end, _PAGE_EXEC);
> +}
>   #endif /* CONFIG_STRICT_KERNEL_RWX */
>   
>   static inline void __meminit print_mapping(unsigned long start,
> diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
> index 5c0b795d656c..0736e94c7615 100644
> --- a/arch/powerpc/mm/pgtable_64.c
> +++ b/arch/powerpc/mm/pgtable_64.c
> @@ -505,4 +505,12 @@ void mark_rodata_ro(void)
>   	else
>   		hash__mark_rodata_ro();
>   }
> +
> +void mark_initmem_nx(void)
> +{
> +	if (radix_enabled())
> +		radix__mark_initmem_nx();
> +	else
> +		hash__mark_initmem_nx();
> +}
>   #endif
> 
