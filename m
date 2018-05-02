Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bdqg2m0tzF2ST
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 23:07:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [RFC PATCH 3/4] powerpc/64s: Wire up arch_trigger_cpumask_backtrace()
Date: Wed,  2 May 2018 23:07:28 +1000
Message-Id: <20180502130729.24077-3-mpe@ellerman.id.au>
In-Reply-To: <20180502130729.24077-1-mpe@ellerman.id.au>
References: <20180502130729.24077-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This allows eg. the RCU stall detector, or the soft/hardlockup
detectors to trigger a backtrace on all CPUs.

We implement this by sending a "safe" NMI, which will actually only
send an IPI. Unfortunately the generic code prints "NMI", so that's a
little confusing but we can probably live with it.

If one of the CPUs doesn't respond to the IPI, we then print some info
from it's paca and do a backtrace based on its saved_r1.

Example output:

  INFO: rcu_sched detected stalls on CPUs/tasks:
  	2-...0: (0 ticks this GP) idle=1be/1/4611686018427387904 softirq=1055/1055 fqs=25735
  	(detected by 4, t=58847 jiffies, g=58, c=57, q=1258)
  Sending NMI from CPU 4 to CPUs 2:
  CPU 2 didn't respond to backtrace IPI, inspecting paca.
  irq_soft_mask: 0x01 in_mce: 0 in_nmi: 0 current: 3623 (bash)
  Back trace of paca->saved_r1 (0xc0000000e1c83ba0) (possibly stale):
  Call Trace:
  [c0000000e1c83ba0] [0000000000000014] 0x14 (unreliable)
  [c0000000e1c83bc0] [c000000000765798] lkdtm_do_action+0x48/0x80
  [c0000000e1c83bf0] [c000000000765a40] direct_entry+0x110/0x1b0
  [c0000000e1c83c90] [c00000000058e650] full_proxy_write+0x90/0xe0
  [c0000000e1c83ce0] [c0000000003aae3c] __vfs_write+0x6c/0x1f0
  [c0000000e1c83d80] [c0000000003ab214] vfs_write+0xd4/0x240
  [c0000000e1c83dd0] [c0000000003ab5cc] ksys_write+0x6c/0x110
  [c0000000e1c83e30] [c00000000000b860] system_call+0x58/0x6c

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/nmi.h   |  4 ++++
 arch/powerpc/kernel/stacktrace.c | 51 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index 9c80939b4d14..e97f58689ca7 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -4,6 +4,10 @@
 
 #ifdef CONFIG_PPC_WATCHDOG
 extern void arch_touch_nmi_watchdog(void);
+extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+
 #else
 static inline void arch_touch_nmi_watchdog(void) {}
 #endif
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index d534ed901538..cf4652d5df80 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -11,12 +11,15 @@
  */
 
 #include <linux/export.h>
+#include <linux/nmi.h>
 #include <linux/sched.h>
 #include <linux/sched/debug.h>
 #include <linux/stacktrace.h>
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 
+#include <asm/paca.h>
+
 /*
  * Save stack-backtrace addresses into a stack_trace buffer.
  */
@@ -76,3 +79,51 @@ save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
 	save_context_stack(trace, regs->gpr[1], current, 0);
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_regs);
+
+#ifdef CONFIG_PPC_BOOK3S_64
+static void handle_backtrace_ipi(struct pt_regs *regs)
+{
+	nmi_cpu_backtrace(regs);
+}
+
+static void raise_backtrace_ipi(cpumask_t *mask)
+{
+	unsigned int cpu;
+
+	for_each_cpu(cpu, mask) {
+		if (cpu == smp_processor_id())
+			handle_backtrace_ipi(NULL);
+		else
+			smp_send_safe_nmi_ipi(cpu, handle_backtrace_ipi, 5 * USEC_PER_SEC);
+	}
+
+	for_each_cpu(cpu, mask) {
+		struct paca_struct *p = paca_ptrs[cpu];
+
+		cpumask_clear_cpu(cpu, mask);
+
+		pr_warn("CPU %d didn't respond to backtrace IPI, inspecting paca.\n", cpu);
+		if (!virt_addr_valid(p)) {
+			pr_warn("paca pointer appears corrupt? (%px)\n", p);
+			continue;
+		}
+
+		pr_warn("irq_soft_mask: 0x%02x in_mce: %d in_nmi: %d",
+			p->irq_soft_mask, p->in_mce, p->in_nmi);
+
+		if (virt_addr_valid(p->__current))
+			pr_cont(" current: %d (%s)\n", p->__current->pid,
+				p->__current->comm);
+		else
+			pr_cont(" current pointer corrupt? (%px)\n", p->__current);
+
+		pr_warn("Back trace of paca->saved_r1 (0x%016llx) (possibly stale):\n", p->saved_r1);
+		show_stack(p->__current, (unsigned long *)p->saved_r1);
+	}
+}
+
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);
+}
+#endif /* CONFIG_PPC64 */
-- 
2.14.1
