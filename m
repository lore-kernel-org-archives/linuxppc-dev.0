Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id A295667C44
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Oct 2006 05:30:37 +1000 (EST)
From: Peter Korsgaard <jacmet@sunsite.dk>
To: paulus@samba.org
Subject: [PATCH] fix ARCH=ppc timer_interrupt after global pt_regs
Date: Mon, 16 Oct 2006 21:30:35 +0200
Message-ID: <871wp8ukh0.fsf@sleipner.barco.com>
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

Hi,

2.6.19-rc2 doesn't boot on arch/ppc (atleast of 4xx), because the
'global-pt_regs' megapatch forgot to fix up the arch/ppc
timer_interrupt handler. This patch fixes it.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

diff -urpN linux-2.6.19-rc2.orig/arch/ppc/kernel/time.c linux-2.6.19-rc2/arch/ppc/kernel/time.c
--- linux-2.6.19-rc2.orig/arch/ppc/kernel/time.c	2006-10-16 21:05:52.000000000 +0200
+++ linux-2.6.19-rc2/arch/ppc/kernel/time.c	2006-10-16 21:12:42.000000000 +0200
@@ -56,6 +56,7 @@
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/profile.h>
+#include <linux/irq.h>
 
 #include <asm/io.h>
 #include <asm/nvram.h>
@@ -129,6 +130,7 @@ void wakeup_decrementer(void)
  */
 void timer_interrupt(struct pt_regs * regs)
 {
+	struct pt_regs *old_regs;
 	int next_dec;
 	unsigned long cpu = smp_processor_id();
 	unsigned jiffy_stamp = last_jiffy_stamp(cpu);
@@ -137,6 +139,7 @@ void timer_interrupt(struct pt_regs * re
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);
 
+	old_regs = set_irq_regs(regs);
 	irq_enter();
 
 	while ((next_dec = tb_ticks_per_jiffy - tb_delta(&jiffy_stamp)) <= 0) {
@@ -188,6 +191,7 @@ void timer_interrupt(struct pt_regs * re
 		ppc_md.heartbeat();
 
 	irq_exit();
+	set_irq_regs(old_regs);
 }
 
 /*

-- 
Bye, Peter Korsgaard
