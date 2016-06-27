Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSp55pXHzDqmr
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:25:49 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSp50cvxz9t1N
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:25:48 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/17] powerpc/irq: Add mechanism to force a replay of
 interrupts
Date: Mon, 27 Jun 2016 22:25:19 +1000
Message-Id: <1467030333-31435-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Calling this function with interrupts soft-disabled will cause
a replay of the external interrupt vector when they are re-enabled.

This will be used by the OPAL XICS backend (and latter by the native
XIVE code) to handle EOI signaling that there are more interrupts to
fetch from the hardware since the hardware won't issue another HW
interrupt in that case.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/hw_irq.h |  2 ++
 arch/powerpc/kernel/irq.c         | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index b59ac27..c7d82ff 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -130,6 +130,8 @@ static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 
 extern bool prep_irq_for_idle(void);
 
+extern void force_external_irq_replay(void);
+
 #else /* CONFIG_PPC64 */
 
 #define SET_MSR_EE(x)	mtmsr(x)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 3cb46a3..604e3dd 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -342,6 +342,20 @@ bool prep_irq_for_idle(void)
 	return true;
 }
 
+/* Force a replay of the external interrupt handler on this
+ * CPU.
+ */
+void force_external_irq_replay(void)
+{
+	/* This must only be called with interrupts soft-disabled,
+	 * the replay will happen when re-enabling
+	 */
+	WARN_ON(!arch_irqs_disabled());
+
+	/* Indicate in the PACA that we have an interrupt to replay */
+	local_paca->irq_happened |= PACA_IRQ_EE;
+}
+
 #endif /* CONFIG_PPC64 */
 
 int arch_show_interrupts(struct seq_file *p, int prec)
-- 
2.7.4
