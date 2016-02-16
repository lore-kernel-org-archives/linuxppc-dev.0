Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A0D261A0338
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:01:59 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3EA78140779
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:59 +1100 (AEDT)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 19:01:58 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1F7322BB0045
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:55 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G91l3k36765802
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:55 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G91KLd018379
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:22 +1100
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Cc: peterz@infradead.org, akpm@linux-foundation.org, tglx@linutronix.de,
 james.hogan@imgtec.com, avagin@openvz.org, Paul.Clothier@imgtec.com,
 palves@redhat.com, oleg@redhat.com, dhowells@redhat.com,
 davej@redhat.com, davem@davemloft.net, mikey@neuling.org,
 benh@kernel.crashing.org, sukadev@linux.vnet.ibm.com,
 mpe@ellerman.id.au, sam.bobroff@au1.ibm.com, kirjanov@gmail.com,
 shuahkh@osg.samsung.com, Ulrich.Weigand@de.ibm.com,
 emachado@linux.vnet.ibm.com
Subject: [PATCH V10 07/28] powerpc, ptrace: Enable support for NT_PPC_CGPR
Date: Tue, 16 Feb 2016 14:29:37 +0530
Message-Id: <1455613198-5113-8-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1455613198-5113-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables support for TM checkpointed GPR register
set ELF core note NT_PPC_CGPR based ptrace requests through
PTRACE_GETREGSET, PTRACE_SETREGSET calls. This is achieved
through adding a register set REGSET_CGPR in powerpc
corresponding to the ELF core note section added. It
implements the get, set and active functions for this new
register set added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 222 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 6e0e035..8462c7e 100644
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
@@ -847,6 +867,172 @@ static int evr_set(struct task_struct *target, const struct user_regset *regset,
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
@@ -863,6 +1049,9 @@ enum powerpc_regset {
 #ifdef CONFIG_SPE
 	REGSET_SPE,
 #endif
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	REGSET_TM_CGPR,		/* TM checkpointed GPR registers */
+#endif
 };
 
 static const struct user_regset native_regsets[] = {
@@ -897,6 +1086,13 @@ static const struct user_regset native_regsets[] = {
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
@@ -1059,6 +1255,24 @@ static int gpr32_set_common(struct task_struct *target,
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
@@ -1103,6 +1317,14 @@ static const struct user_regset compat_regsets[] = {
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
2.1.0
