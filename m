Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 46120B823D
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Feb 2010 23:32:03 +1100 (EST)
Message-Id: <20100218122000.664096615@linutronix.de>
Date: Thu, 18 Feb 2010 12:23:14 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [patch 14/15] powerpc: Convert ipic_lock to raw_spinlock
References: <20100218121904.620984825@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

ipic_lock needs to be a real spinlock in RT. Convert it to
raw_spinlock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/sysdev/ipic.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: linux-2.6-tip/arch/powerpc/sysdev/ipic.c
===================================================================
--- linux-2.6-tip.orig/arch/powerpc/sysdev/ipic.c
+++ linux-2.6-tip/arch/powerpc/sysdev/ipic.c
@@ -32,7 +32,7 @@
 
 static struct ipic * primary_ipic;
 static struct irq_chip ipic_level_irq_chip, ipic_edge_irq_chip;
-static DEFINE_SPINLOCK(ipic_lock);
+static DEFINE_RAW_SPINLOCK(ipic_lock);
 
 static struct ipic_info ipic_info[] = {
 	[1] = {
@@ -530,13 +530,13 @@ static void ipic_unmask_irq(unsigned int
 	unsigned long flags;
 	u32 temp;
 
-	spin_lock_irqsave(&ipic_lock, flags);
+	raw_spin_lock_irqsave(&ipic_lock, flags);
 
 	temp = ipic_read(ipic->regs, ipic_info[src].mask);
 	temp |= (1 << (31 - ipic_info[src].bit));
 	ipic_write(ipic->regs, ipic_info[src].mask, temp);
 
-	spin_unlock_irqrestore(&ipic_lock, flags);
+	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
 static void ipic_mask_irq(unsigned int virq)
@@ -546,7 +546,7 @@ static void ipic_mask_irq(unsigned int v
 	unsigned long flags;
 	u32 temp;
 
-	spin_lock_irqsave(&ipic_lock, flags);
+	raw_spin_lock_irqsave(&ipic_lock, flags);
 
 	temp = ipic_read(ipic->regs, ipic_info[src].mask);
 	temp &= ~(1 << (31 - ipic_info[src].bit));
@@ -556,7 +556,7 @@ static void ipic_mask_irq(unsigned int v
 	 * for nearly all cases. */
 	mb();
 
-	spin_unlock_irqrestore(&ipic_lock, flags);
+	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
 static void ipic_ack_irq(unsigned int virq)
@@ -566,7 +566,7 @@ static void ipic_ack_irq(unsigned int vi
 	unsigned long flags;
 	u32 temp;
 
-	spin_lock_irqsave(&ipic_lock, flags);
+	raw_spin_lock_irqsave(&ipic_lock, flags);
 
 	temp = 1 << (31 - ipic_info[src].bit);
 	ipic_write(ipic->regs, ipic_info[src].ack, temp);
@@ -575,7 +575,7 @@ static void ipic_ack_irq(unsigned int vi
 	 * for nearly all cases. */
 	mb();
 
-	spin_unlock_irqrestore(&ipic_lock, flags);
+	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
 static void ipic_mask_irq_and_ack(unsigned int virq)
@@ -585,7 +585,7 @@ static void ipic_mask_irq_and_ack(unsign
 	unsigned long flags;
 	u32 temp;
 
-	spin_lock_irqsave(&ipic_lock, flags);
+	raw_spin_lock_irqsave(&ipic_lock, flags);
 
 	temp = ipic_read(ipic->regs, ipic_info[src].mask);
 	temp &= ~(1 << (31 - ipic_info[src].bit));
@@ -598,7 +598,7 @@ static void ipic_mask_irq_and_ack(unsign
 	 * for nearly all cases. */
 	mb();
 
-	spin_unlock_irqrestore(&ipic_lock, flags);
+	raw_spin_unlock_irqrestore(&ipic_lock, flags);
 }
 
 static int ipic_set_irq_type(unsigned int virq, unsigned int flow_type)
