Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EC271DE15A
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 13:40:17 +1100 (EST)
Message-ID: <45B8188A.5070900@am.sony.com>
Date: Wed, 24 Jan 2007 18:40:10 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 8/14] ps3: bind interrupt to cpu
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the PS3 irq allocation routines to take an argument indicating which
cpu (processor thread) the interrupt should be serviced on.

The current system configuration favors device interrups that are serviced
on cpu0, so that is used as the default.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 arch/powerpc/platforms/ps3/interrupt.c |  278 +++++++++++++++++++--------------
 arch/powerpc/platforms/ps3/smp.c       |    2 
 arch/powerpc/platforms/ps3/spu.c       |   12 -
 drivers/ps3/vuart.c                    |    4 
 include/asm-powerpc/ps3.h              |   23 +-
 5 files changed, 190 insertions(+), 129 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/interrupt.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/interrupt.c
@@ -36,15 +36,141 @@
 #endif
 
 /**
+ * struct ps3_bmp - a per cpu irq status and mask bitmap structure
+ * @status: 256 bit status bitmap indexed by plug
+ * @unused_1:
+ * @mask: 256 bit mask bitmap indexed by plug
+ * @unused_2:
+ * @lock:
+ * @ipi_debug_brk_mask:
+ *
+ * The HV mantains per SMT thread mappings of HV outlet to HV plug on
+ * behalf of the guest.  These mappings are implemented as 256 bit guest
+ * supplied bitmaps indexed by plug number.  The address of the bitmaps are
+ * registered with the HV through lv1_configure_irq_state_bitmap().
+ *
+ * The HV supports 256 plugs per thread, assigned as {0..255}, for a total
+ * of 512 plugs supported on a processor.  To simplify the logic this
+ * implementation equates HV plug value to linux virq value, constrains each
+ * interrupt to have a system wide unique plug number, and limits the range
+ * of the plug values to map into the first dword of the bitmaps.  This
+ * gives a usable range of plug values of  {NUM_ISA_INTERRUPTS..63}.  Note
+ * that there is no constraint on how many in this set an individual thread
+ * can aquire.
+ */
+
+struct ps3_bmp {
+	struct {
+		unsigned long status;
+		unsigned long unused_1[3];
+		unsigned long mask;
+		unsigned long unused_2[3];
+	} __attribute__ ((aligned (64)));
+
+	spinlock_t lock;
+	unsigned long ipi_debug_brk_mask;
+};
+
+/**
+ * struct ps3_private - a per cpu data structure
+ * @bmp: ps3_bmp structure
+ * @node: HV logical_ppe_id
+ * @cpu: HV thread_id
+ */
+
+struct ps3_private {
+	struct ps3_bmp bmp;
+	unsigned long node;
+	unsigned int cpu;
+};
+
+static DEFINE_PER_CPU(struct ps3_private, ps3_private);
+
+static int ps3_connect_irq(enum ps3_cpu_binding cpu, unsigned long outlet,
+	unsigned int *virq)
+{
+	int result;
+	struct ps3_private *pd;
+
+	/* This defines the default interrupt distribution policy. */
+
+	if(cpu == PS3_BINDING_CPU_ANY)
+		cpu = 0;
+
+	pd = &per_cpu(ps3_private, cpu);
+
+	*virq = irq_create_mapping(NULL, outlet);
+
+	if(*virq == NO_IRQ) {
+		pr_debug("%s:%d: irq_create_mapping failed: outlet %lu\n",
+			__func__, __LINE__, outlet);
+		result = -ENOMEM;
+		goto fail_create;
+	}
+
+	/* Binds outlet to cpu + virq. */
+
+	result = lv1_connect_irq_plug_ext(pd->node, pd->cpu, *virq, outlet, 0);
+
+	if (result) {
+		pr_info("%s:%d: lv1_connect_irq_plug_ext failed: %s\n",
+		__func__, __LINE__, ps3_result(result));
+		result = -EPERM;
+		goto fail_connect;
+	}
+
+	pr_debug("%s:%d: outlet %lu => cpu %u, virq %u\n", __func__, __LINE__,
+		outlet, cpu, *virq);
+
+	result = set_irq_chip_data(*virq, pd);
+
+	if (result) {
+		pr_debug("%s:%d: set_irq_chip_data failed\n",
+			__func__, __LINE__);
+		goto fail_set;
+	}
+
+	return result;
+
+fail_set:
+	lv1_disconnect_irq_plug_ext(pd->node, pd->cpu, *virq);
+fail_connect:
+	irq_dispose_mapping(*virq);
+fail_create:
+	return result;
+}
+
+static void ps3_disconnect_irq(unsigned int virq)
+{
+	int result;
+	const struct ps3_private *pd = get_irq_chip_data(virq);
+
+	pr_debug("%s:%d: node %lu, cpu %d, virq %u\n", __func__, __LINE__,
+		pd->node, pd->cpu, virq);
+
+	result = lv1_disconnect_irq_plug_ext(pd->node, pd->cpu, virq);
+
+	if (result)
+		pr_info("%s:%d: lv1_disconnect_irq_plug_ext failed: %s\n",
+		__func__, __LINE__, ps3_result(result));
+
+	set_irq_chip_data(virq, NULL);
+	irq_dispose_mapping(virq);
+}
+
+/**
  * ps3_alloc_io_irq - Assign a virq to a system bus device.
- * interrupt_id: The device interrupt id read from the system repository.
+ * @cpu: enum ps3_cpu_binding indicating the cpu the interrupt should be
+ * serviced on.
+ * @interrupt_id: The device interrupt id read from the system repository.
  * @virq: The assigned Linux virq.
  *
  * An io irq represents a non-virtualized device interrupt.  interrupt_id
  * coresponds to the interrupt number of the interrupt controller.
  */
 
-int ps3_alloc_io_irq(unsigned int interrupt_id, unsigned int *virq)
+int ps3_alloc_io_irq(enum ps3_cpu_binding cpu, unsigned int interrupt_id,
+	unsigned int *virq)
 {
 	int result;
 	unsigned long outlet;
@@ -57,12 +183,10 @@ int ps3_alloc_io_irq(unsigned int interr
 		return result;
 	}
 
-	*virq = irq_create_mapping(NULL, outlet);
-
-	pr_debug("%s:%d: interrupt_id %u => outlet %lu, virq %u\n",
-		__func__, __LINE__, interrupt_id, outlet, *virq);
+	result = ps3_connect_irq(cpu, outlet, virq);
+	BUG_ON(result);
 
-	return 0;
+	return result;
 }
 
 int ps3_free_io_irq(unsigned int virq)
@@ -75,13 +199,15 @@ int ps3_free_io_irq(unsigned int virq)
 		pr_debug("%s:%d: lv1_destruct_io_irq_outlet failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
-	irq_dispose_mapping(virq);
+	ps3_disconnect_irq(virq);
 
 	return result;
 }
 
 /**
  * ps3_alloc_event_irq - Allocate a virq for use with a system event.
+ * @cpu: enum ps3_cpu_binding indicating the cpu the interrupt should be
+ * serviced on.
  * @virq: The assigned Linux virq.
  *
  * The virq can be used with lv1_connect_interrupt_event_receive_port() to
@@ -89,7 +215,7 @@ int ps3_free_io_irq(unsigned int virq)
  * events.
  */
 
-int ps3_alloc_event_irq(unsigned int *virq)
+int ps3_alloc_event_irq(enum ps3_cpu_binding cpu, unsigned int *virq)
 {
 	int result;
 	unsigned long outlet;
@@ -103,12 +229,10 @@ int ps3_alloc_event_irq(unsigned int *vi
 		return result;
 	}
 
-	*virq = irq_create_mapping(NULL, outlet);
-
-	pr_debug("%s:%d: outlet %lu, virq %u\n", __func__, __LINE__, outlet,
-		*virq);
+	result = ps3_connect_irq(cpu, outlet, virq);
+	BUG_ON(result);
 
-	return 0;
+	return result;
 }
 
 int ps3_free_event_irq(unsigned int virq)
@@ -123,7 +247,7 @@ int ps3_free_event_irq(unsigned int virq
 		pr_debug("%s:%d: lv1_destruct_event_receive_port failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
-	irq_dispose_mapping(virq);
+	ps3_disconnect_irq(virq);
 
 	pr_debug(" <- %s:%d\n", __func__, __LINE__);
 	return result;
@@ -136,6 +260,8 @@ int ps3_send_event_locally(unsigned int 
 
 /**
  * ps3_connect_event_irq - Assign a virq to a system bus device.
+ * @cpu: enum ps3_cpu_binding indicating the cpu the interrupt should be
+ * serviced on.
  * @did: The HV device identifier read from the system repository.
  * @interrupt_id: The device interrupt id read from the system repository.
  * @virq: The assigned Linux virq.
@@ -144,12 +270,13 @@ int ps3_send_event_locally(unsigned int 
  * coresponds to the software interrupt number.
  */
 
-int ps3_connect_event_irq(const struct ps3_device_id *did,
-	unsigned int interrupt_id, unsigned int *virq)
+int ps3_connect_event_irq(enum ps3_cpu_binding cpu,
+	const struct ps3_device_id *did, unsigned int interrupt_id,
+	unsigned int *virq)
 {
 	int result;
 
-	result = ps3_alloc_event_irq(virq);
+	result = ps3_alloc_event_irq(cpu, virq);
 
 	if (result)
 		return result;
@@ -196,6 +323,8 @@ int ps3_disconnect_event_irq(const struc
 
 /**
  * ps3_alloc_vuart_irq - Configure the system virtual uart virq.
+ * @cpu: enum ps3_cpu_binding indicating the cpu the interrupt should be
+ * serviced on.
  * @virt_addr_bmp: The caller supplied virtual uart interrupt bitmap.
  * @virq: The assigned Linux virq.
  *
@@ -203,7 +332,8 @@ int ps3_disconnect_event_irq(const struc
  * freeing the interrupt will return a wrong state error.
  */
 
-int ps3_alloc_vuart_irq(void* virt_addr_bmp, unsigned int *virq)
+int ps3_alloc_vuart_irq(enum ps3_cpu_binding cpu, void* virt_addr_bmp,
+	unsigned int *virq)
 {
 	int result;
 	unsigned long outlet;
@@ -221,12 +351,10 @@ int ps3_alloc_vuart_irq(void* virt_addr_
 		return result;
 	}
 
-	*virq = irq_create_mapping(NULL, outlet);
-
-	pr_debug("%s:%d: outlet %lu, virq %u\n", __func__, __LINE__,
-		outlet, *virq);
+	result = ps3_connect_irq(cpu, outlet, virq);
+	BUG_ON(result);
 
-	return 0;
+	return result;
 }
 
 int ps3_free_vuart_irq(unsigned int virq)
@@ -241,21 +369,23 @@ int ps3_free_vuart_irq(unsigned int virq
 		return result;
 	}
 
-	irq_dispose_mapping(virq);
+	ps3_disconnect_irq(virq);
 
 	return result;
 }
 
 /**
  * ps3_alloc_spe_irq - Configure an spe virq.
+ * @cpu: enum ps3_cpu_binding indicating the cpu the interrupt should be
+ * serviced on.
  * @spe_id: The spe_id returned from lv1_construct_logical_spe().
  * @class: The spe interrupt class {0,1,2}.
  * @virq: The assigned Linux virq.
  *
  */
 
-int ps3_alloc_spe_irq(unsigned long spe_id, unsigned int class,
-	unsigned int *virq)
+int ps3_alloc_spe_irq(enum ps3_cpu_binding cpu, unsigned long spe_id,
+	unsigned int class, unsigned int *virq)
 {
 	int result;
 	unsigned long outlet;
@@ -270,72 +400,21 @@ int ps3_alloc_spe_irq(unsigned long spe_
 		return result;
 	}
 
-	*virq = irq_create_mapping(NULL, outlet);
-
-	pr_debug("%s:%d: spe_id %lu, class %u, outlet %lu, virq %u\n",
-		__func__, __LINE__, spe_id, class, outlet, *virq);
+	result = ps3_connect_irq(cpu, outlet, virq);
+	BUG_ON(result);
 
-	return 0;
+	return result;
 }
 
 int ps3_free_spe_irq(unsigned int virq)
 {
-	irq_dispose_mapping(virq);
+	ps3_disconnect_irq(virq);
 	return 0;
 }
 
 #define PS3_INVALID_OUTLET ((irq_hw_number_t)-1)
 #define PS3_PLUG_MAX 63
 
-/**
- * struct ps3_bmp - a per cpu irq status and mask bitmap structure
- * @status: 256 bit status bitmap indexed by plug
- * @unused_1:
- * @mask: 256 bit mask bitmap indexed by plug
- * @unused_2:
- * @lock:
- * @ipi_debug_brk_mask:
- *
- * The HV mantains per SMT thread mappings of HV outlet to HV plug on
- * behalf of the guest.  These mappings are implemented as 256 bit guest
- * supplied bitmaps indexed by plug number.  The address of the bitmaps are
- * registered with the HV through lv1_configure_irq_state_bitmap().
- *
- * The HV supports 256 plugs per thread, assigned as {0..255}, for a total
- * of 512 plugs supported on a processor.  To simplify the logic this
- * implementation equates HV plug value to linux virq value, constrains each
- * interrupt to have a system wide unique plug number, and limits the range
- * of the plug values to map into the first dword of the bitmaps.  This
- * gives a usable range of plug values of  {NUM_ISA_INTERRUPTS..63}.  Note
- * that there is no constraint on how many in this set an individual thread
- * can aquire.
- */
-
-struct ps3_bmp {
-	struct {
-		unsigned long status;
-		unsigned long unused_1[3];
-		unsigned long mask;
-		unsigned long unused_2[3];
-	} __attribute__ ((aligned (64)));
-
-	spinlock_t lock;
-	unsigned long ipi_debug_brk_mask;
-};
-
-/**
- * struct ps3_private - a per cpu data structure
- * @bmp: ps3_bmp structure
- * @node: HV logical_ppe_id
- * @cpu: HV thread_id
- */
-
-struct ps3_private {
-	struct ps3_bmp bmp;
-	unsigned long node;
-	unsigned int cpu;
-};
-
 #if defined(DEBUG)
 static void _dump_64_bmp(const char *header, const unsigned long *p, unsigned cpu,
 	const char* func, int line)
@@ -441,45 +520,18 @@ static struct irq_chip irq_chip = {
 
 static void ps3_host_unmap(struct irq_host *h, unsigned int virq)
 {
-	int result;
-	const struct ps3_private *pd = get_irq_chip_data(virq);
-
-	pr_debug("%s:%d: node %lu, cpu %d, virq %u\n", __func__, __LINE__,
-		pd->node, pd->cpu, virq);
-
-	lv1_disconnect_irq_plug_ext(pd->node, pd->cpu, virq);
-
-	result = set_irq_chip_data(virq, NULL);
-	BUG_ON(result);
+	set_irq_chip_data(virq, NULL);
 }
 
-static DEFINE_PER_CPU(struct ps3_private, ps3_private);
-
 static int ps3_host_map(struct irq_host *h, unsigned int virq,
 	irq_hw_number_t hwirq)
 {
-	int result;
-	struct ps3_private *pd = &__get_cpu_var(ps3_private);
-
-	pr_debug("%s:%d: node %lu, cpu %d, hwirq %lu => virq %u\n", __func__,
-		__LINE__, pd->node, pd->cpu, hwirq, virq);
-
-	/* Binds this virq to pd->cpu (current cpu) */
-
-	result = lv1_connect_irq_plug_ext(pd->node, pd->cpu, virq, hwirq, 0);
-
-	if (result) {
-		pr_info("%s:%d: lv1_connect_irq_plug_ext failed:"
-			" %s\n", __func__, __LINE__, ps3_result(result));
-		return -EPERM;
-	}
-
-	result = set_irq_chip_data(virq, pd);
-	BUG_ON(result);
+	pr_debug("%s:%d: hwirq %lu, virq %u\n", __func__, __LINE__, hwirq,
+		virq);
 
 	set_irq_chip_and_handler(virq, &irq_chip, handle_fasteoi_irq);
 
-	return result;
+	return 0;
 }
 
 static struct irq_host_ops ps3_host_ops = {
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/smp.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/smp.c
@@ -111,7 +111,7 @@ static void __init ps3_smp_setup_cpu(int
 	BUILD_BUG_ON(PPC_MSG_DEBUGGER_BREAK != 3);
 
 	for (i = 0; i < MSG_COUNT; i++) {
-		result = ps3_alloc_event_irq(&virqs[i]);
+		result = ps3_alloc_event_irq(cpu, &virqs[i]);
 
 		if (result)
 			continue;
--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/spu.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/spu.c
@@ -267,20 +267,20 @@ static int __init setup_interrupts(struc
 {
 	int result;
 
-	result = ps3_alloc_spe_irq(spu_pdata(spu)->spe_id, 0,
-		&spu->irqs[0]);
+	result = ps3_alloc_spe_irq(PS3_BINDING_CPU_ANY, spu_pdata(spu)->spe_id,
+		0, &spu->irqs[0]);
 
 	if (result)
 		goto fail_alloc_0;
 
-	result = ps3_alloc_spe_irq(spu_pdata(spu)->spe_id, 1,
-		&spu->irqs[1]);
+	result = ps3_alloc_spe_irq(PS3_BINDING_CPU_ANY, spu_pdata(spu)->spe_id,
+		1, &spu->irqs[1]);
 
 	if (result)
 		goto fail_alloc_1;
 
-	result = ps3_alloc_spe_irq(spu_pdata(spu)->spe_id, 2,
-		&spu->irqs[2]);
+	result = ps3_alloc_spe_irq(PS3_BINDING_CPU_ANY, spu_pdata(spu)->spe_id,
+		2, &spu->irqs[2]);
 
 	if (result)
 		goto fail_alloc_2;
--- ps3-linux-dev.orig/drivers/ps3/vuart.c
+++ ps3-linux-dev/drivers/ps3/vuart.c
@@ -783,8 +783,8 @@ static int ps3_vuart_probe(struct device
 
 	vuart_private.in_use++;
 	if (vuart_private.in_use == 1) {
-		result = ps3_alloc_vuart_irq((void*)&vuart_private.bmp.status,
-			&vuart_private.virq);
+		result = ps3_alloc_vuart_irq(PS3_BINDING_CPU_ANY,
+			(void*)&vuart_private.bmp.status, &vuart_private.virq);
 
 		if (result) {
 			dev_dbg(&dev->core,
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -140,19 +140,28 @@ unsigned long ps3_mm_phys_to_lpar(unsign
 
 /* inrerrupt routines */
 
-int ps3_alloc_io_irq(unsigned int interrupt_id, unsigned int *virq);
+enum ps3_cpu_binding {
+	PS3_BINDING_CPU_0 = 0,
+	PS3_BINDING_CPU_1 = 1,
+	PS3_BINDING_CPU_ANY = 3,
+};
+
+int ps3_alloc_io_irq(enum ps3_cpu_binding cpu, unsigned int interrupt_id,
+	unsigned int *virq);
 int ps3_free_io_irq(unsigned int virq);
-int ps3_alloc_event_irq(unsigned int *virq);
+int ps3_alloc_event_irq(enum ps3_cpu_binding cpu, unsigned int *virq);
 int ps3_free_event_irq(unsigned int virq);
 int ps3_send_event_locally(unsigned int virq);
-int ps3_connect_event_irq(const struct ps3_device_id *did,
-	unsigned int interrupt_id, unsigned int *virq);
+int ps3_connect_event_irq(enum ps3_cpu_binding cpu,
+	const struct ps3_device_id *did, unsigned int interrupt_id,
+	unsigned int *virq);
 int ps3_disconnect_event_irq(const struct ps3_device_id *did,
 	unsigned int interrupt_id, unsigned int virq);
-int ps3_alloc_vuart_irq(void* virt_addr_bmp, unsigned int *virq);
-int ps3_free_vuart_irq(unsigned int virq);
-int ps3_alloc_spe_irq(unsigned long spe_id, unsigned int class,
+int ps3_alloc_vuart_irq(enum ps3_cpu_binding cpu, void* virt_addr_bmp,
 	unsigned int *virq);
+int ps3_free_vuart_irq(unsigned int virq);
+int ps3_alloc_spe_irq(enum ps3_cpu_binding cpu, unsigned long spe_id,
+	unsigned int class, unsigned int *virq);
 int ps3_free_spe_irq(unsigned int virq);
 
 /* lv1 result codes */
