Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17550.13189.138219.808074@cargo.ozlabs.ibm.com>
Date: Tue, 13 Jun 2006 13:39:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Use 64k pages without needing cache-inhibited large pages
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some POWER5+ machines can do 64k hardware pages for normal memory but
not for cache-inhibited pages.  This patch lets us use 64k hardware
pages for most user processes on such machines (assuming the kernel
has been configured with CONFIG_PPC_64K_PAGES=y).  User processes
start out using 64k pages and get switched to 4k pages if they use any
non-cacheable mappings.

With this, we use 64k pages for the vmalloc region and 4k pages for
the imalloc region.  If anything creates a non-cacheable mapping in
the vmalloc region, the vmalloc region will get switched to 4k pages.
I don't know of any driver other than the DRM that would do this,
though, and these machines don't have AGP.

When a region gets switched from 64k pages to 4k pages, we do not have
to clear out all the 64k HPTEs from the hash table immediately.  We
use the _PAGE_COMBO bit in the Linux PTE to indicate whether the page
was hashed in as a 64k page or a set of 4k pages.  If hash_page is
trying to insert a 4k page for a Linux PTE and it sees that it has
already been inserted as a 64k page, it first invalidates the 64k HPTE
before inserting the 4k HPTE.  The hash invalidation routines also use
the _PAGE_COMBO bit, to determine whether to look for a 64k HPTE or a
set of 4k HPTEs to remove.  With those two changes, we can tolerate a
mix of 4k and 64k HPTEs in the hash table, and they will all get
removed when the address space is torn down.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index aa0486d..ff29405 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -122,6 +122,8 @@ #ifdef CONFIG_PPC64
 	DEFINE(PACASLBCACHE, offsetof(struct paca_struct, slb_cache));
 	DEFINE(PACASLBCACHEPTR, offsetof(struct paca_struct, slb_cache_ptr));
 	DEFINE(PACACONTEXTID, offsetof(struct paca_struct, context.id));
+	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, context.sllp));
+	DEFINE(PACAVMALLOCSLLP, offsetof(struct paca_struct, vmalloc_sllp));
 #ifdef CONFIG_HUGETLB_PAGE
 	DEFINE(PACALOWHTLBAREAS, offsetof(struct paca_struct, context.low_htlb_areas));
 	DEFINE(PACAHIGHHTLBAREAS, offsetof(struct paca_struct, context.high_htlb_areas));
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 969f4ab..d77d24a 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -948,7 +948,10 @@ static struct ibm_pa_feature {
 	{CPU_FTR_CTRL, 0,		0, 3, 0},
 	{CPU_FTR_NOEXECUTE, 0,		0, 6, 0},
 	{CPU_FTR_NODSISRALIGN, 0,	1, 1, 1},
+#if 0
+	/* put this back once we know how to test if firmware does 64k IO */
 	{CPU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
+#endif
 };
 
 static void __init check_cpu_pa_features(unsigned long node)
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 106fba3..52e9142 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -369,6 +369,7 @@ _GLOBAL(__hash_page_4K)
 	rlwinm	r30,r4,32-9+7,31-7,31-7	/* _PAGE_RW -> _PAGE_DIRTY */
 	or	r30,r30,r31
 	ori	r30,r30,_PAGE_BUSY | _PAGE_ACCESSED | _PAGE_HASHPTE
+	oris	r30,r30,_PAGE_COMBO@h
 	/* Write the linux PTE atomically (setting busy) */
 	stdcx.	r30,0,r6
 	bne-	1b
@@ -428,6 +429,14 @@ END_FTR_SECTION(CPU_FTR_NOEXECUTE|CPU_FT
 	andi.	r0,r31,_PAGE_HASHPTE
 	li	r26,0			/* Default hidx */
 	beq	htab_insert_pte
+
+	/*
+	 * Check if the pte was already inserted into the hash table
+	 * as a 64k HW page, and invalidate the 64k HPTE if so.
+	 */
+	andis.	r0,r31,_PAGE_COMBO@h
+	beq	htab_inval_old_hpte
+
 	ld	r6,STK_PARM(r6)(r1)
 	ori	r26,r6,0x8000		/* Load the hidx mask */
 	ld	r26,0(r26)
@@ -498,6 +507,19 @@ _GLOBAL(htab_call_hpte_remove)
 	/* Try all again */
 	b	htab_insert_pte
 
+	/*
+	 * Call out to C code to invalidate an 64k HW HPTE that is
+	 * useless now that the segment has been switched to 4k pages.
+	 */
+htab_inval_old_hpte:
+	mr	r3,r29			/* virtual addr */
+	mr	r4,r31			/* PTE.pte */
+	li	r5,0			/* PTE.hidx */
+	li	r6,MMU_PAGE_64K		/* psize */
+	ld	r7,STK_PARM(r8)(r1)	/* local */
+	bl	.flush_hash_page
+	b	htab_insert_pte
+	
 htab_bail_ok:
 	li	r3,0
 	b	htab_bail
@@ -638,6 +660,12 @@ _GLOBAL(__hash_page_64K)
 	 * is changing this PTE anyway and might hash it.
 	 */
 	bne-	ht64_bail_ok
+BEGIN_FTR_SECTION
+	/* Check if PTE has the cache-inhibit bit set */
+	andi.	r0,r31,_PAGE_NO_CACHE
+	/* If so, bail out and refault as a 4k page */
+	bne-	ht64_bail_ok
+END_FTR_SECTION_IFCLR(CPU_FTR_CI_LARGE_PAGE)
 	/* Prepare new PTE value (turn access RW into DIRTY, then
 	 * add BUSY,HASHPTE and ACCESSED)
 	 */
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index b43ed92..d03fd2b 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -92,10 +92,15 @@ unsigned long htab_size_bytes;
 unsigned long htab_hash_mask;
 int mmu_linear_psize = MMU_PAGE_4K;
 int mmu_virtual_psize = MMU_PAGE_4K;
+int mmu_vmalloc_psize = MMU_PAGE_4K;
+int mmu_io_psize = MMU_PAGE_4K;
 #ifdef CONFIG_HUGETLB_PAGE
 int mmu_huge_psize = MMU_PAGE_16M;
 unsigned int HPAGE_SHIFT;
 #endif
+#ifdef CONFIG_PPC_64K_PAGES
+int mmu_ci_restrictions;
+#endif
 
 /* There are definitions of page sizes arrays to be used when none
  * is provided by the firmware.
@@ -308,20 +313,31 @@ static void __init htab_init_page_sizes(
 	else if (mmu_psize_defs[MMU_PAGE_1M].shift)
 		mmu_linear_psize = MMU_PAGE_1M;
 
+#ifdef CONFIG_PPC_64K_PAGES
 	/*
 	 * Pick a size for the ordinary pages. Default is 4K, we support
-	 * 64K if cache inhibited large pages are supported by the
-	 * processor
+	 * 64K for user mappings and vmalloc if supported by the processor.
+	 * We only use 64k for ioremap if the processor
+	 * (and firmware) support cache-inhibited large pages.
+	 * If not, we use 4k and set mmu_ci_restrictions so that
+	 * hash_page knows to switch processes that use cache-inhibited
+	 * mappings to 4k pages.
 	 */
-#ifdef CONFIG_PPC_64K_PAGES
-	if (mmu_psize_defs[MMU_PAGE_64K].shift &&
-	    cpu_has_feature(CPU_FTR_CI_LARGE_PAGE))
+	if (mmu_psize_defs[MMU_PAGE_64K].shift) {
 		mmu_virtual_psize = MMU_PAGE_64K;
+		mmu_vmalloc_psize = MMU_PAGE_64K;
+		if (cpu_has_feature(CPU_FTR_CI_LARGE_PAGE))
+			mmu_io_psize = MMU_PAGE_64K;
+		else
+			mmu_ci_restrictions = 1;
+	}
 #endif
 
-	printk(KERN_DEBUG "Page orders: linear mapping = %d, others = %d\n",
+	printk(KERN_DEBUG "Page orders: linear mapping = %d, "
+	       "virtual = %d, io = %d\n",
 	       mmu_psize_defs[mmu_linear_psize].shift,
-	       mmu_psize_defs[mmu_virtual_psize].shift);
+	       mmu_psize_defs[mmu_virtual_psize].shift,
+	       mmu_psize_defs[mmu_io_psize].shift);
 
 #ifdef CONFIG_HUGETLB_PAGE
 	/* Init large page size. Currently, we pick 16M or 1M depending
@@ -556,6 +572,7 @@ int hash_page(unsigned long ea, unsigned
 	pte_t *ptep;
 	cpumask_t tmp;
 	int rc, user_region = 0, local = 0;
+	int psize;
 
 	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
 		ea, access, trap);
@@ -575,10 +592,15 @@ int hash_page(unsigned long ea, unsigned
 			return 1;
 		}
 		vsid = get_vsid(mm->context.id, ea);
+		psize = mm->context.user_psize;
 		break;
 	case VMALLOC_REGION_ID:
 		mm = &init_mm;
 		vsid = get_kernel_vsid(ea);
+		if (ea < VMALLOC_END)
+			psize = mmu_vmalloc_psize;
+		else
+			psize = mmu_io_psize;
 		break;
 	default:
 		/* Not a valid range
@@ -629,7 +651,40 @@ #endif
 #ifndef CONFIG_PPC_64K_PAGES
 	rc = __hash_page_4K(ea, access, vsid, ptep, trap, local);
 #else
-	if (mmu_virtual_psize == MMU_PAGE_64K)
+	if (mmu_ci_restrictions) {
+		/* If this PTE is non-cacheable, switch to 4k */
+		if (psize == MMU_PAGE_64K &&
+		    (pte_val(*ptep) & _PAGE_NO_CACHE)) {
+			if (user_region) {
+				psize = MMU_PAGE_4K;
+				mm->context.user_psize = MMU_PAGE_4K;
+				mm->context.sllp = SLB_VSID_USER |
+					mmu_psize_defs[MMU_PAGE_4K].sllp;
+			} else if (ea < VMALLOC_END) {
+				/*
+				 * some driver did a non-cacheable mapping
+				 * in vmalloc space, so switch vmalloc
+				 * to 4k pages
+				 */
+				printk(KERN_ALERT "Reducing vmalloc segment "
+				       "to 4kB pages because of "
+				       "non-cacheable mapping\n");
+				psize = mmu_vmalloc_psize = MMU_PAGE_4K;
+			}
+		}
+		if (user_region) {
+			if (psize != get_paca()->context.user_psize) {
+				get_paca()->context = mm->context;
+				slb_flush_and_rebolt();
+			}
+		} else if (get_paca()->vmalloc_sllp !=
+			   mmu_psize_defs[mmu_vmalloc_psize].sllp) {
+			get_paca()->vmalloc_sllp =
+				mmu_psize_defs[mmu_vmalloc_psize].sllp;
+			slb_flush_and_rebolt();
+		}
+	}
+	if (psize == MMU_PAGE_64K)
 		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local);
 	else
 		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local);
@@ -681,7 +736,18 @@ void hash_preload(struct mm_struct *mm, 
 #ifndef CONFIG_PPC_64K_PAGES
 	__hash_page_4K(ea, access, vsid, ptep, trap, local);
 #else
-	if (mmu_virtual_psize == MMU_PAGE_64K)
+	if (mmu_ci_restrictions) {
+		/* If this PTE is non-cacheable, switch to 4k */
+		if (mm->context.user_psize == MMU_PAGE_64K &&
+		    (pte_val(*ptep) & _PAGE_NO_CACHE)) {
+			mm->context.user_psize = MMU_PAGE_4K;
+			mm->context.sllp = SLB_VSID_USER |
+				mmu_psize_defs[MMU_PAGE_4K].sllp;
+			get_paca()->context = mm->context;
+			slb_flush_and_rebolt();
+		}
+	}
+	if (mm->context.user_psize == MMU_PAGE_64K)
 		__hash_page_64K(ea, access, vsid, ptep, trap, local);
 	else
 		__hash_page_4K(ea, access, vsid, ptep, trap, local);
diff --git a/arch/powerpc/mm/mmu_context_64.c b/arch/powerpc/mm/mmu_context_64.c
index 714a84d..65d18dc 100644
--- a/arch/powerpc/mm/mmu_context_64.c
+++ b/arch/powerpc/mm/mmu_context_64.c
@@ -49,6 +49,9 @@ again:
 	}
 
 	mm->context.id = index;
+	mm->context.user_psize = mmu_virtual_psize;
+	mm->context.sllp = SLB_VSID_USER |
+		mmu_psize_defs[mmu_virtual_psize].sllp;
 
 	return 0;
 }
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 2cc6173..6a8bf6c 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -60,19 +60,19 @@ static inline void create_slbe(unsigned 
 		     : "memory" );
 }
 
-static void slb_flush_and_rebolt(void)
+void slb_flush_and_rebolt(void)
 {
 	/* If you change this make sure you change SLB_NUM_BOLTED
 	 * appropriately too. */
-	unsigned long linear_llp, virtual_llp, lflags, vflags;
+	unsigned long linear_llp, vmalloc_llp, lflags, vflags;
 	unsigned long ksp_esid_data;
 
 	WARN_ON(!irqs_disabled());
 
 	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
-	virtual_llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+	vmalloc_llp = mmu_psize_defs[mmu_vmalloc_psize].sllp;
 	lflags = SLB_VSID_KERNEL | linear_llp;
-	vflags = SLB_VSID_KERNEL | virtual_llp;
+	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
 	ksp_esid_data = mk_esid_data(get_paca()->kstack, 2);
 	if ((ksp_esid_data & ESID_MASK) == PAGE_OFFSET)
@@ -164,11 +164,10 @@ static inline void patch_slb_encoding(un
 
 void slb_initialize(void)
 {
-	unsigned long linear_llp, virtual_llp;
+	unsigned long linear_llp, vmalloc_llp, io_llp;
 	static int slb_encoding_inited;
 	extern unsigned int *slb_miss_kernel_load_linear;
-	extern unsigned int *slb_miss_kernel_load_virtual;
-	extern unsigned int *slb_miss_user_load_normal;
+	extern unsigned int *slb_miss_kernel_load_io;
 #ifdef CONFIG_HUGETLB_PAGE
 	extern unsigned int *slb_miss_user_load_huge;
 	unsigned long huge_llp;
@@ -178,18 +177,19 @@ #endif
 
 	/* Prepare our SLB miss handler based on our page size */
 	linear_llp = mmu_psize_defs[mmu_linear_psize].sllp;
-	virtual_llp = mmu_psize_defs[mmu_virtual_psize].sllp;
+	io_llp = mmu_psize_defs[mmu_io_psize].sllp;
+	vmalloc_llp = mmu_psize_defs[mmu_vmalloc_psize].sllp;
+	get_paca()->vmalloc_sllp = SLB_VSID_KERNEL | vmalloc_llp;
+
 	if (!slb_encoding_inited) {
 		slb_encoding_inited = 1;
 		patch_slb_encoding(slb_miss_kernel_load_linear,
 				   SLB_VSID_KERNEL | linear_llp);
-		patch_slb_encoding(slb_miss_kernel_load_virtual,
-				   SLB_VSID_KERNEL | virtual_llp);
-		patch_slb_encoding(slb_miss_user_load_normal,
-				   SLB_VSID_USER | virtual_llp);
+		patch_slb_encoding(slb_miss_kernel_load_io,
+				   SLB_VSID_KERNEL | io_llp);
 
 		DBG("SLB: linear  LLP = %04x\n", linear_llp);
-		DBG("SLB: virtual LLP = %04x\n", virtual_llp);
+		DBG("SLB: io      LLP = %04x\n", io_llp);
 #ifdef CONFIG_HUGETLB_PAGE
 		patch_slb_encoding(slb_miss_user_load_huge,
 				   SLB_VSID_USER | huge_llp);
@@ -204,7 +204,7 @@ #ifndef CONFIG_PPC_ISERIES
 	unsigned long lflags, vflags;
 
 	lflags = SLB_VSID_KERNEL | linear_llp;
-	vflags = SLB_VSID_KERNEL | virtual_llp;
+	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
 	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
 	asm volatile("isync":::"memory");
@@ -212,7 +212,6 @@ #ifndef CONFIG_PPC_ISERIES
 	asm volatile("isync; slbia; isync":::"memory");
 	create_slbe(PAGE_OFFSET, lflags, 0);
 
-	/* VMALLOC space has 4K pages always for now */
 	create_slbe(VMALLOC_START, vflags, 1);
 
 	/* We don't bolt the stack for the time being - we're in boot,
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index abfaabf..8548dcf 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -59,10 +59,19 @@ _GLOBAL(slb_miss_kernel_load_linear)
 	li	r11,0
 	b	slb_finish_load
 
-1:	/* vmalloc/ioremap mapping encoding bits, the "li" instruction below
+1:	/* vmalloc/ioremap mapping encoding bits, the "li" instructions below
 	 * will be patched by the kernel at boot
 	 */
-_GLOBAL(slb_miss_kernel_load_virtual)
+BEGIN_FTR_SECTION
+	/* check whether this is in vmalloc or ioremap space */
+	clrldi	r11,r10,48
+	cmpldi	r11,(VMALLOC_SIZE >> 28) - 1
+	bgt	5f
+	lhz	r11,PACAVMALLOCSLLP(r13)
+	b	slb_finish_load
+5:
+END_FTR_SECTION_IFCLR(CPU_FTR_CI_LARGE_PAGE)
+_GLOBAL(slb_miss_kernel_load_io)
 	li	r11,0
 	b	slb_finish_load
 
@@ -96,9 +105,7 @@ _GLOBAL(slb_miss_user_load_huge)
 1:
 #endif /* CONFIG_HUGETLB_PAGE */
 
-_GLOBAL(slb_miss_user_load_normal)
-	li	r11,0
-
+	lhz	r11,PACACONTEXTSLLP(r13)
 2:
 	ld	r9,PACACONTEXTID(r13)
 	rldimi	r10,r9,USER_ESID_BITS,0
diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
diff --git a/arch/powerpc/mm/tlb_64.c b/arch/powerpc/mm/tlb_64.c
index f734b11..4bcfd45 100644
--- a/arch/powerpc/mm/tlb_64.c
+++ b/arch/powerpc/mm/tlb_64.c
@@ -131,7 +131,7 @@ void hpte_update(struct mm_struct *mm, u
 {
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
 	unsigned long vsid;
-	unsigned int psize = mmu_virtual_psize;
+	unsigned int psize;
 	int i;
 
 	i = batch->index;
@@ -148,7 +148,8 @@ #ifdef CONFIG_HUGETLB_PAGE
 #else
 		BUG();
 #endif
-	}
+	} else
+		psize = (pte & _PAGE_COMBO)? MMU_PAGE_4K: MMU_PAGE_64K;
 
 	/*
 	 * This can happen when we are in the middle of a TLB batch and
diff --git a/include/asm-powerpc/mmu.h b/include/asm-powerpc/mmu.h
index 8853974..3a5ebe2 100644
--- a/include/asm-powerpc/mmu.h
+++ b/include/asm-powerpc/mmu.h
@@ -165,6 +165,16 @@ #ifndef __ASSEMBLY__
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 extern int mmu_linear_psize;
 extern int mmu_virtual_psize;
+extern int mmu_vmalloc_psize;
+extern int mmu_io_psize;
+
+/*
+ * If the processor supports 64k normal pages but not 64k cache
+ * inhibited pages, we have to be prepared to switch processes
+ * to use 4k pages when they create cache-inhibited mappings.
+ * If this is the case, mmu_ci_restrictions will be set to 1.
+ */
+extern int mmu_ci_restrictions;
 
 #ifdef CONFIG_HUGETLB_PAGE
 /*
@@ -256,6 +266,7 @@ extern long iSeries_hpte_insert(unsigned
 
 extern void stabs_alloc(void);
 extern void slb_initialize(void);
+extern void slb_flush_and_rebolt(void);
 extern void stab_initialize(unsigned long stab);
 
 #endif /* __ASSEMBLY__ */
@@ -359,6 +370,8 @@ typedef unsigned long mm_context_id_t;
 
 typedef struct {
 	mm_context_id_t id;
+	u16 user_psize;			/* page size index */
+	u16 sllp;			/* SLB entry page size encoding */
 #ifdef CONFIG_HUGETLB_PAGE
 	u16 low_htlb_areas, high_htlb_areas;
 #endif
diff --git a/include/asm-powerpc/mmu_context.h b/include/asm-powerpc/mmu_context.h
diff --git a/include/asm-powerpc/paca.h b/include/asm-powerpc/paca.h
index c17fd54..1740635 100644
--- a/include/asm-powerpc/paca.h
+++ b/include/asm-powerpc/paca.h
@@ -81,6 +81,7 @@ #endif /* CONFIG_PPC_ISERIES */
  				 * on the linear mapping */
 
 	mm_context_t context;
+	u16 vmalloc_sllp;
 	u16 slb_cache[SLB_CACHE_ENTRIES];
 	u16 slb_cache_ptr;
 
diff --git a/include/asm-powerpc/pgtable.h b/include/asm-powerpc/pgtable.h
index e9f1f46..260a0fa 100644
--- a/include/asm-powerpc/pgtable.h
+++ b/include/asm-powerpc/pgtable.h
@@ -47,8 +47,8 @@ #endif
 /*
  * Define the address range of the vmalloc VM area.
  */
-#define VMALLOC_START (0xD000000000000000ul)
-#define VMALLOC_SIZE  (0x80000000000UL)
+#define VMALLOC_START ASM_CONST(0xD000000000000000)
+#define VMALLOC_SIZE  ASM_CONST(0x80000000000)
 #define VMALLOC_END   (VMALLOC_START + VMALLOC_SIZE)
 
 /*
@@ -413,12 +413,6 @@ static inline void set_pte_at(struct mm_
 		flush_tlb_pending();
 	}
 	pte = __pte(pte_val(pte) & ~_PAGE_HPTEFLAGS);
-
-#ifdef CONFIG_PPC_64K_PAGES
-	if (mmu_virtual_psize != MMU_PAGE_64K)
-		pte = __pte(pte_val(pte) | _PAGE_COMBO);
-#endif /* CONFIG_PPC_64K_PAGES */
-
 	*ptep = pte;
 }
 
