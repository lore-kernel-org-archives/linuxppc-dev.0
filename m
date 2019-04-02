Return-Path: <SRS0=xrHL=SE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6E1C4360F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:33:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45BE2084B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Apr 2019 18:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="OmDVHD4v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45BE2084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44YdB45cp8zDqNy
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Apr 2019 05:33:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="OmDVHD4v"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Yd8R6tZKzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2019 05:31:35 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44Yd8L23g3z9v06L;
 Tue,  2 Apr 2019 20:31:30 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=OmDVHD4v; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id IR75otPhfzYd; Tue,  2 Apr 2019 20:31:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44Yd8L0tvHz9v06J;
 Tue,  2 Apr 2019 20:31:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1554229890; bh=1LUrTw4sLyaINnCUSW02mDy1bgnUHKLXSJagQKnNAlw=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OmDVHD4vktuNlJFJXd3gPzUH7KoaVKFZK2ZZeaz4bstWhTmugkJu/WNaLW2R4/KTj
 qcXv0DaY0Ep2T0rZcAwFNe4DVZddSlKj9mw2+xzbOR/7hav4eb5ysA7KtkK9IYaiTK
 59tSeSys/olncbNPYRICqDKT7R4VbU06EPURdYgo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 276D58B8D2;
 Tue,  2 Apr 2019 20:31:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id ZDDTtOpZ2ykz; Tue,  2 Apr 2019 20:31:30 +0200 (CEST)
Received: from PO15451 (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 356E98B8CD;
 Tue,  2 Apr 2019 20:31:29 +0200 (CEST)
Subject: Re: [RFC PATCH] powerpc/mm: Reduce memory usage for mm_context_t for
 radix
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <20190402143424.7075-1-aneesh.kumar@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <88b8b995-87d3-e264-e0d6-a99c3e8e098b@c-s.fr>
Date: Tue, 2 Apr 2019 20:31:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190402143424.7075-1-aneesh.kumar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



Le 02/04/2019 à 16:34, Aneesh Kumar K.V a écrit :
> Currently, our mm_context_t on book3s64 include all hash specific
> context details like slice mask, subpage protection details. We
> can skip allocating those on radix. This will help us to save
> 8K per mm_context with radix translation.
> 
> With the patch applied we have
> 
> sizeof(mm_context_t)  = 136
> sizeof(struct hash_mm_context)  = 8288
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> NOTE:
> 
> If we want to do this, I am still trying to figure out how best we can do this
> without all the #ifdef and other overhead for 8xx book3e
> 
> 
>   arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
>   arch/powerpc/include/asm/book3s/64/mmu.h      | 48 +++++++++++--------
>   arch/powerpc/include/asm/book3s/64/slice.h    |  6 +--
>   arch/powerpc/kernel/paca.c                    |  9 ++--
>   arch/powerpc/kernel/setup-common.c            |  7 ++-
>   arch/powerpc/mm/hash_utils_64.c               | 10 ++--
>   arch/powerpc/mm/mmu_context_book3s64.c        | 16 ++++++-
>   arch/powerpc/mm/slb.c                         |  2 +-
>   arch/powerpc/mm/slice.c                       | 48 +++++++++----------
>   arch/powerpc/mm/subpage-prot.c                |  8 ++--
>   10 files changed, 91 insertions(+), 65 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index a28a28079edb..d801be977623 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -657,7 +657,7 @@ extern void slb_set_size(u16 size);
>   
>   /* 4 bits per slice and we have one slice per 1TB */
>   #define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
> -#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.slb_addr_limit >> 41)
> +#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.hash_context->slb_addr_limit >> 41)
>   
>   #ifndef __ASSEMBLY__
>   
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index a809bdd77322..07e76e304a3b 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -114,6 +114,33 @@ struct slice_mask {
>   	DECLARE_BITMAP(high_slices, SLICE_NUM_HIGH);
>   };
>   
> +struct hash_mm_context {
> +
> +	u16 user_psize; /* page size index */

Could we keep that in mm_context_t ?

> +
> +#ifdef CONFIG_PPC_MM_SLICES

CONFIG_PPC_MM_SLICES is always selected on book3s64 so this #ifdef is 
useless.

> +	/* SLB page size encodings*/
> +	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
> +	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
> +	unsigned long slb_addr_limit;

Could we keep slb_addr_limit in mm_context_t too ?


> +#ifdef CONFIG_PPC_64K_PAGES
> +	struct slice_mask mask_64k;
> +#endif
> +	struct slice_mask mask_4k;
> +#ifdef CONFIG_HUGETLB_PAGE
> +	struct slice_mask mask_16m;
> +	struct slice_mask mask_16g;
> +#endif
> +#else
> +	u16 sllp; /* SLB page size encoding */

This can get away as CONFIG_PPC_MM_SLICES is always set.

> +#endif
> +
> +#ifdef CONFIG_PPC_SUBPAGE_PROT
> +	struct subpage_prot_table spt;
> +#endif /* CONFIG_PPC_SUBPAGE_PROT */
> +
> +};
> +
>   typedef struct {
>   	union {
>   		/*
> @@ -127,7 +154,6 @@ typedef struct {
>   		mm_context_id_t id;
>   		mm_context_id_t extended_id[TASK_SIZE_USER64/TASK_CONTEXT_SIZE];
>   	};
> -	u16 user_psize;		/* page size index */
>   
>   	/* Number of bits in the mm_cpumask */
>   	atomic_t active_cpus;
> @@ -137,27 +163,9 @@ typedef struct {
>   
>   	/* NPU NMMU context */
>   	struct npu_context *npu_context;
> +	struct hash_mm_context *hash_context;
>   
> -#ifdef CONFIG_PPC_MM_SLICES
> -	 /* SLB page size encodings*/
> -	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
> -	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
> -	unsigned long slb_addr_limit;
> -# ifdef CONFIG_PPC_64K_PAGES
> -	struct slice_mask mask_64k;
> -# endif
> -	struct slice_mask mask_4k;
> -# ifdef CONFIG_HUGETLB_PAGE
> -	struct slice_mask mask_16m;
> -	struct slice_mask mask_16g;
> -# endif
> -#else
> -	u16 sllp;		/* SLB page size encoding */
> -#endif
>   	unsigned long vdso_base;
> -#ifdef CONFIG_PPC_SUBPAGE_PROT
> -	struct subpage_prot_table spt;
> -#endif /* CONFIG_PPC_SUBPAGE_PROT */
>   	/*
>   	 * pagetable fragment support
>   	 */
> diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
> index db0dedab65ee..3ca1bebe258e 100644
> --- a/arch/powerpc/include/asm/book3s/64/slice.h
> +++ b/arch/powerpc/include/asm/book3s/64/slice.h
> @@ -15,11 +15,11 @@
>   
>   #else /* CONFIG_PPC_MM_SLICES */

That never happens since book3s/64 always selects CONFIG_PPC_MM_SLICES

>   
> -#define get_slice_psize(mm, addr)	((mm)->context.user_psize)
> +#define get_slice_psize(mm, addr)	((mm)->context.hash_context->user_psize)
>   #define slice_set_user_psize(mm, psize)		\
>   do {						\
> -	(mm)->context.user_psize = (psize);	\
> -	(mm)->context.sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
> +	(mm)->context.hash_context->user_psize = (psize);	\
> +	(mm)->context.hash_context->sllp = SLB_VSID_USER | mmu_psize_defs[(psize)].sllp; \
>   } while (0)
>   
>   #endif /* CONFIG_PPC_MM_SLICES */
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index e7382abee868..9f1e5d08fa74 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -267,12 +267,13 @@ void copy_mm_to_paca(struct mm_struct *mm)
>   
>   	get_paca()->mm_ctx_id = context->id;
>   #ifdef CONFIG_PPC_MM_SLICES
> -	VM_BUG_ON(!mm->context.slb_addr_limit);
> -	get_paca()->mm_ctx_slb_addr_limit = mm->context.slb_addr_limit;
> +	VM_BUG_ON(!mm->context.hash_context->slb_addr_limit);
> +	get_paca()->mm_ctx_slb_addr_limit = mm->context.hash_context->slb_addr_limit;
>   	memcpy(&get_paca()->mm_ctx_low_slices_psize,
> -	       &context->low_slices_psize, sizeof(context->low_slices_psize));
> +	       &context->hash_context->low_slices_psize,
> +	       sizeof(context->hash_context->low_slices_psize));

I guess we should set helpers to get pointers to low_slices_psize and 
high_slices_psize. That would help doing the change only for book3s/64.

>   	memcpy(&get_paca()->mm_ctx_high_slices_psize,
> -	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
> +	       &context->hash_context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
>   #else /* CONFIG_PPC_MM_SLICES */
>   	get_paca()->mm_ctx_user_psize = context->user_psize;
>   	get_paca()->mm_ctx_sllp = context->sllp;
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 2e5dfb6e0823..40290d3d95b0 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -862,6 +862,7 @@ static void smp_setup_pacas(void)
>   }
>   #endif
>   
> +struct hash_mm_context init_hash_mm_context;

Should it be for CONFIG_PPC64 only ?

>   /*
>    * Called into from start_kernel this initializes memblock, which is used
>    * to manage page allocation until mem_init is called.
> @@ -949,8 +950,10 @@ void __init setup_arch(char **cmdline_p)
>   
>   #ifdef CONFIG_PPC_MM_SLICES
>   #ifdef CONFIG_PPC64
> -	if (!radix_enabled())
> -		init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
> +	if (!radix_enabled()) {
> +		init_mm.context.hash_context = &init_hash_mm_context;
> +		init_mm.context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
> +	}
>   #elif defined(CONFIG_PPC_8xx)
>   	init_mm.context.slb_addr_limit = DEFAULT_MAP_WINDOW;
>   #else
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 0a4f939a8161..df035c3ebb4b 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1147,7 +1147,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
>    */
>   static int subpage_protection(struct mm_struct *mm, unsigned long ea)
>   {
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
>   	u32 spp = 0;
>   	u32 **sbpm, *sbpp;
>   
> @@ -1470,7 +1470,7 @@ static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
>   	int psize = get_slice_psize(mm, ea);
>   
>   	/* We only prefault standard pages for now */
> -	if (unlikely(psize != mm->context.user_psize))
> +	if (unlikely(psize != mm->context.hash_context->user_psize))
>   		return false;
>   
>   	/*
> @@ -1549,7 +1549,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>   
>   	/* Hash it in */
>   #ifdef CONFIG_PPC_64K_PAGES
> -	if (mm->context.user_psize == MMU_PAGE_64K)
> +	if (mm->context.hash_context->user_psize == MMU_PAGE_64K)
>   		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
>   				     update_flags, ssize);
>   	else
> @@ -1562,8 +1562,8 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>   	 */
>   	if (rc == -1)
>   		hash_failure_debug(ea, access, vsid, trap, ssize,
> -				   mm->context.user_psize,
> -				   mm->context.user_psize,
> +				   mm->context.hash_context->user_psize,
> +				   mm->context.hash_context->user_psize,
>   				   pte_val(*ptep));
>   out_exit:
>   	local_irq_restore(flags);
> diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
> index f720c5cc0b5e..6eef5a36b2e9 100644
> --- a/arch/powerpc/mm/mmu_context_book3s64.c
> +++ b/arch/powerpc/mm/mmu_context_book3s64.c
> @@ -63,6 +63,12 @@ static int hash__init_new_context(struct mm_struct *mm)
>   	if (index < 0)
>   		return index;
>   
> +	mm->context.hash_context = kmalloc(sizeof(struct hash_mm_context), GFP_KERNEL);

> +	if (!mm->context.hash_context) {
> +		ida_free(&mmu_context_ida, index);
> +		return -ENOMEM;
> +	}
> +
>   	/*
>   	 * The old code would re-promote on fork, we don't do that when using
>   	 * slices as it could cause problem promoting slices that have been
> @@ -77,8 +83,14 @@ static int hash__init_new_context(struct mm_struct *mm)
>   	 * We should not be calling init_new_context() on init_mm. Hence a
>   	 * check against 0 is OK.
>   	 */
> -	if (mm->context.id == 0)
> +	if (mm->context.id == 0) {
> +		memset(mm->context.hash_context, 0, sizeof(struct hash_mm_context));

can use kzalloc() instead  ?

>   		slice_init_new_context_exec(mm);
> +	} else {
> +		/* This is fork. Copy hash_context details from current->mm */
> +		memcpy(mm->context.hash_context, current->mm->context.hash_context, sizeof(struct hash_mm_context));
> +
> +	}
>   
>   	subpage_prot_init_new_context(mm);
>   
> @@ -118,6 +130,7 @@ static int radix__init_new_context(struct mm_struct *mm)
>   	asm volatile("ptesync;isync" : : : "memory");
>   
>   	mm->context.npu_context = NULL;
> +	mm->context.hash_context = NULL;
>   
>   	return index;
>   }
> @@ -162,6 +175,7 @@ static void destroy_contexts(mm_context_t *ctx)
>   		if (context_id)
>   			ida_free(&mmu_context_ida, context_id);
>   	}
> +	kfree(ctx->hash_context);
>   }
>   
>   static void pmd_frag_destroy(void *pmd_frag)
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 5986df48359b..2b128939e2e7 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -739,7 +739,7 @@ static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
>   	 * consider this as bad access if we take a SLB miss
>   	 * on an address above addr limit.
>   	 */
> -	if (ea >= mm->context.slb_addr_limit)
> +	if (ea >= mm->context.hash_context->slb_addr_limit)
>   		return -EFAULT;
>   
>   	context = get_user_context(&mm->context, ea);
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index aec91dbcdc0b..84b200429464 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -101,7 +101,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
>   {
>   	struct vm_area_struct *vma;
>   
> -	if ((mm->context.slb_addr_limit - len) < addr)
> +	if ((mm->context.hash_context->slb_addr_limit - len) < addr)
>   		return 0;
>   	vma = find_vma(mm, addr);
>   	return (!vma || (addr + len) <= vm_start_gap(vma));
> @@ -155,15 +155,15 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
>   {
>   #ifdef CONFIG_PPC_64K_PAGES
>   	if (psize == MMU_PAGE_64K)
> -		return &mm->context.mask_64k;
> +		return &mm->context.hash_context->mask_64k;

You should take the two patches below, that would help:
https://patchwork.ozlabs.org/patch/1059056/
https://patchwork.ozlabs.org/patch/1059058/


>   #endif
>   	if (psize == MMU_PAGE_4K)
> -		return &mm->context.mask_4k;
> +		return &mm->context.hash_context->mask_4k;
>   #ifdef CONFIG_HUGETLB_PAGE
>   	if (psize == MMU_PAGE_16M)
> -		return &mm->context.mask_16m;
> +		return &mm->context.hash_context->mask_16m;
>   	if (psize == MMU_PAGE_16G)
> -		return &mm->context.mask_16g;
> +		return &mm->context.hash_context->mask_16g;
>   #endif
>   	BUG();
>   }
> @@ -253,7 +253,7 @@ static void slice_convert(struct mm_struct *mm,
>   	 */
>   	spin_lock_irqsave(&slice_convert_lock, flags);
>   
> -	lpsizes = mm->context.low_slices_psize;
> +	lpsizes = mm->context.hash_context->low_slices_psize;

A help to get ->low_slices_psize would help,
something like:

In nohash/32/mmu-8xx:

unsigned char *slice_low_slices_psize(context_t *ctx)
{
	return mm->context.low_slices_psize;
}

And in book3s/64/mmu.h:

unsigned char *slice_low_slices_psize(context_t *ctx)
{
	return mm->context.hash_context->low_slices_psize;
}

And the same for high_slices_psize

Christophe

>   	for (i = 0; i < SLICE_NUM_LOW; i++) {
>   		if (!(mask->low_slices & (1u << i)))
>   			continue;
> @@ -272,8 +272,8 @@ static void slice_convert(struct mm_struct *mm,
>   				(((unsigned long)psize) << (mask_index * 4));
>   	}
>   
> -	hpsizes = mm->context.high_slices_psize;
> -	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
> +	hpsizes = mm->context.hash_context->high_slices_psize;
> +	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.hash_context->slb_addr_limit); i++) {
>   		if (!test_bit(i, mask->high_slices))
>   			continue;
>   
> @@ -292,8 +292,8 @@ static void slice_convert(struct mm_struct *mm,
>   	}
>   
>   	slice_dbg(" lsps=%lx, hsps=%lx\n",
> -		  (unsigned long)mm->context.low_slices_psize,
> -		  (unsigned long)mm->context.high_slices_psize);
> +		  (unsigned long)mm->context.hash_context->low_slices_psize,
> +		  (unsigned long)mm->context.hash_context->high_slices_psize);
>   
>   	spin_unlock_irqrestore(&slice_convert_lock, flags);
>   
> @@ -393,7 +393,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>   	 * DEFAULT_MAP_WINDOW we should apply this.
>   	 */
>   	if (high_limit > DEFAULT_MAP_WINDOW)
> -		addr += mm->context.slb_addr_limit - DEFAULT_MAP_WINDOW;
> +		addr += mm->context.hash_context->slb_addr_limit - DEFAULT_MAP_WINDOW;
>   
>   	while (addr > min_addr) {
>   		info.high_limit = addr;
> @@ -505,20 +505,20 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   			return -ENOMEM;
>   	}
>   
> -	if (high_limit > mm->context.slb_addr_limit) {
> +	if (high_limit > mm->context.hash_context->slb_addr_limit) {
>   		/*
>   		 * Increasing the slb_addr_limit does not require
>   		 * slice mask cache to be recalculated because it should
>   		 * be already initialised beyond the old address limit.
>   		 */
> -		mm->context.slb_addr_limit = high_limit;
> +		mm->context.hash_context->slb_addr_limit = high_limit;
>   
>   		on_each_cpu(slice_flush_segments, mm, 1);
>   	}
>   
>   	/* Sanity checks */
>   	BUG_ON(mm->task_size == 0);
> -	BUG_ON(mm->context.slb_addr_limit == 0);
> +	BUG_ON(mm->context.hash_context->slb_addr_limit == 0);
>   	VM_BUG_ON(radix_enabled());
>   
>   	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
> @@ -696,7 +696,7 @@ unsigned long arch_get_unmapped_area(struct file *filp,
>   				     unsigned long flags)
>   {
>   	return slice_get_unmapped_area(addr, len, flags,
> -				       current->mm->context.user_psize, 0);
> +				       current->mm->context.hash_context->user_psize, 0);
>   }
>   
>   unsigned long arch_get_unmapped_area_topdown(struct file *filp,
> @@ -706,7 +706,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
>   					     const unsigned long flags)
>   {
>   	return slice_get_unmapped_area(addr0, len, flags,
> -				       current->mm->context.user_psize, 1);
> +				       current->mm->context.hash_context->user_psize, 1);
>   }
>   
>   unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
> @@ -717,10 +717,10 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
>   	VM_BUG_ON(radix_enabled());
>   
>   	if (slice_addr_is_low(addr)) {
> -		psizes = mm->context.low_slices_psize;
> +		psizes = mm->context.hash_context->low_slices_psize;
>   		index = GET_LOW_SLICE_INDEX(addr);
>   	} else {
> -		psizes = mm->context.high_slices_psize;
> +		psizes = mm->context.hash_context->high_slices_psize;
>   		index = GET_HIGH_SLICE_INDEX(addr);
>   	}
>   	mask_index = index & 0x1;
> @@ -742,20 +742,20 @@ void slice_init_new_context_exec(struct mm_struct *mm)
>   	 * duplicated.
>   	 */
>   #ifdef CONFIG_PPC64
> -	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
> +	mm->context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
>   #else
>   	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
>   #endif
>   
> -	mm->context.user_psize = psize;
> +	mm->context.hash_context->user_psize = psize;
>   
>   	/*
>   	 * Set all slice psizes to the default.
>   	 */
> -	lpsizes = mm->context.low_slices_psize;
> +	lpsizes = mm->context.hash_context->low_slices_psize;
>   	memset(lpsizes, (psize << 4) | psize, SLICE_NUM_LOW >> 1);
>   
> -	hpsizes = mm->context.high_slices_psize;
> +	hpsizes = mm->context.hash_context->high_slices_psize;
>   	memset(hpsizes, (psize << 4) | psize, SLICE_NUM_HIGH >> 1);
>   
>   	/*
> @@ -777,7 +777,7 @@ void slice_setup_new_exec(void)
>   	if (!is_32bit_task())
>   		return;
>   
> -	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
> +	mm->context.hash_context->slb_addr_limit = DEFAULT_MAP_WINDOW;
>   }
>   #endif
>   
> @@ -816,7 +816,7 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>   			   unsigned long len)
>   {
>   	const struct slice_mask *maskp;
> -	unsigned int psize = mm->context.user_psize;
> +	unsigned int psize = mm->context.hash_context->user_psize;
>   
>   	VM_BUG_ON(radix_enabled());
>   
> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
> index 5e4178790dee..3a13cbcb6f97 100644
> --- a/arch/powerpc/mm/subpage-prot.c
> +++ b/arch/powerpc/mm/subpage-prot.c
> @@ -25,7 +25,7 @@
>    */
>   void subpage_prot_free(struct mm_struct *mm)
>   {
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
>   	unsigned long i, j, addr;
>   	u32 **p;
>   
> @@ -52,7 +52,7 @@ void subpage_prot_free(struct mm_struct *mm)
>   
>   void subpage_prot_init_new_context(struct mm_struct *mm)
>   {
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
>   
>   	memset(spt, 0, sizeof(*spt));
>   }
> @@ -93,7 +93,7 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
>   static void subpage_prot_clear(unsigned long addr, unsigned long len)
>   {
>   	struct mm_struct *mm = current->mm;
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
>   	u32 **spm, *spp;
>   	unsigned long i;
>   	size_t nw;
> @@ -189,7 +189,7 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
>   		unsigned long, len, u32 __user *, map)
>   {
>   	struct mm_struct *mm = current->mm;
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = &mm->context.hash_context->spt;
>   	u32 **spm, *spp;
>   	unsigned long i;
>   	size_t nw;
> 
