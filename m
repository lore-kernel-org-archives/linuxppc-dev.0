Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id B47FCDE4AD
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 14:08:04 +1100 (EST)
Message-ID: <45BAC20F.10806@am.sony.com>
Date: Fri, 26 Jan 2007 19:07:59 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 6/16] ps3: rename interrupt symbols
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

Rename some PS3 interrupt symbols to avoid name clashes and aid debugging.
No change to code.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
 arch/powerpc/platforms/ps3/interrupt.c |   66 ++++++++++++++++-----------------
 1 files changed, 33 insertions(+), 33 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
@@ -288,7 +288,7 @@ int ps3_free_spe_irq(unsigned int virq)
 #define PS3_PLUG_MAX 63
 
 /**
- * struct bmp - a per cpu irq status and mask bitmap structure
+ * struct ps3_bmp - a per cpu irq status and mask bitmap structure
  * @status: 256 bit status bitmap indexed by plug
  * @unused_1:
  * @mask: 256 bit mask bitmap indexed by plug
@@ -311,7 +311,7 @@ int ps3_free_spe_irq(unsigned int virq)
  * can aquire.
  */
 
-struct bmp {
+struct ps3_bmp {
 	struct {
 		unsigned long status;
 		unsigned long unused_1[3];
@@ -323,16 +323,16 @@ struct bmp {
 };
 
 /**
- * struct private - a per cpu data structure
+ * struct ps3_private - a per cpu data structure
  * @node: HV node id
  * @cpu: HV thread id
- * @bmp: an HV bmp structure
+ * @bmp: an HV ps3_bmp structure
  */
 
-struct private {
+struct ps3_private {
 	unsigned long node;
 	unsigned int cpu;
-	struct bmp bmp;
+	struct ps3_bmp bmp;
 };
 
 #if defined(DEBUG)
@@ -353,7 +353,7 @@ static void __attribute__ ((unused)) _du
 }
 
 #define dump_bmp(_x) _dump_bmp(_x, __func__, __LINE__)
-static void _dump_bmp(struct private* pd, const char* func, int line)
+static void _dump_bmp(struct ps3_private* pd, const char* func, int line)
 {
 	unsigned long flags;
 
@@ -364,7 +364,7 @@ static void _dump_bmp(struct private* pd
 }
 
 #define dump_mask(_x) _dump_mask(_x, __func__, __LINE__)
-static void __attribute__ ((unused)) _dump_mask(struct private* pd,
+static void __attribute__ ((unused)) _dump_mask(struct ps3_private* pd,
 	const char* func, int line)
 {
 	unsigned long flags;
@@ -374,13 +374,13 @@ static void __attribute__ ((unused)) _du
 	spin_unlock_irqrestore(&pd->bmp.lock, flags);
 }
 #else
-static void dump_bmp(struct private* pd) {};
+static void dump_bmp(struct ps3_private* pd) {};
 #endif /* defined(DEBUG) */
 
-static void chip_mask(unsigned int virq)
+static void ps3_chip_mask(unsigned int virq)
 {
 	unsigned long flags;
-	struct private *pd = get_irq_chip_data(virq);
+	struct ps3_private *pd = get_irq_chip_data(virq);
 
 	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
 
@@ -394,10 +394,10 @@ static void chip_mask(unsigned int virq)
 	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
 }
 
-static void chip_unmask(unsigned int virq)
+static void ps3_chip_unmask(unsigned int virq)
 {
 	unsigned long flags;
-	struct private *pd = get_irq_chip_data(virq);
+	struct ps3_private *pd = get_irq_chip_data(virq);
 
 	pr_debug("%s:%d: cpu %u, virq %d\n", __func__, __LINE__, pd->cpu, virq);
 
@@ -411,19 +411,19 @@ static void chip_unmask(unsigned int vir
 	lv1_did_update_interrupt_mask(pd->node, pd->cpu);
 }
 
-static void chip_eoi(unsigned int virq)
+static void ps3_chip_eoi(unsigned int virq)
 {
 	lv1_end_of_interrupt(virq);
 }
 
 static struct irq_chip irq_chip = {
 	.typename = "ps3",
-	.mask = chip_mask,
-	.unmask = chip_unmask,
-	.eoi = chip_eoi,
+	.mask = ps3_chip_mask,
+	.unmask = ps3_chip_unmask,
+	.eoi = ps3_chip_eoi,
 };
 
-static void host_unmap(struct irq_host *h, unsigned int virq)
+static void ps3_host_unmap(struct irq_host *h, unsigned int virq)
 {
 	int result;
 
@@ -435,9 +435,9 @@ static void host_unmap(struct irq_host *
 	BUG_ON(result);
 }
 
-static DEFINE_PER_CPU(struct private, private);
+static DEFINE_PER_CPU(struct ps3_private, ps3_private);
 
-static int host_map(struct irq_host *h, unsigned int virq,
+static int ps3_host_map(struct irq_host *h, unsigned int virq,
 	irq_hw_number_t hwirq)
 {
 	int result;
@@ -460,7 +460,7 @@ static int host_map(struct irq_host *h, 
 		return -EPERM;
 	}
 
-	result = set_irq_chip_data(virq, &per_cpu(private, cpu));
+	result = set_irq_chip_data(virq, &per_cpu(ps3_private, cpu));
 	BUG_ON(result);
 
 	set_irq_chip_and_handler(virq, &irq_chip, handle_fasteoi_irq);
@@ -469,14 +469,14 @@ static int host_map(struct irq_host *h, 
 	return result;
 }
 
-static struct irq_host_ops host_ops = {
-	.map = host_map,
-	.unmap = host_unmap,
+static struct irq_host_ops ps3_host_ops = {
+	.map = ps3_host_map,
+	.unmap = ps3_host_unmap,
 };
 
 void __init ps3_register_ipi_debug_brk(unsigned int cpu, unsigned int virq)
 {
-	struct private *pd = &per_cpu(private, cpu);
+	struct ps3_private *pd = &per_cpu(ps3_private, cpu);
 
 	pd->bmp.ipi_debug_brk_mask = 0x8000000000000000UL >> virq;
 
@@ -484,7 +484,7 @@ void __init ps3_register_ipi_debug_brk(u
 		cpu, virq, pd->bmp.ipi_debug_brk_mask);
 }
 
-static int bmp_get_and_clear_status_bit(struct bmp *m)
+static int bmp_get_and_clear_status_bit(struct ps3_bmp *m)
 {
 	unsigned long flags;
 	unsigned int bit;
@@ -519,22 +519,22 @@ unsigned int ps3_get_irq(void)
 {
 	int plug;
 
-	struct private *pd = &__get_cpu_var(private);
+	struct ps3_private *pd = &__get_cpu_var(ps3_private);
 
 	plug = bmp_get_and_clear_status_bit(&pd->bmp);
 
 	if (plug < 1) {
 		pr_debug("%s:%d: no plug found: cpu %u\n", __func__, __LINE__,
 			pd->cpu);
-		dump_bmp(&per_cpu(private, 0));
-		dump_bmp(&per_cpu(private, 1));
+		dump_bmp(&per_cpu(ps3_private, 0));
+		dump_bmp(&per_cpu(ps3_private, 1));
 		return NO_IRQ;
 	}
 
 #if defined(DEBUG)
 	if (plug < NUM_ISA_INTERRUPTS || plug > PS3_PLUG_MAX) {
-		dump_bmp(&per_cpu(private, 0));
-		dump_bmp(&per_cpu(private, 1));
+		dump_bmp(&per_cpu(ps3_private, 0));
+		dump_bmp(&per_cpu(ps3_private, 1));
 		BUG();
 	}
 #endif
@@ -550,13 +550,13 @@ void __init ps3_init_IRQ(void)
 
 	lv1_get_logical_ppe_id(&node);
 
-	host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0, &host_ops,
+	host = irq_alloc_host(IRQ_HOST_MAP_NOMAP, 0, &ps3_host_ops,
 		PS3_INVALID_OUTLET);
 	irq_set_default_host(host);
 	irq_set_virq_count(PS3_PLUG_MAX + 1);
 
 	for_each_possible_cpu(cpu) {
-		struct private *pd = &per_cpu(private, cpu);
+		struct ps3_private *pd = &per_cpu(ps3_private, cpu);
 
 		pd->node = node;
 		pd->cpu = cpu;
