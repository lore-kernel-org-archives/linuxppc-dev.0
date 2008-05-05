Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 05 May 2008 15:22:27 +1000
Subject: [PATCH] [POWERPC] More useful cputable defaults
Message-Id: <20080505052405.23E38DDE0A@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Changes the cputable so that various CPU families that have an exclusive
CONFIG_ option have a more sensible default entry to patch if the specific
processor hasn't been identified.

This makes the kernel more generally useful when booted on an unknown
PVR for things like new 4xx variants.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/cputable.c |   53 +++++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 10 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/cputable.c	2008-05-05 13:43:02.000000000 +1000
+++ linux-work/arch/powerpc/kernel/cputable.c	2008-05-05 13:47:52.000000000 +1000
@@ -1207,6 +1207,18 @@ static struct cpu_spec __initdata cpu_sp
 		.machine_check		= machine_check_4xx,
 		.platform		= "ppc405",
 	},
+	{	/* default match */
+		.pvr_mask		= 0x00000000,
+		.pvr_value		= 0x00000000,
+		.cpu_name		= "(generic 40x PPC)",
+		.cpu_features		= CPU_FTRS_40X,
+		.cpu_user_features	= PPC_FEATURE_32 |
+			PPC_FEATURE_HAS_MMU | PPC_FEATURE_HAS_4xxMAC,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc405",
+	}
 
 #endif /* CONFIG_40x */
 #ifdef CONFIG_44x
@@ -1397,8 +1409,18 @@ static struct cpu_spec __initdata cpu_sp
 		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
+	{	/* default match */
+		.pvr_mask		= 0x00000000,
+		.pvr_value		= 0x00000000,
+		.cpu_name		= "(generic 44x PPC)",
+		.cpu_features		= CPU_FTRS_44X,
+		.cpu_user_features	= COMMON_USER_BOOKE,
+		.icache_bsize		= 32,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_4xx,
+		.platform		= "ppc440",
+	}
 #endif /* CONFIG_44x */
-#ifdef CONFIG_FSL_BOOKE
 #ifdef CONFIG_E200
 	{	/* e200z5 */
 		.pvr_mask		= 0xfff00000,
@@ -1427,7 +1449,19 @@ static struct cpu_spec __initdata cpu_sp
 		.machine_check		= machine_check_e200,
 		.platform		= "ppc5554",
 	},
-#elif defined(CONFIG_E500)
+	{	/* default match */
+		.pvr_mask		= 0x00000000,
+		.pvr_value		= 0x00000000,
+		.cpu_name		= "(generic E200 PPC)",
+		.cpu_features		= CPU_FTRS_E200,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+			PPC_FEATURE_HAS_EFP_SINGLE |
+			PPC_FEATURE_UNIFIED_CACHE,
+		.dcache_bsize		= 32,
+		.machine_check		= machine_check_e200,
+		.platform		= "ppc5554",
+#endif /* CONFIG_E200 */
+#ifdef CONFIG_E500
 	{	/* e500 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80200000,
@@ -1463,20 +1497,19 @@ static struct cpu_spec __initdata cpu_sp
 		.machine_check		= machine_check_e500,
 		.platform		= "ppc8548",
 	},
-#endif
-#endif
-#if !CLASSIC_PPC
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
-		.cpu_name		= "(generic PPC)",
-		.cpu_features		= CPU_FTRS_GENERIC_32,
-		.cpu_user_features	= PPC_FEATURE_32,
+		.cpu_name		= "(generic E500 PPC)",
+		.cpu_features		= CPU_FTRS_E500,
+		.cpu_user_features	= COMMON_USER_BOOKE |
+			PPC_FEATURE_HAS_SPE_COMP |
+			PPC_FEATURE_HAS_EFP_SINGLE_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.machine_check		= machine_check_e500,
 		.platform		= "powerpc",
-	}
-#endif /* !CLASSIC_PPC */
+#endif /* CONFIG_E500 */
 #endif /* CONFIG_PPC32 */
 };
 
