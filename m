Return-Path: <cyrilbur@gmail.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDZpZ4NJ6zDr4v
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:44:06 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7H3i2EI058956
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 23:44:04 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24uufthty5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Aug 2016 23:44:03 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cyrilbur@gmail.com>;
 Wed, 17 Aug 2016 13:43:55 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id ACC773578067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:43:52 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7H3hqI76881464
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:43:52 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7H3hq8c006734
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 13:43:52 +1000
From: Cyril Bur <cyrilbur@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, wei.guo.simon@gmail.com
Cc: mikey@neuling.org, anton@samba.org
Subject: [PATCH v3 05/21] powerpc: Never giveup a reclaimed thread when
 enabling kernel {fp, altivec, vsx}
Date: Wed, 17 Aug 2016 13:43:07 +1000
In-Reply-To: <20160817034323.23053-1-cyrilbur@gmail.com>
References: <20160817034323.23053-1-cyrilbur@gmail.com>
Message-Id: <20160817034323.23053-6-cyrilbur@gmail.com>
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
index c42581b..432884c 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -204,12 +204,23 @@ EXPORT_SYMBOL_GPL(flush_fp_to_thread);
 
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
+		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+			return;
 		__giveup_fpu(current);
 	}
 }
@@ -256,12 +267,23 @@ EXPORT_SYMBOL(giveup_altivec);
 
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
+		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+			return;
 		__giveup_altivec(current);
 	}
 }
@@ -330,12 +352,23 @@ static void save_vsx(struct task_struct *tsk)
 
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
+		if(!msr_tm_active(cpumsr) && msr_tm_active(current->thread.regs->msr))
+			return;
 		if (current->thread.regs->msr & MSR_FP)
 			__giveup_fpu(current);
 		if (current->thread.regs->msr & MSR_VEC)
-- 
2.9.3
