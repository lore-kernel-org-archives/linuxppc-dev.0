Return-Path: <benh@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 02 Jun 2008 16:22:59 +1000
Subject: [PATCH] [POWERPC] Fix incorrect enabling of VMX when building signal
	or user context
Message-Id: <20080602062521.C2967DDE0A@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

When building a signal or a ucontext, we can incorrectly set the MSR_VEC
bit of the kernel pt_regs->msr before returning to userspace if the task
-ever- used VMX.

This can lead to funny result if that stack used it in the past, then
"lost" it (ie. it wasn't enabled after a context switch for example) and
then called get_context. It can end up with VMX enabled and the registers
containing values from some other task.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/signal_64.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-work.orig/arch/powerpc/kernel/signal_64.c	2008-06-02 16:14:10.000000000 +1000
+++ linux-work/arch/powerpc/kernel/signal_64.c	2008-06-02 16:18:39.000000000 +1000
@@ -87,6 +87,7 @@ static long setup_sigcontext(struct sigc
 #ifdef CONFIG_ALTIVEC
 	elf_vrreg_t __user *v_regs = (elf_vrreg_t __user *)(((unsigned long)sc->vmx_reserve + 15) & ~0xful);
 #endif
+	unsigned long msr = regs->msr;
 	long err = 0;
 
 	flush_fp_to_thread(current);
@@ -102,7 +103,7 @@ static long setup_sigcontext(struct sigc
 		/* set MSR_VEC in the MSR value in the frame to indicate that sc->v_reg)
 		 * contains valid data.
 		 */
-		regs->msr |= MSR_VEC;
+		msr |= MSR_VEC;
 	}
 	/* We always copy to/from vrsave, it's 0 if we don't have or don't
 	 * use altivec.
@@ -114,6 +115,7 @@ static long setup_sigcontext(struct sigc
 	err |= __put_user(&sc->gp_regs, &sc->regs);
 	WARN_ON(!FULL_REGS(regs));
 	err |= __copy_to_user(&sc->gp_regs, regs, GP_REGS_SIZE);
+	err |= __put_user(msr, &sc->gp_regs[PT_MSR]);
 	err |= __copy_to_user(&sc->fp_regs, &current->thread.fpr, FP_REGS_SIZE);
 	err |= __put_user(signr, &sc->signal);
 	err |= __put_user(handler, &sc->handler);
