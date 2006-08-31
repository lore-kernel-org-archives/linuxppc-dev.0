Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C272367B61
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Aug 2006 16:46:58 +1000 (EST)
Subject: [PATCH] powerpc: Fix PowerMac IRQ handling bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 31 Aug 2006 16:46:41 +1000
Message-Id: <1157006801.12526.121.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The port to genirq & the new powerpc interrupt model in 2.6.18
introduced a bug in the legacy PowerMac PIC code (used on older
machines) because of a typo potentially causing hangs due to interrupt
storms. This fixes it, along with a performance issue causing us to do
spurrious retriggers after masking an interrupt.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
This is another 2.6.18 regression, please apply to 2.6.18

Index: linux-work/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-work.orig/arch/powerpc/platforms/powermac/pic.c	2006-08-17 09:26:19.000000000 +1000
+++ linux-work/arch/powerpc/platforms/powermac/pic.c	2006-08-31 16:35:05.000000000 +1000
@@ -87,8 +87,8 @@ static void __pmac_retrigger(unsigned in
 static void pmac_mask_and_ack_irq(unsigned int virq)
 {
 	unsigned int src = irq_map[virq].hwirq;
-        unsigned long bit = 1UL << (virq & 0x1f);
-        int i = virq >> 5;
+        unsigned long bit = 1UL << (src & 0x1f);
+        int i = src >> 5;
         unsigned long flags;
 
 	spin_lock_irqsave(&pmac_pic_lock, flags);
@@ -175,7 +175,7 @@ static void pmac_mask_irq(unsigned int v
 
   	spin_lock_irqsave(&pmac_pic_lock, flags);
         __clear_bit(src, ppc_cached_irq_mask);
-        __pmac_set_irq_mask(src, 0);
+        __pmac_set_irq_mask(src, 1);
   	spin_unlock_irqrestore(&pmac_pic_lock, flags);
 }
 
