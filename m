Return-Path: <B35336@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D45B2C0125
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 00:08:36 +1100 (EST)
Received: from mail194-co9 (localhost [127.0.0.1])	by
 mail194-co9-R.bigfish.com (Postfix) with ESMTP id 44CB01C0124	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:31 +0000 (UTC)
Received: from CO9EHSMHS019.bigfish.com (unknown [10.236.132.248])	by
 mail194-co9.bigfish.com (Postfix) with ESMTP id A43D9380072	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:28 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 10/17] powerpc/85xx: add cpu hotplug support for e500mc/e5500
Date: Wed, 3 Apr 2013 21:09:18 +0800
Message-ID: <1364994565-16010-10-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
References: <1364994565-16010-1-git-send-email-chenhui.zhao@freescale.com>
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

From: Chen-Hui Zhao <chenhui.zhao@freescale.com>

Add support to disable and re-enable individual cores at runtime.
This supports e500mc/e5500 core based SoCs.

To prevent the register access race, only read/write RCPM registers
in platform_cpu_die() on the boot cpu instead of accessing by individual
cpus. Platform implementations can override the platform_cpu_die().

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/Kconfig              |    2 +-
 arch/powerpc/include/asm/smp.h    |    1 +
 arch/powerpc/kernel/smp.c         |   16 ++++++++++-
 arch/powerpc/platforms/85xx/smp.c |   56 ++++++++++++++++++++++++++++++++++--
 4 files changed, 69 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0e11a09..b6851be 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -347,7 +347,7 @@ config SWIOTLB
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
 	depends on SMP && HOTPLUG && (PPC_PSERIES || \
-	PPC_PMAC || PPC_POWERNV || (PPC_85xx && !PPC_E500MC))
+	PPC_PMAC || PPC_POWERNV || PPC_85xx)
 	---help---
 	  Say Y here to be able to disable and re-enable individual
 	  CPUs at runtime on SMP machines.
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 195ce2a..95be584 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -60,6 +60,7 @@ extern void smp_generic_take_timebase(void);
 DECLARE_PER_CPU(unsigned int, cpu_pvr);
 
 #ifdef CONFIG_HOTPLUG_CPU
+void platform_cpu_die(unsigned int cpu);
 extern void migrate_irqs(void);
 int generic_cpu_disable(void);
 void generic_cpu_die(unsigned int cpu);
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 76bd9da..386c7ea 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -381,14 +381,28 @@ int generic_cpu_disable(void)
 	return 0;
 }
 
+/**
+ * platform_cpu_die() - do platform related operations on the boot cpu
+ * after CPU_DEAD is assigned to the variable cpu_state of the dying cpu.
+ * Platform implementations can override this.
+ *
+ * @cpu:	the cpu to die
+ */
+void __attribute__ ((weak)) platform_cpu_die(unsigned int cpu)
+{
+	return;
+}
+
 void generic_cpu_die(unsigned int cpu)
 {
 	int i;
 
 	for (i = 0; i < 100; i++) {
 		smp_rmb();
-		if (per_cpu(cpu_state, cpu) == CPU_DEAD)
+		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
+			platform_cpu_die(cpu);
 			return;
+		}
 		msleep(100);
 	}
 	printk(KERN_ERR "CPU%d didn't die...\n", cpu);
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 3de85a4..04e9fb9 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -40,7 +40,7 @@ struct epapr_spin_table {
 	u32	pir;
 };
 
-static struct ccsr_guts __iomem *guts;
+static void __iomem *guts_regs;
 static u64 timebase;
 static int tb_req;
 static int tb_valid;
@@ -62,7 +62,7 @@ static inline u32 get_phy_cpu_mask(void)
 
 static void mpc85xx_timebase_freeze(int freeze)
 {
-	struct ccsr_rcpm __iomem *rcpm = (typeof(rcpm))guts;
+	struct ccsr_rcpm __iomem *rcpm = guts_regs;
 	u32 mask = get_phy_cpu_mask();
 
 	if (freeze)
@@ -76,6 +76,7 @@ static void mpc85xx_timebase_freeze(int freeze)
 #else
 static void mpc85xx_timebase_freeze(int freeze)
 {
+	struct ccsr_guts __iomem *guts = guts_regs;
 	uint32_t mask;
 
 	mask = CCSR_GUTS_DEVDISR_TB0 | CCSR_GUTS_DEVDISR_TB1;
@@ -84,6 +85,7 @@ static void mpc85xx_timebase_freeze(int freeze)
 	else
 		clrbits32(&guts->devdisr, mask);
 
+	/* read back to push the previous write */
 	in_be32(&guts->devdisr);
 }
 #endif
@@ -136,7 +138,45 @@ static void mpc85xx_take_timebase(void)
 	local_irq_restore(flags);
 }
 
+static void core_reset_erratum(int hw_cpu)
+{
+#ifdef CONFIG_PPC_E500MC
+	struct ccsr_rcpm __iomem *rcpm = guts_regs;
+
+	clrbits32(&rcpm->cnapcr, 1 << hw_cpu);
+#endif
+}
+
 #ifdef CONFIG_HOTPLUG_CPU
+#ifdef CONFIG_PPC_E500MC
+static void __cpuinit smp_85xx_mach_cpu_die(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	local_irq_disable();
+	idle_task_exit();
+	mb();
+
+	mtspr(SPRN_TCR, 0);
+
+	__flush_disable_L1();
+	disable_backside_L2_cache();
+
+	generic_set_cpu_dead(cpu);
+
+	while (1);
+}
+
+void platform_cpu_die(unsigned int cpu)
+{
+	unsigned int hw_cpu = get_hard_smp_processor_id(cpu);
+	struct ccsr_rcpm __iomem *rcpm = guts_regs;
+
+	/* Core Nap Operation */
+	setbits32(&rcpm->cnapcr, 1 << hw_cpu);
+}
+#else
+/* for e500v1 and e500v2 */
 static void __cpuinit smp_85xx_mach_cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -164,6 +204,7 @@ static void __cpuinit smp_85xx_mach_cpu_die(void)
 	while (1)
 		;
 }
+#endif /* CONFIG_PPC_E500MC */
 #endif
 
 static inline void flush_spin_table(void *spin_table)
@@ -236,6 +277,13 @@ static int __cpuinit smp_85xx_kick_cpu(int nr)
 		flush_spin_table(spin_table);
 
 		/*
+		 * Due to an erratum that core hard reset and core warm reset
+		 * are unable to wake up cores from power management modes,
+		 * wake up cores before reset.
+		 */
+		core_reset_erratum(hw_cpu);
+
+		/*
 		 * We don't set the BPTR register here since it already points
 		 * to the boot page properly.
 		 */
@@ -444,9 +492,9 @@ void __init mpc85xx_smp_init(void)
 
 	np = of_find_matching_node(NULL, mpc85xx_smp_guts_ids);
 	if (np) {
-		guts = of_iomap(np, 0);
+		guts_regs = of_iomap(np, 0);
 		of_node_put(np);
-		if (!guts) {
+		if (!guts_regs) {
 			pr_err("%s: Could not map guts node address\n",
 								__func__);
 			return;
-- 
1.7.3
