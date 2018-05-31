Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xF3g2BhZzDrcW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 May 2018 14:34:23 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 06/11] powerpc/prom_init: Move prom_radix_disable to
 __prombss
Date: Thu, 31 May 2018 14:33:44 +1000
Message-Id: <20180531043349.24783-7-benh@kernel.crashing.org>
In-Reply-To: <20180531043349.24783-1-benh@kernel.crashing.org>
References: <20180531043349.24783-1-benh@kernel.crashing.org>
Reply-To: [RFC.PATCH.00/11]prom_init.cleanups.and.sanitization@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initialize it dynamically instead of statically

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/prom_init.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 7c3d285750ad..6a7549f64e28 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -173,7 +173,9 @@ static unsigned long __prombss prom_tce_alloc_start;
 static unsigned long __prombss prom_tce_alloc_end;
 #endif
 
-static bool prom_radix_disable __initdata = !IS_ENABLED(CONFIG_PPC_RADIX_MMU_DEFAULT);
+#ifdef CONFIG_PPC_PSERIES
+static bool prom_radix_disable __prombss;
+#endif
 
 struct platform_support {
 	bool hash_mmu;
@@ -640,6 +642,8 @@ static void __init early_cmdline_parse(void)
 #endif
 	}
 
+#ifdef CONFIG_PPC_PSERIES
+	prom_radix_disable = !IS_ENABLED(CONFIG_PPC_RADIX_MMU_DEFAULT);
 	opt = strstr(prom_cmd_line, "disable_radix");
 	if (opt) {
 		opt += 13;
@@ -655,6 +659,7 @@ static void __init early_cmdline_parse(void)
 	}
 	if (prom_radix_disable)
 		prom_debug("Radix disabled from cmdline\n");
+#endif /* CONFIG_PPC_PSERIES */
 }
 
 #ifdef CONFIG_PPC_PSERIES
-- 
2.17.0
