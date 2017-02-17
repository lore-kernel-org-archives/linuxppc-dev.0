Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPjqs3ZdczDqHl
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Feb 2017 17:32:25 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 8/9] powerpc/mce: Move 64-bit machine check code into mce.c
Date: Fri, 17 Feb 2017 17:32:18 +1100
Message-Id: <1487313139-21959-8-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1487313139-21959-1-git-send-email-mpe@ellerman.id.au>
References: <1487313139-21959-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We already have mce.c which is built for 64bit and contains other parts
of the machine check code, so move these bits in there too.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/mce.c   | 35 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/traps.c | 35 -----------------------------------
 2 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/arch/powerpc/kernel/mce.c b/arch/powerpc/kernel/mce.c
index c6923ff45131..edca4ee0ef93 100644
--- a/arch/powerpc/kernel/mce.c
+++ b/arch/powerpc/kernel/mce.c
@@ -22,11 +22,14 @@
 #undef DEBUG
 #define pr_fmt(fmt) "mce: " fmt
 
+#include <linux/hardirq.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/percpu.h>
 #include <linux/export.h>
 #include <linux/irq_work.h>
+
+#include <asm/machdep.h>
 #include <asm/mce.h>
 
 static DEFINE_PER_CPU(int, mce_nest_count);
@@ -348,3 +351,35 @@ uint64_t get_mce_fault_addr(struct machine_check_event *evt)
 	return 0;
 }
 EXPORT_SYMBOL(get_mce_fault_addr);
+
+/*
+ * This function is called in real mode. Strictly no printk's please.
+ *
+ * regs->nip and regs->msr contains srr0 and ssr1.
+ */
+long machine_check_early(struct pt_regs *regs)
+{
+	long handled = 0;
+
+	__this_cpu_inc(irq_stat.mce_exceptions);
+
+	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
+
+	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
+		handled = cur_cpu_spec->machine_check_early(regs);
+	return handled;
+}
+
+long hmi_exception_realmode(struct pt_regs *regs)
+{
+	__this_cpu_inc(irq_stat.hmi_exceptions);
+
+	wait_for_subcore_guest_exit();
+
+	if (ppc_md.hmi_exception_early)
+		ppc_md.hmi_exception_early(regs);
+
+	wait_for_tb_resync();
+
+	return 0;
+}
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 9315d925d49d..fb753cc81bc0 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -293,41 +293,6 @@ void system_reset_exception(struct pt_regs *regs)
 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
 
-#ifdef CONFIG_PPC64
-/*
- * This function is called in real mode. Strictly no printk's please.
- *
- * regs->nip and regs->msr contains srr0 and ssr1.
- */
-long machine_check_early(struct pt_regs *regs)
-{
-	long handled = 0;
-
-	__this_cpu_inc(irq_stat.mce_exceptions);
-
-	add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
-
-	if (cur_cpu_spec && cur_cpu_spec->machine_check_early)
-		handled = cur_cpu_spec->machine_check_early(regs);
-	return handled;
-}
-
-long hmi_exception_realmode(struct pt_regs *regs)
-{
-	__this_cpu_inc(irq_stat.hmi_exceptions);
-
-	wait_for_subcore_guest_exit();
-
-	if (ppc_md.hmi_exception_early)
-		ppc_md.hmi_exception_early(regs);
-
-	wait_for_tb_resync();
-
-	return 0;
-}
-
-#endif
-
 /*
  * I/O accesses can cause machine checks on powermacs.
  * Check if the NIP corresponds to the address of a sync
-- 
2.7.4
