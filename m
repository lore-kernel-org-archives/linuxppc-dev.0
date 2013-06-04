Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/perf: Fix deadlock caused by calling printk() in PMU
 exception
Date: Tue,  4 Jun 2013 14:20:57 +1000
Message-Id: <1370319657-26753-1-git-send-email-michael@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit bc09c21 "Fix finding overflowed PMC in interrupt" we added
a printk() to the PMU exception handler. Unfortunately that is not safe.

The problem is that the PMU exception runs even when interrupts are soft
disabled. We do this so that we can profile parts of the kernel that
have interrupts soft-disabled.

But by calling printk() from the exception handler, we can potentially
deadlock in the printk code on logbuf_lock, eg:

  [c00000038ba575c0] c000000000081928 .vprintk_emit+0xa8/0x540
  [c00000038ba576a0] c0000000007bcde8 .printk+0x48/0x58
  [c00000038ba57710] c000000000076504 .perf_event_interrupt+0x2d4/0x490
  [c00000038ba57810] c00000000001f6f8 .performance_monitor_exception+0x48/0x60
  [c00000038ba57880] c0000000000032cc performance_monitor_common+0x14c/0x180
  --- Exception: f01 (Performance Monitor) at c0000000007b25d4 ._raw_spin_lock_irq
  +0x64/0xc0
  [c00000038ba57bf0] c00000000007ed90 .devkmsg_read+0xd0/0x5a0
  [c00000038ba57d00] c0000000001c2934 .vfs_read+0xc4/0x1e0
  [c00000038ba57d90] c0000000001c2cd8 .SyS_read+0x58/0xd0
  [c00000038ba57e30] c000000000009d54 syscall_exit+0x0/0x98
  --- Exception: c01 (System Call) at 00001fffffbf6f7c
  SP (3ffff6d4de10) is in userspace

The fix is to not call printk() from the PMU exception handler. Instead
add a counter to track spurious PMU interrupts and display them in
/proc/interrupts.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Cc: <stable@vger.kernel.org> # 3.9
---
 arch/powerpc/include/asm/hardirq.h |    1 +
 arch/powerpc/kernel/irq.c          |    5 +++++
 arch/powerpc/perf/core-book3s.c    |    5 +++--
 3 files changed, 9 insertions(+), 2 deletions(-)

tag: for-3.10

diff --git a/arch/powerpc/include/asm/hardirq.h b/arch/powerpc/include/asm/hardirq.h
index 3bdcfce..23b5c45 100644
--- a/arch/powerpc/include/asm/hardirq.h
+++ b/arch/powerpc/include/asm/hardirq.h
@@ -8,6 +8,7 @@ typedef struct {
 	unsigned int __softirq_pending;
 	unsigned int timer_irqs;
 	unsigned int pmu_irqs;
+	unsigned int pmu_spurious_irqs;
 	unsigned int mce_exceptions;
 	unsigned int spurious_irqs;
 #ifdef CONFIG_PPC_DOORBELL
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 5cbcf4d..91f5d03 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -369,6 +369,11 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);
 	seq_printf(p, "  Performance monitoring interrupts\n");
 
+	seq_printf(p, "%*s: ", prec, "PMS");
+	for_each_online_cpu(j)
+		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);
+	seq_printf(p, "  Performance monitoring interrupts (spurious)\n");
+
 	seq_printf(p, "%*s: ", prec, "MCE");
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).mce_exceptions);
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 845c867..3a71069 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -1758,8 +1758,9 @@ static void perf_event_interrupt(struct pt_regs *regs)
 			}
 		}
 	}
-	if ((!found) && printk_ratelimit())
-		printk(KERN_WARNING "Can't find PMC that caused IRQ\n");
+
+	if (!found)
+		__get_cpu_var(irq_stat).pmu_spurious_irqs++;
 
 	/*
 	 * Reset MMCR0 to its normal value.  This will set PMXE and
-- 
1.7.10.4
