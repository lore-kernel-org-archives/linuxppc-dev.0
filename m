Return-Path: <SRS0=+N6N=S2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A480EC282CE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 10:18:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CC6C20878
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 10:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="hFj68C6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC6C20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44px975sKnzDqVY
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Apr 2019 20:18:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="hFj68C6D"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44px795LbmzDqBd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2019 20:16:35 +1000 (AEST)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44px710sMHz9v11R;
 Wed, 24 Apr 2019 12:16:29 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=hFj68C6D; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id PGnOMQZM3qzZ; Wed, 24 Apr 2019 12:16:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44px706tYPz9v11Q;
 Wed, 24 Apr 2019 12:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1556100989; bh=kQLAoCBRlDg0GilAE3TzQ5Rhf0lUcm0sWlQA3dkfBzo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=hFj68C6DsSeST1e6tPTekMXoDRFzmzs0n4AV41FfrfM1TO124NyRtWaDIOP7DtsJg
 P9V5oXZdrW2Gw4kAj9lQ/Wx2JEYuFFKxRoC8YGQsib0AITULiMR94ZnvRX/AB8iFmn
 FFyTEd8J7tWPLa93OdJLsSQwUrwikkqXK9H5nmvQ=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B1398B902;
 Wed, 24 Apr 2019 12:16:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id G7l9pO-S-6TI; Wed, 24 Apr 2019 12:16:30 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.6])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id CD1688B8FB;
 Wed, 24 Apr 2019 12:16:29 +0200 (CEST)
Subject: Re: [PATCH v3 3/6] powerpc/mm: Add helpers for accessing hash
 translation related variables
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 paulus@samba.org, mpe@ellerman.id.au
References: <20190417130351.3805-1-aneesh.kumar@linux.ibm.com>
 <20190417130351.3805-4-aneesh.kumar@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <134f1c76-e105-5289-1598-531adf4913bf@c-s.fr>
Date: Wed, 24 Apr 2019 12:16:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190417130351.3805-4-aneesh.kumar@linux.ibm.com>
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



Le 17/04/2019 à 15:03, Aneesh Kumar K.V a écrit :
> We want to switch to allocating them runtime only when hash translation is
> enabled. Add helpers so that both book3s and nohash can be adapted to
> upcoming change easily.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>   arch/powerpc/include/asm/book3s/64/mmu-hash.h |  4 +-
>   arch/powerpc/include/asm/book3s/64/mmu.h      | 63 ++++++++++++++++++-
>   arch/powerpc/include/asm/nohash/32/mmu-8xx.h  | 50 +++++++++++++++
>   arch/powerpc/kernel/paca.c                    | 12 ++--
>   arch/powerpc/mm/hash_utils_64.c               | 10 +--
>   arch/powerpc/mm/slb.c                         |  2 +-
>   arch/powerpc/mm/slice.c                       | 49 +++++++--------
>   arch/powerpc/mm/subpage-prot.c                |  8 +--
>   8 files changed, 154 insertions(+), 44 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index a28a28079edb..eb36fbfe4ef5 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -657,8 +657,8 @@ extern void slb_set_size(u16 size);
>   
>   /* 4 bits per slice and we have one slice per 1TB */
>   #define SLICE_ARRAY_SIZE	(H_PGTABLE_RANGE >> 41)
> -#define TASK_SLICE_ARRAY_SZ(x)	((x)->context.slb_addr_limit >> 41)
> -
> +#define LOW_SLICE_ARRAY_SZ	(BITS_PER_LONG / BITS_PER_BYTE)
> +#define TASK_SLICE_ARRAY_SZ(x)	((x)->slb_addr_limit >> 41)
>   #ifndef __ASSEMBLY__
>   
>   #ifdef CONFIG_PPC_SUBPAGE_PROT
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index 484a8ff9b338..28213a36fef7 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -124,7 +124,7 @@ typedef struct {
>   	struct npu_context *npu_context;
>   
>   	 /* SLB page size encodings*/
> -	unsigned char low_slices_psize[BITS_PER_LONG / BITS_PER_BYTE];
> +	unsigned char low_slices_psize[LOW_SLICE_ARRAY_SZ];
>   	unsigned char high_slices_psize[SLICE_ARRAY_SIZE];
>   	unsigned long slb_addr_limit;
>   # ifdef CONFIG_PPC_64K_PAGES
> @@ -159,6 +159,67 @@ typedef struct {
>   #endif
>   } mm_context_t;
>   
> +static inline u16 mm_ctx_user_psize(mm_context_t *ctx)
> +{
> +	return ctx->user_psize;
> +}
> +
> +static inline void mm_ctx_set_user_psize(mm_context_t *ctx, u16 user_psize)
> +{
> +	ctx->user_psize = user_psize;
> +}
> +
> +static inline unsigned char *mm_ctx_low_slices(mm_context_t *ctx)
> +{
> +	return ctx->low_slices_psize;
> +}
> +
> +static inline unsigned char *mm_ctx_high_slices(mm_context_t *ctx)
> +{
> +	return ctx->high_slices_psize;
> +}
> +
> +static inline unsigned long mm_ctx_slb_addr_limit(mm_context_t *ctx)
> +{
> +	return ctx->slb_addr_limit;
> +}
> +
> +static inline void mm_ctx_set_slb_addr_limit(mm_context_t *ctx, unsigned long limit)
> +{
> +	ctx->slb_addr_limit = limit;
> +}
> +
> +#ifdef CONFIG_PPC_64K_PAGES
> +static inline struct slice_mask *mm_ctx_slice_mask_64k(mm_context_t *ctx)
> +{
> +	return &ctx->mask_64k;
> +}
> +#endif
> +
> +static inline struct slice_mask *mm_ctx_slice_mask_4k(mm_context_t *ctx)
> +{
> +	return &ctx->mask_4k;
> +}
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static inline struct slice_mask *mm_ctx_slice_mask_16m(mm_context_t *ctx)
> +{
> +	return &ctx->mask_16m;
> +}
> +
> +static inline struct slice_mask *mm_ctx_slice_mask_16g(mm_context_t *ctx)
> +{
> +	return &ctx->mask_16g;
> +}
> +#endif

I think it would be better to move slice_mask_for_size() into mmu.h 
instead of defining those helpers.

> +
> +#ifdef CONFIG_PPC_SUBPAGE_PROT
> +static inline struct subpage_prot_table *mm_ctx_subpage_prot(mm_context_t *ctx)
> +{
> +	return &ctx->spt;
> +}
> +#endif
> +
>   /*
>    * The current system page and segment sizes
>    */
> diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> index 0a1a3fc54e54..0f4b0b50e5ad 100644
> --- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> +++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
> @@ -167,6 +167,7 @@
>   #ifdef CONFIG_PPC_MM_SLICES
>   #include <asm/nohash/32/slice.h>
>   #define SLICE_ARRAY_SIZE	(1 << (32 - SLICE_LOW_SHIFT - 1))
> +#define LOW_SLICE_ARRAY_SZ	SLICE_ARRAY_SIZE
>   #endif
>   
>   #ifndef __ASSEMBLY__
> @@ -193,6 +194,55 @@ typedef struct {
>   	void *pte_frag;
>   } mm_context_t;
>   
> +#ifdef CONFIG_PPC_MM_SLICES
> +static inline u16 mm_ctx_user_psize(mm_context_t *ctx)
> +{
> +	return ctx->user_psize;
> +}
> +
> +static inline void mm_ctx_set_user_psize(mm_context_t *ctx, u16 user_psize)
> +{
> +	ctx->user_psize = user_psize;
> +}
> +
> +static inline unsigned char *mm_ctx_low_slices(mm_context_t *ctx)
> +{
> +	return ctx->low_slices_psize;
> +}
> +
> +static inline unsigned char *mm_ctx_high_slices(mm_context_t *ctx)
> +{
> +	return ctx->high_slices_psize;
> +}
> +
> +static inline unsigned long mm_ctx_slb_addr_limit(mm_context_t *ctx)
> +{
> +	return ctx->slb_addr_limit;
> +}
> +
> +static inline void mm_ctx_set_slb_addr_limit(mm_context_t *ctx, unsigned long limit)
> +{
> +	ctx->slb_addr_limit = limit;
> +}
> +
> +static inline struct slice_mask *mm_ctx_slice_mask_base(mm_context_t *ctx)
> +{
> +	return &ctx->mask_base_psize;
> +}
> +
> +#ifdef CONFIG_HUGETLB_PAGE
> +static inline struct slice_mask *mm_ctx_slice_mask_512k(mm_context_t *ctx)
> +{
> +	return &ctx->mask_512k;
> +}
> +
> +static inline struct slice_mask *mm_ctx_slice_mask_8m(mm_context_t *ctx)
> +{
> +	return &ctx->mask_8m;
> +}
> +#endif

The 3 helpers above are never used, I think we will never need them.

What would be good is to move slice_mask_for_size() here in mmu-8xx.h

I'll rebase my series on top of yours since Michael has already merged it.

Christophe

> +#endif /* CONFIG_PPC_MM_SLICE */
> +
>   #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
>   #define VIRT_IMMR_BASE (__fix_to_virt(FIX_IMMR_BASE))
>   
> diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
> index e7382abee868..9cc91d03ab62 100644
> --- a/arch/powerpc/kernel/paca.c
> +++ b/arch/powerpc/kernel/paca.c
> @@ -267,12 +267,12 @@ void copy_mm_to_paca(struct mm_struct *mm)
>   
>   	get_paca()->mm_ctx_id = context->id;
>   #ifdef CONFIG_PPC_MM_SLICES
> -	VM_BUG_ON(!mm->context.slb_addr_limit);
> -	get_paca()->mm_ctx_slb_addr_limit = mm->context.slb_addr_limit;
> -	memcpy(&get_paca()->mm_ctx_low_slices_psize,
> -	       &context->low_slices_psize, sizeof(context->low_slices_psize));
> -	memcpy(&get_paca()->mm_ctx_high_slices_psize,
> -	       &context->high_slices_psize, TASK_SLICE_ARRAY_SZ(mm));
> +	VM_BUG_ON(!mm_ctx_slb_addr_limit(context));
> +	get_paca()->mm_ctx_slb_addr_limit = mm_ctx_slb_addr_limit(context);
> +	memcpy(&get_paca()->mm_ctx_low_slices_psize, mm_ctx_low_slices(context),
> +	       LOW_SLICE_ARRAY_SZ);
> +	memcpy(&get_paca()->mm_ctx_high_slices_psize, mm_ctx_high_slices(context),
> +	       TASK_SLICE_ARRAY_SZ(context));
>   #else /* CONFIG_PPC_MM_SLICES */
>   	get_paca()->mm_ctx_user_psize = context->user_psize;
>   	get_paca()->mm_ctx_sllp = context->sllp;
> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
> index 0a4f939a8161..5a2bd132f92e 100644
> --- a/arch/powerpc/mm/hash_utils_64.c
> +++ b/arch/powerpc/mm/hash_utils_64.c
> @@ -1147,7 +1147,7 @@ void demote_segment_4k(struct mm_struct *mm, unsigned long addr)
>    */
>   static int subpage_protection(struct mm_struct *mm, unsigned long ea)
>   {
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
>   	u32 spp = 0;
>   	u32 **sbpm, *sbpp;
>   
> @@ -1470,7 +1470,7 @@ static bool should_hash_preload(struct mm_struct *mm, unsigned long ea)
>   	int psize = get_slice_psize(mm, ea);
>   
>   	/* We only prefault standard pages for now */
> -	if (unlikely(psize != mm->context.user_psize))
> +	if (unlikely(psize != mm_ctx_user_psize(&mm->context)))
>   		return false;
>   
>   	/*
> @@ -1549,7 +1549,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>   
>   	/* Hash it in */
>   #ifdef CONFIG_PPC_64K_PAGES
> -	if (mm->context.user_psize == MMU_PAGE_64K)
> +	if (mm_ctx_user_psize(&mm->context) == MMU_PAGE_64K)
>   		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
>   				     update_flags, ssize);
>   	else
> @@ -1562,8 +1562,8 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>   	 */
>   	if (rc == -1)
>   		hash_failure_debug(ea, access, vsid, trap, ssize,
> -				   mm->context.user_psize,
> -				   mm->context.user_psize,
> +				   mm_ctx_user_psize(&mm->context),
> +				   mm_ctx_user_psize(&mm->context),
>   				   pte_val(*ptep));
>   out_exit:
>   	local_irq_restore(flags);
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 5986df48359b..78c0c0a0e355 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -739,7 +739,7 @@ static long slb_allocate_user(struct mm_struct *mm, unsigned long ea)
>   	 * consider this as bad access if we take a SLB miss
>   	 * on an address above addr limit.
>   	 */
> -	if (ea >= mm->context.slb_addr_limit)
> +	if (ea >= mm_ctx_slb_addr_limit(&mm->context))
>   		return -EFAULT;
>   
>   	context = get_user_context(&mm->context, ea);
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index aec91dbcdc0b..35b278082391 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -101,7 +101,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
>   {
>   	struct vm_area_struct *vma;
>   
> -	if ((mm->context.slb_addr_limit - len) < addr)
> +	if ((mm_ctx_slb_addr_limit(&mm->context) - len) < addr)
>   		return 0;
>   	vma = find_vma(mm, addr);
>   	return (!vma || (addr + len) <= vm_start_gap(vma));
> @@ -155,15 +155,15 @@ static struct slice_mask *slice_mask_for_size(struct mm_struct *mm, int psize)
>   {
>   #ifdef CONFIG_PPC_64K_PAGES
>   	if (psize == MMU_PAGE_64K)
> -		return &mm->context.mask_64k;
> +		return mm_ctx_slice_mask_64k(&mm->context);
>   #endif
>   	if (psize == MMU_PAGE_4K)
> -		return &mm->context.mask_4k;
> +		return mm_ctx_slice_mask_4k(&mm->context);
>   #ifdef CONFIG_HUGETLB_PAGE
>   	if (psize == MMU_PAGE_16M)
> -		return &mm->context.mask_16m;
> +		return mm_ctx_slice_mask_16m(&mm->context);
>   	if (psize == MMU_PAGE_16G)
> -		return &mm->context.mask_16g;
> +		return mm_ctx_slice_mask_16g(&mm->context);
>   #endif
>   	BUG();
>   }
> @@ -253,7 +253,7 @@ static void slice_convert(struct mm_struct *mm,
>   	 */
>   	spin_lock_irqsave(&slice_convert_lock, flags);
>   
> -	lpsizes = mm->context.low_slices_psize;
> +	lpsizes = mm_ctx_low_slices(&mm->context);
>   	for (i = 0; i < SLICE_NUM_LOW; i++) {
>   		if (!(mask->low_slices & (1u << i)))
>   			continue;
> @@ -272,8 +272,8 @@ static void slice_convert(struct mm_struct *mm,
>   				(((unsigned long)psize) << (mask_index * 4));
>   	}
>   
> -	hpsizes = mm->context.high_slices_psize;
> -	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.slb_addr_limit); i++) {
> +	hpsizes = mm_ctx_high_slices(&mm->context);
> +	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm_ctx_slb_addr_limit(&mm->context)); i++) {
>   		if (!test_bit(i, mask->high_slices))
>   			continue;
>   
> @@ -292,8 +292,8 @@ static void slice_convert(struct mm_struct *mm,
>   	}
>   
>   	slice_dbg(" lsps=%lx, hsps=%lx\n",
> -		  (unsigned long)mm->context.low_slices_psize,
> -		  (unsigned long)mm->context.high_slices_psize);
> +		  (unsigned long)mm_ctx_low_slices(&mm->context),
> +		  (unsigned long)mm_ctx_high_slices(&mm->context));
>   
>   	spin_unlock_irqrestore(&slice_convert_lock, flags);
>   
> @@ -393,7 +393,7 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
>   	 * DEFAULT_MAP_WINDOW we should apply this.
>   	 */
>   	if (high_limit > DEFAULT_MAP_WINDOW)
> -		addr += mm->context.slb_addr_limit - DEFAULT_MAP_WINDOW;
> +		addr += mm_ctx_slb_addr_limit(&mm->context) - DEFAULT_MAP_WINDOW;
>   
>   	while (addr > min_addr) {
>   		info.high_limit = addr;
> @@ -505,20 +505,20 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>   			return -ENOMEM;
>   	}
>   
> -	if (high_limit > mm->context.slb_addr_limit) {
> +	if (high_limit > mm_ctx_slb_addr_limit(&mm->context)) {
>   		/*
>   		 * Increasing the slb_addr_limit does not require
>   		 * slice mask cache to be recalculated because it should
>   		 * be already initialised beyond the old address limit.
>   		 */
> -		mm->context.slb_addr_limit = high_limit;
> +		mm_ctx_set_slb_addr_limit(&mm->context, high_limit);
>   
>   		on_each_cpu(slice_flush_segments, mm, 1);
>   	}
>   
>   	/* Sanity checks */
>   	BUG_ON(mm->task_size == 0);
> -	BUG_ON(mm->context.slb_addr_limit == 0);
> +	BUG_ON(mm_ctx_slb_addr_limit(&mm->context) == 0);
>   	VM_BUG_ON(radix_enabled());
>   
>   	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
> @@ -696,7 +696,7 @@ unsigned long arch_get_unmapped_area(struct file *filp,
>   				     unsigned long flags)
>   {
>   	return slice_get_unmapped_area(addr, len, flags,
> -				       current->mm->context.user_psize, 0);
> +				       mm_ctx_user_psize(&current->mm->context), 0);
>   }
>   
>   unsigned long arch_get_unmapped_area_topdown(struct file *filp,
> @@ -706,7 +706,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp,
>   					     const unsigned long flags)
>   {
>   	return slice_get_unmapped_area(addr0, len, flags,
> -				       current->mm->context.user_psize, 1);
> +				       mm_ctx_user_psize(&current->mm->context), 1);
>   }
>   
>   unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
> @@ -717,10 +717,10 @@ unsigned int get_slice_psize(struct mm_struct *mm, unsigned long addr)
>   	VM_BUG_ON(radix_enabled());
>   
>   	if (slice_addr_is_low(addr)) {
> -		psizes = mm->context.low_slices_psize;
> +		psizes = mm_ctx_low_slices(&mm->context);
>   		index = GET_LOW_SLICE_INDEX(addr);
>   	} else {
> -		psizes = mm->context.high_slices_psize;
> +		psizes = mm_ctx_high_slices(&mm->context);
>   		index = GET_HIGH_SLICE_INDEX(addr);
>   	}
>   	mask_index = index & 0x1;
> @@ -742,20 +742,19 @@ void slice_init_new_context_exec(struct mm_struct *mm)
>   	 * duplicated.
>   	 */
>   #ifdef CONFIG_PPC64
> -	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW_USER64;
> +	mm_ctx_set_slb_addr_limit(&mm->context, DEFAULT_MAP_WINDOW_USER64);
>   #else
>   	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
>   #endif
> -
> -	mm->context.user_psize = psize;
> +	mm_ctx_set_user_psize(&mm->context, psize);
>   
>   	/*
>   	 * Set all slice psizes to the default.
>   	 */
> -	lpsizes = mm->context.low_slices_psize;
> +	lpsizes = mm_ctx_low_slices(&mm->context);
>   	memset(lpsizes, (psize << 4) | psize, SLICE_NUM_LOW >> 1);
>   
> -	hpsizes = mm->context.high_slices_psize;
> +	hpsizes = mm_ctx_high_slices(&mm->context);
>   	memset(hpsizes, (psize << 4) | psize, SLICE_NUM_HIGH >> 1);
>   
>   	/*
> @@ -777,7 +776,7 @@ void slice_setup_new_exec(void)
>   	if (!is_32bit_task())
>   		return;
>   
> -	mm->context.slb_addr_limit = DEFAULT_MAP_WINDOW;
> +	mm_ctx_set_slb_addr_limit(&mm->context, DEFAULT_MAP_WINDOW);
>   }
>   #endif
>   
> @@ -816,7 +815,7 @@ int slice_is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
>   			   unsigned long len)
>   {
>   	const struct slice_mask *maskp;
> -	unsigned int psize = mm->context.user_psize;
> +	unsigned int psize = mm_ctx_user_psize(&mm->context);
>   
>   	VM_BUG_ON(radix_enabled());
>   
> diff --git a/arch/powerpc/mm/subpage-prot.c b/arch/powerpc/mm/subpage-prot.c
> index 5e4178790dee..c72252542210 100644
> --- a/arch/powerpc/mm/subpage-prot.c
> +++ b/arch/powerpc/mm/subpage-prot.c
> @@ -25,7 +25,7 @@
>    */
>   void subpage_prot_free(struct mm_struct *mm)
>   {
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
>   	unsigned long i, j, addr;
>   	u32 **p;
>   
> @@ -52,7 +52,7 @@ void subpage_prot_free(struct mm_struct *mm)
>   
>   void subpage_prot_init_new_context(struct mm_struct *mm)
>   {
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
>   
>   	memset(spt, 0, sizeof(*spt));
>   }
> @@ -93,7 +93,7 @@ static void hpte_flush_range(struct mm_struct *mm, unsigned long addr,
>   static void subpage_prot_clear(unsigned long addr, unsigned long len)
>   {
>   	struct mm_struct *mm = current->mm;
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
>   	u32 **spm, *spp;
>   	unsigned long i;
>   	size_t nw;
> @@ -189,7 +189,7 @@ SYSCALL_DEFINE3(subpage_prot, unsigned long, addr,
>   		unsigned long, len, u32 __user *, map)
>   {
>   	struct mm_struct *mm = current->mm;
> -	struct subpage_prot_table *spt = &mm->context.spt;
> +	struct subpage_prot_table *spt = mm_ctx_subpage_prot(&mm->context);
>   	u32 **spm, *spp;
>   	unsigned long i;
>   	size_t nw;
> 
