Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYmXk6M40zDsF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Sep 2016 13:01:42 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id g202so70128pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 20:01:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/64: replay hypervisor maintenance priority
Date: Wed, 14 Sep 2016 13:01:21 +1000
Message-Id: <20160914030121.9755-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hmi is defined to be higher priority than other maskable
interrupts, so replay it first, as a best-effort to replay according
to hardware priorities.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/irq.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 3cb46a3..ad1a930 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -155,6 +155,15 @@ notrace unsigned int __check_irq_replay(void)
 	}
 
 	/*
+	 * Check if an hypervisor Maintenance interrupt happened.
+	 * This is a higher priority interrupt than the others, so
+	 * replay it first.
+	 */
+	local_paca->irq_happened &= ~PACA_IRQ_HMI;
+	if (happened & PACA_IRQ_HMI)
+		return 0xe60;
+
+	/*
 	 * We may have missed a decrementer interrupt. We check the
 	 * decrementer itself rather than the paca irq_happened field
 	 * in case we also had a rollover while hard disabled
@@ -189,11 +198,6 @@ notrace unsigned int __check_irq_replay(void)
 	}
 #endif /* CONFIG_PPC_BOOK3E */
 
-	/* Check if an hypervisor Maintenance interrupt happened */
-	local_paca->irq_happened &= ~PACA_IRQ_HMI;
-	if (happened & PACA_IRQ_HMI)
-		return 0xe60;
-
 	/* There should be nothing left ! */
 	BUG_ON(local_paca->irq_happened != 0);
 
-- 
2.9.3
