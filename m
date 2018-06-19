Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419Jc51nmjzF0wj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 05:55:49 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5JJtiXB085130
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 15:55:46 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jq7jwhy3t-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 15:55:45 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Tue, 19 Jun 2018 13:54:39 -0600
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH 1/2] powerpc: Flush checkpointed gpr state for 32-bit
 processes in ptrace
Date: Tue, 19 Jun 2018 16:54:28 -0300
In-Reply-To: <87d0wvtolp.fsf@concordia.ellerman.id.au>
References: <87d0wvtolp.fsf@concordia.ellerman.id.au>
Message-Id: <20180619195429.22925-1-pedromfc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Would something like this be ok?

I factored out the calls to flush_fp_to_thread and flush_altivec_to_thread,
although I don't really understand why these are necessary. The tm_cvsx_get/set
functions also calls flush_vsx_to_thread (outside of the helper function).

I also noticed that tm_ppr/dscr/tar_get/set functions don't flush the tm
state. Should they do it, and if so, should they also flush the fp and altivec
state?

Thanks!
Pedro

-- >8 --
Currently ptrace doesn't flush the register state when the
checkpointed GPRs of a 32-bit thread are accessed. This can cause core
dumps to have stale data in the checkpointed GPR note.

This patch adds a helper function to flush the TM, fpu and altivec
state and calls it from the tm_cgpr32_get/set functions.

Signed-off-by: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 9667666eb18e..0d56857e1e89 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -778,6 +778,29 @@ static int evr_set(struct task_struct *target, const struct user_regset *regset,
 
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 /**
+ * tm_flush_if_active - flush TM, fpu and altivec state if TM active
+ * @target:	The target task.
+ *
+ * This function flushes the TM, fpu and altivec state to the target
+ * task and returns 0 if TM is available and active in the target, and
+ * returns an error code suitable for ptrace otherwise.
+ */
+static int tm_flush_if_active (struct task_struct *target)
+{
+	if (!cpu_has_feature(CPU_FTR_TM))
+		return -ENODEV;
+
+	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
+		return -ENODATA;
+
+	flush_tmregs_to_thread(target);
+	flush_fp_to_thread(target);
+	flush_altivec_to_thread(target);
+
+	return 0;
+}
+
+/**
  * tm_cgpr_active - get active number of registers in CGPR
  * @target:	The target task.
  * @regset:	The user regset structure.
@@ -2124,6 +2147,11 @@ static int tm_cgpr32_get(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     void *kbuf, void __user *ubuf)
 {
+	int ret = tm_flush_if_active(target);
+
+	if (ret)
+		return ret;
+
 	return gpr32_get_common(target, regset, pos, count, kbuf, ubuf,
 			&target->thread.ckpt_regs.gpr[0]);
 }
@@ -2133,6 +2161,11 @@ static int tm_cgpr32_set(struct task_struct *target,
 		     unsigned int pos, unsigned int count,
 		     const void *kbuf, const void __user *ubuf)
 {
+	int ret = tm_flush_if_active(target);
+
+	if (ret)
+		return ret;
+
 	return gpr32_set_common(target, regset, pos, count, kbuf, ubuf,
 			&target->thread.ckpt_regs.gpr[0]);
 }
-- 
2.13.6
