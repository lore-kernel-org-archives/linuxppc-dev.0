Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409JCJ5nySzF278
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 15:37:32 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 david@gibson.dropbear.id.au, npiggin@gmail.com,
 pedromfc@linux.vnet.ibm.com, kvm-ppc@vger.kernel.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Subject: [PATCH v3 2/8] powerpc: Update ptrace to use
 ppc_breakpoint_available()
Date: Tue, 27 Mar 2018 15:37:18 +1100
Message-Id: <20180327043724.13862-3-mikey@neuling.org>
In-Reply-To: <20180327043724.13862-1-mikey@neuling.org>
References: <20180327043724.13862-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This updates the ptrace code to use ppc_breakpoint_available().

We now advertise via PPC_PTRACE_GETHWDBGINFO zero breakpoints when the
DAWR is missing (ie. POWER9). This results in GDB falling back to
software emulation of the breakpoint (which is slow).

For the features advertised by PPC_PTRACE_GETHWDBGINFO, we keep
advertising DAWR as if we don't GDB assumes 1 breakpoint irrespective
of the number of breakpoints advertised. GDB then fails later when
trying to set this one breakpoint.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/hw_breakpoint.c |  3 +++
 arch/powerpc/kernel/ptrace.c        | 16 ++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
index 53b9c1dfd7..4c1012b80d 100644
--- a/arch/powerpc/kernel/hw_breakpoint.c
+++ b/arch/powerpc/kernel/hw_breakpoint.c
@@ -33,6 +33,7 @@
 #include <asm/hw_breakpoint.h>
 #include <asm/processor.h>
 #include <asm/sstep.h>
+#include <asm/debug.h>
 #include <linux/uaccess.h>
 
 /*
@@ -171,6 +172,8 @@ int arch_validate_hwbkpt_settings(struct perf_event *bp)
 	 * HW_BREAKPOINT_ALIGN by rounding off to the lower address, the
 	 * 'symbolsize' should satisfy the check below.
 	 */
+	if (!ppc_breakpoint_available())
+		return -ENODEV;
 	length_max = 8; /* DABR */
 	if (cpu_has_feature(CPU_FTR_DAWR)) {
 		length_max = 512 ; /* 64 doublewords */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index ca72d7391d..d23cf632ed 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -41,6 +41,7 @@
 #include <asm/switch_to.h>
 #include <asm/tm.h>
 #include <asm/asm-prototypes.h>
+#include <asm/debug.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -2378,6 +2379,7 @@ static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	struct perf_event_attr attr;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 #ifndef CONFIG_PPC_ADV_DEBUG_REGS
+	bool set_bp = true;
 	struct arch_hw_breakpoint hw_brk;
 #endif
 
@@ -2411,9 +2413,10 @@ static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 	hw_brk.address = data & (~HW_BRK_TYPE_DABR);
 	hw_brk.type = (data & HW_BRK_TYPE_DABR) | HW_BRK_TYPE_PRIV_ALL;
 	hw_brk.len = 8;
+	set_bp = (data) && (hw_brk.type & HW_BRK_TYPE_RDWR);
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	bp = thread->ptrace_bps[0];
-	if ((!data) || !(hw_brk.type & HW_BRK_TYPE_RDWR)) {
+	if (!set_bp) {
 		if (bp) {
 			unregister_hw_breakpoint(bp);
 			thread->ptrace_bps[0] = NULL;
@@ -2450,6 +2453,9 @@ static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
 		return PTR_ERR(bp);
 	}
 
+#else /* !CONFIG_HAVE_HW_BREAKPOINT */
+	if (set_bp && (!ppc_breakpoint_available()))
+		return -ENODEV;
 #endif /* CONFIG_HAVE_HW_BREAKPOINT */
 	task->thread.hw_brk = hw_brk;
 #else /* CONFIG_PPC_ADV_DEBUG_REGS */
@@ -2904,6 +2910,9 @@ static long ppc_set_hwdebug(struct task_struct *child,
 	if (child->thread.hw_brk.address)
 		return -ENOSPC;
 
+	if (!ppc_breakpoint_available())
+		return -ENODEV;
+
 	child->thread.hw_brk = brk;
 
 	return 1;
@@ -3052,7 +3061,10 @@ long arch_ptrace(struct task_struct *child, long request,
 #endif
 #else /* !CONFIG_PPC_ADV_DEBUG_REGS */
 		dbginfo.num_instruction_bps = 0;
-		dbginfo.num_data_bps = 1;
+		if (ppc_breakpoint_available())
+			dbginfo.num_data_bps = 1;
+		else
+			dbginfo.num_data_bps = 0;
 		dbginfo.num_condition_regs = 0;
 #ifdef CONFIG_PPC64
 		dbginfo.data_bp_alignment = 8;
-- 
2.14.1
