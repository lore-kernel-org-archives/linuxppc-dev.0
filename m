Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1.1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBDFB1A0EE1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Dec 2015 15:00:37 +1100 (AEDT)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Paul Gortmaker <paul.gortmaker@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: warn on spurious irq events (but ratelimited)
Date: Mon, 7 Dec 2015 20:38:27 -0500
Message-ID: <1449538707-7867-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It might be worth warning on spurious IRQ events; they might
point someone at a bogus DTS value or similar.

But ratelimit them to ensure we aren't too spammy about it.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/kernel/irq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 290559df1e8b..5c777e3a4c04 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -497,10 +497,12 @@ void __do_irq(struct pt_regs *regs)
 	may_hard_irq_enable();
 
 	/* And finally process it */
-	if (unlikely(irq == NO_IRQ))
+	if (unlikely(irq == NO_IRQ)) {
+		printk_ratelimited(KERN_WARNING "spurious irq on %d\n", irq);
 		__this_cpu_inc(irq_stat.spurious_irqs);
-	else
+	} else {
 		generic_handle_irq(irq);
+	}
 
 	trace_irq_exit(regs);
 
-- 
2.6.1
