Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: powerpc: Remove old dump_task_* functions
Date: Wed, 02 Jul 2008 22:51:37 +1000
Message-ID: <7636.1215003097@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Roland McGrath <roland@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Since Roland's ptrace cleanup starting
f65255e8d51ecbc6c9eef20d39e0377d19b658ca, the dump_task_* functions are
no longer being used.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
Paulus: please add to you 2.6.27 tree.  

 arch/powerpc/kernel/process.c |   83 ------------------------------------------
 include/asm-powerpc/elf.h     |   20 ----------
 2 files changed, 103 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/process.c
@@ -105,29 +105,6 @@ void enable_kernel_fp(void)
 }
 EXPORT_SYMBOL(enable_kernel_fp);
 
-int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
-{
-#ifdef CONFIG_VSX
-	int i;
-	elf_fpreg_t *reg;
-#endif
-
-	if (!tsk->thread.regs)
-		return 0;
-	flush_fp_to_thread(current);
-
-#ifdef CONFIG_VSX
-	reg = (elf_fpreg_t *)fpregs;
-	for (i = 0; i < ELF_NFPREG - 1; i++, reg++)
-		*reg = tsk->thread.TS_FPR(i);
-	memcpy(reg, &tsk->thread.fpscr, sizeof(elf_fpreg_t));
-#else
-	memcpy(fpregs, &tsk->thread.TS_FPR(0), sizeof(*fpregs));
-#endif
-
-	return 1;
-}
-
 #ifdef CONFIG_ALTIVEC
 void enable_kernel_altivec(void)
 {
@@ -161,35 +138,6 @@ void flush_altivec_to_thread(struct task
 		preempt_enable();
 	}
 }
-
-int dump_task_altivec(struct task_struct *tsk, elf_vrregset_t *vrregs)
-{
-	/* ELF_NVRREG includes the VSCR and VRSAVE which we need to save
-	 * separately, see below */
-	const int nregs = ELF_NVRREG - 2;
-	elf_vrreg_t *reg;
-	u32 *dest;
-
-	if (tsk == current)
-		flush_altivec_to_thread(tsk);
-
-	reg = (elf_vrreg_t *)vrregs;
-
-	/* copy the 32 vr registers */
-	memcpy(reg, &tsk->thread.vr[0], nregs * sizeof(*reg));
-	reg += nregs;
-
-	/* copy the vscr */
-	memcpy(reg, &tsk->thread.vscr, sizeof(*reg));
-	reg++;
-
-	/* vrsave is stored in the high 32bit slot of the final 128bits */
-	memset(reg, 0, sizeof(*reg));
-	dest = (u32 *)reg;
-	*dest = tsk->thread.vrsave;
-
-	return 1;
-}
 #endif /* CONFIG_ALTIVEC */
 
 #ifdef CONFIG_VSX
@@ -224,29 +172,6 @@ void flush_vsx_to_thread(struct task_str
 		preempt_enable();
 	}
 }
-
-/*
- * This dumps the lower half 64bits of the first 32 VSX registers.
- * This needs to be called with dump_task_fp and dump_task_altivec to
- * get all the VSX state.
- */
-int dump_task_vsx(struct task_struct *tsk, elf_vrreg_t *vrregs)
-{
-	elf_vrreg_t *reg;
-	double buf[32];
-	int i;
-
-	if (tsk == current)
-		flush_vsx_to_thread(tsk);
-
-	reg = (elf_vrreg_t *)vrregs;
-
-	for (i = 0; i < 32 ; i++)
-		buf[i] = current->thread.fpr[i][TS_VSRLOWOFFSET];
-	memcpy(reg, buf, sizeof(buf));
-
-	return 1;
-}
 #endif /* CONFIG_VSX */
 
 #ifdef CONFIG_SPE
@@ -279,14 +204,6 @@ void flush_spe_to_thread(struct task_str
 		preempt_enable();
 	}
 }
-
-int dump_spe(struct pt_regs *regs, elf_vrregset_t *evrregs)
-{
-	flush_spe_to_thread(current);
-	/* We copy u32 evr[32] + u64 acc + u32 spefscr -> 35 */
-	memcpy(evrregs, &current->thread.evr[0], sizeof(u32) * 35);
-	return 1;
-}
 #endif /* CONFIG_SPE */
 
 #ifndef CONFIG_SMP
Index: linux-2.6-ozlabs/include/asm-powerpc/elf.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/elf.h
+++ linux-2.6-ozlabs/include/asm-powerpc/elf.h
@@ -204,28 +204,8 @@ static inline void ppc_elf_core_copy_reg
 }
 #define ELF_CORE_COPY_REGS(gregs, regs) ppc_elf_core_copy_regs(gregs, regs);
 
-static inline int dump_task_regs(struct task_struct *tsk,
-				 elf_gregset_t *elf_regs)
-{
-	struct pt_regs *regs = tsk->thread.regs;
-	if (regs)
-		ppc_elf_core_copy_regs(*elf_regs, regs);
-
-	return 1;
-}
-#define ELF_CORE_COPY_TASK_REGS(tsk, elf_regs) dump_task_regs(tsk, elf_regs)
-
-extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *); 
-#define ELF_CORE_COPY_FPREGS(tsk, elf_fpregs) dump_task_fpu(tsk, elf_fpregs)
-
 typedef elf_vrregset_t elf_fpxregset_t;
 
-#ifdef CONFIG_ALTIVEC
-extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
-#define ELF_CORE_COPY_XFPREGS(tsk, regs) dump_task_altivec(tsk, regs)
-#define ELF_CORE_XFPREG_TYPE NT_PPC_VMX
-#endif
-
 /* ELF_HWCAP yields a mask that user programs can use to figure out what
    instruction set this cpu supports.  This could be done in userspace,
    but it's not easy, and we've already done it here.  */
