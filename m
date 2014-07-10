Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0D3B01A0138
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:29:35 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 9/9] powerpc: Move CLASSIC_PPC into Kconfig and rename
Date: Thu, 10 Jul 2014 12:29:26 +1000
Message-Id: <1404959366-17664-9-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
References: <1404959366-17664-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a strange #define in cputable.h called CLASSIC_PPC. It is true
when no other more modern platform is defined, and indicates that we're
building for a "classic" platform.

Although it is defined for 32 & 64bit, it's only used for 32bit. So for
starters, rename it to indicate that. There's also no reason for it not
to be in Kconfig, so move it there.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h    | 7 ++-----
 arch/powerpc/kernel/cputable.c         | 4 ++--
 arch/powerpc/platforms/Kconfig.cputype | 6 +++++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index f1027481da0f..af5598688daf 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -267,9 +267,6 @@ extern const char *powerpc_base_platform;
 #define CPU_FTR_MAYBE_CAN_NAP	0
 #endif
 
-#define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx) && \
-		     !defined(CONFIG_BOOKE))
-
 #define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | \
 	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE)
 #define CPU_FTRS_603	(CPU_FTR_COMMON | \
@@ -466,7 +463,7 @@ extern const char *powerpc_base_platform;
 #else
 enum {
 	CPU_FTRS_POSSIBLE =
-#if CLASSIC_PPC
+#ifdef CONFIG_CLASSIC_PPC32
 	    CPU_FTRS_PPC601 | CPU_FTRS_603 | CPU_FTRS_604 | CPU_FTRS_740_NOTAU |
 	    CPU_FTRS_740 | CPU_FTRS_750 | CPU_FTRS_750FX1 |
 	    CPU_FTRS_750FX2 | CPU_FTRS_750FX | CPU_FTRS_750GX |
@@ -516,7 +513,7 @@ enum {
 #else
 enum {
 	CPU_FTRS_ALWAYS =
-#if CLASSIC_PPC
+#ifdef CONFIG_CLASSIC_PPC32
 	    CPU_FTRS_PPC601 & CPU_FTRS_603 & CPU_FTRS_604 & CPU_FTRS_740_NOTAU &
 	    CPU_FTRS_740 & CPU_FTRS_750 & CPU_FTRS_750FX1 &
 	    CPU_FTRS_750FX2 & CPU_FTRS_750FX & CPU_FTRS_750GX &
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 4728c0885d83..e7b2ea906838 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -507,7 +507,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 #endif	/* CONFIG_PPC_BOOK3S_64 */
 
 #ifdef CONFIG_PPC32
-#if CLASSIC_PPC
+#ifdef CONFIG_CLASSIC_PPC32
 	{	/* 601 */
 		.pvr_mask		= 0xffff0000,
 		.pvr_value		= 0x00010000,
@@ -1147,7 +1147,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.machine_check		= machine_check_generic,
 		.platform		= "ppc603",
 	},
-#endif /* CLASSIC_PPC */
+#endif /* CONFIG_CLASSIC_PPC32 */
 #ifdef CONFIG_8xx
 	{	/* 8xx */
 		.pvr_mask		= 0xffff0000,
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index f03e7d0d76f8..5fe116bf9883 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -61,7 +61,7 @@ choice
 	help
 	  There are two families of 64 bit PowerPC chips supported.
 	  The most common ones are the desktop and server CPUs
-	  (POWER3, RS64, POWER4, POWER5, POWER5+, POWER6, ...)
+	  (POWER4, POWER5, 970, POWER5+, POWER6, POWER7, POWER8 ...)
 
 	  The other are the "embedded" processors compliant with the
 	  "Book 3E" variant of the architecture
@@ -140,6 +140,10 @@ config 6xx
 	depends on PPC32 && PPC_BOOK3S
 	select PPC_HAVE_PMU_SUPPORT
 
+config CLASSIC_PPC32
+	depends on PPC32 && !8xx && !4xx && !BOOKE
+	def_bool y
+
 config TUNE_CELL
 	bool "Optimize for Cell Broadband Engine"
 	depends on PPC64 && PPC_BOOK3S
-- 
1.9.1
