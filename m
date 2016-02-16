Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAF151A0019
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:01:48 +1100 (AEDT)
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7AD0D1401AF
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:48 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Feb 2016 19:01:48 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B38C5357805A
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:46 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1G91cri6160872
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:46 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1G91CpQ018087
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Feb 2016 20:01:14 +1100
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
Subject: [PATCH V10 05/28] powerpc,
 ptrace: Enable in transaction NT_PPC_VSX ptrace requests
Date: Tue, 16 Feb 2016 14:29:35 +0530
Message-Id: <1455613198-5113-6-git-send-email-khandual@linux.vnet.ibm.com>
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

This patch enables in transaction NT_PPC_VSX ptrace requests. The
function vsr_get which gets the running value of all VSX registers
and the function vsr_set which sets the running value of of all VSX
registers work on the running set of VMX registers whose location
will be different if transaction is active. This patch makes these
functions adapt to situations when the transaction is active.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 8e21e2c..255b598 100644
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
2.1.0
