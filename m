Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 112961A001B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:02:21 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 97668140A98
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:20 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 19:02:20 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id F135B2BB0057
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:17 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G929Re66388080
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:17 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G91gN7020058
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:45 +1100
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
Subject: [PATCH V10 12/28] powerpc, ptrace: Enable NT_PPC_TM_CTAR,
 NT_PPC_TM_CPPR, NT_PPC_TM_CDSCR
Date: Tue, 16 Feb 2016 14:29:42 +0530
Message-Id: <1455613198-5113-13-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables support for all three TM checkpointed SPR
states related ELF core note  NT_PPC_TM_CTAR, NT_PPC_TM_CPPR,
NT_PPC_TM_CDSCR based ptrace requests through PTRACE_GETREGSET,
PTRACE_SETREGSET calls. This is achieved through adding three
new register sets REGSET_TM_CTAR, REGSET_TM_CPPR and
REGSET_TM_CDSCR in powerpc corresponding to the ELF core note
sections added. It implements the get, set and active functions
for all these new register sets added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 178 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index b2dec4a..c3339a0 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1542,6 +1542,151 @@ static int tm_spr_set(struct task_struct *target,
 				 2 * sizeof(u64), 3 * sizeof(u64));
 	return ret;
 }
+
+static int tm_tar_active(struct task_struct *target,
+			 const struct user_regset *regset)
+{
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (MSR_TM_ACTIVE(target->thread.regs->msr))
+		return regset->n;
+
+	return 0;
+}
+
+static int tm_tar_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_tar, 0, sizeof(u64));
+	return ret;
+}
+
+static int tm_tar_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_tar, 0, sizeof(u64));
+	return ret;
+}
+
+static int tm_ppr_active(struct task_struct *target,
+			 const struct user_regset *regset)
+{
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (MSR_TM_ACTIVE(target->thread.regs->msr))
+		return regset->n;
+
+	return 0;
+}
+
+
+static int tm_ppr_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_ppr, 0, sizeof(u64));
+	return ret;
+}
+
+static int tm_ppr_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_ppr, 0, sizeof(u64));
+	return ret;
+}
+
+static int tm_dscr_active(struct task_struct *target,
+			 const struct user_regset *regset)
+{
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (MSR_TM_ACTIVE(target->thread.regs->msr))
+		return regset->n;
+
+	return 0;
+}
+
+static int tm_dscr_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_dscr, 0, sizeof(u64));
+	return ret;
+}
+
+static int tm_dscr_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tm_dscr, 0, sizeof(u64));
+	return ret;
+}
 #endif	/* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 /*
@@ -1565,6 +1710,9 @@ enum powerpc_regset {
 	REGSET_TM_CVMX,		/* TM checkpointed VMX registers */
 	REGSET_TM_CVSX,		/* TM checkpointed VSX registers */
 	REGSET_TM_SPR,		/* TM specific SPR registers */
+	REGSET_TM_CTAR,		/* TM checkpointed TAR register */
+	REGSET_TM_CPPR,		/* TM checkpointed PPR register */
+	REGSET_TM_CDSCR,	/* TM checkpointed DSCR register */
 #endif
 };
 
@@ -1626,6 +1774,21 @@ static const struct user_regset native_regsets[] = {
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = tm_spr_active, .get = tm_spr_get, .set = tm_spr_set
 	},
+	[REGSET_TM_CTAR] = {
+		.core_note_type = NT_PPC_TM_CTAR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = tm_tar_active, .get = tm_tar_get, .set = tm_tar_set
+	},
+	[REGSET_TM_CPPR] = {
+		.core_note_type = NT_PPC_TM_CPPR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = tm_ppr_active, .get = tm_ppr_get, .set = tm_ppr_set
+	},
+	[REGSET_TM_CDSCR] = {
+		.core_note_type = NT_PPC_TM_CDSCR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = tm_dscr_active, .get = tm_dscr_get, .set = tm_dscr_set
+	},
 #endif
 };
 
@@ -1878,6 +2041,21 @@ static const struct user_regset compat_regsets[] = {
 		.size = sizeof(u64), .align = sizeof(u64),
 		.active = tm_spr_active, .get = tm_spr_get, .set = tm_spr_set
 	},
+	[REGSET_TM_CTAR] = {
+		.core_note_type = NT_PPC_TM_CTAR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = tm_tar_active, .get = tm_tar_get, .set = tm_tar_set
+	},
+	[REGSET_TM_CPPR] = {
+		.core_note_type = NT_PPC_TM_CPPR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = tm_ppr_active, .get = tm_ppr_get, .set = tm_ppr_set
+	},
+	[REGSET_TM_CDSCR] = {
+		.core_note_type = NT_PPC_TM_CDSCR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.active = tm_dscr_active, .get = tm_dscr_get, .set = tm_dscr_set
+	},
 #endif
 };
 
-- 
2.1.0
