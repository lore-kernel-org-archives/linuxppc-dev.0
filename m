Return-Path: <matt@ozlabs.org>
Received: from [10.10.10.36] (ppp121-45-193-234.lns20.cbr1.internode.on.net
	[121.45.193.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPSA id 947D7B6F07
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Apr 2011 15:48:54 +1000 (EST)
Message-ID: <4D9D5042.6080500@ozlabs.org>
Date: Thu, 07 Apr 2011 15:48:50 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Free up some CPU feature bits by moving out
	MMU-related features
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the 64bit PPC CPU features are MMU-related, so this patch moves
them to MMU_FTR_ bits.  All cpu_has_feature()-style tests are moved to
mmu_has_feature(), and seven feature bits are freed as a result.

Signed-off-by: Matt Evans <matt@ozlabs.org>
---
Boot-tested on pseries and G5.

 arch/powerpc/include/asm/cputable.h        |   52 ++++++++++++++-------------
 arch/powerpc/include/asm/mmu.h             |   28 +++++++++++++++
 arch/powerpc/include/asm/mmu_context.h     |    2 +-
 arch/powerpc/kernel/cputable.c             |   39 ++++++++++-----------
 arch/powerpc/kernel/entry_64.S             |    8 ++--
 arch/powerpc/kernel/exceptions-64s.S       |    4 +-
 arch/powerpc/kernel/process.c              |    4 +-
 arch/powerpc/kernel/prom.c                 |   17 +++++----
 arch/powerpc/kernel/setup_64.c             |    2 +-
 arch/powerpc/mm/hash_low_64.S              |    8 ++--
 arch/powerpc/mm/hash_native_64.c           |    8 ++--
 arch/powerpc/mm/hash_utils_64.c            |   18 +++++-----
 arch/powerpc/mm/hugetlbpage.c              |    2 +-
 arch/powerpc/mm/slb.c                      |    4 +-
 arch/powerpc/mm/slb_low.S                  |    8 ++--
 arch/powerpc/mm/stab.c                     |    2 +-
 arch/powerpc/platforms/iseries/exception.S |    2 +-
 arch/powerpc/platforms/iseries/setup.c     |    4 +-
 arch/powerpc/platforms/pseries/lpar.c      |    2 +-
 arch/powerpc/xmon/xmon.c                   |    2 +-
 20 files changed, 123 insertions(+), 93 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index be3cdf9..7b0fe7c 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -178,22 +178,15 @@ extern const char *powerpc_base_platform;
 #define LONG_ASM_CONST(x)		0
 #endif
 
-#define CPU_FTR_SLB			LONG_ASM_CONST(0x0000000100000000)
-#define CPU_FTR_16M_PAGE		LONG_ASM_CONST(0x0000000200000000)
-#define CPU_FTR_TLBIEL			LONG_ASM_CONST(0x0000000400000000)
 #define CPU_FTR_IABR			LONG_ASM_CONST(0x0000002000000000)
 #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000004000000000)
 #define CPU_FTR_CTRL			LONG_ASM_CONST(0x0000008000000000)
 #define CPU_FTR_SMT			LONG_ASM_CONST(0x0000010000000000)
-#define CPU_FTR_LOCKLESS_TLBIE		LONG_ASM_CONST(0x0000040000000000)
-#define CPU_FTR_CI_LARGE_PAGE		LONG_ASM_CONST(0x0000100000000000)
 #define CPU_FTR_PAUSE_ZERO		LONG_ASM_CONST(0x0000200000000000)
 #define CPU_FTR_PURR			LONG_ASM_CONST(0x0000400000000000)
 #define CPU_FTR_CELL_TB_BUG		LONG_ASM_CONST(0x0000800000000000)
 #define CPU_FTR_SPURR			LONG_ASM_CONST(0x0001000000000000)
 #define CPU_FTR_DSCR			LONG_ASM_CONST(0x0002000000000000)
-#define CPU_FTR_1T_SEGMENT		LONG_ASM_CONST(0x0004000000000000)
-#define CPU_FTR_NO_SLBIE_B		LONG_ASM_CONST(0x0008000000000000)
 #define CPU_FTR_VSX			LONG_ASM_CONST(0x0010000000000000)
 #define CPU_FTR_SAO			LONG_ASM_CONST(0x0020000000000000)
 #define CPU_FTR_CP_USE_DCBTZ		LONG_ASM_CONST(0x0040000000000000)
@@ -205,9 +198,10 @@ extern const char *powerpc_base_platform;
 
 #ifndef __ASSEMBLY__
 
-#define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_SLB | \
-				 CPU_FTR_TLBIEL | CPU_FTR_NOEXECUTE | \
-				 CPU_FTR_NODSISRALIGN | CPU_FTR_16M_PAGE)
+#define CPU_FTR_PPCAS_ARCH_V2	(CPU_FTR_NOEXECUTE | CPU_FTR_NODSISRALIGN)
+
+#define MMU_FTR_PPCAS_ARCH_V2 	(MMU_FTR_SLB | MMU_FTR_TLBIEL | \
+				 MMU_FTR_16M_PAGE)
 
 /* We only set the altivec features if the kernel was compiled with altivec
  * support
@@ -405,41 +399,49 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_STCX_CHECKS_ADDRESS | \
-	    CPU_FTR_POPCNTB)
+	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_PURR | \
+	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB)
 #define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
+	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_PURR | CPU_FTR_SPURR | \
+	    CPU_FTR_REAL_LE | CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
-	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
-	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
+	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_PURR | CPU_FTR_SPURR | \
+	    CPU_FTR_REAL_LE | CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
-	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | \
-	    CPU_FTR_CELL_TB_BUG | CPU_FTR_CP_USE_DCBTZ | \
+	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CELL_TB_BUG | CPU_FTR_CP_USE_DCBTZ | \
 	    CPU_FTR_UNALIGNED_LD_STD)
 #define CPU_FTRS_PA6T (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | \
-	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
-	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_NO_SLBIE_B)
+	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_PURR | CPU_FTR_REAL_LE)
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2)
 
+/* MMU feature bit sets for various CPUs */
+#define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
+	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
+#define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
+#define MMU_FTRS_PPC970		MMU_FTRS_POWER4
+#define MMU_FTRS_POWER5		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
+#define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
+#define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | \
+	MMU_FTR_TLBIE_206
+#define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
+	MMU_FTR_CI_LARGE_PAGE
+#define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
+	MMU_FTR_CI_LARGE_PAGE | MMU_FTR_NO_SLBIE_B
+
 #ifdef __powerpc64__
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
-	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
-	    CPU_FTR_1T_SEGMENT | CPU_FTR_VSX)
+	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T | CPU_FTR_VSX)
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index bb40a06..388189e 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -70,6 +70,34 @@
  */
 #define MMU_FTR_USE_PAIRED_MAS		ASM_CONST(0x01000000)
 
+/* MMU is SLB-based
+ */
+#define MMU_FTR_SLB			ASM_CONST(0x02000000)
+
+/* Support 16M large pages
+ */
+#define MMU_FTR_16M_PAGE		ASM_CONST(0x04000000)
+
+/* Supports TLBIEL variant
+ */
+#define MMU_FTR_TLBIEL			ASM_CONST(0x08000000)
+
+/* Supports tlbies w/o locking
+ */
+#define MMU_FTR_LOCKLESS_TLBIE		ASM_CONST(0x10000000)
+
+/* Large pages can be marked CI
+ */
+#define MMU_FTR_CI_LARGE_PAGE		ASM_CONST(0x20000000)
+
+/* 1T segments available
+ */
+#define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
+
+/* Doesn't support the B bit (1T segment) in SLBIE
+ */
+#define MMU_FTR_NO_SLBIE_B		ASM_CONST(0x80000000)
+
 #ifndef __ASSEMBLY__
 #include <asm/cputable.h>
 
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 81fb412..8e13f65 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -67,7 +67,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	 * sub architectures.
 	 */
 #ifdef CONFIG_PPC_STD_MMU_64
-	if (cpu_has_feature(CPU_FTR_SLB))
+	if (mmu_has_feature(MMU_FTR_SLB))
 		switch_slb(tsk, next);
 	else
 		switch_stab(tsk, next);
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c9b68d0..387c549 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -199,7 +199,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER4 (gp)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_POWER4,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -214,7 +214,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER4+ (gq)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_POWER4,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -230,7 +230,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_PPC970,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -248,7 +248,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_PPC970,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -284,7 +284,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_PPC970,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -302,7 +302,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_PPC970,
 		.cpu_user_features	= COMMON_USER_POWER4 |
 			PPC_FEATURE_HAS_ALTIVEC_COMP,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_PPC970,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -318,7 +318,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER5 (gr)",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_POWER5,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -338,7 +338,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER5+ (gs)",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_POWER5,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -354,7 +354,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER5+ (gs)",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_POWER5,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -371,7 +371,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER5+",
 		.cpu_features		= CPU_FTRS_POWER5,
 		.cpu_user_features	= COMMON_USER_POWER5_PLUS,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_POWER5,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
@@ -385,7 +385,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_features		= CPU_FTRS_POWER6,
 		.cpu_user_features	= COMMON_USER_POWER6 |
 			PPC_FEATURE_POWER6_EXT,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_POWER6,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -404,7 +404,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER6 (architected)",
 		.cpu_features		= CPU_FTRS_POWER6,
 		.cpu_user_features	= COMMON_USER_POWER6,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_POWER6,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
@@ -417,8 +417,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER7 (architected)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
-		.mmu_features		= MMU_FTR_HPTE_TABLE |
-			MMU_FTR_TLBIE_206,
+		.mmu_features		= MMU_FTRS_POWER7,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.oprofile_type		= PPC_OPROFILE_POWER4,
@@ -431,8 +430,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER7 (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
-		.mmu_features		= MMU_FTR_HPTE_TABLE |
-			MMU_FTR_TLBIE_206,
+		.mmu_features		= MMU_FTRS_POWER7,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -447,8 +445,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER7+ (raw)",
 		.cpu_features		= CPU_FTRS_POWER7,
 		.cpu_user_features	= COMMON_USER_POWER7,
-		.mmu_features		= MMU_FTR_HPTE_TABLE |
-			MMU_FTR_TLBIE_206,
+		.mmu_features		= MMU_FTRS_POWER7,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
@@ -465,7 +462,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_PPC64 |
 			PPC_FEATURE_CELL | PPC_FEATURE_HAS_ALTIVEC_COMP |
 			PPC_FEATURE_SMT,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_CELL,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 4,
@@ -480,7 +477,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "PA6T",
 		.cpu_features		= CPU_FTRS_PA6T,
 		.cpu_user_features	= COMMON_USER_PA6T,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_PA6T,
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
 		.num_pmcs		= 6,
@@ -497,7 +494,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER4 (compatible)",
 		.cpu_features		= CPU_FTRS_COMPATIBLE,
 		.cpu_user_features	= COMMON_USER_PPC64,
-		.mmu_features		= MMU_FTR_HPTE_TABLE,
+		.mmu_features		= MMU_FTRS_DEFAULT_HPTE_ARCH_V2,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index d82878c..32c2605 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -462,10 +462,10 @@ BEGIN_FTR_SECTION
   FTR_SECTION_ELSE_NESTED(95)
 	clrrdi	r6,r8,40	/* get its 1T ESID */
 	clrrdi	r9,r1,40	/* get current sp 1T ESID */
-  ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_1T_SEGMENT, 95)
+  ALT_MMU_FTR_SECTION_END_NESTED_IFCLR(MMU_FTR_1T_SEGMENT, 95)
 FTR_SECTION_ELSE
 	b	2f
-ALT_FTR_SECTION_END_IFSET(CPU_FTR_SLB)
+ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_SLB)
 	clrldi.	r0,r6,2		/* is new ESID c00000000? */
 	cmpd	cr1,r6,r9	/* or is new ESID the same as current ESID? */
 	cror	eq,4*cr1+eq,eq
@@ -479,7 +479,7 @@ BEGIN_FTR_SECTION
 	li	r9,MMU_SEGSIZE_1T	/* insert B field */
 	oris	r6,r6,(MMU_SEGSIZE_1T << SLBIE_SSIZE_SHIFT)@h
 	rldimi	r7,r9,SLB_VSID_SSIZE_SHIFT,0
-END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 
 	/* Update the last bolted SLB.  No write barriers are needed
 	 * here, provided we only update the current CPU's SLB shadow
@@ -491,7 +491,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
 	std	r7,SLBSHADOW_STACKVSID(r9)  /* Save VSID */
 	std	r0,SLBSHADOW_STACKESID(r9)  /* Save ESID */
 
-	/* No need to check for CPU_FTR_NO_SLBIE_B here, since when
+	/* No need to check for MMU_FTR_NO_SLBIE_B here, since when
 	 * we have 1TB segments, the only CPUs known to have the errata
 	 * only support less than 1TB of system memory and we'll never
 	 * actually hit this code path.
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index c532cb2..2279294 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -74,7 +74,7 @@ BEGIN_FTR_SECTION
 	EXCEPTION_PROLOG_PSERIES_1(data_access_common)
 FTR_SECTION_ELSE
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common)
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_SLB)
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_SLB)
 
 	. = 0x380
 	.globl data_access_slb_pSeries
@@ -750,7 +750,7 @@ _STATIC(do_hash_page)
 BEGIN_FTR_SECTION
 	andis.	r0,r4,0x0020		/* Is it a segment table fault? */
 	bne-	do_ste_alloc		/* If so handle it */
-END_FTR_SECTION_IFCLR(CPU_FTR_SLB)
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 
 	clrrdi	r11,r1,THREAD_SHIFT
 	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f74f355..65c3802 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -755,11 +755,11 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 				_ALIGN_UP(sizeof(struct thread_info), 16);
 
 #ifdef CONFIG_PPC_STD_MMU_64
-	if (cpu_has_feature(CPU_FTR_SLB)) {
+	if (mmu_has_feature(MMU_FTR_SLB)) {
 		unsigned long sp_vsid;
 		unsigned long llp = mmu_psize_defs[mmu_linear_psize].sllp;
 
-		if (cpu_has_feature(CPU_FTR_1T_SEGMENT))
+		if (mmu_has_feature(MMU_FTR_1T_SEGMENT))
 			sp_vsid = get_kernel_vsid(sp, MMU_SEGSIZE_1T)
 				<< SLB_VSID_SHIFT_1T;
 		else
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 05b7139..b48b04f 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -123,18 +123,19 @@ static void __init move_device_tree(void)
  */
 static struct ibm_pa_feature {
 	unsigned long	cpu_features;	/* CPU_FTR_xxx bit */
+	unsigned long	mmu_features;	/* MMU_FTR_xxx bit */
 	unsigned int	cpu_user_ftrs;	/* PPC_FEATURE_xxx bit */
 	unsigned char	pabyte;		/* byte number in ibm,pa-features */
 	unsigned char	pabit;		/* bit number (big-endian) */
 	unsigned char	invert;		/* if 1, pa bit set => clear feature */
 } ibm_pa_features[] __initdata = {
-	{0, PPC_FEATURE_HAS_MMU,	0, 0, 0},
-	{0, PPC_FEATURE_HAS_FPU,	0, 1, 0},
-	{CPU_FTR_SLB, 0,		0, 2, 0},
-	{CPU_FTR_CTRL, 0,		0, 3, 0},
-	{CPU_FTR_NOEXECUTE, 0,		0, 6, 0},
-	{CPU_FTR_NODSISRALIGN, 0,	1, 1, 1},
-	{CPU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
+	{0, 0, PPC_FEATURE_HAS_MMU,	0, 0, 0},
+	{0, 0, PPC_FEATURE_HAS_FPU,	0, 1, 0},
+	{0, MMU_FTR_SLB, 0,		0, 2, 0},
+	{CPU_FTR_CTRL, 0, 0,		0, 3, 0},
+	{CPU_FTR_NOEXECUTE, 0, 0,	0, 6, 0},
+	{CPU_FTR_NODSISRALIGN, 0, 0,	1, 1, 1},
+	{0, MMU_FTR_CI_LARGE_PAGE, 0,	1, 2, 0},
 	{CPU_FTR_REAL_LE, PPC_FEATURE_TRUE_LE, 5, 0, 0},
 };
 
@@ -166,9 +167,11 @@ static void __init scan_features(unsigned long node, unsigned char *ftrs,
 		if (bit ^ fp->invert) {
 			cur_cpu_spec->cpu_features |= fp->cpu_features;
 			cur_cpu_spec->cpu_user_features |= fp->cpu_user_ftrs;
+			cur_cpu_spec->mmu_features |= fp->mmu_features;
 		} else {
 			cur_cpu_spec->cpu_features &= ~fp->cpu_features;
 			cur_cpu_spec->cpu_user_features &= ~fp->cpu_user_ftrs;
+			cur_cpu_spec->mmu_features &= ~fp->mmu_features;
 		}
 	}
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 5a0401f..2902f48 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -425,7 +425,7 @@ void __init setup_system(void)
 
 static u64 slb0_limit(void)
 {
-	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
+	if (mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
 		return 1UL << SID_SHIFT_1T;
 	}
 	return 1UL << SID_SHIFT;
diff --git a/arch/powerpc/mm/hash_low_64.S b/arch/powerpc/mm/hash_low_64.S
index 3079f6b..36def97 100644
--- a/arch/powerpc/mm/hash_low_64.S
+++ b/arch/powerpc/mm/hash_low_64.S
@@ -118,7 +118,7 @@ _GLOBAL(__hash_page_4K)
 BEGIN_FTR_SECTION
 	cmpdi	r9,0			/* check segment size */
 	bne	3f
-END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	/* Calc va and put it in r29 */
 	rldicr	r29,r5,28,63-28
 	rldicl	r3,r3,0,36
@@ -401,7 +401,7 @@ _GLOBAL(__hash_page_4K)
 BEGIN_FTR_SECTION
 	cmpdi	r9,0			/* check segment size */
 	bne	3f
-END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	/* Calc va and put it in r29 */
 	rldicr	r29,r5,28,63-28		/* r29 = (vsid << 28) */
 	rldicl	r3,r3,0,36		/* r3 = (ea & 0x0fffffff) */
@@ -715,7 +715,7 @@ BEGIN_FTR_SECTION
 	andi.	r0,r31,_PAGE_NO_CACHE
 	/* If so, bail out and refault as a 4k page */
 	bne-	ht64_bail_ok
-END_FTR_SECTION_IFCLR(CPU_FTR_CI_LARGE_PAGE)
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_CI_LARGE_PAGE)
 	/* Prepare new PTE value (turn access RW into DIRTY, then
 	 * add BUSY and ACCESSED)
 	 */
@@ -736,7 +736,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CI_LARGE_PAGE)
 BEGIN_FTR_SECTION
 	cmpdi	r9,0			/* check segment size */
 	bne	3f
-END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	/* Calc va and put it in r29 */
 	rldicr	r29,r5,28,63-28
 	rldicl	r3,r3,0,36
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 784a400..c23eef2 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -98,8 +98,8 @@ static inline void __tlbiel(unsigned long va, int psize, int ssize)
 
 static inline void tlbie(unsigned long va, int psize, int ssize, int local)
 {
-	unsigned int use_local = local && cpu_has_feature(CPU_FTR_TLBIEL);
-	int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
+	unsigned int use_local = local && mmu_has_feature(MMU_FTR_TLBIEL);
+	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 
 	if (use_local)
 		use_local = mmu_psize_defs[psize].tlbiel;
@@ -503,7 +503,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 		} pte_iterate_hashed_end();
 	}
 
-	if (cpu_has_feature(CPU_FTR_TLBIEL) &&
+	if (mmu_has_feature(MMU_FTR_TLBIEL) &&
 	    mmu_psize_defs[psize].tlbiel && local) {
 		asm volatile("ptesync":::"memory");
 		for (i = 0; i < number; i++) {
@@ -517,7 +517,7 @@ static void native_flush_hash_range(unsigned long number, int local)
 		}
 		asm volatile("ptesync":::"memory");
 	} else {
-		int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
+		int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 
 		if (lock_tlbie)
 			raw_spin_lock(&native_tlbie_lock);
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index a5991fa..2f0b834 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -258,11 +258,11 @@ static int __init htab_dt_scan_seg_sizes(unsigned long node,
 	for (; size >= 4; size -= 4, ++prop) {
 		if (prop[0] == 40) {
 			DBG("1T segment support detected\n");
-			cur_cpu_spec->cpu_features |= CPU_FTR_1T_SEGMENT;
+			cur_cpu_spec->mmu_features |= MMU_FTR_1T_SEGMENT;
 			return 1;
 		}
 	}
-	cur_cpu_spec->cpu_features &= ~CPU_FTR_NO_SLBIE_B;
+	cur_cpu_spec->mmu_features &= ~MMU_FTR_NO_SLBIE_B;
 	return 0;
 }
 
@@ -288,7 +288,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 	if (prop != NULL) {
 		DBG("Page sizes from device-tree:\n");
 		size /= 4;
-		cur_cpu_spec->cpu_features &= ~(CPU_FTR_16M_PAGE);
+		cur_cpu_spec->mmu_features &= ~(MMU_FTR_16M_PAGE);
 		while(size > 0) {
 			unsigned int shift = prop[0];
 			unsigned int slbenc = prop[1];
@@ -316,7 +316,7 @@ static int __init htab_dt_scan_page_sizes(unsigned long node,
 				break;
 			case 0x18:
 				idx = MMU_PAGE_16M;
-				cur_cpu_spec->cpu_features |= CPU_FTR_16M_PAGE;
+				cur_cpu_spec->mmu_features |= MMU_FTR_16M_PAGE;
 				break;
 			case 0x22:
 				idx = MMU_PAGE_16G;
@@ -411,7 +411,7 @@ static void __init htab_init_page_sizes(void)
 	 * Not in the device-tree, let's fallback on known size
 	 * list for 16M capable GP & GR
 	 */
-	if (cpu_has_feature(CPU_FTR_16M_PAGE))
+	if (mmu_has_feature(MMU_FTR_16M_PAGE))
 		memcpy(mmu_psize_defs, mmu_psize_defaults_gp,
 		       sizeof(mmu_psize_defaults_gp));
  found:
@@ -441,7 +441,7 @@ static void __init htab_init_page_sizes(void)
 		mmu_vmalloc_psize = MMU_PAGE_64K;
 		if (mmu_linear_psize == MMU_PAGE_4K)
 			mmu_linear_psize = MMU_PAGE_64K;
-		if (cpu_has_feature(CPU_FTR_CI_LARGE_PAGE)) {
+		if (mmu_has_feature(MMU_FTR_CI_LARGE_PAGE)) {
 			/*
 			 * Don't use 64k pages for ioremap on pSeries, since
 			 * that would stop us accessing the HEA ethernet.
@@ -598,7 +598,7 @@ static void __init htab_initialize(void)
 	/* Initialize page sizes */
 	htab_init_page_sizes();
 
-	if (cpu_has_feature(CPU_FTR_1T_SEGMENT)) {
+	if (mmu_has_feature(MMU_FTR_1T_SEGMENT)) {
 		mmu_kernel_ssize = MMU_SEGSIZE_1T;
 		mmu_highuser_ssize = MMU_SEGSIZE_1T;
 		printk(KERN_INFO "Using 1TB segments\n");
@@ -739,7 +739,7 @@ void __init early_init_mmu(void)
 
 	/* Initialize stab / SLB management except on iSeries
 	 */
-	if (cpu_has_feature(CPU_FTR_SLB))
+	if (mmu_has_feature(MMU_FTR_SLB))
 		slb_initialize();
 	else if (!firmware_has_feature(FW_FEATURE_ISERIES))
 		stab_initialize(get_paca()->stab_real);
@@ -756,7 +756,7 @@ void __cpuinit early_init_mmu_secondary(void)
 	 * in real mode on pSeries and we want a virutal address on
 	 * iSeries anyway
 	 */
-	if (cpu_has_feature(CPU_FTR_SLB))
+	if (mmu_has_feature(MMU_FTR_SLB))
 		slb_initialize();
 	else
 		stab_initialize(get_paca()->stab_addr);
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 9bb249c..0b9a5c1 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -529,7 +529,7 @@ static int __init hugetlbpage_init(void)
 {
 	int psize;
 
-	if (!cpu_has_feature(CPU_FTR_16M_PAGE))
+	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
 		return -ENODEV;
 
 	for (psize = 0; psize < MMU_PAGE_COUNT; ++psize) {
diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 1d98ecc..3657531 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -166,7 +166,7 @@ static inline int esids_match(unsigned long addr1, unsigned long addr2)
 	int esid_1t_count;
 
 	/* System is not 1T segment size capable. */
-	if (!cpu_has_feature(CPU_FTR_1T_SEGMENT))
+	if (!mmu_has_feature(MMU_FTR_1T_SEGMENT))
 		return (GET_ESID(addr1) == GET_ESID(addr2));
 
 	esid_1t_count = (((addr1 >> SID_SHIFT_1T) != 0) +
@@ -201,7 +201,7 @@ void switch_slb(struct task_struct *tsk, struct mm_struct *mm)
 	 */
 	hard_irq_disable();
 	offset = get_paca()->slb_cache_ptr;
-	if (!cpu_has_feature(CPU_FTR_NO_SLBIE_B) &&
+	if (!mmu_has_feature(MMU_FTR_NO_SLBIE_B) &&
 	    offset <= SLB_CACHE_ENTRIES) {
 		int i;
 		asm volatile("isync" : : : "memory");
diff --git a/arch/powerpc/mm/slb_low.S b/arch/powerpc/mm/slb_low.S
index 95ce355..ef653dc 100644
--- a/arch/powerpc/mm/slb_low.S
+++ b/arch/powerpc/mm/slb_low.S
@@ -58,7 +58,7 @@ _GLOBAL(slb_miss_kernel_load_linear)
 	li	r11,0
 BEGIN_FTR_SECTION
 	b	slb_finish_load
-END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	b	slb_finish_load_1T
 
 1:
@@ -87,7 +87,7 @@ _GLOBAL(slb_miss_kernel_load_vmemmap)
 6:
 BEGIN_FTR_SECTION
 	b	slb_finish_load
-END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
+END_MMU_FTR_SECTION_IFCLR(MMU_FTR_1T_SEGMENT)
 	b	slb_finish_load_1T
 
 0:	/* user address: proto-VSID = context << 15 | ESID. First check
@@ -138,11 +138,11 @@ END_FTR_SECTION_IFCLR(CPU_FTR_1T_SEGMENT)
 	ld	r9,PACACONTEXTID(r13)
 BEGIN_FTR_SECTION
 	cmpldi	r10,0x1000
-END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	rldimi	r10,r9,USER_ESID_BITS,0
 BEGIN_FTR_SECTION
 	bge	slb_finish_load_1T
-END_FTR_SECTION_IFSET(CPU_FTR_1T_SEGMENT)
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_1T_SEGMENT)
 	b	slb_finish_load
 
 8:	/* invalid EA */
diff --git a/arch/powerpc/mm/stab.c b/arch/powerpc/mm/stab.c
index 446a018..41e3164 100644
--- a/arch/powerpc/mm/stab.c
+++ b/arch/powerpc/mm/stab.c
@@ -243,7 +243,7 @@ void __init stabs_alloc(void)
 {
 	int cpu;
 
-	if (cpu_has_feature(CPU_FTR_SLB))
+	if (mmu_has_feature(MMU_FTR_SLB))
 		return;
 
 	for_each_possible_cpu(cpu) {
diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index 32a56c6..703b1c9 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -157,7 +157,7 @@ BEGIN_FTR_SECTION
 FTR_SECTION_ELSE
 	EXCEPTION_PROLOG_1(PACA_EXGEN)
 	EXCEPTION_PROLOG_ISERIES_1
-ALT_FTR_SECTION_END_IFCLR(CPU_FTR_SLB)
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_SLB)
 	b	data_access_common
 
 .do_stab_bolted_iSeries:
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 2946ae1..81cb8d2 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -249,7 +249,7 @@ static unsigned long iSeries_process_mainstore_vpd(struct MemoryBlock *mb_array,
 	unsigned long i;
 	unsigned long mem_blocks = 0;
 
-	if (cpu_has_feature(CPU_FTR_SLB))
+	if (mmu_has_feature(MMU_FTR_SLB))
 		mem_blocks = iSeries_process_Regatta_mainstore_vpd(mb_array,
 				max_entries);
 	else
@@ -634,7 +634,7 @@ static int __init iseries_probe(void)
 
 	hpte_init_iSeries();
 	/* iSeries does not support 16M pages */
-	cur_cpu_spec->cpu_features &= ~CPU_FTR_16M_PAGE;
+	cur_cpu_spec->mmu_features &= ~MMU_FTR_16M_PAGE;
 
 	return 1;
 }
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index ca5d589..6f0ed3a 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -573,7 +573,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	unsigned long i, pix, rc;
 	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = &__get_cpu_var(ppc64_tlb_batch);
-	int lock_tlbie = !cpu_has_feature(CPU_FTR_LOCKLESS_TLBIE);
+	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[9];
 	unsigned long va;
 	unsigned long hash, index, shift, hidx, slot;
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 33794c1..57500eb 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -2663,7 +2663,7 @@ static void dump_stab(void)
 
 void dump_segments(void)
 {
-	if (cpu_has_feature(CPU_FTR_SLB))
+	if (mmu_has_feature(MMU_FTR_SLB))
 		dump_slb();
 	else
 		dump_stab();
-- 
1.7.0.4
