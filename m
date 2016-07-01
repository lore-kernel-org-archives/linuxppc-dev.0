Return-Path: <oohall@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgmWb4l2KzDqlN
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 16:21:15 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id us13so8986796pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 23:21:15 -0700 (PDT)
From: Oliver O'Halloran <oohall@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mikey@neuling.org, Oliver O'Halloran <oohall@gmail.com>,
 Balbir Singh <bsingharora@gmail.com>, Jack Miller <jack@codezen.org>
Subject: [PATCH v6] powerpc/timer - large decrementer support
Date: Fri,  1 Jul 2016 16:20:39 +1000
Message-Id: <1467354039-16832-1-git-send-email-oohall@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power ISAv3 adds a large decrementer (LD) mode which increases the size
of the decrementer register. The size of the enlarged decrementer
register is between 32 and 64 bits with the exact size being dependent
on the implementation. When in LD mode, reads are sign extended to 64
bits and a decrementer exception is raised when the high bit is set (i.e
the value goes below zero). Writes however are truncated to the physical
register width so some care needs to be taken to ensure that the high
bit is not set when reloading the decrementer. This patch adds support
for using the LD inside the host kernel on processors that support it.

When LD mode is supported firmware will supply the ibm,dec-bits property
for CPU nodes to allow the kernel to determine the maximum decrementer
value. Enabling LD mode is a hypervisor privileged operation so the kernel
can only enable it manually when running in hypervisor mode. Guests that
support LD mode can request it using the "ibm,client-architecture-support"
firmware call (not implemented in this patch) or some other platform
specific method. If this property is not supplied then the traditional
decrementer width of 32 bit is assumed and LD mode will not be enabled.

This patch was based on initial work by Jack Miller.

Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Acked-by: Michael Neuling <mikey@neuling.org>
Cc: Jack Miller <jack@codezen.org>
---

Changes from v5:
	Removed readback test after enabling LD mode since mikey thought it
	was dumb.

	Replaced use of of_get_property() and of_read_number() with
	of_property_read_u32()

---
 arch/powerpc/include/asm/reg.h  |  1 +
 arch/powerpc/include/asm/time.h |  6 ++--
 arch/powerpc/kernel/time.c      | 67 ++++++++++++++++++++++++++++++++++++-----
 3 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index a0948f40bc7b..12d970d64bb3 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -332,6 +332,7 @@
 #define   LPCR_AIL_0	0x00000000	/* MMU off exception offset 0x0 */
 #define   LPCR_AIL_3	0x01800000	/* MMU on exception offset 0xc00...4xxx */
 #define   LPCR_ONL	0x00040000	/* online - PURR/SPURR count */
+#define   LPCR_LD	0x00020000	/* large decremeter */
 #define   LPCR_PECE	0x0001f000	/* powersave exit cause enable */
 #define     LPCR_PECEDP	0x00010000	/* directed priv dbells cause exit */
 #define     LPCR_PECEDH	0x00008000	/* directed hyp dbells cause exit */
diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 1092fdd7e737..09211640a0e0 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -146,7 +146,7 @@ static inline void set_tb(unsigned int upper, unsigned int lower)
  * in auto-reload mode.  The problem is PIT stops counting when it
  * hits zero.  If it would wrap, we could use it just like a decrementer.
  */
-static inline unsigned int get_dec(void)
+static inline u64 get_dec(void)
 {
 #if defined(CONFIG_40x)
 	return (mfspr(SPRN_PIT));
@@ -160,10 +160,10 @@ static inline unsigned int get_dec(void)
  * in when the decrementer generates its interrupt: on the 1 to 0
  * transition for Book E/4xx, but on the 0 to -1 transition for others.
  */
-static inline void set_dec(int val)
+static inline void set_dec(u64 val)
 {
 #if defined(CONFIG_40x)
-	mtspr(SPRN_PIT, val);
+	mtspr(SPRN_PIT, (u32) val);
 #else
 #ifndef CONFIG_BOOKE
 	--val;
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 7a482a7f4d8d..d1cb44ddfc95 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -97,7 +97,8 @@ static struct clocksource clocksource_timebase = {
 	.read         = timebase_read,
 };
 
-#define DECREMENTER_MAX	0x7fffffff
+#define DECREMENTER_DEFAULT_MAX 0x7FFFFFFF
+u64 decrementer_max = DECREMENTER_DEFAULT_MAX;
 
 static int decrementer_set_next_event(unsigned long evt,
 				      struct clock_event_device *dev);
@@ -505,8 +506,8 @@ static void __timer_interrupt(void)
 		__this_cpu_inc(irq_stat.timer_irqs_event);
 	} else {
 		now = *next_tb - now;
-		if (now <= DECREMENTER_MAX)
-			set_dec((int)now);
+		if (now <= decrementer_max)
+			set_dec(now);
 		/* We may have raced with new irq work */
 		if (test_irq_work_pending())
 			set_dec(1);
@@ -536,7 +537,7 @@ void timer_interrupt(struct pt_regs * regs)
 	/* Ensure a positive value is written to the decrementer, or else
 	 * some CPUs will continue to take decrementer exceptions.
 	 */
-	set_dec(DECREMENTER_MAX);
+	set_dec(decrementer_max);
 
 	/* Some implementations of hotplug will get timer interrupts while
 	 * offline, just ignore these and we also need to set
@@ -584,9 +585,9 @@ static void generic_suspend_disable_irqs(void)
 	 * with suspending.
 	 */
 
-	set_dec(DECREMENTER_MAX);
+	set_dec(decrementer_max);
 	local_irq_disable();
-	set_dec(DECREMENTER_MAX);
+	set_dec(decrementer_max);
 }
 
 static void generic_suspend_enable_irqs(void)
@@ -867,7 +868,7 @@ static int decrementer_set_next_event(unsigned long evt,
 
 static int decrementer_shutdown(struct clock_event_device *dev)
 {
-	decrementer_set_next_event(DECREMENTER_MAX, dev);
+	decrementer_set_next_event(decrementer_max, dev);
 	return 0;
 }
 
@@ -893,6 +894,49 @@ static void register_decrementer_clockevent(int cpu)
 	clockevents_register_device(dec);
 }
 
+static void enable_large_decrementer(void)
+{
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return;
+
+	if (decrementer_max <= DECREMENTER_DEFAULT_MAX)
+		return;
+
+	/*
+	 * If we're running as the hypervisor we need to enable the LD manually
+	 * otherwise firmware should have done it for us.
+	 */
+	if (cpu_has_feature(CPU_FTR_HVMODE))
+		mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_LD);
+}
+
+static void __init set_decrementer_max(void)
+{
+	struct device_node *cpu;
+	u32 bits = 32;
+
+	/* Prior to ISAv3 the decrementer is always 32 bit */
+	if (!cpu_has_feature(CPU_FTR_ARCH_300))
+		return;
+
+	cpu = of_find_node_by_type(NULL, "cpu");
+
+	if (of_property_read_u32(cpu, "ibm,dec-bits", &bits) == 0) {
+		if (bits > 64 || bits < 32) {
+			pr_warn("time_init: firmware supplied invalid ibm,dec-bits");
+			bits = 32;
+		}
+
+		/* calculate the signed maximum given this many bits */
+		decrementer_max = (1ul << (bits - 1)) - 1;
+	}
+
+	of_node_put(cpu);
+
+	pr_info("time_init: %u bit decrementer (max: %llx)\n",
+		bits, decrementer_max);
+}
+
 static void __init init_decrementer_clockevent(void)
 {
 	int cpu = smp_processor_id();
@@ -900,7 +944,7 @@ static void __init init_decrementer_clockevent(void)
 	clockevents_calc_mult_shift(&decrementer_clockevent, ppc_tb_freq, 4);
 
 	decrementer_clockevent.max_delta_ns =
-		clockevent_delta2ns(DECREMENTER_MAX, &decrementer_clockevent);
+		clockevent_delta2ns(decrementer_max, &decrementer_clockevent);
 	decrementer_clockevent.min_delta_ns =
 		clockevent_delta2ns(2, &decrementer_clockevent);
 
@@ -909,6 +953,9 @@ static void __init init_decrementer_clockevent(void)
 
 void secondary_cpu_time_init(void)
 {
+	/* Enable and test the large decrementer for this cpu */
+	enable_large_decrementer();
+
 	/* Start the decrementer on CPUs that have manual control
 	 * such as BookE
 	 */
@@ -974,6 +1021,10 @@ void __init time_init(void)
 	vdso_data->tb_update_count = 0;
 	vdso_data->tb_ticks_per_sec = tb_ticks_per_sec;
 
+	/* initialise and enable the large decrementer (if we have one) */
+	set_decrementer_max();
+	enable_large_decrementer();
+
 	/* Start the decrementer on CPUs that have manual control
 	 * such as BookE
 	 */
-- 
2.5.5
