Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9E6602C007A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Oct 2013 08:08:40 +1100 (EST)
Message-ID: <1381180104.645.176.camel@pasglop>
Subject: [PATCH] powerpc/irq: Don't switch to irq stack from softirq stack
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 08 Oct 2013 08:08:24 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

irq_exit() is now called on the irq stack, which can trigger a switch
to the softirq stack from the irq stack. If an interrupt happens at
that point, we will not properly detect the re-entrancy and clobber
the original return context on the irq stack.

This fixes it. The side effect is to prevent all nesting from softirq
stack to irq stack even in the "safe" case but it's simpler that way
and matches what x86_64 does.

Reported-by: Cédric Le Goater <clg@fr.ibm.com>
Tested-by: Cédric Le Goater <clg@fr.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Linus, I don't have my git repo at hand right now and this is pretty
urgent, can you apply it directly please ?

Cheers,
Ben.

 arch/powerpc/kernel/irq.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 57d286a..c7cb8c2 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -495,14 +495,15 @@ void __do_irq(struct pt_regs *regs)
 void do_IRQ(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
-	struct thread_info *curtp, *irqtp;
+	struct thread_info *curtp, *irqtp, *sirqtp;
 
 	/* Switch to the irq stack to handle this */
 	curtp = current_thread_info();
 	irqtp = hardirq_ctx[raw_smp_processor_id()];
+	sirqtp = softirq_ctx[raw_smp_processor_id()];
 
 	/* Already there ? */
-	if (unlikely(curtp == irqtp)) {
+	if (unlikely(curtp == irqtp || curtp == sirqtp)) {
 		__do_irq(regs);
 		set_irq_regs(old_regs);
 		return;
-- 
1.7.10.4
