Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0B37967B56
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Oct 2006 16:58:35 +1000 (EST)
Date: Wed, 11 Oct 2006 02:06:59 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ppc: Add missing calls set_irq_regs
Message-ID: <Pine.LNX.4.44.0610110206160.29377-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the timer_interrupt we were not calling set_irq_regs() and if we are
profiling we will end up calling get_irq_regs().  This causes bad things to
happen.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 6799b47da9c145fba3a855f74e20680acffe87a7
tree 30ed136bbebf14a71c5b0eeed76510ef884aee76
parent 53a5fbdc2dff55161a206ed1a1385a8fa8055c34
author Kumar Gala <galak@kernel.crashing.org> Wed, 11 Oct 2006 01:57:04 -0500
committer Kumar Gala <galak@kernel.crashing.org> Wed, 11 Oct 2006 01:57:04 -0500

 arch/ppc/kernel/time.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/ppc/kernel/time.c b/arch/ppc/kernel/time.c
index d4b2cf7..18ee851 100644
--- a/arch/ppc/kernel/time.c
+++ b/arch/ppc/kernel/time.c
@@ -62,6 +62,7 @@ #include <asm/nvram.h>
 #include <asm/cache.h>
 #include <asm/8xx_immap.h>
 #include <asm/machdep.h>
+#include <asm/irq_regs.h>
 
 #include <asm/time.h>
 
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
