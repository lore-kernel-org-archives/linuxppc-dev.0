Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPQ110937zDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 05:39:17 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id y6so1542754pgy.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 10:39:16 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/5] powerpc/64s: move remaining system reset idle code into
 idle_book3s.S
Date: Fri, 17 Feb 2017 04:38:57 +1000
Message-Id: <20170216183901.28611-2-npiggin@gmail.com>
In-Reply-To: <20170216183901.28611-1-npiggin@gmail.com>
References: <20170216183901.28611-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Should be no functional change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 26 +-----------------------
 arch/powerpc/kernel/idle_book3s.S    | 39 +++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0e1350b30160..d0d89047befe 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -130,31 +130,7 @@ EXC_VIRT_NONE(0x4100, 0x4200)
 
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
-	b	kvm_start_guest
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
 
 EXC_COMMON_BEGIN(system_reset_common)
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 72dac0b58061..ea3562f83c57 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -115,7 +115,7 @@ core_idle_lock_held:
  *
  * Address to 'rfid' to in r5
  */
-_GLOBAL(pnv_powersave_common)
+pnv_powersave_common:
 	/* Use r3 to pass state nap/sleep/winkle */
 	/* NAP is a state loss, we create a regs frame on the
 	 * stack, fill it up with the state we care about and
@@ -365,6 +365,34 @@ _GLOBAL(power9_idle_stop)
 	LOAD_REG_ADDR(r5,power_enter_stop)
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
+	b	kvm_start_guest
+1:
+#endif
+
+	/* Return SRR1 from power7_nap() */
+	mfspr	r3,SPRN_SRR1
+	blt	cr3,pnv_wakeup_noloss
+	b	pnv_wakeup_loss
+
 /*
  * Called from reset vector. Check whether we have woken up with
  * hypervisor state loss. If yes, restore hypervisor state and return
@@ -373,7 +401,7 @@ _GLOBAL(power9_idle_stop)
  * r13 - Contents of HSPRG0
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
  */
-_GLOBAL(pnv_restore_hyp_resource)
+pnv_restore_hyp_resource:
 BEGIN_FTR_SECTION
 	ld	r2,PACATOC(r13);
 	/*
@@ -436,7 +464,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
  * cr3 - gt if waking up with partial/complete hypervisor state loss
  * cr4 - gt or eq if waking up from complete hypervisor state loss.
  */
-_GLOBAL(pnv_wakeup_tb_loss)
+pnv_wakeup_tb_loss:
 	ld	r1,PACAR1(r13)
 	/*
 	 * Before entering any idle state, the NVGPRs are saved in the stack
@@ -640,7 +668,8 @@ fastsleep_workaround_at_exit:
  * R3 here contains the value that will be returned to the caller
  * of power7_nap.
  */
-_GLOBAL(pnv_wakeup_loss)
+.global pnv_wakeup_loss
+pnv_wakeup_loss:
 	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
@@ -660,7 +689,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
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
