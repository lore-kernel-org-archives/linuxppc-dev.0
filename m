Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6E19A1A0163
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Jul 2015 02:57:53 +1000 (AEST)
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mikey@neuling.org, cyril.bur@au1.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/3] powerpc: Create context switch helpers save_sprs() and
 restore_sprs()
Date: Sun, 26 Jul 2015 02:57:44 +1000
Message-Id: <1437843465-1577-2-git-send-email-anton@samba.org>
In-Reply-To: <1437843465-1577-1-git-send-email-anton@samba.org>
References: <1437843465-1577-1-git-send-email-anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move all our context switch SPR save and restore code into two
helpers. We do a few optimisations:

- Group all mfsprs and all mtsprs. In many cases an mtspr sets a
scoreboarding bit that an mfspr waits on, so the current practise of
mfspr A; mtspr A; mfpsr B; mtspr B is the worst scheduling we can
do.

- SPR writes are slow, so check that the value is changing before
writing it.

A context switch microbenchmark using yield():

http://ozlabs.org/~anton/junkcode/context_switch2.c

./context_switch2 --type=yield 0 0

shows an improvement of almost 10% on POWER8.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/include/asm/switch_to.h | 11 -----
 arch/powerpc/kernel/entry_64.S       | 60 +---------------------
 arch/powerpc/kernel/process.c        | 96 +++++++++++++++++++++++++++++++-----
 3 files changed, 85 insertions(+), 82 deletions(-)

diff --git a/arch/powerpc/include/asm/switch_to.h b/arch/powerpc/include/asm/switch_to.h
index 58abeda..a65f78c 100644
--- a/arch/powerpc/include/asm/switch_to.h
+++ b/arch/powerpc/include/asm/switch_to.h
@@ -15,17 +15,6 @@ extern struct task_struct *__switch_to(struct task_struct *,
 struct thread_struct;
 extern struct task_struct *_switch(struct thread_struct *prev,
 				   struct thread_struct *next);
-#ifdef CONFIG_PPC_BOOK3S_64
-static inline void save_early_sprs(struct thread_struct *prev)
-{
-	if (cpu_has_feature(CPU_FTR_ARCH_207S))
-		prev->tar = mfspr(SPRN_TAR);
-	if (cpu_has_feature(CPU_FTR_DSCR))
-		prev->dscr = mfspr(SPRN_DSCR);
-}
-#else
-static inline void save_early_sprs(struct thread_struct *prev) {}
-#endif
 
 extern void enable_kernel_fp(void);
 extern void enable_kernel_altivec(void);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index daf00f5..8428280 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -441,29 +441,12 @@ _GLOBAL(_switch)
 	SAVE_8GPRS(14, r1)
 	SAVE_10GPRS(22, r1)
 	mflr	r20		/* Return to switch caller */
-#ifdef CONFIG_ALTIVEC
-BEGIN_FTR_SECTION
-	mfspr	r24,SPRN_VRSAVE	/* save vrsave register value */
-	std	r24,THREAD_VRSAVE(r3)
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-#endif /* CONFIG_ALTIVEC */
+
 	std	r20,_NIP(r1)
 	mfcr	r23
 	std	r23,_CCR(r1)
 	std	r1,KSP(r3)	/* Set old stack pointer */
 
-#ifdef CONFIG_PPC_BOOK3S_64
-BEGIN_FTR_SECTION
-	/* Event based branch registers */
-	mfspr	r0, SPRN_BESCR
-	std	r0, THREAD_BESCR(r3)
-	mfspr	r0, SPRN_EBBHR
-	std	r0, THREAD_EBBHR(r3)
-	mfspr	r0, SPRN_EBBRR
-	std	r0, THREAD_EBBRR(r3)
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
-#endif
-
 #ifdef CONFIG_SMP
 	/* We need a sync somewhere here to make sure that if the
 	 * previous task gets rescheduled on another CPU, it sees all
@@ -551,47 +534,6 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	mr	r1,r8		/* start using new stack pointer */
 	std	r7,PACAKSAVE(r13)
 
-#ifdef CONFIG_PPC_BOOK3S_64
-BEGIN_FTR_SECTION
-	/* Event based branch registers */
-	ld	r0, THREAD_BESCR(r4)
-	mtspr	SPRN_BESCR, r0
-	ld	r0, THREAD_EBBHR(r4)
-	mtspr	SPRN_EBBHR, r0
-	ld	r0, THREAD_EBBRR(r4)
-	mtspr	SPRN_EBBRR, r0
-
-	ld	r0,THREAD_TAR(r4)
-	mtspr	SPRN_TAR,r0
-END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
-#endif
-
-#ifdef CONFIG_ALTIVEC
-BEGIN_FTR_SECTION
-	ld	r0,THREAD_VRSAVE(r4)
-	mtspr	SPRN_VRSAVE,r0		/* if G4, restore VRSAVE reg */
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-#endif /* CONFIG_ALTIVEC */
-#ifdef CONFIG_PPC64
-BEGIN_FTR_SECTION
-	lwz	r6,THREAD_DSCR_INHERIT(r4)
-	ld	r0,THREAD_DSCR(r4)
-	cmpwi	r6,0
-	bne	1f
-	ld	r0,PACA_DSCR_DEFAULT(r13)
-1:
-BEGIN_FTR_SECTION_NESTED(70)
-	mfspr	r8, SPRN_FSCR
-	rldimi	r8, r6, FSCR_DSCR_LG, (63 - FSCR_DSCR_LG)
-	mtspr	SPRN_FSCR, r8
-END_FTR_SECTION_NESTED(CPU_FTR_ARCH_207S, CPU_FTR_ARCH_207S, 70)
-	cmpd	r0,r25
-	beq	2f
-	mtspr	SPRN_DSCR,r0
-2:
-END_FTR_SECTION_IFSET(CPU_FTR_DSCR)
-#endif
-
 	ld	r6,_CCR(r1)
 	mtcrf	0xFF,r6
 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 8005e18..b9b690f 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -745,26 +745,96 @@ void restore_tm_state(struct pt_regs *regs)
 #define __switch_to_tm(prev)
 #endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
 
+struct spr_save_t {
+	u64 fscr;
+};
+
+static inline void save_sprs(struct thread_struct *t, struct spr_save_t *save)
+{
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(cpu_has_feature(CPU_FTR_ALTIVEC)))
+		t->vrsave = mfspr(SPRN_VRSAVE);
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (cpu_has_feature(CPU_FTR_DSCR))
+		t->dscr = mfspr(SPRN_DSCR);
+
+	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
+		t->bescr = mfspr(SPRN_BESCR);
+		t->ebbhr = mfspr(SPRN_EBBHR);
+		t->ebbrr = mfspr(SPRN_EBBRR);
+
+		save->fscr = mfspr(SPRN_FSCR);
+
+		/*
+		 * Note that the TAR is not available for use in the kernel.
+		 * (To provide this, the TAR should be backed up/restored on
+		 * exception entry/exit instead, and be in pt_regs.  FIXME,
+		 * this should be in pt_regs anyway (for debug).)
+		 */
+		t->tar = mfspr(SPRN_TAR);
+	}
+#endif
+}
+
+static inline void restore_sprs(struct thread_struct *old_thread,
+				struct thread_struct *new_thread,
+				struct spr_save_t *save)
+{
+#ifdef CONFIG_ALTIVEC
+	if (cpu_has_feature(CPU_FTR_ALTIVEC) &&
+	    old_thread->vrsave != new_thread->vrsave)
+		mtspr(SPRN_VRSAVE, new_thread->vrsave);
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	if (cpu_has_feature(CPU_FTR_DSCR)) {
+		u64 dscr = get_paca()->dscr_default;
+
+		if (new_thread->dscr_inherit) {
+			dscr = new_thread->dscr;
+
+			if (!(save->fscr & FSCR_DSCR))
+				mtspr(SPRN_FSCR, save->fscr | FSCR_DSCR);
+		}
+
+		if (old_thread->dscr != new_thread->dscr)
+			mtspr(SPRN_DSCR, new_thread->dscr);
+	}
+
+	if (cpu_has_feature(CPU_FTR_ARCH_207S)) {
+		if (old_thread->bescr != new_thread->bescr)
+			mtspr(SPRN_BESCR, new_thread->bescr);
+		if (old_thread->ebbhr != new_thread->ebbhr)
+			mtspr(SPRN_EBBHR, new_thread->ebbhr);
+		if (old_thread->ebbrr != new_thread->ebbrr)
+			mtspr(SPRN_EBBRR, new_thread->ebbrr);
+
+		if (old_thread->tar != new_thread->tar)
+			mtspr(SPRN_TAR, new_thread->tar);
+	}
+#endif
+}
+
 struct task_struct *__switch_to(struct task_struct *prev,
 	struct task_struct *new)
 {
 	struct thread_struct *new_thread, *old_thread;
 	struct task_struct *last;
+	struct spr_save_t spr_save = {0, };
 #ifdef CONFIG_PPC_BOOK3S_64
 	struct ppc64_tlb_batch *batch;
 #endif
 
+	new_thread = &new->thread;
+	old_thread = &current->thread;
+
 	WARN_ON(!irqs_disabled());
 
-	/* Back up the TAR and DSCR across context switches.
-	 * Note that the TAR is not available for use in the kernel.  (To
-	 * provide this, the TAR should be backed up/restored on exception
-	 * entry/exit instead, and be in pt_regs.  FIXME, this should be in
-	 * pt_regs anyway (for debug).)
-	 * Save the TAR and DSCR here before we do treclaim/trecheckpoint as
-	 * these will change them.
+	/*
+	 * We need to save SPRs before treclaim/trecheckpoint as these will
+	 * change a number of them.
 	 */
-	save_early_sprs(&prev->thread);
+	save_sprs(&prev->thread, &spr_save);
 
 	__switch_to_tm(prev);
 
@@ -847,10 +917,6 @@ struct task_struct *__switch_to(struct task_struct *prev,
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 
-
-	new_thread = &new->thread;
-	old_thread = &current->thread;
-
 #ifdef CONFIG_PPC64
 	/*
 	 * Collect processor utilization data per process
@@ -886,6 +952,10 @@ struct task_struct *__switch_to(struct task_struct *prev,
 
 	last = _switch(old_thread, new_thread);
 
+	/* Need to recalculate these after calling _switch() */
+	old_thread = &last->thread;
+	new_thread = &current->thread;
+
 #ifdef CONFIG_PPC_BOOK3S_64
 	if (current_thread_info()->local_flags & _TLF_LAZY_MMU) {
 		current_thread_info()->local_flags &= ~_TLF_LAZY_MMU;
@@ -894,6 +964,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	}
 #endif /* CONFIG_PPC_BOOK3S_64 */
 
+	restore_sprs(old_thread, new_thread, &spr_save);
+
 	return last;
 }
 
-- 
2.1.4
