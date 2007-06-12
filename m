Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound5-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 01FA4DDE26
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 04:55:40 +1000 (EST)
Message-ID: <466EEBC4.9060203@am.sony.com>
Date: Tue, 12 Jun 2007 11:53:56 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 20/30] PS3: Rename processor id symbols
References: <20070612181825.730300780@am.sony.com>>
In-Reply-To: <20070612181825.730300780@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rename the PS3 static symbols node to ppe_id and cpu to thread_id
to clarify usage.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/interrupt.c |   55 +++++++++++++++++----------------
 1 file changed, 29 insertions(+), 26 deletions(-)

--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -79,14 +79,14 @@ struct ps3_bmp {
 /**
  * struct ps3_private - a per cpu data structure
  * @bmp: ps3_bmp structure
- * @node: HV logical_ppe_id
- * @cpu: HV thread_id
+ * @ppe_id: HV logical_ppe_id
+ * @thread_id: HV thread_id
  */
 
 struct ps3_private {
 	struct ps3_bmp bmp __attribute__ ((aligned (PS3_BMP_MINALIGN)));
-	u64 node;
-	unsigned int cpu;
+	u64 ppe_id;
+	u64 thread_id;
 };
 
 static DEFINE_PER_CPU(struct ps3_private, ps3_private);
@@ -106,7 +106,8 @@ static void ps3_chip_mask(unsigned int v
 	u64 old;
 	unsigned long flags;
 
-	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
+	pr_debug("%s:%d: thread_id %lu, virq %d\n", __func__, __LINE__,
+		pd->thread_id, virq);
 
 	local_irq_save(flags);
 	asm volatile(
@@ -118,7 +119,7 @@ static void ps3_chip_mask(unsigned int v
 		     : "r" (bit), "r" (p)
 		     : "cc" );
 
-	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
+	lv1_did_update_interrupt_mask(pd->ppe_id, pd->thread_id);
 	local_irq_restore(flags);
 }
 
@@ -137,7 +138,8 @@ static void ps3_chip_unmask(unsigned int
 	u64 old;
 	unsigned long flags;
 
-	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
+	pr_debug("%s:%d: thread_id %lu, virq %d\n", __func__, __LINE__,
+		pd->thread_id, virq);
 
 	local_irq_save(flags);
 	asm volatile(
@@ -149,7 +151,7 @@ static void ps3_chip_unmask(unsigned int
 		     : "r" (bit), "r" (p)
 		     : "cc" );
 
-	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
+	lv1_did_update_interrupt_mask(pd->ppe_id, pd->thread_id);
 	local_irq_restore(flags);
 }
 
@@ -163,7 +165,7 @@ static void ps3_chip_unmask(unsigned int
 static void ps3_chip_eoi(unsigned int virq)
 {
 	const struct ps3_private *pd = get_irq_chip_data(virq);
-	lv1_end_of_interrupt_ext(pd->node, pd->cpu, virq);
+	lv1_end_of_interrupt_ext(pd->ppe_id, pd->thread_id, virq);
 }
 
 /**
@@ -242,8 +244,8 @@ int ps3_virq_destroy(unsigned int virq)
 {
 	const struct ps3_private *pd = get_irq_chip_data(virq);
 
-	pr_debug("%s:%d: node %lu, cpu %d, virq %u\n", __func__, __LINE__,
-		pd->node, pd->cpu, virq);
+	pr_debug("%s:%d: ppe_id %lu, thread_id %lu, virq %u\n", __func__,
+		__LINE__, pd->ppe_id, pd->thread_id, virq);
 
 	set_irq_chip_data(virq, NULL);
 	irq_dispose_mapping(virq);
@@ -279,7 +281,8 @@ int ps3_irq_plug_setup(enum ps3_cpu_bind
 
 	/* Binds outlet to cpu + virq. */
 
-	result = lv1_connect_irq_plug_ext(pd->node, pd->cpu, *virq, outlet, 0);
+	result = lv1_connect_irq_plug_ext(pd->ppe_id, pd->thread_id, *virq,
+		outlet, 0);
 
 	if (result) {
 		pr_info("%s:%d: lv1_connect_irq_plug_ext failed: %s\n",
@@ -311,12 +314,12 @@ int ps3_irq_plug_destroy(unsigned int vi
 	int result;
 	const struct ps3_private *pd = get_irq_chip_data(virq);
 
-	pr_debug("%s:%d: node %lu, cpu %d, virq %u\n", __func__, __LINE__,
-		pd->node, pd->cpu, virq);
+	pr_debug("%s:%d: ppe_id %lu, thread_id %lu, virq %u\n", __func__,
+		__LINE__, pd->ppe_id, pd->thread_id, virq);
 
 	ps3_chip_mask(virq);
 
-	result = lv1_disconnect_irq_plug_ext(pd->node, pd->cpu, virq);
+	result = lv1_disconnect_irq_plug_ext(pd->ppe_id, pd->thread_id, virq);
 
 	if (result)
 		pr_info("%s:%d: lv1_disconnect_irq_plug_ext failed: %s\n",
@@ -658,8 +661,8 @@ static void _dump_bmp(struct ps3_private
 	unsigned long flags;
 
 	spin_lock_irqsave(&pd->bmp.lock, flags);
-	_dump_64_bmp("stat", &pd->bmp.status, pd->cpu, func, line);
-	_dump_64_bmp("mask", &pd->bmp.mask, pd->cpu, func, line);
+	_dump_64_bmp("stat", &pd->bmp.status, pd->thread_id, func, line);
+	_dump_64_bmp("mask", &pd->bmp.mask, pd->thread_id, func, line);
 	spin_unlock_irqrestore(&pd->bmp.lock, flags);
 }
 
@@ -670,7 +673,7 @@ static void __maybe_unused _dump_mask(st
 	unsigned long flags;
 
 	spin_lock_irqsave(&pd->bmp.lock, flags);
-	_dump_64_bmp("mask", &pd->bmp.mask, pd->cpu, func, line);
+	_dump_64_bmp("mask", &pd->bmp.mask, pd->thread_id, func, line);
 	spin_unlock_irqrestore(&pd->bmp.lock, flags);
 }
 #else
@@ -723,8 +726,8 @@ static unsigned int ps3_get_irq(void)
 	plug &= 0x3f;
 
 	if (unlikely(plug) == NO_IRQ) {
-		pr_debug("%s:%d: no plug found: cpu %u\n", __func__, __LINE__,
-			pd->cpu);
+		pr_debug("%s:%d: no plug found: thread_id %lu\n", __func__,
+			__LINE__, pd->thread_id);
 		dump_bmp(&per_cpu(ps3_private, 0));
 		dump_bmp(&per_cpu(ps3_private, 1));
 		return NO_IRQ;
@@ -754,16 +757,16 @@ void __init ps3_init_IRQ(void)
 	for_each_possible_cpu(cpu) {
 		struct ps3_private *pd = &per_cpu(ps3_private, cpu);
 
-		lv1_get_logical_ppe_id(&pd->node);
-		pd->cpu = get_hard_smp_processor_id(cpu);
+		lv1_get_logical_ppe_id(&pd->ppe_id);
+		pd->thread_id = get_hard_smp_processor_id(cpu);
 		spin_lock_init(&pd->bmp.lock);
 
-		pr_debug("%s:%d: node %lu, cpu %d, bmp %lxh\n", __func__,
-			__LINE__, pd->node, pd->cpu,
+		pr_debug("%s:%d: ppe_id %lu, thread_id %lu, bmp %lxh\n",
+			__func__, __LINE__, pd->ppe_id, pd->thread_id,
 			ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
 
-		result = lv1_configure_irq_state_bitmap(pd->node, pd->cpu,
-			ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
+		result = lv1_configure_irq_state_bitmap(pd->ppe_id,
+			pd->thread_id, ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
 
 		if (result)
 			pr_debug("%s:%d: lv1_configure_irq_state_bitmap failed:"

-- 
