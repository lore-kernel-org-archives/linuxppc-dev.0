Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sDdS526DZzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Aug 2016 15:43:17 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3sDdS44Skyz9sRB
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2016 15:43:16 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 09/10] powerpc/64: Add L2 and L3 cache shape info
Date: Wed, 17 Aug 2016 15:39:16 +1000
Message-Id: <1471412357-3477-9-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
References: <1471412357-3477-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Retrieved from device-tree when available

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/cache.h |  2 ++
 arch/powerpc/kernel/setup_64.c   | 27 ++++++++++++++++++++++-----
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index ceb7376..3987bd9 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -40,6 +40,8 @@ struct ppc_cache_info {
 struct ppc64_caches {
 	struct ppc_cache_info l1d;
 	struct ppc_cache_info l1i;
+	struct ppc_cache_info l2;
+	struct ppc_cache_info l3;
 };
 
 extern struct ppc64_caches ppc64_caches;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 80a20b9..78d28ca 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -485,22 +485,37 @@ static bool __init parse_cache_info(struct device_node *np,
 
 void __init initialize_cache_info(void)
 {
-	struct device_node *np;
+	struct device_node *cpu, *l2, *l3 = NULL;
 
 	DBG(" -> initialize_cache_info()\n");
 
-	np  = of_find_node_by_type(NULL, "cpu");
+	cpu = of_find_node_by_type(NULL, "cpu");
 
 	/*
 	 * We're assuming *all* of the CPUs have the same
 	 * d-cache and i-cache sizes... -Peter
 	 */
-	if (np) {
-		if (!parse_cache_info(np, false, &ppc64_caches.l1d))
+	if (cpu) {
+		if (!parse_cache_info(cpu, false, &ppc64_caches.l1d))
 			DBG("Argh, can't find dcache properties !\n");
 
-		if (!parse_cache_info(np, true, &ppc64_caches.l1i))
+		if (!parse_cache_info(cpu, true, &ppc64_caches.l1i))
 			DBG("Argh, can't find icache properties !\n");
+
+		/* Try to find the L2 and L3 if any. Assume they are
+		 * unified and use the D-side properties
+		 */
+		l2 = of_find_next_cache_node(cpu);
+		of_node_put(cpu);
+		if (l2) {
+			parse_cache_info(l2, false, &ppc64_caches.l2);
+			l3 = of_find_next_cache_node(l2);
+			of_node_put(l2);
+		}
+		if (l3) {
+			parse_cache_info(l3, false, &ppc64_caches.l3);
+			of_node_put(l3);
+		}
 	}
 
 	/* For use by binfmt_elf */
@@ -508,6 +523,8 @@ void __init initialize_cache_info(void)
 	icache_bsize = ppc64_caches.l1i.block_size;
 	dl1cache_shape = format_cache_shape(&ppc64_caches.l1d);
 	il1cache_shape = format_cache_shape(&ppc64_caches.l1i);
+	l2cache_shape = format_cache_shape(&ppc64_caches.l2);
+	l3cache_shape = format_cache_shape(&ppc64_caches.l3);
 
 	DBG(" <- initialize_cache_info()\n");
 }
-- 
2.7.4
