Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 45CE62C0138
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 17:04:13 +1000 (EST)
Message-ID: <1367910242.5769.11.camel@pasglop>
Subject: [PATCH] powerpc: Make hard_irq_disable() do the right thing vs. irq
 tracing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Tue, 07 May 2013 17:04:02 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org,
 Tiejun Chen <tiejun.chen@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If hard_irq_disable() is called while interrupts are already soft-disabled
(which is the most common case) all is already well.

However you can (and in some cases want) to call it while everything is
enabled (to make sure you don't get a lazy even, for example before entry
into KVM guests) and in this case we need to inform the irq tracer that
the irqs are going off.

We have to change the inline into a macro to avoid an include circular
dependency hell hole.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

Tested on pseries, Scott, I don't expect a problem with that patch especially
since most callers already are soft disabled, so I'll merge it now along with
my other pending stuff and you can simplify your KVM one.

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index e45c494..d615b28 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -95,15 +95,13 @@ static inline bool arch_irqs_disabled(void)
 #define __hard_irq_disable()	__mtmsrd(local_paca->kernel_msr, 1)
 #endif
 
-static inline void hard_irq_disable(void)
-{
-	__hard_irq_disable();
-	get_paca()->soft_enabled = 0;
-	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;
-}
-
-/* include/linux/interrupt.h needs hard_irq_disable to be a macro */
-#define hard_irq_disable	hard_irq_disable
+#define hard_irq_disable()	do {			\
+	__hard_irq_disable();				\
+	if (local_paca->soft_enabled)			\
+		trace_hardirqs_off();			\
+	get_paca()->soft_enabled = 0;			\
+	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;	\
+} while(0)
 
 static inline bool lazy_irq_pending(void)
 {
