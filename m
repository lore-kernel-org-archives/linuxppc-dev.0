Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 73741B71E4
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Sep 2011 13:45:39 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/20] powerpc/powernv: Add CPU hotplug support
Date: Tue, 20 Sep 2011 13:44:54 +1000
Message-Id: <1316490307-28030-7-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
References: <1316490307-28030-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Unplugged CPU go into NAP mode in a loop until woken up

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig                 |    2 +-
 arch/powerpc/platforms/powernv/smp.c |   78 +++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6926b61..85baae5 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -323,7 +323,7 @@ config SWIOTLB
 
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
-	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC)
+	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC || PPC_POWERNV)
 	---help---
 	  Say Y here to be able to disable and re-enable individual
 	  CPUs at runtime on SMP machines.
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index 36c7151..4f4ec37 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -33,7 +33,14 @@
 
 #include "powernv.h"
 
-static void __devinit pnv_smp_setup_cpu(int cpu)
+#ifdef DEBUG
+#include <asm/udbg.h>
+#define DBG(fmt...) udbg_printf(fmt)
+#else
+#define DBG(fmt...)
+#endif
+
+static void __cpuinit pnv_smp_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
 		xics_setup_cpu();
@@ -55,6 +62,67 @@ static int pnv_smp_cpu_bootable(unsigned int nr)
 	return 1;
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
+
+static int pnv_smp_cpu_disable(void)
+{
+	int cpu = smp_processor_id();
+
+	/* This is identical to pSeries... might consolidate by
+	 * moving migrate_irqs_away to a ppc_md with default to
+	 * the generic fixup_irqs. --BenH.
+	 */
+	set_cpu_online(cpu, false);
+	vdso_data->processorCount--;
+	if (cpu == boot_cpuid)
+		boot_cpuid = cpumask_any(cpu_online_mask);
+	xics_migrate_irqs_away();
+	return 0;
+}
+
+static void pnv_smp_cpu_kill_self(void)
+{
+	unsigned int cpu;
+
+	/* If powersave_nap is enabled, use NAP mode, else just
+	 * spin aimlessly
+	 */
+	if (!powersave_nap) {
+		generic_mach_cpu_die();
+		return;
+	}
+
+	/* Standard hot unplug procedure */
+	local_irq_disable();
+	idle_task_exit();
+	current->active_mm = NULL; /* for sanity */
+	cpu = smp_processor_id();
+	DBG("CPU%d offline\n", cpu);
+	generic_set_cpu_dead(cpu);
+	smp_wmb();
+
+	/* We don't want to take decrementer interrupts while we are offline,
+	 * so clear LPCR:PECE1. We keep PECE2 enabled.
+	 */
+	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) & ~(u64)LPCR_PECE1);
+	while (!generic_check_cpu_restart(cpu)) {
+		power7_idle();
+		if (!generic_check_cpu_restart(cpu)) {
+			DBG("CPU%d Unexpected exit while offline !\n", cpu);
+			/* We may be getting an IPI, so we re-enable
+			 * interrupts to process it, it will be ignored
+			 * since we aren't online (hopefully)
+			 */
+			local_irq_enable();
+			local_irq_disable();
+		}
+	}
+	mtspr(SPRN_LPCR, mfspr(SPRN_LPCR) | LPCR_PECE1);
+	DBG("CPU%d coming online...\n", cpu);
+}
+
+#endif /* CONFIG_HOTPLUG_CPU */
+
 static struct smp_ops_t pnv_smp_ops = {
 	.message_pass	= smp_muxed_ipi_message_pass,
 	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
@@ -62,6 +130,10 @@ static struct smp_ops_t pnv_smp_ops = {
 	.kick_cpu	= smp_generic_kick_cpu,
 	.setup_cpu	= pnv_smp_setup_cpu,
 	.cpu_bootable	= pnv_smp_cpu_bootable,
+#ifdef CONFIG_HOTPLUG_CPU
+	.cpu_disable	= pnv_smp_cpu_disable,
+	.cpu_die	= generic_cpu_die,
+#endif /* CONFIG_HOTPLUG_CPU */
 };
 
 /* This is called very early during platform setup_arch */
@@ -80,4 +152,8 @@ void __init pnv_smp_init(void)
 		smp_ops->take_timebase = rtas_take_timebase;
 	}
 #endif /* CONFIG_PPC_RTAS */
+
+#ifdef CONFIG_HOTPLUG_CPU
+	ppc_md.cpu_die	= pnv_smp_cpu_kill_self;
+#endif
 }
-- 
1.7.4.1
