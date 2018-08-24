Return-Path: <lkp@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41xd2750XrzDqj4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Aug 2018 20:34:39 +1000 (AEST)
Date: Fri, 24 Aug 2018 18:34:12 +0800
From: kbuild test robot <lkp@intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: kbuild-all@01.org, npiggin@gmail.com, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3 1/6] powerpc/mm/book3s: Update pmd_present to look at
 _PAGE_PRESENT bit
Message-ID: <201808241608.ls9K3IJe%fengguang.wu@intel.com>
References: <20180824060008.18396-1-aneesh.kumar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="YiEDa0DAkWCtVeE4"
In-Reply-To: <20180824060008.18396-1-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Aneesh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on powerpc/next]
[also build test WARNING on v4.18 next-20180822]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aneesh-Kumar-K-V/powerpc-mm-book3s-Update-pmd_present-to-look-at-_PAGE_PRESENT-bit/20180824-141837
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-obs600_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:15:0,
                    from arch/powerpc/mm/pgtable.c:24:
   arch/powerpc/mm/pgtable.c: In function 'set_pte_at':
   arch/powerpc/mm/pgtable.c:195:14: error: implicit declaration of function 'pte_raw'; did you mean 'pte_read'? [-Werror=implicit-function-declaration]
     VM_WARN_ON((pte_raw(*ptep) & cpu_to_be64(_PAGE_PRESENT)) &&
                 ^
   include/linux/build_bug.h:36:63: note: in definition of macro 'BUILD_BUG_ON_INVALID'
    #define BUILD_BUG_ON_INVALID(e) ((void)(sizeof((__force long)(e))))
                                                                  ^
>> arch/powerpc/mm/pgtable.c:195:2: note: in expansion of macro 'VM_WARN_ON'
     VM_WARN_ON((pte_raw(*ptep) & cpu_to_be64(_PAGE_PRESENT)) &&
     ^~~~~~~~~~
   cc1: all warnings being treated as errors

vim +/VM_WARN_ON +195 arch/powerpc/mm/pgtable.c

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

--YiEDa0DAkWCtVeE4
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--YiEDa0DAkWCtVeE4--
