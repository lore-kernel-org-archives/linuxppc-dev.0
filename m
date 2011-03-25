Return-Path: <tglx@linutronix.de>
Received: from linutronix.de (www.linutronix.de [62.245.132.108])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C963100856
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 26 Mar 2011 09:08:01 +1100 (EST)
Message-Id: <20110325164140.933916953@linutronix.de>
Date: Fri, 25 Mar 2011 21:36:16 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [patch 03/14] powerpc: mac: pic: Use irqd_is_level_type()
References: <20110325164049.138289403@linutronix.de>
Cc: Lennert Buytenhek <buytenh@secretlab.ca>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No need for a redundant sparse irq lookup. irqdata provides the same
information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/powermac/pic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6-tip/arch/powerpc/platforms/powermac/pic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/platforms/powermac/pic.c
+++ linux-2.6-tip/arch/powerpc/platforms/powermac/pic.c
@@ -157,7 +157,7 @@ static unsigned int pmac_startup_irq(str
         int i = src >> 5;
 
 	raw_spin_lock_irqsave(&pmac_pic_lock, flags);
-	if ((irq_to_desc(d->irq)->status & IRQ_LEVEL) == 0)
+	if (!irqd_is_level_type(d))
 		out_le32(&pmac_irq_hw[i]->ack, bit);
         __set_bit(src, ppc_cached_irq_mask);
         __pmac_set_irq_mask(src, 0);
