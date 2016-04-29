Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyK4WzMzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 44/70] powerpc/mm/radix: Use STD_MMU_64 to properly isolate
 hash related code
Date: Fri, 29 Apr 2016 23:26:07 +1000
Message-Id: <1461936393-10131-44-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We also use MMU_FTR_RADIX to branch out from code path specific to
hash.

No functionality change.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S         |  7 +++++--
 arch/powerpc/kernel/exceptions-64s.S   | 28 +++++++++++++++++++++++-----
 arch/powerpc/kernel/machine_kexec_64.c |  6 ++++--
 arch/powerpc/kernel/mce_power.c        | 10 ++++++++++
 arch/powerpc/kernel/process.c          | 15 +++++++++------
 arch/powerpc/xmon/xmon.c               |  2 +-
 6 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 4fd492209d90..73e461a3dfbb 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -529,7 +529,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
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
@@ -575,7 +578,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	slbmte	r7,r0
 	isync
 2:
-#endif /* !CONFIG_PPC_BOOK3S */
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	CURRENT_THREAD_INFO(r7, r8)  /* base of new stack */
 	/* Note: this uses SWITCH_FRAME_SIZE rather than INT_FRAME_SIZE
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 52d2d742f6e7..7272e6c38d01 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -939,7 +939,13 @@ data_access_common:
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
@@ -964,7 +970,13 @@ instruction_access_common:
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
 
@@ -1375,8 +1387,11 @@ slb_miss_realmode:
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
@@ -1384,7 +1399,9 @@ slb_miss_realmode:
 	lwz	r9,PACA_EXSLB+EX_CCR(r13)	/* get saved CR */
 
 	mtlr	r10
-
+BEGIN_MMU_FTR_SECTION
+	b	2f
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_RADIX)
 	andi.	r10,r12,MSR_RI	/* check for unrecoverable exception */
 	beq-	2f
 
@@ -1435,9 +1452,7 @@ power4_fixup_nap:
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
@@ -1465,6 +1480,7 @@ do_hash_page:
 
 	/* Error */
 	blt-	13f
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
@@ -1491,6 +1507,7 @@ handle_dabr_fault:
 12:	b       ret_from_except_lite
 
 
+#ifdef CONFIG_PPC_STD_MMU_64
 /* We have a page fault that hash_page could handle but HV refused
  * the PTE insertion
  */
@@ -1500,6 +1517,7 @@ handle_dabr_fault:
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
index f64660254951..bec70338672e 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -80,6 +80,7 @@ void __flush_tlb_power9(unsigned int action)
 
 
 /* flush SLBs and reload */
+#ifdef CONFIG_PPC_MMU_STD_64
 static void flush_and_reload_slb(void)
 {
 	struct slb_shadow *slb;
@@ -113,6 +114,7 @@ static void flush_and_reload_slb(void)
 		asm volatile("slbmte %0,%1" : : "r" (rs), "r" (rb));
 	}
 }
+#endif
 
 static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 {
@@ -123,6 +125,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 	 * reset the error bits whenever we handle them so that at the end
 	 * we can check whether we handled all of them or not.
 	 * */
+#ifdef CONFIG_PPC_MMU_STD_64
 	if (dsisr & slb_error_bits) {
 		flush_and_reload_slb();
 		/* reset error bits */
@@ -134,6 +137,7 @@ static long mce_handle_derror(uint64_t dsisr, uint64_t slb_error_bits)
 		/* reset error bits */
 		dsisr &= ~P7_DSISR_MC_TLB_MULTIHIT_MFTLB;
 	}
+#endif
 	/* Any other errors we don't understand? */
 	if (dsisr & 0xffffffffUL)
 		handled = 0;
@@ -153,6 +157,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
 	switch (P7_SRR1_MC_IFETCH(srr1)) {
 	case 0:
 		break;
+#ifdef CONFIG_PPC_MMU_STD_64
 	case P7_SRR1_MC_IFETCH_SLB_PARITY:
 	case P7_SRR1_MC_IFETCH_SLB_MULTIHIT:
 		/* flush and reload SLBs for SLB errors. */
@@ -165,6 +170,7 @@ static long mce_handle_common_ierror(uint64_t srr1)
 			handled = 1;
 		}
 		break;
+#endif
 	default:
 		break;
 	}
@@ -178,10 +184,12 @@ static long mce_handle_ierror_p7(uint64_t srr1)
 
 	handled = mce_handle_common_ierror(srr1);
 
+#ifdef CONFIG_PPC_MMU_STD_64
 	if (P7_SRR1_MC_IFETCH(srr1) == P7_SRR1_MC_IFETCH_SLB_BOTH) {
 		flush_and_reload_slb();
 		handled = 1;
 	}
+#endif
 	return handled;
 }
 
@@ -324,10 +332,12 @@ static long mce_handle_ierror_p8(uint64_t srr1)
 
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
index ad79816f13fe..ea8a28fd6f31 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1079,7 +1079,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	}
 #endif /* CONFIG_PPC64 */
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_STD_MMU_64
 	batch = this_cpu_ptr(&ppc64_tlb_batch);
 	if (batch->active) {
 		current_thread_info()->local_flags |= _TLF_LAZY_MMU;
@@ -1087,7 +1087,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 			__flush_tlb_pending(batch);
 		batch->active = 0;
 	}
-#endif /* CONFIG_PPC_BOOK3S_64 */
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 	switch_booke_debug_regs(&new->thread.debug);
@@ -1133,7 +1133,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	last = _switch(old_thread, new_thread);
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_STD_MMU_64
 	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
 		current_thread_info()->local_flags &= ~_TLF_LAZY_MMU;
 		batch = this_cpu_ptr(&ppc64_tlb_batch);
@@ -1142,8 +1142,7 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	if (current_thread_info()->task->thread.regs)
 		restore_math(current_thread_info()->task->thread.regs);
-
-#endif /* CONFIG_PPC_BOOK3S_64 */
+#endif /* CONFIG_PPC_STD_MMU_64 */
 
 	return last;
 }
@@ -1378,6 +1377,9 @@ static void setup_ksp_vsid(struct task_struct *p, unsigned long sp)
 	unsigned long sp_vsid;
 	unsigned long llp = mmu_psize_defs[mmu_linear_psize].sllp;
 
+	if (radix_enabled())
+		return;
+
 	if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		sp_vsid = get_kernel_vsid(sp, MMU_SEGSIZE_1T)
 			<< SLB_VSID_SHIFT_1T;
@@ -1926,7 +1928,8 @@ unsigned long arch_randomize_brk(struct mm_struct *mm)
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
