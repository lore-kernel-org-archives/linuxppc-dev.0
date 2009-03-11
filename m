Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9A94CDE143
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:47:26 +1100 (EST)
Message-Id: <20090311003237.169865866@linutronix.de>
Date: Wed, 11 Mar 2009 00:46:30 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 16/18] powerpc: convert obsolete hw_interrupt_type to struct
	irq_chip
References: <20090311003204.592133594@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Impact: cleanup

Convert the last remaining users to struct irq_chip.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: linuxppc-dev@ozlabs.org
---
 arch/powerpc/include/asm/hw_irq.h     |    2 +-
 arch/powerpc/platforms/powermac/pic.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/powerpc/include/asm/hw_irq.h
===================================================================
--- linux-2.6.orig/arch/powerpc/include/asm/hw_irq.h
+++ linux-2.6/arch/powerpc/include/asm/hw_irq.h
@@ -129,7 +129,7 @@ static inline int irqs_disabled_flags(un
  * interrupt-retrigger: should we handle this via lost interrupts and IPIs
  * or should we not care like we do now ? --BenH.
  */
-struct hw_interrupt_type;
+struct irq_chip;
 
 #endif	/* __KERNEL__ */
 #endif	/* _ASM_POWERPC_HW_IRQ_H */
Index: linux-2.6/arch/powerpc/platforms/powermac/pic.h
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/powermac/pic.h
+++ linux-2.6/arch/powerpc/platforms/powermac/pic.h
@@ -3,7 +3,7 @@
 
 #include <linux/irq.h>
 
-extern struct hw_interrupt_type pmac_pic;
+extern struct irq_chip pmac_pic;
 
 extern void pmac_pic_init(void);
 extern int pmac_get_irq(void);
