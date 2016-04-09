Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmL94f93zDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:16:17 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 02:16:15 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 08B0C38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:16:14 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396GDsa37617904
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:16:13 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396GDkC016373
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:16:13 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 41/68] powerpc/mm/radix: Use STD_MMU_64 to properly isolate
 hash related code
Date: Sat,  9 Apr 2016 11:43:37 +0530
Message-Id: <1460182444-2468-42-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We also use MMU_FTR_RADIX to branch out from code path specific to
hash.

No functionality change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S         |  7 +++++--
 arch/powerpc/kernel/exceptions-64s.S   | 28 +++++++++++++++++++++++-----
 arch/powerpc/kernel/machine_kexec_64.c |  6 ++++--
 arch/powerpc/kernel/mce_power.c        | 10 ++++++++++
 arch/powerpc/kernel/process.c          | 15 +++++++++------
 arch/powerpc/xmon/xmon.c               |  2 +-
 6 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 9916d150b28c..8b9d68676d2b 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -519,7 +519,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_STCX_CHECKS_ADDRESS)
 	std	r6,PACACURRENT(r13)	/* Set new 'current' */
 
 	ld	r8,KSP(r4)	/* new stack pointer */
-#ifdef CONFIG_PPC_BOOK3S
+#ifdef CONFIG_PPC_STD_MMU_64
+BEGIN_MMU_FTR_SECTION
+	b	2f
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
 BEGIN_FTR_SECTION
 	clrrdi	r6,r8,28	/* get its ESID */
 	clrrdi	r9,r1,28	/* get current sp ESID */
@@ -565,7 +568,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	slbmte	r7,r0
 	isync
 2:
-#endif /* !CONFIG_PPC_BOOK3S */
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	CURRENT_THREAD_INFO(r7, r8)  /* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7716cebf4b8e..d2afec81d04d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -983,7 +983,13 @@ data_access_common:
 	ld	r3,PACA_EXGEN+EX_DAR(r13)
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
 	li	r5,0x300
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
+MMU_FTR_SECTION_ELSE
+	b	handle_page_fault
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
 
 	.align  7
 	.globl  h_data_storage_common
@@ -1008,7 +1014,13 @@ instruction_access_common:
 	ld	r3,_NIP(r1)
 	andis.	r4,r12,0x5820
 	li	r5,0x400
+	std	r3,_DAR(r1)
+	std	r4,_DSISR(r1)
+BEGIN_MMU_FTR_SECTION
 	b	do_hash_page		/* Try to handle as hpte fault */
+MMU_FTR_SECTION_ELSE
+	b	handle_page_fault
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_RADIX)
 
 	STD_EXCEPTION_COMMON(0xe20, h_instr_storage, unknown_exception)
 
@@ -1476,8 +1488,11 @@ slb_miss_realmode:
 	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
 	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
 
+#ifdef CONFIG_PPC_STD_MMU_64
+BEGIN_MMU_FTR_SECTION
 	bl	slb_allocate_realmode
-
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_RADIX)
+#endif
 	/* All done -- return from exception. */
 
 	ld	r10,PACA_EXSLB+EX_LR(r13)
@@ -1485,7 +1500,9 @@ slb_miss_realmode:
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
 
 	mtlr	r10
-
+BEGIN_MMU_FTR_SECTION
+	b	2f
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
 	beq-	2f
 
@@ -1536,9 +1553,7 @@ power4_fixup_nap:
  */
 	.align	7
 do_hash_page:
-	std	r3,_DAR(r1)
-	std	r4,_DSISR(r1)
-
+#ifdef CONFIG_PPC_STD_MMU_64
 	andis.	r0,r4,0xa410		/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
 	andis.  r0,r4,DSISR_DABRMATCH@h
@@ -1566,6 +1581,7 @@ do_hash_page:
 
 	/* Error */
 	blt-	13f
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
@@ -1592,6 +1608,7 @@ handle_dabr_fault:
 12:	b       ret_from_except_lite
 
 
+#ifdef CONFIG_PPC_STD_MMU_64
 /* We have a page fault that hash_page could handle but HV refused
  * the PTE insertion
  */
@@ -1601,6 +1618,7 @@ handle_dabr_fault:
 	ld	r4,_DAR(r1)
 	bl	low_hash_fault
 	b	ret_from_except
+#endif
 
 /*
  * We come here as a result of a DSI at a point where we don't want
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 0fbd75d185d7..1da864c00db0 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -76,6 +76,7 @@ int default_machine_kexec_prepare(struct kimage *image)
 	 * end of the blocked region (begin >= high).  Use the
 	 * boolean identity !(a || b)  === (!a && !b).
 	 */
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (htab_address) {
 		low = __pa(htab_address);
 		high = low + htab_size_bytes;
@@ -88,6 +89,7 @@ int default_machine_kexec_prepare(struct kimage *image)
 				return -ETXTBSY;
 		}
 	}
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	/* We also should not overwrite the tce tables */
 	for_each_node_by_type(node, "pci") {
@@ -381,7 +383,7 @@ void default_machine_kexec(struct kimage *image)
 	/* NOTREACHED */
 }
 
-#ifndef CONFIG_PPC_BOOK3E
+#ifdef CONFIG_PPC_STD_MMU_64
 /* Values we need to export to the second kernel via the device tree. */
 static unsigned long htab_base;
 static unsigned long htab_size;
@@ -428,4 +430,4 @@ static int __init export_htab_values(void)
 	return 0;
 }
 late_initcall(export_htab_values);
-#endif /* !CONFIG_PPC_BOOK3E */
+#endif /* CONFIG_PPC_STD_MMU_64 */
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index ee62b197502d..92a66a2a9b85 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -77,6 +77,7 @@ void __flush_tlb_power9(unsigned int action)
 
 
 /* flush SLBs and reload */
+#ifdef CONFIG_PPC_MMU_STD_64
 static void flush_and_reload_slb(void)
 {
 	struct slb_shadow *slb;
@@ -110,6 +111,7 @@ static void flush_and_reload_slb(void)
 		asm volatile("slbmte %0,%1" : : "r" (rs), "r" (rb));
 	}
 }
+#endif
 
 static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 {
@@ -120,6 +122,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 	 * reset the error bits whenever we handle them so that at the end
 	 * we can check whether we handled all of them or not.
 	 * */
+#ifdef CONFIG_PPC_MMU_STD_64
 	if (dsisr & slb_error_bits) {
 		flush_and_reload_slb();
 		/* reset error bits */
@@ -131,6 +134,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 		/* reset error bits */
 		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
 	}
+#endif
 	/* Any other errors we don't understand? */
 	if (dsisr & 0xffffffffUL)
 		handled = 0;
@@ -150,6 +154,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
 	switch (P7_SRR1_MC_IFETCH(srr1)) {
 	case 0:
 		break;
+#ifdef CONFIG_PPC_MMU_STD_64
 	case P7_SRR1_MC_IFETCH_SLB_PARITY:
 	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
 		/* flush and reload SLBs for SLB errors. */
@@ -162,6 +167,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
 			handled = 1;
 		}
 		break;
+#endif
 	default:
 		break;
 	}
@@ -175,10 +181,12 @@ static long mce_handle_ierror_p7(uint64_t srr1)
 
 	handled = mce_handle_common_ierror(srr1);
 
+#ifdef CONFIG_PPC_MMU_STD_64
 	if (P7_SRR1_MC_IFETCH(srr1) == P7_SRR1_MC_IFETCH_SLB_BOTH) {
 		flush_and_reload_slb();
 		handled = 1;
 	}
+#endif
 	return handled;
 }
 
@@ -321,10 +329,12 @@ static long mce_handle_ierror_p8(uint64_t srr1)
 
 	handled = mce_handle_common_ierror(srr1);
 
+#ifdef CONFIG_PPC_MMU_STD_64
 	if (P7_SRR1_MC_IFETCH(srr1) == P8_SRR1_MC_IFETCH_ERAT_MULTIHIT) {
 		flush_and_reload_slb();
 		handled = 1;
 	}
+#endif
 	return handled;
 }
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d7a9df51b974..e35b018be765 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1075,7 +1075,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	}
 #endif /* CONFIG_PPC64 */
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_STD_MMU_64
 	batch = this_cpu_ptr(&ppc64_tlb_batch);
 	if (batch->active) {
 		current_thread_info()->local_flags |= _TLF_LAZY_MMU;
@@ -1083,7 +1083,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 			__flush_tlb_pending(batch);
 		batch->active = 0;
 	}
-#endif /* CONFIG_PPC_BOOK3S_64 */
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	switch_booke_debug_regs(&new->thread.debug);
@@ -1129,7 +1129,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	last = _switch(old_thread, new_thread);
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
 		current_thread_info()->local_flags &= ~_TLF_LAZY_MMU;
 		batch = this_cpu_ptr(&ppc64_tlb_batch);
@@ -1138,8 +1138,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	if (current_thread_info()->task->thread.regs)
 		restore_math(current_thread_info()->task->thread.regs);
-
-#endif /* CONFIG_PPC_BOOK3S_64 */
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	return last;
 }
@@ -1374,6 +1373,9 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
 	unsigned long sp_vsid;
 	unsigned long llp = mmu_psize_defs[mmu_linear_psize].sllp;
 
+	if (radix_enabled())
+		return;
+
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		sp_vsid = get_kernel_vsid(sp, MMU_SEGSIZE_1T)
 			<< SLB_VSID_SHIFT_1T;
@@ -1920,7 +1922,8 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
 	 * the heap, we can put it above 1TB so it is backed by a 1TB
 	 * segment. Otherwise the heap will be in the bottom 1TB
 	 * which always uses 256MB segments and this may result in a
-	 * performance penalty.
+	 * performance penalty. We don't need to worry about radix. For
+	 * radix, mmu_highuser_ssize remains unchanged from 256MB.
 	 */
 	if (!is_32bit_task() && (mmu_highuser_ssize == MMU_SEGSIZE_1T))
 		base = max_t(unsigned long, mm->brk, 1UL << SID_SHIFT_1T);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 942796fa4767..308283b7b60c 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2913,7 +2913,7 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 	printf("%s", after);
 }
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_STD_MMU_64
 void dump_segments(void)
 {
 	int i;
-- 
2.5.0
