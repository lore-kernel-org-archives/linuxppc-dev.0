Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x229.google.com (mail-pg0-x229.google.com
 [IPv6:2607:f8b0:400e:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwfPG0qYQzDr2f
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 01:32:17 +1100 (AEDT)
Received: by mail-pg0-x229.google.com with SMTP id y8so8319635pgr.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 06:32:17 -0800 (PST)
Date: Wed, 7 Mar 2018 00:32:03 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>, Christophe Leroy
 <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 02/10] powerpc/mm/slice: Simplify and optimise slice
 context initialisation
Message-ID: <20180307003203.055b2d87@roar.ozlabs.ibm.com>
In-Reply-To: <20180306132507.10649-3-npiggin@gmail.com>
References: <20180306132507.10649-1-npiggin@gmail.com>
 <20180306132507.10649-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  6 Mar 2018 23:24:59 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index 929d9ef7083f..80acad52b006 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -93,13 +93,6 @@ static int hash__init_new_context(struct mm_struct *mm)
>  	if (index < 0)
>  		return index;
>  
> -	/*
> -	 * In the case of exec, use the default limit,
> -	 * otherwise inherit it from the mm we are duplicating.
> -	 */
> -	if (!mm->context.slb_addr_limit)
> -		mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;

[...]

> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
> index d98f7e5c141b..be8f5c9d4d08 100644
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -332,9 +332,6 @@ int init_new_context(struct task_struct *t, struct mm_struct *mm)
>  	pr_hard("initing context for mm @%p\n", mm);
>  
>  #ifdef	CONFIG_PPC_MM_SLICES
> -	if (!mm->context.slb_addr_limit)
> -		mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
> -

[...]

> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 5e9e1e57d580..af4351b15d01 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -671,70 +671,29 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
>  }
>  EXPORT_SYMBOL_GPL(get_slice_psize);
>  
> -/*
> - * This is called by hash_page when it needs to do a lazy conversion of
> - * an address space from real 64K pages to combo 4K pages (typically
> - * when hitting a non cacheable mapping on a processor or hypervisor
> - * that won't allow them for 64K pages).
> - *
> - * This is also called in init_new_context() to change back the user
> - * psize from whatever the parent context had it set to
> - * N.B. This may be called before mm->context.id has been set.
> - *
> - * This function will only change the content of the {low,high)_slice_psize
> - * masks, it will not flush SLBs as this shall be handled lazily by the
> - * caller.
> - */
> -void slice_set_user_psize(struct mm_struct *mm, unsigned int psize)
> +void slice_init_new_context_exec(struct mm_struct *mm)
>  {
> -	int index, mask_index;
>  	unsigned char *hpsizes, *lpsizes;
> -	unsigned long flags;
> -	unsigned int old_psize;
> -	int i;
> -
> -	slice_dbg("slice_set_user_psize(mm=%p, psize=%d)\n", mm, psize);
> -
> -	VM_BUG_ON(radix_enabled());
> -	spin_lock_irqsave(&slice_convert_lock, flags);
> +	unsigned int psize = mmu_virtual_psize;
>  
> -	old_psize = mm->context.user_psize;
> -	slice_dbg(" old_psize=%d\n", old_psize);
> -	if (old_psize == psize)
> -		goto bail;
> +	slice_dbg("slice_init_new_context_exec(mm=%p)\n", mm);
>  
> +	/*
> +	 * In the case of exec, use the default limit. In the
> +	 * case of fork it is just inherited from the mm being
> +	 * duplicated.
> +	 */
> +	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;

Okay this looks wrong for 8xx now I just noticed. But... isn't existing
code wrong for 32-bit tasks on BOOK3S_64? It should be DEFAULT_MAP_WINDOW
here I think?

Thanks,
Nick
