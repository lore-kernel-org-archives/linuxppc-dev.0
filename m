Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wC82z28vpzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:35:39 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3PGXnSx143919
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 12:35:28 -0400
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a28s0ma1h-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Apr 2017 12:35:28 -0400
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 26 Apr 2017 02:35:25 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3PGZFi463963258
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:35:23 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3PGYkT5014202
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 02:34:46 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] powerpc/kprobes: blacklist functions invoked on a trap
Date: Tue, 25 Apr 2017 22:04:08 +0530
In-Reply-To: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <e699cb4fb493b1eec7f68f78047bd6460c5cd882.1493137432.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Blacklist all functions invoked when we get a trap, through to the time
we invoke the kprobe handler.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/entry_64.S       | 1 +
 arch/powerpc/kernel/exceptions-64s.S | 1 +
 arch/powerpc/kernel/time.c           | 3 +++
 arch/powerpc/kernel/traps.c          | 2 ++
 arch/powerpc/platforms/pseries/dtl.c | 2 ++
 5 files changed, 9 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index e030ce34dd66..22aaa377149f 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -399,6 +399,7 @@ _GLOBAL(save_nvgprs)
 	clrrdi	r0,r11,1
 	std	r0,_TRAP(r1)
 	blr
+_ASM_NOKPROBE_SYMBOL(save_nvgprs);
 
 	
 /*
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 28f8d7bed6b1..aff23b2288f2 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1534,6 +1534,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CFAR)
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	kernel_bad_stack
 	b	1b
+_ASM_NOKPROBE_SYMBOL(bad_stack);
 
 /*
  * Called from arch_local_irq_enable when an interrupt needs
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 07b90725855e..afdec3c00738 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -59,6 +59,7 @@
 #include <linux/suspend.h>
 #include <linux/rtc.h>
 #include <linux/sched/cputime.h>
+#include <linux/kprobes.h>
 #include <asm/trace.h>
 
 #include <asm/io.h>
@@ -236,6 +237,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
 	local_paca->dtl_curr = dtl;
 	return stolen;
 }
+NOKPROBE_SYMBOL(scan_dispatch_log);
 
 /*
  * Accumulate stolen time by scanning the dispatch trace log.
@@ -263,6 +265,7 @@ void accumulate_stolen_time(void)
 
 	local_paca->soft_enabled = save_soft_enabled;
 }
+NOKPROBE_SYMBOL(accumulate_stolen_time);
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
 {
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 76f6045b021b..ece130515cd0 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -237,6 +237,7 @@ void die(const char *str, struct pt_regs *regs, long err)
 		err = 0;
 	oops_end(flags, regs, err);
 }
+NOKPROBE_SYMBOL(die);
 
 void user_single_step_siginfo(struct task_struct *tsk,
 				struct pt_regs *regs, siginfo_t *info)
@@ -1981,6 +1982,7 @@ void kernel_bad_stack(struct pt_regs *regs)
 	       regs->gpr[1], regs->nip);
 	die("Bad kernel stack pointer", regs, SIGABRT);
 }
+NOKPROBE_SYMBOL(kernel_bad_stack);
 
 void __init trap_init(void)
 {
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 18014cdeb590..03d333ff7867 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -29,6 +29,7 @@
 #include <asm/debugfs.h>
 #include <asm/plpar_wrappers.h>
 #include <asm/machdep.h>
+#include <linux/kprobes.h>
 
 struct dtl {
 	struct dtl_entry	*buf;
@@ -97,6 +98,7 @@ static void consume_dtle(struct dtl_entry *dtle, u64 index)
 	smp_wmb();
 	++dtlr->write_index;
 }
+NOKPROBE_SYMBOL(consume_dtle);
 
 static int dtl_start(struct dtl *dtl)
 {
-- 
2.12.1
