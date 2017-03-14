Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vj8SQ5Jz2zDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 20:24:06 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 25so23251234pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 02:24:06 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH 1/8] powerpc/64s: move remaining system reset idle code into
 idle_book3s.S
Date: Tue, 14 Mar 2017 19:23:42 +1000
Message-Id: <20170314092349.10981-2-npiggin@gmail.com>
In-Reply-To: <20170314092349.10981-1-npiggin@gmail.com>
References: <20170314092349.10981-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Should be no functional change.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 26 +-----------
 arch/powerpc/kernel/idle_book3s.S    | 76 ++++++++++++++++++++++++------------
 2 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 857bf7c5b946..2f837a4a78a2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -126,31 +126,7 @@ EXC_VIRT_NONE(0x4100, 0x100)
 
 #ifdef CONFIG_PPC_P7_NAP
 EXC_COMMON_BEGIN(system_reset_idle_common)
-BEGIN_FTR_SECTION
-	GET_PACA(r13) /* Restore HSPRG0 to get the winkle bit in r13 */
-END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
-	bl	pnv_restore_hyp_resource
-
-	li	r0,PNV_THREAD_RUNNING
-	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
-
-#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
-	li	r0,KVM_HWTHREAD_IN_KERNEL
-	stb	r0,HSTATE_HWTHREAD_STATE(r13)
-	/* Order setting hwthread_state vs. testing hwthread_req */
-	sync
-	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
-	cmpwi	r0,0
-	beq	1f
-	BRANCH_TO_KVM(r10, kvm_start_guest)
-1:
-#endif
-
-	/* Return SRR1 from power7_nap() */
-	mfspr	r3,SPRN_SRR1
-	blt	cr3,2f
-	b	pnv_wakeup_loss
-2:	b	pnv_wakeup_noloss
+	b	pnv_powersave_wakeup
 #endif
 
 EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 995728736677..4313c107da5d 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -20,6 +20,7 @@
 #include <asm/kvm_book3s_asm.h>
 #include <asm/opal.h>
 #include <asm/cpuidle.h>
+#include <asm/exception-64s.h>
 #include <asm/book3s/64/mmu-hash.h>
 #include <asm/mmu.h>
 
@@ -113,7 +114,7 @@ core_idle_lock_held:
  *
  * Address to 'rfid' to in r5
  */
-_GLOBAL(pnv_powersave_common)
+pnv_powersave_common:
 	/* Use r3 to pass state nap/sleep/winkle */
 	/* NAP is a state loss, we create a regs frame on the
 	 * stack, fill it up with the state we care about and
@@ -188,8 +189,8 @@ pnv_enter_arch207_idle_mode:
 	/* The following store to HSTATE_HWTHREAD_STATE(r13)  */
 	/* MUST occur in real mode, i.e. with the MMU off,    */
 	/* and the MMU must stay off until we clear this flag */
-	/* and test HSTATE_HWTHREAD_REQ(r13) in the system    */
-	/* reset interrupt vector in exceptions-64s.S.        */
+	/* and test HSTATE_HWTHREAD_REQ(r13) in               */
+	/* pnv_powersave_wakeup in this file.                 */
 	/* The reason is that another thread can switch the   */
 	/* MMU to a guest context whenever this flag is set   */
 	/* to KVM_HWTHREAD_IN_IDLE, and if the MMU was on,    */
@@ -375,15 +376,42 @@ _GLOBAL(power9_idle_stop)
 	li	r4,1
 	b	pnv_powersave_common
 	/* No return */
+
+.global pnv_powersave_wakeup
+pnv_powersave_wakeup:
+BEGIN_FTR_SECTION
+	GET_PACA(r13) /* Restore HSPRG0 to get the winkle bit in r13 */
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
+	bl	pnv_restore_hyp_resource
+
+	li	r0,PNV_THREAD_RUNNING
+	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
+
+#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
+	li	r0,KVM_HWTHREAD_IN_KERNEL
+	stb	r0,HSTATE_HWTHREAD_STATE(r13)
+	/* Order setting hwthread_state vs. testing hwthread_req */
+	sync
+	lbz	r0,HSTATE_HWTHREAD_REQ(r13)
+	cmpwi	r0,0
+	beq	1f
+	BRANCH_TO_KVM(r10, kvm_start_guest)
+1:
+#endif
+
+	/* Return SRR1 from power7_nap() */
+	mfspr	r3,SPRN_SRR1
+	blt	cr3,pnv_wakeup_noloss
+	b	pnv_wakeup_loss
+
 /*
- * Called from reset vector. Check whether we have woken up with
- * hypervisor state loss. If yes, restore hypervisor state and return
- * back to reset vector.
+ * Check whether we have woken up with hypervisor state loss.
+ * If yes, restore hypervisor state and return back to link.
  *
  * r13 - Contents of HSPRG0
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
-_GLOBAL(pnv_restore_hyp_resource)
+pnv_restore_hyp_resource:
 BEGIN_FTR_SECTION
 	ld	r2,PACATOC(r13);
 	/*
@@ -400,12 +428,9 @@ BEGIN_FTR_SECTION
 	 */
 	rldicl  r5,r5,4,60
 	cmpd	cr4,r5,r4
-	bge	cr4,pnv_wakeup_tb_loss
-	/*
-	 * Waking up without hypervisor state loss. Return to
-	 * reset vector
-	 */
-	blr
+	bge	cr4,pnv_wakeup_tb_loss /* returns to caller */
+
+	blr	/* Waking up without hypervisor state loss. */
 
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 
@@ -433,8 +458,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
 	 */
 	bgt	cr3,.
 
-	blr	/* Return back to System Reset vector from where
-		   pnv_restore_hyp_resource was invoked */
+	blr	/* Waking up wihtout hypervisor state loss */
 
 /*
  * Called if waking up from idle state which can cause either partial or
@@ -446,18 +470,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
  * cr3 - gt if waking up with partial/complete hypervisor state loss
  * cr4 - gt or eq if waking up from complete hypervisor state loss.
  */
-_GLOBAL(pnv_wakeup_tb_loss)
+pnv_wakeup_tb_loss:
 	ld	r1,PACAR1(r13)
 	/*
 	 * Before entering any idle state, the NVGPRs are saved in the stack
-	 * and they are restored before switching to the process context. Hence
-	 * until they are restored, they are free to be used.
+	 * and they are restored before switching to the process context.
+	 * Hence until they are restored, they are free to be used.
 	 *
 	 * Save SRR1 and LR in NVGPRs as they might be clobbered in
-	 * opal_call() (called in CHECK_HMI_INTERRUPT). SRR1 is required
-	 * to determine the wakeup reason if we branch to kvm_start_guest. LR
-	 * is required to return back to reset vector after hypervisor state
-	 * restore is complete.
+	 * opal_call() (called in CHECK_HMI_INTERRUPT). SRR1 is required to
+	 * determine the wakeup reason if we branch to kvm_start_guest. LR is
+	 * required to return back to caller after hypervisor state restore is
+	 * complete.
 	 */
 	mflr	r17
 	mfspr	r16,SPRN_SRR1
@@ -637,8 +661,7 @@ hypervisor_state_restored:
 
 	mtspr	SPRN_SRR1,r16
 	mtlr	r17
-	blr	/* Return back to System Reset vector from where
-		   pnv_restore_hyp_resource was invoked */
+	blr		/* return to pnv_powersave_wakeup */
 
 fastsleep_workaround_at_exit:
 	li	r3,1
@@ -650,7 +673,8 @@ fastsleep_workaround_at_exit:
  * R3 here contains the value that will be returned to the caller
  * of power7_nap.
  */
-_GLOBAL(pnv_wakeup_loss)
+.global pnv_wakeup_loss
+pnv_wakeup_loss:
 	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
@@ -670,7 +694,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
  * R3 here contains the value that will be returned to the caller
  * of power7_nap.
  */
-_GLOBAL(pnv_wakeup_noloss)
+pnv_wakeup_noloss:
 	lbz	r0,PACA_NAPSTATELOST(r13)
 	cmpwi	r0,0
 	bne	pnv_wakeup_loss
-- 
2.11.0
