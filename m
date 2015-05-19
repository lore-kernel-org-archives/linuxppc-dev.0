Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 043791A08B6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:10:53 +1000 (AEST)
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 55A60140D4E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:10:52 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:40:50 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 7EB6A3940053
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:40:48 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JFAKP564356396
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:40:48 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8SBu028009
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:33 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 09/28] powerpc, ptrace: Enable support for NT_PPC_CVMX
Date: Tue, 19 May 2015 20:38:05 +0530
Message-Id: <1432048104-4695-10-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1432048104-4695-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: shuahkh@osg.samsung.com, mikey@neuling.org, james.hogan@imgtec.com,
 avagin@openvz.org, Paul.Clothier@imgtec.com, peterz@infradead.org,
 palves@redhat.com, nacc@linux.vnet.ibm.com, emachado@linux.vnet.ibm.com,
 oleg@redhat.com, davem@davemloft.net, dhowells@redhat.com,
 Ulrich.Weigand@de.ibm.com, kirjanov@gmail.com, davej@redhat.com,
 akpm@linux-foundation.org, sukadev@linux.vnet.ibm.com, tglx@linutronix.de,
 sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables support for TM checkpointed VMX register
set ELF core note NT_PPC_CVMX based ptrace requests through
PTRACE_GETREGSET, PTRACE_SETREGSET calls. This is achieved
through adding a register set REGSET_CVMX in powerpc
corresponding to the ELF core note section added. It
implements the get, set and active functions for this new
register set added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/elf.h |   1 +
 arch/powerpc/kernel/ptrace.c        | 158 ++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 59dad11..6c900be 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -91,6 +91,7 @@
 
 #define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
 #define ELF_NFPREG	33	/* includes fpscr */
+#define ELF_NVMX	34	/* includes all vector registers */
 
 typedef unsigned long elf_greg_t64;
 typedef elf_greg_t64 elf_gregset_t64[ELF_NGREG];
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 35df932..4faad8c 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -63,6 +63,8 @@ struct pt_regs_offset {
 	{.name = STR(gpr##num), .offset = offsetof(struct pt_regs, gpr[num])}
 #define REG_OFFSET_END {.name = NULL, .offset = 0}
 
+#define TVSO(f)	(offsetof(struct thread_vr_state, f))
+
 static const struct pt_regs_offset regoffset_table[] = {
 	GPR_OFFSET_NAME(0),
 	GPR_OFFSET_NAME(1),
@@ -1146,6 +1148,151 @@ static int tm_cfpr_set(struct task_struct *target,
 	target->thread.fp_state.fpscr = buf[32];
 	return 0;
 }
+
+/**
+ * tm_cvmx_active - get active number of registers in CVMX
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ *
+ * This function checks for the active number of available
+ * regisers in checkpointed VMX category.
+ */
+static int tm_cvmx_active(struct task_struct *target,
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
+ * tm_cvmx_get - get CMVX registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy from.
+ * @ubuf:	User buffer to copy into.
+ *
+ * This function gets in transaction checkpointed VMX registers.
+ *
+ * When the transaction is active 'vr_state' and 'vr_save' hold
+ * the checkpointed values for the current transaction to fall
+ * back on if it aborts in between. The userspace interface buffer
+ * layout is as follows.
+ *
+ * struct data {
+ *	vector128	vr[32];
+ *	vector128	vscr;
+ *	vector128	vrsave;
+ *};
+ */
+static int tm_cvmx_get(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	BUILD_BUG_ON(TVSO(vscr) != TVSO(vr[32]));
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	/* Flush the state */
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_tmregs_to_thread(target);
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					&target->thread.vr_state, 0,
+					33 * sizeof(vector128));
+	if (!ret) {
+		/*
+		 * Copy out only the low-order word of vrsave.
+		 */
+		union {
+			elf_vrreg_t reg;
+			u32 word;
+		} vrsave;
+		memset(&vrsave, 0, sizeof(vrsave));
+		vrsave.word = target->thread.vrsave;
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
+						33 * sizeof(vector128), -1);
+	}
+
+	return ret;
+}
+
+/**
+ * tm_cvmx_set - set CMVX registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy into.
+ * @ubuf:	User buffer to copy from.
+ *
+ * This function sets in transaction checkpointed VMX registers.
+ *
+ * When the transaction is active 'vr_state' and 'vr_save' hold
+ * the checkpointed values for the current transaction to fall
+ * back on if it aborts in between. The userspace interface buffer
+ * layout is as follows.
+ *
+ * struct data {
+ *	vector128	vr[32];
+ *	vector128	vscr;
+ *	vector128	vrsave;
+ *};
+ */
+static int tm_cvmx_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	BUILD_BUG_ON(TVSO(vscr) != TVSO(vr[32]));
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
+					&target->thread.vr_state, 0,
+					33 * sizeof(vector128));
+	if (!ret && count > 0) {
+		/*
+		 * We use only the low-order word of vrsave.
+		 */
+		union {
+			elf_vrreg_t reg;
+			u32 word;
+		} vrsave;
+		memset(&vrsave, 0, sizeof(vrsave));
+		vrsave.word = target->thread.vrsave;
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &vrsave,
+						33 * sizeof(vector128), -1);
+		if (!ret)
+			target->thread.vrsave = vrsave.word;
+	}
+
+	return ret;
+}
 #endif
 
 /*
@@ -1166,6 +1313,7 @@ enum powerpc_regset {
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 	REGSET_TM_CGPR,		/* TM checkpointed GPR registers */
 	REGSET_TM_CFPR,		/* TM checkpointed FPR registers */
+	REGSET_TM_CVMX,		/* TM checkpointed VMX registers */
 #endif
 };
 
@@ -1212,6 +1360,11 @@ static const struct user_regset native_regsets[] = {
 		.size = sizeof(double), .align = sizeof(double),
 		.active = tm_cfpr_active, .get = tm_cfpr_get, .set = tm_cfpr_set
 	},
+	[REGSET_TM_CVMX] = {
+		.core_note_type = NT_PPC_TM_CVMX, .n = ELF_NVMX,
+		.size = sizeof(vector128), .align = sizeof(vector128),
+		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
+	},
 #endif
 };
 
@@ -1449,6 +1602,11 @@ static const struct user_regset compat_regsets[] = {
 		.size = sizeof(double), .align = sizeof(double),
 		.active = tm_cfpr_active, .get = tm_cfpr_get, .set = tm_cfpr_set
 	},
+	[REGSET_TM_CVMX] = {
+		.core_note_type = NT_PPC_TM_CVMX, .n = ELF_NVMX,
+		.size = sizeof(vector128), .align = sizeof(vector128),
+		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
+	},
 #endif
 };
 
-- 
2.1.0
