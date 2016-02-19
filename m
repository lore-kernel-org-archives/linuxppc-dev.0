Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 306DC1A0634
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Feb 2016 11:16:30 +1100 (AEDT)
From: Michael Neuling <mikey@neuling.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>
Subject: [PATCH v2 3/3] powerpc: Add POWER9 cputable entry
Date: Fri, 19 Feb 2016 11:16:24 +1100
Message-Id: <1455840984-24068-4-git-send-email-mikey@neuling.org>
In-Reply-To: <1455840984-24068-1-git-send-email-mikey@neuling.org>
References: <1455840984-24068-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a cputable entry for POWER9.  More code is required to actually
boot and run on a POWER9 but this gets the base piece in which we can
start building on.

Copies over from POWER8 except for:
- Adds a new CPU_FTR_ARCH_300 bit to start hanging new architecture
   features from (in subsequent patches).
- Advertises new user features bits PPC_FEATURE2_ARCH_3_00 &
  HAS_IEEE128 when on POWER9.
- Drops CPU_FTR_SUBCORE.
- Drops PMU code and machine check.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/cputable.h   | 17 +++++++++++---
 arch/powerpc/include/asm/mmu-hash64.h |  1 +
 arch/powerpc/include/asm/mmu.h        |  1 +
 arch/powerpc/kernel/cpu_setup_power.S | 44 +++++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c        | 27 +++++++++++++++++++++
 arch/powerpc/kernel/mce_power.c       | 17 +++++++-------
 6 files changed, 95 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index a47e175..94ace9b 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -171,7 +171,7 @@ enum {
 #define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000200000000)
 #define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000400000000)
 #define CPU_FTR_ARCH_207S		LONG_ASM_CONST(0x0000000800000000)
-/* Free					LONG_ASM_CONST(0x0000001000000000) */
+#define CPU_FTR_ARCH_300		LONG_ASM_CONST(0x0000001000000000)
 #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000002000000000)
 #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000004000000000)
 #define CPU_FTR_SMT			LONG_ASM_CONST(0x0000008000000000)
@@ -447,6 +447,16 @@ enum {
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_SUBCORE)
 #define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
 #define CPU_FTRS_POWER8_DD1 (CPU_FTRS_POWER8 & ~CPU_FTR_DBELL)
+#define CPU_FTRS_POWER9 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
+	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
+	    CPU_FTR_COHERENT_ICACHE | \
+	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
+	    CPU_FTR_DSCR | CPU_FTR_SAO  | \
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
+	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
+	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_ARCH_300)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -465,7 +475,7 @@ enum {
 	    (CPU_FTRS_POWER4 | CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | \
 	     CPU_FTRS_POWER6 | CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | \
 	     CPU_FTRS_POWER8 | CPU_FTRS_POWER8_DD1 | CPU_FTRS_CELL | \
-	     CPU_FTRS_PA6T | CPU_FTR_VSX)
+	     CPU_FTRS_PA6T | CPU_FTR_VSX | CPU_FTRS_POWER9)
 #endif
 #else
 enum {
@@ -516,7 +526,8 @@ enum {
 	    (CPU_FTRS_POWER4 & CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & \
 	     CPU_FTRS_POWER6 & CPU_FTRS_POWER7 & CPU_FTRS_CELL & \
 	     CPU_FTRS_PA6T & CPU_FTRS_POWER8 & CPU_FTRS_POWER8E & \
-	     CPU_FTRS_POWER8_DD1 & ~CPU_FTR_HVMODE & CPU_FTRS_POSSIBLE)
+	     CPU_FTRS_POWER8_DD1 & ~CPU_FTR_HVMODE & CPU_FTRS_POSSIBLE & \
+	     CPU_FTRS_POWER9)
 #endif
 #else
 enum {
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index 7352d3f..e36dc90 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -114,6 +114,7 @@
 
 #define POWER7_TLB_SETS		128	/* # sets in POWER7 TLB */
 #define POWER8_TLB_SETS		512	/* # sets in POWER8 TLB */
+#define POWER9_TLB_SETS_HASH	256	/* # sets in POWER9 TLB Hash mode */
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 3d5abfe..54d4650 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -97,6 +97,7 @@
 #define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_POWER8		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
+#define MMU_FTRS_POWER9		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
 				MMU_FTR_CI_LARGE_PAGE
 #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index cb3e272..5932219 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -84,6 +84,39 @@ _GLOBAL(__restore_cpu_power8)
 	mtlr	r11
 	blr
 
+_GLOBAL(__setup_cpu_power9)
+	mflr	r11
+	bl	__init_FSCR
+	bl	__init_hvmode_206
+	mtlr	r11
+	beqlr
+	li	r0,0
+	mtspr	SPRN_LPID,r0
+	mfspr	r3,SPRN_LPCR
+	ori	r3, r3, LPCR_PECEDH
+	bl	__init_LPCR
+	bl	__init_HFSCR
+	bl	__init_tlb_power9
+	mtlr	r11
+	blr
+
+_GLOBAL(__restore_cpu_power9)
+	mflr	r11
+	bl	__init_FSCR
+	mfmsr	r3
+	rldicl.	r0,r3,4,63
+	mtlr	r11
+	beqlr
+	li	r0,0
+	mtspr	SPRN_LPID,r0
+	mfspr   r3,SPRN_LPCR
+	ori	r3, r3, LPCR_PECEDH
+	bl	__init_LPCR
+	bl	__init_HFSCR
+	bl	__init_tlb_power9
+	mtlr	r11
+	blr
+
 __init_hvmode_206:
 	/* Disable CPU_FTR_HVMODE and exit if MSR:HV is not set */
 	mfmsr	r3
@@ -161,6 +194,17 @@ __init_tlb_power8:
 	ptesync
 1:	blr
 
+__init_tlb_power9:
+	li	r6,POWER9_TLB_SETS_HASH
+	mtctr	r6
+	li	r7,0xc00	/* IS field = 0b11 */
+	ptesync
+2:	tlbiel	r7
+	addi	r7,r7,0x1000
+	bdnz	2b
+	ptesync
+1:	blr
+
 __init_PMU_HV:
 	li	r5,0
 	mtspr	SPRN_MMCRC,r5
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 7d80bfd..be4d730 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -70,9 +70,12 @@ extern void __setup_cpu_power7(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power7(void);
 extern void __setup_cpu_power8(unsigned long offset, struct cpu_spec* spec);
 extern void __restore_cpu_power8(void);
+extern void __setup_cpu_power9(unsigned long offset, struct cpu_spec* spec);
+extern void __restore_cpu_power9(void);
 extern void __restore_cpu_a2(void);
 extern void __flush_tlb_power7(unsigned int action);
 extern void __flush_tlb_power8(unsigned int action);
+extern void __flush_tlb_power9(unsigned int action);
 extern long __machine_check_early_realmode_p7(struct pt_regs *regs);
 extern long __machine_check_early_realmode_p8(struct pt_regs *regs);
 #endif /* CONFIG_PPC64 */
@@ -116,6 +119,11 @@ extern void __restore_cpu_e6500(void);
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
+#define COMMON_USER_POWER9	COMMON_USER_POWER8
+#define COMMON_USER2_POWER9	(COMMON_USER2_POWER8 | \
+				 PPC_FEATURE2_ARCH_3_00 | \
+				 PPC_FEATURE2_HAS_IEEE128)
+
 #ifdef CONFIG_PPC_BOOK3E_64
 #define COMMON_USER_BOOKE	(COMMON_USER_PPC64 | PPC_FEATURE_BOOKE)
 #else
@@ -499,6 +507,25 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check_early	= __machine_check_early_realmode_p8,
 		.platform		= "power8",
 	},
+	{	/* Power9 */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x004e0000,
+		.cpu_name		= "POWER9 (raw)",
+		.cpu_features		= CPU_FTRS_POWER9,
+		.cpu_user_features	= COMMON_USER_POWER9,
+		.cpu_user_features2	= COMMON_USER2_POWER9,
+		.mmu_features		= MMU_FTRS_POWER9,
+		.icache_bsize		= 128,
+		.dcache_bsize		= 128,
+		.num_pmcs		= 6,
+		.pmc_type		= PPC_PMC_IBM,
+		.oprofile_cpu_type	= "ppc64/power9",
+		.oprofile_type		= PPC_OPROFILE_INVALID,
+		.cpu_setup		= __setup_cpu_power9,
+		.cpu_restore		= __restore_cpu_power9,
+		.flush_tlb		= __flush_tlb_power9,
+		.platform		= "power9",
+	},
 	{	/* Cell Broadband Engine */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00700000,
diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index 2c647b1..ee62b19 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -54,8 +54,8 @@ static void flush_tlb_206(unsigned int num_sets, unsigned int action)
 }
 
 /*
- * Generic routine to flush TLB on power7. This routine is used as
- * flush_tlb hook in cpu_spec for Power7 processor.
+ * Generic routines to flush TLB on POWER processors. These routines
+ * are used as flush_tlb hook in the cpu_spec.
  *
  * action => TLB_INVAL_SCOPE_GLOBAL:  Invalidate all TLBs.
  *	     TLB_INVAL_SCOPE_LPID: Invalidate TLB for current LPID.
@@ -65,18 +65,17 @@ void __flush_tlb_power7(unsigned int action)
 	flush_tlb_206(POWER7_TLB_SETS, action);
 }
 
-/*
- * Generic routine to flush TLB on power8. This routine is used as
- * flush_tlb hook in cpu_spec for power8 processor.
- *
- * action => TLB_INVAL_SCOPE_GLOBAL:  Invalidate all TLBs.
- *	     TLB_INVAL_SCOPE_LPID: Invalidate TLB for current LPID.
- */
 void __flush_tlb_power8(unsigned int action)
 {
 	flush_tlb_206(POWER8_TLB_SETS, action);
 }
 
+void __flush_tlb_power9(unsigned int action)
+{
+	flush_tlb_206(POWER9_TLB_SETS_HASH, action);
+}
+
+
 /* flush SLBs and reload */
 static void flush_and_reload_slb(void)
 {
-- 
2.5.0
