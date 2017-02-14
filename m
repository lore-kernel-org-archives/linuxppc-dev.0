Return-Path: <michaele@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vMs2c4pxgzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 16:50:16 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1E5nQUS137770
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 00:50:14 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28kthtb5nv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 00:50:13 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <michaele@au1.ibm.com>;
 Tue, 14 Feb 2017 15:50:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id C0DD22CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 16:50:05 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1E5nvdJ24576056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 16:50:05 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1E5nXRQ016938
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 16:49:33 +1100
From: Michael Ellerman <michaele@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 akpm@linux-foundation.org, Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] mm/autonuma: Let architecture override how the
 write bit should be stashed in a protnone pte.
In-Reply-To: <1487050314-3892-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1487050314-3892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487050314-3892-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Tue, 14 Feb 2017 16:49:04 +1100
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87poilmien.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Autonuma preserves the write permission across numa fault to avoid taking
> a writefault after a numa fault (Commit: b191f9b106ea " mm: numa: preserve PTE
> write permissions across a NUMA hinting fault"). Architecture can implement
> protnone in different ways and some may choose to implement that by clearing Read/
> Write/Exec bit of pte. Setting the write bit on such pte can result in wrong
> behaviour. Fix this up by allowing arch to override how to save the write bit
> on a protnone pte.

This is pretty obviously a nop on arches that don't implement the new
hooks, but it'd still be good to get an ack from someone in mm land
before I merge it.

cheers

> Acked-By: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  include/asm-generic/pgtable.h | 16 ++++++++++++++++
>  mm/huge_memory.c              |  4 ++--
>  mm/memory.c                   |  2 +-
>  mm/mprotect.c                 |  4 ++--
>  4 files changed, 21 insertions(+), 5 deletions(-)
>
> diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
> index 18af2bcefe6a..b6f3a8a4b738 100644
> --- a/include/asm-generic/pgtable.h
> +++ b/include/asm-generic/pgtable.h
> @@ -192,6 +192,22 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm, unsigned long addres
>  }
>  #endif
>  
> +#ifndef pte_savedwrite
> +#define pte_savedwrite pte_write
> +#endif
> +
> +#ifndef pte_mk_savedwrite
> +#define pte_mk_savedwrite pte_mkwrite
> +#endif
> +
> +#ifndef pmd_savedwrite
> +#define pmd_savedwrite pmd_write
> +#endif
> +
> +#ifndef pmd_mk_savedwrite
> +#define pmd_mk_savedwrite pmd_mkwrite
> +#endif
> +
>  #ifndef __HAVE_ARCH_PMDP_SET_WRPROTECT
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 9a6bd6c8d55a..2f0f855ec911 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1300,7 +1300,7 @@ int do_huge_pmd_numa_page(struct vm_fault *vmf, pmd_t pmd)
>  	goto out;
>  clear_pmdnuma:
>  	BUG_ON(!PageLocked(page));
> -	was_writable = pmd_write(pmd);
> +	was_writable = pmd_savedwrite(pmd);
>  	pmd = pmd_modify(pmd, vma->vm_page_prot);
>  	pmd = pmd_mkyoung(pmd);
>  	if (was_writable)
> @@ -1555,7 +1555,7 @@ int change_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  			entry = pmdp_huge_get_and_clear_notify(mm, addr, pmd);
>  			entry = pmd_modify(entry, newprot);
>  			if (preserve_write)
> -				entry = pmd_mkwrite(entry);
> +				entry = pmd_mk_savedwrite(entry);
>  			ret = HPAGE_PMD_NR;
>  			set_pmd_at(mm, addr, pmd, entry);
>  			BUG_ON(vma_is_anonymous(vma) && !preserve_write &&
> diff --git a/mm/memory.c b/mm/memory.c
> index e78bf72f30dd..88c24f89d6d3 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3388,7 +3388,7 @@ static int do_numa_page(struct vm_fault *vmf)
>  	int target_nid;
>  	bool migrated = false;
>  	pte_t pte;
> -	bool was_writable = pte_write(vmf->orig_pte);
> +	bool was_writable = pte_savedwrite(vmf->orig_pte);
>  	int flags = 0;
>  
>  	/*
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index f9c07f54dd62..15f5c174a7c1 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -113,13 +113,13 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
>  			ptent = ptep_modify_prot_start(mm, addr, pte);
>  			ptent = pte_modify(ptent, newprot);
>  			if (preserve_write)
> -				ptent = pte_mkwrite(ptent);
> +				ptent = pte_mk_savedwrite(ptent);
>  
>  			/* Avoid taking write faults for known dirty pages */
>  			if (dirty_accountable && pte_dirty(ptent) &&
>  					(pte_soft_dirty(ptent) ||
>  					 !(vma->vm_flags & VM_SOFTDIRTY))) {
> -				ptent = pte_mkwrite(ptent);
> +				ptent = pte_mk_savedwrite(ptent);
>  			}
>  			ptep_modify_prot_commit(mm, addr, pte, ptent);
>  			pages++;
> -- 
> 2.7.4
