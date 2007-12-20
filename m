Return-Path: <roland@redhat.com>
Received: from QMTA01.emeryville.ca.mail.comcast.net
	(qmta01.emeryville.ca.mail.comcast.net [76.96.30.16])
	by ozlabs.org (Postfix) with ESMTP id 985EEDDE1F
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 23:02:39 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: Roland McGrath's message of  Thursday,
	20 December 2007 03:52:00 -0800
	<20071220115200.C767E26F98A@magilla.localdomain>
References: <20071220115200.C767E26F98A@magilla.localdomain>
Subject: [PATCH -mm 19/43] powerpc core dump cleanup
Message-Id: <20071220115822.B2E9126F98A@magilla.localdomain>
Date: Thu, 20 Dec 2007 03:58:22 -0800 (PST)
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove some dead code we no longer need now that the
user_regset interfaces are doing all these jobs.

Signed-off-by: Roland McGrath <roland@redhat.com>
---
 arch/powerpc/kernel/process.c |   48 -----------------------------------------
 include/asm-powerpc/elf.h     |   46 ---------------------------------------
 2 files changed, 0 insertions(+), 94 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b9d8837..9c2983c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -104,17 +104,6 @@ void enable_kernel_fp(void)
 }
 EXPORT_SYMBOL(enable_kernel_fp);
 
-int dump_task_fpu(struct task_struct *tsk, elf_fpregset_t *fpregs)
-{
-	if (!tsk->thread.regs)
-		return 0;
-	flush_fp_to_thread(current);
-
-	memcpy(fpregs, &tsk->thread.fpr[0], sizeof(*fpregs));
-
-	return 1;
-}
-
 #ifdef CONFIG_ALTIVEC
 void enable_kernel_altivec(void)
 {
@@ -148,35 +137,6 @@ void flush_altivec_to_thread(struct task_struct *tsk)
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
 
 #ifdef CONFIG_SPE
@@ -209,14 +169,6 @@ void flush_spe_to_thread(struct task_struct *tsk)
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
diff --git a/include/asm-powerpc/elf.h b/include/asm-powerpc/elf.h
index 9080d85..fe309b4 100644
--- a/include/asm-powerpc/elf.h
+++ b/include/asm-powerpc/elf.h
@@ -178,52 +178,6 @@ typedef elf_vrreg_t elf_vrregset_t32[ELF_NVRREG32];
 
 #define ELF_ET_DYN_BASE         (0x20000000)
 
-/*
- * Our registers are always unsigned longs, whether we're a 32 bit
- * process or 64 bit, on either a 64 bit or 32 bit kernel.
- *
- * This macro relies on elf_regs[i] having the right type to truncate to,
- * either u32 or u64.  It defines the body of the elf_core_copy_regs
- * function, either the native one with elf_gregset_t elf_regs or
- * the 32-bit one with elf_gregset_t32 elf_regs.
- */
-#define PPC_ELF_CORE_COPY_REGS(elf_regs, regs) \
-	int i, nregs = min(sizeof(*regs) / sizeof(unsigned long), \
-			   (size_t)ELF_NGREG);			  \
-	for (i = 0; i < nregs; i++) \
-		elf_regs[i] = ((unsigned long *) regs)[i]; \
-	memset(&elf_regs[i], 0, (ELF_NGREG - i) * sizeof(elf_regs[0]))
-
-/* Common routine for both 32-bit and 64-bit native processes */
-static inline void ppc_elf_core_copy_regs(elf_gregset_t elf_regs,
-					  struct pt_regs *regs)
-{
-	PPC_ELF_CORE_COPY_REGS(elf_regs, regs);
-}
-#define ELF_CORE_COPY_REGS(gregs, regs) ppc_elf_core_copy_regs(gregs, regs);
-
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
-typedef elf_vrregset_t elf_fpxregset_t;
-
-#ifdef CONFIG_ALTIVEC
-extern int dump_task_altivec(struct task_struct *, elf_vrregset_t *vrregs);
-#define ELF_CORE_COPY_XFPREGS(tsk, regs) dump_task_altivec(tsk, regs)
-#define ELF_CORE_XFPREG_TYPE NT_PPC_VMX
-#endif
-
 #endif /* __KERNEL__ */
 
 /* ELF_HWCAP yields a mask that user programs can use to figure out what
-- 
1.5.3.6
