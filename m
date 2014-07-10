Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BB751A014B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 12:29:33 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/9] powerpc: Remove CONFIG_POWER3
Date: Thu, 10 Jul 2014 12:29:22 +1000
Message-Id: <1404959366-17664-5-git-send-email-mpe@ellerman.id.au>
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

Now that we have dropped power3 support we can remove CONFIG_POWER3. The
usage in pgtable_32.c was already dead code as CONFIG_POWER3 was not
selectable on PPC32.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cputable.h    | 3 +--
 arch/powerpc/mm/pgtable_32.c           | 2 +-
 arch/powerpc/platforms/Kconfig.cputype | 4 ----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index ed17bc75b0a6..bff747eea06b 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -268,8 +268,7 @@ extern const char *powerpc_base_platform;
 #endif
 
 #define CLASSIC_PPC (!defined(CONFIG_8xx) && !defined(CONFIG_4xx) && \
-		     !defined(CONFIG_POWER3) && !defined(CONFIG_POWER4) && \
-		     !defined(CONFIG_BOOKE))
+		     !defined(CONFIG_POWER4) && !defined(CONFIG_BOOKE))
 
 #define CPU_FTRS_PPC601	(CPU_FTR_COMMON | CPU_FTR_601 | \
 	CPU_FTR_COHERENT_ICACHE | CPU_FTR_UNIFIED_ID_CACHE)
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 343a87fa78b5..cf11342bf519 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -41,7 +41,7 @@ unsigned long ioremap_base;
 unsigned long ioremap_bot;
 EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
-#if defined(CONFIG_6xx) || defined(CONFIG_POWER3)
+#ifdef CONFIG_6xx
 #define HAVE_BATS	1
 #endif
 
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index a41bd023647a..798e6add1cae 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -140,10 +140,6 @@ config 6xx
 	depends on PPC32 && PPC_BOOK3S
 	select PPC_HAVE_PMU_SUPPORT
 
-config POWER3
-	depends on PPC64 && PPC_BOOK3S
-	def_bool y
-
 config POWER4
 	depends on PPC64 && PPC_BOOK3S
 	def_bool y
-- 
1.9.1
