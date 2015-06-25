Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D510D1A06A6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 16:16:44 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Thu, 25 Jun 2015 16:16:43 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 39F8A3578048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 16:16:40 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5P6GWIk4587780
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 16:16:40 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5P6G7Ii017343
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jun 2015 16:16:07 +1000
Date: Thu, 25 Jun 2015 11:45:46 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Jeremy Kerr <jeremy.kerr@au1.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Fix vma page prot flags in opal-prd
 driver
Message-ID: <20150625061546.GA4233@dirshya.in.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
References: <20150621182616.9866.16633.stgit@drishya>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150621182616.9866.16633.stgit@drishya>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> [2015-06-21 23:56:16]:

> opal-prd driver will mmap() firmware code/data area as private
> mapping to prd user space daemon.  Write to this page will
> trigger COW faults.  The new COW pages are normal kernel RAM
> pages accounted by the kernel and are not special.
> 
> vma->vm_page_prot value will be used at page fault time
> for the new COW pages, while pgprot_t value passed in
> remap_pfn_range() is used for the initial page table entry.
> 
> Hence:
> * Do not add _PAGE_SPECIAL in vma, but only for remap_pfn_range()
> * Also remap_pfn_range() will add the _PAGE_SPECIAL flag using
>   pte_mkspecial() call, hence no need to specify in the driver
> 
> This fix resolves the page accounting warning shown below:
> BUG: Bad rss-counter state mm:c0000007d34ac600 idx:1 val:19
> 
> The above warning is triggered since _PAGE_SPECIAL was incorrectly
> being set for the normal kernel COW pages.
> 
> Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/opal-prd.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal-prd.c b/arch/powerpc/platforms/powernv/opal-prd.c
> index 46cb3fe..4ece8e4 100644
> --- a/arch/powerpc/platforms/powernv/opal-prd.c
> +++ b/arch/powerpc/platforms/powernv/opal-prd.c
> @@ -112,6 +112,7 @@ static int opal_prd_open(struct inode *inode, struct file *file)
>  static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma)
>  {
>  	size_t addr, size;
> +	pgprot_t page_prot;
>  	int rc;
>  
>  	pr_devel("opal_prd_mmap(0x%016lx, 0x%016lx, 0x%lx, 0x%lx)\n",
> @@ -125,13 +126,11 @@ static int opal_prd_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (!opal_prd_range_is_valid(addr, size))
>  		return -EINVAL;
>  
> -	vma->vm_page_prot = __pgprot(pgprot_val(phys_mem_access_prot(file,
> -						vma->vm_pgoff,
> -						 size, vma->vm_page_prot))
> -					| _PAGE_SPECIAL);
> +	page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
> +					 size, vma->vm_page_prot);
>  
>  	rc = remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff, size,
> -			vma->vm_page_prot);
> +				page_prot);

Hi Ben,

remap_pfn_range() is the correct method to map the firmware pages
because we will not have struct page associated with this RAM area.

We do a memblock_reserve() in early boot and take out this memory from
kernel and avoid struct page allocation/init for these.

vm_insert_page() is an alternative that would have worked if kernel
allocated the memory, in which case we can bump up the page count and
map the page to user space.  This is already done by vm_insert_page()
and we will not need to make the page special.

However, this use case fits remap_pfn_range() and page special
mechanism since there is no struct page associate with this physical
pages.

--Vaidy
