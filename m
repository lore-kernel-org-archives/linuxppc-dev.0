Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 602AD140FD7
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 17:56:59 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 5 May 2014 13:26:57 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DEA5F1258056
 for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2014 13:25:50 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s457uw3K57606380
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 13:26:58 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s457ureq015973
 for <linuxppc-dev@ozlabs.org>; Mon, 5 May 2014 13:26:54 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] powerpc,
 ptrace: Enable support for miscellaneous registers
Date: Mon,  5 May 2014 13:24:29 +0530
Message-Id: <1399276469-13541-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, avagin@openvz.org, palves@redhat.com, oleg@redhat.com,
 michael@ellerman.id.au, roland@redhat.com,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables get and set of miscellaneous registers through ptrace
PTRACE_GETREGSET/PTRACE_SETREGSET interface by implementing new powerpc
specific register set REGSET_MISC support corresponding to the new ELF
core note NT_PPC_MISC added previously in this regard.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 92faded..3332dd8 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1054,6 +1054,76 @@ static int tm_cvmx_set(struct task_struct *target, const struct user_regset *reg
 #endif	/* CONFIG_PPC_TRANSACTIONAL_MEM */
 
 /*
+ * Miscellaneous Registers
+ *
+ * struct {
+ * 	unsigned long dscr;
+ *	unsigned long ppr;
+ * 	unsigned long tar;
+ * };
+ */
+static int misc_get(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   void *kbuf, void __user *ubuf)
+{
+	int ret;
+
+	/* DSCR register */
+	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					&target->thread.dscr, 0,
+					sizeof(unsigned long));
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, dscr) + sizeof(unsigned long) +
+				sizeof(unsigned long) != offsetof(struct thread_struct, ppr));
+
+	/* PPR register */
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.ppr, sizeof(unsigned long),
+					  2 * sizeof(unsigned long));
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, ppr) + sizeof(unsigned long)
+						!= offsetof(struct thread_struct, tar));
+	/* TAR register */
+	if (!ret)
+		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
+					  &target->thread.tar, 2 * sizeof(unsigned long),
+					  3 * sizeof(unsigned long));
+	return ret;
+}
+
+static int misc_set(struct task_struct *target, const struct user_regset *regset,
+		   unsigned int pos, unsigned int count,
+		   const void *kbuf, const void __user *ubuf)
+{
+	int ret;
+
+	/* DSCR register */
+	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+					&target->thread.dscr, 0,
+					sizeof(unsigned long));
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, dscr) + sizeof(unsigned long) +
+			sizeof(unsigned long) != offsetof(struct thread_struct, ppr));
+
+	/* PPR register */
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+						&target->thread.ppr, sizeof(unsigned long),
+						2 * sizeof(unsigned long));
+
+	BUILD_BUG_ON(offsetof(struct thread_struct, ppr) + sizeof(unsigned long)
+						!= offsetof(struct thread_struct, tar));
+
+	/* TAR register */
+	if (!ret)
+		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
+						&target->thread.tar, 2 * sizeof(unsigned long),
+						3 * sizeof(unsigned long));
+	return ret;
+}
+
+/*
  * These are our native regset flavors.
  */
 enum powerpc_regset {
@@ -1074,6 +1144,7 @@ enum powerpc_regset {
 	REGSET_TM_CFPR,		/* TM checkpointed FPR */
 	REGSET_TM_CVMX,		/* TM checkpointed VMX */
 #endif
+	REGSET_MISC		/* Miscellaneous */
 };
 
 static const struct user_regset native_regsets[] = {
@@ -1130,6 +1201,11 @@ static const struct user_regset native_regsets[] = {
 		.get = tm_cvmx_get, .set = tm_cvmx_set
 	},
 #endif
+	[REGSET_MISC] = {
+		.core_note_type = NT_PPC_MISC, .n = 3,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = misc_get, .set = misc_set
+	},
 };
 
 static const struct user_regset_view user_ppc_native_view = {
@@ -1459,6 +1535,11 @@ static const struct user_regset compat_regsets[] = {
 		.get = tm_cvmx_get, .set = tm_cvmx_set
 	},
 #endif
+	[REGSET_MISC] = {
+		.core_note_type = NT_PPC_MISC, .n = 3,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = misc_get, .set = misc_set
+	},
 };
 
 static const struct user_regset_view user_ppc_compat_view = {
-- 
1.7.11.7
