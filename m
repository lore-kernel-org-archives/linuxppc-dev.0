Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976AFC282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 10:35:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDBCA218A4
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 10:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDBCA218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qKX94jd0zDqVF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 21:35:53 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qKV36STkzDqT8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 21:34:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qKV265Vdz9s9G;
 Wed, 30 Jan 2019 21:34:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 x86@kernel.org
Subject: Re: [PATCH V5 1/5] mm: Update ptep_modify_prot_start/commit to take
 vm_area_struct as arg
In-Reply-To: <20190116085035.29729-2-aneesh.kumar@linux.ibm.com>
References: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
 <20190116085035.29729-2-aneesh.kumar@linux.ibm.com>
Date: Wed, 30 Jan 2019 21:33:57 +1100
Message-ID: <87lg32qvsa.fsf@concordia.ellerman.id.au>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Some architecture may want to call flush_tlb_range from these helpers.

That's what we want to do, but wouldn't a better description be that
some architectures may need access to the vma for some reason, one of
which might be flushing the TLB.

> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/s390/include/asm/pgtable.h       |  4 ++--
>  arch/s390/mm/pgtable.c                |  6 ++++--
>  arch/x86/include/asm/paravirt.h       | 11 ++++++-----
>  arch/x86/include/asm/paravirt_types.h |  5 +++--
>  arch/x86/xen/mmu.h                    |  4 ++--
>  arch/x86/xen/mmu_pv.c                 |  8 ++++----
>  fs/proc/task_mmu.c                    |  4 ++--
>  include/asm-generic/pgtable.h         | 16 ++++++++--------
>  mm/memory.c                           |  4 ++--
>  mm/mprotect.c                         |  4 ++--
>  10 files changed, 35 insertions(+), 31 deletions(-)
>
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 063732414dfb..5d730199e37b 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1069,8 +1069,8 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  }
>  
>  #define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
> -pte_t ptep_modify_prot_start(struct mm_struct *, unsigned long, pte_t *);
> -void ptep_modify_prot_commit(struct mm_struct *, unsigned long, pte_t *, pte_t);
> +pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, pte_t *);
> +void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long, pte_t *, pte_t);
>  
>  #define __HAVE_ARCH_PTEP_CLEAR_FLUSH
>  static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
> diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
> index f2cc7da473e4..29c0a21cd34a 100644
> --- a/arch/s390/mm/pgtable.c
> +++ b/arch/s390/mm/pgtable.c
> @@ -301,12 +301,13 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL(ptep_xchg_lazy);
>  
> -pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr,
> +pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t *ptep)
>  {
>  	pgste_t pgste;
>  	pte_t old;
>  	int nodat;
> +	struct mm_struct *mm = vma->vm_mm;

If this was my code I'd want the mm as the first variable, to preserve
the Reverse Christmas tree format.

>  	preempt_disable();
>  	pgste = ptep_xchg_start(mm, addr, ptep);
> @@ -320,10 +321,11 @@ pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL(ptep_modify_prot_start);
>  
> -void ptep_modify_prot_commit(struct mm_struct *mm, unsigned long addr,
> +void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
>  			     pte_t *ptep, pte_t pte)
>  {
>  	pgste_t pgste;
> +	struct mm_struct *mm = vma->vm_mm;
  
Ditto.

>  	if (!MACHINE_HAS_NX)
>  		pte_val(pte) &= ~_PAGE_NOEXEC;
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index a97f28d914d5..c5a7f18cce7e 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -422,25 +422,26 @@ static inline pgdval_t pgd_val(pgd_t pgd)
>  }
>  
>  #define  __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
> -static inline pte_t ptep_modify_prot_start(struct mm_struct *mm, unsigned long addr,
> +static inline pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
>  					   pte_t *ptep)
>  {
>  	pteval_t ret;
>  
> -	ret = PVOP_CALL3(pteval_t, mmu.ptep_modify_prot_start, mm, addr, ptep);
> +	ret = PVOP_CALL3(pteval_t, mmu.ptep_modify_prot_start, vma, addr, ptep);
>  
>  	return (pte_t) { .pte = ret };
>  }
>  
> -static inline void ptep_modify_prot_commit(struct mm_struct *mm, unsigned long addr,
> +static inline void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
>  					   pte_t *ptep, pte_t pte)
>  {
> +

Unnecessary blank line here.

>  	if (sizeof(pteval_t) > sizeof(long))
>  		/* 5 arg words */
> -		pv_ops.mmu.ptep_modify_prot_commit(mm, addr, ptep, pte);
> +		pv_ops.mmu.ptep_modify_prot_commit(vma, addr, ptep, pte);
>  	else
>  		PVOP_VCALL4(mmu.ptep_modify_prot_commit,
> -			    mm, addr, ptep, pte.pte);
> +			    vma, addr, ptep, pte.pte);
>  }
>  
>  static inline void set_pte(pte_t *ptep, pte_t pte)

The rest looks good.

cheers
