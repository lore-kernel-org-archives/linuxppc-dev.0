Return-Path: <michael@ellerman.id.au>
Date: Wed, 10 Apr 2013 17:21:23 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 19/25] powerpc/THP: Differentiate THP PMD entries
 from HUGETLB PMD entries
Message-ID: <20130410072122.GC24786@concordia>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1365055083-31956-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 04, 2013 at 11:27:57AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> HUGETLB clear the top bit of PMD entries and use that to indicate
> a HUGETLB page directory. Since we store pfns in PMDs for THP,
> we would have the top bit cleared by default. Add the top bit mask
> for THP PMD entries and clear that when we are looking for pmd_pfn.
> 
> @@ -44,6 +44,14 @@ struct mm_struct;
>  #define PMD_HUGE_RPN_SHIFT	PTE_RPN_SHIFT
>  #define HUGE_PAGE_SIZE		(ASM_CONST(1) << 24)
>  #define HUGE_PAGE_MASK		(~(HUGE_PAGE_SIZE - 1))
> +/*
> + * HugeTLB looks at the top bit of the Linux page table entries to
> + * decide whether it is a huge page directory or not. Mark HUGE
> + * PMD to differentiate
> + */
> +#define PMD_HUGE_NOT_HUGETLB	(ASM_CONST(1) << 63)
> +#define PMD_ISHUGE		(_PMD_ISHUGE | PMD_HUGE_NOT_HUGETLB)
> +#define PMD_HUGE_PROTBITS	(0xfff | PMD_HUGE_NOT_HUGETLB)
>  
>  #ifndef __ASSEMBLY__
>  extern void hpte_need_hugepage_flush(struct mm_struct *mm, unsigned long addr,
> @@ -84,7 +93,8 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
>  	/*
>  	 * Only called for hugepage pmd
>  	 */
> -	return pmd_val(pmd) >> PMD_HUGE_RPN_SHIFT;
> +	unsigned long val = pmd_val(pmd) & ~PMD_HUGE_PROTBITS;
> +	return val  >> PMD_HUGE_RPN_SHIFT;
>  }

This is breaking the 32-bit build for me (pmac32_defconfig):

arch/powerpc/include/asm/pgtable.h:123:2: error: left shift count >= width of type [-Werror]

cheers
