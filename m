Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Fri, 5 Mar 2010 15:43:41 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100305204341.18424.17797.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
References: <20100305204255.18424.85295.sendpatchset@norville.austin.ibm.com>
Subject: [PATCH 08/13] powerpc/476: define specific cpu table entry DD1.1 core
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/476: define specific cpu table entry DD1.1 core

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

There are still some unstable bits in the DD1.1 cores.  Don't use
the FPU or the tlbivax operation.  Define CPU_FTR_476_DD1_1 for additional
workarounds in later patches.

The DD1 core requires an additional workaround that will be addressed
in a separate patch, which may not need to be picked up into the
mainline kernel.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/cputable.h |    1 +
 arch/powerpc/kernel/cputable.c      |   26 ++++++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)


diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 9fff628..7c5d490 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -153,6 +153,7 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_NAP_DISABLE_L2_PR	ASM_CONST(0x0000000000002000)
 #define CPU_FTR_DUAL_PLL_750FX		ASM_CONST(0x0000000000004000)
 #define CPU_FTR_NO_DPM			ASM_CONST(0x0000000000008000)
+#define CPU_FTR_476_DD1_1		ASM_CONST(0x0000000000010000)
 #define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
 #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
 #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index a06e6d3..cb9e6b7 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1701,15 +1701,15 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
-	{ /* 476 core */
+	{ /* 476 DD1.1 core */
 		.pvr_mask		= 0xffff0000,
-		.pvr_value		= 0x11a50000,
+		.pvr_value		= 0x11a52040,
 		.cpu_name		= "476",
-		.cpu_features		= CPU_FTRS_47X,
-		.cpu_user_features	= COMMON_USER_BOOKE |
-			PPC_FEATURE_HAS_FPU,
+		.cpu_features		= CPU_FTRS_47X | CPU_FTR_476_DD1_1 |
+			CPU_FTR_FPU_UNAVAILABLE,
+		.cpu_user_features	= COMMON_USER_BOOKE,
 		.mmu_features		= MMU_FTR_TYPE_47x |
-			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
+			MMU_FTR_LOCK_BCAST_INVAL,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_47x,
@@ -1724,6 +1724,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
 			PPC_FEATURE_HAS_FPU,
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.mmu_features		= MMU_FTR_TYPE_47x |
+			MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 128,
+		.machine_check		= machine_check_47x,
+		.platform		= "ppc470",
+	},
+	{ /* 476 others */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x11a52000,
+		.cpu_name		= "476",
+		.cpu_features		= CPU_FTRS_47X,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+			PPC_FEATURE_HAS_FPU,
+		.mmu_features		= MMU_FTR_TYPE_47x |
 			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 128,

-- 
Dave Kleikamp
IBM Linux Technology Center
