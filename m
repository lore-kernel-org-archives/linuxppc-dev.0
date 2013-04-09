Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org, sfr@canb.auug.org.au
Subject: [PATCH] powerpc: fix compiling CONFIG_PPC_TRANSACTIONAL_MEM when
 CONFIG_ALTIVEC=n
Date: Tue, 09 Apr 2013 16:18:55 +1000
Message-ID: <9087.1365488335@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We can't compile a kernel with CONFIG_ALTIVEC=n when
CONFIG_PPC_TRANSACTIONAL_MEM=y.  We currently get:

arch/powerpc/kernel/tm.S:320: Error: unsupported relocation against THREAD_VSCR
arch/powerpc/kernel/tm.S:323: Error: unsupported relocation against THREAD_VR0
arch/powerpc/kernel/tm.S:323: Error: unsupported relocation against THREAD_VR0
etc.

The below fixes this with a sprinkling of #ifdefs.

This was found by mpe with kisskb:
  http://kisskb.ellerman.id.au/kisskb/buildresult/8539442/

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
sfr: this would be nice to get in 3.9.

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 59dd545..16e77a8 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -555,10 +555,12 @@ static inline void tm_recheckpoint_new_task(struct task_struct *new)
 		new->thread.regs->msr |=
 			(MSR_FP | new->thread.fpexc_mode);
 	}
+#ifdef CONFIG_ALTIVEC
 	if (msr & MSR_VEC) {
 		do_load_up_transact_altivec(&new->thread);
 		new->thread.regs->msr |= MSR_VEC;
 	}
+#endif
 	/* We may as well turn on VSX too since all the state is restored now */
 	if (msr & MSR_VSX)
 		new->thread.regs->msr |= MSR_VSX;
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 3acb28e..95068bf 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -866,10 +866,12 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 		do_load_up_transact_fpu(&current->thread);
 		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
 	}
+#ifdef CONFIG_ALTIVEC
 	if (msr & MSR_VEC) {
 		do_load_up_transact_altivec(&current->thread);
 		regs->msr |= MSR_VEC;
 	}
+#endif
 
 	return 0;
 }
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 995f854..c179428 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -522,10 +522,12 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 		do_load_up_transact_fpu(&current->thread);
 		regs->msr |= (MSR_FP | current->thread.fpexc_mode);
 	}
+#ifdef CONFIG_ALTIVEC
 	if (msr & MSR_VEC) {
 		do_load_up_transact_altivec(&current->thread);
 		regs->msr |= MSR_VEC;
 	}
+#endif
 
 	return err;
 }
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 84dbace..2da67e7 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -309,6 +309,7 @@ _GLOBAL(tm_recheckpoint)
 	or	r5, r6, r5			/* Set MSR.FP+.VSX/.VEC */
 	mtmsr	r5
 
+#ifdef CONFIG_ALTIVEC
 	/* FP and VEC registers:  These are recheckpointed from thread.fpr[]
 	 * and thread.vr[] respectively.  The thread.transact_fpr[] version
 	 * is more modern, and will be loaded subsequently by any FPUnavailable
@@ -323,6 +324,7 @@ _GLOBAL(tm_recheckpoint)
 	REST_32VRS(0, r5, r3)			/* r5 scratch, r3 THREAD ptr */
 	ld	r5, THREAD_VRSAVE(r3)
 	mtspr	SPRN_VRSAVE, r5
+#endif
 
 dont_restore_vec:
 	andi.	r0, r4, MSR_FP
