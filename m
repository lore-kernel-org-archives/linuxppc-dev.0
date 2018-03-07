Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zx1G7655qzF1dc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 15:42:23 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w274gLwl023485
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 23:42:21 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gj79nbt0v-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 23:42:20 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 6 Mar 2018 21:42:19 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V3 1/3] powerpc/mm: Add support for handling > 512TB address
 in SLB miss
Date: Wed,  7 Mar 2018 10:12:02 +0530
In-Reply-To: <20180307044204.8904-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180307044204.8904-1-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <20180307044204.8904-2-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For address above 512TB we allocate additional mmu context. To make it all
easy address above 512TB is handled with IR/DR=1 and with stack frame setup.

We do the additional context allocation in SLB miss handler. If the context is
not allocated, we enable interrupts and allocate the context and retry the
access which will again result in a SLB miss.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   6 ++
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   5 +
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |   6 +-
 arch/powerpc/include/asm/book3s/64/mmu.h      |  24 +++++
 arch/powerpc/include/asm/processor.h          |   7 ++
 arch/powerpc/kernel/exceptions-64s.S          |  12 ++-
 arch/powerpc/mm/copro_fault.c                 |   2 +-
 arch/powerpc/mm/hash_utils_64.c               |   4 +-
 arch/powerpc/mm/mmu_context_book3s64.c        |  17 ++-
 arch/powerpc/mm/pgtable-hash64.c              |   2 +-
 arch/powerpc/mm/slb.c                         | 146 ++++++++++++++++++++++++++
 arch/powerpc/mm/slb_low.S                     |   6 +-
 arch/powerpc/mm/tlb_hash64.c                  |   2 +-
 13 files changed, 224 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 67c5475311ee..af2ba9875f18 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -11,6 +11,12 @@
 #define H_PUD_INDEX_SIZE  9
 #define H_PGD_INDEX_SIZE  9
 
+/*
+ * No of address bits below which we use the default context
+ * for slb allocation. For 4k this is 64TB.
+ */
+#define H_BITS_FIRST_CONTEXT	46
+
 #ifndef __ASSEMBLY__
 #define H_PTE_TABLE_SIZE	(sizeof(pte_t) << H_PTE_INDEX_SIZE)
 #define H_PMD_TABLE_SIZE	(sizeof(pmd_t) << H_PMD_INDEX_SIZE)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 3bcf269f8f55..0ee0fc1ad675 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -6,6 +6,11 @@
 #define H_PMD_INDEX_SIZE  10
 #define H_PUD_INDEX_SIZE  7
 #define H_PGD_INDEX_SIZE  8
+/*
+ * No of address bits below which we use the default context
+ * for slb allocation. For 64k this is 512TB.
+ */
+#define H_BITS_FIRST_CONTEXT	49
 
 /*
  * 64k aligned address free up few of the lower bits of RPN for us
diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 50ed64fba4ae..8ee83f6e9c84 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -691,8 +691,8 @@ static inline int user_segment_size(unsigned long addr)
 	return MMU_SEGSIZE_256M;
 }
 
-static inline unsigned long get_vsid(unsigned long context, unsigned long ea,
-				     int ssize)
+static inline unsigned long __get_vsid(unsigned long context, unsigned long ea,
+				       int ssize)
 {
 	unsigned long va_bits = VA_BITS;
 	unsigned long vsid_bits;
@@ -744,7 +744,7 @@ static inline unsigned long get_kernel_vsid(unsigned long ea, int ssize)
 	 */
 	context = (ea >> 60) - KERNEL_REGION_CONTEXT_OFFSET;
 
-	return get_vsid(context, ea, ssize);
+	return __get_vsid(context, ea, ssize);
 }
 
 unsigned htab_shift_for_mem_size(unsigned long mem_size);
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 777778579305..fbf9081e6ece 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -92,6 +92,12 @@ struct slice_mask {
 
 typedef struct {
 	mm_context_id_t id;
+	/*
+	 * One context for each 512TB above the first 512TB.
+	 * First 512TB context is saved in id and is also used
+	 * as PIDR.
+	 */
+	mm_context_id_t extended_id[(TASK_SIZE_USER64/TASK_CONTEXT_SIZE) - 1];
 	u16 user_psize;		/* page size index */
 
 	/* Number of bits in the mm_cpumask */
@@ -193,5 +199,23 @@ extern void radix_init_pseries(void);
 static inline void radix_init_pseries(void) { };
 #endif
 
+static inline int get_esid_context(mm_context_t *ctx, unsigned long ea)
+{
+	int index = ea >> H_BITS_FIRST_CONTEXT;
+
+	if (index == 0)
+		return ctx->id;
+	return ctx->extended_id[--index];
+}
+
+static inline unsigned long get_user_vsid(mm_context_t *ctx,
+					  unsigned long ea, int ssize)
+{
+	unsigned long context = get_esid_context(ctx, ea);
+
+	return __get_vsid(context, ea, ssize);
+}
+
+
 #endif /* __ASSEMBLY__ */
 #endif /* _ASM_POWERPC_BOOK3S_64_MMU_H_ */
diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 01299cdc9806..70d65b482504 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -119,9 +119,16 @@ void release_thread(struct task_struct *);
  */
 #define TASK_SIZE_USER64		TASK_SIZE_512TB
 #define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
+#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
 #else
 #define TASK_SIZE_USER64		TASK_SIZE_64TB
 #define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
+/*
+ * We don't need allocate extended context id for 4K
+ * page size. We limit max address on this config to
+ * 64TB.
+ */
+#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
 #endif
 
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3ac87e53b3da..166b8c0f1830 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -620,8 +620,12 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	ld	r10,PACA_EXSLB+EX_LR(r13)
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
 	mtlr	r10
+	/*
+	 * Large address, check whether we have to allocate new
+	 * contexts.
+	 */
+	beq-	8f
 
-	beq-	8f		/* if bad address, make full stack frame */
 
 	bne-	cr5,2f		/* if unrecoverable exception, oops */
 
@@ -685,7 +689,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_TYPE_RADIX)
 	mr	r3,r12
 	mfspr	r11,SPRN_SRR0
 	mfspr	r12,SPRN_SRR1
-	LOAD_HANDLER(r10,bad_addr_slb)
+	LOAD_HANDLER(r10, multi_context_slb)
 	mtspr	SPRN_SRR0,r10
 	ld	r10,PACAKMSR(r13)
 	mtspr	SPRN_SRR1,r10
@@ -700,7 +704,7 @@ EXC_COMMON_BEGIN(unrecov_slb)
 	bl	unrecoverable_exception
 	b	1b
 
-EXC_COMMON_BEGIN(bad_addr_slb)
+EXC_COMMON_BEGIN(multi_context_slb)
 	EXCEPTION_PROLOG_COMMON(0x380, PACA_EXSLB)
 	RECONCILE_IRQ_STATE(r10, r11)
 	ld	r3, PACA_EXSLB+EX_DAR(r13)
@@ -710,7 +714,7 @@ EXC_COMMON_BEGIN(bad_addr_slb)
 	std	r10, _TRAP(r1)
 2:	bl	save_nvgprs
 	addi	r3, r1, STACK_FRAME_OVERHEAD
-	bl	slb_miss_bad_addr
+	bl	handle_multi_context_slb_miss
 	b	ret_from_except
 
 EXC_REAL_BEGIN(hardware_interrupt, 0x500, 0x100)
diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_fault.c
index 697b70ad1195..7d0945bd3a61 100644
--- a/arch/powerpc/mm/copro_fault.c
+++ b/arch/powerpc/mm/copro_fault.c
@@ -112,7 +112,7 @@ int copro_calculate_slb(struct mm_struct *mm, u64 ea, struct copro_slb *slb)
 			return 1;
 		psize = get_slice_psize(mm, ea);
 		ssize = user_segment_size(ea);
-		vsid = get_vsid(mm->context.id, ea, ssize);
+		vsid = get_user_vsid(&mm->context, ea, ssize);
 		vsidkey = SLB_VSID_USER;
 		break;
 	case VMALLOC_REGION_ID:
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index b578148d89e6..f62325d4f5f5 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1261,7 +1261,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		}
 		psize = get_slice_psize(mm, ea);
 		ssize = user_segment_size(ea);
-		vsid = get_vsid(mm->context.id, ea, ssize);
+		vsid = get_user_vsid(&mm->context, ea, ssize);
 		break;
 	case VMALLOC_REGION_ID:
 		vsid = get_kernel_vsid(ea, mmu_kernel_ssize);
@@ -1526,7 +1526,7 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 
 	/* Get VSID */
 	ssize = user_segment_size(ea);
-	vsid = get_vsid(mm->context.id, ea, ssize);
+	vsid = get_user_vsid(&mm->context, ea, ssize);
 	if (!vsid)
 		return;
 	/*
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 80acad52b006..1e3960fa2df2 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -178,6 +178,19 @@ void __destroy_context(int context_id)
 }
 EXPORT_SYMBOL_GPL(__destroy_context);
 
+void destroy_extended_context(mm_context_t *ctx)
+{
+	int index, context_id;
+
+	spin_lock(&mmu_context_lock);
+	for (index = 1; index < (TASK_SIZE_USER64/TASK_CONTEXT_SIZE); index++) {
+		context_id = ctx->extended_id[index - 1];
+		if (context_id)
+			ida_remove(&mmu_context_ida, context_id);
+	}
+	spin_unlock(&mmu_context_lock);
+}
+
 #ifdef CONFIG_PPC_64K_PAGES
 static void destroy_pagetable_page(struct mm_struct *mm)
 {
@@ -213,8 +226,10 @@ void destroy_context(struct mm_struct *mm)
 #endif
 	if (radix_enabled())
 		WARN_ON(process_tb[mm->context.id].prtb0 != 0);
-	else
+	else {
 		subpage_prot_free(mm);
+		destroy_extended_context(&mm->context);
+	}
 	destroy_pagetable_page(mm);
 	__destroy_context(mm->context.id);
 	mm->context.id = MMU_NO_CONTEXT;
diff --git a/arch/powerpc/mm/pgtable-hash64.c b/arch/powerpc/mm/pgtable-hash64.c
index 469808e77e58..a87b18cf6749 100644
--- a/arch/powerpc/mm/pgtable-hash64.c
+++ b/arch/powerpc/mm/pgtable-hash64.c
@@ -320,7 +320,7 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 
 	if (!is_kernel_addr(addr)) {
 		ssize = user_segment_size(addr);
-		vsid = get_vsid(mm->context.id, addr, ssize);
+		vsid = get_user_vsid(&mm->context, addr, ssize);
 		WARN_ON(vsid == 0);
 	} else {
 		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 13cfe413b40d..e5bde73c62df 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -23,6 +23,7 @@
 #include <asm/smp.h>
 #include <linux/compiler.h>
 #include <linux/mm_types.h>
+#include <linux/context_tracking.h>
 
 #include <asm/udbg.h>
 #include <asm/code-patching.h>
@@ -340,3 +341,148 @@ void slb_initialize(void)
 
 	asm volatile("isync":::"memory");
 }
+
+/*
+ * Only handle insert of 1TB slb entries.
+ */
+static void insert_slb_entry(unsigned long vsid, unsigned long ea,
+			     int bpsize, int ssize)
+{
+	int slb_cache_index;
+	unsigned long flags;
+	enum slb_index index;
+	unsigned long vsid_data, esid_data;
+
+	/*
+	 * We are irq disabled, hence should be safe
+	 * to access PACA.
+	 */
+	index =  get_paca()->stab_rr;
+	/*
+	 * simple round roubin replacement of slb.
+	 */
+	if (index < mmu_slb_size)
+		index++;
+	else
+		index = SLB_NUM_BOLTED;
+	get_paca()->stab_rr = index;
+
+	flags = SLB_VSID_USER | mmu_psize_defs[bpsize].sllp;
+	vsid_data =  (vsid << SLB_VSID_SHIFT_1T) | flags |
+		((unsigned long) ssize << SLB_VSID_SSIZE_SHIFT);
+	esid_data = mk_esid_data(ea, mmu_highuser_ssize, index);
+
+	asm volatile("slbmte %0, %1" : : "r" (vsid_data), "r" (esid_data)
+		     : "memory");
+	/*
+	 * Now update slb cache entries
+	 */
+	slb_cache_index = get_paca()->slb_cache_ptr;
+	if (slb_cache_index < SLB_CACHE_ENTRIES) {
+		/*
+		 * We have space in slb cache for optimized switch_slb().
+		 * Top 36 bits from esid_data as per ISA
+		 */
+		get_paca()->slb_cache[slb_cache_index++] = esid_data >> 28;
+	}
+	/*
+	 * if we are full, just increment and return.
+	 */
+	get_paca()->slb_cache_ptr++;
+}
+
+static void alloc_extended_context(struct mm_struct *mm, unsigned long ea)
+{
+	int context_id;
+
+	int index = (ea >> H_BITS_FIRST_CONTEXT) - 1;
+
+	/*
+	 * we need to do locking only here. If this value was not set before
+	 * we will have taken an SLB miss and will reach here. The value will
+	 * be either 0 or a valid extended context. We need to make sure two
+	 * parallel SLB miss don't end up allocating extended_context for the
+	 * same range. The locking below ensures that. For now we take the
+	 * heavy mmap_sem. But can be changed to per mm_context_t custom lock
+	 * if needed.
+	 */
+	down_read(&mm->mmap_sem);
+	context_id = hash__alloc_context_id();
+	if (context_id < 0) {
+		up_read(&mm->mmap_sem);
+		pagefault_out_of_memory();
+		return;
+	}
+	/* Check for parallel allocation after holding lock */
+	if (!mm->context.extended_id[index])
+		mm->context.extended_id[index] = context_id;
+	else
+		__destroy_context(context_id);
+	up_read(&mm->mmap_sem);
+}
+
+static void __handle_multi_context_slb_miss(struct pt_regs *regs,
+					    unsigned long ea)
+{
+	int context, bpsize;
+	unsigned long vsid;
+	struct mm_struct *mm = current->mm;
+
+	context = get_esid_context(&mm->context, ea);
+	if (!context) {
+		/*
+		 * haven't allocated context yet for this range.
+		 * Enable irq and allo context and return. We will
+		 * take an slb miss on this again and come here with
+		 * allocated context.
+		 */
+		/* We restore the interrupt state now */
+		if (!arch_irq_disabled_regs(regs))
+			local_irq_enable();
+		return alloc_extended_context(mm, ea);
+	}
+	/*
+	 * We are always above 1TB, hence use high user segment size.
+	 */
+	vsid = __get_vsid(context, ea, mmu_highuser_ssize);
+	bpsize = get_slice_psize(mm, ea);
+
+	insert_slb_entry(vsid, ea, bpsize, mmu_highuser_ssize);
+}
+
+/*
+ * exception_enter() handling? FIXME!!
+ */
+void handle_multi_context_slb_miss(struct pt_regs *regs)
+{
+	enum ctx_state prev_state = exception_enter();
+	unsigned long ea = regs->dar;
+
+	/*
+	 * Kernel always runs with single context. Hence
+	 * anything that request for multi context is
+	 * considered bad slb request.
+	 */
+	if (!user_mode(regs))
+		return bad_page_fault(regs, ea, SIGSEGV);
+
+	if (REGION_ID(ea) != USER_REGION_ID)
+		goto slb_bad_addr;
+	/*
+	 * Are we beyound what the page table layout support ?
+	 */
+	if ((ea & ~REGION_MASK) >= H_PGTABLE_RANGE)
+		goto slb_bad_addr;
+
+	/* Lower address should be handled by asm code */
+	if (ea < (1UL << H_BITS_FIRST_CONTEXT))
+		goto slb_bad_addr;
+
+	__handle_multi_context_slb_miss(regs, ea);
+	exception_exit(prev_state);
+	return;
+
+slb_bad_addr:
+	_exception(SIGSEGV, regs, SEGV_BNDERR, ea);
+	exception_exit(prev_state);
+}
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 2c7c717fd2ea..c66cb06e73a1 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -75,10 +75,12 @@ ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_68_BIT_VA)
  */
 _GLOBAL(slb_allocate)
 	/*
-	 * check for bad kernel/user address
+	 * Check for address range for which we need to handle multi context. For
+         * the default context we allocate the slb via the fast path. For large
+         * address we branch out to C-code and look at additional context allocated.
 	 * (ea & ~REGION_MASK) >= PGTABLE_RANGE
 	 */
-	rldicr. r9,r3,4,(63 - H_PGTABLE_EADDR_SIZE - 4)
+	rldicr. r9,r3,4,(63 - H_BITS_FIRST_CONTEXT - 4)
 	bne-	8f
 
 	srdi	r9,r3,60		/* get region */
diff --git a/arch/powerpc/mm/tlb_hash64.c b/arch/powerpc/mm/tlb_hash64.c
index 9b23f12e863c..87d71dd25441 100644
--- a/arch/powerpc/mm/tlb_hash64.c
+++ b/arch/powerpc/mm/tlb_hash64.c
@@ -89,7 +89,7 @@ void hpte_need_flush(struct mm_struct *mm, unsigned long addr,
 	/* Build full vaddr */
 	if (!is_kernel_addr(addr)) {
 		ssize = user_segment_size(addr);
-		vsid = get_vsid(mm->context.id, addr, ssize);
+		vsid = get_user_vsid(&mm->context, addr, ssize);
 	} else {
 		vsid = get_kernel_vsid(addr, mmu_kernel_ssize);
 		ssize = mmu_kernel_ssize;
-- 
2.14.3
