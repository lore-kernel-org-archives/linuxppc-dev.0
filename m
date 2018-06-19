Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419JZn6X2HzF0fX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 05:54:41 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5JJrvmL134191
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 15:54:39 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jq70k3aqb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 15:54:38 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Tue, 19 Jun 2018 13:54:38 -0600
From: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: [PATCH 2/2] powerpc: Use helper function to flush TM state in ptrace
Date: Tue, 19 Jun 2018 16:54:29 -0300
In-Reply-To: <87d0wvtolp.fsf@concordia.ellerman.id.au>
References: <87d0wvtolp.fsf@concordia.ellerman.id.au>
Message-Id: <20180619195429.22925-2-pedromfc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch updates the get/set regset functions that flush tm, fpu and
altvec state when TM is available and active to use a helper function.

Signed-off-by: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/ptrace.c | 104 ++++++++++++-------------------------------
 1 file changed, 28 insertions(+), 76 deletions(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 0d56857e1e89..84fa97587850 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -845,17 +845,10 @@ static int tm_cgpr_get(struct task_struct *target,
 			unsigned int pos, unsigned int count,
 			void *kbuf, void __user *ubuf)
 {
-	int ret;
-
-	if (!cpu_has_feature(CPU_FTR_TM))
-		return -ENODEV;
-
-	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
-		return -ENODATA;
+	int ret = tm_flush_if_active(target);
 
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
+	if (ret)
+		return ret;
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 				  &target->thread.ckpt_regs,
@@ -910,17 +903,11 @@ static int tm_cgpr_set(struct task_struct *target,
 			const void *kbuf, const void __user *ubuf)
 {
 	unsigned long reg;
-	int ret;
-
-	if (!cpu_has_feature(CPU_FTR_TM))
-		return -ENODEV;
 
-	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
-		return -ENODATA;
+	int ret = tm_flush_if_active(target);
 
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
+	if (ret)
+		return ret;
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 				 &target->thread.ckpt_regs,
@@ -1014,15 +1001,10 @@ static int tm_cfpr_get(struct task_struct *target,
 	u64 buf[33];
 	int i;
 
-	if (!cpu_has_feature(CPU_FTR_TM))
-		return -ENODEV;
-
-	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
-		return -ENODATA;
+	int ret = tm_flush_if_active(target);
 
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
+	if (ret)
+		return ret;
 
 	/* copy to local buffer then write that out */
 	for (i = 0; i < 32 ; i++)
@@ -1060,15 +1042,10 @@ static int tm_cfpr_set(struct task_struct *target,
 	u64 buf[33];
 	int i;
 
-	if (!cpu_has_feature(CPU_FTR_TM))
-		return -ENODEV;
-
-	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
-		return -ENODATA;
+	int ret = tm_flush_if_active(target);
 
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
+	if (ret)
+		return ret;
 
 	for (i = 0; i < 32; i++)
 		buf[i] = target->thread.TS_CKFPR(i);
@@ -1131,20 +1108,12 @@ static int tm_cvmx_get(struct task_struct *target,
 			unsigned int pos, unsigned int count,
 			void *kbuf, void __user *ubuf)
 {
-	int ret;
-
-	BUILD_BUG_ON(TVSO(vscr) != TVSO(vr[32]));
-
-	if (!cpu_has_feature(CPU_FTR_TM))
-		return -ENODEV;
+	int ret = tm_flush_if_active(target);
 
-	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
-		return -ENODATA;
+	if (ret)
+		return ret;
 
-	/* Flush the state */
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
+	BUILD_BUG_ON(TVSO(vscr) != TVSO(vr[32]));
 
 	ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
 					&target->thread.ckvr_state, 0,
@@ -1193,19 +1162,12 @@ static int tm_cvmx_set(struct task_struct *target,
 			unsigned int pos, unsigned int count,
 			const void *kbuf, const void __user *ubuf)
 {
-	int ret;
-
-	BUILD_BUG_ON(TVSO(vscr) != TVSO(vr[32]));
-
-	if (!cpu_has_feature(CPU_FTR_TM))
-		return -ENODEV;
+	int ret = tm_flush_if_active(target);
 
-	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
-		return -ENODATA;
+	if (ret)
+		return ret;
 
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
+	BUILD_BUG_ON(TVSO(vscr) != TVSO(vr[32]));
 
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf,
 					&target->thread.ckvr_state, 0,
@@ -1276,18 +1238,13 @@ static int tm_cvsx_get(struct task_struct *target,
 			void *kbuf, void __user *ubuf)
 {
 	u64 buf[32];
-	int ret, i;
+	int i;
 
-	if (!cpu_has_feature(CPU_FTR_TM))
-		return -ENODEV;
+	int ret = tm_flush_if_active(target);
 
-	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
-		return -ENODATA;
+	if (ret)
+		return ret;
 
-	/* Flush the state */
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
 	flush_vsx_to_thread(target);
 
 	for (i = 0; i < 32 ; i++)
@@ -1324,18 +1281,13 @@ static int tm_cvsx_set(struct task_struct *target,
 			const void *kbuf, const void __user *ubuf)
 {
 	u64 buf[32];
-	int ret, i;
+	int i;
 
-	if (!cpu_has_feature(CPU_FTR_TM))
-		return -ENODEV;
+	int ret = tm_flush_if_active(target);
 
-	if (!MSR_TM_ACTIVE(target->thread.regs->msr))
-		return -ENODATA;
+	if (ret)
+		return ret;
 
-	/* Flush the state */
-	flush_tmregs_to_thread(target);
-	flush_fp_to_thread(target);
-	flush_altivec_to_thread(target);
 	flush_vsx_to_thread(target);
 
 	for (i = 0; i < 32 ; i++)
-- 
2.13.6
