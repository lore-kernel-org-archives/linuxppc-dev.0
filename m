Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1FCB51A05E6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:08:43 +1000 (AEST)
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 558D5140D4E
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:08:42 +1000 (AEST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:40 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D77BCE005F
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:41:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8XG34587928
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8QhW027825
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 04/28] powerpc,
 ptrace: Enable in transaction NT_PPC_VMX ptrace requests
Date: Tue, 19 May 2015 20:38:00 +0530
Message-Id: <1432048104-4695-5-git-send-email-khandual@linux.vnet.ibm.com>
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
index d8a1388..1e6bff5 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -517,10 +517,28 @@ static int vr_active(struct task_struct *target,
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
@@ -528,8 +546,19 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
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
@@ -540,7 +569,16 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
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
@@ -548,10 +586,28 @@ static int vr_get(struct task_struct *target, const struct user_regset *regset,
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
@@ -559,8 +615,19 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
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
@@ -571,11 +638,28 @@ static int vr_set(struct task_struct *target, const struct user_regset *regset,
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
