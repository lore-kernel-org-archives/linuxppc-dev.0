Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZz4S33CxzDqk6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 16:01:12 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAD4xgmO055090
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 00:01:10 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e72fedg05-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 00:01:10 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 13 Nov 2017 05:01:07 -0000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Florian Weimer <fweimer@redhat.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v2 4/5] powerpc/64s/radix: Fix 128TB-512TB virtual address
 boundary case allocation
In-Reply-To: <20171109172740.19681-5-npiggin@gmail.com>
References: <20171109172740.19681-1-npiggin@gmail.com>
 <20171109172740.19681-5-npiggin@gmail.com>
Date: Mon, 13 Nov 2017 10:31:01 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <878tfasrg2.fsf@linux.vnet.ibm.com>
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
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> Fixes: f4ea6dcb08 ("powerpc/mm: Enable mappings above 128TB")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/hugetlbpage-radix.c | 26 ++++++++++++------
>  arch/powerpc/mm/mmap.c              | 55 ++++++++++++++++++++++---------------
>  2 files changed, 50 insertions(+), 31 deletions(-)
>
> diff --git a/arch/powerpc/mm/hugetlbpage-radix.c b/arch/powerpc/mm/hugetlbpage-radix.c
> index 558e9d3891bf..bd022d16745c 100644
> --- a/arch/powerpc/mm/hugetlbpage-radix.c
> +++ b/arch/powerpc/mm/hugetlbpage-radix.c
> @@ -49,17 +49,28 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	struct hstate *h = hstate_file(file);
> +	int fixed = (flags & MAP_FIXED);
> +	unsigned long high_limit;
>  	struct vm_unmapped_area_info info;
>
> -	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
> -		mm->context.addr_limit = TASK_SIZE;
> +	high_limit = DEFAULT_MAP_WINDOW;
> +	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
> +		high_limit = TASK_SIZE;
>
>  	if (len & ~huge_page_mask(h))
>  		return -EINVAL;
> -	if (len > mm->task_size)
> +	if (len > high_limit)
>  		return -ENOMEM;
> +	if (fixed) {
> +		if (addr > high_limit - len)
> +			return -ENOMEM;
> +	}
>
> -	if (flags & MAP_FIXED) {
> +	if (unlikely(addr > mm->context.addr_limit &&
> +		     mm->context.addr_limit != TASK_SIZE))
> +		mm->context.addr_limit = TASK_SIZE;
> +
> +	if (fixed) {
>  		if (prepare_hugepage_range(file, addr, len))
>  			return -EINVAL;
>  		return addr;
> @@ -68,7 +79,7 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>  	if (addr) {
>  		addr = ALIGN(addr, huge_page_size(h));
>  		vma = find_vma(mm, addr);
> -		if (mm->task_size - len >= addr &&
> +		if (high_limit - len >= addr &&
>  		    (!vma || addr + len <= vm_start_gap(vma)))
>  			return addr;
>  	}
> @@ -79,12 +90,9 @@ radix__hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
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
> index 5d78b193fec4..6d476a7b5611 100644
> --- a/arch/powerpc/mm/mmap.c
> +++ b/arch/powerpc/mm/mmap.c
> @@ -106,22 +106,32 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  {
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
> +	int fixed = (flags & MAP_FIXED);
> +	unsigned long high_limit;
>  	struct vm_unmapped_area_info info;
>
> +	high_limit = DEFAULT_MAP_WINDOW;
> +	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
> +		high_limit = TASK_SIZE;
> +
> +	if (len > high_limit)
> +		return -ENOMEM;
> +	if (fixed) {
> +		if (addr > high_limit - len)
> +			return -ENOMEM;
> +	}
> +
>  	if (unlikely(addr > mm->context.addr_limit &&
>  		     mm->context.addr_limit != TASK_SIZE))
>  		mm->context.addr_limit = TASK_SIZE;
>
> -	if (len > mm->task_size - mmap_min_addr)
> -		return -ENOMEM;
> -
> -	if (flags & MAP_FIXED)
> +	if (fixed)
>  		return addr;
>
>  	if (addr) {
>  		addr = PAGE_ALIGN(addr);
>  		vma = find_vma(mm, addr);
> -		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
> +		if (high_limit - len >= addr && addr >= mmap_min_addr &&
>  		    (!vma || addr + len <= vm_start_gap(vma)))
>  			return addr;
>  	}
> @@ -129,13 +139,9 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
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
> @@ -149,37 +155,42 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
>  	struct vm_area_struct *vma;
>  	struct mm_struct *mm = current->mm;
>  	unsigned long addr = addr0;
> +	int fixed = (flags & MAP_FIXED);
> +	unsigned long high_limit;
>  	struct vm_unmapped_area_info info;
>
> +	high_limit = DEFAULT_MAP_WINDOW;
> +	if (addr >= high_limit || (fixed && (addr + len > high_limit)))
> +		high_limit = TASK_SIZE;
> +
> +	if (len > high_limit)
> +		return -ENOMEM;
> +	if (fixed) {
> +		if (addr > high_limit - len)
> +			return -ENOMEM;
> +	}
> +
>  	if (unlikely(addr > mm->context.addr_limit &&
>  		     mm->context.addr_limit != TASK_SIZE))
>  		mm->context.addr_limit = TASK_SIZE;
>
> -	/* requested length too big for entire address space */
> -	if (len > mm->task_size - mmap_min_addr)
> -		return -ENOMEM;
> -
> -	if (flags & MAP_FIXED)
> +	if (fixed)
>  		return addr;
>
> -	/* requesting a specific address */
>  	if (addr) {
>  		addr = PAGE_ALIGN(addr);
>  		vma = find_vma(mm, addr);
> -		if (mm->task_size - len >= addr && addr >= mmap_min_addr &&
> -				(!vma || addr + len <= vm_start_gap(vma)))
> +		if (high_limit - len >= addr && addr >= mmap_min_addr &&
> +		    (!vma || addr + len <= vm_start_gap(vma)))
>  			return addr;
>  	}
>
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
