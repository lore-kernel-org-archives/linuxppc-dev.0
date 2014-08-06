Return-Path: <mihai.caraman@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0190.outbound.protection.outlook.com [207.46.163.190])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AE3A61A0367
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Aug 2014 18:52:40 +1000 (EST)
From: Mihai Caraman <mihai.caraman@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/booke: Restrict SPE exception handlers to
 e200/e500 cores
Date: Wed, 6 Aug 2014 11:39:17 +0300
Message-ID: <1407314358-17653-1-git-send-email-mihai.caraman@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, Mihai Caraman <mihai.caraman@freescale.com>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SPE exception handlers are now defined for 32-bit e500mc cores even though
SPE unit is not present and CONFIG_SPE is undefined.

Restrict SPE exception handlers to e200/e500 cores adding CONFIG_SPE_POSSIBLE
and consequently guard __stup_ivors and __setup_cpu functions.

Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/kernel/cpu_setup_fsl_booke.S | 12 +++++++++++-
 arch/powerpc/kernel/cputable.c            |  5 +++++
 arch/powerpc/kernel/head_fsl_booke.S      | 18 +++++++++++++-----
 arch/powerpc/platforms/Kconfig.cputype    |  6 +++++-
 4 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kernel/cpu_setup_fsl_booke.S b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
index 4f1393d..44bb2c9 100644
--- a/arch/powerpc/kernel/cpu_setup_fsl_booke.S
+++ b/arch/powerpc/kernel/cpu_setup_fsl_booke.S
@@ -91,6 +91,7 @@ _GLOBAL(setup_altivec_idle)
 
 	blr
 
+#if defined(CONFIG_E500) && defined(CONFIG_PPC_E500MC)
 _GLOBAL(__setup_cpu_e6500)
 	mflr	r6
 #ifdef CONFIG_PPC64
@@ -107,14 +108,20 @@ _GLOBAL(__setup_cpu_e6500)
 	bl	__setup_cpu_e5500
 	mtlr	r6
 	blr
+#endif /* CONFIG_E500 && CONFIG_PPC_E500MC */
 
 #ifdef CONFIG_PPC32
+#ifdef CONFIG_E200
 _GLOBAL(__setup_cpu_e200)
 	/* enable dedicated debug exception handling resources (Debug APU) */
 	mfspr	r3,SPRN_HID0
 	ori	r3,r3,HID0_DAPUEN@l
 	mtspr	SPRN_HID0,r3
 	b	__setup_e200_ivors
+#endif /* CONFIG_E200 */
+
+#ifdef CONFIG_E500
+#ifndef CONFIG_PPC_E500MC
 _GLOBAL(__setup_cpu_e500v1)
 _GLOBAL(__setup_cpu_e500v2)
 	mflr	r4
@@ -129,6 +136,7 @@ _GLOBAL(__setup_cpu_e500v2)
 #endif
 	mtlr	r4
 	blr
+#else /* CONFIG_PPC_E500MC */
 _GLOBAL(__setup_cpu_e500mc)
 _GLOBAL(__setup_cpu_e5500)
 	mflr	r5
@@ -159,7 +167,9 @@ _GLOBAL(__setup_cpu_e5500)
 2:
 	mtlr	r5
 	blr
-#endif
+#endif /* CONFIG_PPC_E500MC */
+#endif /* CONFIG_E500 */
+#endif /* CONFIG_PPC32 */
 
 #ifdef CONFIG_PPC_BOOK3E_64
 _GLOBAL(__restore_cpu_e6500)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 965291b..c98719f 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2031,6 +2031,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_E500
 #ifdef CONFIG_PPC32
+#ifndef CONFIG_PPC_E500MC
 	{	/* e500 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80200000,
@@ -2070,6 +2071,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
 	},
+#else
 	{	/* e500mc */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80230000,
@@ -2088,7 +2090,9 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce500mc",
 	},
+#endif /* CONFIG_PPC_E500MC */
 #endif /* CONFIG_PPC32 */
+#ifdef CONFIG_PPC_E500MC
 	{	/* e5500 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80240000,
@@ -2132,6 +2136,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e500mc,
 		.platform		= "ppce6500",
 	},
+#endif /* CONFIG_PPC_E500MC */
 #ifdef CONFIG_PPC32
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index b497188..4f8930f 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -613,6 +613,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	mfspr	r10, SPRN_SPRG_RSCRATCH0
 	b	InstructionStorage
 
+/* Define SPE handlers for e200 and e500v2 */
 #ifdef CONFIG_SPE
 	/* SPE Unavailable */
 	START_EXCEPTION(SPEUnavailable)
@@ -622,10 +623,10 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	b	fast_exception_return
 1:	addi	r3,r1,STACK_FRAME_OVERHEAD
 	EXC_XFER_EE_LITE(0x2010, KernelSPE)
-#else
+#elif CONFIG_SPE_POSSIBLE
 	EXCEPTION(0x2020, SPE_ALTIVEC_UNAVAIL, SPEUnavailable, \
 		  unknown_exception, EXC_XFER_EE)
-#endif /* CONFIG_SPE */
+#endif /* CONFIG_SPE_POSSIBLE */
 
 	/* SPE Floating Point Data */
 #ifdef CONFIG_SPE
@@ -635,12 +636,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	/* SPE Floating Point Round */
 	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
 		  SPEFloatingPointRoundException, EXC_XFER_EE)
-#else
+#elif CONFIG_SPE_POSSIBLE
 	EXCEPTION(0x2040, SPE_FP_DATA_ALTIVEC_ASSIST, SPEFloatingPointData,
 		  unknown_exception, EXC_XFER_EE)
 	EXCEPTION(0x2050, SPE_FP_ROUND, SPEFloatingPointRound, \
 		  unknown_exception, EXC_XFER_EE)
-#endif /* CONFIG_SPE */
+#endif /* CONFIG_SPE_POSSIBLE */
+
 
 	/* Performance Monitor */
 	EXCEPTION(0x2060, PERFORMANCE_MONITOR, PerformanceMonitor, \
@@ -947,6 +949,7 @@ get_phys_addr:
  * Global functions
  */
 
+#ifdef CONFIG_E200
 /* Adjust or setup IVORs for e200 */
 _GLOBAL(__setup_e200_ivors)
 	li	r3,DebugDebug@l
@@ -959,7 +962,10 @@ _GLOBAL(__setup_e200_ivors)
 	mtspr	SPRN_IVOR34,r3
 	sync
 	blr
+#endif
 
+#ifdef CONFIG_E500
+#ifndef CONFIG_PPC_E500MC
 /* Adjust or setup IVORs for e500v1/v2 */
 _GLOBAL(__setup_e500_ivors)
 	li	r3,DebugCrit@l
@@ -974,7 +980,7 @@ _GLOBAL(__setup_e500_ivors)
 	mtspr	SPRN_IVOR35,r3
 	sync
 	blr
-
+#else
 /* Adjust or setup IVORs for e500mc */
 _GLOBAL(__setup_e500mc_ivors)
 	li	r3,DebugDebug@l
@@ -1000,6 +1006,8 @@ _GLOBAL(__setup_ehv_ivors)
 	mtspr	SPRN_IVOR41,r3
 	sync
 	blr
+#endif /* CONFIG_PPC_E500MC */
+#endif /* CONFIG_E500 */
 
 #ifdef CONFIG_SPE
 /*
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a41bd02..bb81571 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -311,9 +311,13 @@ config PPC_ICSWX_USE_SIGILL
 
 	  If in doubt, say N here.
 
+config SPE_POSSIBLE
+	def_bool y
+	depends on E200 || (E500 && !PPC_E500MC)
+
 config SPE
 	bool "SPE Support"
-	depends on E200 || (E500 && !PPC_E500MC)
+	depends on SPE_POSSIBLE
 	default y
 	---help---
 	  This option enables kernel support for the Signal Processing
-- 
1.7.11.7
