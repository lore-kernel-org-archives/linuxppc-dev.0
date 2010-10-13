Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7E6FCB70DD
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 09:02:19 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o9DM2ETt009808
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 17:02:14 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v4 1/5] powerpc/fsl-booke: Add support for FSL 64-bit e5500
	core
Date: Wed, 13 Oct 2010 17:02:12 -0500
Message-Id: <1287007333-4436-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new e5500 core is similar to the e500mc core but adds 64-bit
support.  We support running it in 32-bit mode as it is identical to the
e500mc.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* Further kconfig cleanup

 arch/powerpc/kernel/Makefile              |    4 +++-
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   15 +++++++++++++++
 arch/powerpc/kernel/cputable.c            |   28 +++++++++++++++++++++++++++-
 arch/powerpc/kernel/traps.c               |    5 +++++
 arch/powerpc/platforms/85xx/Kconfig       |    5 ++++-
 arch/powerpc/platforms/Kconfig.cputype    |    8 +++++++-
 6 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1dda701..4ed076a 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -55,7 +55,9 @@ obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_IBMEBUS)           += ibmebus.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
+ifeq ($(CONFIG_PPC32),y)
 obj-$(CONFIG_E500)		+= idle_e500.o
+endif
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o
@@ -67,7 +69,7 @@ endif
 obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
 obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
-obj-$(CONFIG_FSL_BOOKE)		+= cpu_setup_fsl_booke.o dbell.o
+obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o dbell.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= dbell.o
 
 extra-y				:= head_$(CONFIG_WORD_SIZE).o
diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 0adb50a..894e64f 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -51,6 +51,7 @@ _GLOBAL(__e500_dcache_setup)
 	isync
 	blr
 
+#ifdef CONFIG_PPC32
 _GLOBAL(__setup_cpu_e200)
 	/* enable dedicated debug exception handling resources (Debug APU) */
 	mfspr	r3,SPRN_HID0
@@ -72,3 +73,17 @@ _GLOBAL(__setup_cpu_e500mc)
 	bl	__setup_e500mc_ivors
 	mtlr	r4
 	blr
+#endif
+/* Right now, restore and setup are the same thing */
+_GLOBAL(__restore_cpu_e5500)
+_GLOBAL(__setup_cpu_e5500)
+	mflr	r4
+	bl	__e500_icache_setup
+	bl	__e500_dcache_setup
+#ifdef CONFIG_PPC_BOOK3E_64
+	bl	.__setup_base_ivors
+#else
+	bl	__setup_e500mc_ivors
+#endif
+	mtlr	r4
+	blr
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 1f9123f..cd55191 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -66,6 +66,10 @@ extern void __restore_cpu_ppc970(void);
 extern void __setup_cpu_power7(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power7(void);
 #endif /* CONFIG_PPC64 */
+#if defined(CONFIG_E500)
+extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
+extern void __restore_cpu_e5500(void);
+#endif /* CONFIG_E500 */
 
 /* This table only contains "desktop" CPUs, it need to be filled with embedded
  * ones as well...
@@ -1891,7 +1895,9 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "ppc5554",
 	}
 #endif /* CONFIG_E200 */
+#endif /* CONFIG_PPC32 */
 #ifdef CONFIG_E500
+#ifdef CONFIG_PPC32
 	{	/* e500 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80200000,
@@ -1946,6 +1952,26 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce500mc",
 	},
+#endif /* CONFIG_PPC32 */
+	{	/* e5500 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x80240000,
+		.cpu_name		= "e5500",
+		.cpu_features		= CPU_FTRS_E500MC,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
+			MMU_FTR_USE_TLBILX,
+		.icache_bsize		= 64,
+		.dcache_bsize		= 64,
+		.num_pmcs		= 4,
+		.oprofile_cpu_type	= "ppc/e500mc",
+		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
+		.cpu_setup		= __setup_cpu_e5500,
+		.cpu_restore		= __restore_cpu_e5500,
+		.machine_check		= machine_check_e500mc,
+		.platform		= "ppce5500",
+	},
+#ifdef CONFIG_PPC32
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
@@ -1960,8 +1986,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e500,
 		.platform		= "powerpc",
 	}
-#endif /* CONFIG_E500 */
 #endif /* CONFIG_PPC32 */
+#endif /* CONFIG_E500 */
 
 #ifdef CONFIG_PPC_BOOK3E_64
 	{	/* This is a default entry to get going, to be replaced by
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a45a63c..1b2cdc8 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -538,6 +538,11 @@ int machine_check_e500(struct pt_regs *regs)
 
 	return 0;
 }
+
+int machine_check_generic(struct pt_regs *regs)
+{
+	return 0;
+}
 #elif defined(CONFIG_E200)
 int machine_check_e200(struct pt_regs *regs)
 {
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 068a6e3..4bac9e0 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -11,6 +11,8 @@ menuconfig FSL_SOC_BOOKE
 
 if FSL_SOC_BOOKE
 
+if PPC32
+
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
 	select DEFAULT_UIMAGE
@@ -167,7 +169,6 @@ config P3041_DS
 config P4080_DS
 	bool "Freescale P4080 DS"
 	select DEFAULT_UIMAGE
-	select PPC_FSL_BOOK3E
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
@@ -176,6 +177,8 @@ config P4080_DS
 	help
 	  This option enables support for the P4080 DS board
 
+endif # PPC32
+
 endif # FSL_SOC_BOOKE
 
 config TQM85xx
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d361f81..111138c 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -125,6 +125,7 @@ config 8xx
 
 config E500
 	select FSL_EMB_PERFMON
+	select PPC_FSL_BOOK3E
 	bool
 
 config PPC_E500MC
@@ -166,9 +167,14 @@ config BOOKE
 
 config FSL_BOOKE
 	bool
-	depends on E200 || E500
+	depends on (E200 || E500) && PPC32
 	default y
 
+# this is for common code between PPC32 & PPC64 FSL BOOKE
+config PPC_FSL_BOOK3E
+	bool
+	select FSL_EMB_PERFMON
+	default y if FSL_BOOKE
 
 config PTE_64BIT
 	bool
-- 
1.7.2.3
