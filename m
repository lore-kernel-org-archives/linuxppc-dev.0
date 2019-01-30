Return-Path: <SRS0=D1of=QG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9371FC282D7
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 10:54:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B755620857
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 10:54:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B755620857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43qKx95hsZzDqV8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Jan 2019 21:54:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43qKvX2QG3zDqTN
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jan 2019 21:52:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43qKvW28qXz9s3q;
 Wed, 30 Jan 2019 21:52:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org, akpm@linux-foundation.org,
 x86@kernel.org
Subject: Re: [PATCH V5 3/5] arch/powerpc/mm: Nest MMU workaround for mprotect
 RW upgrade.
In-Reply-To: <20190116085035.29729-4-aneesh.kumar@linux.ibm.com>
References: <20190116085035.29729-1-aneesh.kumar@linux.ibm.com>
 <20190116085035.29729-4-aneesh.kumar@linux.ibm.com>
Date: Wed, 30 Jan 2019 21:52:38 +1100
Message-ID: <87fttaqux5.fsf@concordia.ellerman.id.au>
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
> NestMMU requires us to mark the pte invalid and flush the tlb when we do a
> RW upgrade of pte. We fixed a variant of this in the fault path in commit
> Fixes: bd5050e38aec ("powerpc/mm/radix: Change pte relax sequence to handle nest MMU hang")

You don't want the "Fixes:" there.

>
> Do the same for mprotect upgrades.
>
> Hugetlb is handled in the next patch.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/pgtable.h | 18 ++++++++++++++
>  arch/powerpc/include/asm/book3s/64/radix.h   |  4 ++++
>  arch/powerpc/mm/pgtable-book3s64.c           | 25 ++++++++++++++++++++
>  arch/powerpc/mm/pgtable-radix.c              | 18 ++++++++++++++
>  4 files changed, 65 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index 2e6ada28da64..92eaea164700 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -1314,6 +1314,24 @@ static inline int pud_pfn(pud_t pud)
>  	BUILD_BUG();
>  	return 0;
>  }

Can we get a blank line here?

> +#define __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION
> +pte_t ptep_modify_prot_start(struct vm_area_struct *, unsigned long, pte_t *);
> +void ptep_modify_prot_commit(struct vm_area_struct *, unsigned long,
> +			     pte_t *, pte_t, pte_t);

So these are not inline ...

> +/*
> + * Returns true for a R -> RW upgrade of pte
> + */
> +static inline bool is_pte_rw_upgrade(unsigned long old_val, unsigned long new_val)
> +{
> +	if (!(old_val & _PAGE_READ))
> +		return false;
> +
> +	if ((!(old_val & _PAGE_WRITE)) && (new_val & _PAGE_WRITE))
> +		return true;
> +
> +	return false;
> +}
>  
>  #endif /* __ASSEMBLY__ */
>  #endif /* _ASM_POWERPC_BOOK3S_64_PGTABLE_H_ */
> diff --git a/arch/powerpc/mm/pgtable-book3s64.c b/arch/powerpc/mm/pgtable-book3s64.c
> index f3c31f5e1026..47c742f002ea 100644
> --- a/arch/powerpc/mm/pgtable-book3s64.c
> +++ b/arch/powerpc/mm/pgtable-book3s64.c
> @@ -400,3 +400,28 @@ void arch_report_meminfo(struct seq_file *m)
>  		   atomic_long_read(&direct_pages_count[MMU_PAGE_1G]) << 20);
>  }
>  #endif /* CONFIG_PROC_FS */
> +
> +pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
> +			     pte_t *ptep)
> +{
> +	unsigned long pte_val;
> +
> +	/*
> +	 * Clear the _PAGE_PRESENT so that no hardware parallel update is
> +	 * possible. Also keep the pte_present true so that we don't take
> +	 * wrong fault.
> +	 */
> +	pte_val = pte_update(vma->vm_mm, addr, ptep, _PAGE_PRESENT, _PAGE_INVALID, 0);
> +
> +	return __pte(pte_val);
> +
> +}
> +
> +void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
> +			     pte_t *ptep, pte_t old_pte, pte_t pte)
> +{

Which means we're going to be doing a function call to get to here ...

> +	if (radix_enabled())
> +		return radix__ptep_modify_prot_commit(vma, addr,
> +						      ptep, old_pte, pte);

And then another function call to get to the radix version ...

> +	set_pte_at(vma->vm_mm, addr, ptep, pte);
> +}
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> index 931156069a81..dced3cd241c2 100644
> --- a/arch/powerpc/mm/pgtable-radix.c
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -1063,3 +1063,21 @@ void radix__ptep_set_access_flags(struct vm_area_struct *vma, pte_t *ptep,
>  	}
>  	/* See ptesync comment in radix__set_pte_at */
>  }
> +
> +void radix__ptep_modify_prot_commit(struct vm_area_struct *vma,
> +				    unsigned long addr, pte_t *ptep,
> +				    pte_t old_pte, pte_t pte)
> +{
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	/*
> +	 * To avoid NMMU hang while relaxing access we need to flush the tlb before
> +	 * we set the new value. We need to do this only for radix, because hash
> +	 * translation does flush when updating the linux pte.
> +	 */
> +	if (is_pte_rw_upgrade(pte_val(old_pte), pte_val(pte)) &&
> +	    (atomic_read(&mm->context.copros) > 0))
> +		radix__flush_tlb_page(vma, addr);

To finally get here, where we'll realise that 99.99% of processes don't
use copros and so we have nothing to do except set the PTE.

> +
> +	set_pte_at(mm, addr, ptep, pte);
> +}

So can we just make it all inline in the header? Or do we think it's not
a hot enough path to worry about it?

cheers
