Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DAFB1A074E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:09:02 +1000 (AEST)
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5F402140DCD
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:09:01 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:59 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D9E3D125805B
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:41:11 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8gxf000354
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:44 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8UMh028284
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:35 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 12/28] powerpc, ptrace: Enable NT_PPC_TM_CTAR,
 NT_PPC_TM_CPPR, NT_PPC_TM_CDSCR
Date: Tue, 19 May 2015 20:38:08 +0530
Message-Id: <1432048104-4695-13-git-send-email-khandual@linux.vnet.ibm.com>
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
index 228cdcf..774f5c20 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1541,6 +1541,151 @@ static int tm_spr_set(struct task_struct *target,
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
@@ -1564,6 +1709,9 @@ enum powerpc_regset {
 	REGSET_TM_CVMX,		/* TM checkpointed VMX registers */
 	REGSET_TM_CVSX,		/* TM checkpointed VSX registers */
 	REGSET_TM_SPR,		/* TM specific SPR registers */
+	REGSET_TM_CTAR,		/* TM checkpointed TAR register */
+	REGSET_TM_CPPR,		/* TM checkpointed PPR register */
+	REGSET_TM_CDSCR,	/* TM checkpointed DSCR register */
 #endif
 };
 
@@ -1625,6 +1773,21 @@ static const struct user_regset native_regsets[] = {
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
 
@@ -1877,6 +2040,21 @@ static const struct user_regset compat_regsets[] = {
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
