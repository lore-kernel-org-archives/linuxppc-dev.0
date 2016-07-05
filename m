Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rkCFQ6tgLzDrpX
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Jul 2016 15:32:26 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rkCFQ1cfCz9ryQ
 for <linuxppc-dev@ozlabs.org>; Tue,  5 Jul 2016 15:32:25 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 34/41] powerpc/32: Move cache info inits to a separate function
Date: Tue,  5 Jul 2016 15:04:10 +1000
Message-Id: <1467695057-12431-35-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
References: <1467695057-12431-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matches 64-bit. Also move the call to the same spot as ppc64

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_32.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 22347e87..5457911 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -248,6 +248,21 @@ static void setup_power_save(void)
 #endif
 }
 
+static __init void initialize_cache_info(void)
+{
+	/*
+	 * Set cache line size based on type of cpu as a default.
+	 * Systems with OF can look in the properties on the cpu node(s)
+	 * for a possibly more accurate value.
+	 */
+	dcache_bsize = cur_cpu_spec->dcache_bsize;
+	icache_bsize = cur_cpu_spec->icache_bsize;
+	ucache_bsize = 0;
+	if (cpu_has_feature(CPU_FTR_UNIFIED_ID_CACHE))
+		ucache_bsize = icache_bsize = dcache_bsize;
+}
+
+
 /* Warning, IO base is not yet inited */
 void __init setup_arch(char **cmdline_p)
 {
@@ -257,6 +272,7 @@ void __init setup_arch(char **cmdline_p)
 	loops_per_jiffy = 500000000 / HZ;
 
 	unflatten_device_tree();
+	initialize_cache_info();
 	check_for_initrd();
 
 	probe_machine();
@@ -272,17 +288,6 @@ void __init setup_arch(char **cmdline_p)
 
 	xmon_setup();
 
-	/*
-	 * Set cache line size based on type of cpu as a default.
-	 * Systems with OF can look in the properties on the cpu node(s)
-	 * for a possibly more accurate value.
-	 */
-	dcache_bsize = cur_cpu_spec->dcache_bsize;
-	icache_bsize = cur_cpu_spec->icache_bsize;
-	ucache_bsize = 0;
-	if (cpu_has_feature(CPU_FTR_UNIFIED_ID_CACHE))
-		ucache_bsize = icache_bsize = dcache_bsize;
-
 	if (ppc_md.panic)
 		setup_panic();
 
-- 
2.7.4
