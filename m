Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0GlS6R6lzDrLF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 12:58:44 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id i6so2839478pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 19:58:44 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Shuah Khan <shuahkh@osg.samsung.com>, Anton Blanchard <anton@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>,
 Ulrich Weigand <ulrich.weigand@de.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Rashmica Gupta <rashmicy@gmail.com>,
 Khem Raj <raj.khem@gmail.com>, Jessica Yu <jeyu@redhat.com>,
 Jiri Kosina <jkosina@suse.cz>, Miroslav Benes <mbenes@suse.cz>,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 Chris Smart <chris@distroguy.com>, linux-kselftest@vger.kernel.org
Subject: [PATCH v13 03/30] powerpc/ptrace: Enable in transaction NT_PRFPREG
 ptrace requests
Date: Thu, 28 Jul 2016 10:57:32 +0800
Message-Id: <1469674679-8580-4-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
References: <1469674679-8580-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anshuman Khandual <khandual@linux.vnet.ibm.com>

This patch enables in transaction NT_PRFPREG ptrace requests.
The function fpr_get which gets the running value of all FPR
registers and the function fpr_set which sets the running
value of of all FPR registers work on the running set of FPR
registers whose location will be different if transaction is
active. This patch makes these functions adapt to situations
when the transaction is active.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 arch/powerpc/kernel/ptrace.c | 93 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 89 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 060b140..82db082 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -358,6 +358,29 @@ static int gpr_set(struct task_struct *target, const struct user_regset *regset,
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
@@ -368,14 +391,31 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
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
 		     offsetof(struct thread_fp_state, fpr[32]));
 
@@ -384,6 +424,29 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
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
@@ -394,7 +457,27 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
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
@@ -403,7 +486,9 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
 		target->thread.TS_FPR(i) = buf[i];
 	target->thread.fp_state.fpscr = buf[32];
 	return 0;
-#else
+#endif
+
+#if !defined(CONFIG_VSX) && !defined(CONFIG_PPC_TRANSACTIONAL_MEM)
 	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
 		     offsetof(struct thread_fp_state, fpr[32]));
 
-- 
1.8.3.1
