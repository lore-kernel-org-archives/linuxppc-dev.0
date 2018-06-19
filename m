Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419NpS1LvXzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Jun 2018 09:05:04 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64s: Fix build failures with CONFIG_NMI_IPI=n
Date: Wed, 20 Jun 2018 09:04:54 +1000
Message-Id: <20180619230454.8881-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I broke the build when CONFIG_NMI_IPI=n with my recent commit to add
arch_trigger_cpumask_backtrace(), eg:

  stacktrace.c:(.text+0x1b0): undefined reference to `.smp_send_safe_nmi_ipi'

We should rework the CONFIG symbols here in future to avoid these
double barrelled ifdefs but for now they fix the build.

Fixes: 5cc05910f26e ("powerpc/64s: Wire up arch_trigger_cpumask_backtrace()")
Reported-by: Christophe LEROY <christophe.leroy@c-s.fr>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/nmi.h   | 2 +-
 arch/powerpc/kernel/stacktrace.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nmi.h b/arch/powerpc/include/asm/nmi.h
index 0f571e0ebca1..bd9ba8defd72 100644
--- a/arch/powerpc/include/asm/nmi.h
+++ b/arch/powerpc/include/asm/nmi.h
@@ -8,7 +8,7 @@ extern void arch_touch_nmi_watchdog(void);
 static inline void arch_touch_nmi_watchdog(void) {}
 #endif
 
-#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_STACKTRACE)
+#if defined(CONFIG_NMI_IPI) && defined(CONFIG_STACKTRACE)
 extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
 					   bool exclude_self);
 #define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
diff --git a/arch/powerpc/kernel/stacktrace.c b/arch/powerpc/kernel/stacktrace.c
index 07e97f289c52..e2c50b55138f 100644
--- a/arch/powerpc/kernel/stacktrace.c
+++ b/arch/powerpc/kernel/stacktrace.c
@@ -196,7 +196,7 @@ save_stack_trace_tsk_reliable(struct task_struct *tsk,
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk_reliable);
 #endif /* CONFIG_HAVE_RELIABLE_STACKTRACE */
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI)
 static void handle_backtrace_ipi(struct pt_regs *regs)
 {
 	nmi_cpu_backtrace(regs);
@@ -242,4 +242,4 @@ void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
 {
 	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_backtrace_ipi);
 }
-#endif /* CONFIG_PPC64 */
+#endif /* defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_NMI_IPI) */
-- 
2.14.1
