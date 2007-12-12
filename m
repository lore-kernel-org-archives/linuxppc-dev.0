Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D36E0DE06A
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Dec 2007 04:35:24 +1100 (EST)
Date: Wed, 12 Dec 2007 11:35:19 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 1/8] Implement arch disable/enable irq hooks.
Message-ID: <20071212173519.GA5577@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These hooks ensure that a decrementer interrupt is not pending when
suspending; otherwise, problems may occur.  For example, with deep sleep
on the 831x, a pending decrementer will cause a system freeze because the
SoC thinks the decrementer interrupt would have woken the system, but the
core must have interrupts disabled due to the setup required for deep
sleep.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Paul, please apply this series for 2.6.25 if all is well.

 arch/powerpc/kernel/time.c    |   41 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/machdep.h |   13 +++++++++++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index a925a8e..509f481 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -623,6 +623,47 @@ void wakeup_decrementer(void)
 	set_dec(ticks);
 }
 
+#ifdef CONFIG_SUSPEND
+void generic_suspend_disable_irqs(void)
+{
+	preempt_disable();
+
+	/* Disable the decrementer, so that it doesn't interfere
+	 * with suspending.
+	 */
+
+	set_dec(0x7fffffff);
+	hard_irq_disable();
+	set_dec(0x7fffffff);
+}
+
+void generic_suspend_enable_irqs(void)
+{
+	wakeup_decrementer();
+
+	hard_irq_enable();
+	preempt_enable();
+}
+
+/* Overrides the weak version in kernel/power/main.c */
+void arch_suspend_disable_irqs(void)
+{
+	if (ppc_md.suspend_disable_irqs)
+		ppc_md.suspend_disable_irqs();
+	else
+		generic_suspend_disable_irqs();
+}
+
+/* Overrides the weak version in kernel/power/main.c */
+void arch_suspend_enable_irqs(void)
+{
+	if (ppc_md.suspend_enable_irqs)
+		ppc_md.suspend_enable_irqs();
+	else
+		generic_suspend_enable_irqs();
+}
+#endif
+
 #ifdef CONFIG_SMP
 void __init smp_space_timers(unsigned int max_cpus)
 {
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 6968f43..15ba15a 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -253,6 +253,16 @@ struct machdep_calls {
 	 */
 	void (*machine_kexec)(struct kimage *image);
 #endif /* CONFIG_KEXEC */
+
+#ifdef CONFIG_SUSPEND
+	/* These are called to disable and enable, respectively, IRQs when
+	 * entering a suspend state.  If NULL, then the generic versions
+	 * will be called.  The generic versions disable/enable the
+	 * decrementer along with interrupts.
+	 */
+	void (*suspend_disable_irqs)(void);
+	void (*suspend_enable_irqs)(void);
+#endif
 };
 
 extern void power4_idle(void);
@@ -326,5 +336,8 @@ static inline void log_error(char *buf, unsigned int err_type, int fatal)
 		ppc_md.log_error(buf, err_type, fatal);
 }
 
+void generic_suspend_disable_irqs(void);
+void generic_suspend_enable_irqs(void);
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MACHDEP_H */
-- 
1.5.3.7
