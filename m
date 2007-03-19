Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 008D4DE014
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 21:59:30 +1100 (EST)
Message-Id: <20070319105358.796834000@sipsolutions.net>
References: <20070319105352.771599000@sipsolutions.net>
Date: Mon, 19 Mar 2007 11:53:54 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/5] powerpc: fix suspend states again
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In commit 0fba3a1f39f8b0a50b56c8b068fa52131cbc84c2 (a very long time ago,
May 2006), I fixed a bug that caused powermacs to crash when you tried
entering standby/mem suspend states.

As I'm now getting more familiar with the suspend code I notice a few
more things:
 1. we previously misunderstood what pm_ops is for, it isn't supposed to be
    for doing platform dependent suspend/resume stuff that needs to be done
    for suspend to disk (as we currently try to use it!), it is instead for
    entering platform dependent suspend states ("standby", "mem").
 2. due to the first point, we never properly save FPU and altivec states
    when suspending to disk. It probably hasn't hurt yet because the process
    that writes the "disk" to /sys/power/state uses neither and its context
    is used.

This patch addresses these points as follows:
 1. remove all pm_ops from powermac, powermac suspend to ram isn't currently
    usable via /sys/power/state but is done via the PMU instead.
 2. move the code responsible for storing FPU/altivec state into a new
    arch_prepare_suspend function (previously, this was only present for
    32-bit platforms from asm-ppc.)

A follow-on patch will create new pm_ops for via-pmu.

I removed
	set_context(current->active_mm->context.id, current->active_mm->pgd);
because
 1. it works without and
 2. I don't see the point

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
 arch/powerpc/kernel/Makefile            |    1 
 arch/powerpc/kernel/swsusp.c            |   26 ++++++++++++
 arch/powerpc/platforms/powermac/setup.c |   65 --------------------------------
 include/asm-powerpc/suspend.h           |    9 ++++
 4 files changed, 36 insertions(+), 65 deletions(-)

--- linux-2.6.orig/arch/powerpc/platforms/powermac/setup.c	2007-03-19 11:47:26.622413925 +0100
+++ linux-2.6/arch/powerpc/platforms/powermac/setup.c	2007-03-19 11:47:39.132413925 +0100
@@ -420,76 +420,11 @@ static void __init find_boot_device(void
 #endif
 }
 
-/* TODO: Merge the suspend-to-ram with the common code !!!
- * currently, this is a stub implementation for suspend-to-disk
- * only
- */
-
-#ifdef CONFIG_SOFTWARE_SUSPEND
-
-static int pmac_pm_prepare(suspend_state_t state)
-{
-	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
-
-	return 0;
-}
-
-static int pmac_pm_enter(suspend_state_t state)
-{
-	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
-
-	/* Giveup the lazy FPU & vec so we don't have to back them
-	 * up from the low level code
-	 */
-	enable_kernel_fp();
-
-#ifdef CONFIG_ALTIVEC
-	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
-		enable_kernel_altivec();
-#endif /* CONFIG_ALTIVEC */
-
-	return 0;
-}
-
-static int pmac_pm_finish(suspend_state_t state)
-{
-	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
-
-	/* Restore userland MMU context */
-	set_context(current->active_mm->context.id, current->active_mm->pgd);
-
-	return 0;
-}
-
-static int pmac_pm_valid(suspend_state_t state)
-{
-	switch (state) {
-	case PM_SUSPEND_DISK:
-		return 1;
-	/* can't do any other states via generic mechanism yet */
-	default:
-		return 0;
-	}
-}
-
-static struct pm_ops pmac_pm_ops = {
-	.pm_disk_mode	= PM_DISK_SHUTDOWN,
-	.prepare	= pmac_pm_prepare,
-	.enter		= pmac_pm_enter,
-	.finish		= pmac_pm_finish,
-	.valid		= pmac_pm_valid,
-};
-
-#endif /* CONFIG_SOFTWARE_SUSPEND */
-
 static int initializing = 1;
 
 static int pmac_late_init(void)
 {
 	initializing = 0;
-#ifdef CONFIG_SOFTWARE_SUSPEND
-	pm_set_ops(&pmac_pm_ops);
-#endif /* CONFIG_SOFTWARE_SUSPEND */
 	return 0;
 }
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/include/asm-powerpc/suspend.h	2007-03-19 11:47:39.132413925 +0100
@@ -0,0 +1,9 @@
+#ifndef __ASM_POWERPC_SUSPEND_H
+#define __ASM_POWERPC_SUSPEND_H
+
+static inline int arch_prepare_suspend(void) { return 0; }
+
+void save_processor_state(void);
+static inline void restore_processor_state(void) {}
+
+#endif /* __ASM_POWERPC_SUSPEND_H */
--- linux-2.6.orig/arch/powerpc/kernel/Makefile	2007-03-19 11:47:26.692413925 +0100
+++ linux-2.6/arch/powerpc/kernel/Makefile	2007-03-19 11:47:39.172413925 +0100
@@ -36,6 +36,7 @@ obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsy
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj32-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_32.o
 obj32-$(CONFIG_MODULES)		+= module_32.o
 
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/arch/powerpc/kernel/swsusp.c	2007-03-19 11:47:39.172413925 +0100
@@ -0,0 +1,26 @@
+/*
+ * Common powerpc suspend code for 32 and 64 bits
+ *
+ * Copyright 2007	Johannes Berg <johannes@sipsolutions.net>
+ *
+ * GPLv2
+ */
+
+#include <asm/cputable.h>
+#include <asm/system.h>
+
+
+int save_processor_state(void)
+{
+	/* Giveup the lazy FPU & vec so we don't have to back them
+	 * up from the low level code
+	 */
+	enable_kernel_fp();
+
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec->cpu_features & CPU_FTR_ALTIVEC)
+		enable_kernel_altivec();
+#endif /* CONFIG_ALTIVEC */
+
+	return 0;
+}

--
