Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkjvb2NZBzDqYd
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 09:34:35 +1100 (AEDT)
Date: Fri, 17 Mar 2017 09:19:20 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 06/11] powerpc/mm/hugetlb: Filter out hugepage size
 not supported by page table layout
Message-ID: <20170316221920.GF10100@fergus.ozlabs.ibm.com>
References: <1489660329-22501-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1489660329-22501-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1489660329-22501-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 16, 2017 at 04:02:04PM +0530, Aneesh Kumar K.V wrote:
> Without this if firmware reports 1MB page size support we will crash
> trying to use 1MB as hugetlb page size.
> 
> echo 300 > /sys/kernel/mm/hugepages/hugepages-1024kB/nr_hugepages
> 
> kernel BUG at ./arch/powerpc/include/asm/hugetlb.h:19!
> .....
> ....
> [c0000000e2c27b30] c00000000029dae8 .hugetlb_fault+0x638/0xda0
> [c0000000e2c27c30] c00000000026fb64 .handle_mm_fault+0x844/0x1d70
> [c0000000e2c27d70] c00000000004805c .do_page_fault+0x3dc/0x7c0
> [c0000000e2c27e30] c00000000000ac98 handle_page_fault+0x10/0x30
> 
> With fix, we don't enable 1MB as hugepage size.
> 
> bash-4.2# cd /sys/kernel/mm/hugepages/
> bash-4.2# ls
> hugepages-16384kB  hugepages-16777216kB
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hugetlbpage.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
> index 8c3389cbcd12..eb8d42bac00b 100644
> --- a/arch/powerpc/mm/hugetlbpage.c
> +++ b/arch/powerpc/mm/hugetlbpage.c
> @@ -738,6 +738,7 @@ static int __init add_huge_page_size(unsigned long long size)
>  	int shift = __ffs(size);
>  	int mmu_psize;
>  
> +#ifndef CONFIG_PPC_BOOK3S_64

This #ifndef doesn't really seem necessary.  All it is removing is a
check for size <= PAGE_SIZE.  Yes that check is subsumed by the checks
you are adding below, but on the other hand, #if[n]defs inside
functions are ugly and make the code harder to read.  Since this is
not a hot path, let's not have the ifndef.

>  	/* Check that it is a page size supported by the hardware and
>  	 * that it fits within pagetable and slice limits. */
>  	if (size <= PAGE_SIZE)
> @@ -749,10 +750,29 @@ static int __init add_huge_page_size(unsigned long long size)
>  	if (!is_power_of_2(size) || (shift > SLICE_HIGH_SHIFT))
>  		return -EINVAL;
>  #endif
> +#endif /* CONFIG_PPC_BOOK3S_64 */
>  
>  	if ((mmu_psize = shift_to_mmu_psize(shift)) < 0)
>  		return -EINVAL;
>  
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	/*
> +	 * We need to make sure that for different page sizes reported by
> +	 * firmware we only add hugetlb support for page sizes that can be
> +	 * supported by linux page table layout.
> +	 * For now we have
> +	 * Radix: 2M
> +	 * Hash: 16M and 16G
> +	 */
> +	if (radix_enabled()) {
> +		if (mmu_psize != MMU_PAGE_2M)
> +			return -EINVAL;
> +	} else {
> +		if (mmu_psize != MMU_PAGE_16M && mmu_psize != MMU_PAGE_16G)
> +			return -EINVAL;
> +	}
> +#endif
> +
>  	BUG_ON(mmu_psize_defs[mmu_psize].shift != shift);
>  
>  	/* Return if huge page size has already been setup */
> -- 
> 2.7.4

Paul.
