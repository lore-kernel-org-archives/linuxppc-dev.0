Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 03/20] powerpc: Add a cpu feature CPU_FTR_PMAO_BUG
Date: Fri, 14 Mar 2014 16:00:28 +1100
Message-Id: <1394773245-18328-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
References: <1394773245-18328-1-git-send-email-mpe@ellerman.id.au>
Cc: cody@linux.vnet.ibm.com, khandual@linux.vnet.ibm.com
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

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h | 6 ++++--
 arch/powerpc/kernel/cputable.c      | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 617cc76..bc23477 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -189,6 +189,7 @@ extern const char *powerpc_base_platform;
 #define	CPU_FTR_HAS_PPR			LONG_ASM_CONST(0x0200000000000000)
 #define CPU_FTR_DAWR			LONG_ASM_CONST(0x0400000000000000)
 #define CPU_FTR_DABRX			LONG_ASM_CONST(0x0800000000000000)
+#define CPU_FTR_PMAO_BUG		LONG_ASM_CONST(0x1000000000000000)
 
 #ifndef __ASSEMBLY__
 
@@ -445,6 +446,7 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE | CPU_FTR_VMX_COPY | \
 	    CPU_FTR_DBELL | CPU_FTR_HAS_PPR | CPU_FTR_DAWR | \
 	    CPU_FTR_ARCH_207S | CPU_FTR_TM_COMP)
+#define CPU_FTRS_POWER8E (CPU_FTRS_POWER8 | CPU_FTR_PMAO_BUG)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -466,8 +468,8 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
-	    CPU_FTRS_POWER7 | CPU_FTRS_POWER8 | CPU_FTRS_CELL |		\
-	    CPU_FTRS_PA6T | CPU_FTR_VSX)
+	    CPU_FTRS_POWER7 | CPU_FTRS_POWER8E | CPU_FTRS_POWER8 |	\
+	    CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_VSX)
 #endif
 #else
 enum {
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 6c8dd5d..c1faade 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -510,7 +510,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x004b0000,
 		.cpu_name		= "POWER8E (raw)",
-		.cpu_features		= CPU_FTRS_POWER8,
+		.cpu_features		= CPU_FTRS_POWER8E,
 		.cpu_user_features	= COMMON_USER_POWER8,
 		.cpu_user_features2	= COMMON_USER2_POWER8,
 		.mmu_features		= MMU_FTRS_POWER8,
-- 
1.8.3.2
