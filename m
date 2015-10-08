Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E120F1A01E9
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 01:49:35 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 972C1140DA0
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:49:35 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 00:49:35 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2DF823578052
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:49:33 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t98EnDtZ65142794
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:49:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98Emw4f006657
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:49:00 +1100
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
Subject: [PATCH V9 08/28] powerpc, ptrace: Enable support for NT_PPC_CFPR
Date: Thu,  8 Oct 2015 20:17:29 +0530
Message-Id: <1444315669-23487-9-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1444315669-23487-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1444315669-23487-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables support for TM checkpointed FPR register
set ELF core note NT_PPC_CFPR based ptrace requests through
PTRACE_GETREGSET, PTRACE_SETREGSET calls. This is achieved
through adding a register set REGSET_CFPR in powerpc
corresponding to the ELF core note section added. It
implements the get, set and active functions for this new
register set added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 126 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 126 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 5b3f3e9..3c69767 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1031,6 +1031,121 @@ static int tm_cgpr_set(struct task_struct *target,
 
 	return ret;
 }
+
+/**
+ * tm_cfpr_active - get active number of registers in CFPR
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ *
+ * This function checks for the active number of available
+ * regisers in transaction checkpointed FPR category.
+ */
+static int tm_cfpr_active(struct task_struct *target,
+				const struct user_regset *regset)
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
+ * tm_cfpr_get - get CFPR registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy from.
+ * @ubuf:	User buffer to copy into.
+ *
+ * This function gets in transaction checkpointed FPR registers.
+ *
+ * When the transaction is active 'fp_state' holds the checkpointed
+ * values for the current transaction to fall back on if it aborts
+ * in between. This function gets those checkpointed FPR registers.
+ * The userspace interface buffer layout is as follows.
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ *};
+ */
+static int tm_cfpr_get(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			void *kbuf, void __user *ubuf)
+{
+	u64 buf[33];
+	int i;
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
+	/* copy to local buffer then write that out */
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.TS_FPR(i);
+	buf[32] = target->thread.fp_state.fpscr;
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+}
+
+/**
+ * tm_cfpr_set - set CFPR registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy into.
+ * @ubuf:	User buffer to copy from.
+ *
+ * This function sets in transaction checkpointed FPR registers.
+ *
+ * When the transaction is active 'fp_state' holds the checkpointed
+ * FPR register values for the current transaction to fall back on
+ * if it aborts in between. This function sets these checkpointed
+ * FPR registers. The userspace interface buffer layout is as follows.
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ *};
+ */
+static int tm_cfpr_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	u64 buf[33];
+	int i;
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
+	/* copy to local buffer then write that out */
+	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+	if (i)
+		return i;
+	for (i = 0; i < 32 ; i++)
+		target->thread.TS_FPR(i) = buf[i];
+	target->thread.fp_state.fpscr = buf[32];
+	return 0;
+}
 #endif
 
 /*
@@ -1050,6 +1165,7 @@ enum powerpc_regset {
 #endif
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	REGSET_TM_CGPR,		/* TM checkpointed GPR registers */
+	REGSET_TM_CFPR,		/* TM checkpointed FPR registers */
 #endif
 };
 
@@ -1091,6 +1207,11 @@ static const struct user_regset native_regsets[] = {
 		.size = sizeof(long), .align = sizeof(long),
 		.active = tm_cgpr_active, .get = tm_cgpr_get, .set = tm_cgpr_set
 	},
+	[REGSET_TM_CFPR] = {
+		.core_note_type = NT_PPC_TM_CFPR, .n = ELF_NFPREG,
+		.size = sizeof(double), .align = sizeof(double),
+		.active = tm_cfpr_active, .get = tm_cfpr_get, .set = tm_cfpr_set
+	},
 #endif
 };
 
@@ -1323,6 +1444,11 @@ static const struct user_regset compat_regsets[] = {
 		.active = tm_cgpr_active,
 		.get = tm_cgpr32_get, .set = tm_cgpr32_set
 	},
+	[REGSET_TM_CFPR] = {
+		.core_note_type = NT_PPC_TM_CFPR, .n = ELF_NFPREG,
+		.size = sizeof(double), .align = sizeof(double),
+		.active = tm_cfpr_active, .get = tm_cfpr_get, .set = tm_cfpr_set
+	},
 #endif
 };
 
-- 
2.1.0
