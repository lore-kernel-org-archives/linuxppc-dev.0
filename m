Return-Path: <SRS0=jb1v=3H=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285DBC33CB1
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jan 2020 11:02:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90DC72468D
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jan 2020 11:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ZejS7K6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90DC72468D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 480FQP6wF4zDqvp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 18 Jan 2020 22:02:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 480FNR4FmNzDqtl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jan 2020 22:01:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=ZejS7K6b; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 480FNQ3hbqz9sP6;
 Sat, 18 Jan 2020 22:01:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1579345271;
 bh=+ulljLUKb6YQwXPEHo6wjTNIvD2BQufBLyDbxBLm/nk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ZejS7K6bqRlR8103U9Yudfz6yhHjDi95+BKMxQYP7P6OQX3errdxmtKNxl9vRuLX1
 lmF9rG/xIrDDcQpE0z5bekpwIapcR0tAR3dU+HOfAqSQg6eGfrRMbzzA6Zb+QpBHKm
 gkuJnS2G47MSiourShu92BIaGFOClEW8DOgx97i1RKAoW3sYxQIYLSVrIRX/TNP6JS
 YLXQmMdIhNTAEJEQmU+KYiH9DCZwIRDY8LdfN5yedg4M0HUFlrxebt9zSRBfLzcSVi
 Es4hhap2p6oWvarpWe9gN4NXRzDkvxJEtjW2YQuoMqy06lNZcWLjqy3Ej6xeiJLhZv
 Z2CxB66OwaTAw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, akpm@linux-foundation.org,
 peterz@infradead.org, will@kernel.org
Subject: Re: [PATCH v4 1/9] powerpc/mmu_gather: Enable RCU_TABLE_FREE even for
 !SMP case
In-Reply-To: <20200116064531.483522-2-aneesh.kumar@linux.ibm.com>
References: <20200116064531.483522-1-aneesh.kumar@linux.ibm.com>
 <20200116064531.483522-2-aneesh.kumar@linux.ibm.com>
Date: Sat, 18 Jan 2020 21:01:14 +1000
Message-ID: <875zh981vp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-arch@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> A follow up patch is going to make sure we correctly invalidate page walk cache
> before we free page table pages. In order to keep things simple enable
> RCU_TABLE_FREE even for !SMP so that we don't have to fixup the !SMP case
> differently in the followup patch
>
> !SMP case is right now broken for radix translation w.r.t page walk cache flush.
> We can get interrupted in between page table free and that would imply we
> have page walk cache entries pointing to tables which got freed already.

For the archives, both our platforms that run on Power9 force SMP on in
Kconfig, so the !SMP case is unlikely to be a problem for anyone in
practice, unless they've hacked their kernel to build it !SMP.

> Cc: <stable@vger.kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig                         | 2 +-
>  arch/powerpc/include/asm/book3s/32/pgalloc.h | 8 --------
>  arch/powerpc/include/asm/book3s/64/pgalloc.h | 2 --
>  arch/powerpc/include/asm/nohash/pgalloc.h    | 8 --------
>  arch/powerpc/mm/book3s64/pgtable.c           | 7 -------
>  5 files changed, 1 insertion(+), 26 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers

> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 1ec34e16ed65..04240205f38c 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -222,7 +222,7 @@ config PPC
>  	select HAVE_HARDLOCKUP_DETECTOR_PERF	if PERF_EVENTS && HAVE_PERF_EVENTS_NMI && !HAVE_HARDLOCKUP_DETECTOR_ARCH
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
> -	select HAVE_RCU_TABLE_FREE		if SMP
> +	select HAVE_RCU_TABLE_FREE
>  	select HAVE_RCU_TABLE_NO_INVALIDATE	if HAVE_RCU_TABLE_FREE
>  	select HAVE_MMU_GATHER_PAGE_SIZE
>  	select HAVE_REGS_AND_STACK_ACCESS_API
> diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> index 998317702630..dc5c039eb28e 100644
> --- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
> @@ -49,7 +49,6 @@ static inline void pgtable_free(void *table, unsigned index_size)
>  
>  #define get_hugepd_cache_index(x)  (x)
>  
> -#ifdef CONFIG_SMP
>  static inline void pgtable_free_tlb(struct mmu_gather *tlb,
>  				    void *table, int shift)
>  {
> @@ -66,13 +65,6 @@ static inline void __tlb_remove_table(void *_table)
>  
>  	pgtable_free(table, shift);
>  }
> -#else
> -static inline void pgtable_free_tlb(struct mmu_gather *tlb,
> -				    void *table, int shift)
> -{
> -	pgtable_free(table, shift);
> -}
> -#endif
>  
>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>  				  unsigned long address)
> diff --git a/arch/powerpc/include/asm/book3s/64/pgalloc.h b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> index f6968c811026..a41e91bd0580 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgalloc.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgalloc.h
> @@ -19,9 +19,7 @@ extern struct vmemmap_backing *vmemmap_list;
>  extern pmd_t *pmd_fragment_alloc(struct mm_struct *, unsigned long);
>  extern void pmd_fragment_free(unsigned long *);
>  extern void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift);
> -#ifdef CONFIG_SMP
>  extern void __tlb_remove_table(void *_table);
> -#endif
>  void pte_frag_destroy(void *pte_frag);
>  
>  static inline pgd_t *radix__pgd_alloc(struct mm_struct *mm)
> diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
> index 332b13b4ecdb..29c43665a753 100644
> --- a/arch/powerpc/include/asm/nohash/pgalloc.h
> +++ b/arch/powerpc/include/asm/nohash/pgalloc.h
> @@ -46,7 +46,6 @@ static inline void pgtable_free(void *table, int shift)
>  
>  #define get_hugepd_cache_index(x)	(x)
>  
> -#ifdef CONFIG_SMP
>  static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
>  {
>  	unsigned long pgf = (unsigned long)table;
> @@ -64,13 +63,6 @@ static inline void __tlb_remove_table(void *_table)
>  	pgtable_free(table, shift);
>  }
>  
> -#else
> -static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int shift)
> -{
> -	pgtable_free(table, shift);
> -}
> -#endif
> -
>  static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t table,
>  				  unsigned long address)
>  {
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s64/pgtable.c
> index 75483b40fcb1..2bf7e1b4fd82 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -378,7 +378,6 @@ static inline void pgtable_free(void *table, int index)
>  	}
>  }
>  
> -#ifdef CONFIG_SMP
>  void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
>  {
>  	unsigned long pgf = (unsigned long)table;
> @@ -395,12 +394,6 @@ void __tlb_remove_table(void *_table)
>  
>  	return pgtable_free(table, index);
>  }
> -#else
> -void pgtable_free_tlb(struct mmu_gather *tlb, void *table, int index)
> -{
> -	return pgtable_free(table, index);
> -}
> -#endif
>  
>  #ifdef CONFIG_PROC_FS
>  atomic_long_t direct_pages_count[MMU_PAGE_COUNT];
> -- 
> 2.24.1
