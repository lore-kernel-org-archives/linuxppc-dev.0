Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <1a24282746fd056fb51dda3b25d160d2fc609da5.1302856271.git.michael@ellerman.id.au>
In-Reply-To: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
References: <d284a5076d7760656470a5fd16d98ec6501a9bf3.1302856271.git.michael@ellerman.id.au>
Subject: [PATCH 07/15] powerpc: Move CPU_FTRS_BASE_BOOK3E into cputable.h &
	update FTR masks
Date: Fri, 15 Apr 2011 18:32:01 +1000 (EST)
From: michael@ozlabs.org (Michael Ellerman)
Cc: Jimi Xenidis <jimix@watson.ibm.com>, jack@codezen.org, imunsie@au.ibm.com,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <michael@ellerman.id.au>

Where they belong with all the others. Remove SMT which may not be
true for all BOOK3E parts.

Currently the FTRS_POSSIBLE & FTRS_ALWAYS are defined for 64 or 32 bit.
Now that we have BOOK3E we need to split it three ways, BOOK3S, BOOK3E,
and 32-bit.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h |   17 +++++++++++++----
 arch/powerpc/kernel/cputable.c      |    3 ---
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 7d2eb44..32a970d 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -435,12 +435,18 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_NO_SLBIE_B)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2)
 
-#ifdef __powerpc64__
+#define CPU_FTRS_BASE_BOOK3E	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2 | \
+				 CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
+
+#if defined(CONFIG_PPC_BOOK3S_64)
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
 	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
 	    CPU_FTR_1T_SEGMENT | CPU_FTR_VSX)
+#elif defined(CONFIG_PPC_BOOK3E_64)
+#define CPU_FTRS_POSSIBLE	\
+	    (CPU_FTRS_BASE_BOOK3E)
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
@@ -477,13 +483,16 @@ enum {
 #endif
 	    0,
 };
-#endif /* __powerpc64__ */
+#endif /* defined(CONFIG_PPC_BOOK3S_64) */
 
-#ifdef __powerpc64__
+#if defined(CONFIG_PPC_BOOK3S_64)
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_POWER3 & CPU_FTRS_RS64 & CPU_FTRS_POWER4 &	\
 	    CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & CPU_FTRS_POWER6 &	\
 	    CPU_FTRS_POWER7 & CPU_FTRS_CELL & CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
+#elif defined(CONFIG_PPC_BOOK3E_64)
+#define CPU_FTRS_ALWAYS	\
+	    (CPU_FTRS_BASE_BOOK3E)
 #else
 enum {
 	CPU_FTRS_ALWAYS =
@@ -517,7 +526,7 @@ enum {
 #endif
 	    CPU_FTRS_POSSIBLE,
 };
-#endif /* __powerpc64__ */
+#endif /* defined(CONFIG_PPC_BOOK3S_64) */
 
 static inline int cpu_has_feature(unsigned long feature)
 {
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 867ae30..70cbae1 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2015,9 +2015,6 @@ static struct cpu_spec __initdata cpu_specs[] = {
 	{	/* This is a default entry to get going, to be replaced by
 		 * a real one at some stage
 		 */
-#define CPU_FTRS_BASE_BOOK3E	(CPU_FTR_USE_TB | \
-	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_SMT | \
-	    CPU_FTR_NODSISRALIGN | CPU_FTR_NOEXECUTE)
 		.pvr_mask		= 0x00000000,
 		.pvr_value		= 0x00000000,
 		.cpu_name		= "Book3E",
-- 
1.7.1
