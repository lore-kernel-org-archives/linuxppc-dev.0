Return-Path: <buytenh@wantstofly.org>
Received: from mail.wantstofly.org (fw.wantstofly.org [80.101.37.227])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 11DB010088A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Mar 2011 19:27:01 +1100 (EST)
Date: Wed, 9 Mar 2011 09:26:56 +0100
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2 13/28] powerpc: platforms/ps3 irq_data conversion.
Message-ID: <20110309082656.GQ16649@mail.wantstofly.org>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110307235942.GR16649@mail.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110307235942.GR16649@mail.wantstofly.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>
---
v2: get_irq_chip_data(d->irq) => irq_data_get_irq_chip_data(d)

 arch/powerpc/platforms/ps3/interrupt.c |   40 ++++++++++++++++----------------
 1 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 92290ff..3988c86 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -99,16 +99,16 @@ static DEFINE_PER_CPU(struct ps3_private, ps3_private);
  * Sets ps3_bmp.mask and calls lv1_did_update_interrupt_mask().
  */
 
-static void ps3_chip_mask(unsigned int virq)
+static void ps3_chip_mask(struct irq_data *d)
 {
-	struct ps3_private *pd = get_irq_chip_data(virq);
+	struct ps3_private *pd = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
 	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
-		pd->thread_id, virq);
+		pd->thread_id, d->irq);
 
 	local_irq_save(flags);
-	clear_bit(63 - virq, &pd->bmp.mask);
+	clear_bit(63 - d->irq, &pd->bmp.mask);
 	lv1_did_update_interrupt_mask(pd->ppe_id, pd->thread_id);
 	local_irq_restore(flags);
 }
@@ -120,16 +120,16 @@ static void ps3_chip_mask(unsigned int virq)
  * Clears ps3_bmp.mask and calls lv1_did_update_interrupt_mask().
  */
 
-static void ps3_chip_unmask(unsigned int virq)
+static void ps3_chip_unmask(struct irq_data *d)
 {
-	struct ps3_private *pd = get_irq_chip_data(virq);
+	struct ps3_private *pd = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
 	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
-		pd->thread_id, virq);
+		pd->thread_id, d->irq);
 
 	local_irq_save(flags);
-	set_bit(63 - virq, &pd->bmp.mask);
+	set_bit(63 - d->irq, &pd->bmp.mask);
 	lv1_did_update_interrupt_mask(pd->ppe_id, pd->thread_id);
 	local_irq_restore(flags);
 }
@@ -141,10 +141,10 @@ static void ps3_chip_unmask(unsigned int virq)
  * Calls lv1_end_of_interrupt_ext().
  */
 
-static void ps3_chip_eoi(unsigned int virq)
+static void ps3_chip_eoi(struct irq_data *d)
 {
-	const struct ps3_private *pd = get_irq_chip_data(virq);
-	lv1_end_of_interrupt_ext(pd->ppe_id, pd->thread_id, virq);
+	const struct ps3_private *pd = irq_data_get_irq_chip_data(d);
+	lv1_end_of_interrupt_ext(pd->ppe_id, pd->thread_id, d->irq);
 }
 
 /**
@@ -153,9 +153,9 @@ static void ps3_chip_eoi(unsigned int virq)
 
 static struct irq_chip ps3_irq_chip = {
 	.name = "ps3",
-	.mask = ps3_chip_mask,
-	.unmask = ps3_chip_unmask,
-	.eoi = ps3_chip_eoi,
+	.irq_mask = ps3_chip_mask,
+	.irq_unmask = ps3_chip_unmask,
+	.irq_eoi = ps3_chip_eoi,
 };
 
 /**
@@ -202,7 +202,7 @@ static int ps3_virq_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 		goto fail_set;
 	}
 
-	ps3_chip_mask(*virq);
+	ps3_chip_mask(irq_get_irq_data(*virq));
 
 	return result;
 
@@ -296,7 +296,7 @@ int ps3_irq_plug_destroy(unsigned int virq)
 	pr_debug("%s:%d: ppe_id %llu, thread_id %llu, virq %u\n", __func__,
 		__LINE__, pd->ppe_id, pd->thread_id, virq);
 
-	ps3_chip_mask(virq);
+	ps3_chip_mask(irq_get_irq_data(virq));
 
 	result = lv1_disconnect_irq_plug_ext(pd->ppe_id, pd->thread_id, virq);
 
@@ -357,7 +357,7 @@ int ps3_event_receive_port_destroy(unsigned int virq)
 
 	pr_debug(" -> %s:%d virq %u\n", __func__, __LINE__, virq);
 
-	ps3_chip_mask(virq);
+	ps3_chip_mask(irq_get_irq_data(virq));
 
 	result = lv1_destruct_event_receive_port(virq_to_hw(virq));
 
@@ -492,7 +492,7 @@ int ps3_io_irq_destroy(unsigned int virq)
 	int result;
 	unsigned long outlet = virq_to_hw(virq);
 
-	ps3_chip_mask(virq);
+	ps3_chip_mask(irq_get_irq_data(virq));
 
 	/*
 	 * lv1_destruct_io_irq_outlet() will destroy the IRQ plug,
@@ -553,7 +553,7 @@ int ps3_vuart_irq_destroy(unsigned int virq)
 {
 	int result;
 
-	ps3_chip_mask(virq);
+	ps3_chip_mask(irq_get_irq_data(virq));
 	result = lv1_deconfigure_virtual_uart_irq();
 
 	if (result) {
@@ -605,7 +605,7 @@ int ps3_spe_irq_destroy(unsigned int virq)
 {
 	int result;
 
-	ps3_chip_mask(virq);
+	ps3_chip_mask(irq_get_irq_data(virq));
 
 	result = ps3_irq_plug_destroy(virq);
 	BUG_ON(result);
-- 
1.7.4
