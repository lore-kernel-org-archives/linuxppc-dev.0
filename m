Return-Path: <srs0=wh99=4d=kernel.crashing.org=benh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wDJRp1cRQzDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 23:57:42 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wDJRn6VMqz8sv9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 23:57:41 +1000 (AEST)
Message-ID: <1493301446.25766.276.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/xive: Fix/improve verbose debug output
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Thu, 27 Apr 2017 15:57:26 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing verbose debug code doesn't build when enabled.

This fixes it and generally improves the output to make it
more useful.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/xive/common.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 6a98efb..2305aa9 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -143,7 +143,6 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, bool just_peek)
 		struct xive_q *q;
 
 		prio = ffs(xc->pending_prio) - 1;
-		DBG_VERBOSE("scan_irq: trying prio %d\n", prio);
 
 		/* Try to fetch */
 		irq = xive_read_eq(&xc->queue[prio], just_peek);
@@ -171,12 +170,18 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, bool just_peek)
 	}
 
 	/* If nothing was found, set CPPR to 0xff */
-	if (irq == 0)
+	if (irq == 0) {
 		prio = 0xff;
+		DBG_VERBOSE("scan_irq(%d): nothing found\n", just_peek);
+	} else {
+		DBG_VERBOSE("scan_irq(%d): found irq %d prio %d\n",
+			    just_peek, irq, prio);
+	}
 
 	/* Update HW CPPR to match if necessary */
 	if (prio != xc->cppr) {
-		DBG_VERBOSE("scan_irq: adjusting CPPR to %d\n", prio);
+		DBG_VERBOSE("scan_irq(%d): adjusting CPPR %d->%d\n",
+			    just_peek, xc->cppr, prio);
 		xc->cppr = prio;
 		out_8(xive_tima + xive_tima_offset + TM_CPPR, prio);
 	}
@@ -260,7 +265,7 @@ static unsigned int xive_get_irq(void)
 	/* Scan our queue(s) for interrupts */
 	irq = xive_scan_interrupts(xc, false);
 
-	DBG_VERBOSE("get_irq: got irq 0x%x, new pending=0x%02x\n",
+	DBG_VERBOSE("get_irq: got irq %d new pending=0x%02x\n",
 	    irq, xc->pending_prio);
 
 	/* Return pending interrupt if any */
@@ -282,7 +287,7 @@ static unsigned int xive_get_irq(void)
 static void xive_do_queue_eoi(struct xive_cpu *xc)
 {
 	if (xive_scan_interrupts(xc, true) != 0) {
-		DBG_VERBOSE("eoi: pending=0x%02x\n", xc->pending_prio);
+		DBG_VERBOSE("eoi_irq: more pending !\n");
 		force_external_irq_replay();
 	}
 }
@@ -327,11 +332,13 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
 			in_be64(xd->eoi_mmio);
 		else {
 			eoi_val = xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
-			DBG_VERBOSE("eoi_val=%x\n", offset, eoi_val);
+			DBG_VERBOSE("hwirq 0x%x eoi_val=%x\n", hw_irq, eoi_val);
 
 			/* Re-trigger if needed */
-			if ((eoi_val & XIVE_ESB_VAL_Q) && xd->trig_mmio)
+			if ((eoi_val & XIVE_ESB_VAL_Q) && xd->trig_mmio) {
+				DBG_VERBOSE(" -> eoi retrigger !\n");
 				out_be64(xd->trig_mmio, 0);
+			}
 		}
 	}
 }
@@ -380,10 +387,15 @@ static void xive_do_source_set_mask(struct xive_irq_data *xd,
 	if (mask) {
 		val = xive_poke_esb(xd, XIVE_ESB_SET_PQ_01);
 		xd->saved_p = !!(val & XIVE_ESB_VAL_P);
-	} else if (xd->saved_p)
-		xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
-	else
-		xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
+		DBG_VERBOSE("masking val=%llx, sp=%d\n",
+			    val, xd->saved_p);
+	} else {
+		DBG_VERBOSE("unmasking sp=%d\n", xd->saved_p);
+		if (xd->saved_p)
+			xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
+		else
+			xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
+	}
 }
 
 /*
@@ -526,6 +538,7 @@ static unsigned int xive_irq_startup(struct irq_data *d)
 
 	pr_devel("xive_irq_startup: irq %d [0x%x] data @%p\n",
 		 d->irq, hw_irq, d);
+	pr_devel("  eoi_mmio=%p trig_mmio=%p\n", xd->eoi_mmio, xd->trig_mmio);
 
 #ifdef CONFIG_PCI_MSI
 	/*
@@ -754,6 +767,8 @@ static int xive_irq_retrigger(struct irq_data *d)
 	if (WARN_ON(xd->flags & XIVE_IRQ_FLAG_LSI))
 		return 0;
 
+	DBG_VERBOSE("retrigger irq %d\n", d->irq);
+
 	/*
 	 * To perform a retrigger, we first set the PQ bits to
 	 * 11, then perform an EOI.
