Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401371A05D8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 01:08:38 +1000 (AEST)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 98944140D58
 for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2015 01:08:37 +1000 (AEST)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 19 May 2015 20:38:35 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D16E5E005C
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:41:37 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4JF8XMB19464420
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4JF8QdQ027836
 for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2015 20:38:32 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH V8 05/28] powerpc,
 ptrace: Enable in transaction NT_PPC_VSX ptrace requests
Date: Tue, 19 May 2015 20:38:01 +0530
Message-Id: <1432048104-4695-6-git-send-email-khandual@linux.vnet.ibm.com>
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
index 1e6bff5..015f284 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -680,6 +680,21 @@ static int vsr_active(struct task_struct *target,
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
@@ -687,16 +702,47 @@ static int vsr_get(struct task_struct *target, const struct user_regset *regset,
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
@@ -704,12 +750,30 @@ static int vsr_set(struct task_struct *target, const struct user_regset *regset,
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
