Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 334F71A01F2
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 01:49:10 +1100 (AEDT)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 29E93140D72
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:49:09 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 9 Oct 2015 00:49:08 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3A394357804F
 for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2015 01:49:06 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t98Emr8g23068864
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:49:01 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t98EmTdE005768
 for <linuxppc-dev@ozlabs.org>; Fri, 9 Oct 2015 01:48:34 +1100
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
Subject: [PATCH V9 03/28] powerpc,
 ptrace: Enable in transaction NT_PRFPREG ptrace requests
Date: Thu,  8 Oct 2015 20:17:24 +0530
Message-Id: <1444315669-23487-4-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables in transaction NT_PRFPREG ptrace requests.
The function fpr_get which gets the running value of all FPR
registers and the function fpr_set which sets the running
value of of all FPR registers work on the running set of FPR
registers whose location will be different if transaction is
active. This patch makes these functions adapt to situations
when the transaction is active.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 93 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 737c0d0..0ddaddd 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -357,6 +357,29 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
+/*
+ * When the transaction is active, 'transact_fp' holds the current running
+ * value of all FPR registers and 'fp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction. When transaction
+ * is not active 'fp_state' holds the current running state of all the FPR
+ * registers. So this function which returns the current running values of
+ * all the FPR registers, needs to know whether any transaction is active
+ * or not.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ *
+ * There are two config options CONFIG_VSX and CONFIG_PPC_TRANSACTIONAL_MEM
+ * which determines the final code in this function. All the combinations of
+ * these two config options are possible except the one below as transactional
+ * memory config pulls in CONFIG_VSX automatically.
+ *
+ *	!defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
+ */
 static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
@@ -367,14 +390,31 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 #endif
 	flush_fp_to_thread(target);
 
-#ifdef CONFIG_VSX
+#if defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
+	/* copy to local buffer then write that out */
+	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
+		flush_altivec_to_thread(target);
+		flush_tmregs_to_thread(target);
+		for (i = 0; i < 32 ; i++)
+			buf[i] = target->thread.TS_TRANS_FPR(i);
+		buf[32] = target->thread.transact_fp.fpscr;
+	} else {
+		for (i = 0; i < 32 ; i++)
+			buf[i] = target->thread.TS_FPR(i);
+		buf[32] = target->thread.fp_state.fpscr;
+	}
+	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+#endif
+
+#if defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
 	/* copy to local buffer then write that out */
 	for (i = 0; i < 32 ; i++)
 		buf[i] = target->thread.TS_FPR(i);
 	buf[32] = target->thread.fp_state.fpscr;
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+#endif
 
-#else
+#if !defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
 		     offsetof(struct thread_fp_state, fpr[32][0]));
 
@@ -383,6 +423,29 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
 #endif
 }
 
+/*
+ * When the transaction is active, 'transact_fp' holds the current running
+ * value of all FPR registers and 'fp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction. When transaction
+ * is not active 'fp_state' holds the current running state of all the FPR
+ * registers. So this function which setss the current running values of
+ * all the FPR registers, needs to know whether any transaction is active
+ * or not.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	fpr[32];
+ *	u64	fpscr;
+ * };
+ *
+ * There are two config options CONFIG_VSX and CONFIG_PPC_TRANSACTIONAL_MEM
+ * which determines the final code in this function. All the combinations of
+ * these two config options are possible except the one below as transactional
+ * memory config pulls in CONFIG_VSX automatically.
+ *
+ *	!defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
+ */
 static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
@@ -393,7 +456,27 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 #endif
 	flush_fp_to_thread(target);
 
-#ifdef CONFIG_VSX
+#if defined(CONFIG_VSX) && defined(CONFIG_PPC_TRANSACTIONAL_MEM)
+	/* copy to local buffer then write that out */
+	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
+	if (i)
+		return i;
+
+	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
+		flush_altivec_to_thread(target);
+		flush_tmregs_to_thread(target);
+		for (i = 0; i < 32 ; i++)
+			target->thread.TS_TRANS_FPR(i) = buf[i];
+		target->thread.transact_fp.fpscr = buf[32];
+	} else {
+		for (i = 0; i < 32 ; i++)
+			target->thread.TS_FPR(i) = buf[i];
+		target->thread.fp_state.fpscr = buf[32];
+	}
+	return 0;
+#endif
+
+#if defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
 	/* copy to local buffer then write that out */
 	i = user_regset_copyin(&pos, &count, &kbuf, &ubuf, buf, 0, -1);
 	if (i)
@@ -402,7 +485,9 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 		target->thread.TS_FPR(i) = buf[i];
 	target->thread.fp_state.fpscr = buf[32];
 	return 0;
-#else
+#endif
+
+#if !defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
 		     offsetof(struct thread_fp_state, fpr[32][0]));
 
-- 
2.1.0
