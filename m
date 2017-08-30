Return-Path: <clg@kaod.org>
Received: from 10.mo68.mail-out.ovh.net (10.mo68.mail-out.ovh.net
 [46.105.79.203])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjGTp32S1zDqNY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 05:56:14 +1000 (AEST)
Received: from player776.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1D8AE76430
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 21:46:52 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 3/8] powerpc/xive: rename xive_poke_esb() in xive_esb_read()
Date: Wed, 30 Aug 2017 21:46:12 +0200
Message-Id: <20170830194617.26621-4-clg@kaod.org>
In-Reply-To: <20170830194617.26621-1-clg@kaod.org>
References: <20170830194617.26621-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

xive_poke_esb() is performing a load/read so it is better named as
xive_esb_read() as we will need to introduce a xive_esb_write()
routine. Also use the XIVE_ESB_LOAD_EOI offset when EOI'ing LSI
interrupts.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 Changes since v1:

 - fixed naming.

 arch/powerpc/sysdev/xive/common.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index 8774af7a4105..8a58662ed793 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -190,7 +190,7 @@ static u32 xive_scan_interrupts(struct xive_cpu *xc, bool just_peek)
  * This is used to perform the magic loads from an ESB
  * described in xive.h
  */
-static u8 xive_poke_esb(struct xive_irq_data *xd, u32 offset)
+static u8 xive_esb_read(struct xive_irq_data *xd, u32 offset)
 {
 	u64 val;
 
@@ -227,7 +227,7 @@ void xmon_xive_do_dump(int cpu)
 	xive_dump_eq("IRQ", &xc->queue[xive_irq_priority]);
 #ifdef CONFIG_SMP
 	{
-		u64 val = xive_poke_esb(&xc->ipi_data, XIVE_ESB_GET);
+		u64 val = xive_esb_read(&xc->ipi_data, XIVE_ESB_GET);
 		xmon_printf("  IPI state: %x:%c%c\n", xc->hw_ipi,
 			val & XIVE_ESB_VAL_P ? 'P' : 'p',
 			val & XIVE_ESB_VAL_P ? 'Q' : 'q');
@@ -326,9 +326,9 @@ void xive_do_source_eoi(u32 hw_irq, struct xive_irq_data *xd)
 		 * properly.
 		 */
 		if (xd->flags & XIVE_IRQ_FLAG_LSI)
-			in_be64(xd->eoi_mmio);
+			xive_esb_read(xd, XIVE_ESB_LOAD_EOI);
 		else {
-			eoi_val = xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
+			eoi_val = xive_esb_read(xd, XIVE_ESB_SET_PQ_00);
 			DBG_VERBOSE("eoi_val=%x\n", offset, eoi_val);
 
 			/* Re-trigger if needed */
@@ -383,12 +383,12 @@ static void xive_do_source_set_mask(struct xive_irq_data *xd,
 	 * ESB accordingly on unmask.
 	 */
 	if (mask) {
-		val = xive_poke_esb(xd, XIVE_ESB_SET_PQ_01);
+		val = xive_esb_read(xd, XIVE_ESB_SET_PQ_01);
 		xd->saved_p = !!(val & XIVE_ESB_VAL_P);
 	} else if (xd->saved_p)
-		xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
+		xive_esb_read(xd, XIVE_ESB_SET_PQ_10);
 	else
-		xive_poke_esb(xd, XIVE_ESB_SET_PQ_00);
+		xive_esb_read(xd, XIVE_ESB_SET_PQ_00);
 }
 
 /*
@@ -768,7 +768,7 @@ static int xive_irq_retrigger(struct irq_data *d)
 	 * To perform a retrigger, we first set the PQ bits to
 	 * 11, then perform an EOI.
 	 */
-	xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
+	xive_esb_read(xd, XIVE_ESB_SET_PQ_11);
 
 	/*
 	 * Note: We pass "0" to the hw_irq argument in order to
@@ -803,7 +803,7 @@ static int xive_irq_set_vcpu_affinity(struct irq_data *d, void *state)
 		irqd_set_forwarded_to_vcpu(d);
 
 		/* Set it to PQ=10 state to prevent further sends */
-		pq = xive_poke_esb(xd, XIVE_ESB_SET_PQ_10);
+		pq = xive_esb_read(xd, XIVE_ESB_SET_PQ_10);
 
 		/* No target ? nothing to do */
 		if (xd->target == XIVE_INVALID_TARGET) {
@@ -832,7 +832,7 @@ static int xive_irq_set_vcpu_affinity(struct irq_data *d, void *state)
 		 * for sure the queue slot is no longer in use.
 		 */
 		if (pq & 2) {
-			pq = xive_poke_esb(xd, XIVE_ESB_SET_PQ_11);
+			pq = xive_esb_read(xd, XIVE_ESB_SET_PQ_11);
 			xd->saved_p = true;
 
 			/*
-- 
2.13.5
