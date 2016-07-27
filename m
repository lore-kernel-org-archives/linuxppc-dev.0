Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzqQt4Z9FzDrF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 19:27:50 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id h186so1521621pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jul 2016 02:27:50 -0700 (PDT)
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
Subject: [PATCH v12 05/30] powerpc/ptrace: Enable in transaction NT_PPC_VSX
 ptrace requests
Date: Wed, 27 Jul 2016 17:26:30 +0800
Message-Id: <1469611615-2935-6-git-send-email-wei.guo.simon@gmail.com>
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

This patch enables in transaction NT_PPC_VSX ptrace requests. The
function vsr_get which gets the running value of all VSX registers
and the function vsr_set which sets the running value of of all VSX
registers work on the running set of VMX registers whose location
will be different if transaction is active. This patch makes these
functions adapt to situations when the transaction is active.

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
 arch/powerpc/kernel/ptrace.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 3baa57e..ebf3b0e 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -681,6 +681,21 @@ static int vsr_active(struct task_struct *target,
 	return target->thread.used_vsr ? regset->n : 0;
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
+ *	u64	vsx[32];
+ * };
+ */
 static int vsr_get(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   void *kbuf, void __user *ubuf)
@@ -688,16 +703,47 @@ static int vsr_get(struct task_struct *target, const struct user_regset *regset,
 	u64 buf[32];
 	int ret, i;
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_tmregs_to_thread(target);
+#endif
 	flush_vsx_to_thread(target);
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
+		for (i = 0; i < 32 ; i++)
+			buf[i] = target->thread.
+				transact_fp.fpr[i][TS_VSRLOWOFFSET];
+	} else {
+		for (i = 0; i < 32 ; i++)
+			buf[i] = target->thread.
+				fp_state.fpr[i][TS_VSRLOWOFFSET];
+	}
+#else
 	for (i = 0; i < 32 ; i++)
 		buf[i] = target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET];
+#endif
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  buf, 0, 32 * sizeof(double));
 
 	return ret;
 }
 
+/*
+ * When the transaction is active, 'transact_fp' holds the current running
+ * value of all FPR registers and 'fp_state' holds the last checkpointed
+ * value of all FPR registers for the current transaction. When transaction
+ * is not active 'fp_state' holds the current running state of all the FPR
+ * registers. So this function which sets the current running values of all
+ * the FPR registers, needs to know whether any transaction is active or not.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	u64	vsx[32];
+ * };
+ */
 static int vsr_set(struct task_struct *target, const struct user_regset *regset,
 		   unsigned int pos, unsigned int count,
 		   const void *kbuf, const void __user *ubuf)
@@ -705,12 +751,30 @@ static int vsr_set(struct task_struct *target, const struct user_regset *regset,
 	u64 buf[32];
 	int ret,i;
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+	flush_tmregs_to_thread(target);
+#endif
 	flush_vsx_to_thread(target);
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 buf, 0, 32 * sizeof(double));
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
+		for (i = 0; i < 32 ; i++)
+			target->thread.transact_fp.
+				fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	} else {
+		for (i = 0; i < 32 ; i++)
+			target->thread.fp_state.
+				fpr[i][TS_VSRLOWOFFSET] = buf[i];
+	}
+#else
 	for (i = 0; i < 32 ; i++)
 		target->thread.fp_state.fpr[i][TS_VSRLOWOFFSET] = buf[i];
+#endif
 
 
 	return ret;
-- 
1.8.3.1
