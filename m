Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Mon, 1 Mar 2010 14:13:52 -0500
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20100301191351.20987.49730.sendpatchset@norville.austin.ibm.com>
In-Reply-To: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
References: <20100301191255.20987.84668.sendpatchset@norville.austin.ibm.com>
Subject: [RFC: PATCH 08/13] powerpc/476: define specific cpu table entry for
	DD1 and DD1.1 cores
Cc: Torez Smith <torez@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc/476: define specific cpu table entry for DD1 and DD1.1 cores

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

There are still some unstable bits on the DD1 and DD1.1 cores.  Don't use
the FPU or the tlbivax operation.  Define CPU_FTR_476_DD1 and
CPU_FTR_476_DD1_1 for additional workarounds in later patches.

The DD1 core requires workarounds triggered by both CPU_FTR_476_DD1
and CPU_FTR_476_DD1_1.  the DD1.1 core only needs CPU_FTR_476_DD1_1
defined.

Signed-off-by: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/cputable.h |    2 ++
 arch/powerpc/kernel/cputable.c      |   38 ++++++++++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 5 deletions(-)


diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 9fff628..d28eaf7 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -153,8 +153,10 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_NAP_DISABLE_L2_PR	ASM_CONST(0x0000000000002000)
 #define CPU_FTR_DUAL_PLL_750FX		ASM_CONST(0x0000000000004000)
 #define CPU_FTR_NO_DPM			ASM_CONST(0x0000000000008000)
+#define CPU_FTR_476_DD1			ASM_CONST(0x0000000000010000)
 #define CPU_FTR_NEED_COHERENT		ASM_CONST(0x0000000000020000)
 #define CPU_FTR_NO_BTIC			ASM_CONST(0x0000000000040000)
+#define CPU_FTR_476_DD1_1		ASM_CONST(0x0000000000080000)
 #define CPU_FTR_NODSISRALIGN		ASM_CONST(0x0000000000100000)
 #define CPU_FTR_PPC_LE			ASM_CONST(0x0000000000200000)
 #define CPU_FTR_REAL_LE			ASM_CONST(0x0000000000400000)
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index a06e6d3..0ea9134 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1701,15 +1701,29 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
-	{ /* 476 core */
+	{ /* 476 DD1 core - needs DD1.1 feature as well */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x11a50000,
 		.cpu_name		= "476",
-		.cpu_features		= CPU_FTRS_47X,
-		.cpu_user_features	= COMMON_USER_BOOKE |
-			PPC_FEATURE_HAS_FPU,
+		.cpu_features		= CPU_FTRS_47X | CPU_FTR_476_DD1 |
+			CPU_FTR_476_DD1_1 | CPU_FTR_FPU_UNAVAILABLE,
+		.cpu_user_features	= COMMON_USER_BOOKE,
 		.mmu_features		= MMU_FTR_TYPE_47x |
-			MMU_FTR_USE_TLBIVAX_BCAST | MMU_FTR_LOCK_BCAST_INVAL,
+			MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 128,
+		.machine_check		= machine_check_47x,
+		.platform		= "ppc470",
+	},
+	{ /* 476 DD1.1 core */
+		.pvr_mask		= 0xffff0000,
+		.pvr_value		= 0x11a50000,
+		.cpu_name		= "476",
+		.cpu_features		= CPU_FTRS_47X | CPU_FTR_476_DD1_1 |
+			CPU_FTR_FPU_UNAVAILABLE,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.mmu_features		= MMU_FTR_TYPE_47x |
+			MMU_FTR_LOCK_BCAST_INVAL,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 128,
 		.machine_check		= machine_check_47x,
@@ -1724,6 +1738,20 @@ static struct cpu_spec __initdata cpu_specs[] = {
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
+		.pvr_value		= 0x11a50000,
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
