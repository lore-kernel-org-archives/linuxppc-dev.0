Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzqRp2M89zDrFc
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 19:28:38 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id hh10so1466773pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 02:28:38 -0700 (PDT)
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
Subject: [PATCH v12 13/30] powerpc/ptrace: Enable support for NT_PPPC_TAR,
 NT_PPC_PPR, NT_PPC_DSCR
Date: Wed, 27 Jul 2016 17:26:38 +0800
Message-Id: <1469611615-2935-14-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
References: <1469611615-2935-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch enables support for running TAR, PPR, DSCR registers
related ELF core notes NT_PPPC_TAR, NT_PPC_PPR, NT_PPC_DSCR based
ptrace requests through PTRACE_GETREGSET, PTRACE_SETREGSET calls.
This is achieved through adding three new register sets REGSET_TAR,
REGSET_PPR, REGSET_DSCR in powerpc corresponding to the ELF core
note sections added in this regad. It implements the get, set and
active functions for all these new register sets added.

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
 arch/powerpc/kernel/ptrace.c | 117 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 2ce5f86..c710060 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1689,6 +1689,78 @@ static int tm_dscr_set(struct task_struct *target,
 }
 #endif	/* CONFIG_PPC_TRANSACTIONAL_MEM */
 
+#ifdef CONFIG_PPC64
+static int ppr_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.ppr, 0, sizeof(u64));
+	return ret;
+}
+
+static int ppr_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.ppr, 0, sizeof(u64));
+	return ret;
+}
+
+static int dscr_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.dscr, 0, sizeof(u64));
+	return ret;
+}
+static int dscr_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.dscr, 0, sizeof(u64));
+	return ret;
+}
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+static int tar_get(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tar, 0, sizeof(u64));
+	return ret;
+}
+static int tar_set(struct task_struct *target,
+		      const struct user_regset *regset,
+		      unsigned int pos, unsigned int count,
+		      const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+				&target->thread.tar, 0, sizeof(u64));
+	return ret;
+}
+#endif
 /*
  * These are our native regset flavors.
  */
@@ -1714,6 +1786,13 @@ enum powerpc_regset {
 	REGSET_TM_CPPR,		/* TM checkpointed PPR register */
 	REGSET_TM_CDSCR,	/* TM checkpointed DSCR register */
 #endif
+#ifdef CONFIG_PPC64
+	REGSET_PPR,		/* PPR register */
+	REGSET_DSCR,		/* DSCR register */
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	REGSET_TAR,		/* TAR register */
+#endif
 };
 
 static const struct user_regset native_regsets[] = {
@@ -1790,6 +1869,25 @@ static const struct user_regset native_regsets[] = {
 		.active = tm_dscr_active, .get = tm_dscr_get, .set = tm_dscr_set
 	},
 #endif
+#ifdef CONFIG_PPC64
+	[REGSET_PPR] = {
+		.core_note_type = NT_PPC_PPR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = ppr_get, .set = ppr_set
+	},
+	[REGSET_DSCR] = {
+		.core_note_type = NT_PPC_DSCR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = dscr_get, .set = dscr_set
+	},
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	[REGSET_TAR] = {
+		.core_note_type = NT_PPC_TAR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = tar_get, .set = tar_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_ppc_native_view = {
@@ -2057,6 +2155,25 @@ static const struct user_regset compat_regsets[] = {
 		.active = tm_dscr_active, .get = tm_dscr_get, .set = tm_dscr_set
 	},
 #endif
+#ifdef CONFIG_PPC64
+	[REGSET_PPR] = {
+		.core_note_type = NT_PPC_PPR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = ppr_get, .set = ppr_set
+	},
+	[REGSET_DSCR] = {
+		.core_note_type = NT_PPC_DSCR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = dscr_get, .set = dscr_set
+	},
+#endif
+#ifdef CONFIG_PPC_BOOK3S_64
+	[REGSET_TAR] = {
+		.core_note_type = NT_PPC_TAR, .n = 1,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = tar_get, .set = tar_set
+	},
+#endif
 };
 
 static const struct user_regset_view user_ppc_compat_view = {
-- 
1.8.3.1
