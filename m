Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xQqlm2c9czDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Aug 2017 18:03:15 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id c65so8329568pfl.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Aug 2017 01:03:15 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64e: Fix perf hardlockup detector build
Date: Mon,  7 Aug 2017 18:02:57 +1000
Message-Id: <20170807080257.13708-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a couple more bits of fallout when enabling the hardlockup
detector for 64e.

It restores the required hw_nmi_get_sample_period() function for the
perf watchdog, and restores disabling of the watchdog there. It also
removes API definitions that are only defined for 64s.

Fixes: 2104180a53 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---

This patch should go on top of the previous:

http://patchwork.ozlabs.org/patch/796202/

 arch/powerpc/include/asm/nmi.h |  3 +--
 arch/powerpc/kernel/setup_64.c | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 2 deletions(-)

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
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index af23d4b576ec..5db2ddd8c31d 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -751,3 +751,24 @@ unsigned long memory_block_size_bytes(void)
 struct ppc_pci_io ppc_pci_io;
 EXPORT_SYMBOL(ppc_pci_io);
 #endif
+
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+u64 hw_nmi_get_sample_period(int watchdog_thresh)
+{
+	return ppc_proc_freq * watchdog_thresh;
+}
+
+/*
+ * The perf based hardlockup detector breaks PMU event based branches and is
+ * likely to get false positives in KVM guests, so disable it by default.
+ * Book3S has a soft-nmi version based on the decrementer interrupt so it does
+ * not suffer from these problems.
+ */
+static int __init disable_hardlockup_detector(void)
+{
+	hardlockup_detector_disable();
+
+	return 0;
+}
+early_initcall(disable_hardlockup_detector);
+#endif
-- 
2.13.3
