Return-Path: <dgibson@ozlabs.org>
To: Paul Mackerras <paulus@samba.org>, Josh Boyer <jwboyer@linux.vnet.ibm.com>
From: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 1/3] Fix setting of irq trigger type in UIC driver
In-Reply-To: <20070814034811.GA8791@localhost.localdomain>
Message-Id: <20070814035242.8EED6DDEF4@ozlabs.org>
Date: Tue, 14 Aug 2007 13:52:42 +1000 (EST)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The UIC (interrupt controller in 4xx embedded CPUs) driver currently
missets the IRQ_lEVEL flag in desc->status, due to a thinko.  This
patch fixes the bug.

Currently this is only a cosmetic problem (affects the output in
/proc/interrupts), however subsequent patches will use the IRQ_LEVEL
flag to affect flow handling.

Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

---
 arch/powerpc/sysdev/uic.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: working-2.6/arch/powerpc/sysdev/uic.c
===================================================================
--- working-2.6.orig/arch/powerpc/sysdev/uic.c	2007-08-14 13:17:44.000000000 +1000
+++ working-2.6/arch/powerpc/sysdev/uic.c	2007-08-14 13:17:52.000000000 +1000
@@ -142,7 +142,7 @@ static int uic_set_irq_type(unsigned int
 
 	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
 	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
-	if (trigger)
+	if (!trigger)
 		desc->status |= IRQ_LEVEL;
 
 	spin_unlock_irqrestore(&uic->lock, flags);
