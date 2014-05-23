Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5555D1A05E2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 May 2014 01:17:43 +1000 (EST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A3CB1400A0
 for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2014 01:17:42 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 23 May 2014 20:47:40 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7AB5BE004B
 for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2014 20:48:20 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s4NFI5JT39387330
 for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2014 20:48:05 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s4NFHaX7006484
 for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2014 20:47:37 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 peterz@infradead.org, akpm@linux-foundation.org, tglx@linutronix.de
Subject: [PATCH V3 3/3] powerpc,
 ptrace: Enable support for miscellaneous registers
Date: Fri, 23 May 2014 20:45:38 +0530
Message-Id: <1400858138-3939-4-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1400858138-3939-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, james.hogan@imgtec.com, avagin@openvz.org,
 Paul.Clothier@imgtec.com, palves@redhat.com, oleg@redhat.com,
 dhowells@redhat.com, davej@redhat.com, davem@davemloft.net
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
index 17642ef..63b883a 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -1149,6 +1149,76 @@ static int tm_cvmx_set(struct task_struct *target, const struct user_regset *reg
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
@@ -1169,6 +1239,7 @@ enum powerpc_regset {
 	REGSET_TM_CFPR,		/* TM checkpointed FPR */
 	REGSET_TM_CVMX,		/* TM checkpointed VMX */
 #endif
+	REGSET_MISC		/* Miscellaneous */
 };
 
 static const struct user_regset native_regsets[] = {
@@ -1225,6 +1296,11 @@ static const struct user_regset native_regsets[] = {
 		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
 	},
 #endif
+	[REGSET_MISC] = {
+		.core_note_type = NT_PPC_MISC, .n = 3,
+		.size = sizeof(u64), .align = sizeof(u64),
+		.get = misc_get, .set = misc_set
+	},
 };
 
 static const struct user_regset_view user_ppc_native_view = {
@@ -1566,6 +1642,11 @@ static const struct user_regset compat_regsets[] = {
 		.active = tm_cvmx_active, .get = tm_cvmx_get, .set = tm_cvmx_set
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
