Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 065A91007D1
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Apr 2011 22:29:30 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/book3e: Fix CPU feature handling on 64-bit e5500
Date: Wed,  6 Apr 2011 07:29:03 -0500
Message-Id: <1302092943-10586-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The CPU_FTRS_POSSIBLE and CPU_FTRS_ALWAYS defines did not encompass
e5500 CPU features when built for 64-bit.  This causes issues with
cpu_has_feature() as it utilizes the POSSIBLE & ALWAYS defines as part
of its check.

Create a unique CPU_FTRS_E5500 (as its different from CPU_FTRS_E500MC),
created a new group for 64-bit Book3e based CPUs and add CPU_FTRS_E5500
to that group.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
* This patch is intened to fix some issues and I'd like to see it in v2.6.39

- k

 arch/powerpc/include/asm/cputable.h |   14 ++++++++++++++
 arch/powerpc/kernel/cputable.c      |    2 +-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index be3cdf9..9028a9e 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -386,6 +386,10 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
 	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
 	    CPU_FTR_DBELL)
+#define CPU_FTRS_E5500	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
+	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_NODSISRALIGN | \
+	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC | CPU_FTR_NOEXECUTE | \
+	    CPU_FTR_DBELL | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)
 
 /* 64-bit CPUs */
@@ -435,11 +439,15 @@ extern const char *powerpc_base_platform;
 #define CPU_FTRS_COMPATIBLE	(CPU_FTR_USE_TB | CPU_FTR_PPCAS_ARCH_V2)
 
 #ifdef __powerpc64__
+#ifdef CONFIG_PPC_BOOK3E
+#define CPU_FTRS_POSSIBLE	(CPU_FTRS_E5500)
+#else
 #define CPU_FTRS_POSSIBLE	\
 	    (CPU_FTRS_POWER3 | CPU_FTRS_RS64 | CPU_FTRS_POWER4 |	\
 	    CPU_FTRS_PPC970 | CPU_FTRS_POWER5 | CPU_FTRS_POWER6 |	\
 	    CPU_FTRS_POWER7 | CPU_FTRS_CELL | CPU_FTRS_PA6T |		\
 	    CPU_FTR_1T_SEGMENT | CPU_FTR_VSX)
+#endif
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
@@ -473,16 +481,21 @@ enum {
 #endif
 #ifdef CONFIG_E500
 	    CPU_FTRS_E500 | CPU_FTRS_E500_2 | CPU_FTRS_E500MC |
+	    CPU_FTRS_E5500 |
 #endif
 	    0,
 };
 #endif /* __powerpc64__ */
 
 #ifdef __powerpc64__
+#ifdef CONFIG_PPC_BOOK3E
+#define CPU_FTRS_ALWAYS		(CPU_FTRS_E5500)
+#else
 #define CPU_FTRS_ALWAYS		\
 	    (CPU_FTRS_POWER3 & CPU_FTRS_RS64 & CPU_FTRS_POWER4 &	\
 	    CPU_FTRS_PPC970 & CPU_FTRS_POWER5 & CPU_FTRS_POWER6 &	\
 	    CPU_FTRS_POWER7 & CPU_FTRS_CELL & CPU_FTRS_PA6T & CPU_FTRS_POSSIBLE)
+#endif
 #else
 enum {
 	CPU_FTRS_ALWAYS =
@@ -513,6 +526,7 @@ enum {
 #endif
 #ifdef CONFIG_E500
 	    CPU_FTRS_E500 & CPU_FTRS_E500_2 & CPU_FTRS_E500MC &
+	    CPU_FTRS_E5500 &
 #endif
 	    CPU_FTRS_POSSIBLE,
 };
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c9b68d0..b9602ee 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -1973,7 +1973,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x80240000,
 		.cpu_name		= "e5500",
-		.cpu_features		= CPU_FTRS_E500MC,
+		.cpu_features		= CPU_FTRS_E5500,
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.mmu_features		= MMU_FTR_TYPE_FSL_E | MMU_FTR_BIG_PHYS |
 			MMU_FTR_USE_TLBILX,
-- 
1.7.3.4
