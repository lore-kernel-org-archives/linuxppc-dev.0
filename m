Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfl2h1K4lzDqY1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 22:11:56 +1100 (AEDT)
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC] powerpc: handle simultanneous interrupts at once
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Message-Id: <20170310111152.1B3BF679C4@localhost.localdomain>
Date: Fri, 10 Mar 2017 12:11:51 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It often happens to have simultanneous interrupts, for instance
when having double Ethernet attachment. With the current
implementation, we suffer the cost of kernel entry/exit for each
interrupt.

This patch introduces a loop in __do_irq() to handle all interrupts
at once before returning.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/hw_irq.h |  6 ++++++
 arch/powerpc/kernel/irq.c         | 22 +++++++++++++++-------
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index eba60416536e..d69ae5846955 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -123,6 +123,11 @@ static inline void may_hard_irq_enable(void)
 		__hard_irq_enable();
 }
 
+static inline void may_hard_irq_disable(void)
+{
+	__hard_irq_disable();
+}
+
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
 	return !regs->softe;
@@ -204,6 +209,7 @@ static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 }
 
 static inline void may_hard_irq_enable(void) { }
+static inline void may_hard_irq_disable(void) { }
 
 #endif /* CONFIG_PPC64 */
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index a018f5cae899..28aca510c166 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -515,14 +515,22 @@ void __do_irq(struct pt_regs *regs)
 	 */
 	irq = ppc_md.get_irq();
 
-	/* We can hard enable interrupts now to allow perf interrupts */
-	may_hard_irq_enable();
+	do {
+		/* We can hard enable interrupts now to allow perf interrupts */
+		may_hard_irq_enable();
+
+		/* And finally process it */
+		if (unlikely(!irq))
+			__this_cpu_inc(irq_stat.spurious_irqs);
+		else
+			generic_handle_irq(irq);
+
+		may_hard_irq_disable();
 
-	/* And finally process it */
-	if (unlikely(!irq))
-		__this_cpu_inc(irq_stat.spurious_irqs);
-	else
-		generic_handle_irq(irq);
+		irq = ppc_md.get_irq();
+	} while (irq);
+
+	may_hard_irq_enable();
 
 	trace_irq_exit(regs);
 
-- 
2.12.0
