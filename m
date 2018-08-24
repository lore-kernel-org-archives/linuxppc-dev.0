Return-Path: <lkp@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xcxY1zX4zDqk8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 20:30:38 +1000 (AEST)
Date: Fri, 24 Aug 2018 18:29:46 +0800
From: kbuild test robot <lkp@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: kbuild-all@01.org, npiggin@gmail.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 1/6] powerpc/mm/book3s: Update pmd_present to look at
 _PAGE_PRESENT bit
Message-ID: <201808241634.wyzX1AJG%fengguang.wu@intel.com>
References: <20180824060008.18396-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <20180824060008.18396-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aneesh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on v4.18 next-20180822]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/powerpc-mm-book3s-Update-pmd_present-to-look-at-_PAGE_PRESENT-bit/20180824-141837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-allnoconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All errors (new ones prefixed by >>):

   In file included from include/linux/kernel.h:15:0,
                    from arch/powerpc/mm/pgtable.c:24:
   arch/powerpc/mm/pgtable.c: In function 'set_pte_at':
>> arch/powerpc/mm/pgtable.c:195:14: error: implicit declaration of function 'pte_raw'; did you mean 'pte_read'? [-Werror=implicit-function-declaration]
     VM_WARN_ON((pte_raw(*ptep) & cpu_to_be64(_PAGE_PRESENT)) &&
                 ^
   include/linux/build_bug.h:36:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
    #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
                                                                  ^
   arch/powerpc/mm/pgtable.c:195:2: note: in expansion of macro 'VM_WARN_ON'
     VM_WARN_ON((pte_raw(*ptep) & cpu_to_be64(_PAGE_PRESENT)) &&
     ^~~~~~~~~~
   cc1: all warnings being treated as errors

vim +195 arch/powerpc/mm/pgtable.c

  > 24	#include <linux/kernel.h>
    25	#include <linux/gfp.h>
    26	#include <linux/mm.h>
    27	#include <linux/percpu.h>
    28	#include <linux/hardirq.h>
    29	#include <linux/hugetlb.h>
    30	#include <asm/pgalloc.h>
    31	#include <asm/tlbflush.h>
    32	#include <asm/tlb.h>
    33	
    34	static inline int is_exec_fault(void)
    35	{
    36		return current->thread.regs && TRAP(current->thread.regs) == 0x400;
    37	}
    38	
    39	/* We only try to do i/d cache coherency on stuff that looks like
    40	 * reasonably "normal" PTEs. We currently require a PTE to be present
    41	 * and we avoid _PAGE_SPECIAL and cache inhibited pte. We also only do that
    42	 * on userspace PTEs
    43	 */
    44	static inline int pte_looks_normal(pte_t pte)
    45	{
    46	
    47	#if defined(CONFIG_PPC_BOOK3S_64)
    48		if ((pte_val(pte) & (_PAGE_PRESENT | _PAGE_SPECIAL)) == _PAGE_PRESENT) {
    49			if (pte_ci(pte))
    50				return 0;
    51			if (pte_user(pte))
    52				return 1;
    53		}
    54		return 0;
    55	#else
    56		return (pte_val(pte) &
    57			(_PAGE_PRESENT | _PAGE_SPECIAL | _PAGE_NO_CACHE | _PAGE_USER |
    58			 _PAGE_PRIVILEGED)) ==
    59			(_PAGE_PRESENT | _PAGE_USER);
    60	#endif
    61	}
    62	
    63	static struct page *maybe_pte_to_page(pte_t pte)
    64	{
    65		unsigned long pfn = pte_pfn(pte);
    66		struct page *page;
    67	
    68		if (unlikely(!pfn_valid(pfn)))
    69			return NULL;
    70		page = pfn_to_page(pfn);
    71		if (PageReserved(page))
    72			return NULL;
    73		return page;
    74	}
    75	
    76	#if defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0
    77	
    78	/* Server-style MMU handles coherency when hashing if HW exec permission
    79	 * is supposed per page (currently 64-bit only). If not, then, we always
    80	 * flush the cache for valid PTEs in set_pte. Embedded CPU without HW exec
    81	 * support falls into the same category.
    82	 */
    83	
    84	static pte_t set_pte_filter(pte_t pte)
    85	{
    86		if (radix_enabled())
    87			return pte;
    88	
    89		pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
    90		if (pte_looks_normal(pte) && !(cpu_has_feature(CPU_FTR_COHERENT_ICACHE) ||
    91					       cpu_has_feature(CPU_FTR_NOEXECUTE))) {
    92			struct page *pg = maybe_pte_to_page(pte);
    93			if (!pg)
    94				return pte;
    95			if (!test_bit(PG_arch_1, &pg->flags)) {
    96				flush_dcache_icache_page(pg);
    97				set_bit(PG_arch_1, &pg->flags);
    98			}
    99		}
   100		return pte;
   101	}
   102	
   103	static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
   104					     int dirty)
   105	{
   106		return pte;
   107	}
   108	
   109	#else /* defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0 */
   110	
   111	/* Embedded type MMU with HW exec support. This is a bit more complicated
   112	 * as we don't have two bits to spare for _PAGE_EXEC and _PAGE_HWEXEC so
   113	 * instead we "filter out" the exec permission for non clean pages.
   114	 */
   115	static pte_t set_pte_filter(pte_t pte)
   116	{
   117		struct page *pg;
   118	
   119		/* No exec permission in the first place, move on */
   120		if (!(pte_val(pte) & _PAGE_EXEC) || !pte_looks_normal(pte))
   121			return pte;
   122	
   123		/* If you set _PAGE_EXEC on weird pages you're on your own */
   124		pg = maybe_pte_to_page(pte);
   125		if (unlikely(!pg))
   126			return pte;
   127	
   128		/* If the page clean, we move on */
   129		if (test_bit(PG_arch_1, &pg->flags))
   130			return pte;
   131	
   132		/* If it's an exec fault, we flush the cache and make it clean */
   133		if (is_exec_fault()) {
   134			flush_dcache_icache_page(pg);
   135			set_bit(PG_arch_1, &pg->flags);
   136			return pte;
   137		}
   138	
   139		/* Else, we filter out _PAGE_EXEC */
   140		return __pte(pte_val(pte) & ~_PAGE_EXEC);
   141	}
   142	
   143	static pte_t set_access_flags_filter(pte_t pte, struct vm_area_struct *vma,
   144					     int dirty)
   145	{
   146		struct page *pg;
   147	
   148		/* So here, we only care about exec faults, as we use them
   149		 * to recover lost _PAGE_EXEC and perform I$/D$ coherency
   150		 * if necessary. Also if _PAGE_EXEC is already set, same deal,
   151		 * we just bail out
   152		 */
   153		if (dirty || (pte_val(pte) & _PAGE_EXEC) || !is_exec_fault())
   154			return pte;
   155	
   156	#ifdef CONFIG_DEBUG_VM
   157		/* So this is an exec fault, _PAGE_EXEC is not set. If it was
   158		 * an error we would have bailed out earlier in do_page_fault()
   159		 * but let's make sure of it
   160		 */
   161		if (WARN_ON(!(vma->vm_flags & VM_EXEC)))
   162			return pte;
   163	#endif /* CONFIG_DEBUG_VM */
   164	
   165		/* If you set _PAGE_EXEC on weird pages you're on your own */
   166		pg = maybe_pte_to_page(pte);
   167		if (unlikely(!pg))
   168			goto bail;
   169	
   170		/* If the page is already clean, we move on */
   171		if (test_bit(PG_arch_1, &pg->flags))
   172			goto bail;
   173	
   174		/* Clean the page and set PG_arch_1 */
   175		flush_dcache_icache_page(pg);
   176		set_bit(PG_arch_1, &pg->flags);
   177	
   178	 bail:
   179		return __pte(pte_val(pte) | _PAGE_EXEC);
   180	}
   181	
   182	#endif /* !(defined(CONFIG_PPC_STD_MMU) || _PAGE_EXEC == 0) */
   183	
   184	/*
   185	 * set_pte stores a linux PTE into the linux page table.
   186	 */
   187	void set_pte_at(struct mm_struct *mm, unsigned long addr, pte_t *ptep,
   188			pte_t pte)
   189	{
   190		/*
   191		 * When handling numa faults, we already have the pte marked
   192		 * _PAGE_PRESENT, but we can be sure that it is not in hpte.
   193		 * Hence we can use set_pte_at for them.
   194		 */
 > 195		VM_WARN_ON((pte_raw(*ptep) & cpu_to_be64(_PAGE_PRESENT)) &&
   196			!pte_protnone(*ptep));
   197	
   198		/* Add the pte bit when trying to set a pte */
   199		pte = __pte(pte_val(pte) | _PAGE_PTE);
   200	
   201		/* Note: mm->context.id might not yet have been assigned as
   202		 * this context might not have been activated yet when this
   203		 * is called.
   204		 */
   205		pte = set_pte_filter(pte);
   206	
   207		/* Perform the setting of the PTE */
   208		__set_pte_at(mm, addr, ptep, pte, 0);
   209	}
   210	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--3V7upXqbjpZ4EhLz
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--3V7upXqbjpZ4EhLz--
