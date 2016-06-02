Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL6H86mKqzDqfc
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 22:39:16 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 08:39:14 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v5 04/11] powerpc/powernv: Rename reusable idle functions to
 hardware agnostic names
Date: Thu,  2 Jun 2016 07:38:54 -0500
Message-Id: <1464871141-11568-5-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Functions like power7_wakeup_loss, power7_wakeup_noloss,
power7_wakeup_tb_loss are used by POWER7 and POWER8 hardware. They can
also be used by POWER9. Hence rename these functions hardware agnostic
names.

Suggested-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 - No changes in v5

Changes in v4:
==============
 - renaming power7_powersave_common to pnv_powersave_common
 - renaming power7_enter_nap_mode to pnv_enter_arch207_idle_mode

 arch/powerpc/kernel/exceptions-64s.S    |  8 ++++----
 arch/powerpc/kernel/idle_power_common.S | 33 +++++++++++++++++----------------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  4 ++--
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4a74d6a..2a123cd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -108,7 +108,7 @@ BEGIN_FTR_SECTION
 
 	cmpwi	cr3,r13,2
 	GET_PACA(r13)
-	bl	power7_restore_hyp_resource
+	bl	pnv_restore_hyp_resource
 
 	li	r0,PNV_THREAD_RUNNING
 	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
@@ -128,8 +128,8 @@ BEGIN_FTR_SECTION
 	/* Return SRR1 from power7_nap() */
 	mfspr	r3,SPRN_SRR1
 	blt	cr3,2f
-	b	power7_wakeup_loss
-2:	b	power7_wakeup_noloss
+	b	pnv_wakeup_loss
+2:	b	pnv_wakeup_noloss
 
 9:
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
@@ -1269,7 +1269,7 @@ machine_check_handle_early:
 	GET_PACA(r13)
 	ld	r1,PACAR1(r13)
 	li	r3,PNV_THREAD_NAP
-	b	power7_enter_nap_mode
+	b	pnv_enter_arch207_idle_mode
 4:
 #endif
 	/*
diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
index d5def06..34dbfc9 100644
--- a/arch/powerpc/kernel/idle_power_common.S
+++ b/arch/powerpc/kernel/idle_power_common.S
@@ -1,5 +1,6 @@
 /*
- *  This file contains the power_save function for Power7 CPUs.
+ *  This file contains idle entry/exit functions for POWER7 and
+ *  POWER8 CPUs.
  *
  *  This program is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU General Public License
@@ -75,7 +76,7 @@ core_idle_lock_held:
  * 	0 - don't check
  * 	1 - check
  */
-_GLOBAL(power7_powersave_common)
+_GLOBAL(pnv_powersave_common)
 	/* Use r3 to pass state nap/sleep/winkle */
 	/* NAP is a state loss, we create a regs frame on the
 	 * stack, fill it up with the state we care about and
@@ -135,14 +136,14 @@ _GLOBAL(power7_powersave_common)
 	LOAD_REG_IMMEDIATE(r5, MSR_IDLE)
 	li	r6, MSR_RI
 	andc	r6, r9, r6
-	LOAD_REG_ADDR(r7, power7_enter_nap_mode)
+	LOAD_REG_ADDR(r7, pnv_enter_arch207_idle_mode)
 	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
 	mtspr	SPRN_SRR0, r7
 	mtspr	SPRN_SRR1, r5
 	rfid
 
-	.globl	power7_enter_nap_mode
-power7_enter_nap_mode:
+	.globl pnv_enter_arch207_idle_mode
+pnv_enter_arch207_idle_mode:
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	/* Tell KVM we're napping */
 	li	r4,KVM_HWTHREAD_IN_NAP
@@ -242,19 +243,19 @@ _GLOBAL(power7_idle)
 _GLOBAL(power7_nap)
 	mr	r4,r3
 	li	r3,PNV_THREAD_NAP
-	b	power7_powersave_common
+	b	pnv_powersave_common
 	/* No return */
 
 _GLOBAL(power7_sleep)
 	li	r3,PNV_THREAD_SLEEP
 	li	r4,1
-	b	power7_powersave_common
+	b	pnv_powersave_common
 	/* No return */
 
 _GLOBAL(power7_winkle)
 	li	r3,PNV_THREAD_WINKLE
 	li	r4,1
-	b	power7_powersave_common
+	b	pnv_powersave_common
 	/* No return */
 
 #define CHECK_HMI_INTERRUPT						\
@@ -284,7 +285,7 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
  * r13 - Contents of HSPRG0
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
-_GLOBAL(power7_restore_hyp_resource)
+_GLOBAL(pnv_restore_hyp_resource)
 	/*
 	 * Check if last bit of HSPGR0 is set. This indicates whether we are
 	 * waking up from winkle.
@@ -296,7 +297,7 @@ _GLOBAL(power7_restore_hyp_resource)
 
 	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
 	cmpwi   cr2,r0,PNV_THREAD_NAP
-	bgt     cr2,power7_wakeup_tb_loss	/* Either sleep or Winkle */
+	bgt     cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
 
 	/*
 	 * We fall through here if PACA_THREAD_IDLE_STATE shows we are waking
@@ -306,10 +307,10 @@ _GLOBAL(power7_restore_hyp_resource)
 	bgt	cr3,.
 
 	blr	/* Return back to System Reset vector from where
-		   power7_restore_hyp_resource was invoked */
+		   pnv_restore_hyp_resource was invoked */
 
 
-_GLOBAL(power7_wakeup_tb_loss)
+_GLOBAL(pnv_wakeup_tb_loss)
 	ld	r2,PACATOC(r13);
 	ld	r1,PACAR1(r13)
 	/*
@@ -476,7 +477,7 @@ hypervisor_state_restored:
 	mtspr	SPRN_SRR1,r16
 	mtlr	r17
 	blr	/* Return back to System Reset vector from where
-		   power7_restore_hyp_resource was invoked */
+		   pnv_restore_hyp_resource was invoked */
 
 fastsleep_workaround_at_exit:
 	li	r3,1
@@ -489,7 +490,7 @@ fastsleep_workaround_at_exit:
  * R3 here contains the value that will be returned to the caller
  * of power7_nap.
  */
-_GLOBAL(power7_wakeup_loss)
+_GLOBAL(pnv_wakeup_loss)
 	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
@@ -509,10 +510,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
  * R3 here contains the value that will be returned to the caller
  * of power7_nap.
  */
-_GLOBAL(power7_wakeup_noloss)
+_GLOBAL(pnv_wakeup_noloss)
 	lbz	r0,PACA_NAPSTATELOST(r13)
 	cmpwi	r0,0
-	bne	power7_wakeup_loss
+	bne	pnv_wakeup_loss
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index e571ad2..86f0cae 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -392,7 +392,7 @@ kvm_no_guest:
 	cmpwi	r3, 0
 	bne	54f
 /*
- * We jump to power7_wakeup_loss, which will return to the caller
+ * We jump to pnv_wakeup_loss, which will return to the caller
  * of power7_nap in the powernv cpu offline loop.  The value we
  * put in r3 becomes the return value for power7_nap.
  */
@@ -401,7 +401,7 @@ kvm_no_guest:
 	rlwimi	r4, r3, 0, LPCR_PECE0 | LPCR_PECE1
 	mtspr	SPRN_LPCR, r4
 	li	r3, 0
-	b	power7_wakeup_loss
+	b	pnv_wakeup_loss
 
 53:	HMT_LOW
 	ld	r5, HSTATE_KVM_VCORE(r13)
-- 
2.1.4
