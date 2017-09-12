Return-Path: <npiggin@gmail.com>
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	skiboot@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alistair Popple <alistair@popple.id.au>
Subject: [RFC PATCH 2/2] powerpc/powernv: implement NMI IPIs with
 OPAL_SIGNAL_SYSTEM_RESET
Date: Wed, 13 Sep 2017 02:05:53 +1000
Message-Id: <20170912160553.13422-3-npiggin@gmail.com>
In-Reply-To: <20170912160553.13422-1-npiggin@gmail.com>
References: <20170912160553.13422-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are two complications. The first is that sreset from stop states
come in with SRR1 set to do a powersave wakeup, with an sreset reason
encoded.

The second is that threads on the same core can't be signalled directly
so we must designate a bounce CPU to reflect the IPI back.
---
 arch/powerpc/include/asm/opal-api.h            |   1 +
 arch/powerpc/include/asm/opal.h                |   2 +
 arch/powerpc/kernel/irq.c                      |  13 +++
 arch/powerpc/platforms/powernv/opal-wrappers.S |   1 +
 arch/powerpc/platforms/powernv/powernv.h       |   1 +
 arch/powerpc/platforms/powernv/setup.c         |   3 +
 arch/powerpc/platforms/powernv/smp.c           | 111 +++++++++++++++++++++++++
 7 files changed, 132 insertions(+)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 450a60b81d2a..bd9d1f2b3584 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -188,6 +188,7 @@
 #define OPAL_XIVE_DUMP				142
 #define OPAL_XIVE_RESERVED3			143
 #define OPAL_XIVE_RESERVED4			144
+#define OPAL_SIGNAL_SYSTEM_RESET 		145
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
index 4e65bf82f5e0..3276e05cb53f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -407,10 +407,23 @@ static const u8 srr1_to_lazyirq[0x10] = {
 	PACA_IRQ_HMI,
 	0, 0, 0, 0, 0 };
 
+static noinline void system_reset(void)
+{
+	struct pt_regs regs;
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
 
+	if (unlikely(idx == 2 || idx == 4))
+		system_reset();
+
 	/*
 	 * The 0 index (SRR1[42:45]=b0000) must always evaluate to 0,
 	 * so this can be called unconditionally with srr1 wake reason.
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
index c17f81e433f7..45b1c191e3c8 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -290,6 +290,112 @@ static void __init pnv_smp_probe(void)
 	}
 }
 
+static int nmi_ipi_bounce_cpu;
+static int nmi_ipi_bounce_cpu_done;
+static int nmi_ipi_bounce_target_core;
+static int nmi_ipi_bounce_target_exclude;
+
+int pnv_system_reset_exception(struct pt_regs *regs)
+{
+	smp_mb();
+	if (nmi_ipi_bounce_cpu == smp_processor_id()) {
+		int64_t rc;
+		int c;
+
+		nmi_ipi_bounce_cpu = -1;
+		smp_mb();
+		for_each_online_cpu(c) {
+			if (!cpumask_test_cpu(c, cpu_sibling_mask(nmi_ipi_bounce_target_core)))
+				continue;
+			if (c == nmi_ipi_bounce_target_exclude)
+				continue;
+			rc = opal_signal_system_reset(get_hard_smp_processor_id(c));
+			if (rc != OPAL_SUCCESS) {
+				nmi_ipi_bounce_cpu_done = -1;
+				return 1;
+			}
+		}
+		nmi_ipi_bounce_cpu_done = 1;
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
+		/*
+		 * Test bounce behavior with broadcast IPI.
+		 */
+		rc = OPAL_PARTIAL;
+	}
+	if (rc == OPAL_PARTIAL) {
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
+			printk("CPU:%d pnv_cause_nmi_ipi can not bounce unicast IPIs!\n", smp_processor_id());
+			return 0;
+		}
+
+		nmi_ipi_bounce_cpu = -1;
+		nmi_ipi_bounce_cpu_done = 0;
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
+				rc = opal_signal_system_reset(get_hard_smp_processor_id(c));
+				if (rc != OPAL_SUCCESS)
+					return 0;
+			}
+		}
+
+		if (nmi_ipi_bounce_cpu == -1)
+			return 0; /* could not find a bouncer */
+
+		rc = opal_signal_system_reset(get_hard_smp_processor_id(nmi_ipi_bounce_cpu));
+		if (rc != OPAL_SUCCESS)
+			return 0;
+
+		while (!nmi_ipi_bounce_cpu_done)
+			cpu_relax();
+
+		if (nmi_ipi_bounce_cpu_done == 1)
+			return 1; /* bounce worked */
+	}
+
+	return 0;
+}
+
 static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= NULL, /* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by pnv_smp_probe() */
@@ -308,6 +414,11 @@ static struct smp_ops_t pnv_smp_ops = {
 /* This is called very early during platform setup_arch */
 void __init pnv_smp_init(void)
 {
+	if (opal_check_token(OPAL_SIGNAL_SYSTEM_RESET)) {
+		printk("OPAL_SIGNAL_SYSTEM_RESET available\n");
+		pnv_smp_ops.cause_nmi_ipi = pnv_cause_nmi_ipi;
+	} else
+		printk("OPAL_SIGNAL_SYSTEM_RESET NOT available\n");
 	smp_ops = &pnv_smp_ops;
 
 #ifdef CONFIG_HOTPLUG_CPU
-- 
2.13.3
