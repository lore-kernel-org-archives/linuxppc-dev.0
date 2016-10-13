Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svZBM037czDt4C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 13:17:31 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 128so3909032pfz.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 19:17:30 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/64s: relocation,
 register save fixes for system reset interrupt
Date: Thu, 13 Oct 2016 13:17:14 +1100
Message-Id: <20161013021714.6624-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch does a couple of things. First of all, powernv immediately
explodes when running a relocated kernel, because the system reset
exception for handling sleeps does not do correct relocated branches.

Secondly, the sleep handling code trashes the condition and cfar
registers, which we would like to preserve for debugging purposes (for
non-sleep case exception).

This patch changes the exception to use the standard format that saves
registers before any tests or branches are made. It adds the test for
idle-wakeup as an "extra" to break out of the normal exception path.
Then it branches to a relocated idle handler that calls the various
idle handling functions.

After this patch, POWER8 CPU simulator now boots powernv kernel that is
running at non-zero.

Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/exception-64s.h | 16 ++++++++++
 arch/powerpc/kernel/exceptions-64s.S     | 50 ++++++++++++++++++--------------
 2 files changed, 45 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 2e4e7d8..84d49b1 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -93,6 +93,10 @@
 	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
 	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
 
+#define __LOAD_HANDLER(reg, label)					\
+	ld	reg,PACAKBASE(r13);					\
+	ori	reg,reg,(ABS_ADDR(label))@l;
+
 /* Exception register prefixes */
 #define EXC_HV	H
 #define EXC_STD
@@ -208,6 +212,18 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define kvmppc_interrupt kvmppc_interrupt_pr
 #endif
 
+#ifdef CONFIG_RELOCATABLE
+#define BRANCH_TO_COMMON(reg, label)					\
+	__LOAD_HANDLER(reg, label);					\
+	mtctr	reg;							\
+	bctr
+
+#else
+#define BRANCH_TO_COMMON(reg, label)					\
+	b	label
+
+#endif
+
 #define __KVM_HANDLER_PROLOG(area, n)					\
 	BEGIN_FTR_SECTION_NESTED(947)					\
 	ld	r10,area+EX_CFAR(r13);					\
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 08992f8..e680e84 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -95,19 +95,35 @@ __start_interrupts:
 /* No virt vectors corresponding with 0x0..0x100 */
 EXC_VIRT_NONE(0x4000, 0x4100)
 
-EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
-	SET_SCRATCH0(r13)
+
 #ifdef CONFIG_PPC_P7_NAP
-BEGIN_FTR_SECTION
-	/* Running native on arch 2.06 or later, check if we are
-	 * waking up from nap/sleep/winkle.
+	/*
+	 * If running native on arch 2.06 or later, check if we are waking up
+	 * from nap/sleep/winkle, and branch to idle handler.
 	 */
-	mfspr	r13,SPRN_SRR1
-	rlwinm.	r13,r13,47-31,30,31
-	beq	9f
+#define IDLETEST(n)							\
+	BEGIN_FTR_SECTION ;						\
+	mfspr	r10,SPRN_SRR1 ;						\
+	rlwinm.	r10,r10,47-31,30,31 ;					\
+	beq-	1f ;							\
+	cmpwi	cr3,r10,2 ;						\
+	BRANCH_TO_COMMON(r10, system_reset_idle_common) ;		\
+1:									\
+	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
+#else
+#define IDLETEST NOTEST
+#endif
 
-	cmpwi	cr3,r13,2
-	GET_PACA(r13)
+EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
+				 IDLETEST, 0x100)
+
+EXC_REAL_END(system_reset, 0x100, 0x200)
+EXC_VIRT_NONE(0x4100, 0x4200)
+
+#ifdef CONFIG_PPC_P7_NAP
+EXC_COMMON_BEGIN(system_reset_idle_common)
 	bl	pnv_restore_hyp_resource
 
 	li	r0,PNV_THREAD_RUNNING
@@ -130,14 +146,8 @@ BEGIN_FTR_SECTION
 	blt	cr3,2f
 	b	pnv_wakeup_loss
 2:	b	pnv_wakeup_noloss
+#endif
 
-9:
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-#endif /* CONFIG_PPC_P7_NAP */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
-				 NOTEST, 0x100)
-EXC_REAL_END(system_reset, 0x100, 0x200)
-EXC_VIRT_NONE(0x4100, 0x4200)
 EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
 
 #ifdef CONFIG_PPC_PSERIES
@@ -817,10 +827,8 @@ EXC_VIRT(trap_0b, 0x4b00, 0x4c00, 0xb00)
 TRAMP_KVM(PACA_EXGEN, 0xb00)
 EXC_COMMON(trap_0b_common, 0xb00, unknown_exception)
 
-
-#define LOAD_SYSCALL_HANDLER(reg)				\
-	ld	reg,PACAKBASE(r13);				\
-	ori	reg,reg,(ABS_ADDR(system_call_common))@l;
+#define LOAD_SYSCALL_HANDLER(reg)					\
+	__LOAD_HANDLER(reg, system_call_common)
 
 /* Syscall routine is used twice, in reloc-off and reloc-on paths */
 #define SYSCALL_PSERIES_1 					\
-- 
2.9.3
