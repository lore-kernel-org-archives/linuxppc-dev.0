Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgdz90w64zDqBf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 14:27:33 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id r133so5452916pgr.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Aug 2017 21:27:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64: Fix watchdog configuration regressions
Date: Mon, 28 Aug 2017 14:27:19 +1000
Message-Id: <20170828042719.18197-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a couple more bits of fallout from the new hard lockup watchdog
patch.

It restores the required hw_nmi_get_sample_period() function for the
perf watchdog, and removes some function declarations on 64e that are only
defined for 64s. This fixes the 64e build when the hardlockup detector is
enabled.

It restores the default behaviour of disabling the perf watchdog, and also
fixes disabling the 64s watchdog when running as a guest.

Fixes: 2104180a53 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/nmi.h |  3 +--
 arch/powerpc/kernel/kvm.c      |  7 -------
 arch/powerpc/kernel/setup_64.c | 28 ++++++++++++++++++++++++++++
 3 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index 6f8e79cd35d8..3760150a0ff0 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -1,9 +1,8 @@
 #ifndef _ASM_NMI_H
 #define _ASM_NMI_H
 
-#ifdef CONFIG_HARDLOCKUP_DETECTOR
+#ifdef CONFIG_PPC_WATCHDOG
 extern void arch_touch_nmi_watchdog(void);
-
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
diff --git a/arch/powerpc/kernel/kvm.c b/arch/powerpc/kernel/kvm.c
index 1086ea37c832..9ad37f827a97 100644
--- a/arch/powerpc/kernel/kvm.c
+++ b/arch/powerpc/kernel/kvm.c
@@ -25,7 +25,6 @@
 #include <linux/kvm_para.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/nmi.h> /* hardlockup_detector_disable() */
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -719,12 +718,6 @@ static __init void kvm_free_tmp(void)
 
 static int __init kvm_guest_init(void)
 {
-	/*
-	 * The hardlockup detector is likely to get false positives in
-	 * KVM guests, so disable it by default.
-	 */
-	hardlockup_detector_disable();
-
 	if (!kvm_para_available())
 		goto free_tmp;
 
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index af23d4b576ec..da255a6762f2 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -751,3 +751,31 @@ unsigned long memory_block_size_bytes(void)
 struct ppc_pci_io ppc_pci_io;
 EXPORT_SYMBOL(ppc_pci_io);
 #endif
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	return ppc_proc_freq * watchdog_thresh;
+}
+#endif
+
+/*
+ * The perf based hardlockup detector breaks PMU event based branches, so
+ * disable it by default. Book3S has a soft-nmi hardlockup detector based
+ * on the decrementer interrupt, so it does not suffer from this problem.
+ *
+ * It is likely to get false positives in VM guests, so disable it there
+ * by default too.
+ */
+static int __init disable_hardlockup_detector(void)
+{
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+	hardlockup_detector_disable();
+#else
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		hardlockup_detector_disable();
+#endif
+
+	return 0;
+}
+early_initcall(disable_hardlockup_detector);
-- 
2.13.3
