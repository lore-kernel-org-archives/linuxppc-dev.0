Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xPqqg2HQ1zDqmD
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  6 Aug 2017 03:03:11 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id 83so4725010pgb.4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 05 Aug 2017 10:03:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 04/13] powerpc/64: cleanup __check_irq_replay
Date: Sun,  6 Aug 2017 03:02:32 +1000
Message-Id: <20170805170241.22966-5-npiggin@gmail.com>
In-Reply-To: <20170805170241.22966-1-npiggin@gmail.com>
References: <20170805170241.22966-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the clearing of irq_happened bits into the condition where
they were found to be set. This reduces instruction count slightly,
and reduces stores into irq_happened.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/irq.c | 45 +++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f291f7826abc..7c46e0cce054 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -143,9 +143,10 @@ notrace unsigned int __check_irq_replay(void)
 	 */
 	unsigned char happened = local_paca->irq_happened;
 
-	/* Clear bit 0 which we wouldn't clear otherwise */
-	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
 	if (happened & PACA_IRQ_HARD_DIS) {
+		/* Clear bit 0 which we wouldn't clear otherwise */
+		local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
+
 		/*
 		 * We may have missed a decrementer interrupt if hard disabled.
 		 * Check the decrementer register in case we had a rollover
@@ -173,39 +174,39 @@ notrace unsigned int __check_irq_replay(void)
 	 * This is a higher priority interrupt than the others, so
 	 * replay it first.
 	 */
-	local_paca->irq_happened &= ~PACA_IRQ_HMI;
-	if (happened & PACA_IRQ_HMI)
+	if (happened & PACA_IRQ_HMI) {
+		local_paca->irq_happened &= ~PACA_IRQ_HMI;
 		return 0xe60;
+	}
 
-	/*
-	 * We may have missed a decrementer interrupt. We check the
-	 * decrementer itself rather than the paca irq_happened field
-	 * in case we also had a rollover while hard disabled
-	 */
-	local_paca->irq_happened &= ~PACA_IRQ_DEC;
-	if (happened & PACA_IRQ_DEC)
+	if (happened & PACA_IRQ_DEC) {
+		local_paca->irq_happened &= ~PACA_IRQ_DEC;
 		return 0x900;
+	}
 
-	/* Finally check if an external interrupt happened */
-	local_paca->irq_happened &= ~PACA_IRQ_EE;
-	if (happened & PACA_IRQ_EE)
+	if (happened & PACA_IRQ_EE) {
+		local_paca->irq_happened &= ~PACA_IRQ_EE;
 		return 0x500;
+	}
 
 #ifdef CONFIG_PPC_BOOK3E
-	/* Finally check if an EPR external interrupt happened
-	 * this bit is typically set if we need to handle another
-	 * "edge" interrupt from within the MPIC "EPR" handler
+	/*
+	 * Check if an EPR external interrupt happened this bit is typically
+	 * set if we need to handle another "edge" interrupt from within the
+	 * MPIC "EPR" handler.
 	 */
-	local_paca->irq_happened &= ~PACA_IRQ_EE_EDGE;
-	if (happened & PACA_IRQ_EE_EDGE)
+	if (happened & PACA_IRQ_EE_EDGE) {
+		local_paca->irq_happened &= ~PACA_IRQ_EE_EDGE;
 		return 0x500;
+	}
 
-	local_paca->irq_happened &= ~PACA_IRQ_DBELL;
-	if (happened & PACA_IRQ_DBELL)
+	if (happened & PACA_IRQ_DBELL) {
+		local_paca->irq_happened &= ~PACA_IRQ_DBELL;
 		return 0x280;
+	}
 #else
-	local_paca->irq_happened &= ~PACA_IRQ_DBELL;
 	if (happened & PACA_IRQ_DBELL) {
+		local_paca->irq_happened &= ~PACA_IRQ_DBELL;
 		if (cpu_has_feature(CPU_FTR_HVMODE))
 			return 0xe80;
 		return 0xa00;
-- 
2.11.0
