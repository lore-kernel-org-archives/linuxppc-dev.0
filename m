Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7E33B7105
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Oct 2010 06:07:11 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o98J77fC005892
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Oct 2010 14:07:07 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 07/11] powerpc/fsl-booke: Add support for FSL 64-bit e5500 core
Date: Fri,  8 Oct 2010 14:06:49 -0500
Message-Id: <1286564813-21209-7-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1286564813-21209-6-git-send-email-galak@kernel.crashing.org>
References: <1286564813-21209-1-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-2-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-3-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-4-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-5-git-send-email-galak@kernel.crashing.org>
	<1286564813-21209-6-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/include/asm/cache.h          |    2 +-
 arch/powerpc/include/asm/reg_booke.h      |    3 ++-
 arch/powerpc/kernel/Makefile              |    1 +
 arch/powerpc/kernel/cpu_setup_fsl_booke.S |   15 +++++++++++++++
 arch/powerpc/kernel/cputable.c            |   26 +++++++++++++++++++++++++-
 arch/powerpc/kernel/traps.c               |    8 +++++++-
 arch/powerpc/platforms/85xx/Kconfig       |    4 ++++
 arch/powerpc/platforms/Kconfig.cputype    |   22 ++++++++++++++++------
 8 files changed, 71 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 4b50941..2a3d94a 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -8,7 +8,7 @@
 #if defined(CONFIG_8xx) || defined(CONFIG_403GCX)
 #define L1_CACHE_SHIFT		4
 #define MAX_COPY_PREFETCH	1
-#elif defined(CONFIG_PPC_E500MC)
+#elif defined(CONFIG_PPC_E500MC) || defined(CONFIG_PPC_E5500)
 #define L1_CACHE_SHIFT		6
 #define MAX_COPY_PREFETCH	4
 #elif defined(CONFIG_PPC32)
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 667a498..5e7ab0c 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -203,7 +203,8 @@
 #define PPC47x_MCSR_FPR	0x00800000 /* FPR parity error */
 #define PPC47x_MCSR_IPR	0x00400000 /* Imprecise Machine Check Exception */
 
-#ifdef CONFIG_E500
+#if defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC) \
+	|| defined(CONFIG_PPC_BOOK3E_64)
 /* All e500 */
 #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
 #define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 1dda701..ac4aadf 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o \
 				   paca.o nvram_64.o firmware.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
+obj-$(CONFIG_PPC_BOOK3E_64)	+= cpu_setup_fsl_booke.o
 obj64-$(CONFIG_RELOCATABLE)	+= reloc_64.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
 obj-$(CONFIG_PPC64)		+= vdso64/
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
index 1f9123f..f93a061 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -66,6 +66,10 @@ extern void __restore_cpu_ppc970(void);
 extern void __setup_cpu_power7(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power7(void);
 #endif /* CONFIG_PPC64 */
+#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_E500)
+extern void __setup_cpu_e5500(unsigned long offset, struct cpu_spec* spec);
+extern void __restore_cpu_e5500(void);
+#endif /* CONFIG_PPC_BOOK3E_64 || CONFIG_E500 */
 
 /* This table only contains "desktop" CPUs, it need to be filled with embedded
  * ones as well...
@@ -1891,6 +1895,27 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "ppc5554",
 	}
 #endif /* CONFIG_E200 */
+#endif /* CONFIG_PPC32 */
+#if defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_E500)
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
+#endif
 #ifdef CONFIG_E500
 	{	/* e500 */
 		.pvr_mask		= 0xffff0000,
@@ -1961,7 +1986,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "powerpc",
 	}
 #endif /* CONFIG_E500 */
-#endif /* CONFIG_PPC32 */
 
 #ifdef CONFIG_PPC_BOOK3E_64
 	{	/* This is a default entry to get going, to be replaced by
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index a45a63c..e0e7184 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -418,7 +418,8 @@ int machine_check_47x(struct pt_regs *regs)
 
 	return 0;
 }
-#elif defined(CONFIG_E500)
+#elif defined(CONFIG_E500) || defined(CONFIG_PPC_E500MC) \
+	|| defined(CONFIG_PPC_BOOK3E_64)
 int machine_check_e500mc(struct pt_regs *regs)
 {
 	unsigned long mcsr = mfspr(SPRN_MCSR);
@@ -538,6 +539,11 @@ int machine_check_e500(struct pt_regs *regs)
 
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
index 5bde1f2..ae25527 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -11,6 +11,8 @@ menuconfig FSL_SOC_BOOKE
 
 if FSL_SOC_BOOKE
 
+if PPC32
+
 config MPC8540_ADS
 	bool "Freescale MPC8540 ADS"
 	select DEFAULT_UIMAGE
@@ -177,6 +179,8 @@ config P4080_DS
 	help
 	  This option enables support for the P4080 DS board
 
+endif # PPC32
+
 endif # FSL_SOC_BOOKE
 
 config TQM85xx
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index d361f81..19083b3 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -132,13 +132,18 @@ config PPC_E500MC
 	select PPC_FPU
 	depends on E500
 
+config PPC_E5500
+	bool
+	select PPC_FPU
+	select PPC_E500MC if PPC32
+
 config PPC_FPU
 	bool
 	default y if PPC64
 
 config FSL_EMB_PERFMON
 	bool "Freescale Embedded Perfmon"
-	depends on E500 || PPC_83xx
+	depends on E500 || PPC_E5500 || PPC_83xx
 	help
 	  This is the Performance Monitor support found on the e500 core
 	  and some e300 cores (c3 and c4).  Select this only if your
@@ -151,7 +156,7 @@ config FSL_EMB_PERF_EVENT
 
 config FSL_EMB_PERF_EVENT_E500
 	bool
-	depends on FSL_EMB_PERF_EVENT && E500
+	depends on FSL_EMB_PERF_EVENT && (E500 || PPC_E5500)
 	default y
 
 config 4xx
@@ -161,7 +166,7 @@ config 4xx
 
 config BOOKE
 	bool
-	depends on E200 || E500 || 44x || PPC_BOOK3E
+	depends on E200 || E500 || PPC_E5500 || 44x || PPC_BOOK3E
 	default y
 
 config FSL_BOOKE
@@ -169,15 +174,20 @@ config FSL_BOOKE
 	depends on E200 || E500
 	default y
 
+# this is for common code between PPC32 & PPC64 FSL BOOKE
+config PPC_FSL_BOOK3E
+	bool
+	select FSL_EMB_PERFMON
+	default y if FSL_BOOKE
 
 config PTE_64BIT
 	bool
-	depends on 44x || E500 || PPC_86xx
+	depends on 44x || E500 || PPC_E5500 || PPC_86xx
 	default y if PHYS_64BIT
 
 config PHYS_64BIT
-	bool 'Large physical address support' if E500 || PPC_86xx
-	depends on (44x || E500 || PPC_86xx) && !PPC_83xx && !PPC_82xx
+	bool 'Large physical address support' if E500 || PPC_E5500 || PPC_86xx
+	depends on (44x || E500 || PPC_E5500 || PPC_86xx) && !PPC_83xx && !PPC_82xx
 	---help---
 	  This option enables kernel support for larger than 32-bit physical
 	  addresses.  This feature may not be available on all cores.
-- 
1.7.2.3
