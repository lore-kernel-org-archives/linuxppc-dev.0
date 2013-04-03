Return-Path: <B35336@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0442E2C0113
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Apr 2013 00:08:51 +1100 (EST)
Received: from mail37-co1 (localhost [127.0.0.1])	by mail37-co1-R.bigfish.com
 (Postfix) with ESMTP id D4592B00155	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Apr 2013 13:08:43 +0000 (UTC)
Received: from CO1EHSMHS003.bigfish.com (unknown [10.243.78.244])	by
 mail37-co1.bigfish.com (Postfix) with ESMTP id 991866A00ED	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Apr 2013 13:08:41 +0000 (UTC)
From: Zhao Chenhui <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 16/17] powerpc/smp: add cpu hotplug support for e6500
Date: Wed, 3 Apr 2013 21:09:24 +0800
Message-ID: <1364994565-16010-16-git-send-email-chenhui.zhao@freescale.com>
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

* Only if two threads of one core are offline, the core can
  enter PH20 state.
* Clear PH20 bits before core reset, or core will not restart.
* Introduced a variable l2cache_type in the struce cpu_spec to
  indentify the type of L2 cache.

Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/include/asm/cputable.h |   10 ++++++++
 arch/powerpc/kernel/cputable.c      |    5 ++++
 arch/powerpc/platforms/85xx/smp.c   |   40 +++++++++++++++++++++++++++++-----
 3 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index f326444..3715def 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -33,6 +33,13 @@ enum powerpc_pmc_type {
 	PPC_PMC_G4 = 3,
 };
 
+enum powerpc_l2cache_type {
+	PPC_L2_CACHE_DEFAULT = 0,
+	PPC_L2_CACHE_CORE    = 1, /* L2 cache used exclusively by one core */
+	PPC_L2_CACHE_CLUSTER = 2, /* L2 cache shared by a core cluster */
+	PPC_L2_CACHE_SOC     = 3, /* L2 cache shared by all cores */
+};
+
 struct pt_regs;
 
 extern int machine_check_generic(struct pt_regs *regs);
@@ -58,6 +65,9 @@ struct cpu_spec {
 	unsigned int	icache_bsize;
 	unsigned int	dcache_bsize;
 
+	/* L2 cache type */
+	enum powerpc_l2cache_type l2cache_type;
+
 	/* number of performance monitor counters */
 	unsigned int	num_pmcs;
 	enum powerpc_pmc_type pmc_type;
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index cc39139..a7329c1 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2004,6 +2004,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_e500v1,
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8540",
+		.l2cache_type		= PPC_L2_CACHE_SOC,
 	},
 	{	/* e500v2 */
 		.pvr_mask		= 0xffff0000,
@@ -2023,6 +2024,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_e500v2,
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
+		.l2cache_type		= PPC_L2_CACHE_SOC,
 	},
 	{	/* e500mc */
 		.pvr_mask		= 0xffff0000,
@@ -2040,6 +2042,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_setup		= __setup_cpu_e500mc,
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce500mc",
+		.l2cache_type		= PPC_L2_CACHE_CORE,
 	},
 #endif /* CONFIG_PPC32 */
 	{	/* e5500 */
@@ -2061,6 +2064,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce5500",
+		.l2cache_type		= PPC_L2_CACHE_CORE,
 	},
 	{	/* e6500 */
 		.pvr_mask		= 0xffff0000,
@@ -2082,6 +2086,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce6500",
+		.l2cache_type		= PPC_L2_CACHE_CLUSTER,
 	},
 #ifdef CONFIG_PPC32
 	{	/* default match */
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 4ec2de2..f5a3cc7 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -174,13 +174,31 @@ static void core_reset_erratum(int hw_cpu)
 {
 #ifdef CONFIG_PPC_E500MC
 	struct ccsr_rcpm __iomem *rcpm = guts_regs;
+	struct ccsr_rcpm_v2 __iomem *rcpm_v2 = guts_regs;
 
-	clrbits32(&rcpm->cnapcr, 1 << hw_cpu);
+	if (rcpmv2)
+		setbits32(&rcpm_v2->pcph20clrr,
+			1 << cpu_core_index_of_thread(hw_cpu));
+	else
+		clrbits32(&rcpm->cnapcr, 1 << hw_cpu);
 #endif
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
 #ifdef CONFIG_PPC_E500MC
+static inline bool is_core_down(unsigned int thread)
+{
+	cpumask_t thd_mask;
+
+	if (!smt_capable())
+		return true;
+
+	cpumask_shift_left(&thd_mask, &threads_core_mask,
+			cpu_core_index_of_thread(thread) * threads_per_core);
+
+	return !cpumask_intersects(&thd_mask, cpu_online_mask);
+}
+
 static void __cpuinit smp_85xx_mach_cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -191,8 +209,11 @@ static void __cpuinit smp_85xx_mach_cpu_die(void)
 
 	mtspr(SPRN_TCR, 0);
 
-	__flush_disable_L1();
-	disable_backside_L2_cache();
+	if (is_core_down(cpu))
+		__flush_disable_L1();
+
+	if (cur_cpu_spec->l2cache_type == PPC_L2_CACHE_CORE)
+		disable_backside_L2_cache();
 
 	generic_set_cpu_dead(cpu);
 
@@ -203,9 +224,16 @@ void platform_cpu_die(unsigned int cpu)
 {
 	unsigned int hw_cpu = get_hard_smp_processor_id(cpu);
 	struct ccsr_rcpm __iomem *rcpm = guts_regs;
-
-	/* Core Nap Operation */
-	setbits32(&rcpm->cnapcr, 1 << hw_cpu);
+	struct ccsr_rcpm_v2 __iomem *rcpm_v2 = guts_regs;
+
+	if (rcpmv2 && is_core_down(cpu)) {
+		/* enter PH20 status */
+		setbits32(&rcpm_v2->pcph20setr,
+			1 << cpu_core_index_of_thread(hw_cpu));
+	} else if (!rcpmv2) {
+		/* Core Nap Operation */
+		setbits32(&rcpm->cnapcr, 1 << hw_cpu);
+	}
 }
 #else
 /* for e500v1 and e500v2 */
-- 
1.7.3
