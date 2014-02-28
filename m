Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/2] powerpc: Add a cpu feature CPU_FTR_PMAO_BUG
Date: Fri, 28 Feb 2014 17:29:05 +1100
Message-Id: <1393568946-4136-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some power8 revisions have a hardware bug where we can lose a
Performance Monitor (PMU) exception under certain circumstances.

We will be adding a workaround for this case, see the next commit for
details. The observed behaviour is that writing PMAO doesn't cause an
exception as we would expect, hence the name of the feature.

This commit just adds a CPU feature bit. We set it on all power8 cpus,
and then clear it at cpu setup time if we are on a revision where the
bug is fixed.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h   |  3 ++-
 arch/powerpc/kernel/cpu_setup_power.S | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 617cc76..56d3166 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -189,6 +189,7 @@ extern const char *powerpc_base_platform;
 #define	CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x0200000000000000)
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
+#define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -444,7 +445,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
-	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
+	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP | CPU_FTR_PMAO_BUG)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
index 37d1bb0..cb2da74 100644
--- a/arch/powerpc/kernel/cpu_setup_power.S
+++ b/arch/powerpc/kernel/cpu_setup_power.S
@@ -179,4 +179,19 @@ __init_PMU:
 	mtspr	SPRN_MMCR0,r5
 	mtspr	SPRN_MMCR1,r5
 	mtspr	SPRN_MMCR2,r5
+
+	/* Compare our PVR to POWER8 DD2 (0x4d0200) */
+	mfpvr	r5
+	lis	r6,0x4d
+	ori	r6,r6,0x0200
+	cmplw	r5,r6
+
+	/* If we are older then return */
+	bltlr
+
+	/* Otherwise clear CPU_FTR_PMAO_BUG */
+	ld	r5,CPU_SPEC_FEATURES(r4)
+	LOAD_REG_IMMEDIATE(r6,CPU_FTR_PMAO_BUG)
+	xor	r5,r5,r6
+	std	r5,CPU_SPEC_FEATURES(r4)
 	blr
-- 
1.8.3.2
