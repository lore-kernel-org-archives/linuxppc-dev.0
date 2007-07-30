Return-Path: <vbarshak@ru.mvista.com>
Received: from vaxon.spb.rtsoft.ru (unknown [212.176.242.38])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C2693DDEA2
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Jul 2007 02:36:20 +1000 (EST)
Received: from vaxon.spb.rtsoft.ru (localhost.localdomain [127.0.0.1])
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1) with ESMTP id l6UGZHfp010109
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jul 2007 20:35:17 +0400
Received: (from vaxon@localhost)
	by vaxon.spb.rtsoft.ru (8.13.1/8.13.1/Submit) id l6UGZHvK010106
	for linuxppc-dev@ozlabs.org; Mon, 30 Jul 2007 20:35:17 +0400
Date: Mon, 30 Jul 2007 20:35:17 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [ PATCH ] PowerPC cascade UIC IRQ handler fix.
Message-ID: <20070730163517.GA10087@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

PPC44x cascade UIC irq handler fix.

According to PPC44x UM, if an interrupt is configured as level-sensitive,
and a clear is attempted on the UIC_SR, the UIC_SR field is not
cleared if the incoming interrupt signal is at the asserted polarity.
This causes us to enter a cascade handler twice, since we first ack
parent UIC interrupt and ack child UIC one after that.
The patch checks child UIC msr value and returns IRQ_HANDLED
if there're no pending interrupts. Otherwise we get a kernel panic
with a "Fatal exception in interrupt" (illegal vector).
The patch also fixes status flags.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
---

--- linux.orig/arch/powerpc/sysdev/uic.c	2007-07-27 20:37:11.000000000 +0400
+++ linux/arch/powerpc/sysdev/uic.c	2007-07-30 20:26:48.000000000 +0400
@@ -142,7 +142,7 @@
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-	if (trigger)
+	if (!trigger)
 		desc->status |= IRQ_LEVEL;
 
 	spin_unlock_irqrestore(&uic->lock, flags);
@@ -207,6 +207,9 @@
 	int subvirq;
 
 	msr = mfdcr(uic->dcrbase + UIC_MSR);
+	if (!msr)
+		return IRQ_HANDLED;
+
 	src = 32 - ffs(msr);
 
 	subvirq = irq_linear_revmap(uic->irqhost, src);
