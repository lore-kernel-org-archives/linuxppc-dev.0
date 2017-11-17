Return-Path: <pedromfc@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ydc2J6XljzDrKv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 22:53:28 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vAHBnBVs103093
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 06:53:25 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2e9wtbc4c7-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 06:53:25 -0500
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <pedromfc@linux.vnet.ibm.com>;
 Fri, 17 Nov 2017 04:53:24 -0700
From: "pedromfc" <pedromfc@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, ananth@linux.vnet.ibm.com
Subject: [PATCH] powerpc: Check DAWR before setting watchpoint
Date: Fri, 17 Nov 2017 09:52:30 -0200
Message-Id: <20171117115230.8794-1-pedromfc@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Parse the PVR to check if DAWR was disabled by firmware
for POWER9 DD2.0 and if so return in error from ptrace.

Based on initial code provided by Michael Neuling <mikey@neuling.org>.

Suggested-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Signed-off-by: Pedro Franco de Carvalho <pedromfc@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/debug.h    |  1 +
 arch/powerpc/kernel/hw_breakpoint.c |  2 ++
 arch/powerpc/kernel/process.c       | 24 ++++++++++++++++++++++++
 arch/powerpc/kernel/ptrace.c        | 18 ++++++++++++++++--
 4 files changed, 43 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/debug.h b/arch/powerpc/include/asm/debug.h
index 14e71ff6579e..9b0381abeb0a 100644
--- a/arch/powerpc/include/asm/debug.h
+++ b/arch/powerpc/include/asm/debug.h
@@ -47,6 +47,7 @@ static inline int debugger_fault_handler(struct pt_regs *regs) { return 0; }
 
 void set_breakpoint(struct arch_hw_breakpoint *brk);
 void __set_breakpoint(struct arch_hw_breakpoint *brk);
+bool breakpoint_enabled(void);
 #ifdef CONFIG_PPC_ADV_DEBUG_REGS
 extern void do_send_trap(struct pt_regs *regs, unsigned long address,
 			 unsigned long error_code, int signal_code, int brkpt);
diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 53b9c1dfd7d9..42a6c692f22a 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -173,6 +173,8 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 */
 	length_max = 8; /* DABR */
 	if (cpu_has_feature(CPU_FTR_DAWR)) {
+		if(!breakpoint_enabled())
+			return -ENODEV;
 		length_max = 512 ; /* 64 doublewords */
 		/* DAWR region can't cross 512 boundary */
 		if ((bp->attr.bp_addr >> 10) != 
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a0c74bbf3454..73dd45dcc5b1 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -809,6 +809,30 @@ void set_breakpoint(struct arch_hw_breakpoint *brk)
 	preempt_enable();
 }
 
+/*
+ * Check if DAWR is enabled.
+ *
+ * Firmware for POWER9 DD2.0 has DAWR disabled.
+ * There is no way to determine this pragmatically or from
+ * firmware so unfortunately we need to do this based on the PVR.
+ */
+bool breakpoint_enabled(void)
+{
+	unsigned long pvr;
+	unsigned short maj;
+	unsigned short min;
+
+	pvr = mfspr(SPRN_PVR);
+
+	maj = (pvr >> 8) & 0x0F;
+	min = pvr & 0xFF;
+
+	if ((PVR_VER(pvr) == PVR_POWER9) && (maj == 2) && (min == 0))
+		return false;
+
+	return true;
+}
+
 #ifdef CONFIG_PPC64
 DEFINE_PER_CPU(struct cpu_usage, cpu_usage_array);
 #endif
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index f52ad5bb7109..632fc7b2ca90 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -35,6 +35,7 @@
 #include <linux/context_tracking.h>
 
 #include <linux/uaccess.h>
+#include <asm/debug.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/switch_to.h>
@@ -2300,6 +2301,7 @@ static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	struct perf_event_attr attr;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #ifndef CONFIG_PPC_ADV_DEBUG_REGS
+	bool clear_bp = false;
 	struct arch_hw_breakpoint hw_brk;
 #endif
 
@@ -2333,9 +2335,10 @@ static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	hw_brk.address = data & (~HW_BRK_TYPE_DABR);
 	hw_brk.type = (data & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
 	hw_brk.len = 8;
+	clear_bp = (!data) || !(hw_brk.type & HW_BRK_TYPE_RDWR);
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	bp = thread->ptrace_bps[0];
-	if ((!data) || !(hw_brk.type & HW_BRK_TYPE_RDWR)) {
+	if (clear_bp) {
 		if (bp) {
 			unregister_hw_breakpoint(bp);
 			thread->ptrace_bps[0] = NULL;
@@ -2372,7 +2375,15 @@ static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 		return PTR_ERR(bp);
 	}
 
-#endif /* CONFIG_HAVE_HW_BREAKPOINT */
+#else /* !CONFIG_HAVE_HW_BREAKPOINT */
+	/* Only check if DAWR is enabled if we are actually
+	 * setting a watchpoint that can be triggered (i.e. clear_bp is false).
+	 * This emulates the behavior when CONFIG_HAVE_HW_BREAKPOINT is set,
+	 * which checks DAWR when register_user_hw_breakpoint is called.
+	 */
+	if((!clear_bp) && (!breakpoint_enabled()))
+		return -ENODEV;
+#endif /* !CONFIG_HAVE_HW_BREAKPOINT */
 	task->thread.hw_brk = hw_brk;
 #else /* CONFIG_PPC_ADV_DEBUG_REGS */
 	/* As described above, it was assumed 3 bits were passed with the data
@@ -2826,6 +2837,9 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	if (child->thread.hw_brk.address)
 		return -ENOSPC;
 
+	if (!breakpoint_enabled())
+		return -ENODEV;
+
 	child->thread.hw_brk = brk;
 
 	return 1;
-- 
2.13.6
