Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zM6LZ34LTzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 23:47:34 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id f8so6750151plk.11
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Jan 2018 04:47:33 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/watchdog: remove arch_trigger_cpumask_backtrace
Date: Wed, 17 Jan 2018 22:47:22 +1000
Message-Id: <20180117124722.31063-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc NMI IPIs may not be recoverable if they are taken in
some sections of code, and also there have been and still are issues
with taking NMIs (in KVM guest code, in firmware, etc) which makes them
a bit dangerous to use.

Generic code like softlockup detector and rcu stall detectors really
hammer on trigger_*_backtrace, which has lead to further problems
because we've implemented it with the NMI.

So stop providing NMI backtraces for now. Importantly, the powerpc code
uses NMI IPIs in crash/debug, and the SMP hardlockup watchdog. So if the
softlockup and rcu hang detection traces are not being printed because
the CPU is stuck with interrupts off, then the hard lockup watchdog
should get it with the NMI IPI.

Fixes: 2104180a5369 ("powerpc/64s: implement arch-specific hardlockup watchdog")
Signed-of-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/nmi.h |  4 ----
 arch/powerpc/kernel/watchdog.c | 21 ---------------------
 2 files changed, 25 deletions(-)

diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index e97f58689ca7..9c80939b4d14 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -4,10 +4,6 @@
 
 #ifdef CONFIG_PPC_WATCHDOG
 extern void arch_touch_nmi_watchdog(void);
-extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
-					   bool exclude_self);
-#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
-
 #else
 static inline void arch_touch_nmi_watchdog(void) {}
 #endif
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 87da80ccced1..a49dd9e7e58a 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -394,24 +394,3 @@ int __init watchdog_nmi_probe(void)
 	return 0;
 }
 
-static void handle_backtrace_ipi(struct pt_regs *regs)
-{
-	nmi_cpu_backtrace(regs);
-}
-
-static void raise_backtrace_ipi(cpumask_t *mask)
-{
-	unsigned int cpu;
-
-	for_each_cpu(cpu, mask) {
-		if (cpu == smp_processor_id())
-			handle_backtrace_ipi(NULL);
-		else
-			smp_send_nmi_ipi(cpu, handle_backtrace_ipi, 1000000);
-	}
-}
-
-void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
-{
-	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);
-}
-- 
2.15.1
