Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 587781A0196
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:02:26 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BD22C1409B7
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:25 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 19:02:25 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 049FA2BB0059
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:22 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G92D5a40108230
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:02:21 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G91lkS020307
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:49 +1100
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
Subject: [PATCH V10 13/28] powerpc, ptrace: Enable support for NT_PPPC_TAR,
 NT_PPC_PPR, NT_PPC_DSCR
Date: Tue, 16 Feb 2016 14:29:43 +0530
Message-Id: <1455613198-5113-14-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables support for running TAR, PPR, DSCR registers
related ELF core notes NT_PPPC_TAR, NT_PPC_PPR, NT_PPC_DSCR based
ptrace requests through PTRACE_GETREGSET, PTRACE_SETREGSET calls.
This is achieved through adding three new register sets REGSET_TAR,
REGSET_PPR, REGSET_DSCR in powerpc corresponding to the ELF core
note sections added in this regad. It implements the get, set and
active functions for all these new register sets added.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 117 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index c3339a0..587f031 100644
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
2.1.0
