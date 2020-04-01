Return-Path: <SRS0=4P7+=5R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA25C43331
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 06:28:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ECA020719
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 06:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECA020719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48sbq95gsszDqc4
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2020 17:28:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.ibm.com (client-ip=148.163.156.1;
 helo=mx0a-001b2d01.pphosted.com; envelope-from=ravi.bangoria@linux.ibm.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.ibm.com
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48sbWC269vzDr0T
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2020 17:14:14 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 03164nBa052102
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Apr 2020 02:14:12 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 301yfgg4qq-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2020 02:14:12 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.ibm.com>;
 Wed, 1 Apr 2020 07:13:54 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
 by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway:
 Authorized Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 1 Apr 2020 07:13:51 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com
 [9.149.105.59])
 by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 0316E5Ze54853806
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Apr 2020 06:14:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 69E75A405B;
 Wed,  1 Apr 2020 06:14:05 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47F83A4051;
 Wed,  1 Apr 2020 06:14:02 +0000 (GMT)
Received: from bangoria.ibmuc.com (unknown [9.199.48.114])
 by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
 Wed,  1 Apr 2020 06:14:02 +0000 (GMT)
From: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
To: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH v2 06/16] powerpc/watchpoint: Provide DAWR number to
 __set_breakpoint
Date: Wed,  1 Apr 2020 11:42:59 +0530
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
References: <20200401061309.92442-1-ravi.bangoria@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040106-0020-0000-0000-000003BF6B61
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040106-0021-0000-0000-000022180F5C
Message-Id: <20200401061309.92442-7-ravi.bangoria@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138, 18.0.676
 definitions=2020-03-31_07:2020-03-31,
 2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 suspectscore=0 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 mlxlogscore=988 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010049
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: apopple@linux.ibm.com, ravi.bangoria@linux.ibm.com, peterz@infradead.org,
 fweisbec@gmail.com, oleg@redhat.com, npiggin@gmail.com,
 linux-kernel@vger.kernel.org, paulus@samba.org, jolsa@kernel.org,
 naveen.n.rao@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 mingo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Introduce new parameter 'nr' to __set_breakpoint() which indicates
which DAWR should be programed. Also convert current_brk variable
to an array.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 arch/powerpc/include/asm/debug.h         |  2 +-
 arch/powerpc/include/asm/hw_breakpoint.h |  2 +-
 arch/powerpc/kernel/hw_breakpoint.c      |  8 ++++----
 arch/powerpc/kernel/process.c            | 14 +++++++-------
 arch/powerpc/kernel/signal.c             |  2 +-
 arch/powerpc/xmon/xmon.c                 |  2 +-
 6 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index 7756026b95ca..6228935a8b64 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -45,7 +45,7 @@ static inline int debugger_break_match(struct pt_regs *regs) { return 0; }
 static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 #endif
 
-void __set_breakpoint(struct arch_hw_breakpoint *brk);
+void __set_breakpoint(struct arch_hw_breakpoint *brk, int nr);
 bool ppc_breakpoint_available(void);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
diff --git a/arch/powerpc/include/asm/hw_breakpoint.h b/arch/powerpc/include/asm/hw_breakpoint.h
index 62549007c87a..4e4976c3248b 100644
--- a/arch/powerpc/include/asm/hw_breakpoint.h
+++ b/arch/powerpc/include/asm/hw_breakpoint.h
@@ -85,7 +85,7 @@ static inline void hw_breakpoint_disable(void)
 	brk.len = 0;
 	brk.hw_len = 0;
 	if (ppc_breakpoint_available())
-		__set_breakpoint(&brk);
+		__set_breakpoint(&brk, 0);
 }
 extern void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs);
 int hw_breakpoint_handler(struct die_args *args);
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 4120349e2abe..7562f9ceb77e 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -63,7 +63,7 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	 * If so, DABR will be populated in single_step_dabr_instruction().
 	 */
 	if (current->thread.last_hit_ubp != bp)
-		__set_breakpoint(info);
+		__set_breakpoint(info, 0);
 
 	return 0;
 }
@@ -221,7 +221,7 @@ void thread_change_pc(struct task_struct *tsk, struct pt_regs *regs)
 
 	info = counter_arch_bp(tsk->thread.last_hit_ubp);
 	regs->msr &= ~MSR_SE;
-	__set_breakpoint(info);
+	__set_breakpoint(info, 0);
 	tsk->thread.last_hit_ubp = NULL;
 }
 
@@ -346,7 +346,7 @@ int hw_breakpoint_handler(struct die_args *args)
 	if (!(info->type & HW_BRK_TYPE_EXTRANEOUS_IRQ))
 		perf_bp_event(bp, regs);
 
-	__set_breakpoint(info);
+	__set_breakpoint(info, 0);
 out:
 	rcu_read_unlock();
 	return rc;
@@ -379,7 +379,7 @@ static int single_step_dabr_instruction(struct die_args *args)
 	if (!(info->type & HW_BRK_TYPE_EXTRANEOUS_IRQ))
 		perf_bp_event(bp, regs);
 
-	__set_breakpoint(info);
+	__set_breakpoint(info, 0);
 	current->thread.last_hit_ubp = NULL;
 
 	/*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index b548a584e465..e0275fcd0c55 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -630,7 +630,7 @@ void do_break (struct pt_regs *regs, unsigned long address,
 }
 #endif	/* CONFIG_PPC_ADV_DEBUG_REGS */
 
-static DEFINE_PER_CPU(struct arch_hw_breakpoint, current_brk);
+static DEFINE_PER_CPU(struct arch_hw_breakpoint, current_brk[HBP_NUM_MAX]);
 
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 /*
@@ -707,7 +707,7 @@ EXPORT_SYMBOL_GPL(switch_booke_debug_regs);
 static void set_breakpoint(struct arch_hw_breakpoint *brk)
 {
 	preempt_disable();
-	__set_breakpoint(brk);
+	__set_breakpoint(brk, 0);
 	preempt_enable();
 }
 
@@ -793,13 +793,13 @@ static inline int set_breakpoint_8xx(struct arch_hw_breakpoint *brk)
 	return 0;
 }
 
-void __set_breakpoint(struct arch_hw_breakpoint *brk)
+void __set_breakpoint(struct arch_hw_breakpoint *brk, int nr)
 {
-	memcpy(this_cpu_ptr(&current_brk), brk, sizeof(*brk));
+	memcpy(this_cpu_ptr(&current_brk[nr]), brk, sizeof(*brk));
 
 	if (dawr_enabled())
 		// Power8 or later
-		set_dawr(brk, 0);
+		set_dawr(brk, nr);
 	else if (IS_ENABLED(CONFIG_PPC_8xx))
 		set_breakpoint_8xx(brk);
 	else if (!cpu_has_feature(CPU_FTR_ARCH_207S))
@@ -1167,8 +1167,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
  * schedule DABR
  */
 #ifndef CONFIG_HAVE_HW_BREAKPOINT
-	if (unlikely(!hw_brk_match(this_cpu_ptr(&current_brk), &new->thread.hw_brk)))
-		__set_breakpoint(&new->thread.hw_brk);
+	if (unlikely(!hw_brk_match(this_cpu_ptr(&current_brk[0]), &new->thread.hw_brk)))
+		__set_breakpoint(&new->thread.hw_brk, 0);
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #endif
 
diff --git a/arch/powerpc/kernel/signal.c b/arch/powerpc/kernel/signal.c
index d215f9554553..bbf237f072d4 100644
--- a/arch/powerpc/kernel/signal.c
+++ b/arch/powerpc/kernel/signal.c
@@ -129,7 +129,7 @@ static void do_signal(struct task_struct *tsk)
 	 * triggered inside the kernel.
 	 */
 	if (tsk->thread.hw_brk.address && tsk->thread.hw_brk.type)
-		__set_breakpoint(&tsk->thread.hw_brk);
+		__set_breakpoint(&tsk->thread.hw_brk, 0);
 #endif
 	/* Re-enable the breakpoints for the signal stack */
 	thread_change_pc(tsk, tsk->thread.regs);
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 75ca41c04dd1..508d353e7f06 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -935,7 +935,7 @@ static void insert_cpu_bpts(void)
 		brk.address = dabr.address;
 		brk.type = (dabr.enabled & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
 		brk.len = DABR_MAX_LEN;
-		__set_breakpoint(&brk);
+		__set_breakpoint(&brk, 0);
 	}
 
 	if (iabr)
-- 
2.21.1

