Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 4125p95r71zF33j
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 12:24:33 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
Message-Id: <38079a1f0a8670fd417c1f7e2358c7fba7c163b9.1528423341.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1528423341.git.fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v2 05/12] macintosh/via-pmu: Replace via pointer with via1 and
 via2 pointers
Date: Thu,  7 Jun 2018 22:24:29 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On most PowerPC Macs, the PMU driver uses the shift register and
IO port B from a single VIA chip.

On 68k and early PowerPC PowerBooks, the driver uses the shift register
from one VIA chip together with IO port B from another.

Replace via with via1 and via2 to accommodate this. For the
CONFIG_PPC_PMAC case, set via1 = via2 so there is no change.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/macintosh/via-pmu.c | 142 +++++++++++++++++++++-----------------------
 1 file changed, 69 insertions(+), 73 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index c4c324fb5fa6..2e09137410f6 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -76,7 +76,6 @@
 #define BATTERY_POLLING_COUNT	2
 
 static DEFINE_MUTEX(pmu_info_proc_mutex);
-static volatile unsigned char __iomem *via;
 
 /* VIA registers - spaced 0x200 bytes apart */
 #define RS		0x200		/* skip between registers */
@@ -145,6 +144,8 @@ static struct device_node *vias;
 static int pmu_kind = PMU_UNKNOWN;
 static int pmu_fully_inited;
 static int pmu_has_adb;
+static volatile unsigned char __iomem *via1;
+static volatile unsigned char __iomem *via2;
 static struct device_node *gpio_node;
 static unsigned char __iomem *gpio_reg;
 static int gpio_irq = 0;
@@ -340,14 +341,14 @@ int __init find_via_pmu(void)
 	} else
 		pmu_kind = PMU_UNKNOWN;
 
-	via = ioremap(taddr, 0x2000);
-	if (via == NULL) {
+	via1 = via2 = ioremap(taddr, 0x2000);
+	if (via1 == NULL) {
 		printk(KERN_ERR "via-pmu: Can't map address !\n");
 		goto fail_via_remap;
 	}
 	
-	out_8(&via[IER], IER_CLR | 0x7f);	/* disable all intrs */
-	out_8(&via[IFR], 0x7f);			/* clear IFR */
+	out_8(&via1[IER], IER_CLR | 0x7f);	/* disable all intrs */
+	out_8(&via1[IFR], 0x7f);			/* clear IFR */
 
 	pmu_state = idle;
 
@@ -362,8 +363,8 @@ int __init find_via_pmu(void)
 	return 1;
 
  fail_init:
-	iounmap(via);
-	via = NULL;
+	iounmap(via1);
+	via1 = via2 = NULL;
  fail_via_remap:
 	iounmap(gpio_reg);
 	gpio_reg = NULL;
@@ -437,7 +438,7 @@ static int __init via_pmu_start(void)
 	}
 
 	/* Enable interrupts */
-	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
+	out_8(&via1[IER], IER_SET | SR_INT | CB1_INT);
 
 	pmu_fully_inited = 1;
 
@@ -533,8 +534,8 @@ init_pmu(void)
 	struct adb_request req;
 
 	/* Negate TREQ. Set TACK to input and TREQ to output. */
-	out_8(&via[B], in_8(&via[B]) | TREQ);
-	out_8(&via[DIRB], (in_8(&via[DIRB]) | TREQ) & ~TACK);
+	out_8(&via2[B], in_8(&via2[B]) | TREQ);
+	out_8(&via2[DIRB], (in_8(&via2[DIRB]) | TREQ) & ~TACK);
 
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	timeout =  100000;
@@ -1174,7 +1175,7 @@ wait_for_ack(void)
 	 * reported
 	 */
 	int timeout = 4000;
-	while ((in_8(&via[B]) & TACK) == 0) {
+	while ((in_8(&via2[B]) & TACK) == 0) {
 		if (--timeout < 0) {
 			printk(KERN_ERR "PMU not responding (!ack)\n");
 			return;
@@ -1188,23 +1189,19 @@ wait_for_ack(void)
 static inline void
 send_byte(int x)
 {
-	volatile unsigned char __iomem *v = via;
-
-	out_8(&v[ACR], in_8(&v[ACR]) | SR_OUT | SR_EXT);
-	out_8(&v[SR], x);
-	out_8(&v[B], in_8(&v[B]) & ~TREQ);		/* assert TREQ */
-	(void)in_8(&v[B]);
+	out_8(&via1[ACR], in_8(&via1[ACR]) | SR_OUT | SR_EXT);
+	out_8(&via1[SR], x);
+	out_8(&via2[B], in_8(&via2[B]) & ~TREQ);	/* assert TREQ */
+	(void)in_8(&via2[B]);
 }
 
 static inline void
 recv_byte(void)
 {
-	volatile unsigned char __iomem *v = via;
-
-	out_8(&v[ACR], (in_8(&v[ACR]) & ~SR_OUT) | SR_EXT);
-	in_8(&v[SR]);		/* resets SR */
-	out_8(&v[B], in_8(&v[B]) & ~TREQ);
-	(void)in_8(&v[B]);
+	out_8(&via1[ACR], (in_8(&via1[ACR]) & ~SR_OUT) | SR_EXT);
+	in_8(&via1[SR]);		/* resets SR */
+	out_8(&via2[B], in_8(&via2[B]) & ~TREQ);
+	(void)in_8(&via2[B]);
 }
 
 static inline void
@@ -1307,7 +1304,7 @@ pmu_suspend(void)
 		if (!adb_int_pending && pmu_state == idle && !req_awaiting_reply) {
 			if (gpio_irq >= 0)
 				disable_irq_nosync(gpio_irq);
-			out_8(&via[IER], CB1_INT | IER_CLR);
+			out_8(&via1[IER], CB1_INT | IER_CLR);
 			spin_unlock_irqrestore(&pmu_lock, flags);
 			break;
 		}
@@ -1331,7 +1328,7 @@ pmu_resume(void)
 	adb_int_pending = 1;
 	if (gpio_irq >= 0)
 		enable_irq(gpio_irq);
-	out_8(&via[IER], CB1_INT | IER_SET);
+	out_8(&via1[IER], CB1_INT | IER_SET);
 	spin_unlock_irqrestore(&pmu_lock, flags);
 	pmu_poll();
 }
@@ -1456,20 +1453,20 @@ pmu_sr_intr(void)
 	struct adb_request *req;
 	int bite = 0;
 
-	if (in_8(&via[B]) & TREQ) {
-		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via[B]));
+	if (in_8(&via2[B]) & TREQ) {
+		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via2[B]));
 		return NULL;
 	}
 	/* The ack may not yet be low when we get the interrupt */
-	while ((in_8(&via[B]) & TACK) != 0)
+	while ((in_8(&via2[B]) & TACK) != 0)
 			;
 
 	/* if reading grab the byte, and reset the interrupt */
 	if (pmu_state == reading || pmu_state == reading_intr)
-		bite = in_8(&via[SR]);
+		bite = in_8(&via1[SR]);
 
 	/* reset TREQ and wait for TACK to go high */
-	out_8(&via[B], in_8(&via[B]) | TREQ);
+	out_8(&via2[B], in_8(&via2[B]) | TREQ);
 	wait_for_ack();
 
 	switch (pmu_state) {
@@ -1570,17 +1567,17 @@ via_pmu_interrupt(int irq, void *arg)
 	++disable_poll;
 	
 	for (;;) {
-		intr = in_8(&via[IFR]) & (SR_INT | CB1_INT);
+		intr = in_8(&via1[IFR]) & (SR_INT | CB1_INT);
 		if (intr == 0)
 			break;
 		handled = 1;
 		if (++nloop > 1000) {
 			printk(KERN_DEBUG "PMU: stuck in intr loop, "
 			       "intr=%x, ier=%x pmu_state=%d\n",
-			       intr, in_8(&via[IER]), pmu_state);
+			       intr, in_8(&via1[IER]), pmu_state);
 			break;
 		}
-		out_8(&via[IFR], intr);
+		out_8(&via1[IFR], intr);
 		if (intr & CB1_INT) {
 			adb_int_pending = 1;
 			pmu_irq_stats[0]++;
@@ -1762,29 +1759,29 @@ static u32 save_via[8];
 static void
 save_via_state(void)
 {
-	save_via[0] = in_8(&via[ANH]);
-	save_via[1] = in_8(&via[DIRA]);
-	save_via[2] = in_8(&via[B]);
-	save_via[3] = in_8(&via[DIRB]);
-	save_via[4] = in_8(&via[PCR]);
-	save_via[5] = in_8(&via[ACR]);
-	save_via[6] = in_8(&via[T1CL]);
-	save_via[7] = in_8(&via[T1CH]);
+	save_via[0] = in_8(&via1[ANH]);
+	save_via[1] = in_8(&via1[DIRA]);
+	save_via[2] = in_8(&via1[B]);
+	save_via[3] = in_8(&via1[DIRB]);
+	save_via[4] = in_8(&via1[PCR]);
+	save_via[5] = in_8(&via1[ACR]);
+	save_via[6] = in_8(&via1[T1CL]);
+	save_via[7] = in_8(&via1[T1CH]);
 }
 static void
 restore_via_state(void)
 {
-	out_8(&via[ANH], save_via[0]);
-	out_8(&via[DIRA], save_via[1]);
-	out_8(&via[B], save_via[2]);
-	out_8(&via[DIRB], save_via[3]);
-	out_8(&via[PCR], save_via[4]);
-	out_8(&via[ACR], save_via[5]);
-	out_8(&via[T1CL], save_via[6]);
-	out_8(&via[T1CH], save_via[7]);
-	out_8(&via[IER], IER_CLR | 0x7f);	/* disable all intrs */
-	out_8(&via[IFR], 0x7f);				/* clear IFR */
-	out_8(&via[IER], IER_SET | SR_INT | CB1_INT);
+	out_8(&via1[ANH],  save_via[0]);
+	out_8(&via1[DIRA], save_via[1]);
+	out_8(&via1[B],    save_via[2]);
+	out_8(&via1[DIRB], save_via[3]);
+	out_8(&via1[PCR],  save_via[4]);
+	out_8(&via1[ACR],  save_via[5]);
+	out_8(&via1[T1CL], save_via[6]);
+	out_8(&via1[T1CH], save_via[7]);
+	out_8(&via1[IER], IER_CLR | 0x7f);	/* disable all intrs */
+	out_8(&via1[IFR], 0x7f);			/* clear IFR */
+	out_8(&via1[IER], IER_SET | SR_INT | CB1_INT);
 }
 
 #define	GRACKLE_PM	(1<<7)
@@ -2426,33 +2423,33 @@ device_initcall(pmu_device_init);
 
 #ifdef DEBUG_SLEEP
 static inline void 
-polled_handshake(volatile unsigned char __iomem *via)
+polled_handshake(void)
 {
-	via[B] &= ~TREQ; eieio();
-	while ((via[B] & TACK) != 0)
+	via2[B] &= ~TREQ; eieio();
+	while ((via2[B] & TACK) != 0)
 		;
-	via[B] |= TREQ; eieio();
-	while ((via[B] & TACK) == 0)
+	via2[B] |= TREQ; eieio();
+	while ((via2[B] & TACK) == 0)
 		;
 }
 
 static inline void 
-polled_send_byte(volatile unsigned char __iomem *via, int x)
+polled_send_byte(int x)
 {
-	via[ACR] |= SR_OUT | SR_EXT; eieio();
-	via[SR] = x; eieio();
-	polled_handshake(via);
+	via1[ACR] |= SR_OUT | SR_EXT; eieio();
+	via1[SR] = x; eieio();
+	polled_handshake();
 }
 
 static inline int
-polled_recv_byte(volatile unsigned char __iomem *via)
+polled_recv_byte(void)
 {
 	int x;
 
-	via[ACR] = (via[ACR] & ~SR_OUT) | SR_EXT; eieio();
-	x = via[SR]; eieio();
-	polled_handshake(via);
-	x = via[SR]; eieio();
+	via1[ACR] = (via1[ACR] & ~SR_OUT) | SR_EXT; eieio();
+	x = via1[SR]; eieio();
+	polled_handshake();
+	x = via1[SR]; eieio();
 	return x;
 }
 
@@ -2461,7 +2458,6 @@ pmu_polled_request(struct adb_request *req)
 {
 	unsigned long flags;
 	int i, l, c;
-	volatile unsigned char __iomem *v = via;
 
 	req->complete = 1;
 	c = req->data[0];
@@ -2473,21 +2469,21 @@ pmu_polled_request(struct adb_request *req)
 	while (pmu_state != idle)
 		pmu_poll();
 
-	while ((via[B] & TACK) == 0)
+	while ((via2[B] & TACK) == 0)
 		;
-	polled_send_byte(v, c);
+	polled_send_byte(c);
 	if (l < 0) {
 		l = req->nbytes - 1;
-		polled_send_byte(v, l);
+		polled_send_byte(l);
 	}
 	for (i = 1; i <= l; ++i)
-		polled_send_byte(v, req->data[i]);
+		polled_send_byte(req->data[i]);
 
 	l = pmu_data_len[c][1];
 	if (l < 0)
-		l = polled_recv_byte(v);
+		l = polled_recv_byte();
 	for (i = 0; i < l; ++i)
-		req->reply[i + req->reply_len] = polled_recv_byte(v);
+		req->reply[i + req->reply_len] = polled_recv_byte();
 
 	if (req->done)
 		(*req->done)(req);
-- 
2.16.4
