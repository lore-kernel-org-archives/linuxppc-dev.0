Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qrHw53NLSzDqcf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 22:23:17 +1000 (AEST)
Received: by mail-pa0-x22d.google.com with SMTP id r5so26096674pag.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Apr 2016 05:23:17 -0700 (PDT)
Subject: Re: [PATCH V2 32/68] powerpc/mm/radix: Add radix callback for early
 init routines
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-33-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5718C623.8030401@gmail.com>
Date: Thu, 21 Apr 2016 22:22:59 +1000
MIME-Version: 1.0
In-Reply-To: <1460182444-2468-33-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/04/16 16:13, Aneesh Kumar K.V wrote:
> This add routines for early setup w.r.t radix. We use device tree
> property ibm,processor-radix-AP-encodings to find supported page sizes.
> If we don't find above we consider 64K and 4K as supported page sizes.
> 
> We do map vmemap using 2M page size if we can. Linear mapping is done
> such that we use required page size for that range. For ex: memory of
> 3.5G is mapped such that we use 1G mapping till 3G range and use 2M
> mapping for the rest.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h   |  17 +-
>  arch/powerpc/include/asm/book3s/64/radix.h |   2 +
>  arch/powerpc/mm/Makefile                   |   1 +
>  arch/powerpc/mm/pgtable-radix.c            | 344 +++++++++++++++++++++++++++++
>  arch/powerpc/platforms/powernv/setup.c     |   5 +-
>  5 files changed, 367 insertions(+), 2 deletions(-)
>  create mode 100644 arch/powerpc/mm/pgtable-radix.c
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
> index a66cd3e65a33..a526642f1c02 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu.h
> @@ -16,7 +16,10 @@ struct mmu_psize_def {
>  	int		penc[MMU_PAGE_COUNT];	/* HPTE encoding */
>  	unsigned int	tlbiel;	/* tlbiel supported for that page size */
>  	unsigned long	avpnm;	/* bits to mask out in AVPN in the HPTE */
> -	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
> +	union {
> +		unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
> +		unsigned long ap;	/* Ap encoding used by PowerISA 3.0 */
> +	};
>  };
>  extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
>  
> @@ -98,22 +101,34 @@ extern int mmu_vmemmap_psize;
>  extern int mmu_io_psize;
>  
>  /* MMU initialization */
> +extern void radix_init_native(void);
>  extern void hlearly_init_mmu(void);
> +extern void rearly_init_mmu(void);
>  static inline void early_init_mmu(void)
>  {
> +	if (radix_enabled())
> +		return rearly_init_mmu();

rearly sounds like rear-ly, r_early_init_mmu()?

>  	return hlearly_init_mmu();
>  }
>  extern void hlearly_init_mmu_secondary(void);
> +extern void rearly_init_mmu_secondary(void);
>  static inline void early_init_mmu_secondary(void)
>  {
> +	if (radix_enabled())
> +		return rearly_init_mmu_secondary();
>  	return hlearly_init_mmu_secondary();
>  }
>  
>  extern void hlsetup_initial_memory_limit(phys_addr_t first_memblock_base,
>  					 phys_addr_t first_memblock_size);
> +extern void rsetup_initial_memory_limit(phys_addr_t first_memblock_base,
> +					 phys_addr_t first_memblock_size);
>  static inline void setup_initial_memory_limit(phys_addr_t first_memblock_base,
>  					      phys_addr_t first_memblock_size)
>  {
> +	if (radix_enabled())
> +		return rsetup_initial_memory_limit(first_memblock_base,
> +						   first_memblock_size);
>  	return hlsetup_initial_memory_limit(first_memblock_base,
>  					   first_memblock_size);
>  }
> diff --git a/arch/powerpc/include/asm/book3s/64/radix.h b/arch/powerpc/include/asm/book3s/64/radix.h
> index 46a5381324f5..806dc2195f85 100644
> --- a/arch/powerpc/include/asm/book3s/64/radix.h
> +++ b/arch/powerpc/include/asm/book3s/64/radix.h
> @@ -133,5 +133,7 @@ static inline int rpmd_trans_huge(pmd_t pmd)
>  
>  #endif
>  
> +extern int map_radix_kernel_page(unsigned long ea, unsigned long pa,
> +				 pgprot_t flags, unsigned int psz);
>  #endif /* __ASSEMBLY__ */
>  #endif
> diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
> index ef778997daa9..d734934cbb1e 100644
> --- a/arch/powerpc/mm/Makefile
> +++ b/arch/powerpc/mm/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_PPC_BOOK3E)	+= tlb_low_$(CONFIG_WORD_SIZE)e.o
>  hash64-$(CONFIG_PPC_NATIVE)	:= hash_native_64.o
>  obj-$(CONFIG_PPC_BOOK3E_64)   += pgtable-book3e.o
>  obj-$(CONFIG_PPC_STD_MMU_64)	+= pgtable-hash64.o hash_utils_64.o slb_low.o slb.o $(hash64-y)
> +obj-$(CONFIG_PPC_RADIX_MMU)	+= pgtable-radix.o
>  obj-$(CONFIG_PPC_STD_MMU_32)	+= ppc_mmu_32.o hash_low_32.o
>  obj-$(CONFIG_PPC_STD_MMU)	+= tlb_hash$(CONFIG_WORD_SIZE).o \
>  				   mmu_context_hash$(CONFIG_WORD_SIZE).o
> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
> new file mode 100644
> index 000000000000..5737769469b3
> --- /dev/null
> +++ b/arch/powerpc/mm/pgtable-radix.c
> @@ -0,0 +1,344 @@
> +/*
> + * page table handling routines for radix page table
> + *
> + *  Copyright (C) 2015 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> + *
> + *  This program is free software; you can redistribute it and/or
> + *  modify it under the terms of the GNU General Public License
> + *  as published by the Free Software Foundation; either version
> + *  2 of the License, or (at your option) any later version.
> + *
> + */
> +#include <linux/sched.h>
> +#include <linux/memblock.h>
> +#include <linux/of_fdt.h>
> +
> +#include <asm/pgtable.h>
> +#include <asm/pgalloc.h>
> +#include <asm/dma.h>
> +#include <asm/machdep.h>
> +#include <asm/mmu.h>
> +#include <asm/firmware.h>
> +
> +static int native_update_partition_table(u64 patb1)
> +{
> +	partition_tb->patb1 = cpu_to_be64(patb1);
> +	return 0;
> +}
> +
> +static __ref void *early_alloc_pgtable(unsigned long size)
> +{
> +	void *pt;
> +
> +	pt = __va(memblock_alloc_base(size, size, MEMBLOCK_ALLOC_ANYWHERE));
> +	memset(pt, 0, size);
> +
> +	return pt;
> +}
> +
> +int map_radix_kernel_page(unsigned long ea, unsigned long pa,
> +			  pgprot_t flags,
> +			  unsigned int map_page_size)
> +{
> +	pgd_t *pgdp;
> +	pud_t *pudp;
> +	pmd_t *pmdp;
> +	pte_t *ptep;
> +	/*
> +	 * Make sure task size is correct as per the max adddr
> +	 */
> +	BUILD_BUG_ON(TASK_SIZE_USER64 > R_PGTABLE_RANGE);
> +	if (slab_is_available()) {
> +		pgdp = pgd_offset_k(ea);
> +		pudp = pud_alloc(&init_mm, pgdp, ea);
> +		if (!pudp)
> +			return -ENOMEM;
> +		if (map_page_size == PUD_SIZE) {
> +			ptep = (pte_t *)pudp;
> +			goto set_the_pte;
> +		}
> +		pmdp = pmd_alloc(&init_mm, pudp, ea);
> +		if (!pmdp)
> +			return -ENOMEM;
> +		if (map_page_size == PMD_SIZE) {
> +			ptep = (pte_t *)pudp;
> +			goto set_the_pte;
> +		}
> +		ptep = pte_alloc_kernel(pmdp, ea);
> +		if (!ptep)
> +			return -ENOMEM;
> +	} else {
> +		pgdp = pgd_offset_k(ea);
> +		if (pgd_none(*pgdp)) {
> +			pudp = early_alloc_pgtable(PUD_TABLE_SIZE);
> +			BUG_ON(pudp == NULL);
> +			pgd_populate(&init_mm, pgdp, pudp);
> +		}
> +		pudp = pud_offset(pgdp, ea);
> +		if (map_page_size == PUD_SIZE) {
> +			ptep = (pte_t *)pudp;
> +			goto set_the_pte;
> +		}
> +		if (pud_none(*pudp)) {
> +			pmdp = early_alloc_pgtable(PMD_TABLE_SIZE);
> +			BUG_ON(pmdp == NULL);
> +			pud_populate(&init_mm, pudp, pmdp);
> +		}
> +		pmdp = pmd_offset(pudp, ea);
> +		if (map_page_size == PMD_SIZE) {
> +			ptep = (pte_t *)pudp;
> +			goto set_the_pte;
> +		}
> +		if (!pmd_present(*pmdp)) {
> +			ptep = early_alloc_pgtable(PAGE_SIZE);
> +			BUG_ON(ptep == NULL);
> +			pmd_populate_kernel(&init_mm, pmdp, ptep);
> +		}
> +		ptep = pte_offset_kernel(pmdp, ea);
> +	}
> +
> +set_the_pte:
> +	set_pte_at(&init_mm, ea, ptep, pfn_pte(pa >> PAGE_SHIFT, flags));
> +	smp_wmb();

We got ptesync inside set_pte_at, do we need smp_wmb()?

> +	return 0;
> +}
> +
> +static void __init radix_init_pgtable(void)
> +{
> +	int loop_count;
> +	u64 base, end, start_addr;
> +	unsigned long rts_field;
> +	struct memblock_region *reg;
> +	unsigned long linear_page_size;
> +
> +	/* We don't support slb for radix */
> +	mmu_slb_size = 0;
> +	/*
> +	 * Create the linear mapping, using standard page size for now
> +	 */
> +	loop_count = 0;

I would call this page_size_idx

> +	for_each_memblock(memory, reg) {
> +
> +		start_addr = reg->base;
> +
> +redo:
> +		if (loop_count < 1 && mmu_psize_defs[MMU_PAGE_1G].shift)
> +			linear_page_size = PUD_SIZE;
> +		else if (loop_count < 2 && mmu_psize_defs[MMU_PAGE_2M].shift)
> +			linear_page_size = PMD_SIZE;
> +		else
> +			linear_page_size = PAGE_SIZE;
> +
> +		base = _ALIGN_UP(start_addr, linear_page_size);
> +		end = _ALIGN_DOWN(reg->base + reg->size, linear_page_size);
> +
> +		pr_info("Mapping range 0x%lx - 0x%lx with 0x%lx\n",
> +			(unsigned long)base, (unsigned long)end,
> +			linear_page_size);
> +
> +		while (base < end) {
> +			map_radix_kernel_page((unsigned long)__va(base),
> +					      base, PAGE_KERNEL_X,
> +					      linear_page_size);
> +			base += linear_page_size;
> +		}
> +		/*
> +		 * map the rest using lower page size
> +		 */
> +		if (end < reg->base + reg->size) {
> +			start_addr = end;
> +			loop_count++;
> +			goto redo;
> +		}

Can't we do something like nr_count = reg->size / linear_page_size
then map nr_pud_count entries and use nr_remaining = reg->size % linear_page_size
Then repeat by interchaing nr_remaining with nr_count and updating linear_page_size?


> +	}
> +	/*
> +	 * Allocate Partition table and process table for the
> +	 * host.
> +	 */
> +	BUILD_BUG_ON_MSG((PRTB_SIZE_SHIFT > 23), "Process table size too large.");
> +	process_tb = early_alloc_pgtable(1UL << PRTB_SIZE_SHIFT);
> +	/*
> +	 * Fill in the process table.
> +	 * we support 52 bits, hence 52-28 = 24, 11000
> +	 */
> +	rts_field = 3ull << PPC_BITLSHIFT(2);
> +	process_tb->prtb0 = cpu_to_be64(rts_field | __pa(init_mm.pgd) | R_PGD_INDEX_SIZE);
> +	/*
> +	 * Fill in the partition table. We are suppose to use effective address
> +	 * of process table here. But our linear mapping also enable us to use
> +	 * physical address here.
> +	 */
> +	ppc_md.update_partition_table(__pa(process_tb) | (PRTB_SIZE_SHIFT - 12) | PATB_GR);

Is this for guest radix?

> +	pr_info("Process table %p and radix root for kernel: %p\n", process_tb, init_mm.pgd);
> +}
> +
> +static void __init radix_init_partition_table(void)
> +{
> +	unsigned long rts_field;
> +	/*
> +	 * we support 52 bits, hence 52-28 = 24, 11000
> +	 */
> +	rts_field = 3ull << PPC_BITLSHIFT(2);
> +
> +	BUILD_BUG_ON_MSG((PATB_SIZE_SHIFT > 24), "Partition table size too large.");
> +	partition_tb = early_alloc_pgtable(1UL << PATB_SIZE_SHIFT);
> +	partition_tb->patb0 = cpu_to_be64(rts_field | __pa(init_mm.pgd) |
> +					  R_PGD_INDEX_SIZE | PATB_HR);
> +	printk("Partition table %p\n", partition_tb);
> +
> +	memblock_set_current_limit(MEMBLOCK_ALLOC_ANYWHERE);
> +	/*
> +	 * update partition table control register,
> +	 * 64 K size.
> +	 */
> +	mtspr(SPRN_PTCR, __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
> +}
> +
> +void __init radix_init_native(void)
> +{
> +	ppc_md.update_partition_table = native_update_partition_table;
> +}
> +
> +static int __init get_idx_from_shift(unsigned int shift)
> +{
> +	int idx = -1;
> +
> +	switch (shift) {
> +	case 0xc:
> +		idx = MMU_PAGE_4K;
> +		break;
> +	case 0x10:
> +		idx = MMU_PAGE_64K;
> +		break;
> +	case 0x15:
> +		idx = MMU_PAGE_2M;
> +		break;
> +	case 0x1e:
> +		idx = MMU_PAGE_1G;
> +		break;
> +	}
> +	return idx;
> +}
> +
> +static int __init radix_dt_scan_page_sizes(unsigned long node,
> +					   const char *uname, int depth,
> +					   void *data)
> +{
> +	int size = 0;

Assignment is not required, since we get &size in of_get_flat_dt_prop

> +	int shift, idx;
> +	unsigned int ap;
> +	const __be32 *prop;
> +	const char *type = of_get_flat_dt_prop(node, "device_type", NULL);
> +
> +	/* We are scanning "cpu" nodes only */
> +	if (type == NULL || strcmp(type, "cpu") != 0)
> +		return 0;
> +
> +	prop = of_get_flat_dt_prop(node, "ibm,processor-radix-AP-encodings", &size);
> +	if (!prop)
> +		return 0;
> +
> +	pr_info("Page sizes from device-tree:\n");
> +	for (; size >= 4; size -= 4, ++prop) {
> +
> +		struct mmu_psize_def *def;
> +
> +		/* top 3 bit is AP encoding */
> +		shift = be32_to_cpu(prop[0]) & ~(0xe << 28);
> +		ap = be32_to_cpu(prop[0]) >> 29;


Can we get more meaningful names for 4, 0xe, 28, 29?

> +		pr_info("Page size sift = %d AP=0x%x\n", shift, ap);
> +
> +		idx = get_idx_from_shift(shift);
> +		if (idx < 0)
> +			continue;
> +
> +		def = &mmu_psize_defs[idx];
> +		def->shift = shift;
> +		def->ap  = ap;
> +	}
> +
> +	/* needed ? */
> +	cur_cpu_spec->mmu_features &= ~MMU_FTR_NO_SLBIE_B;
> +	return 1;
> +}
> +
> +static void __init radix_init_page_sizes(void)
> +{
> +	int rc;
> +
> +	/*
> +	 * Try to find the available page sizes in the device-tree
> +	 */
> +	rc = of_scan_flat_dt(radix_dt_scan_page_sizes, NULL);
> +	if (rc != 0)  /* Found */
> +		goto found;
> +	/*
> +	 * let's assume we have page 4k and 64k support
> +	 */
> +	mmu_psize_defs[MMU_PAGE_4K].shift = 12;
> +	mmu_psize_defs[MMU_PAGE_4K].ap = 0x0;
> +
> +	mmu_psize_defs[MMU_PAGE_64K].shift = 16;
> +	mmu_psize_defs[MMU_PAGE_64K].ap = 0x5;
> +found:
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +	if (mmu_psize_defs[MMU_PAGE_2M].shift) {
> +		/*
> +		 * map vmemmap using 2M if available
> +		 */
> +		mmu_vmemmap_psize = MMU_PAGE_2M;

Good idea!

> +	}
> +#endif /* CONFIG_SPARSEMEM_VMEMMAP */
> +	return;
> +}
> +
> +void __init rearly_init_mmu(void)
> +{
> +#ifdef CONFIG_PPC_64K_PAGES
> +	/* PAGE_SIZE mappings */
> +	mmu_virtual_psize = MMU_PAGE_64K;
> +#else
> +	mmu_virtual_psize = MMU_PAGE_4K;
> +#endif
> +
> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> +	/* vmemmap mapping */
> +	mmu_vmemmap_psize = mmu_virtual_psize;
> +#endif
> +	/*
> +	 * initialize page table size
> +	 */
> +	__pte_index_size = R_PTE_INDEX_SIZE;
> +	__pmd_index_size = R_PMD_INDEX_SIZE;
> +	__pud_index_size = R_PUD_INDEX_SIZE;
> +	__pgd_index_size = R_PGD_INDEX_SIZE;
> +	__pmd_cache_index = R_PMD_INDEX_SIZE;
> +	__pte_table_size = R_PTE_TABLE_SIZE;
> +	__pmd_table_size = R_PMD_TABLE_SIZE;
> +	__pud_table_size = R_PUD_TABLE_SIZE;
> +	__pgd_table_size = R_PGD_TABLE_SIZE;
> +
> +	radix_init_page_sizes();
> +
> +	if (!firmware_has_feature(FW_FEATURE_LPAR))
> +		radix_init_partition_table();
> +
> +	radix_init_pgtable();
> +}
> +
> +void rearly_init_mmu_secondary(void)
> +{
> +	/*
> +	 * update partition table control register, 64 K size.
> +	 */
> +	if (!firmware_has_feature(FW_FEATURE_LPAR))
> +		mtspr(SPRN_PTCR,
> +		      __pa(partition_tb) | (PATB_SIZE_SHIFT - 12));
> +}
> +
> +void rsetup_initial_memory_limit(phys_addr_t first_memblock_base,
> +				phys_addr_t first_memblock_size)
> +{
> +	/* Finally limit subsequent allocations */
> +	memblock_set_current_limit(first_memblock_base + first_memblock_size);
> +}
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index 1acb0c72d923..ee6430bedcc3 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -273,7 +273,10 @@ static int __init pnv_probe(void)
>  	if (!of_flat_dt_is_compatible(root, "ibm,powernv"))
>  		return 0;
>  
> -	hpte_init_native();
> +	if (IS_ENABLED(CONFIG_PPC_RADIX_MMU) && radix_enabled())
> +		radix_init_native();
> +	else if (IS_ENABLED(CONFIG_PPC_STD_MMU_64))
> +		hpte_init_native();
>  
>  	if (firmware_has_feature(FW_FEATURE_OPAL))
>  		pnv_setup_machdep_opal();
> 

This looks good!

Balbir Singh.
