Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wprm14y7TzDqGt
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 16:57:37 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id j186so4280079pge.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 23:57:37 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, Babu Moger <babu.moger@oracle.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 2/5] watchdog: introduce arch_touch_nmi_watchdog()
Date: Fri, 16 Jun 2017 16:57:12 +1000
Message-Id: <20170616065715.18390-3-npiggin@gmail.com>
In-Reply-To: <20170616065715.18390-1-npiggin@gmail.com>
References: <20170616065715.18390-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For architectures that define HAVE_NMI_WATCHDOG, instead of having
them provide the complete touch_nmi_watchdog() function, just have
them provide arch_touch_nmi_watchdog().

This gives the generic code more flexibility in implementing this
function, and arch implementations don't miss out on touching the
softlockup watchdog or other generic details.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/blackfin/include/asm/nmi.h            |  2 ++
 arch/blackfin/kernel/nmi.c                 |  2 +-
 arch/mn10300/include/asm/nmi.h             |  2 ++
 arch/mn10300/kernel/mn10300-watchdog-low.S |  8 ++++----
 arch/mn10300/kernel/mn10300-watchdog.c     |  2 +-
 arch/sparc/include/asm/nmi.h               |  1 +
 arch/sparc/kernel/nmi.c                    |  6 ++----
 include/linux/nmi.h                        | 27 ++++++++++++++++-----------
 kernel/watchdog_hld.c                      |  5 ++---
 9 files changed, 31 insertions(+), 24 deletions(-)

diff --git a/arch/blackfin/include/asm/nmi.h b/arch/blackfin/include/asm/nmi.h
index b9caac4fcfd8..107d23705f46 100644
--- a/arch/blackfin/include/asm/nmi.h
+++ b/arch/blackfin/include/asm/nmi.h
@@ -9,4 +9,6 @@
 
 #include <linux/nmi.h>
 
+extern void arch_touch_nmi_watchdog(void);
+
 #endif
diff --git a/arch/blackfin/kernel/nmi.c b/arch/blackfin/kernel/nmi.c
index 633c37083e87..1e714329fe8a 100644
--- a/arch/blackfin/kernel/nmi.c
+++ b/arch/blackfin/kernel/nmi.c
@@ -190,7 +190,7 @@ static int __init init_nmi_wdt(void)
 }
 device_initcall(init_nmi_wdt);
 
-void touch_nmi_watchdog(void)
+void arch_touch_nmi_watchdog(void)
 {
 	atomic_set(&nmi_touched[smp_processor_id()], 1);
 }
diff --git a/arch/mn10300/include/asm/nmi.h b/arch/mn10300/include/asm/nmi.h
index f3671cbbc117..b05627597b1b 100644
--- a/arch/mn10300/include/asm/nmi.h
+++ b/arch/mn10300/include/asm/nmi.h
@@ -11,4 +11,6 @@
 #ifndef _ASM_NMI_H
 #define _ASM_NMI_H
 
+extern void arch_touch_nmi_watchdog(void);
+
 #endif /* _ASM_NMI_H */
diff --git a/arch/mn10300/kernel/mn10300-watchdog-low.S b/arch/mn10300/kernel/mn10300-watchdog-low.S
index f2f5c9cfaabd..34f8773de7d0 100644
--- a/arch/mn10300/kernel/mn10300-watchdog-low.S
+++ b/arch/mn10300/kernel/mn10300-watchdog-low.S
@@ -50,9 +50,9 @@ watchdog_handler:
 #   we can't inline it)
 #
 ###############################################################################
-	.globl	touch_nmi_watchdog
-	.type	touch_nmi_watchdog,@function
-touch_nmi_watchdog:
+	.globl	arch_touch_nmi_watchdog
+	.type	arch_touch_nmi_watchdog,@function
+arch_touch_nmi_watchdog:
 	clr	d0
 	clr	d1
 	mov	watchdog_alert_counter, a0
@@ -63,4 +63,4 @@ touch_nmi_watchdog:
 	lne
 	ret	[],0
 
-	.size	touch_nmi_watchdog,.-touch_nmi_watchdog
+	.size	arch_touch_nmi_watchdog,.-arch_touch_nmi_watchdog
diff --git a/arch/mn10300/kernel/mn10300-watchdog.c b/arch/mn10300/kernel/mn10300-watchdog.c
index a2d8e6938d67..0d5641beadf5 100644
--- a/arch/mn10300/kernel/mn10300-watchdog.c
+++ b/arch/mn10300/kernel/mn10300-watchdog.c
@@ -31,7 +31,7 @@ static unsigned int watchdog;
 static unsigned int watchdog_hz = 1;
 unsigned int watchdog_alert_counter[NR_CPUS];
 
-EXPORT_SYMBOL(touch_nmi_watchdog);
+EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
 /*
  * the best way to detect whether a CPU has a 'hard lockup' problem
diff --git a/arch/sparc/include/asm/nmi.h b/arch/sparc/include/asm/nmi.h
index 26ad2b2607c6..284eac3ffaf2 100644
--- a/arch/sparc/include/asm/nmi.h
+++ b/arch/sparc/include/asm/nmi.h
@@ -7,6 +7,7 @@ void nmi_adjust_hz(unsigned int new_hz);
 
 extern atomic_t nmi_active;
 
+void arch_touch_nmi_watchdog(void);
 void start_nmi_watchdog(void *unused);
 void stop_nmi_watchdog(void *unused);
 
diff --git a/arch/sparc/kernel/nmi.c b/arch/sparc/kernel/nmi.c
index 95e73c63c99d..048ad783ea3f 100644
--- a/arch/sparc/kernel/nmi.c
+++ b/arch/sparc/kernel/nmi.c
@@ -51,7 +51,7 @@ static DEFINE_PER_CPU(unsigned int, last_irq_sum);
 static DEFINE_PER_CPU(long, alert_counter);
 static DEFINE_PER_CPU(int, nmi_touch);
 
-void touch_nmi_watchdog(void)
+void arch_touch_nmi_watchdog(void)
 {
 	if (atomic_read(&nmi_active)) {
 		int cpu;
@@ -61,10 +61,8 @@ void touch_nmi_watchdog(void)
 				per_cpu(nmi_touch, cpu) = 1;
 		}
 	}
-
-	touch_softlockup_watchdog();
 }
-EXPORT_SYMBOL(touch_nmi_watchdog);
+EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
 static void die_nmi(const char *str, struct pt_regs *regs, int do_panic)
 {
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index 5e2e57536d98..bd387ef8bccd 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -6,6 +6,9 @@
 
 #include <linux/sched.h>
 #include <asm/irq.h>
+#if defined(CONFIG_HAVE_NMI_WATCHDOG)
+#include <asm/nmi.h>
+#endif
 
 #ifdef CONFIG_LOCKUP_DETECTOR
 extern void touch_softlockup_watchdog_sched(void);
@@ -58,6 +61,18 @@ static inline void reset_hung_task_detector(void)
 #define NMI_WATCHDOG_ENABLED      (1 << NMI_WATCHDOG_ENABLED_BIT)
 #define SOFT_WATCHDOG_ENABLED     (1 << SOFT_WATCHDOG_ENABLED_BIT)
 
+#if defined(CONFIG_HARDLOCKUP_DETECTOR)
+extern void hardlockup_detector_disable(void);
+#else
+static inline void hardlockup_detector_disable(void) {}
+#endif
+
+#if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WATCHDOG)
+extern void arch_touch_nmi_watchdog(void);
+#else
+static inline void arch_touch_nmi_watchdog(void) {}
+#endif
+
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
  * 
@@ -65,21 +80,11 @@ static inline void reset_hung_task_detector(void)
  * may be used to reset the timeout - for code which intentionally
  * disables interrupts for a long time. This call is stateless.
  */
-#if defined(CONFIG_HAVE_NMI_WATCHDOG) || defined(CONFIG_HARDLOCKUP_DETECTOR)
-#include <asm/nmi.h>
-extern void touch_nmi_watchdog(void);
-#else
 static inline void touch_nmi_watchdog(void)
 {
+	arch_touch_nmi_watchdog();
 	touch_softlockup_watchdog();
 }
-#endif
-
-#if defined(CONFIG_HARDLOCKUP_DETECTOR)
-extern void hardlockup_detector_disable(void);
-#else
-static inline void hardlockup_detector_disable(void) {}
-#endif
 
 /*
  * Create trigger_all_cpu_backtrace() out of the arch-provided
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index 54a427d1f344..90d688df6ce1 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -56,7 +56,7 @@ static int __init hardlockup_panic_setup(char *str)
 }
 __setup("nmi_watchdog=", hardlockup_panic_setup);
 
-void touch_nmi_watchdog(void)
+void arch_touch_nmi_watchdog(void)
 {
 	/*
 	 * Using __raw here because some code paths have
@@ -66,9 +66,8 @@ void touch_nmi_watchdog(void)
 	 * going off.
 	 */
 	raw_cpu_write(watchdog_nmi_touch, true);
-	touch_softlockup_watchdog();
 }
-EXPORT_SYMBOL(touch_nmi_watchdog);
+EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
 static struct perf_event_attr wd_hw_attr = {
 	.type		= PERF_TYPE_HARDWARE,
-- 
2.11.0
