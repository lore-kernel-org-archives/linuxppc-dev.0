Return-Path: <leitao@debian.org>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429XFF58WSzF3D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 05:40:33 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8CJYa5C052558
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:30 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mf60384hw-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2018 15:40:30 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 12 Sep 2018 13:40:29 -0600
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, paulus@ozlabs.org, gromero@linux.vnet.ibm.com,
 mpe@ellerman.id.au, ldufour@linux.vnet.ibm.com,
 Breno Leitao <leitao@debian.org>
Subject: [RFC PATCH 01/11] powerpc/tm: Reclaim transaction on kernel entry
Date: Wed, 12 Sep 2018 16:40:09 -0300
In-Reply-To: <1536781219-13938-1-git-send-email-leitao@debian.org>
References: <1536781219-13938-1-git-send-email-leitao@debian.org>
Message-Id: <1536781219-13938-2-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch creates a macro that will be invoked on all entrance to the
kernel, so, in kernel space the transaction will be completely reclaimed
and not suspended anymore.

This patchset checks if we are coming from PR, if not, skip. This is useful
when there is a irq_replay() being called after recheckpoint, when the IRQ
is re-enable. In this case, we do not want to re-reclaim and
re-recheckpoint, thus, if not coming from PR, skip it completely.

This macro does not care about TM SPR also, it will only be saved and
restore in the context switch code now on.

This macro will return 0 or 1 in r3 register, to specify if a reclaim was
executed or not.

This patchset is based on initial work done by Cyril:
https://patchwork.ozlabs.org/cover/875341/

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 arch/powerpc/include/asm/exception-64s.h | 46 ++++++++++++++++++++++++
 arch/powerpc/kernel/entry_64.S           | 10 ++++++
 arch/powerpc/kernel/exceptions-64s.S     | 12 +++++--
 3 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index a86feddddad0..db90b6d7826e 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -36,6 +36,7 @@
  */
 #include <asm/head-64.h>
 #include <asm/feature-fixups.h>
+#include <asm/tm.h>
 
 /* PACA save area offsets (exgen, exmc, etc) */
 #define EX_R9		0
@@ -686,10 +687,54 @@ BEGIN_FTR_SECTION				\
 	beql	ppc64_runlatch_on_trampoline;	\
 END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+
+/*
+ * This macro will reclaim a transaction if called when coming from userspace
+ * (MSR.PR = 1) and if the transaction state is active or suspended.
+ *
+ * Since we don't want to reclaim when coming from kernel, for instance after
+ * a trechkpt. or a IRQ replay, the live MSR is not useful and instead of it the
+ * MSR from thread stack is used to check the MSR.PR bit.
+ * This macro has one argument which is the cause that will be used by treclaim.
+ * and returns in r3 '1' if the reclaim happens or '0' if reclaim didn't
+ * happen, which is useful to know what registers were clobbered.
+ *
+ * NOTE: If addition registers are clobbered here, make sure the callee
+ * function restores them before proceeding.
+ */
+#define TM_KERNEL_ENTRY(cause)						\
+	ld      r3, _MSR(r1);						\
+	andi.   r0, r3, MSR_PR;	/* Coming from userspace? */		\
+	beq     1f;		/* Skip reclaim if MSR.PR != 1 */	\
+	rldicl. r0, r3, (64-MSR_TM_LG), 63; /* Is TM enabled? */	\
+	beq     1f;		/* Skip reclaim if TM is off */		\
+	rldicl. r0, r3, (64-MSR_TS_LG), 62;	/* Is active */		\
+	beq     1f;		/* Skip reclaim if neither */		\
+	/*								\
+	 * If there is a transaction active or suspended, save the	\
+	 * non-volatile GPRs if they are not already saved.		\
+	 */								\
+	bl      save_nvgprs;						\
+	/*								\
+	 * Soft disable the IRQs, otherwise it might cause a CPU hang.	\
+	 */								\
+	RECONCILE_IRQ_STATE(r10, r11);					\
+	li      r3, cause;						\
+	bl      tm_reclaim_current;					\
+	li      r3, 1;		/* Reclaim happened */			\
+	b       2f;							\
+1:	li      r3, 0;		/* Reclaim didn't happen */		\
+2:
+#else
+#define TM_KERNEL_ENTRY(cause)
+#endif
+
 #define EXCEPTION_COMMON(area, trap, label, hdlr, ret, additions) \
 	EXCEPTION_PROLOG_COMMON(trap, area);			\
 	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
+	TM_KERNEL_ENTRY(TM_CAUSE_MISC);				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	bl	hdlr;						\
 	b	ret
@@ -704,6 +749,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	EXCEPTION_PROLOG_COMMON_3(trap);			\
 	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
+	TM_KERNEL_ENTRY(TM_CAUSE_MISC);				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	bl	hdlr
 
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 2206912ea4f0..c38677b7442c 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -131,6 +131,16 @@ BEGIN_FW_FTR_SECTION
 END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING_NATIVE && CONFIG_PPC_SPLPAR */
 
+#if CONFIG_PPC_TRANSACTIONAL_MEM
+	TM_KERNEL_ENTRY(TM_CAUSE_SYSCALL)
+	cmpdi	r3, 0x1
+	bne	44f
+	/* Restore from r4 to r12 */
+	REST_8GPRS(4,r1)
+44:	/* treclaim was not called, just restore r3 and r0 */
+	REST_GPR(3, r1)
+	REST_GPR(0, r1)
+#endif
 	/*
 	 * A syscall should always be called with interrupts enabled
 	 * so we just unconditionally hard-enable here. When some kind
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ea04dfb8c092..78aba71a4b2d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -805,6 +805,7 @@ EXC_COMMON_BEGIN(alignment_common)
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
 	bl	save_nvgprs
+	TM_KERNEL_ENTRY(TM_CAUSE_ALIGNMENT)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	alignment_exception
@@ -839,6 +840,8 @@ EXC_COMMON_BEGIN(program_check_common)
 	b 3f				/* Jump into the macro !!	*/
 1:	EXCEPTION_PROLOG_COMMON(0x700, PACA_EXGEN)
 	bl	save_nvgprs
+	ld      r3, _MSR(r1)
+	TM_KERNEL_ENTRY(TM_CAUSE_FAC_UNAV)
 	RECONCILE_IRQ_STATE(r10, r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	program_check_exception
@@ -1738,7 +1741,9 @@ do_hash_page:
 
 /* Here we have a page fault that hash_page can't handle. */
 handle_page_fault:
-11:	andis.  r0,r4,DSISR_DABRMATCH@h
+11:	TM_KERNEL_ENTRY(TM_CAUSE_TLBI)
+	ld      r4,_DSISR(r1)
+	andis.  r0,r4,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
 	ld	r4,_DAR(r1)
 	ld	r5,_DSISR(r1)
@@ -1769,6 +1774,8 @@ handle_dabr_fault:
  */
 13:	bl	save_nvgprs
 	mr	r5,r3
+	TM_KERNEL_ENTRY(TM_CAUSE_TLBI)
+	REST_GPR(3,r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r4,_DAR(r1)
 	bl	low_hash_fault
@@ -1783,7 +1790,8 @@ handle_dabr_fault:
  * the access, or panic if there isn't a handler.
  */
 77:	bl	save_nvgprs
-	mr	r4,r3
+	TM_KERNEL_ENTRY(TM_CAUSE_TLBI)
+	ld      r4,_DAR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	li	r5,SIGSEGV
 	bl	bad_page_fault
-- 
2.19.0
