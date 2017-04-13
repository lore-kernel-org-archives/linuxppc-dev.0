Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3d8C0DQczDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 20:59:06 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DAs3dN084346
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 06:59:00 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29t7g11hbt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 06:59:00 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 13 Apr 2017 16:28:56 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3DAwqMA14221498
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 16:28:52 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3DAwpus008429
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 16:28:52 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: ricklind@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: Rick Lindsley <ricklind@linux.vnet.ibm.com>
Subject: Re: [PATCH] arch/powerpc/mm/slice: Cleanup leftover use of task_size
In-Reply-To: <1492067567-24688-1-git-send-email-ricklind@linux.vnet.ibm.com>
References: <1492067567-24688-1-git-send-email-ricklind@linux.vnet.ibm.com>
Date: Thu, 13 Apr 2017 16:28:46 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87poggpo9l.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ricklind@linux.vnet.ibm.com writes:

> From: Rick Lindsley <ricklind@linux.vnet.ibm.com>
>
> With the 512TB virtual addressing capability, a new field was added to
> the paca and mm_context (addr_limit) to track the process's desire to
> use the larger addressing space.  Functions in the radix-enabled path
> (mmap.c) were modified to inspect this value when deciding whether to
> grant or deny requests in that range.
>
> However, the non-radix path falls through to the old, hashed slice code
> (slice_get_unmapped_area, etc.) and these code paths still inspect
> task_size.  The same attention to addr_limit made in (for example)
> radix__arch_get_unmapped_area() should also be applied to (correspondingly)
> slice_get_unmapped_area().


I would suggest we don't do this change now. But rather we audit the
usage of TASK_SIZE(), mm->task_size and move them correctly to
mm->task_size and mm->context.addr_limit. The context.addr_limit is
added as an optimization for slice_mask copy and we need to closely
audit to make sure we can use that as a boundary condition for error
checking in case of mmap.

IMHO we should do this while consoliding
TASK_SIZE/mm->task_size/mm->context.addr_limit.

A previous attempt can be found at

https://lkml.kernel.org/r/20161230155634.8692-1-dsafonov@virtuozzo.com

We should start working in that direction. Some arch even have thread_info.addr_limit

>
> Signed-off-by: Rick Lindsley <ricklind@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/slice.c |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
> index 251b6ba..c023bff 100644
> --- a/arch/powerpc/mm/slice.c
> +++ b/arch/powerpc/mm/slice.c
> @@ -96,7 +96,7 @@ static int slice_area_is_free(struct mm_struct *mm, unsigned long addr,
>  {
>  	struct vm_area_struct *vma;
>  
> -	if ((mm->task_size - len) < addr)
> +	if ((mm->addr_limit - len) < addr)
>  		return 0;
>  	vma = find_vma(mm, addr);
>  	return (!vma || (addr + len) <= vma->vm_start);
> @@ -133,7 +133,7 @@ static void slice_mask_for_free(struct mm_struct *mm, struct slice_mask *ret)
>  		if (!slice_low_has_vma(mm, i))
>  			ret->low_slices |= 1u << i;
>  
> -	if (mm->task_size <= SLICE_LOW_TOP)
> +	if (mm->addr_limit <= SLICE_LOW_TOP)
>  		return;
>  
>  	for (i = 0; i < GET_HIGH_SLICE_INDEX(mm->context.addr_limit); i++)
> @@ -444,20 +444,20 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  	bitmap_zero(compat_mask.high_slices, SLICE_NUM_HIGH);
>  
>  	/* Sanity checks */
> -	BUG_ON(mm->task_size == 0);
> +	BUG_ON(mm->addr_limit == 0);
>  	VM_BUG_ON(radix_enabled());
>  
>  	slice_dbg("slice_get_unmapped_area(mm=%p, psize=%d...\n", mm, psize);
>  	slice_dbg(" addr=%lx, len=%lx, flags=%lx, topdown=%d\n",
>  		  addr, len, flags, topdown);
>  
> -	if (len > mm->task_size)
> +	if (len > mm->addr_limit)
>  		return -ENOMEM;
>  	if (len & ((1ul << pshift) - 1))
>  		return -EINVAL;
>  	if (fixed && (addr & ((1ul << pshift) - 1)))
>  		return -EINVAL;
> -	if (fixed && addr > (mm->task_size - len))
> +	if (fixed && addr > (mm->addr_limit - len))
>  		return -ENOMEM;
>  
>  	/* If hint, make sure it matches our alignment restrictions */
> @@ -465,7 +465,7 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
>  		addr = _ALIGN_UP(addr, 1ul << pshift);
>  		slice_dbg(" aligned addr=%lx\n", addr);
>  		/* Ignore hint if it's too large or overlaps a VMA */
> -		if (addr > mm->task_size - len ||
> +		if (addr > mm->addr_limit - len ||
>  		    !slice_area_is_free(mm, addr, len))
>  			addr = 0;
>  	}
> -- 
> 1.7.1


-aneesh
