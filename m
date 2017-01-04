Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ttfFR3QX3zDqSr
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jan 2017 16:17:15 +1100 (AEDT)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Steven Munroe <munroesj@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 7/9] powerpc/64: Add L2 and L3 cache shape info
Date: Wed,  4 Jan 2017 16:15:33 +1100
Message-Id: <20170104051535.9454-7-benh@kernel.crashing.org>
In-Reply-To: <20170104051535.9454-1-benh@kernel.crashing.org>
References: <20170104051535.9454-1-benh@kernel.crashing.org>
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
 arch/powerpc/kernel/setup_64.c   | 25 ++++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

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
index e2946a7..216e305 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -457,22 +457,37 @@ static bool __init parse_cache_info(struct device_node *np,
 
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
-- 
2.9.3
