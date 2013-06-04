Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Rename PMU interrupts from CNT to PMI
Date: Tue,  4 Jun 2013 14:21:17 +1000
Message-Id: <1370319677-26946-1-git-send-email-michael@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Back in commit 89713ed "Add timer, performance monitor and machine check
counts to /proc/interrupts" we added a count of PMU interrupts to the
output of /proc/interrupts.

At the time we named them "CNT" to match x86.

However in commit 89ccf46 "Rename 'performance counter interrupt'", the
x86 guys renamed theirs from "CNT" to "PMI".

Arguably changing the name could break someone's script, but I think the
chance of that is minimal, and it's preferable to have a name that 1) is
somewhat meaningful, and 2) matches x86.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/irq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 91f5d03..f3da6215 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -364,7 +364,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).spurious_irqs);
 	seq_printf(p, "  Spurious interrupts\n");
 
-	seq_printf(p, "%*s: ", prec, "CNT");
+	seq_printf(p, "%*s: ", prec, "PMI");
 	for_each_online_cpu(j)
 		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);
 	seq_printf(p, "  Performance monitoring interrupts\n");
-- 
1.7.10.4
