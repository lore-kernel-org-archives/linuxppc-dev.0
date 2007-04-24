Return-Path: <benh@kernel.crashing.org>
Subject: Re: powerpc: Cleanup and fix breakage in tlbflush.h
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070424030912.GA30007@localhost.localdomain>
References: <20070424030912.GA30007@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 13:14:26 +1000
Message-Id: <1177384466.14873.59.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-04-24 at 13:09 +1000, David Gibson wrote:
> BenH's commit a741e67969577163a4cfc78d7fd2753219087ef1 in powerpc.git,
> although (AFAICT) only intended to affect ppc64, also has side-effects
> which break 44x.  I think 40x, 8xx and Freescale Book E are also
> affected, though I haven't tested them.
> 
> The problem lies in unconditionally removing flush_tlb_pending() from
> the versions of flush_tlb_mm(), flush_tlb_range() and
> flush_tlb_kernel_range() used on ppc64 - which are also used the
> embedded platforms mentioned above.
> 
> 
> The patch below cleans up the convoluted #ifdef logic in tlbflush.h,
> in the process restoring the necessary flushes for the software TLB
> platforms.  There are three sets of definitions for the flushing
> hooks: the software TLB versions (revised to avoid using names which
> appear to related to TLB batching), the 32-bit hash based versions
> (external functions) amd the 64-bit hash based versions (which
> implement batching).
> 
> It also moves the declaration of update_mmu_cache() to always be in
> tlbflush.h (previously it was in tlbflush.h except for PPC64, where it
> was in pgtable.h).
> 
> Booted on Ebony (440GP) and compiled for 64-bit and 32-bit
> multiplatform.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> Paul, I think this is ok to apply.  This obsoletes my earlier hackier
> patch for restoring the necessary TLB flushes on 44x et al.
> 
> Index: working-2.6/include/asm-powerpc/pgtable.h
> ===================================================================
> --- working-2.6.orig/include/asm-powerpc/pgtable.h	2007-04-24 12:47:01.000000000 +1000
> +++ working-2.6/include/asm-powerpc/pgtable.h	2007-04-24 12:47:04.000000000 +1000
> @@ -448,16 +448,6 @@ extern pgd_t swapper_pg_dir[];
>  
>  extern void paging_init(void);
>  
> -/*
> - * This gets called at the end of handling a page fault, when
> - * the kernel has put a new PTE into the page table for the process.
> - * We use it to put a corresponding HPTE into the hash table
> - * ahead of time, instead of waiting for the inevitable extra
> - * hash-table miss exception.
> - */
> -struct vm_area_struct;
> -extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
> -
>  /* Encode and de-code a swap entry */
>  #define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
>  #define __swp_offset(entry)	((entry).val >> 8)
> Index: working-2.6/include/asm-powerpc/tlbflush.h
> ===================================================================
> --- working-2.6.orig/include/asm-powerpc/tlbflush.h	2007-04-24 12:47:01.000000000 +1000
> +++ working-2.6/include/asm-powerpc/tlbflush.h	2007-04-24 12:53:31.000000000 +1000
> @@ -17,10 +17,73 @@
>   */
>  #ifdef __KERNEL__
>  
> -
>  struct mm_struct;
> +struct vm_area_struct;
> +
> +#if defined(CONFIG_4xx) || defined(CONFIG_8xx) || defined(CONFIG_FSL_BOOKE)
> +/*
> + * TLB flushing for software loaded TLB chips
> + *
> + * TODO: (CONFIG_FSL_BOOKE) determine if flush_tlb_range &
> + * flush_tlb_kernel_range are best implemented as tlbia vs
> + * specific tlbie's
> + */
>  
> -#ifdef CONFIG_PPC64
> +extern void _tlbie(unsigned long address);
> +
> +#if defined(CONFIG_40x) || defined(CONFIG_8xx)
> +#define _tlbia()	asm volatile ("tlbia; sync" : : : "memory")
> +#else /* CONFIG_44x || CONFIG_FSL_BOOKE */
> +extern void _tlbia(void);
> +#endif
> +
> +static inline void flush_tlb_mm(struct mm_struct *mm)
> +{
> +	_tlbia();
> +}
> +
> +static inline void flush_tlb_page(struct vm_area_struct *vma,
> +				  unsigned long vmaddr)
> +{
> +	_tlbie(vmaddr);
> +}
> +
> +static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
> +					 unsigned long vmaddr)
> +{
> +	_tlbie(vmaddr);
> +}
> +
> +static inline void flush_tlb_range(struct vm_area_struct *vma,
> +				   unsigned long start, unsigned long end)
> +{
> +	_tlbia();
> +}
> +
> +static inline void flush_tlb_kernel_range(unsigned long start,
> +					  unsigned long end)
> +{
> +	_tlbia();
> +}
> +
> +#elif defined(CONFIG_PPC32)
> +/*
> + * TLB flushing for "classic" hash-MMMU 32-bit CPUs, 6xx, 7xx, 7xxx
> + */
> +extern void _tlbie(unsigned long address);
> +extern void _tlbia(void);
> +
> +extern void flush_tlb_mm(struct mm_struct *mm);
> +extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
> +extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
> +extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> +			    unsigned long end);
> +extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
> +
> +#else
> +/*
> + * TLB flushing for 64-bit has-MMU CPUs
> + */
>  
>  #include <linux/percpu.h>
>  #include <asm/page.h>
> @@ -67,89 +130,51 @@ extern void flush_hash_page(unsigned lon
>  			    int local);
>  extern void flush_hash_range(unsigned long number, int local);
>  
> -#else /* CONFIG_PPC64 */
> -
> -#include <linux/mm.h>
> -
> -extern void _tlbie(unsigned long address);
> -extern void _tlbia(void);
> -
> -/*
> - * TODO: (CONFIG_FSL_BOOKE) determine if flush_tlb_range &
> - * flush_tlb_kernel_range are best implemented as tlbia vs
> - * specific tlbie's
> - */
> -
> -#if (defined(CONFIG_4xx) && !defined(CONFIG_44x)) || defined(CONFIG_8xx)
> -#define flush_tlb_pending()	asm volatile ("tlbia; sync" : : : "memory")
> -#elif defined(CONFIG_4xx) || defined(CONFIG_FSL_BOOKE)
> -#define flush_tlb_pending()	_tlbia()
> -#endif
> -
> -/*
> - * This gets called at the end of handling a page fault, when
> - * the kernel has put a new PTE into the page table for the process.
> - * We use it to ensure coherency between the i-cache and d-cache
> - * for the page which has just been mapped in.
> - * On machines which use an MMU hash table, we use this to put a
> - * corresponding HPTE into the hash table ahead of time, instead of
> - * waiting for the inevitable extra hash-table miss exception.
> - */
> -extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
> -
> -#endif /* CONFIG_PPC64 */
> -
> -#if defined(CONFIG_PPC64) || defined(CONFIG_4xx) || \
> -	defined(CONFIG_FSL_BOOKE) || defined(CONFIG_8xx)
>  
>  static inline void flush_tlb_mm(struct mm_struct *mm)
>  {
>  }
>  
>  static inline void flush_tlb_page(struct vm_area_struct *vma,
> -				unsigned long vmaddr)
> +				  unsigned long vmaddr)
>  {
> -#ifndef CONFIG_PPC64
> -	_tlbie(vmaddr);
> -#endif
>  }
>  
>  static inline void flush_tlb_page_nohash(struct vm_area_struct *vma,
>  					 unsigned long vmaddr)
>  {
> -#ifndef CONFIG_PPC64
> -	_tlbie(vmaddr);
> -#endif
>  }
>  
>  static inline void flush_tlb_range(struct vm_area_struct *vma,
> -		unsigned long start, unsigned long end)
> +				   unsigned long start, unsigned long end)
>  {
>  }
>  
>  static inline void flush_tlb_kernel_range(unsigned long start,
> -		unsigned long end)
> +					  unsigned long end)
>  {
>  }
>  
> -#else	/* 6xx, 7xx, 7xxx cpus */
> -
> -extern void flush_tlb_mm(struct mm_struct *mm);
> -extern void flush_tlb_page(struct vm_area_struct *vma, unsigned long vmaddr);
> -extern void flush_tlb_page_nohash(struct vm_area_struct *vma, unsigned long addr);
> -extern void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> -			    unsigned long end);
> -extern void flush_tlb_kernel_range(unsigned long start, unsigned long end);
> -
>  #endif
>  
>  /*
> + * This gets called at the end of handling a page fault, when
> + * the kernel has put a new PTE into the page table for the process.
> + * We use it to ensure coherency between the i-cache and d-cache
> + * for the page which has just been mapped in.
> + * On machines which use an MMU hash table, we use this to put a
> + * corresponding HPTE into the hash table ahead of time, instead of
> + * waiting for the inevitable extra hash-table miss exception.
> + */
> +extern void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t);
> +
> +/*
>   * This is called in munmap when we have freed up some page-table
>   * pages.  We don't need to do anything here, there's nothing special
>   * about our page-table pages.  -- paulus
>   */
>  static inline void flush_tlb_pgtables(struct mm_struct *mm,
> -		unsigned long start, unsigned long end)
> +				      unsigned long start, unsigned long end)
>  {
>  }
>  
> Index: working-2.6/arch/powerpc/mm/mmu_decl.h
> ===================================================================
> --- working-2.6.orig/arch/powerpc/mm/mmu_decl.h	2007-04-24 12:54:50.000000000 +1000
> +++ working-2.6/arch/powerpc/mm/mmu_decl.h	2007-04-24 12:54:59.000000000 +1000
> @@ -19,6 +19,7 @@
>   *  2 of the License, or (at your option) any later version.
>   *
>   */
> +#include <linux/mm.h>
>  #include <asm/tlbflush.h>
>  #include <asm/mmu.h>
>  
> 
