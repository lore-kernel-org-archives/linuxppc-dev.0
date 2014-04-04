Return-Path: <kas@node.shutemov.name>
Received: from jenni1.inet.fi (mta-out.inet.fi [195.156.147.13])
 by ozlabs.org (Postfix) with ESMTP id AAE67140096
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 Apr 2014 00:20:42 +1100 (EST)
Date: Fri, 4 Apr 2014 16:17:47 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: Re: [PATCH V2 1/2] mm: move FAULT_AROUND_ORDER to arch/
Message-ID: <20140404131747.GA23076@node.dhcp.inet.fi>
References: <1396592835-24767-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1396592835-24767-2-git-send-email-maddy@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, riel@redhat.com, rusty@rustcorp.com.au,
 peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ak@linux.intel.com, paulus@samba.org, mgorman@suse.de,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org,
 kirill.shutemov@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 04, 2014 at 11:57:14AM +0530, Madhavan Srinivasan wrote:
> Kirill A. Shutemov with faultaround patchset introduced
> vm_ops->map_pages() for mapping easy accessible pages around
> fault address in hope to reduce number of minor page faults.
> 
> This patch creates infrastructure to move the FAULT_AROUND_ORDER
> to arch/ using Kconfig. This will enable architecture maintainers
> to decide on suitable FAULT_AROUND_ORDER value based on
> performance data for that architecture. Patch also adds
> FAULT_AROUND_ORDER Kconfig element in arch/X86.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/x86/Kconfig   |    4 ++++
>  include/linux/mm.h |    9 +++++++++
>  mm/memory.c        |   12 +++++-------
>  3 files changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 9c0a657..5833f22 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1177,6 +1177,10 @@ config DIRECT_GBPAGES
>  	  support it. This can improve the kernel's performance a tiny bit by
>  	  reducing TLB pressure. If in doubt, say "Y".
>  
> +config FAULT_AROUND_ORDER
> +	int
> +	default "4"
> +
>  # Common NUMA Features
>  config NUMA
>  	bool "Numa Memory Allocation and Scheduler Support"
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 0bd4359..b93c1c3 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -26,6 +26,15 @@ struct file_ra_state;
>  struct user_struct;
>  struct writeback_control;
>  
> +/*
> + * Fault around order is a control knob to decide the fault around pages.
> + * Default value is set to 0UL (disabled), but the arch can override it as
> + * desired.
> + */
> +#ifndef CONFIG_FAULT_AROUND_ORDER
> +#define CONFIG_FAULT_AROUND_ORDER 0
> +#endif
> +

I don't think it should be in header file: nobody except mm/memory.c cares.
Just put it instead '#define FAULT_AROUND_ORDER'.

>  #ifndef CONFIG_NEED_MULTIPLE_NODES	/* Don't use mapnrs, do it properly */
>  extern unsigned long max_mapnr;
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index b02c584..22a4a89 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3358,10 +3358,8 @@ void do_set_pte(struct vm_area_struct *vma, unsigned long address,
>  	update_mmu_cache(vma, address, pte);
>  }
>  
> -#define FAULT_AROUND_ORDER 4
> -
>  #ifdef CONFIG_DEBUG_FS
> -static unsigned int fault_around_order = FAULT_AROUND_ORDER;
> +static unsigned int fault_around_order = CONFIG_FAULT_AROUND_ORDER;
>  
>  static int fault_around_order_get(void *data, u64 *val)
>  {
> @@ -3371,7 +3369,7 @@ static int fault_around_order_get(void *data, u64 *val)
>  
>  static int fault_around_order_set(void *data, u64 val)
>  {
> -	BUILD_BUG_ON((1UL << FAULT_AROUND_ORDER) > PTRS_PER_PTE);
> +	BUILD_BUG_ON((1UL << CONFIG_FAULT_AROUND_ORDER) > PTRS_PER_PTE);
>  	if (1UL << val > PTRS_PER_PTE)
>  		return -EINVAL;
>  	fault_around_order = val;
> @@ -3406,14 +3404,14 @@ static inline unsigned long fault_around_pages(void)
>  {
>  	unsigned long nr_pages;
>  
> -	nr_pages = 1UL << FAULT_AROUND_ORDER;
> +	nr_pages = 1UL << CONFIG_FAULT_AROUND_ORDER;
>  	BUILD_BUG_ON(nr_pages > PTRS_PER_PTE);
>  	return nr_pages;
>  }
>  
>  static inline unsigned long fault_around_mask(void)
>  {
> -	return ~((1UL << (PAGE_SHIFT + FAULT_AROUND_ORDER)) - 1);
> +	return ~((1UL << (PAGE_SHIFT + CONFIG_FAULT_AROUND_ORDER)) - 1);
>  }
>  #endif
>  
> @@ -3471,7 +3469,7 @@ static int do_read_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  	 * if page by the offset is not ready to be mapped (cold cache or
>  	 * something).
>  	 */
> -	if (vma->vm_ops->map_pages) {
> +	if ((vma->vm_ops->map_pages) && (fault_around_pages() > 1)) {

	if (vma->vm_ops->map_pages && fault_around_pages()) {

>  		pte = pte_offset_map_lock(mm, pmd, address, &ptl);
>  		do_fault_around(vma, address, pte, pgoff, flags);
>  		if (!pte_same(*pte, orig_pte))
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
 Kirill A. Shutemov
