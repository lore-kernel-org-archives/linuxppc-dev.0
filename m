Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 826DC1A0616
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:10:59 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CDBF7140B0E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:10:58 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:40:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 6DBB5E004C
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:43:58 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JFAKPN64356396
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:40:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8SD4028086
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:33 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 10/28] powerpc, ptrace: Enable support for NT_PPC_CVSX
Date: Tue, 19 May 2015 20:38:06 +0530
Message-Id: <1432048104-4695-11-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables support for TM checkpointed VSX register
set ELF core note NT_PPC_CVSX based ptrace requests through
PTRACE_GETREGSET, PTRACE_SETREGSET calls. This is achieved
through adding a register set REGSET_CVSX in powerpc
corresponding to the ELF core note section added. It
implements the get, set and active functions for this new
register set added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/elf.h |   1 +
 arch/powerpc/kernel/ptrace.c        | 129 ++++++++++++++++++++++++++++++++++++
 2 files changed, 130 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 6c900be..4477318 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -92,6 +92,7 @@
 #define ELF_NGREG	48	/* includes nip, msr, lr, etc. */
 #define ELF_NFPREG	33	/* includes fpscr */
 #define ELF_NVMX	34	/* includes all vector registers */
+#define ELF_NVSX	32	/* includes all VSX registers */
 
 typedef unsigned long elf_greg_t64;
 typedef elf_greg_t64 elf_gregset_t64[ELF_NGREG];
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 4faad8c..3497d26 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -64,6 +64,7 @@ struct pt_regs_offset {
 #define REG_OFFSET_END {.name = NULL, .offset = 0}
 
 #define TVSO(f)	(offsetof(struct thread_vr_state, f))
+#define TFSO(f)	(offsetof(struct thread_fp_state, f))
 
 static const struct pt_regs_offset regoffset_table[] = {
 	GPR_OFFSET_NAME(0),
@@ -1293,6 +1294,123 @@ static int tm_cvmx_set(struct task_struct *target,
 
 	return ret;
 }
+
+/**
+ * tm_cvsx_active - get active number of registers in CVSX
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ *
+ * This function checks for the active number of available
+ * regisers in transaction checkpointed VSX category.
+ */
+static int tm_cvsx_active(struct task_struct *target,
+				const struct user_regset *regset)
+{
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return 0;
+
+	flush_vsx_to_thread(target);
+	return target->thread.used_vsr ? regset->n : 0;
+}
+
+/**
+ * tm_cvsx_get - get CVSX registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy from.
+ * @ubuf:	User buffer to copy into.
+ *
+ * This function gets in transaction checkpointed VSX registers.
+ *
+ * When the transaction is active 'fp_state' holds the checkpointed
+ * values for the current transaction to fall back on if it aborts
+ * in between. This function gets those checkpointed VSX registers.
+ * The userspace interface buffer layout is as follows.
+ *
+ * struct data {
+ *	u64	vsx[32];
+ *};
+ */
+static int tm_cvsx_get(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			void *kbuf, void __user *ubuf)
+{
+	u64 buf[32];
+	int ret, i;
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
+	flush_vsx_to_thread(target);
+
+	for (i = 0; i < 32 ; i++)
+		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				  buf, 0, 32 * sizeof(double));
+
+	return ret;
+}
+
+/**
+ * tm_cvsx_set - set CFPR registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy into.
+ * @ubuf:	User buffer to copy from.
+ *
+ * This function sets in transaction checkpointed VSX registers.
+ *
+ * When the transaction is active 'fp_state' holds the checkpointed
+ * VSX register values for the current transaction to fall back on
+ * if it aborts in between. This function sets these checkpointed
+ * FPR registers. The userspace interface buffer layout is as follows.
+ *
+ * struct data {
+ *	u64	vsx[32];
+ *};
+ */
+static int tm_cvsx_set(struct task_struct *target,
+			const struct user_regset *regset,
+			unsigned int pos, unsigned int count,
+			const void *kbuf, const void __user *ubuf)
+{
+	u64 buf[32];
+	int ret, i;
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
+	flush_vsx_to_thread(target);
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				 buf, 0, 32 * sizeof(double));
+	for (i = 0; i < 32 ; i++)
+		target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+
+	return ret;
+}
 #endif
 
 /*
@@ -1314,6 +1432,7 @@ enum powerpc_regset {
 	REGSET_TM_CGPR,		/* TM checkpointed GPR registers */
 	REGSET_TM_CFPR,		/* TM checkpointed FPR registers */
 	REGSET_TM_CVMX,		/* TM checkpointed VMX registers */
+	REGSET_TM_CVSX,		/* TM checkpointed VSX registers */
 #endif
 };
 
@@ -1365,6 +1484,11 @@ static const struct user_regset native_regsets[] = {
 		.size = sizeof(vector128), .align = sizeof(vector128),
 		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
 	},
+	[REGSET_TM_CVSX] = {
+		.core_note_type = NT_PPC_TM_CVSX, .n = ELF_NVSX,
+		.size = sizeof(double), .align = sizeof(double),
+		.active = tm_cvsx_active, .get = tm_cvsx_get, .set = tm_cvsx_set
+	},
 #endif
 };
 
@@ -1607,6 +1731,11 @@ static const struct user_regset compat_regsets[] = {
 		.size = sizeof(vector128), .align = sizeof(vector128),
 		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
 	},
+	[REGSET_TM_CVSX] = {
+		.core_note_type = NT_PPC_TM_CVSX, .n = ELF_NVSX,
+		.size = sizeof(double), .align = sizeof(double),
+		.active = tm_cvsx_active, .get = tm_cvsx_get, .set = tm_cvsx_set
+	},
 #endif
 };
 
-- 
2.1.0
