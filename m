Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MMg65W68zF1RT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 23:48:02 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: npiggin@gmail.com
Subject: [PATCH] powerpc/64s: Fix CPU_FTRS_ALWAYS vs DT CPU features
Date: Thu, 12 Apr 2018 23:47:51 +1000
Message-Id: <20180412134751.25098-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cpu_has_feature() mechanism has an optimisation where at build
time we construct a mask of the CPU feature bits that will always be
true for the given .config, based on the platform/bitness/etc. that we
are building for.

That is incompatible with DT CPU features, where the set of CPU
features is dependent on feature flags that are given to us by
firmware.

The result is that some feature bits can not be *disabled* by DT CPU
features. Or more accurately, they can be disabled but they will still
appear in the ALWAYS mask, meaning cpu_has_feature() will always
return true for them.

In the past this hasn't really been a problem because on Book3S
64 (where we support DT CPU features), the set of ALWAYS bits has been
very small. That was because we always built for POWER4 and later,
meaning the set of common bits was small.

The only bit that could be cleared by DT CPU features that was also in
the ALWAYS mask was CPU_FTR_NODSISRALIGN, and that was only used in
the alignment handler to create a fake DSISR. That code was itself
deleted in 31bfdb036f12 ("powerpc: Use instruction emulation
infrastructure to handle alignment faults") (Sep 2017).

However the set of ALWAYS features changed with the recent commit
db5ae1c155af ("powerpc/64s: Refine feature sets for little endian
builds") which restricted the set of feature flags when building
little endian to Power7 or later. That caused the ALWAYS mask to
become much larger for little endian builds.

The result is that the following feature bits can currently not
be *disabled* by DT CPU features:

  CPU_FTR_REAL_LE, CPU_FTR_MMCRA, CPU_FTR_CTRL, CPU_FTR_SMT,
  CPU_FTR_PURR, CPU_FTR_SPURR, CPU_FTR_DSCR, CPU_FTR_PKEY,
  CPU_FTR_VMX_COPY, CPU_FTR_CFAR, CPU_FTR_HAS_PPR.

To fix it we need to mask the set of ALWAYS features with the base set
of DT CPU features, ie. the features that are always enabled by DT CPU
features. That way there are no bits in the ALWAYS mask that are not
also always set by DT CPU features.

Fixes: db5ae1c155af ("powerpc/64s: Refine feature sets for little endian builds")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h | 23 +++++++++++++++++++++--
 arch/powerpc/kernel/dt_cpu_ftrs.c   | 14 +-------------
 2 files changed, 22 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index 931dda8be87c..66fcab13c8b4 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -545,18 +545,37 @@ enum {
 #ifdef CONFIG_PPC_BOOK3E
 #define CPU_FTRS_ALWAYS		(CPU_FTRS_E6500 & CPU_FTRS_E5500)
 #else
+
+#ifdef CONFIG_PPC_DT_CPU_FTRS
+#define CPU_FTRS_DT_CPU_BASE			\
+	(CPU_FTR_LWSYNC |			\
+	 CPU_FTR_FPU_UNAVAILABLE |		\
+	 CPU_FTR_NODSISRALIGN |			\
+	 CPU_FTR_NOEXECUTE |			\
+	 CPU_FTR_COHERENT_ICACHE |		\
+	 CPU_FTR_STCX_CHECKS_ADDRESS |		\
+	 CPU_FTR_POPCNTB | CPU_FTR_POPCNTD |	\
+	 CPU_FTR_DAWR |				\
+	 CPU_FTR_ARCH_206 |			\
+	 CPU_FTR_ARCH_207S)
+#else
+#define CPU_FTRS_DT_CPU_BASE	(~0ul)
+#endif
+
 #ifdef CONFIG_CPU_LITTLE_ENDIAN
 #define CPU_FTRS_ALWAYS \
 	    (CPU_FTRS_POSSIBLE & ~CPU_FTR_HVMODE & CPU_FTRS_POWER7 & \
 	     CPU_FTRS_POWER8E & CPU_FTRS_POWER8 & CPU_FTRS_POWER8_DD1 & \
-	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1)
+	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1 & \
+	     CPU_FTRS_DT_CPU_BASE)
 #else
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & \
 	     CPU_FTRS_POWER6 & CPU_FTRS_POWER7 & CPU_FTRS_CELL & \
 	     CPU_FTRS_PA6T & CPU_FTRS_POWER8 & CPU_FTRS_POWER8E & \
 	     CPU_FTRS_POWER8_DD1 & ~CPU_FTR_HVMODE & CPU_FTRS_POSSIBLE & \
-	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1)
+	     CPU_FTRS_POWER9 & CPU_FTRS_POWER9_DD1 & CPU_FTRS_POWER9_DD2_1 & \
+	     CPU_FTRS_DT_CPU_BASE)
 #endif /* CONFIG_CPU_LITTLE_ENDIAN */
 #endif
 #else
diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
index e88fbb1fdb8f..8ab51f6ca03a 100644
--- a/arch/powerpc/kernel/dt_cpu_ftrs.c
+++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
@@ -53,18 +53,6 @@ struct dt_cpu_feature {
 	int disabled;
 };
 
-#define CPU_FTRS_BASE \
-	   (CPU_FTR_LWSYNC | \
-	    CPU_FTR_FPU_UNAVAILABLE |\
-	    CPU_FTR_NODSISRALIGN |\
-	    CPU_FTR_NOEXECUTE |\
-	    CPU_FTR_COHERENT_ICACHE | \
-	    CPU_FTR_STCX_CHECKS_ADDRESS |\
-	    CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_DAWR | \
-	    CPU_FTR_ARCH_206 |\
-	    CPU_FTR_ARCH_207S)
-
 #define MMU_FTRS_HASH_BASE (MMU_FTRS_POWER8)
 
 #define COMMON_USER_BASE	(PPC_FEATURE_32 | PPC_FEATURE_64 | \
@@ -124,7 +112,7 @@ static char dt_cpu_name[64];
 
 static struct cpu_spec __initdata base_cpu_spec = {
 	.cpu_name		= NULL,
-	.cpu_features		= CPU_FTRS_BASE,
+	.cpu_features		= CPU_FTRS_DT_CPU_BASE,
 	.cpu_user_features	= COMMON_USER_BASE,
 	.cpu_user_features2	= COMMON_USER2_BASE,
 	.mmu_features		= 0,
-- 
2.14.1
