Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9PNj0mclzDr7v
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:08 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BNSb3E081178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:07 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24rqx1x78p-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 19:29:06 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Fri, 12 Aug 2016 09:29:03 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5DF423578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:02 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BNT2Wl31916104
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:02 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BNT2pd003489
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 09:29:02 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: anton@samba.org, mikey@neuling.org
Subject: [PATCH v2 05/20] powerpc: Never giveup a reclaimed thread when
 enabling kernel {fp, altivec, vsx}
Date: Fri, 12 Aug 2016 09:28:04 +1000
In-Reply-To: <20160811232819.11453-1-cyrilbur@gmail.com>
References: <20160811232819.11453-1-cyrilbur@gmail.com>
Message-Id: <20160811232819.11453-6-cyrilbur@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

After a thread is reclaimed from its active or suspended transactional
state the checkpointed state exists on CPU, this state (along with the
live/transactional state) has been saved in its entirety by the
reclaiming process.

There exists a sequence of events that would cause the kernel to call
one of enable_kernel_fp(), enable_kernel_altivec() or
enable_kernel_vsx() after a thread has been reclaimed. These functions
save away any user state on the CPU so that the kernel can use the
registers. Not only is this saving away unnecessary at this point, it
is actually incorrect. It causes a save of the checkpointed state to
the live structures within the thread struct thus destroying the true
live state for that thread.

Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
---
 arch/powerpc/kernel/process.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 216cf05..0cfbc89 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -198,12 +198,23 @@ EXPORT_SYMBOL_GPL(flush_fp_to_thread);
 
 void enable_kernel_fp(void)
 {
+	unsigned long cpumsr;
+
 	WARN_ON(preemptible());
 
-	msr_check_and_set(MSR_FP);
+	cpumsr = msr_check_and_set(MSR_FP);
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_FP)) {
 		check_if_tm_restore_required(current);
+		/*
+		 * If a thread has already been reclaimed then the
+		 * checkpointed registers are on the CPU but have definitely
+		 * been saved by the reclaim code. Don't need to and *cannot*
+		 * giveup as this would save  to the 'live' structure not the
+		 * checkpointed structure.
+		 */
+		if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
+			return;
 		__giveup_fpu(current);
 	}
 }
@@ -250,12 +261,23 @@ EXPORT_SYMBOL(giveup_altivec);
 
 void enable_kernel_altivec(void)
 {
+	unsigned long cpumsr;
+
 	WARN_ON(preemptible());
 
-	msr_check_and_set(MSR_VEC);
+	cpumsr = msr_check_and_set(MSR_VEC);
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VEC)) {
 		check_if_tm_restore_required(current);
+		/*
+		 * If a thread has already been reclaimed then the
+		 * checkpointed registers are on the CPU but have definitely
+		 * been saved by the reclaim code. Don't need to and *cannot*
+		 * giveup as this would save  to the 'live' structure not the
+		 * checkpointed structure.
+		 */
+		if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
+			return;
 		__giveup_altivec(current);
 	}
 }
@@ -324,12 +346,23 @@ static void save_vsx(struct task_struct *tsk)
 
 void enable_kernel_vsx(void)
 {
+	unsigned long cpumsr;
+
 	WARN_ON(preemptible());
 
-	msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
+	cpumsr = msr_check_and_set(MSR_FP|MSR_VEC|MSR_VSX);
 
 	if (current->thread.regs && (current->thread.regs->msr & MSR_VSX)) {
 		check_if_tm_restore_required(current);
+		/*
+		 * If a thread has already been reclaimed then the
+		 * checkpointed registers are on the CPU but have definitely
+		 * been saved by the reclaim code. Don't need to and *cannot*
+		 * giveup as this would save  to the 'live' structure not the
+		 * checkpointed structure.
+		 */
+		if(!MSR_TM_ACTIVE(cpumsr) && MSR_TM_ACTIVE(current->thread.regs->msr))
+			return;
 		if (current->thread.regs->msr & MSR_FP)
 			__giveup_fpu(current);
 		if (current->thread.regs->msr & MSR_VEC)
-- 
2.9.2
