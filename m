Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7C80367B58
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Sep 2006 03:28:52 +1000 (EST)
Date: Tue, 5 Sep 2006 12:28:08 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org, anton@samba.org
Subject: [3/5] powerpc: PA6T cputable entry, PVR value
Message-ID: <20060905122808.36c0c88d@localhost.localdomain>
In-Reply-To: <20060904175742.5472a6fa@localhost.localdomain>
References: <20060904175742.5472a6fa@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Introduce PWRficient PA6T cputable entry and feature bits.


Signed-off-by: Olof Johansson <olof@lixom.net>

Index: merge/arch/powerpc/kernel/cputable.c
===================================================================
--- merge.orig/arch/powerpc/kernel/cputable.c
+++ merge/arch/powerpc/kernel/cputable.c
@@ -58,6 +58,9 @@ extern void __restore_cpu_ppc970(void);
 #define COMMON_USER_POWER6	(COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_05 |\
 				 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
 				 PPC_FEATURE_TRUE_LE)
+#define COMMON_USER_PA6T	(COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\
+				 PPC_FEATURE_TRUE_LE | \
+				 PPC_FEATURE_HAS_ALTIVEC_COMP)
 #define COMMON_USER_BOOKE	(PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU | \
 				 PPC_FEATURE_BOOKE)
 
@@ -286,6 +289,17 @@ struct cpu_spec	cpu_specs[] = {
 		.dcache_bsize		= 128,
 		.platform		= "ppc-cell-be",
 	},
+	{	/* PA Semi PA6T */
+		.pvr_mask		= 0x7fff0000,
+		.pvr_value		= 0x00900000,
+		.cpu_name		= "PA6T",
+		.cpu_features		= CPU_FTRS_PA6T,
+		.cpu_user_features	= COMMON_USER_PA6T,
+		.icache_bsize		= 64,
+		.dcache_bsize		= 64,
+		.num_pmcs		= 6,
+		.platform		= "pa6t",
+	},
 	{	/* default match */
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
Index: merge/include/asm-powerpc/reg.h
===================================================================
--- merge.orig/include/asm-powerpc/reg.h
+++ merge/include/asm-powerpc/reg.h
@@ -592,6 +592,8 @@
 #define PV_630p	0x0041
 #define PV_970MP	0x0044
 #define PV_BE		0x0070
+#define	PV_PA6T		0x0090
+
 
 /*
  * Number of entries in the SLB. If this ever changes we should handle
Index: merge/include/asm-powerpc/cputable.h
===================================================================
--- merge.orig/include/asm-powerpc/cputable.h
+++ merge/include/asm-powerpc/cputable.h
@@ -23,6 +23,7 @@
 #define PPC_FEATURE_SMT			0x00004000
 #define PPC_FEATURE_ICACHE_SNOOP	0x00002000
 #define PPC_FEATURE_ARCH_2_05		0x00001000
+#define PPC_FEATURE_PA6T		0x00000800
 
 #define PPC_FEATURE_TRUE_LE		0x00000002
 #define PPC_FEATURE_PPC_LE		0x00000001
@@ -332,6 +333,10 @@ extern void do_cpu_ftr_fixups(unsigned l
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE)
+#define CPU_FTRS_PA6T (CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
+	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
+	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
+	    CPU_FTR_PURR | CPU_FTR_REAL_LE)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2)
 #endif
@@ -340,7 +345,7 @@ extern void do_cpu_ftr_fixups(unsigned l
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
-	    CPU_FTRS_CELL | CPU_FTR_CI_LARGE_PAGE)
+	    CPU_FTRS_CELL | CPU_FTRS_PA6T)
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
@@ -379,7 +384,7 @@ enum {
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_POWER3 & CPU_FTRS_RS64 & CPU_FTRS_POWER4 &	\
 	    CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & CPU_FTRS_POWER6 &	\
-	    CPU_FTRS_CELL & CPU_FTRS_POSSIBLE)
+	    CPU_FTRS_CELL & CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
 #else
 enum {
 	CPU_FTRS_ALWAYS =
