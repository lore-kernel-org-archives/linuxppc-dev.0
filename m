Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wbMgt59sqzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 00:29:13 +1000 (AEST)
Subject: Re: [PATCH v1 1/8] powerpc/lib/code-patching: Enhance code patching
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 mpe@ellerman.id.au
References: <20170525033650.10891-1-bsingharora@gmail.com>
 <20170525033650.10891-2-bsingharora@gmail.com>
Cc: naveen.n.rao@linux.vnet.ibm.com, ananth@linux.vnet.ibm.com,
 paulus@samba.org, rashmica.g@gmail.com
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <58bd28a3-f9bf-4c27-8f5b-32377f3d5f9f@c-s.fr>
Date: Sun, 28 May 2017 16:29:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170525033650.10891-2-bsingharora@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/05/2017 à 05:36, Balbir Singh a écrit :
> Today our patching happens via direct copy and
> patch_instruction. The patching code is well
> contained in the sense that copying bits are limited.
>
> While considering implementation of CONFIG_STRICT_RWX,
> the first requirement is to a create another mapping
> that will allow for patching. We create the window using
> text_poke_area, allocated via get_vm_area(), which might
> be an overkill. We can do per-cpu stuff as well. The
> downside of these patches that patch_instruction is
> now synchornized using a lock. Other arches do similar
> things, but use fixmaps. The reason for not using
> fixmaps is to make use of any randomization in the
> future. The code also relies on set_pte_at and pte_clear
> to do the appropriate tlb flushing.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

[...]

> +static int kernel_map_addr(void *addr)
> +{
> +	unsigned long pfn;
>  	int err;
>
> -	__put_user_size(instr, addr, 4, err);
> +	if (is_vmalloc_addr(addr))
> +		pfn = vmalloc_to_pfn(addr);
> +	else
> +		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
> +
> +	err = map_kernel_page((unsigned long)text_poke_area->addr,
> +			(pfn << PAGE_SHIFT), _PAGE_KERNEL_RW | _PAGE_PRESENT);

map_kernel_page() doesn't exist on powerpc32, so compilation fails.

However a similar function exists and is called map_page()

Maybe the below modification could help (not tested yet)

Christophe



---
  arch/powerpc/include/asm/book3s/32/pgtable.h | 2 ++
  arch/powerpc/include/asm/nohash/32/pgtable.h | 2 ++
  arch/powerpc/mm/8xx_mmu.c                    | 2 +-
  arch/powerpc/mm/dma-noncoherent.c            | 2 +-
  arch/powerpc/mm/mem.c                        | 4 ++--
  arch/powerpc/mm/mmu_decl.h                   | 1 -
  arch/powerpc/mm/pgtable_32.c                 | 8 ++++----
  7 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h 
b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 26ed228..7fb7558 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -297,6 +297,8 @@ static inline void __ptep_set_access_flags(struct 
mm_struct *mm,
  extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t 
**ptep,
  		      pmd_t **pmdp);

+int map_kernel_page(unsigned long va, phys_addr_t pa, int flags);
+
  /* Generic accessors to PTE bits */
  static inline int pte_write(pte_t pte)		{ return !!(pte_val(pte) & 
_PAGE_RW);}
  static inline int pte_dirty(pte_t pte)		{ return !!(pte_val(pte) & 
_PAGE_DIRTY); }
diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h 
b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 5134ade..9131426 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -340,6 +340,8 @@ static inline void __ptep_set_access_flags(struct 
mm_struct *mm,
  extern int get_pteptr(struct mm_struct *mm, unsigned long addr, pte_t 
**ptep,
  		      pmd_t **pmdp);

+int map_kernel_page(unsigned long va, phys_addr_t pa, int flags);
+
  #endif /* !__ASSEMBLY__ */

  #endif /* __ASM_POWERPC_NOHASH_32_PGTABLE_H */
diff --git a/arch/powerpc/mm/8xx_mmu.c b/arch/powerpc/mm/8xx_mmu.c
index 6c5025e..f4c6472 100644
--- a/arch/powerpc/mm/8xx_mmu.c
+++ b/arch/powerpc/mm/8xx_mmu.c
@@ -88,7 +88,7 @@ static void mmu_mapin_immr(void)
  	int offset;

  	for (offset = 0; offset < IMMR_SIZE; offset += PAGE_SIZE)
-		map_page(v + offset, p + offset, f);
+		map_kernel_page(v + offset, p + offset, f);
  }

  /* Address of instructions to patch */
diff --git a/arch/powerpc/mm/dma-noncoherent.c 
b/arch/powerpc/mm/dma-noncoherent.c
index 2dc74e5..3825284 100644
--- a/arch/powerpc/mm/dma-noncoherent.c
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -227,7 +227,7 @@ __dma_alloc_coherent(struct device *dev, size_t 
size, dma_addr_t *handle, gfp_t

  		do {
  			SetPageReserved(page);
-			map_page(vaddr, page_to_phys(page),
+			map_kernel_page(vaddr, page_to_phys(page),
  				 pgprot_val(pgprot_noncached(PAGE_KERNEL)));
  			page++;
  			vaddr += PAGE_SIZE;
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 9ee536e..04f4c98 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -313,11 +313,11 @@ void __init paging_init(void)
  	unsigned long end = __fix_to_virt(FIX_HOLE);

  	for (; v < end; v += PAGE_SIZE)
-		map_page(v, 0, 0); /* XXX gross */
+		map_kernel_page(v, 0, 0); /* XXX gross */
  #endif

  #ifdef CONFIG_HIGHMEM
-	map_page(PKMAP_BASE, 0, 0);	/* XXX gross */
+	map_kernel_page(PKMAP_BASE, 0, 0);	/* XXX gross */
  	pkmap_page_table = virt_to_kpte(PKMAP_BASE);

  	kmap_pte = virt_to_kpte(__fix_to_virt(FIX_KMAP_BEGIN));
diff --git a/arch/powerpc/mm/mmu_decl.h b/arch/powerpc/mm/mmu_decl.h
index f988db6..d46128b 100644
--- a/arch/powerpc/mm/mmu_decl.h
+++ b/arch/powerpc/mm/mmu_decl.h
@@ -94,7 +94,6 @@ extern void _tlbia(void);
  #ifdef CONFIG_PPC32

  extern void mapin_ram(void);
-extern int map_page(unsigned long va, phys_addr_t pa, int flags);
  extern void setbat(int index, unsigned long virt, phys_addr_t phys,
  		   unsigned int size, pgprot_t prot);

diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index a65c0b4..9c23c09 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -189,7 +189,7 @@ __ioremap_caller(phys_addr_t addr, unsigned long 
size, unsigned long flags,

  	err = 0;
  	for (i = 0; i < size && err == 0; i += PAGE_SIZE)
-		err = map_page(v+i, p+i, flags);
+		err = map_kernel_page(v+i, p+i, flags);
  	if (err) {
  		if (slab_is_available())
  			vunmap((void *)v);
@@ -215,7 +215,7 @@ void iounmap(volatile void __iomem *addr)
  }
  EXPORT_SYMBOL(iounmap);

-int map_page(unsigned long va, phys_addr_t pa, int flags)
+int map_kernel_page(unsigned long va, phys_addr_t pa, int flags)
  {
  	pmd_t *pd;
  	pte_t *pg;
@@ -255,7 +255,7 @@ void __init __mapin_ram_chunk(unsigned long offset, 
unsigned long top)
  		ktext = ((char *)v >= _stext && (char *)v < etext) ||
  			((char *)v >= _sinittext && (char *)v < _einittext);
  		f = ktext ? pgprot_val(PAGE_KERNEL_TEXT) : pgprot_val(PAGE_KERNEL);
-		map_page(v, p, f);
+		map_kernel_page(v, p, f);
  #ifdef CONFIG_PPC_STD_MMU_32
  		if (ktext)
  			hash_preload(&init_mm, v, 0, 0x300);
@@ -387,7 +387,7 @@ void __set_fixmap (enum fixed_addresses idx, 
phys_addr_t phys, pgprot_t flags)
  		return;
  	}

-	map_page(address, phys, pgprot_val(flags));
+	map_kernel_page(address, phys, pgprot_val(flags));
  	fixmaps++;
  }

-- 
2.2.2

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
