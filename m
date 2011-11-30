Return-Path: <geoff@infradead.org>
Message-Id: <0b790c7b9164ec4b61f3853f615627331a72d14a.1322615824.git.geoff@infradead.org>
In-Reply-To: <cover.1322615824.git.geoff@infradead.org>
References: <cover.1322615824.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Subject: [PATCH 1/8] powerpc/ps3: Interrupt code cleanup
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 Nov 2011 01:38:49 +0000
Cc: cbe-oss-dev@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

General code cleanup for PS3 interrupt.c:

 o Fill out comments for structure members.
 o Move variables ipi_debug_brk_mask and lock from struct ps3_bmp to
   struct ps3_private.
 o Fix pr_debug build errors when DEBUG is defined.
 o Convert bit operation to set_bit().
 o Convert DBG macro from pr_debug to pr_devel
 o Add new macro FAIL to replace pr_debug calls

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/interrupt.c |  103 ++++++++++++++++---------------
 1 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/arch/powerpc/platforms/ps3/interrupt.c b/arch/powerpc/platforms/ps3/interrupt.c
index 1d6f4f4..617efa1 100644
--- a/arch/powerpc/platforms/ps3/interrupt.c
+++ b/arch/powerpc/platforms/ps3/interrupt.c
@@ -31,18 +31,18 @@
 
 #if defined(DEBUG)
 #define DBG udbg_printf
+#define FAIL udbg_printf
 #else
-#define DBG pr_debug
+#define DBG pr_devel
+#define FAIL pr_debug
 #endif
 
 /**
  * struct ps3_bmp - a per cpu irq status and mask bitmap structure
  * @status: 256 bit status bitmap indexed by plug
- * @unused_1:
+ * @unused_1: Alignment
  * @mask: 256 bit mask bitmap indexed by plug
- * @unused_2:
- * @lock:
- * @ipi_debug_brk_mask:
+ * @unused_2: Alignment
  *
  * The HV maintains per SMT thread mappings of HV outlet to HV plug on
  * behalf of the guest.  These mappings are implemented as 256 bit guest
@@ -73,21 +73,24 @@ struct ps3_bmp {
 		unsigned long mask;
 		u64 unused_2[3];
 	};
-	u64 ipi_debug_brk_mask;
-	spinlock_t lock;
 };
 
 /**
  * struct ps3_private - a per cpu data structure
  * @bmp: ps3_bmp structure
+ * @bmp_lock: Syncronize access to bmp.
+ * @ipi_debug_brk_mask: Mask for debug break IPIs
  * @ppe_id: HV logical_ppe_id
  * @thread_id: HV thread_id
+ * @ipi_mask: Mask of IPI virqs
  */
 
 struct ps3_private {
 	struct ps3_bmp bmp __attribute__ ((aligned (PS3_BMP_MINALIGN)));
+	spinlock_t bmp_lock;
 	u64 ppe_id;
 	u64 thread_id;
+	unsigned long ipi_debug_brk_mask;
 	unsigned long ipi_mask;
 };
 
@@ -105,7 +108,7 @@ static void ps3_chip_mask(struct irq_data *d)
 	struct ps3_private *pd = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
-	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
+	DBG("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
 		pd->thread_id, d->irq);
 
 	local_irq_save(flags);
@@ -126,7 +129,7 @@ static void ps3_chip_unmask(struct irq_data *d)
 	struct ps3_private *pd = irq_data_get_irq_chip_data(d);
 	unsigned long flags;
 
-	pr_debug("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
+	DBG("%s:%d: thread_id %llu, virq %d\n", __func__, __LINE__,
 		pd->thread_id, d->irq);
 
 	local_irq_save(flags);
@@ -190,19 +193,19 @@ static int ps3_virq_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 	*virq = irq_create_mapping(NULL, outlet);
 
 	if (*virq == NO_IRQ) {
-		pr_debug("%s:%d: irq_create_mapping failed: outlet %lu\n",
+		FAIL("%s:%d: irq_create_mapping failed: outlet %lu\n",
 			__func__, __LINE__, outlet);
 		result = -ENOMEM;
 		goto fail_create;
 	}
 
-	pr_debug("%s:%d: outlet %lu => cpu %u, virq %u\n", __func__, __LINE__,
+	DBG("%s:%d: outlet %lu => cpu %u, virq %u\n", __func__, __LINE__,
 		outlet, cpu, *virq);
 
 	result = irq_set_chip_data(*virq, pd);
 
 	if (result) {
-		pr_debug("%s:%d: irq_set_chip_data failed\n",
+		FAIL("%s:%d: irq_set_chip_data failed\n",
 			__func__, __LINE__);
 		goto fail_set;
 	}
@@ -228,13 +231,13 @@ static int ps3_virq_destroy(unsigned int virq)
 {
 	const struct ps3_private *pd = irq_get_chip_data(virq);
 
-	pr_debug("%s:%d: ppe_id %llu, thread_id %llu, virq %u\n", __func__,
+	DBG("%s:%d: ppe_id %llu, thread_id %llu, virq %u\n", __func__,
 		__LINE__, pd->ppe_id, pd->thread_id, virq);
 
 	irq_set_chip_data(virq, NULL);
 	irq_dispose_mapping(virq);
 
-	pr_debug("%s:%d <-\n", __func__, __LINE__);
+	DBG("%s:%d <-\n", __func__, __LINE__);
 	return 0;
 }
 
@@ -257,7 +260,7 @@ int ps3_irq_plug_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 	result = ps3_virq_setup(cpu, outlet, virq);
 
 	if (result) {
-		pr_debug("%s:%d: ps3_virq_setup failed\n", __func__, __LINE__);
+		FAIL("%s:%d: ps3_virq_setup failed\n", __func__, __LINE__);
 		goto fail_setup;
 	}
 
@@ -269,7 +272,7 @@ int ps3_irq_plug_setup(enum ps3_cpu_binding cpu, unsigned long outlet,
 		outlet, 0);
 
 	if (result) {
-		pr_info("%s:%d: lv1_connect_irq_plug_ext failed: %s\n",
+		FAIL("%s:%d: lv1_connect_irq_plug_ext failed: %s\n",
 		__func__, __LINE__, ps3_result(result));
 		result = -EPERM;
 		goto fail_connect;
@@ -298,7 +301,7 @@ int ps3_irq_plug_destroy(unsigned int virq)
 	int result;
 	const struct ps3_private *pd = irq_get_chip_data(virq);
 
-	pr_debug("%s:%d: ppe_id %llu, thread_id %llu, virq %u\n", __func__,
+	DBG("%s:%d: ppe_id %llu, thread_id %llu, virq %u\n", __func__,
 		__LINE__, pd->ppe_id, pd->thread_id, virq);
 
 	ps3_chip_mask(irq_get_irq_data(virq));
@@ -306,7 +309,7 @@ int ps3_irq_plug_destroy(unsigned int virq)
 	result = lv1_disconnect_irq_plug_ext(pd->ppe_id, pd->thread_id, virq);
 
 	if (result)
-		pr_info("%s:%d: lv1_disconnect_irq_plug_ext failed: %s\n",
+		FAIL("%s:%d: lv1_disconnect_irq_plug_ext failed: %s\n",
 		__func__, __LINE__, ps3_result(result));
 
 	ps3_virq_destroy(virq);
@@ -334,7 +337,7 @@ int ps3_event_receive_port_setup(enum ps3_cpu_binding cpu, unsigned int *virq)
 	result = lv1_construct_event_receive_port(&outlet);
 
 	if (result) {
-		pr_debug("%s:%d: lv1_construct_event_receive_port failed: %s\n",
+		FAIL("%s:%d: lv1_construct_event_receive_port failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 		*virq = NO_IRQ;
 		return result;
@@ -360,14 +363,14 @@ int ps3_event_receive_port_destroy(unsigned int virq)
 {
 	int result;
 
-	pr_debug(" -> %s:%d virq %u\n", __func__, __LINE__, virq);
+	DBG(" -> %s:%d virq %u\n", __func__, __LINE__, virq);
 
 	ps3_chip_mask(irq_get_irq_data(virq));
 
 	result = lv1_destruct_event_receive_port(virq_to_hw(virq));
 
 	if (result)
-		pr_debug("%s:%d: lv1_destruct_event_receive_port failed: %s\n",
+		FAIL("%s:%d: lv1_destruct_event_receive_port failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
 	/*
@@ -375,7 +378,7 @@ int ps3_event_receive_port_destroy(unsigned int virq)
 	 * calls from interrupt context (smp_call_function) when kexecing.
 	 */
 
-	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	DBG(" <- %s:%d\n", __func__, __LINE__);
 	return result;
 }
 
@@ -411,7 +414,7 @@ int ps3_sb_event_receive_port_setup(struct ps3_system_bus_device *dev,
 		dev->dev_id, virq_to_hw(*virq), dev->interrupt_id);
 
 	if (result) {
-		pr_debug("%s:%d: lv1_connect_interrupt_event_receive_port"
+		FAIL("%s:%d: lv1_connect_interrupt_event_receive_port"
 			" failed: %s\n", __func__, __LINE__,
 			ps3_result(result));
 		ps3_event_receive_port_destroy(*virq);
@@ -419,7 +422,7 @@ int ps3_sb_event_receive_port_setup(struct ps3_system_bus_device *dev,
 		return result;
 	}
 
-	pr_debug("%s:%d: interrupt_id %u, virq %u\n", __func__, __LINE__,
+	DBG("%s:%d: interrupt_id %u, virq %u\n", __func__, __LINE__,
 		dev->interrupt_id, *virq);
 
 	return 0;
@@ -433,14 +436,14 @@ int ps3_sb_event_receive_port_destroy(struct ps3_system_bus_device *dev,
 
 	int result;
 
-	pr_debug(" -> %s:%d: interrupt_id %u, virq %u\n", __func__, __LINE__,
+	DBG(" -> %s:%d: interrupt_id %u, virq %u\n", __func__, __LINE__,
 		dev->interrupt_id, virq);
 
 	result = lv1_disconnect_interrupt_event_receive_port(dev->bus_id,
 		dev->dev_id, virq_to_hw(virq), dev->interrupt_id);
 
 	if (result)
-		pr_debug("%s:%d: lv1_disconnect_interrupt_event_receive_port"
+		FAIL("%s:%d: lv1_disconnect_interrupt_event_receive_port"
 			" failed: %s\n", __func__, __LINE__,
 			ps3_result(result));
 
@@ -455,7 +458,7 @@ int ps3_sb_event_receive_port_destroy(struct ps3_system_bus_device *dev,
 	result = ps3_virq_destroy(virq);
 	BUG_ON(result);
 
-	pr_debug(" <- %s:%d\n", __func__, __LINE__);
+	DBG(" <- %s:%d\n", __func__, __LINE__);
 	return result;
 }
 EXPORT_SYMBOL(ps3_sb_event_receive_port_destroy);
@@ -480,7 +483,7 @@ int ps3_io_irq_setup(enum ps3_cpu_binding cpu, unsigned int interrupt_id,
 	result = lv1_construct_io_irq_outlet(interrupt_id, &outlet);
 
 	if (result) {
-		pr_debug("%s:%d: lv1_construct_io_irq_outlet failed: %s\n",
+		FAIL("%s:%d: lv1_construct_io_irq_outlet failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 		return result;
 	}
@@ -510,7 +513,7 @@ int ps3_io_irq_destroy(unsigned int virq)
 	result = lv1_destruct_io_irq_outlet(outlet);
 
 	if (result)
-		pr_debug("%s:%d: lv1_destruct_io_irq_outlet failed: %s\n",
+		FAIL("%s:%d: lv1_destruct_io_irq_outlet failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
 	return result;
@@ -542,7 +545,7 @@ int ps3_vuart_irq_setup(enum ps3_cpu_binding cpu, void* virt_addr_bmp,
 	result = lv1_configure_virtual_uart_irq(lpar_addr, &outlet);
 
 	if (result) {
-		pr_debug("%s:%d: lv1_configure_virtual_uart_irq failed: %s\n",
+		FAIL("%s:%d: lv1_configure_virtual_uart_irq failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 		return result;
 	}
@@ -562,7 +565,7 @@ int ps3_vuart_irq_destroy(unsigned int virq)
 	result = lv1_deconfigure_virtual_uart_irq();
 
 	if (result) {
-		pr_debug("%s:%d: lv1_configure_virtual_uart_irq failed: %s\n",
+		FAIL("%s:%d: lv1_configure_virtual_uart_irq failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 		return result;
 	}
@@ -595,7 +598,7 @@ int ps3_spe_irq_setup(enum ps3_cpu_binding cpu, unsigned long spe_id,
 	result = lv1_get_spe_irq_outlet(spe_id, class, &outlet);
 
 	if (result) {
-		pr_debug("%s:%d: lv1_get_spe_irq_outlet failed: %s\n",
+		FAIL("%s:%d: lv1_get_spe_irq_outlet failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 		return result;
 	}
@@ -626,7 +629,7 @@ int ps3_spe_irq_destroy(unsigned int virq)
 static void _dump_64_bmp(const char *header, const u64 *p, unsigned cpu,
 	const char* func, int line)
 {
-	pr_debug("%s:%d: %s %u {%04lx_%04lx_%04lx_%04lx}\n",
+	pr_debug("%s:%d: %s %u {%04llx_%04llx_%04llx_%04llx}\n",
 		func, line, header, cpu,
 		*p >> 48, (*p >> 32) & 0xffff, (*p >> 16) & 0xffff,
 		*p & 0xffff);
@@ -635,7 +638,7 @@ static void _dump_64_bmp(const char *header, const u64 *p, unsigned cpu,
 static void __maybe_unused _dump_256_bmp(const char *header,
 	const u64 *p, unsigned cpu, const char* func, int line)
 {
-	pr_debug("%s:%d: %s %u {%016lx:%016lx:%016lx:%016lx}\n",
+	pr_debug("%s:%d: %s %u {%016llx:%016llx:%016llx:%016llx}\n",
 		func, line, header, cpu, p[0], p[1], p[2], p[3]);
 }
 
@@ -644,10 +647,10 @@ static void _dump_bmp(struct ps3_private* pd, const char* func, int line)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&pd->bmp.lock, flags);
+	spin_lock_irqsave(&pd->bmp_lock, flags);
 	_dump_64_bmp("stat", &pd->bmp.status, pd->thread_id, func, line);
-	_dump_64_bmp("mask", &pd->bmp.mask, pd->thread_id, func, line);
-	spin_unlock_irqrestore(&pd->bmp.lock, flags);
+	_dump_64_bmp("mask", (u64*)&pd->bmp.mask, pd->thread_id, func, line);
+	spin_unlock_irqrestore(&pd->bmp_lock, flags);
 }
 
 #define dump_mask(_x) _dump_mask(_x, __func__, __LINE__)
@@ -656,9 +659,9 @@ static void __maybe_unused _dump_mask(struct ps3_private *pd,
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&pd->bmp.lock, flags);
-	_dump_64_bmp("mask", &pd->bmp.mask, pd->thread_id, func, line);
-	spin_unlock_irqrestore(&pd->bmp.lock, flags);
+	spin_lock_irqsave(&pd->bmp_lock, flags);
+	_dump_64_bmp("mask", (u64*)&pd->bmp.mask, pd->thread_id, func, line);
+	spin_unlock_irqrestore(&pd->bmp_lock, flags);
 }
 #else
 static void dump_bmp(struct ps3_private* pd) {};
@@ -667,7 +670,7 @@ static void dump_bmp(struct ps3_private* pd) {};
 static int ps3_host_map(struct irq_host *h, unsigned int virq,
 	irq_hw_number_t hwirq)
 {
-	pr_debug("%s:%d: hwirq %lu, virq %u\n", __func__, __LINE__, hwirq,
+	DBG("%s:%d: hwirq %lu, virq %u\n", __func__, __LINE__, hwirq,
 		virq);
 
 	irq_set_chip_and_handler(virq, &ps3_irq_chip, handle_fasteoi_irq);
@@ -690,10 +693,10 @@ void __init ps3_register_ipi_debug_brk(unsigned int cpu, unsigned int virq)
 {
 	struct ps3_private *pd = &per_cpu(ps3_private, cpu);
 
-	pd->bmp.ipi_debug_brk_mask = 0x8000000000000000UL >> virq;
+	set_bit(63 - virq, &pd->ipi_debug_brk_mask);
 
-	pr_debug("%s:%d: cpu %u, virq %u, mask %llxh\n", __func__, __LINE__,
-		cpu, virq, pd->bmp.ipi_debug_brk_mask);
+	DBG("%s:%d: cpu %u, virq %u, mask %lxh\n", __func__, __LINE__,
+		cpu, virq, pd->ipi_debug_brk_mask);
 }
 
 void __init ps3_register_ipi_irq(unsigned int cpu, unsigned int virq)
@@ -714,14 +717,14 @@ static unsigned int ps3_get_irq(void)
 
 	/* check for ipi break first to stop this cpu ASAP */
 
-	if (x & pd->bmp.ipi_debug_brk_mask)
-		x &= pd->bmp.ipi_debug_brk_mask;
+	if (x & pd->ipi_debug_brk_mask)
+		x &= pd->ipi_debug_brk_mask;
 
 	asm volatile("cntlzd %0,%1" : "=r" (plug) : "r" (x));
 	plug &= 0x3f;
 
 	if (unlikely(plug == NO_IRQ)) {
-		pr_debug("%s:%d: no plug found: thread_id %llu\n", __func__,
+		DBG("%s:%d: no plug found: thread_id %llu\n", __func__,
 			__LINE__, pd->thread_id);
 		dump_bmp(&per_cpu(ps3_private, 0));
 		dump_bmp(&per_cpu(ps3_private, 1));
@@ -760,9 +763,9 @@ void __init ps3_init_IRQ(void)
 
 		lv1_get_logical_ppe_id(&pd->ppe_id);
 		pd->thread_id = get_hard_smp_processor_id(cpu);
-		spin_lock_init(&pd->bmp.lock);
+		spin_lock_init(&pd->bmp_lock);
 
-		pr_debug("%s:%d: ppe_id %llu, thread_id %llu, bmp %lxh\n",
+		DBG("%s:%d: ppe_id %llu, thread_id %llu, bmp %lxh\n",
 			__func__, __LINE__, pd->ppe_id, pd->thread_id,
 			ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
 
@@ -770,7 +773,7 @@ void __init ps3_init_IRQ(void)
 			pd->thread_id, ps3_mm_phys_to_lpar(__pa(&pd->bmp)));
 
 		if (result)
-			pr_debug("%s:%d: lv1_configure_irq_state_bitmap failed:"
+			FAIL("%s:%d: lv1_configure_irq_state_bitmap failed:"
 				" %s\n", __func__, __LINE__,
 				ps3_result(result));
 	}
-- 
1.7.0.4
