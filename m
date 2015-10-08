Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 65F341A0246
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 01:49:53 +1100 (AEDT)
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A8BB6140DA0
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:49:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 00:49:52 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 8C3EF3578056
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:49:49 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t98EnfAB45023478
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:49:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98EnEfW007181
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:49:17 +1100
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
Subject: [PATCH V9 11/28] powerpc, ptrace: Enable support for TM SPR state
Date: Thu,  8 Oct 2015 20:17:32 +0530
Message-Id: <1444315669-23487-12-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables support for TM SPR state related ELF core
note NT_PPC_TM_SPR based ptrace requests through PTRACE_GETREGSET,
PTRACE_SETREGSET calls. This is achieved through adding a register
set REGSET_TM_SPR in powerpc corresponding to the ELF core note
section added. It implements the get, set and active functions for
this new register set added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/uapi/asm/elf.h |   1 +
 arch/powerpc/kernel/ptrace.c        | 143 +++++++++++++++++++++++++++++++++++-
 2 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/elf.h b/arch/powerpc/include/uapi/asm/elf.h
index 4477318..9e6b6e3 100644
--- a/arch/powerpc/include/uapi/asm/elf.h
+++ b/arch/powerpc/include/uapi/asm/elf.h
@@ -93,6 +93,7 @@
 #define ELF_NFPREG	33	/* includes fpscr */
 #define ELF_NVMX	34	/* includes all vector registers */
 #define ELF_NVSX	32	/* includes all VSX registers */
+#define ELF_NTMSPRREG	3	/* include tfhar, tfiar, texasr */
 
 typedef unsigned long elf_greg_t64;
 typedef elf_greg_t64 elf_gregset_t64[ELF_NGREG];
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index d8c08a9..787b514 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -65,6 +65,7 @@ struct pt_regs_offset {
 
 #define TVSO(f)	(offsetof(struct thread_vr_state, f))
 #define TFSO(f)	(offsetof(struct thread_fp_state, f))
+#define TSO(f)	(offsetof(struct thread_struct, f))
 
 static const struct pt_regs_offset regoffset_table[] = {
 	GPR_OFFSET_NAME(0),
@@ -1411,7 +1412,136 @@ static int tm_cvsx_set(struct task_struct *target,
 
 	return ret;
 }
-#endif
+
+/**
+ * tm_spr_active - get active number of registers in TM SPR
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ *
+ * This function checks the active number of available
+ * regisers in the transactional memory SPR category.
+ */
+static int tm_spr_active(struct task_struct *target,
+			 const struct user_regset *regset)
+{
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	return regset->n;
+}
+
+/**
+ * tm_spr_get - get the TM related SPR registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy from.
+ * @ubuf:	User buffer to copy into.
+ *
+ * This function gets transactional memory related SPR registers.
+ * The userspace interface buffer layout is as follows.
+ *
+ * struct {
+ *	u64		tm_tfhar;
+ *	u64		tm_texasr;
+ *	u64		tm_tfiar;
+ * };
+ */
+static int tm_spr_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	/* Build tests */
+	BUILD_BUG_ON(TSO(tm_tfhar) + sizeof(u64) != TSO(tm_texasr));
+	BUILD_BUG_ON(TSO(tm_texasr) + sizeof(u64) != TSO(tm_tfiar));
+	BUILD_BUG_ON(TSO(tm_tfiar) + sizeof(u64) != TSO(ckpt_regs));
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	/* Flush the states */
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_tmregs_to_thread(target);
+
+	/* TFHAR register */
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_tfhar, 0, sizeof(u64));
+
+	/* TEXASR register */
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_texasr, sizeof(u64),
+				2 * sizeof(u64));
+
+	/* TFIAR register */
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_tfiar,
+				2 * sizeof(u64), 3 * sizeof(u64));
+	return ret;
+}
+
+/**
+ * tm_spr_set - set the TM related SPR registers
+ * @target:	The target task.
+ * @regset:	The user regset structure.
+ * @pos:	The buffer position.
+ * @count:	Number of bytes to copy.
+ * @kbuf:	Kernel buffer to copy into.
+ * @ubuf:	User buffer to copy from.
+ *
+ * This function sets transactional memory related SPR registers.
+ * The userspace interface buffer layout is as follows.
+ *
+ * struct {
+ *	u64		tm_tfhar;
+ *	u64		tm_texasr;
+ *	u64		tm_tfiar;
+ * };
+ */
+static int tm_spr_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	/* Build tests */
+	BUILD_BUG_ON(TSO(tm_tfhar) + sizeof(u64) != TSO(tm_texasr));
+	BUILD_BUG_ON(TSO(tm_texasr) + sizeof(u64) != TSO(tm_tfiar));
+	BUILD_BUG_ON(TSO(tm_tfiar) + sizeof(u64) != TSO(ckpt_regs));
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	/* Flush the states */
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_tmregs_to_thread(target);
+
+	/* TFHAR register */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_tfhar, 0, sizeof(u64));
+
+	/* TEXASR register */
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_texasr, sizeof(u64),
+				2 * sizeof(u64));
+
+	/* TFIAR register */
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_tfiar,
+				 2 * sizeof(u64), 3 * sizeof(u64));
+	return ret;
+}
+#endif	/* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 /*
  * These are our native regset flavors.
@@ -1433,6 +1563,7 @@ enum powerpc_regset {
 	REGSET_TM_CFPR,		/* TM checkpointed FPR registers */
 	REGSET_TM_CVMX,		/* TM checkpointed VMX registers */
 	REGSET_TM_CVSX,		/* TM checkpointed VSX registers */
+	REGSET_TM_SPR,		/* TM specific SPR registers */
 #endif
 };
 
@@ -1489,6 +1620,11 @@ static const struct user_regset native_regsets[] = {
 		.size = sizeof(double), .align = sizeof(double),
 		.active = tm_cvsx_active, .get = tm_cvsx_get, .set = tm_cvsx_set
 	},
+	[REGSET_TM_SPR] = {
+		.core_note_type = NT_PPC_TM_SPR, .n = ELF_NTMSPRREG,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = tm_spr_active, .get = tm_spr_get, .set = tm_spr_set
+	},
 #endif
 };
 
@@ -1736,6 +1872,11 @@ static const struct user_regset compat_regsets[] = {
 		.size = sizeof(double), .align = sizeof(double),
 		.active = tm_cvsx_active, .get = tm_cvsx_get, .set = tm_cvsx_set
 	},
+	[REGSET_TM_SPR] = {
+		.core_note_type = NT_PPC_TM_SPR, .n = ELF_NTMSPRREG,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = tm_spr_active, .get = tm_spr_get, .set = tm_spr_set
+	},
 #endif
 };
 
-- 
2.1.0
