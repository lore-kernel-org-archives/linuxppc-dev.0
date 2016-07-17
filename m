Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
 [209.85.220.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsV1X1VWqzDqMn
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 12:02:24 +1000 (AEST)
Received: by mail-pa0-f66.google.com with SMTP id dx3so8596134pab.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 19:02:24 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Shuah Khan <shuahkh@osg.samsung.com>,
 Anton Blanchard <anton@samba.org>, Cyril Bur <cyrilbur@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v11 04/27] powerpc/ptrace: Enable support for NT_PPC_CGPR
Date: Sun, 17 Jul 2016 09:59:37 +0800
Message-Id: <1468720800-2950-5-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
References: <1468720800-2950-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch enables support for TM checkpointed GPR register
set ELF core note NT_PPC_CGPR based ptrace requests through
PTRACE_GETREGSET, PTRACE_SETREGSET calls. This is achieved
through adding a register set REGSET_CGPR in powerpc
corresponding to the ELF core note section added. It
implements the get, set and active functions for this new
register set added.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Shuah Khan <shuahkh@osg.samsung.com>
Cc: Anton Blanchard <anton@samba.org>
Cc: Cyril Bur <cyrilbur@gmail.com>
Cc: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: Simon Guo <wei.guo.simon@gmail.com>
Cc: Ulrich Weigand <ulrich.weigand@de.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Rashmica Gupta <rashmicy@gmail.com>
Cc: Khem Raj <raj.khem@gmail.com>
Cc: Jessica Yu <jeyu@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: Chris Smart <chris@distroguy.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 222 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 38df7f0..0334c23 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -181,6 +181,26 @@ static int set_user_msr(struct task_struct *task, unsigned long msr)
 	return 0;
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static unsigned long get_user_ckpt_msr(struct task_struct *task)
+{
+	return task->thread.ckpt_regs.msr | task->thread.fpexc_mode;
+}
+
+static int set_user_ckpt_msr(struct task_struct *task, unsigned long msr)
+{
+	task->thread.ckpt_regs.msr &= ~MSR_DEBUGCHANGE;
+	task->thread.ckpt_regs.msr |= msr & MSR_DEBUGCHANGE;
+	return 0;
+}
+
+static int set_user_ckpt_trap(struct task_struct *task, unsigned long trap)
+{
+	task->thread.ckpt_regs.trap = trap & 0xfff0;
+	return 0;
+}
+#endif
+
 #ifdef CONFIG_PPC64
 static int get_user_dscr(struct task_struct *task, unsigned long *data)
 {
@@ -614,6 +634,172 @@ static int evr_set(struct task_struct *target, const struct user_regset *regset,
 }
 #endif /* CONFIG_SPE */
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+/**
+ * tm_cgpr_active - get active number of registers in CGPR
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ *
+ * This function checks for the active number of available
+ * regisers in transaction checkpointed GPR category.
+ */
+static int tm_cgpr_active(struct task_struct *target,
+			  const struct user_regset *regset)
+{
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return 0;
+
+	return regset->n;
+}
+
+/**
+ * tm_cgpr_get - get CGPR registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy from.
+ * @ubuf:	User buffer to copy into.
+ *
+ * This function gets transaction checkpointed GPR registers.
+ *
+ * When the transaction is active, 'ckpt_regs' holds all the checkpointed
+ * GPR register values for the current transaction to fall back on if it
+ * aborts in between. This function gets those checkpointed GPR registers.
+ * The userspace interface buffer layout is as follows.
+ *
+ * struct data {
+ *	struct pt_regs ckpt_regs;
+ * };
+ */
+static int tm_cgpr_get(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_tmregs_to_thread(target);
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  &target->thread.ckpt_regs,
+				  0, offsetof(struct pt_regs, msr));
+	if (!ret) {
+		unsigned long msr = get_user_ckpt_msr(target);
+
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &msr,
+					  offsetof(struct pt_regs, msr),
+					  offsetof(struct pt_regs, msr) +
+					  sizeof(msr));
+	}
+
+	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
+		     offsetof(struct pt_regs, msr) + sizeof(long));
+
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.ckpt_regs.orig_gpr3,
+					  offsetof(struct pt_regs, orig_gpr3),
+					  sizeof(struct pt_regs));
+	if (!ret)
+		ret = user_regset_copyout_zero(&pos, &count, &kbuf, &ubuf,
+					       sizeof(struct pt_regs), -1);
+
+	return ret;
+}
+
+/*
+ * tm_cgpr_set - set the CGPR registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy into.
+ * @ubuf:	User buffer to copy from.
+ *
+ * This function sets in transaction checkpointed GPR registers.
+ *
+ * When the transaction is active, 'ckpt_regs' holds the checkpointed
+ * GPR register values for the current transaction to fall back on if it
+ * aborts in between. This function sets those checkpointed GPR registers.
+ * The userspace interface buffer layout is as follows.
+ *
+ * struct data {
+ *	struct pt_regs ckpt_regs;
+ * };
+ */
+static int tm_cgpr_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	unsigned long reg;
+	int ret;
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_tmregs_to_thread(target);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 &target->thread.ckpt_regs,
+				 0, PT_MSR * sizeof(reg));
+
+	if (!ret && count > 0) {
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &reg,
+					 PT_MSR * sizeof(reg),
+					 (PT_MSR + 1) * sizeof(reg));
+		if (!ret)
+			ret = set_user_ckpt_msr(target, reg);
+	}
+
+	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
+		     offsetof(struct pt_regs, msr) + sizeof(long));
+
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					 &target->thread.ckpt_regs.orig_gpr3,
+					 PT_ORIG_R3 * sizeof(reg),
+					 (PT_MAX_PUT_REG + 1) * sizeof(reg));
+
+	if (PT_MAX_PUT_REG + 1 < PT_TRAP && !ret)
+		ret = user_regset_copyin_ignore(
+			&pos, &count, &kbuf, &ubuf,
+			(PT_MAX_PUT_REG + 1) * sizeof(reg),
+			PT_TRAP * sizeof(reg));
+
+	if (!ret && count > 0) {
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &reg,
+					 PT_TRAP * sizeof(reg),
+					 (PT_TRAP + 1) * sizeof(reg));
+		if (!ret)
+			ret = set_user_ckpt_trap(target, reg);
+	}
+
+	if (!ret)
+		ret = user_regset_copyin_ignore(
+			&pos, &count, &kbuf, &ubuf,
+			(PT_TRAP + 1) * sizeof(reg), -1);
+
+	return ret;
+}
+#endif
 
 /*
  * These are our native regset flavors.
@@ -630,6 +816,9 @@ enum powerpc_regset {
 #ifdef CONFIG_SPE
 	REGSET_SPE,
 #endif
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	REGSET_TM_CGPR,		/* TM checkpointed GPR registers */
+#endif
 };
 
 static const struct user_regset native_regsets[] = {
@@ -664,6 +853,13 @@ static const struct user_regset native_regsets[] = {
 		.active = evr_active, .get = evr_get, .set = evr_set
 	},
 #endif
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	[REGSET_TM_CGPR] = {
+		.core_note_type = NT_PPC_TM_CGPR, .n = ELF_NGREG,
+		.size = sizeof(long), .align = sizeof(long),
+		.active = tm_cgpr_active, .get = tm_cgpr_get, .set = tm_cgpr_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_ppc_native_view = {
@@ -826,6 +1022,24 @@ static int gpr32_set_common(struct task_struct *target,
 					 (PT_TRAP + 1) * sizeof(reg), -1);
 }
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+static int tm_cgpr32_get(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     void *kbuf, void __user *ubuf)
+{
+	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf, 1);
+}
+
+static int tm_cgpr32_set(struct task_struct *target,
+		     const struct user_regset *regset,
+		     unsigned int pos, unsigned int count,
+		     const void *kbuf, const void __user *ubuf)
+{
+	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf, 1);
+}
+#endif /* CONFIG_PPC_TRANSACTIONAL_MEM */
+
 static int gpr32_get(struct task_struct *target,
 		     const struct user_regset *regset,
 		     unsigned int pos, unsigned int count,
@@ -870,6 +1084,14 @@ static const struct user_regset compat_regsets[] = {
 		.active = evr_active, .get = evr_get, .set = evr_set
 	},
 #endif
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	[REGSET_TM_CGPR] = {
+		.core_note_type = NT_PPC_TM_CGPR, .n = ELF_NGREG,
+		.size = sizeof(long), .align = sizeof(long),
+		.active = tm_cgpr_active,
+		.get = tm_cgpr32_get, .set = tm_cgpr32_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_ppc_compat_view = {
-- 
1.8.3.1
