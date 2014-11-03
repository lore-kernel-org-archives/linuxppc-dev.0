Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 638011A04D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 01:52:20 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 4 Nov 2014 00:52:19 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 0FF052BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Nov 2014 01:52:15 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sA3EqDWl42860718
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Nov 2014 01:52:13 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sA3EqEGG006126
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Nov 2014 01:52:14 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 2/2] powerpc/mm: don't do tlbie for updatepp request with NO
 HPTE fault
Date: Mon,  3 Nov 2014 20:21:35 +0530
Message-Id: <1415026295-25965-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1415026295-25965-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1415026295-25965-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

upatepp get called for a nohpte fault, when we find from the linux
page table that the translation was hashed before. In that case
we are sure that there is no existing translation, hence we could
avoid doing tlbie.

Performance number:
We use randbox_access_bench written by Anton.

Kernel with THP disabled and smaller hash page table size.

    86.60%  random_access_b  [kernel.kallsyms]                [k] .native_hpte_updatepp
     2.10%  random_access_b  random_access_bench              [.] doit
     1.99%  random_access_b  [kernel.kallsyms]                [k] .do_raw_spin_lock
     1.85%  random_access_b  [kernel.kallsyms]                [k] .native_hpte_insert
     1.26%  random_access_b  [kernel.kallsyms]                [k] .native_flush_hash_range
     1.18%  random_access_b  [kernel.kallsyms]                [k] .__delay
     0.69%  random_access_b  [kernel.kallsyms]                [k] .native_hpte_remove
     0.37%  random_access_b  [kernel.kallsyms]                [k] .clear_user_page
     0.34%  random_access_b  [kernel.kallsyms]                [k] .__hash_page_64K
     0.32%  random_access_b  [kernel.kallsyms]                [k] fast_exception_return
     0.30%  random_access_b  [kernel.kallsyms]                [k] .hash_page_mm

With Fix:

    27.54%  random_access_b  random_access_bench              [.] doit
    22.90%  random_access_b  [kernel.kallsyms]                [k] .native_hpte_insert
     5.76%  random_access_b  [kernel.kallsyms]                [k] .native_hpte_remove
     5.20%  random_access_b  [kernel.kallsyms]                [k] fast_exception_return
     5.12%  random_access_b  [kernel.kallsyms]                [k] .__hash_page_64K
     4.80%  random_access_b  [kernel.kallsyms]                [k] .hash_page_mm
     3.31%  random_access_b  [kernel.kallsyms]                [k] data_access_common
     1.84%  random_access_b  [kernel.kallsyms]                [k] .trace_hardirqs_on_caller

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/machdep.h        |  2 +-
 arch/powerpc/include/asm/mmu-hash64.h     | 22 ++++++++++-------
 arch/powerpc/include/asm/tlbflush.h       |  2 +-
 arch/powerpc/kernel/exceptions-64s.S      |  2 ++
 arch/powerpc/mm/hash_low_64.S             | 15 ++++++------
 arch/powerpc/mm/hash_native_64.c          | 15 ++++++++----
 arch/powerpc/mm/hash_utils_64.c           | 40 +++++++++++++++++++------------
 arch/powerpc/mm/hugepage-hash64.c         |  6 ++---
 arch/powerpc/mm/hugetlbpage-hash64.c      |  6 ++---
 arch/powerpc/platforms/cell/beat_htab.c   |  4 ++--
 arch/powerpc/platforms/cell/spu_base.c    |  5 ++--
 arch/powerpc/platforms/cell/spufs/fault.c |  2 +-
 arch/powerpc/platforms/ps3/htab.c         |  2 +-
 arch/powerpc/platforms/pseries/lpar.c     |  2 +-
 drivers/misc/cxl/fault.c                  |  8 +++++--
 15 files changed, 82 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 307347f8ddbd..7b44bdf0c313 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -42,7 +42,7 @@ struct machdep_calls {
 					 unsigned long newpp, 
 					 unsigned long vpn,
 					 int bpsize, int apsize,
-					 int ssize, int local);
+					 int ssize, unsigned long flags);
 	void            (*hpte_updateboltedpp)(unsigned long newpp, 
 					       unsigned long ea,
 					       int psize, int ssize);
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index aeebc94b2bce..4f13c3ed7acf 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -316,27 +316,33 @@ static inline unsigned long hpt_hash(unsigned long vpn,
 	return hash & 0x7fffffffffUL;
 }
 
+#define HPTE_LOCAL_UPDATE	0x1
+#define HPTE_NOHPTE_UPDATE	0x2
+
 extern int __hash_page_4K(unsigned long ea, unsigned long access,
 			  unsigned long vsid, pte_t *ptep, unsigned long trap,
-			  unsigned int local, int ssize, int subpage_prot);
+			  unsigned long flags, int ssize, int subpage_prot);
 extern int __hash_page_64K(unsigned long ea, unsigned long access,
 			   unsigned long vsid, pte_t *ptep, unsigned long trap,
-			   unsigned int local, int ssize);
+			   unsigned long flags, int ssize);
 struct mm_struct;
 unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int trap);
-extern int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, unsigned long trap);
-extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap);
+extern int hash_page_mm(struct mm_struct *mm, unsigned long ea,
+			unsigned long access, unsigned long trap,
+			unsigned long flags);
+extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
+		     unsigned long dsisr);
 int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
-		     pte_t *ptep, unsigned long trap, int local, int ssize,
-		     unsigned int shift, unsigned int mmu_psize);
+		     pte_t *ptep, unsigned long trap, unsigned long flags,
+		     int ssize, unsigned int shift, unsigned int mmu_psize);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern int __hash_page_thp(unsigned long ea, unsigned long access,
 			   unsigned long vsid, pmd_t *pmdp, unsigned long trap,
-			   int local, int ssize, unsigned int psize);
+			   unsigned long flags, int ssize, unsigned int psize);
 #else
 static inline int __hash_page_thp(unsigned long ea, unsigned long access,
 				  unsigned long vsid, pmd_t *pmdp,
-				  unsigned long trap, int local,
+				  unsigned long trap, unsigned long flags,
 				  int ssize, unsigned int psize)
 {
 	BUG();
diff --git a/arch/powerpc/include/asm/tlbflush.h b/arch/powerpc/include/asm/tlbflush.h
index 2def01ed0cb2..2f9862ac8d0e 100644
--- a/arch/powerpc/include/asm/tlbflush.h
+++ b/arch/powerpc/include/asm/tlbflush.h
@@ -125,7 +125,7 @@ static inline void arch_leave_lazy_mmu_mode(void)
 
 
 extern void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize,
-			    int ssize, int local);
+			    int ssize, unsigned long flags);
 extern void flush_hash_range(unsigned long number, int local);
 
 
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 72e783ea0681..2366e9d918a2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1571,9 +1571,11 @@ do_hash_page:
 	 * r3 contains the faulting address
 	 * r4 contains the required access permissions
 	 * r5 contains the trap number
+	 * r6 contains dsisr
 	 *
 	 * at return r3 = 0 for success, 1 for page fault, negative for error
 	 */
+	ld      r6,_DSISR(r1)
 	bl	hash_page		/* build HPTE if possible */
 	cmpdi	r3,0			/* see if hash_page succeeded */
 
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 057cbbb4c576..fc5ce0926204 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -46,7 +46,8 @@
 
 /*
  * _hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
- *		 pte_t *ptep, unsigned long trap, int local, int ssize)
+ *		 pte_t *ptep, unsigned long trap, unsigned long flags,
+ *		 int ssize)
  *
  * Adds a 4K page to the hash table in a segment of 4K pages only
  */
@@ -298,7 +299,7 @@ htab_modify_pte:
 	li	r6,MMU_PAGE_4K		/* base page size */
 	li	r7,MMU_PAGE_4K		/* actual page size */
 	ld	r8,STK_PARAM(R9)(r1)	/* segment size */
-	ld	r9,STK_PARAM(R8)(r1)	/* get "local" param */
+	ld	r9,STK_PARAM(R8)(r1)	/* get "flags" param */
 .globl htab_call_hpte_updatepp
 htab_call_hpte_updatepp:
 	bl	.			/* Patched by htab_finish_init() */
@@ -338,8 +339,8 @@ htab_pte_insert_failure:
  *****************************************************************************/
 
 /* _hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
- *		 pte_t *ptep, unsigned long trap, int local, int ssize,
- *		 int subpg_prot)
+ *		 pte_t *ptep, unsigned long trap, unsigned local flags,
+ *		 int ssize, int subpg_prot)
  */
 
 /*
@@ -594,7 +595,7 @@ htab_inval_old_hpte:
 	li	r5,0			/* PTE.hidx */
 	li	r6,MMU_PAGE_64K		/* psize */
 	ld	r7,STK_PARAM(R9)(r1)	/* ssize */
-	ld	r8,STK_PARAM(R8)(r1)	/* local */
+	ld	r8,STK_PARAM(R8)(r1)	/* flags */
 	bl	flush_hash_page
 	/* Clear out _PAGE_HPTE_SUB bits in the new linux PTE */
 	lis	r0,_PAGE_HPTE_SUB@h
@@ -666,7 +667,7 @@ htab_modify_pte:
 	li	r6,MMU_PAGE_4K		/* base page size */
 	li	r7,MMU_PAGE_4K		/* actual page size */
 	ld	r8,STK_PARAM(R9)(r1)	/* segment size */
-	ld	r9,STK_PARAM(R8)(r1)	/* get "local" param */
+	ld	r9,STK_PARAM(R8)(r1)	/* get "flags" param */
 .globl htab_call_hpte_updatepp
 htab_call_hpte_updatepp:
 	bl	.			/* patched by htab_finish_init() */
@@ -962,7 +963,7 @@ ht64_modify_pte:
 	li	r6,MMU_PAGE_64K		/* base page size */
 	li	r7,MMU_PAGE_64K		/* actual page size */
 	ld	r8,STK_PARAM(R9)(r1)	/* segment size */
-	ld	r9,STK_PARAM(R8)(r1)	/* get "local" param */
+	ld	r9,STK_PARAM(R8)(r1)	/* get "flags" param */
 .globl ht64_call_hpte_updatepp
 ht64_call_hpte_updatepp:
 	bl	.			/* patched by htab_finish_init() */
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 83c6bb12be14..216efffdef8d 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -283,11 +283,11 @@ static long native_hpte_remove(unsigned long hpte_group)
 
 static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 				 unsigned long vpn, int bpsize,
-				 int apsize, int ssize, int local)
+				 int apsize, int ssize, unsigned long flags)
 {
 	struct hash_pte *hptep = htab_address + slot;
 	unsigned long hpte_v, want_v;
-	int ret = 0;
+	int ret = 0, local = 0;
 
 	want_v = hpte_encode_avpn(vpn, bpsize, ssize);
 
@@ -322,8 +322,15 @@ static long native_hpte_updatepp(unsigned long slot, unsigned long newpp,
 		}
 		native_unlock_hpte(hptep);
 	}
-	/* Ensure it is out of the tlb too. */
-	tlbie(vpn, bpsize, apsize, ssize, local);
+
+	if (flags & HPTE_LOCAL_UPDATE)
+		local = 1;
+	/*
+	 * Ensure it is out of the tlb too if it is not a nohpte fault
+	 */
+	if (!(flags & HPTE_NOHPTE_UPDATE))
+		tlbie(vpn, bpsize, apsize, ssize, local);
+
 	return ret;
 }
 
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 64ee89c0825f..553192a2cede 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1003,7 +1003,9 @@ static void check_paca_psize(unsigned long ea, struct mm_struct *mm,
  * -1 - critical hash insertion error
  * -2 - access not permitted by subpage protection mechanism
  */
-int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, unsigned long trap)
+int hash_page_mm(struct mm_struct *mm, unsigned long ea,
+		 unsigned long access, unsigned long trap,
+		 unsigned long flags)
 {
 	enum ctx_state prev_state = exception_enter();
 	pgd_t *pgdir;
@@ -1011,7 +1013,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, u
 	pte_t *ptep;
 	unsigned hugeshift;
 	const struct cpumask *tmp;
-	int rc, user_region = 0, local = 0;
+	int rc, user_region = 0;
 	int psize, ssize;
 
 	DBG_LOW("hash_page(ea=%016lx, access=%lx, trap=%lx\n",
@@ -1063,7 +1065,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, u
 	/* Check CPU locality */
 	tmp = cpumask_of(smp_processor_id());
 	if (user_region && cpumask_equal(mm_cpumask(mm), tmp))
-		local = 1;
+		flags |= HPTE_LOCAL_UPDATE;
 
 #ifndef CONFIG_PPC_64K_PAGES
 	/* If we use 4K pages and our psize is not 4K, then we might
@@ -1100,11 +1102,11 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, u
 	if (hugeshift) {
 		if (pmd_trans_huge(*(pmd_t *)ptep))
 			rc = __hash_page_thp(ea, access, vsid, (pmd_t *)ptep,
-					     trap, local, ssize, psize);
+					     trap, flags, ssize, psize);
 #ifdef CONFIG_HUGETLB_PAGE
 		else
 			rc = __hash_page_huge(ea, access, vsid, ptep, trap,
-					      local, ssize, hugeshift, psize);
+					      flags, ssize, hugeshift, psize);
 #else
 		else {
 			/*
@@ -1163,7 +1165,8 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, u
 
 #ifdef CONFIG_PPC_HAS_HASH_64K
 	if (psize == MMU_PAGE_64K)
-		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local, ssize);
+		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
+				     flags, ssize);
 	else
 #endif /* CONFIG_PPC_HAS_HASH_64K */
 	{
@@ -1172,7 +1175,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsigned long access, u
 			rc = -2;
 		else
 			rc = __hash_page_4K(ea, access, vsid, ptep, trap,
-					    local, ssize, spp);
+					    flags, ssize, spp);
 	}
 
 	/* Dump some info in case of hash insertion failure, they should
@@ -1195,14 +1198,19 @@ bail:
 }
 EXPORT_SYMBOL_GPL(hash_page_mm);
 
-int hash_page(unsigned long ea, unsigned long access, unsigned long trap)
+int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
+	      unsigned long dsisr)
 {
+	unsigned long flags = 0;
 	struct mm_struct *mm = current->mm;
 
 	if (REGION_ID(ea) == VMALLOC_REGION_ID)
 		mm = &init_mm;
 
-	return hash_page_mm(mm, ea, access, trap);
+	if (dsisr & DSISR_NOHPTE)
+		flags |= HPTE_NOHPTE_UPDATE;
+
+	return hash_page_mm(mm, ea, access, trap, flags);
 }
 EXPORT_SYMBOL_GPL(hash_page);
 
@@ -1214,7 +1222,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	pgd_t *pgdir;
 	pte_t *ptep;
 	unsigned long flags;
-	int rc, ssize, local = 0;
+	int rc, ssize, update_flags = 0;
 
 	BUG_ON(REGION_ID(ea) != USER_REGION_ID);
 
@@ -1265,16 +1273,17 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 
 	/* Is that local to this CPU ? */
 	if (cpumask_equal(mm_cpumask(mm), cpumask_of(smp_processor_id())))
-		local = 1;
+		update_flags = HPTE_LOCAL_UPDATE;
 
 	/* Hash it in */
 #ifdef CONFIG_PPC_HAS_HASH_64K
 	if (mm->context.user_psize == MMU_PAGE_64K)
-		rc = __hash_page_64K(ea, access, vsid, ptep, trap, local, ssize);
+		rc = __hash_page_64K(ea, access, vsid, ptep, trap,
+				     update_flags, ssize);
 	else
 #endif /* CONFIG_PPC_HAS_HASH_64K */
-		rc = __hash_page_4K(ea, access, vsid, ptep, trap, local, ssize,
-				    subpage_protection(mm, ea));
+		rc = __hash_page_4K(ea, access, vsid, ptep, trap, update_flags,
+				    ssize, subpage_protection(mm, ea));
 
 	/* Dump some info in case of hash insertion failure, they should
 	 * never happen so it is really useful to know if/when they do
@@ -1292,9 +1301,10 @@ out_exit:
  *          do not forget to update the assembly call site !
  */
 void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
-		     int local)
+		     unsigned long flags)
 {
 	unsigned long hash, index, shift, hidx, slot;
+	int local = flags & HPTE_LOCAL_UPDATE;
 
 	DBG_LOW("flush_hash_page(vpn=%016lx)\n", vpn);
 	pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 5f5e6328c21c..edecf9381aed 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -70,8 +70,8 @@ static void invalidate_old_hpte(unsigned long vsid, unsigned long addr,
 
 
 int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
-		    pmd_t *pmdp, unsigned long trap, int local, int ssize,
-		    unsigned int psize)
+		    pmd_t *pmdp, unsigned long trap, unsigned long flags,
+		    int ssize, unsigned int psize)
 {
 	unsigned int index, valid;
 	unsigned char *hpte_slot_array;
@@ -158,7 +158,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 		slot += hidx & _PTEIDX_GROUP_IX;
 
 		ret = ppc_md.hpte_updatepp(slot, rflags, vpn,
-					   psize, lpsize, ssize, local);
+					   psize, lpsize, ssize, flags);
 		/*
 		 * We failed to update, try to insert a new entry.
 		 */
diff --git a/arch/powerpc/mm/hugetlbpage-hash64.c b/arch/powerpc/mm/hugetlbpage-hash64.c
index a5bcf9301196..d94b1af53a93 100644
--- a/arch/powerpc/mm/hugetlbpage-hash64.c
+++ b/arch/powerpc/mm/hugetlbpage-hash64.c
@@ -19,8 +19,8 @@ extern long hpte_insert_repeating(unsigned long hash, unsigned long vpn,
 				  unsigned long vflags, int psize, int ssize);
 
 int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
-		     pte_t *ptep, unsigned long trap, int local, int ssize,
-		     unsigned int shift, unsigned int mmu_psize)
+		     pte_t *ptep, unsigned long trap, unsigned long flags,
+		     int ssize, unsigned int shift, unsigned int mmu_psize)
 {
 	unsigned long vpn;
 	unsigned long old_pte, new_pte;
@@ -81,7 +81,7 @@ int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		slot += (old_pte & _PAGE_F_GIX) >> 12;
 
 		if (ppc_md.hpte_updatepp(slot, rflags, vpn, mmu_psize,
-					 mmu_psize, ssize, local) == -1)
+					 mmu_psize, ssize, flags) == -1)
 			old_pte &= ~_PAGE_HPTEFLAGS;
 	}
 
diff --git a/arch/powerpc/platforms/cell/beat_htab.c b/arch/powerpc/platforms/cell/beat_htab.c
index d4d245c0d787..bee9232fe619 100644
--- a/arch/powerpc/platforms/cell/beat_htab.c
+++ b/arch/powerpc/platforms/cell/beat_htab.c
@@ -186,7 +186,7 @@ static long beat_lpar_hpte_updatepp(unsigned long slot,
 				    unsigned long newpp,
 				    unsigned long vpn,
 				    int psize, int apsize,
-				    int ssize, int local)
+				    int ssize, unsigned long flags)
 {
 	unsigned long lpar_rc;
 	u64 dummy0, dummy1;
@@ -369,7 +369,7 @@ static long beat_lpar_hpte_updatepp_v3(unsigned long slot,
 				       unsigned long newpp,
 				       unsigned long vpn,
 				       int psize, int apsize,
-				       int ssize, int local)
+				       int ssize, unsigned long flags)
 {
 	unsigned long lpar_rc;
 	unsigned long want_v;
diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index ffcbd242e669..f7af74f83693 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -181,7 +181,8 @@ static int __spu_trap_data_seg(struct spu *spu, unsigned long ea)
 	return 0;
 }
 
-extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap); //XXX
+extern int hash_page(unsigned long ea, unsigned long access,
+		     unsigned long trap, unsigned long dsisr); //XXX
 static int __spu_trap_data_map(struct spu *spu, unsigned long ea, u64 dsisr)
 {
 	int ret;
@@ -196,7 +197,7 @@ static int __spu_trap_data_map(struct spu *spu, unsigned long ea, u64 dsisr)
 	    (REGION_ID(ea) != USER_REGION_ID)) {
 
 		spin_unlock(&spu->register_lock);
-		ret = hash_page(ea, _PAGE_PRESENT, 0x300);
+		ret = hash_page(ea, _PAGE_PRESENT, 0x300, dsisr);
 		spin_lock(&spu->register_lock);
 
 		if (!ret) {
diff --git a/arch/powerpc/platforms/cell/spufs/fault.c b/arch/powerpc/platforms/cell/spufs/fault.c
index e45894a08118..d98f845ac777 100644
--- a/arch/powerpc/platforms/cell/spufs/fault.c
+++ b/arch/powerpc/platforms/cell/spufs/fault.c
@@ -144,7 +144,7 @@ int spufs_handle_class1(struct spu_context *ctx)
 	access = (_PAGE_PRESENT | _PAGE_USER);
 	access |= (dsisr & MFC_DSISR_ACCESS_PUT) ? _PAGE_RW : 0UL;
 	local_irq_save(flags);
-	ret = hash_page(ea, access, 0x300);
+	ret = hash_page(ea, access, 0x300, dsisr);
 	local_irq_restore(flags);
 
 	/* hashing failed, so try the actual fault handler */
diff --git a/arch/powerpc/platforms/ps3/htab.c b/arch/powerpc/platforms/ps3/htab.c
index 3e270e3412ae..2f95d33cf34a 100644
--- a/arch/powerpc/platforms/ps3/htab.c
+++ b/arch/powerpc/platforms/ps3/htab.c
@@ -110,7 +110,7 @@ static long ps3_hpte_remove(unsigned long hpte_group)
 
 static long ps3_hpte_updatepp(unsigned long slot, unsigned long newpp,
 			      unsigned long vpn, int psize, int apsize,
-			      int ssize, int local)
+			      int ssize, unsigned long inv_flags)
 {
 	int result;
 	u64 hpte_v, want_v, hpte_rs;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 8c509d5397c6..003d0e88f651 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -274,7 +274,7 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 				       unsigned long newpp,
 				       unsigned long vpn,
 				       int psize, int apsize,
-				       int ssize, int local)
+				       int ssize, unsigned long inv_flags)
 {
 	unsigned long lpar_rc;
 	unsigned long flags = (newpp & 7) | H_AVPN;
diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index c99e896604ee..f8684bca2d79 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -133,7 +133,7 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
 {
 	unsigned flt = 0;
 	int result;
-	unsigned long access, flags;
+	unsigned long access, flags, inv_flags = 0;
 
 	if ((result = copro_handle_mm_fault(mm, dar, dsisr, &flt))) {
 		pr_devel("copro_handle_mm_fault failed: %#x\n", result);
@@ -149,8 +149,12 @@ static void cxl_handle_page_fault(struct cxl_context *ctx,
 		access |= _PAGE_RW;
 	if ((!ctx->kernel) || ~(dar & (1ULL << 63)))
 		access |= _PAGE_USER;
+
+	if (dsisr & DSISR_NOHPTE)
+		inv_flags |= HPTE_NOHPTE_UPDATE;
+
 	local_irq_save(flags);
-	hash_page_mm(mm, dar, access, 0x300);
+	hash_page_mm(mm, dar, access, 0x300, inv_flags);
 	local_irq_restore(flags);
 
 	pr_devel("Page fault successfully handled for pe: %i!\n", ctx->pe);
-- 
2.1.0
