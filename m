Return-Path: <npiggin@gmail.com>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfGMn4gM5zDqLy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 17:40:21 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id 67so8870425itx.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 00:40:21 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH 07/14] powerpc/64s: idle avoid SRR usage in idle sleep/wake
 paths
Date: Fri,  2 Jun 2017 17:39:39 +1000
Message-Id: <20170602073946.8983-8-npiggin@gmail.com>
In-Reply-To: <20170602073946.8983-1-npiggin@gmail.com>
References: <20170602073946.8983-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Idle code now always runs at the 0xc... effective address whether
in real or virtual mode. This means rfid can be ditched, along
with a lot of SRR manipulations.

In the wakeup path, carry SRR1 around in r12. Use mtmsrd to change
MSR states as required.

I haven't tested KVM with this yet.
---
 arch/powerpc/kernel/exceptions-64s.S    |  1 +
 arch/powerpc/kernel/idle_book3s.S       | 57 +++++++++++++++------------------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  8 ++++-
 3 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0c07a3e3158a..0f87ae9ac1db 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -130,6 +130,7 @@ EXC_VIRT_NONE(0x4100, 0x100)
 
 #ifdef CONFIG_PPC_P7_NAP
 EXC_COMMON_BEGIN(system_reset_idle_common)
+	mfspr	r12,SPRN_SRR1
 	b	pnv_powersave_wakeup
 #endif
 
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index c7edb374d1aa..2efb88da8ba3 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -108,7 +108,7 @@ core_idle_lock_held:
  *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
  *	   - Requested PSSCR value in POWER9
  *
- * Address of idle handler to 'rfid' to in r4
+ * Address of idle handler to branch to in realmode in r4
  */
 pnv_powersave_common:
 	/* Use r3 to pass state nap/sleep/winkle */
@@ -118,14 +118,14 @@ pnv_powersave_common:
 	 * need to save PC, some CR bits and the NV GPRs,
 	 * but for now an interrupt frame will do.
 	 */
+	mtctr	r4
+
 	mflr	r0
 	std	r0,16(r1)
 	stdu	r1,-INT_FRAME_SIZE(r1)
 	std	r0,_LINK(r1)
 	std	r0,_NIP(r1)
 
-	mfmsr   r9
-
 	/* We haven't lost state ... yet */
 	li	r0,0
 	stb	r0,PACA_NAPSTATELOST(r13)
@@ -135,7 +135,6 @@ pnv_powersave_common:
 	SAVE_NVGPRS(r1)
 	mfcr	r5
 	std	r5,_CCR(r1)
-	std	r9,_MSR(r1)
 	std	r1,PACAR1(r13)
 
 	/*
@@ -145,12 +144,8 @@ pnv_powersave_common:
 	 * the MMU context to the guest.
 	 */
 	LOAD_REG_IMMEDIATE(r7, MSR_IDLE)
-	li	r6, MSR_RI
-	andc	r6, r9, r6
-	mtmsrd	r6, 1		/* clear RI before setting SRR0/1 */
-	mtspr	SPRN_SRR0, r4
-	mtspr	SPRN_SRR1, r7
-	rfid
+	mtmsrd	r7,0
+	bctr
 
 	.globl pnv_enter_arch207_idle_mode
 pnv_enter_arch207_idle_mode:
@@ -302,11 +297,10 @@ _GLOBAL(power7_idle_insn)
 	b	pnv_powersave_common
 
 #define CHECK_HMI_INTERRUPT						\
-	mfspr	r0,SPRN_SRR1;						\
 BEGIN_FTR_SECTION_NESTED(66);						\
-	rlwinm	r0,r0,45-31,0xf;  /* extract wake reason field (P8) */	\
+	rlwinm	r0,r12,45-31,0xf;  /* extract wake reason field (P8) */	\
 FTR_SECTION_ELSE_NESTED(66);						\
-	rlwinm	r0,r0,45-31,0xe;  /* P7 wake reason field is 3 bits */	\
+	rlwinm	r0,r12,45-31,0xe;  /* P7 wake reason field is 3 bits */	\
 ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
 	cmpwi	r0,0xa;			/* Hypervisor maintenance ? */	\
 	bne	20f;							\
@@ -384,17 +378,17 @@ pnv_powersave_wakeup_mce:
 
 	/*
 	 * Now put the original SRR1 with SRR1_WAKEMCE_RESVD as the wake
-	 * reason into SRR1, which allows reuse of the system reset wakeup
+	 * reason into r12, which allows reuse of the system reset wakeup
 	 * code without being mistaken for another type of wakeup.
 	 */
-	oris	r3,r3,SRR1_WAKEMCE_RESVD@h
-	mtspr	SPRN_SRR1,r3
+	oris	r12,r3,SRR1_WAKEMCE_RESVD@h
 
 	b	pnv_powersave_wakeup
 
 /*
  * Called from reset vector for powersave wakeups.
  * cr3 - set to gt if waking up with partial/complete hypervisor state loss
+ * r12 - SRR1
  */
 .global pnv_powersave_wakeup
 pnv_powersave_wakeup:
@@ -404,8 +398,10 @@ BEGIN_FTR_SECTION
 BEGIN_FTR_SECTION_NESTED(70)
 	bl	power9_dd1_recover_paca
 END_FTR_SECTION_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)
+	ld	r1,PACAR1(r13)
 	bl	pnv_restore_hyp_resource_arch300
 FTR_SECTION_ELSE
+	ld	r1,PACAR1(r13)
 	bl	pnv_restore_hyp_resource_arch207
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 
@@ -425,7 +421,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 #endif
 
 	/* Return SRR1 from power7_nap() */
-	mfspr	r3,SPRN_SRR1
+	mr	r3,r12
 	blt	cr3,pnv_wakeup_noloss
 	b	pnv_wakeup_loss
 
@@ -489,7 +485,6 @@ pnv_restore_hyp_resource_arch207:
  * r4 - PACA_THREAD_IDLE_STATE
  */
 pnv_wakeup_tb_loss:
-	ld	r1,PACAR1(r13)
 	/*
 	 * Before entering any idle state, the NVGPRs are saved in the stack.
 	 * If there was a state loss, or PACA_NAPSTATELOST was set, then the
@@ -515,9 +510,9 @@ pnv_wakeup_tb_loss:
 	 * is required to return back to reset vector after hypervisor state
 	 * restore is complete.
 	 */
+	mr	r19,r12
 	mr	r18,r4
 	mflr	r17
-	mfspr	r16,SPRN_SRR1
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
@@ -762,7 +757,7 @@ no_segments:
 
 hypervisor_state_restored:
 
-	mtspr	SPRN_SRR1,r16
+	mr	r12,r19
 	mtlr	r17
 	blr		/* return to pnv_powersave_wakeup */
 
@@ -778,20 +773,19 @@ fastsleep_workaround_at_exit:
  */
 .global pnv_wakeup_loss
 pnv_wakeup_loss:
-	ld	r1,PACAR1(r13)
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	REST_NVGPRS(r1)
 	REST_GPR(2, r1)
+	ld	r4,PACAKMSR(r13)
+	ld	r5,_LINK(r1)
 	ld	r6,_CCR(r1)
-	ld	r4,_MSR(r1)
-	ld	r5,_NIP(r1)
 	addi	r1,r1,INT_FRAME_SIZE
+	mtlr	r5
 	mtcr	r6
-	mtspr	SPRN_SRR1,r4
-	mtspr	SPRN_SRR0,r5
-	rfid
+	mtmsrd	r4
+	blr
 
 /*
  * R3 here contains the value that will be returned to the caller
@@ -804,12 +798,11 @@ pnv_wakeup_noloss:
 BEGIN_FTR_SECTION
 	CHECK_HMI_INTERRUPT
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
-	ld	r1,PACAR1(r13)
-	ld	r6,_CCR(r1)
-	ld	r4,_MSR(r1)
+	ld	r4,PACAKMSR(r13)
 	ld	r5,_NIP(r1)
+	ld	r6,_CCR(r1)
 	addi	r1,r1,INT_FRAME_SIZE
+	mtlr	r5
 	mtcr	r6
-	mtspr	SPRN_SRR1,r4
-	mtspr	SPRN_SRR0,r5
-	rfid
+	mtmsrd	r4
+	blr
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index bdb3f76ceb6b..2c65aedf516a 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -329,15 +329,21 @@ kvm_novcpu_exit:
  * We come in here when wakened from nap mode.
  * Relocation is off and most register values are lost.
  * r13 points to the PACA.
+ * r3 contains the SRR1 wakeup value
  */
 	.globl	kvm_start_guest
 kvm_start_guest:
-
 	/* Set runlatch bit the minute you wake up from nap */
 	mfspr	r0, SPRN_CTRLF
 	ori 	r0, r0, 1
 	mtspr	SPRN_CTRLT, r0
 
+	/*
+	 * Should avoid this and pass it through in r3. For now,
+	 * code expects it to be in SRR1.
+	 */
+	mtspr	r3,SPRN_SRR1
+
 	ld	r2,PACATOC(r13)
 
 	li	r0,KVM_HWTHREAD_IN_KVM
-- 
2.11.0
