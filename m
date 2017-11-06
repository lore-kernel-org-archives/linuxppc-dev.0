Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVqj31PShzDrLR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 22:15:02 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA6BEe4h128582
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Nov 2017 06:14:55 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e2pcss18j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 06:14:55 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 6 Nov 2017 11:14:53 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 4/5] powerpc/64s/radix: Fix 128TB-512TB virtual address
 boundary case allocation
In-Reply-To: <20171106100315.29720-5-npiggin@gmail.com>
References: <20171106100315.29720-1-npiggin@gmail.com>
 <20171106100315.29720-5-npiggin@gmail.com>
Date: Mon, 06 Nov 2017 16:44:48 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87po8vslp3.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> Radix VA space allocations test addresses against mm->task_size which is
> 512TB, even in cases where the intention is to limit allocation to below
> 128TB.
>
> This results in mmap with a hint address below 128TB but address + length
> above 128TB succeeding when it should fail (as hash does after the
> previous patch).
>
> Set the high address limit to be considered up front, and base subsequent
> allocation checks on that consistently.

Doesn't setting info.high_limit take care of that ? I would expect
vm_unmapped_area to fail based on info.high_limit. Is this with MAP_FIXED?


>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/hugetlbpage-radix.c | 13 +++++++------
>  arch/powerpc/mm/mmap.c              | 27 ++++++++++++++-------------
>  2 files changed, 21 insertions(+), 19 deletions(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
> index a12e86395025..9c6a411e9c85 100644
> --- a/arch/powerpc/mm/hugetlbpage-radix.c
> +++ b/arch/powerpc/mm/hugetlbpage-radix.c
> @@ -48,14 +48,18 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	struct hstate *h = hstate_file(file);
> +	unsigned long high_limit = DEFAULT_MAP_WINDOW;
>  	struct vm_unmapped_area_info info;
>
>  	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
>  		mm->context.addr_limit = TASK_SIZE;
>
> +	if (addr > high_limit)
> +		high_limit = TASK_SIZE;
> +
>  	if (len & ~huge_page_mask(h))
>  		return -EINVAL;
> -	if (len > mm->task_size)
> +	if (len > high_limit)
>  		return -ENOMEM;
>
>  	if (flags & MAP_FIXED) {
> @@ -67,7 +71,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	if (addr) {
>  		addr = ALIGN(addr, huge_page_size(h));
>  		vma = find_vma(mm, addr);
> -		if (mm->task_size - len >= addr &&
> +		if (high_limit - len >= addr &&
>  		    (!vma || addr + len <= vm_start_gap(vma)))
>  			return addr;
>  	}
> @@ -78,12 +82,9 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
>  	info.low_limit = PAGE_SIZE;
> -	info.high_limit = current->mm->mmap_base;
> +	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
>  	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
>  	info.align_offset = 0;
>
> -	if (addr > DEFAULT_MAP_WINDOW)
> -		info.high_limit += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
> -
>  	return vm_unmapped_area(&info);
>  }
> diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
> index 5d78b193fec4..e6cb3b3f7e93 100644
> --- a/arch/powerpc/mm/mmap.c
> +++ b/arch/powerpc/mm/mmap.c
> @@ -106,13 +106,17 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> +	unsigned long high_limit = DEFAULT_MAP_WINDOW;
>  	struct vm_unmapped_area_info info;
>
>  	if (unlikely(addr > mm->context.addr_limit &&
>  		     mm->context.addr_limit != TASK_SIZE))
>  		mm->context.addr_limit = TASK_SIZE;
>
> -	if (len > mm->task_size - mmap_min_addr)
> +	if (addr > high_limit)
> +		high_limit = TASK_SIZE;
> +
> +	if (len > high_limit - mmap_min_addr)
>  		return -ENOMEM;
>
>  	if (flags & MAP_FIXED)
> @@ -121,7 +125,7 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  	if (addr) {
>  		addr = PAGE_ALIGN(addr);
>  		vma = find_vma(mm, addr);
> -		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
> +		if (high_limit - len >= addr && addr >= mmap_min_addr &&
>  		    (!vma || addr + len <= vm_start_gap(vma)))
>  			return addr;
>  	}
> @@ -129,13 +133,9 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  	info.flags = 0;
>  	info.length = len;
>  	info.low_limit = mm->mmap_base;
> +	info.high_limit = high_limit;
>  	info.align_mask = 0;
>
> -	if (unlikely(addr > DEFAULT_MAP_WINDOW))
> -		info.high_limit = mm->context.addr_limit;
> -	else
> -		info.high_limit = DEFAULT_MAP_WINDOW;
> -
>  	return vm_unmapped_area(&info);
>  }
>
> @@ -149,14 +149,18 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm = current->mm;
>  	unsigned long addr = addr0;
> +	unsigned long high_limit = DEFAULT_MAP_WINDOW;
>  	struct vm_unmapped_area_info info;
>
>  	if (unlikely(addr > mm->context.addr_limit &&
>  		     mm->context.addr_limit != TASK_SIZE))
>  		mm->context.addr_limit = TASK_SIZE;
>
> +	if (addr > high_limit)
> +		high_limit = TASK_SIZE;
> +
>  	/* requested length too big for entire address space */
> -	if (len > mm->task_size - mmap_min_addr)
> +	if (len > high_limit - mmap_min_addr)
>  		return -ENOMEM;
>
>  	if (flags & MAP_FIXED)
> @@ -166,7 +170,7 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
>  	if (addr) {
>  		addr = PAGE_ALIGN(addr);
>  		vma = find_vma(mm, addr);
> -		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
> +		if (high_limit - len >= addr && addr >= mmap_min_addr &&
>  				(!vma || addr + len <= vm_start_gap(vma)))
>  			return addr;
>  	}
> @@ -174,12 +178,9 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
>  	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
>  	info.length = len;
>  	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
> -	info.high_limit = mm->mmap_base;
> +	info.high_limit = mm->mmap_base + (high_limit - DEFAULT_MAP_WINDOW);
>  	info.align_mask = 0;
>
> -	if (addr > DEFAULT_MAP_WINDOW)
> -		info.high_limit += mm->context.addr_limit - DEFAULT_MAP_WINDOW;
> -
>  	addr = vm_unmapped_area(&info);
>  	if (!(addr & ~PAGE_MASK))
>  		return addr;
> -- 
> 2.15.0
