Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DA4B82C0096
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Sep 2012 15:23:25 +1000 (EST)
Message-ID: <1347254598.11820.3.camel@pasglop>
Subject: Re: [PATCH -V8 0/11] arch/powerpc: Add 64TB support to ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Mon, 10 Sep 2012 15:23:18 +1000
In-Reply-To: <87ipbomp0h.fsf@linux.vnet.ibm.com>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346982235.2385.33.camel@pasglop> <87fw6uoxo3.fsf@linux.vnet.ibm.com>
 <87ipbomp0h.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2012-09-08 at 22:27 +0530, Aneesh Kumar K.V wrote:

 .../...

> slice array size and slice mask size depend on PGTABLE_RANGE. We
> can't directly include pgtable.h in these header because there is
> a circular dependency. So split the pgtable range into a separate
> header and include that
 
Not fan of that pgtable-*-range.h .... I did a quick hack on top of
upstream and it looks like you can get away with something along the
lines of: (fill in the gaps)

index 1c65a59..40f70085 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -16,6 +16,14 @@
 #include <asm/page.h>
 
 /*
+ * This is necessary to get the definition of PGTABLE_RANGE which we
+ * need for various slices related matters. Note that this isn't the
+ * complete pgtable.h but only a portion of it.
+ */
+#include <asm/pgtable-ppc64.h>
+
+
+/*
  * Segment table
  */
 
@@ -371,8 +379,7 @@ extern void slb_set_size(u16 size);
 	addi	rx,rt,1;						\
 	srdi	rx,rx,VSID_BITS_##size;	/* extract 2^VSID_BITS bit */	\
 	add	rt,rt,rx
-
-
+ 
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_PPC_SUBPAGE_PROT
diff --git a/arch/powerpc/include/asm/mmu.h
b/arch/powerpc/include/asm/mmu.h
index e8a26db..0a3692d 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -146,6 +146,16 @@ extern void setup_initial_memory_limit(phys_addr_t
first_memblock_base,
 extern u64 ppc64_rma_size;
 #endif /* CONFIG_PPC64 */
 
+struct mm_struct;
+
+#ifdef CONFIG_DEBUG_VM
+extern void assert_pte_locked(struct mm_struct *mm, unsigned long
addr);
+#else /* CONFIG_DEBUG_VM */
+static inline void assert_pte_locked(struct mm_struct *mm, unsigned
long addr)
+{
+}
+#endif /* !CONFIG_DEBUG_VM */
+
 #endif /* !__ASSEMBLY__ */
 
 /* The kernel use the constants below to index in the page sizes array.
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h
b/arch/powerpc/include/asm/pgtable-ppc64.h
index c420561..2871b00 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -21,17 +21,6 @@
 #define PGTABLE_RANGE (ASM_CONST(1) << PGTABLE_EADDR_SIZE)
 
 
-/* Some sanity checking */
-#if TASK_SIZE_USER64 > PGTABLE_RANGE
-#error TASK_SIZE_USER64 exceeds pagetable range
-#endif
-
-#ifdef CONFIG_PPC_STD_MMU_64
-#if TASK_SIZE_USER64 > (1UL << (USER_ESID_BITS + SID_SHIFT))
-#error TASK_SIZE_USER64 exceeds user VSID range
-#endif
-#endif
-
 /*
  * Define the address range of the kernel non-linear virtual area
  */
@@ -117,9 +106,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/stddef.h>
-#include <asm/tlbflush.h>
-
 /*
  * This is the default implementation of various PTE accessors, it's
  * used in all cases except Book3S with 64K pages where we have a
@@ -200,6 +186,9 @@
 #define pgd_offset_k(address) pgd_offset(&init_mm, address)
 
 
+extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
+			    pte_t *ptep, unsigned long pte, int huge);
+
 /* Atomic PTE updates */
 static inline unsigned long pte_update(struct mm_struct *mm,
 				       unsigned long addr,
diff --git a/arch/powerpc/include/asm/pgtable.h
b/arch/powerpc/include/asm/pgtable.h
index 2e0e411..a9cbd3b 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -9,14 +9,6 @@
 
 struct mm_struct;
 
-#ifdef CONFIG_DEBUG_VM
-extern void assert_pte_locked(struct mm_struct *mm, unsigned long
addr);
-#else /* CONFIG_DEBUG_VM */
-static inline void assert_pte_locked(struct mm_struct *mm, unsigned
long addr)
-{
-}
-#endif /* !CONFIG_DEBUG_VM */
-
 #endif /* !__ASSEMBLY__ */
 
 #if defined(CONFIG_PPC64)
@@ -27,6 +19,8 @@ static inline void assert_pte_locked(struct mm_struct
*mm, unsigned long addr)
 
 #ifndef __ASSEMBLY__
 
+#include <asm/tlbflush.h>
+
 /* Generic accessors to PTE bits */
 static inline int pte_write(pte_t pte)		{ return pte_val(pte) &
_PAGE_RW; }
 static inline int pte_dirty(pte_t pte)		{ return pte_val(pte) &
_PAGE_DIRTY; }
diff --git a/arch/powerpc/include/asm/tlbflush.h
b/arch/powerpc/include/asm/tlbflush.h
index 81143fc..2af6a03 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -103,9 +103,6 @@ DECLARE_PER_CPU(struct ppc64_tlb_batch,
ppc64_tlb_batch);
 
 extern void __flush_tlb_pending(struct ppc64_tlb_batch *batch);
 
-extern void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
-			    pte_t *ptep, unsigned long pte, int huge);
-
 #define __HAVE_ARCH_ENTER_LAZY_MMU_MODE
 
 static inline void arch_enter_lazy_mmu_mode(void)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 44cf2b2..4aa2da5 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -41,6 +41,7 @@
 #include <asm/io.h>
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
+#include <asm/tlbflush.h>
 #include <asm/mmu.h>
 #include <asm/smp.h>
 #include <asm/machdep.h>
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 297d495..411e7a1 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -327,3 +327,15 @@ EXPORT_SYMBOL(__ioremap_at);
 EXPORT_SYMBOL(iounmap);
 EXPORT_SYMBOL(__iounmap);
 EXPORT_SYMBOL(__iounmap_at);
+
+/* Some sanity checking */
+#if TASK_SIZE_USER64 > PGTABLE_RANGE
+#error TASK_SIZE_USER64 exceeds pagetable range
+#endif
+
+#ifdef CONFIG_PPC_STD_MMU_64
+#if TASK_SIZE_USER64 > (1UL << (USER_ESID_BITS + SID_SHIFT))
+#error TASK_SIZE_USER64 exceeds user VSID range
+#endif
+#endif
+
