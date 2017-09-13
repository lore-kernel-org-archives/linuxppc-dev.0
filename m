Return-Path: <npiggin@gmail.com>
Date: Wed, 13 Sep 2017 23:13:54 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org, skiboot@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alistair Popple
 <alistair@popple.id.au>
Subject: Re: [RFC PATCH 2/2] powerpc/powernv: implement NMI IPIs with
 OPAL_SIGNAL_SYSTEM_RESET
Message-ID: <20170913231354.6b249fd0@roar.ozlabs.ibm.com>
In-Reply-To: <20170912160553.13422-3-npiggin@gmail.com>
References: <20170912160553.13422-1-npiggin@gmail.com>
 <20170912160553.13422-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 13 Sep 2017 02:05:53 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> There are two complications. The first is that sreset from stop states
> come in with SRR1 set to do a powersave wakeup, with an sreset reason
> encoded.
> 
> The second is that threads on the same core can't be signalled directly
> so we must designate a bounce CPU to reflect the IPI back.

Here is an updated Linux patch for the latest OPAL patch. This has
a few assorted fixes as well to make it work nicely, I roll them into
one patch here to make it easy to apply for testing the OPAL patch.

Thanks,
Nick

---
 arch/powerpc/include/asm/opal-api.h            |  1 +
 arch/powerpc/include/asm/opal.h                |  2 +
 arch/powerpc/kernel/irq.c                      | 18 ++++++
 arch/powerpc/kernel/watchdog.c                 | 30 +++++++--
 arch/powerpc/platforms/powernv/opal-wrappers.S |  1 +
 arch/powerpc/platforms/powernv/powernv.h       |  1 +
 arch/powerpc/platforms/powernv/setup.c         |  3 +
 arch/powerpc/platforms/powernv/smp.c           | 89 ++++++++++++++++++++++++++
 arch/powerpc/xmon/xmon.c                       | 17 +++--
 9 files changed, 151 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 450a60b81d2a..e39f4236b413 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -188,6 +188,7 @@
 #define OPAL_XIVE_DUMP				142
 #define OPAL_XIVE_RESERVED3			143
 #define OPAL_XIVE_RESERVED4			144
+#define OPAL_SIGNAL_SYSTEM_RESET                145
 #define OPAL_NPU_INIT_CONTEXT			146
 #define OPAL_NPU_DESTROY_CONTEXT		147
 #define OPAL_NPU_MAP_LPAR			148
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 726c23304a57..7d7613c49f2b 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -281,6 +281,8 @@ int opal_get_power_shift_ratio(u32 handle, int token, u32 *psr);
 int opal_set_power_shift_ratio(u32 handle, int token, u32 psr);
 int opal_sensor_group_clear(u32 group_hndl, int token);
 
+int64_t opal_signal_system_reset(int32_t cpu);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 4e65bf82f5e0..5f2c0367bab2 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -407,10 +407,28 @@ static const u8 srr1_to_lazyirq[0x10] = {
 	PACA_IRQ_HMI,
 	0, 0, 0, 0, 0 };
 
+/*
+ * System reset does not have to wait for Linux interrupts
+ * to be re-enabled, so just replay it now.
+ */
+static noinline void replay_system_reset(void)
+{
+	struct pt_regs regs;
+
+	ppc_save_regs(&regs);
+
+	get_paca()->in_nmi = 1;
+	system_reset_exception(&regs);
+	get_paca()->in_nmi = 0;
+}
+
 void irq_set_pending_from_srr1(unsigned long srr1)
 {
 	unsigned int idx = (srr1 & SRR1_WAKEMASK_P8) >> 18;
 
+	if (unlikely(idx == 4))
+		replay_system_reset();
+
 	/*
 	 * The 0 index (SRR1[42:45]=b0000) must always evaluate to 0,
 	 * so this can be called unconditionally with srr1 wake reason.
diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdog.c
index 2f6eadd9408d..a6aa85b0cdeb 100644
--- a/arch/powerpc/kernel/watchdog.c
+++ b/arch/powerpc/kernel/watchdog.c
@@ -61,6 +61,7 @@ static DEFINE_PER_CPU(u64, wd_timer_tb);
  */
 static unsigned long __wd_smp_lock;
 static cpumask_t wd_smp_cpus_pending;
+static cpumask_t wd_smp_cpus_stuck_tmp;
 static cpumask_t wd_smp_cpus_stuck;
 static u64 wd_smp_last_reset_tb;
 
@@ -97,8 +98,7 @@ static void wd_lockup_ipi(struct pt_regs *regs)
 	else
 		dump_stack();
 
-	if (hardlockup_panic)
-		nmi_panic(regs, "Hard LOCKUP");
+	/* Do not panic from here because that can recurse into NMI IPI layer */
 }
 
 static void set_cpumask_stuck(const struct cpumask *cpumask, u64 tb)
@@ -136,16 +136,29 @@ static void watchdog_smp_panic(int cpu, u64 tb)
 
 	/*
 	 * Try to trigger the stuck CPUs.
+	 *
+	 * There is a bit of a hack for OPAL here because it can not
+	 * signal sibling threads. Don't try to signal those or mark
+	 * them stuck, in the hope that another core will notice.
 	 */
+	cpumask_clear(&wd_smp_cpus_stuck_tmp);
 	for_each_cpu(c, &wd_smp_cpus_pending) {
 		if (c == cpu)
 			continue;
-		smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
+		if (firmware_has_feature(FW_FEATURE_OPAL)) {
+			if (cpumask_test_cpu(c, cpu_sibling_mask(cpu)))
+				continue;
+		}
+		cpumask_set_cpu(c, &wd_smp_cpus_stuck_tmp);
+		if (!sysctl_hardlockup_all_cpu_backtrace)
+			smp_send_nmi_ipi(c, wd_lockup_ipi, 1000000);
 	}
-	smp_flush_nmi_ipi(1000000);
 
 	/* Take the stuck CPUs out of the watch group */
-	set_cpumask_stuck(&wd_smp_cpus_pending, tb);
+	set_cpumask_stuck(&wd_smp_cpus_stuck_tmp, tb);
+
+	if (!sysctl_hardlockup_all_cpu_backtrace)
+		smp_flush_nmi_ipi(1000000);
 
 	wd_smp_unlock(&flags);
 
@@ -275,9 +288,12 @@ void arch_touch_nmi_watchdog(void)
 {
 	unsigned long ticks = tb_ticks_per_usec * wd_timer_period_ms * 1000;
 	int cpu = smp_processor_id();
+	u64 tb = get_tb();
 
-	if (get_tb() - per_cpu(wd_timer_tb, cpu) >= ticks)
-		watchdog_timer_interrupt(cpu);
+	if (tb - per_cpu(wd_timer_tb, cpu) >= ticks) {
+		per_cpu(wd_timer_tb, cpu) = tb;
+		wd_smp_clear_cpu_pending(cpu, tb);
+	}
 }
 EXPORT_SYMBOL(arch_touch_nmi_watchdog);
 
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 8c1ede2d3f7e..37cd170201a2 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -307,6 +307,7 @@ OPAL_CALL(opal_xive_get_vp_info,		OPAL_XIVE_GET_VP_INFO);
 OPAL_CALL(opal_xive_set_vp_info,		OPAL_XIVE_SET_VP_INFO);
 OPAL_CALL(opal_xive_sync,			OPAL_XIVE_SYNC);
 OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
+OPAL_CALL(opal_signal_system_reset,		OPAL_SIGNAL_SYSTEM_RESET);
 OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
 OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
 OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index a159d48573d7..49add2037e0d 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -3,6 +3,7 @@
 
 #ifdef CONFIG_SMP
 extern void pnv_smp_init(void);
+extern int pnv_system_reset_exception(struct pt_regs *regs);
 #else
 static inline void pnv_smp_init(void) { }
 #endif
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 897aa1400eb8..4fdaa1d7c4cd 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -282,6 +282,9 @@ static void __init pnv_setup_machdep_opal(void)
 	ppc_md.restart = pnv_restart;
 	pm_power_off = pnv_power_off;
 	ppc_md.halt = pnv_halt;
+#ifdef CONFIG_SMP
+	ppc_md.system_reset_exception = pnv_system_reset_exception;
+#endif
 	ppc_md.machine_check_exception = opal_machine_check;
 	ppc_md.mce_check_early_recovery = opal_mce_check_early_recovery;
 	ppc_md.hmi_exception_early = opal_hmi_exception_early;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index c17f81e433f7..9da97962c93a 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -290,6 +290,93 @@ static void __init pnv_smp_probe(void)
 	}
 }
 
+static int nmi_ipi_bounce_cpu;
+static int nmi_ipi_bounce_target_core;
+static int nmi_ipi_bounce_target_exclude;
+
+int pnv_system_reset_exception(struct pt_regs *regs)
+{
+	if (nmi_ipi_bounce_cpu == smp_processor_id()) {
+		int c;
+		nmi_ipi_bounce_cpu = -1;
+		for_each_online_cpu(c) {
+			if (!cpumask_test_cpu(c, cpu_sibling_mask(
+						nmi_ipi_bounce_target_core)))
+				continue;
+			if (c == nmi_ipi_bounce_target_exclude)
+				continue;
+			opal_signal_system_reset(
+					get_hard_smp_processor_id(c));
+			/* can't do much with failure here */
+		}
+	}
+
+	if (smp_handle_nmi_ipi(regs))
+		return 1;
+	return 0;
+}
+
+static int pnv_cause_nmi_ipi(int cpu)
+{
+	int64_t rc;
+
+	if (cpu >= 0) {
+		rc = opal_signal_system_reset(get_hard_smp_processor_id(cpu));
+		if (rc == OPAL_SUCCESS)
+			return 1;
+		return 0;
+	} else {
+		int c;
+
+		/*
+		 * Some platforms can not send NMI to sibling threads in
+		 * the same core. We can designate one inter-core target
+		 * to bounce NMIs back to our sibling threads.
+		 */
+
+		if (cpu >= 0) {
+			/*
+			 * Don't support bouncing unicast NMIs yet (because
+			 * that would have to raise an NMI on an unrelated
+			 * CPU. Revisit this if callers start using unicast.
+			 */
+			return 0;
+		}
+
+		nmi_ipi_bounce_cpu = -1;
+		nmi_ipi_bounce_target_core = -1;
+		nmi_ipi_bounce_target_exclude = -1;
+
+		for_each_online_cpu(c) {
+			if (cpumask_test_cpu(c, cpu_sibling_mask(smp_processor_id())))
+				continue;
+
+			if (nmi_ipi_bounce_cpu == -1) {
+				nmi_ipi_bounce_cpu = c;
+				nmi_ipi_bounce_target_core = smp_processor_id();
+				if (cpu == NMI_IPI_ALL_OTHERS)
+					nmi_ipi_bounce_target_exclude = smp_processor_id();
+				smp_mb();
+			} else {
+				rc = opal_signal_system_reset(
+						get_hard_smp_processor_id(c));
+				if (rc != OPAL_SUCCESS)
+					return 0;
+			}
+		}
+
+		if (nmi_ipi_bounce_cpu == -1)
+			return 0; /* could not find a bouncer */
+		rc = opal_signal_system_reset(
+				get_hard_smp_processor_id(nmi_ipi_bounce_cpu));
+		if (rc != OPAL_SUCCESS)
+			return 0;
+		return 1;
+	}
+
+	return 0;
+}
+
 static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= NULL, /* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by pnv_smp_probe() */
@@ -308,6 +395,8 @@ static struct smp_ops_t pnv_smp_ops = {
 /* This is called very early during platform setup_arch */
 void __init pnv_smp_init(void)
 {
+	if (opal_check_token(OPAL_SIGNAL_SYSTEM_RESET))
+		pnv_smp_ops.cause_nmi_ipi = pnv_cause_nmi_ipi;
 	smp_ops = &pnv_smp_ops;
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 33351c6704b1..d9a12102b111 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -530,14 +530,19 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 
  waiting:
 	secondary = 1;
+	spin_begin();
 	while (secondary && !xmon_gate) {
 		if (in_xmon == 0) {
-			if (fromipi)
+			if (fromipi) {
+				spin_end();
 				goto leave;
+			}
 			secondary = test_and_set_bit(0, &in_xmon);
 		}
-		barrier();
+		spin_cpu_relax();
+		touch_nmi_watchdog();
 	}
+	spin_end();
 
 	if (!secondary && !xmon_gate) {
 		/* we are the first cpu to come in */
@@ -568,21 +573,25 @@ static int xmon_core(struct pt_regs *regs, int fromipi)
 		mb();
 		xmon_gate = 1;
 		barrier();
+		touch_nmi_watchdog();
 	}
 
  cmdloop:
 	while (in_xmon) {
 		if (secondary) {
+			spin_begin();
 			if (cpu == xmon_owner) {
 				if (!test_and_set_bit(0, &xmon_taken)) {
 					secondary = 0;
+					spin_end();
 					continue;
 				}
 				/* missed it */
 				while (cpu == xmon_owner)
-					barrier();
+					spin_cpu_relax();
 			}
-			barrier();
+			spin_cpu_relax();
+			touch_nmi_watchdog();
 		} else {
 			cmd = cmds(regs);
 			if (cmd != 0) {
-- 
2.13.3
