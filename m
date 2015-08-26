Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0110.outbound.protection.outlook.com [157.56.111.110])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ED9941A0179
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Aug 2015 22:10:00 +1000 (AEST)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <Jason.Jin@freescale.com>
Subject: [PATCH v2,3/5] Powerpc: mpc85xx: refactor the PM operations
Date: Wed, 26 Aug 2015 20:09:46 +0800
Message-ID: <1440590988-25594-3-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1440590988-25594-1-git-send-email-chenhui.zhao@freescale.com>
References: <1440590988-25594-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale CoreNet-based and Non-CoreNet-based platforms require
different PM operations. This patch extracted existing PM operations
on Non-CoreNet-based platforms to a new file which can accommodate
both platforms.
In this way, PM operation codes are clearer structurally.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@feescale.com>
---
major changes for v2:
* moved mpc85xx_cpu_die()
* added qoriq_pm_ops->cpu_die() in smp_85xx_mach_cpu_die(). it puts the dying
  cpu in a low power mode

 arch/powerpc/platforms/85xx/Makefile         |   1 +
 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c | 106 +++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/smp.c            |  74 +++++--------------
 arch/powerpc/platforms/85xx/smp.h            |   1 +
 4 files changed, 127 insertions(+), 55 deletions(-)
 create mode 100644 arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c

diff --git a/arch/powerpc/platforms/85xx/Makefile b/arch/powerpc/platforms/85xx/Makefile
index 1fe7fb9..7bc86da 100644
--- a/arch/powerpc/platforms/85xx/Makefile
+++ b/arch/powerpc/platforms/85xx/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the PowerPC 85xx linux kernel.
 #
 obj-$(CONFIG_SMP) += smp.o
+obj-$(CONFIG_FSL_PMC)		  += mpc85xx_pm_ops.o
 
 obj-y += common.o
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c b/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
new file mode 100644
index 0000000..ed356dd
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/mpc85xx_pm_ops.c
@@ -0,0 +1,106 @@
+/*
+ * MPC85xx PM operators
+ *
+ * Copyright 2015 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define pr_fmt(fmt) "%s: " fmt, __func__
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <asm/io.h>
+#include <asm/fsl_guts.h>
+#include <asm/fsl_pm.h>
+
+static struct ccsr_guts __iomem *guts;
+
+static void mpc85xx_irq_mask(int cpu)
+{
+
+}
+
+static void mpc85xx_irq_unmask(int cpu)
+{
+
+}
+
+static void mpc85xx_cpu_die(int cpu)
+{
+	u32 tmp;
+
+	tmp = (mfspr(SPRN_HID0) & ~(HID0_DOZE|HID0_SLEEP)) | HID0_NAP;
+	mtspr(SPRN_HID0, tmp);
+
+	/* Enter NAP mode. */
+	tmp = mfmsr();
+	tmp |= MSR_WE;
+	asm volatile(
+		"msync\n"
+		"mtmsr %0\n"
+		"isync\n"
+		:
+		: "r" (tmp));
+}
+
+static void mpc85xx_cpu_up_prepare(int cpu)
+{
+
+}
+
+static void mpc85xx_freeze_time_base(bool freeze)
+{
+	uint32_t mask;
+
+	mask = CCSR_GUTS_DEVDISR_TB0 | CCSR_GUTS_DEVDISR_TB1;
+	if (freeze)
+		setbits32(&guts->devdisr, mask);
+	else
+		clrbits32(&guts->devdisr, mask);
+
+	in_be32(&guts->devdisr);
+}
+
+static const struct of_device_id mpc85xx_smp_guts_ids[] = {
+	{ .compatible = "fsl,mpc8572-guts", },
+	{ .compatible = "fsl,p1020-guts", },
+	{ .compatible = "fsl,p1021-guts", },
+	{ .compatible = "fsl,p1022-guts", },
+	{ .compatible = "fsl,p1023-guts", },
+	{ .compatible = "fsl,p2020-guts", },
+	{ .compatible = "fsl,bsc9132-guts", },
+	{},
+};
+
+static const struct fsl_pm_ops mpc85xx_pm_ops = {
+	.freeze_time_base = mpc85xx_freeze_time_base,
+	.irq_mask = mpc85xx_irq_mask,
+	.irq_unmask = mpc85xx_irq_unmask,
+	.cpu_die = mpc85xx_cpu_die,
+	.cpu_up_prepare = mpc85xx_cpu_up_prepare,
+};
+
+int __init mpc85xx_setup_pmc(void)
+{
+	struct device_node *np;
+
+	np = of_find_matching_node(NULL, mpc85xx_smp_guts_ids);
+	if (np) {
+		guts = of_iomap(np, 0);
+		of_node_put(np);
+		if (!guts) {
+			pr_err("Could not map guts node address\n");
+			return -ENOMEM;
+		}
+	}
+
+	qoriq_pm_ops = &mpc85xx_pm_ops;
+
+	return 0;
+}
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 0b75e8e..f9552b8 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -2,7 +2,7 @@
  * Author: Andy Fleming <afleming@freescale.com>
  * 	   Kumar Gala <galak@kernel.crashing.org>
  *
- * Copyright 2006-2008, 2011-2012 Freescale Semiconductor Inc.
+ * Copyright 2006-2008, 2011-2012, 2015 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -15,7 +15,6 @@
 #include <linux/init.h>
 #include <linux/delay.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/kexec.h>
 #include <linux/highmem.h>
 #include <linux/cpu.h>
@@ -26,9 +25,9 @@
 #include <asm/mpic.h>
 #include <asm/cacheflush.h>
 #include <asm/dbell.h>
-#include <asm/fsl_guts.h>
 #include <asm/code-patching.h>
 #include <asm/cputhreads.h>
+#include <asm/fsl_pm.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/mpic.h>
@@ -43,24 +42,11 @@ struct epapr_spin_table {
 	u32	pir;
 };
 
-static struct ccsr_guts __iomem *guts;
+#ifdef CONFIG_HOTPLUG_CPU
 static u64 timebase;
 static int tb_req;
 static int tb_valid;
 
-static void mpc85xx_timebase_freeze(int freeze)
-{
-	uint32_t mask;
-
-	mask = CCSR_GUTS_DEVDISR_TB0 | CCSR_GUTS_DEVDISR_TB1;
-	if (freeze)
-		setbits32(&guts->devdisr, mask);
-	else
-		clrbits32(&guts->devdisr, mask);
-
-	in_be32(&guts->devdisr);
-}
-
 static void mpc85xx_give_timebase(void)
 {
 	unsigned long flags;
@@ -71,7 +57,7 @@ static void mpc85xx_give_timebase(void)
 		barrier();
 	tb_req = 0;
 
-	mpc85xx_timebase_freeze(1);
+	qoriq_pm_ops->freeze_time_base(true);
 #ifdef CONFIG_PPC64
 	/*
 	 * e5500/e6500 have a workaround for erratum A-006958 in place
@@ -104,7 +90,7 @@ static void mpc85xx_give_timebase(void)
 	while (tb_valid)
 		barrier();
 
-	mpc85xx_timebase_freeze(0);
+	qoriq_pm_ops->freeze_time_base(false);
 
 	local_irq_restore(flags);
 }
@@ -126,31 +112,25 @@ static void mpc85xx_take_timebase(void)
 	local_irq_restore(flags);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static void smp_85xx_mach_cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
-	u32 tmp;
 
 	local_irq_disable();
+	hard_irq_disable();
+	/* mask all irqs to prevent cpu wakeup */
+	qoriq_pm_ops->irq_mask(cpu);
+
 	idle_task_exit();
-	generic_set_cpu_dead(cpu);
-	mb();
 
 	mtspr(SPRN_TCR, 0);
+	mtspr(SPRN_TSR, mfspr(SPRN_TSR));
 
-	cur_cpu_spec->cpu_down_flush();
+	generic_set_cpu_dead(cpu);
 
-	tmp = (mfspr(SPRN_HID0) & ~(HID0_DOZE|HID0_SLEEP)) | HID0_NAP;
-	mtspr(SPRN_HID0, tmp);
-	isync();
+	cur_cpu_spec->cpu_down_flush();
 
-	/* Enter NAP mode. */
-	tmp = mfmsr();
-	tmp |= MSR_WE;
-	mb();
-	mtmsr(tmp);
-	isync();
+	qoriq_pm_ops->cpu_die(cpu);
 
 	while (1)
 		;
@@ -398,16 +378,6 @@ static void smp_85xx_setup_cpu(int cpu_nr)
 	smp_85xx_basic_setup(cpu_nr);
 }
 
-static const struct of_device_id mpc85xx_smp_guts_ids[] = {
-	{ .compatible = "fsl,mpc8572-guts", },
-	{ .compatible = "fsl,p1020-guts", },
-	{ .compatible = "fsl,p1021-guts", },
-	{ .compatible = "fsl,p1022-guts", },
-	{ .compatible = "fsl,p1023-guts", },
-	{ .compatible = "fsl,p2020-guts", },
-	{},
-};
-
 void __init mpc85xx_smp_init(void)
 {
 	struct device_node *np;
@@ -431,22 +401,16 @@ void __init mpc85xx_smp_init(void)
 		smp_85xx_ops.probe = NULL;
 	}
 
-	np = of_find_matching_node(NULL, mpc85xx_smp_guts_ids);
-	if (np) {
-		guts = of_iomap(np, 0);
-		of_node_put(np);
-		if (!guts) {
-			pr_err("%s: Could not map guts node address\n",
-								__func__);
-			return;
-		}
+#ifdef CONFIG_HOTPLUG_CPU
+#ifdef CONFIG_FSL_PMC
+	mpc85xx_setup_pmc();
+#endif
+	if (qoriq_pm_ops) {
 		smp_85xx_ops.give_timebase = mpc85xx_give_timebase;
 		smp_85xx_ops.take_timebase = mpc85xx_take_timebase;
-#ifdef CONFIG_HOTPLUG_CPU
 		ppc_md.cpu_die = smp_85xx_mach_cpu_die;
-#endif
 	}
-
+#endif
 	smp_ops = &smp_85xx_ops;
 
 #ifdef CONFIG_KEXEC
diff --git a/arch/powerpc/platforms/85xx/smp.h b/arch/powerpc/platforms/85xx/smp.h
index e2b4493..0b20ae3 100644
--- a/arch/powerpc/platforms/85xx/smp.h
+++ b/arch/powerpc/platforms/85xx/smp.h
@@ -5,6 +5,7 @@
 
 #ifdef CONFIG_SMP
 void __init mpc85xx_smp_init(void);
+int __init mpc85xx_setup_pmc(void);
 #else
 static inline void mpc85xx_smp_init(void)
 {
-- 
1.9.1
