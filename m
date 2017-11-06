Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVptd15mzzDrKc
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:38:16 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA6AZF87052753
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Nov 2017 05:38:14 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e2jxf908t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 05:38:13 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Nov 2017 10:38:11 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 1/5] powerpc/64s/hash: Fix 128TB-512TB virtual address
 boundary case allocation
In-Reply-To: <20171106100315.29720-2-npiggin@gmail.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-2-npiggin@gmail.com>
Date: Mon, 06 Nov 2017 16:08:06 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3njsne9.fsf@linux.vnet.ibm.com>
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


But then the mask passed to slice_check_fit() is generated using
context.addr_limit as max value. So how did that return succcess? ie,
we get the request mask via

slice_range_to_mask(addr, len, &mask);

And the potential/possible mask using

slice_mask_for_size(mm, psize, &good_mask);

So how did slice_check_fit() return sucess with

slice_check_fit(mm, mask, good_mask);


>
> Fix this by using mm->context.addr_limit instead of mm->task_size for
> testing allocation limits. This causes such allocations to fail.
>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> Reported-by: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/slice.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 45f6740dd407..567db541c0a1 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -96,7 +96,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
>  {
>  	struct vm_area_struct *vma;
>
> -	if ((mm->task_size - len) < addr)
> +	if ((mm->context.addr_limit - len) < addr)

I was looking at these as generic boundary check against task size and
for specific range check we should have created mask always using
context.addr_limit. That should keep the boundary condition check same
across radix/hash.

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
> @@ -446,19 +446,20 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
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
> +	if (len > mm->context.addr_limit)
>  		return -ENOMEM;
>  	if (len & ((1ul << pshift) - 1))
>  		return -EINVAL;
>  	if (fixed && (addr & ((1ul << pshift) - 1)))
>  		return -EINVAL;
> -	if (fixed && addr > (mm->task_size - len))
> +	if (fixed && addr > (mm->context.addr_limit - len))
>  		return -ENOMEM;
>
>  	/* If hint, make sure it matches our alignment restrictions */
> @@ -466,7 +467,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  		addr = _ALIGN_UP(addr, 1ul << pshift);
>  		slice_dbg(" aligned addr=%lx\n", addr);
>  		/* Ignore hint if it's too large or overlaps a VMA */
> -		if (addr > mm->task_size - len ||
> +		if (addr > mm->context.addr_limit - len ||
>  		    !slice_area_is_free(mm, addr, len))
>  			addr = 0;
>  	}
> -- 
> 2.15.0
