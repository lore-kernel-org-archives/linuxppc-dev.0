Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3BBC8DDEBC
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 05:13:05 +1000 (EST)
Date: Thu, 12 Jul 2007 14:12:57 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 2/4] Implement arch disable/enable irq hooks.
Message-ID: <20070712191257.GA31381@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070712191205.GA31358@ld0162-tx32.am.freescale.net>
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
 arch/powerpc/kernel/time.c    |   41 +++++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/machdep.h |   10 ++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index e5df167..253f46d 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -728,6 +728,47 @@ void wakeup_decrementer(void)
 	set_dec(ticks);
 }
 
+#ifdef CONFIG_PM
+void generic_suspend_disable_irqs(void)
+{
+	preempt_disable();
+
+	/* Disable the decrementer, so that it doesn't interfere
+	 * with suspending.
+	 */
+
+	set_dec(0x7fffffff);
+	local_irq_disable();
+	set_dec(0x7fffffff);
+}
+
+void generic_suspend_enable_irqs(void)
+{
+	wakeup_decrementer();
+
+	local_irq_enable();
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
index 71c6e7e..492ecf3 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -253,6 +253,16 @@ struct machdep_calls {
 	 */
 	void (*machine_kexec)(struct kimage *image);
 #endif /* CONFIG_KEXEC */
+
+#ifdef CONFIG_PM
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
-- 
1.5.0.3
