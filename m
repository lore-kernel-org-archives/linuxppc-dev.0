Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZz2T24flzDqJ6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 15:59:28 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAD4t4t7113308
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 23:59:26 -0500
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e6nyfef9f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Nov 2017 23:59:26 -0500
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 13 Nov 2017 04:59:24 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 1/5] powerpc/64s/hash: Fix 128TB-512TB virtual address
 boundary case allocation
In-Reply-To: <20171109172740.19681-2-npiggin@gmail.com>
References: <20171109172740.19681-1-npiggin@gmail.com>
 <20171109172740.19681-2-npiggin@gmail.com>
Date: Mon, 13 Nov 2017 10:29:19 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87h8tysriw.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> When allocating VA space with a hint that crosses 128TB, the SLB addr_limit
> variable is not expanded if addr is not > 128TB, but the slice allocation
> looks at task_size, which is 512TB. This results in slice_check_fit()
> incorrectly succeeding because the slice_count truncates off bit 128 of the
> requested mask, so the comparison to the available mask succeeds.
>
> Fix this by using mm->context.addr_limit instead of mm->task_size for
> testing allocation limits. This causes such allocations to fail.
>

Also note that this change the rule from > 128TB to >-128TB to select
the larger address space. I guess that is correct because without '>=' we
won't be able to allocate anything starting from 128TB (except MAP_FIXED).

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/slice.c | 50 ++++++++++++++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 26 deletions(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 45f6740dd407..3889201b560c 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -96,7 +96,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
>  {
>  	struct vm_area_struct *vma;
>
> -	if ((mm->task_size - len) < addr)
> +	if ((mm->context.addr_limit - len) < addr)
>  		return 0;
>  	vma = find_vma(mm, addr);
>  	return (!vma || (addr + len) <= vm_start_gap(vma));
> @@ -133,7 +133,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
>  		if (!slice_low_has_vma(mm, i))
>  			ret->low_slices |= 1u << i;
>
> -	if (mm->task_size <= SLICE_LOW_TOP)
> +	if (mm->context.addr_limit <= SLICE_LOW_TOP)
>  		return;
>
>  	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++)
> @@ -412,25 +412,31 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	struct slice_mask compat_mask;
>  	int fixed = (flags & MAP_FIXED);
>  	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
> +	unsigned long page_size = 1UL << pshift;
>  	struct mm_struct *mm = current->mm;
>  	unsigned long newaddr;
>  	unsigned long high_limit;
>
> -	/*
> -	 * Check if we need to expland slice area.
> -	 */
> -	if (unlikely(addr > mm->context.addr_limit &&
> -		     mm->context.addr_limit != TASK_SIZE)) {
> -		mm->context.addr_limit = TASK_SIZE;
> +	high_limit = DEFAULT_MAP_WINDOW;
> +	if (addr >= high_limit)
> +		high_limit = TASK_SIZE;
> +
> +	if (len > high_limit)
> +		return -ENOMEM;
> +	if (len & (page_size - 1))
> +		return -EINVAL;
> +	if (fixed) {
> +		if (addr & (page_size - 1))
> +			return -EINVAL;
> +		if (addr > high_limit - len)
> +			return -ENOMEM;
> +	}
> +
> +	if (high_limit > mm->context.addr_limit) {
> +		mm->context.addr_limit = high_limit;
>  		on_each_cpu(slice_flush_segments, mm, 1);
>  	}
> -	/*
> -	 * This mmap request can allocate upt to 512TB
> -	 */
> -	if (addr > DEFAULT_MAP_WINDOW)
> -		high_limit = mm->context.addr_limit;
> -	else
> -		high_limit = DEFAULT_MAP_WINDOW;
> +
>  	/*
>  	 * init different masks
>  	 */
> @@ -446,27 +452,19 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>
>  	/* Sanity checks */
>  	BUG_ON(mm->task_size == 0);
> +	BUG_ON(mm->context.addr_limit == 0);
>  	VM_BUG_ON(radix_enabled());
>
>  	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
>  	slice_dbg(" addr=%lx, len=%lx, flags=%lx, topdown=%d\n",
>  		  addr, len, flags, topdown);
>
> -	if (len > mm->task_size)
> -		return -ENOMEM;
> -	if (len & ((1ul << pshift) - 1))
> -		return -EINVAL;
> -	if (fixed && (addr & ((1ul << pshift) - 1)))
> -		return -EINVAL;
> -	if (fixed && addr > (mm->task_size - len))
> -		return -ENOMEM;
> -
>  	/* If hint, make sure it matches our alignment restrictions */
>  	if (!fixed && addr) {
> -		addr = _ALIGN_UP(addr, 1ul << pshift);
> +		addr = _ALIGN_UP(addr, page_size);
>  		slice_dbg(" aligned addr=%lx\n", addr);
>  		/* Ignore hint if it's too large or overlaps a VMA */
> -		if (addr > mm->task_size - len ||
> +		if (addr > high_limit - len ||
>  		    !slice_area_is_free(mm, addr, len))
>  			addr = 0;
>  	}
> -- 
> 2.15.0
