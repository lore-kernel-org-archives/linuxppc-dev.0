Return-Path: <paulus@ozlabs.org>
Date: Mon, 5 Aug 2013 14:13:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix VRSAVE handling
Message-ID: <20130805041316.GC19254@iris.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since 2002, the kernel has not saved VRSAVE on exception entry and
restored it on exit; rather, VRSAVE gets context-switched in _switch.
This means that when executing in process context in the kernel, the
userspace VRSAVE value is live in the VRSAVE register.

However, the signal code assumes that current->thread.vrsave holds
the current VRSAVE value, which is incorrect.  Therefore, this
commit changes it to use the actual VRSAVE register instead.  (It
still uses current->thread.vrsave as a temporary location to store
it in, as __get_user and __put_user can only transfer to/from a
variable, not an SPR.)

This also modifies the transactional memory code to save and restore
VRSAVE regardless of whether VMX is enabled in the MSR.  This is
because accesses to VRSAVE are not controlled by the MSR.VEC bit,
but can happen at any time.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/signal_32.c | 9 +++++++++
 arch/powerpc/kernel/signal_64.c | 8 ++++++++
 arch/powerpc/kernel/tm.S        | 4 ++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 0f83122..bebdf1a 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -436,7 +436,10 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
 	 * use altivec. Since VSCR only contains 32 bits saved in the least
 	 * significant bits of a vector, we "cheat" and stuff VRSAVE in the
 	 * most significant bits of that same vector. --BenH
+	 * Note that the current VRSAVE value is in the SPR at this point.
 	 */
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		current->thread.vrsave = mfspr(SPRN_VRSAVE);
 	if (__put_user(current->thread.vrsave, (u32 __user *)&frame->mc_vregs[32]))
 		return 1;
 #endif /* CONFIG_ALTIVEC */
@@ -557,6 +560,8 @@ static int save_tm_user_regs(struct pt_regs *regs,
 	 * significant bits of a vector, we "cheat" and stuff VRSAVE in the
 	 * most significant bits of that same vector. --BenH
 	 */
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		current->thread.vrsave = mfspr(SPRN_VRSAVE);
 	if (__put_user(current->thread.vrsave,
 		       (u32 __user *)&frame->mc_vregs[32]))
 		return 1;
@@ -696,6 +701,8 @@ static long restore_user_regs(struct pt_regs *regs,
 	/* Always get VRSAVE back */
 	if (__get_user(current->thread.vrsave, (u32 __user *)&sr->mc_vregs[32]))
 		return 1;
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		mtspr(SPRN_VRSAVE, current->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
 	if (copy_fpr_from_user(current, &sr->mc_fregs))
 		return 1;
@@ -809,6 +816,8 @@ static long restore_tm_user_regs(struct pt_regs *regs,
 	    __get_user(current->thread.transact_vrsave,
 		       (u32 __user *)&tm_sr->mc_vregs[32]))
 		return 1;
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		mtspr(SPRN_VRSAVE, current->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
 
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index 887e99d..c95257e 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -114,6 +114,8 @@ static long setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
 	/* We always copy to/from vrsave, it's 0 if we don't have or don't
 	 * use altivec.
 	 */
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		current->thread.vrsave = mfspr(SPRN_VRSAVE);
 	err |= __put_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);
 #else /* CONFIG_ALTIVEC */
 	err |= __put_user(0, &sc->v_regs);
@@ -217,6 +219,8 @@ static long setup_tm_sigcontexts(struct sigcontext __user *sc,
 	/* We always copy to/from vrsave, it's 0 if we don't have or don't
 	 * use altivec.
 	 */
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		current->thread.vrsave = mfspr(SPRN_VRSAVE);
 	err |= __put_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);
 	if (msr & MSR_VEC)
 		err |= __put_user(current->thread.transact_vrsave,
@@ -356,6 +360,8 @@ static long restore_sigcontext(struct pt_regs *regs, sigset_t *set, int sig,
 		err |= __get_user(current->thread.vrsave, (u32 __user *)&v_regs[33]);
 	else
 		current->thread.vrsave = 0;
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		mtspr(SPRN_VRSAVE, current->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
 	/* restore floating point */
 	err |= copy_fpr_from_user(current, &sc->fp_regs);
@@ -484,6 +490,8 @@ static long restore_tm_sigcontexts(struct pt_regs *regs,
 		current->thread.vrsave = 0;
 		current->thread.transact_vrsave = 0;
 	}
+	if (cpu_has_feature(CPU_FTR_ALTIVEC))
+		mtspr(SPRN_VRSAVE, current->thread.vrsave);
 #endif /* CONFIG_ALTIVEC */
 	/* restore floating point */
 	err |= copy_fpr_from_user(current, &sc->fp_regs);
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
index 51be8fb..e2145b2 100644
--- a/arch/powerpc/kernel/tm.S
+++ b/arch/powerpc/kernel/tm.S
@@ -155,10 +155,10 @@ _GLOBAL(tm_reclaim)
 	mfvscr	vr0
 	li	r6, THREAD_TRANSACT_VSCR
 	stvx	vr0, r3, r6
+dont_backup_vec:
 	mfspr	r0, SPRN_VRSAVE
 	std	r0, THREAD_TRANSACT_VRSAVE(r3)
 
-dont_backup_vec:
 	andi.	r0, r4, MSR_FP
 	beq	dont_backup_fp
 
@@ -331,11 +331,11 @@ _GLOBAL(tm_recheckpoint)
 	lvx	vr0, r3, r5
 	mtvscr	vr0
 	REST_32VRS(0, r5, r3)			/* r5 scratch, r3 THREAD ptr */
+dont_restore_vec:
 	ld	r5, THREAD_VRSAVE(r3)
 	mtspr	SPRN_VRSAVE, r5
 #endif
 
-dont_restore_vec:
 	andi.	r0, r4, MSR_FP
 	beq	dont_restore_fp
 
-- 
1.8.3.1
