Return-Path: <tipbot@zytor.com>
Received: from terminus.zytor.com (terminus.zytor.com [IPv6:2001:1868:205::10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 6D3DA2C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Mar 2014 04:14:44 +1100 (EST)
Date: Tue, 4 Mar 2014 08:39:53 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-a4e04c9f219d2c00764ffa7ba45500411815879d@git.kernel.org>
In-Reply-To: <20140223212736.333718121@linutronix.de>
References: <20140223212736.333718121@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:irq/core] powerpc: Irq: Use generic_handle_irq
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, peterz@infradead.org, linuxppc-dev@lists.ozlabs.org,
 tglx@linutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit-ID:  a4e04c9f219d2c00764ffa7ba45500411815879d
Gitweb:     http://git.kernel.org/tip/a4e04c9f219d2c00764ffa7ba45500411815879d
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Sun, 23 Feb 2014 21:40:08 +0000
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 4 Mar 2014 17:37:52 +0100

powerpc: Irq: Use generic_handle_irq

No functional change

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ppc <linuxppc-dev@lists.ozlabs.org>
Link: http://lkml.kernel.org/r/20140223212736.333718121@linutronix.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/kernel/irq.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 1d0848b..ca1cd74 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -465,7 +465,6 @@ static inline void check_stack_overflow(void)
 
 void __do_irq(struct pt_regs *regs)
 {
-	struct irq_desc *desc;
 	unsigned int irq;
 
 	irq_enter();
@@ -487,11 +486,8 @@ void __do_irq(struct pt_regs *regs)
 	/* And finally process it */
 	if (unlikely(irq == NO_IRQ))
 		__get_cpu_var(irq_stat).spurious_irqs++;
-	else {
-		desc = irq_to_desc(irq);
-		if (likely(desc))
-			desc->handle_irq(irq, desc);
-	}
+	else
+		generic_handle_irq(irq);
 
 	trace_irq_exit(regs);
 
