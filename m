Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E1278DDE9F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 May 2007 23:18:38 +1000 (EST)
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
To: mingo@elte.hu, tglx@linutronix.de
Subject: [PATCH 2.6.21-rt2] PowerPC: revert fix for threaded fasteoi IRQ
	handlers
Date: Thu, 17 May 2007 17:20:08 +0400
References: <200611192243.34850.sshtylyov@ru.mvista.com>
In-Reply-To: <200611192243.34850.sshtylyov@ru.mvista.com>
MIME-Version: 1.0
Message-Id: <200705171719.34968.sshtylyov@ru.mvista.com>
Content-Type: text/plain;
  charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Revert the change to the "fasteoi" type chips as after handle_fasteoi_irq() had
been fixed, they've become meaningless (and even dangerous -- as was the case
with Celleb that has been fixed earlier)...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch in question wasn't even initially accepted but then was erroneously
restored along with the TOD patch.  I've asked to revert it but to no avail,
so here's the formal patch to revert it at last...

 arch/powerpc/platforms/iseries/irq.c  |    1 -
 arch/powerpc/platforms/pseries/xics.c |    2 --
 arch/powerpc/sysdev/mpic.c            |    1 -
 3 files changed, 4 deletions(-)

Index: linux-2.6/arch/powerpc/platforms/iseries/irq.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/iseries/irq.c
+++ linux-2.6/arch/powerpc/platforms/iseries/irq.c
@@ -279,7 +279,6 @@ static struct irq_chip iseries_pic = {
 	.shutdown	= iseries_shutdown_IRQ,
 	.unmask		= iseries_enable_IRQ,
 	.mask		= iseries_disable_IRQ,
-	.ack		= iseries_end_IRQ,
 	.eoi		= iseries_end_IRQ
 };
 
Index: linux-2.6/arch/powerpc/platforms/pseries/xics.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/pseries/xics.c
+++ linux-2.6/arch/powerpc/platforms/pseries/xics.c
@@ -456,7 +456,6 @@ static struct irq_chip xics_pic_direct =
 	.startup = xics_startup,
 	.mask = xics_mask_irq,
 	.unmask = xics_unmask_irq,
-	.ack = xics_eoi_direct,
 	.eoi = xics_eoi_direct,
 	.set_affinity = xics_set_affinity
 };
@@ -467,7 +466,6 @@ static struct irq_chip xics_pic_lpar = {
 	.startup = xics_startup,
 	.mask = xics_mask_irq,
 	.unmask = xics_unmask_irq,
-	.ack = xics_eoi_lpar,
 	.eoi = xics_eoi_lpar,
 	.set_affinity = xics_set_affinity
 };
Index: linux-2.6/arch/powerpc/sysdev/mpic.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mpic.c
+++ linux-2.6/arch/powerpc/sysdev/mpic.c
@@ -776,7 +776,6 @@ static int mpic_set_irq_type(unsigned in
 static struct irq_chip mpic_irq_chip = {
 	.mask		= mpic_mask_irq,
 	.unmask		= mpic_unmask_irq,
-	.ack		= mpic_end_irq,
 	.eoi		= mpic_end_irq,
 	.set_type	= mpic_set_irq_type,
 };
