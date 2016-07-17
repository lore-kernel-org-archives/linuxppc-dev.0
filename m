Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
 [209.85.220.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rsV2F1TYhzDqLQ
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 12:03:01 +1000 (AEST)
Received: by mail-pa0-f66.google.com with SMTP id hh10so8574737pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jul 2016 19:03:01 -0700 (PDT)
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
Subject: [PATCH v11 09/27] powerpc/ptrace: Enable NT_PPC_TM_CTAR,
 NT_PPC_TM_CPPR, NT_PPC_TM_CDSCR
Date: Sun, 17 Jul 2016 09:59:42 +0800
Message-Id: <1468720800-2950-10-git-send-email-wei.guo.simon@gmail.com>
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

This patch enables support for all three TM checkpointed SPR
states related ELF core note  NT_PPC_TM_CTAR, NT_PPC_TM_CPPR,
NT_PPC_TM_CDSCR based ptrace requests through PTRACE_GETREGSET,
PTRACE_SETREGSET calls. This is achieved through adding three
new register sets REGSET_TM_CTAR, REGSET_TM_CPPR and
REGSET_TM_CDSCR in powerpc corresponding to the ELF core note
sections added. It implements the get, set and active functions
for all these new register sets added.

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
 arch/powerpc/kernel/ptrace.c | 178 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 66bb46a..f0dcfb5 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1309,6 +1309,151 @@ static int tm_spr_set(struct task_struct *target,
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
@@ -1332,6 +1477,9 @@ enum powerpc_regset {
 	REGSET_TM_CVMX,		/* TM checkpointed VMX registers */
 	REGSET_TM_CVSX,		/* TM checkpointed VSX registers */
 	REGSET_TM_SPR,		/* TM specific SPR registers */
+	REGSET_TM_CTAR,		/* TM checkpointed TAR register */
+	REGSET_TM_CPPR,		/* TM checkpointed PPR register */
+	REGSET_TM_CDSCR,	/* TM checkpointed DSCR register */
 #endif
 };
 
@@ -1393,6 +1541,21 @@ static const struct user_regset native_regsets[] = {
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
 
@@ -1645,6 +1808,21 @@ static const struct user_regset compat_regsets[] = {
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
1.8.3.1
