Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B8C91A00A2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:01:45 +1100 (AEDT)
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3696D140779
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:45 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 19:01:44 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 2960D3578052
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:43 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G91Z2f27590758
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:43 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G918Sd017993
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:10 +1100
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
Subject: [PATCH V10 04/28] powerpc,
 ptrace: Enable in transaction NT_PPC_VMX ptrace requests
Date: Tue, 16 Feb 2016 14:29:34 +0530
Message-Id: <1455613198-5113-5-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables in transaction NT_PPC_VMX ptrace requests. The
function vr_get which gets the running value of all VMX registers
and the function vr_set which sets the running value of of all VMX
registers work on the running set of VMX registers whose location
will be different if transaction is active. This patch makes these
functions adapt to situations when the transaction is active.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 90 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 87 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 547a979..8e21e2c 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -518,10 +518,28 @@ static int vr_active(struct task_struct *target,
 	return target->thread.used_vr ? regset->n : 0;
 }
 
+/*
+ * When the transaction is active, 'transact_vr' holds the current running
+ * value of all the VMX registers and 'vr_state' holds the last checkpointed
+ * value of all the VMX registers for the current transaction to fall back
+ * on in case it aborts. When transaction is not active 'vr_state' holds
+ * the current running state of all the VMX registers. So this function which
+ * gets the current running values of all the VMX registers, needs to know
+ * whether any transaction is active or not.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	vector128	vr[32];
+ *	vector128	vscr;
+ *	vector128	vrsave;
+ * };
+ */
 static int vr_get(struct task_struct *target, const struct user_regset *regset,
 		  unsigned int pos, unsigned int count,
 		  void *kbuf, void __user *ubuf)
 {
+	struct thread_vr_state *addr;
 	int ret;
 
 	flush_altivec_to_thread(target);
@@ -529,8 +547,19 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 	BUILD_BUG_ON(offsetof(struct thread_vr_state, vscr) !=
 		     offsetof(struct thread_vr_state, vr[32]));
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
+		flush_fp_to_thread(target);
+		flush_tmregs_to_thread(target);
+		addr = &target->thread.transact_vr;
+	} else {
+		addr = &target->thread.vr_state;
+	}
+#else
+	addr = &target->thread.vr_state;
+#endif
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.vr_state, 0,
+				  addr, 0,
 				  33 * sizeof(vector128));
 	if (!ret) {
 		/*
@@ -541,7 +570,16 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 			u32 word;
 		} vrsave;
 		memset(&vrsave, 0, sizeof(vrsave));
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+		if (MSR_TM_ACTIVE(target->thread.regs->msr))
+			vrsave.word = target->thread.transact_vrsave;
+		else
+			vrsave.word = target->thread.vrsave;
+#else
 		vrsave.word = target->thread.vrsave;
+#endif
+
 		ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &vrsave,
 					  33 * sizeof(vector128), -1);
 	}
@@ -549,10 +587,28 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
 	return ret;
 }
 
+/*
+ * When the transaction is active, 'transact_vr' holds the current running
+ * value of all the VMX registers and 'vr_state' holds the last checkpointed
+ * value of all the VMX registers for the current transaction to fall back
+ * on in case it aborts. When transaction is not active 'vr_state' holds
+ * the current running state of all the VMX registers. So this function which
+ * sets the current running values of all the VMX registers, needs to know
+ * whether any transaction is active or not.
+ *
+ * Userspace interface buffer layout:
+ *
+ * struct data {
+ *	vector128	vr[32];
+ *	vector128	vscr;
+ *	vector128	vrsave;
+ * };
+ */
 static int vr_set(struct task_struct *target, const struct user_regset *regset,
 		  unsigned int pos, unsigned int count,
 		  const void *kbuf, const void __user *ubuf)
 {
+	struct thread_vr_state *addr;
 	int ret;
 
 	flush_altivec_to_thread(target);
@@ -560,8 +616,19 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 	BUILD_BUG_ON(offsetof(struct thread_vr_state, vscr) !=
 		     offsetof(struct thread_vr_state, vr[32]));
 
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+	if (MSR_TM_ACTIVE(target->thread.regs->msr)) {
+		flush_fp_to_thread(target);
+		flush_tmregs_to_thread(target);
+		addr = &target->thread.transact_vr;
+	} else {
+		addr = &target->thread.vr_state;
+	}
+#else
+	addr = &target->thread.vr_state;
+#endif
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				 &target->thread.vr_state, 0,
+				 addr, 0,
 				 33 * sizeof(vector128));
 	if (!ret && count > 0) {
 		/*
@@ -572,11 +639,28 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
 			u32 word;
 		} vrsave;
 		memset(&vrsave, 0, sizeof(vrsave));
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+		if (MSR_TM_ACTIVE(target->thread.regs->msr))
+			vrsave.word = target->thread.transact_vrsave;
+		else
+			vrsave.word = target->thread.vrsave;
+#else
 		vrsave.word = target->thread.vrsave;
+#endif
 		ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &vrsave,
 					 33 * sizeof(vector128), -1);
-		if (!ret)
+		if (!ret) {
+
+#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
+			if (MSR_TM_ACTIVE(target->thread.regs->msr))
+				target->thread.transact_vrsave = vrsave.word;
+			else
+				target->thread.vrsave = vrsave.word;
+#else
 			target->thread.vrsave = vrsave.word;
+#endif
+		}
 	}
 
 	return ret;
-- 
2.1.0
