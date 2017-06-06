Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whYQt39cvzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 11:05:58 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id x58so12877561qtc.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 18:05:58 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com
Subject: [RFC PATCH 7/7 v1]powerpc: Deliver SEGV signal on protection key
 violation.
Date: Mon,  5 Jun 2017 18:05:09 -0700
Message-Id: <1496711109-4968-8-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The value of the AMR register at the time of the exception
is made available in gp_regs[PT_AMR] of the siginfo.

This field can be used to reprogram the permission bits of
any valid protection key.

Similarly the value of the key, whose protection got violated,
is made available at si_pkey field of the siginfo structure.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/uapi/asm/ptrace.h |  5 +++-
 arch/powerpc/kernel/asm-offsets.c      |  1 +
 arch/powerpc/kernel/exceptions-64s.S   |  8 ++++++
 arch/powerpc/kernel/signal_32.c        | 18 ++++++++++---
 arch/powerpc/kernel/signal_64.c        | 11 ++++++++
 arch/powerpc/kernel/traps.c            | 49 ++++++++++++++++++++++++++++++++++
 6 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 8036b38..109d0c2 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -49,6 +49,8 @@ struct pt_regs {
 	unsigned long dar;		/* Fault registers */
 	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
 	unsigned long result;		/* Result of a system call */
+	unsigned long dscr;		/* contents of the DSCR register */
+	unsigned long amr;		/* contents of AMR register */
 };
 
 #endif /* __ASSEMBLY__ */
@@ -109,7 +111,8 @@ struct pt_regs {
 #define PT_DSISR 42
 #define PT_RESULT 43
 #define PT_DSCR 44
-#define PT_REGS_COUNT 44
+#define PT_AMR 45
+#define PT_REGS_COUNT 45
 
 #define PT_FPR0	48	/* each FP reg occupies 2 slots in this space */
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 709e234..3818dc5 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -301,6 +301,7 @@ int main(void)
 	STACK_PT_REGS_OFFSET(ORIG_GPR3, orig_gpr3);
 	STACK_PT_REGS_OFFSET(RESULT, result);
 	STACK_PT_REGS_OFFSET(_TRAP, trap);
+	STACK_PT_REGS_OFFSET(_AMR, amr);
 #ifndef CONFIG_PPC64
 	/*
 	 * The PowerPC 400-class & Book-E processors have neither the DAR
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 5226a9d..9872dd3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -493,6 +493,10 @@ EXC_COMMON_BEGIN(data_access_common)
 	ld	r12,_MSR(r1)
 	ld	r3,PACA_EXGEN+EX_DAR(r13)
 	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	mfspr	r5,SPRN_AMR
+	std	r5,_AMR(r1)
+#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 	li	r5,0x300
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
@@ -561,6 +565,10 @@ EXC_COMMON_BEGIN(instruction_access_common)
 	ld	r12,_MSR(r1)
 	ld	r3,_NIP(r1)
 	andis.	r4,r12,0x5820
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	mfspr	r5,SPRN_AMR
+	std	r5,_AMR(r1)
+#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 	li	r5,0x400
 	std	r3,_DAR(r1)
 	std	r4,_DSISR(r1)
diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
index 97bb138..f317638 100644
--- a/arch/powerpc/kernel/signal_32.c
+++ b/arch/powerpc/kernel/signal_32.c
@@ -141,9 +141,11 @@ static inline int save_general_regs(struct pt_regs *regs,
 
 	WARN_ON(!FULL_REGS(regs));
 
-	for (i = 0; i <= PT_RESULT; i ++) {
+	for (i = 0; i <= PT_REGS_COUNT; i++) {
 		if (i == 14 && !FULL_REGS(regs))
 			i = 32;
+		if (i == PT_DSCR)
+			continue;
 		if (__put_user((unsigned int)gregs[i], &frame->mc_gregs[i]))
 			return -EFAULT;
 	}
@@ -156,8 +158,8 @@ static inline int restore_general_regs(struct pt_regs *regs,
 	elf_greg_t64 *gregs = (elf_greg_t64 *)regs;
 	int i;
 
-	for (i = 0; i <= PT_RESULT; i++) {
-		if ((i == PT_MSR) || (i == PT_SOFTE))
+	for (i = 0; i <= PT_REGS_COUNT; i++) {
+		if ((i == PT_MSR) || (i == PT_SOFTE) || (i == PT_DSCR))
 			continue;
 		if (__get_user(gregs[i], &sr->mc_gregs[i]))
 			return -EFAULT;
@@ -661,6 +663,9 @@ static long restore_user_regs(struct pt_regs *regs,
 	long err;
 	unsigned int save_r2 = 0;
 	unsigned long msr;
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	unsigned long amr;
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 #ifdef CONFIG_VSX
 	int i;
 #endif
@@ -750,6 +755,13 @@ static long restore_user_regs(struct pt_regs *regs,
 		return 1;
 #endif /* CONFIG_SPE */
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	amr = regs->amr;
+	err |= __get_user(regs->amr, &sr->mc_gregs[PT_AMR]);
+	if (!err && amr != regs->amr)
+		mtspr(SPRN_AMR, regs->amr);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	return 0;
 }
 
diff --git a/arch/powerpc/kernel/signal_64.c b/arch/powerpc/kernel/signal_64.c
index c83c115..d86d232 100644
--- a/arch/powerpc/kernel/signal_64.c
+++ b/arch/powerpc/kernel/signal_64.c
@@ -327,6 +327,9 @@ static long restore_sigcontext(struct task_struct *tsk, sigset_t *set, int sig,
 	unsigned long save_r13 = 0;
 	unsigned long msr;
 	struct pt_regs *regs = tsk->thread.regs;
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	unsigned long amr;
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 #ifdef CONFIG_VSX
 	int i;
 #endif
@@ -406,6 +409,14 @@ static long restore_sigcontext(struct task_struct *tsk, sigset_t *set, int sig,
 			tsk->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = 0;
 	}
 #endif
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	amr = regs->amr;
+	err |= __get_user(regs->amr, &sc->gp_regs[PT_AMR]);
+	if (!err && amr != regs->amr)
+		mtspr(SPRN_AMR, regs->amr);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	return err;
 }
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d4e545d..cc4bde8b 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -20,6 +20,7 @@
 #include <linux/sched/debug.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
+#include <linux/pkeys.h>
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/ptrace.h>
@@ -247,6 +248,49 @@ void user_single_step_siginfo(struct task_struct *tsk,
 	info->si_addr = (void __user *)regs->nip;
 }
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+static void fill_sig_info_pkey(int si_code, siginfo_t *info, unsigned long addr)
+{
+	struct vm_area_struct *vma;
+
+	/* Fault not from Protection Keys: nothing to do */
+	if (si_code != SEGV_PKUERR)
+		return;
+
+	down_read(&current->mm->mmap_sem);
+	/*
+	 * we could be racing with pkey_mprotect().
+	 * If pkey_mprotect() wins the key value could
+	 * get modified...xxx
+	 */
+	vma = find_vma(current->mm, addr);
+	up_read(&current->mm->mmap_sem);
+
+	/*
+	 * force_sig_info_fault() is called from a number of
+	 * contexts, some of which have a VMA and some of which
+	 * do not.  The Pkey-fault handing happens after we have a
+	 * valid VMA, so we should never reach this without a
+	 * valid VMA.
+	 */
+	if (!vma) {
+		WARN_ONCE(1, "Pkey fault with no VMA passed in");
+		info->si_pkey = 0;
+		return;
+	}
+
+	/*
+	 * We could report the incorrect key because of the reason
+	 * explained above.
+	 *
+	 * si_pkey should be thought off as a strong hint, but not
+	 * an absolutely guarantee because of the race explained
+	 * above.
+	 */
+	info->si_pkey = vma_pkey(vma);
+}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
 	siginfo_t info;
@@ -274,6 +318,11 @@ void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 	info.si_signo = signr;
 	info.si_code = code;
 	info.si_addr = (void __user *) addr;
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	fill_sig_info_pkey(code, &info, addr);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	force_sig_info(signr, &info, current);
 }
 
-- 
1.8.3.1
