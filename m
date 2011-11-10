Return-Path: <Kyle.D.Moffett@boeing.com>
Received: from border.exmeritus.com (border.exmeritus.com
 [IPv6:2002:46a7:f11a:ffff::])
 by ozlabs.org (Postfix) with ESMTP id 3498C1011CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2011 11:08:47 +1100 (EST)
From: Kyle Moffett <Kyle.D.Moffett@boeing.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 07/17] powerpc/e200: Rename CONFIG_E200 => CONFIG_FSL_E200
Date: Wed,  9 Nov 2011 19:07:05 -0500
Message-Id: <1320883635-17194-8-git-send-email-Kyle.D.Moffett@boeing.com>
In-Reply-To: <4E42AB6F.1050900@freescale.com>
References: <4E42AB6F.1050900@freescale.com>
Cc: Alexander Graf <agraf@suse.de>, Baruch Siach <baruch@tkos.co.il>,
 Lucas De Marchi <lucas.demarchi@profusion.mobi>,
 Timur Tabi <B04825@freescale.com>, linux-kernel@vger.kernel.org,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Kyle Moffett <Kyle.D.Moffett@boeing.com>,
 Scott Wood <scottwood@freescale.com>, Paul Bolle <pebolle@tiscali.nl>,
 Sonny Rao <sonnyrao@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Match the config symbols for FreeScale e500/e5500 chips by using "FSL"
in the name of the config symbol.

Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>
---
 arch/powerpc/Kconfig                   |    2 +-
 arch/powerpc/Makefile                  |    2 +-
 arch/powerpc/include/asm/cputable.h    |    2 +-
 arch/powerpc/include/asm/reg.h         |    2 +-
 arch/powerpc/include/asm/reg_booke.h   |    2 +-
 arch/powerpc/kernel/cputable.c         |    4 ++--
 arch/powerpc/kernel/head_fsl_booke.S   |   10 +++++-----
 arch/powerpc/kernel/traps.c            |    2 +-
 arch/powerpc/platforms/Kconfig.cputype |   12 ++++--------
 9 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 27e31c5..e3412a1 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -288,7 +288,7 @@ config HUGETLB_PAGE_SIZE_VARIABLE
 
 config MATH_EMULATION
 	bool "Math emulation"
-	depends on 4xx || 8xx || E200 || PPC_MPC832x || E500
+	depends on 4xx || 8xx || FSL_E200 || PPC_MPC832x || E500
 	---help---
 	  Some PowerPC chips designed for embedded applications do not have
 	  a floating-point unit and therefore do not implement the
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 57af16e..c17bc29 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -134,7 +134,7 @@ cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
 cpu-as-$(CONFIG_6xx)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_POWER4)		+= -Wa,-maltivec
 cpu-as-$(CONFIG_E500)		+= -Wa,-me500
-cpu-as-$(CONFIG_E200)		+= -Wa,-me200
+cpu-as-$(CONFIG_FSL_E200)	+= -Wa,-me200
 
 KBUILD_AFLAGS += $(cpu-as-y)
 KBUILD_CFLAGS += $(cpu-as-y)
diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index e30442c..b69f255 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -522,7 +522,7 @@ enum {
 #ifdef CONFIG_44x
 	    CPU_FTRS_44X & CPU_FTRS_440x6 &
 #endif
-#ifdef CONFIG_E200
+#ifdef CONFIG_FSL_E200
 	    CPU_FTRS_E200 &
 #endif
 #ifdef CONFIG_E500
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 559da19..f5b4f457 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -893,7 +893,7 @@
 #define SPRN_SPRG_WSCRATCH_MC	SPRN_SPRG1
 #define SPRN_SPRG_RSCRATCH4	SPRN_SPRG7R
 #define SPRN_SPRG_WSCRATCH4	SPRN_SPRG7W
-#ifdef CONFIG_E200
+#ifdef CONFIG_FSL_E200
 #define SPRN_SPRG_RSCRATCH_DBG	SPRN_SPRG6R
 #define SPRN_SPRG_WSCRATCH_DBG	SPRN_SPRG6W
 #else
diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
index 28cdbd9..81cd987 100644
--- a/arch/powerpc/include/asm/reg_booke.h
+++ b/arch/powerpc/include/asm/reg_booke.h
@@ -237,7 +237,7 @@
 #define MCSR_BSL2_ERR	0x00000001UL /* Backside L2 cache error */
 #endif
 
-#ifdef CONFIG_E200
+#ifdef CONFIG_FSL_E200
 #define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
 #define MCSR_CP_PERR 	0x20000000UL /* Cache Push Parity Error */
 #define MCSR_CPERR 	0x10000000UL /* Cache Parity Error */
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index e35f4fb..e5b142c 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1871,7 +1871,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "ppc440",
 	}
 #endif /* CONFIG_44x */
-#ifdef CONFIG_E200
+#ifdef CONFIG_FSL_E200
 	{	/* e200z5 */
 		.pvr_mask		= 0xfff00000,
 		.pvr_value		= 0x81000000,
@@ -1915,7 +1915,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
 	}
-#endif /* CONFIG_E200 */
+#endif /* CONFIG_FSL_E200 */
 #endif /* CONFIG_PPC32 */
 #ifdef CONFIG_E500
 #ifdef CONFIG_PPC32
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 9f5d210..134b2b8 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -137,7 +137,7 @@ _ENTRY(__early_start)
 
 	/* Setup the defaults for TLB entries */
 	li	r2,(MAS4_TSIZED(BOOK3E_PAGESZ_4K))@l
-#ifdef CONFIG_E200
+#ifdef CONFIG_FSL_E200
 	oris	r2,r2,MAS4_TLBSELD(1)@h
 #endif
 	mtspr	SPRN_MAS4, r2
@@ -304,7 +304,7 @@ interrupt_base:
 	CRITICAL_EXCEPTION(0x0100, CriticalInput, unknown_exception)
 
 	/* Machine Check Interrupt */
-#ifdef CONFIG_E200
+#ifdef CONFIG_FSL_E200
 	/* no RFMCI, MCSRRs on E200 */
 	CRITICAL_EXCEPTION(0x0200, MachineCheck, machine_check_exception)
 #else
@@ -340,7 +340,7 @@ interrupt_base:
 #ifdef CONFIG_PPC_FPU
 	FP_UNAVAILABLE_EXCEPTION
 #else
-#ifdef CONFIG_E200
+#ifdef CONFIG_FSL_E200
 	/* E200 treats 'normal' floating point instructions as FP Unavail exception */
 	EXCEPTION(0x0800, FloatingPointUnavailable, program_check_exception, EXC_XFER_EE)
 #else
@@ -694,7 +694,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 #endif
 3:	mtspr	SPRN_MAS2, r12
 
-#ifdef CONFIG_E200
+#ifdef CONFIG_FSL_E200
 	/* Round robin TLB1 entries assignment */
 	mfspr	r12, SPRN_MAS0
 
@@ -717,7 +717,7 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_BIG_PHYS)
 	rlwimi	r12, r13, 0, 20, 31
 7:
 	mtspr	SPRN_MAS0,r12
-#endif /* CONFIG_E200 */
+#endif /* CONFIG_FSL_E200 */
 
 tlb_write_entry:
 	tlbwe
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index e3113341..81b6afd 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -560,7 +560,7 @@ int machine_check_e500(struct pt_regs *regs)
 	return 0;
 }
 #endif
-#ifdef CONFIG_E200
+#ifdef CONFIG_FSL_E200
 int machine_check_e200(struct pt_regs *regs)
 {
 	unsigned long reason = get_mc_reason(regs);
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 1108586..9770564 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -28,7 +28,6 @@ config PPC_BOOK3S_32
 
 config FSL_E200
 	bool "Freescale e200 (also known as MPC5xx/MPC55xx)"
-	select E200
 
 config FSL_E500_V1_V2
 	bool "Freescale e500v1/e500v2 (also known as MPC85xx)"
@@ -141,9 +140,6 @@ config TUNE_CELL
 config 8xx
 	bool
 
-config E200
-	bool
-
 config PPC_85xx
 	bool
 
@@ -186,12 +182,12 @@ config 4xx
 
 config BOOKE
 	bool
-	depends on E200 || E500 || 44x || PPC_BOOK3E
+	depends on FSL_E200 || E500 || 44x || PPC_BOOK3E
 	default y
 
 config FSL_BOOKE
 	bool
-	depends on (E200 || E500) && PPC32
+	depends on FSL_E200 || (E500 && PPC32)
 	select SYS_SUPPORTS_HUGETLBFS if PHYS_64BIT
 	default y
 
@@ -284,7 +280,7 @@ config PPC_ICSWX
 
 config SPE
 	bool "SPE Support"
-	depends on E200 || (E500 && !PPC_E500MC)
+	depends on FSL_E200 || (E500 && !PPC_E500MC)
 	default y
 	---help---
 	  This option enables kernel support for the Signal Processing
@@ -375,7 +371,7 @@ config NR_CPUS
 
 config NOT_COHERENT_CACHE
 	bool
-	depends on 4xx || 8xx || E200 || PPC_MPC512x || GAMECUBE_COMMON
+	depends on 4xx || 8xx || FSL_E200 || PPC_MPC512x || GAMECUBE_COMMON
 	default n if PPC_47x
 	default y
 
-- 
1.7.2.5
