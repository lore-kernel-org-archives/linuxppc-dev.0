Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 453B3B7BBE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 15:08:42 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A3006DDDA0
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 15:08:41 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 2/5] powerpc/book3e-64: Move the default cpu table entry
Date: Wed, 19 Aug 2009 00:08:30 -0500
Message-Id: <1250658513-13009-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
References: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the default cpu entry table for CONFIG_PPC_BOOK3E_64 to the
very end since we will probably want to support both 32-bit and
64-bit kernels for some processors that are higher up in the list.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/cputable.c |   49 ++++++++++++++++++++++------------------
 1 files changed, 27 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 9f38ecb..0b9c913 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -89,8 +89,12 @@ extern void __restore_cpu_power7(void);
 #define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
 				 PPC_FEATURE_TRUE_LE | \
 				 PPC_FEATURE_HAS_ALTIVEC_COMP)
+#ifdef CONFIG_PPC_BOOK3E_64
+#define COMMON_USER_BOOKE	(COMMON_USER_PPC64 | PPC_FEATURE_BOOKE)
+#else
 #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
 				 PPC_FEATURE_BOOKE)
+#endif
 
 static struct cpu_spec __initdata cpu_specs[] = {
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -509,28 +513,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.platform		= "power4",
 	}
 #endif	/* CONFIG_PPC_BOOK3S_64 */
-#ifdef CONFIG_PPC_BOOK3E_64
-	{	/* This is a default entry to get going, to be replaced by
-		 * a real one at some stage
-		 */
-#define CPU_FTRS_BASE_BOOK3E	(CPU_FTR_USE_TB | \
-	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_SMT | \
-	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
-		.pvr_mask		= 0x00000000,
-		.pvr_value		= 0x00000000,
-		.cpu_name		= "Book3E",
-		.cpu_features		= CPU_FTRS_BASE_BOOK3E,
-		.cpu_user_features	= COMMON_USER_PPC64,
-		.mmu_features		= MMU_FTR_TYPE_3E | MMU_FTR_USE_TLBILX |
-					  MMU_FTR_USE_TLBIVAX_BCAST |
-					  MMU_FTR_LOCK_BCAST_INVAL,
-		.icache_bsize		= 64,
-		.dcache_bsize		= 64,
-		.num_pmcs		= 0,
-		.machine_check		= machine_check_generic,
-		.platform		= "power6",
-	},
-#endif
 
 #ifdef CONFIG_PPC32
 #if CLASSIC_PPC
@@ -1846,6 +1828,29 @@ static struct cpu_spec __initdata cpu_specs[] = {
 	}
 #endif /* CONFIG_E500 */
 #endif /* CONFIG_PPC32 */
+
+#ifdef CONFIG_PPC_BOOK3E_64
+	{	/* This is a default entry to get going, to be replaced by
+		 * a real one at some stage
+		 */
+#define CPU_FTRS_BASE_BOOK3E	(CPU_FTR_USE_TB | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_SMT | \
+	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
+		.pvr_mask		= 0x00000000,
+		.pvr_value		= 0x00000000,
+		.cpu_name		= "Book3E",
+		.cpu_features		= CPU_FTRS_BASE_BOOK3E,
+		.cpu_user_features	= COMMON_USER_PPC64,
+		.mmu_features		= MMU_FTR_TYPE_3E | MMU_FTR_USE_TLBILX |
+					  MMU_FTR_USE_TLBIVAX_BCAST |
+					  MMU_FTR_LOCK_BCAST_INVAL,
+		.icache_bsize		= 64,
+		.dcache_bsize		= 64,
+		.num_pmcs		= 0,
+		.machine_check		= machine_check_generic,
+		.platform		= "power6",
+	},
+#endif
 };
 
 static struct cpu_spec the_cpu_spec;
-- 
1.6.0.6
