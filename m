Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFDZL0JXrzDqDT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Feb 2017 22:06:18 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 7/9] powerpc/64: Add L2 and L3 cache shape info
Date: Fri,  3 Feb 2017 22:05:57 +1100
Message-Id: <1486119959-21662-7-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1486119959-21662-1-git-send-email-mpe@ellerman.id.au>
References: <1486119959-21662-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Retrieved from device-tree when available

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/cache.h |  2 ++
 arch/powerpc/kernel/setup_64.c   | 26 +++++++++++++++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index 823750fa6e66..d7cf60f87604 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -43,6 +43,8 @@ struct ppc_cache_info {
 struct ppc64_caches {
 	struct ppc_cache_info l1d;
 	struct ppc_cache_info l1i;
+	struct ppc_cache_info l2;
+	struct ppc_cache_info l3;
 };
 
 extern struct ppc64_caches ppc64_caches;
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b87dcb2968d9..db18f7b68a1d 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -472,22 +472,38 @@ static bool __init parse_cache_info(struct device_node *np,
 
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
+		/*
+		 * Try to find the L2 and L3 if any. Assume they are
+		 * unified and use the D-side properties.
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
2.7.4
