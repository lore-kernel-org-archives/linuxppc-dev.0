Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tx8Kh0JzczDqZ8
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Jan 2017 17:59:35 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v086xVY4008851
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 8 Jan 2017 01:59:31 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27tuhj7ham-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 08 Jan 2017 01:59:30 -0500
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 7 Jan 2017 23:59:30 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Hugh Dickins <hughd@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] mm: stop leaking PageTables
In-Reply-To: <alpine.LSU.2.11.1701071526090.1130@eggly.anvils>
References: <alpine.LSU.2.11.1701071526090.1130@eggly.anvils>
Date: Sun, 08 Jan 2017 12:29:21 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mvf2kpfa.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hugh Dickins <hughd@google.com> writes:

> 4.10-rc loadtest (even on x86, even without THPCache) fails with
> "fork: Cannot allocate memory" or some such; and /proc/meminfo
> shows PageTables growing.
>
> rc1 removed the freeing of an unused preallocated pagetable after
> do_fault_around() has called map_pages(): which is usually a good
> optimization, so that the followup doesn't have to reallocate one;
> but it's not sufficient to shift the freeing into alloc_set_pte(),
> since there are failure cases (most commonly VM_FAULT_RETRY) which
> never reach finish_fault().
>
> Check and free it at the outer level in do_fault(), then we don't
> need to worry in alloc_set_pte(), and can restore that to how it was
> (I cannot find any reason to pte_free() under lock as it was doing).
>
> And fix a separate pagetable leak, or crash, introduced by the same
> change, that could only show up on some ppc64: why does do_set_pmd()'s
> failure case attempt to withdraw a pagetable when it never deposited
> one, at the same time overwriting (so leaking) the vmf->prealloc_pte?
> Residue of an earlier implementation, perhaps?  Delete it.

That change is part of -mm tree.

https://lkml.kernel.org/r/20161212163428.6780-1-aneesh.kumar@linux.vnet.ibm.com

>
> Fixes: 953c66c2b22a ("mm: THP page cache support for ppc64")
> Signed-off-by: Hugh Dickins <hughd@google.com>


Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>
>  mm/memory.c |   47 ++++++++++++++++++++---------------------------
>  1 file changed, 20 insertions(+), 27 deletions(-)
>
> --- 4.10-rc2/mm/memory.c	2016-12-25 18:40:50.830453384 -0800
> +++ linux/mm/memory.c	2017-01-07 13:34:29.373381551 -0800
> @@ -3008,13 +3008,6 @@ static int do_set_pmd(struct vm_fault *v
>  	ret = 0;
>  	count_vm_event(THP_FILE_MAPPED);
>  out:
> -	/*
> -	 * If we are going to fallback to pte mapping, do a
> -	 * withdraw with pmd lock held.
> -	 */
> -	if (arch_needs_pgtable_deposit() && ret == VM_FAULT_FALLBACK)
> -		vmf->prealloc_pte = pgtable_trans_huge_withdraw(vma->vm_mm,
> -								vmf->pmd);
>  	spin_unlock(vmf->ptl);
>  	return ret;
>  }
> @@ -3055,20 +3048,18 @@ int alloc_set_pte(struct vm_fault *vmf,
>
>  		ret = do_set_pmd(vmf, page);
>  		if (ret != VM_FAULT_FALLBACK)
> -			goto fault_handled;
> +			return ret;
>  	}
>
>  	if (!vmf->pte) {
>  		ret = pte_alloc_one_map(vmf);
>  		if (ret)
> -			goto fault_handled;
> +			return ret;
>  	}
>
>  	/* Re-check under ptl */
> -	if (unlikely(!pte_none(*vmf->pte))) {
> -		ret = VM_FAULT_NOPAGE;
> -		goto fault_handled;
> -	}
> +	if (unlikely(!pte_none(*vmf->pte)))
> +		return VM_FAULT_NOPAGE;
>
>  	flush_icache_page(vma, page);
>  	entry = mk_pte(page, vma->vm_page_prot);
> @@ -3088,15 +3079,8 @@ int alloc_set_pte(struct vm_fault *vmf,
>
>  	/* no need to invalidate: a not-present page won't be cached */
>  	update_mmu_cache(vma, vmf->address, vmf->pte);
> -	ret = 0;
>
> -fault_handled:
> -	/* preallocated pagetable is unused: free it */
> -	if (vmf->prealloc_pte) {
> -		pte_free(vmf->vma->vm_mm, vmf->prealloc_pte);
> -		vmf->prealloc_pte = 0;
> -	}
> -	return ret;
> +	return 0;
>  }
>
>
> @@ -3360,15 +3344,24 @@ static int do_shared_fault(struct vm_fau
>  static int do_fault(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	int ret;
>
>  	/* The VMA was not fully populated on mmap() or missing VM_DONTEXPAND */
>  	if (!vma->vm_ops->fault)
> -		return VM_FAULT_SIGBUS;
> -	if (!(vmf->flags & FAULT_FLAG_WRITE))
> -		return do_read_fault(vmf);
> -	if (!(vma->vm_flags & VM_SHARED))
> -		return do_cow_fault(vmf);
> -	return do_shared_fault(vmf);
> +		ret = VM_FAULT_SIGBUS;
> +	else if (!(vmf->flags & FAULT_FLAG_WRITE))
> +		ret = do_read_fault(vmf);
> +	else if (!(vma->vm_flags & VM_SHARED))
> +		ret = do_cow_fault(vmf);
> +	else
> +		ret = do_shared_fault(vmf);
> +
> +	/* preallocated pagetable is unused: free it */
> +	if (vmf->prealloc_pte) {
> +		pte_free(vma->vm_mm, vmf->prealloc_pte);
> +		vmf->prealloc_pte = 0;
> +	}
> +	return ret;
>  }
>
>  static int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
