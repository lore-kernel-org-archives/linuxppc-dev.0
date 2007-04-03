Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F09F1DDF27
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Apr 2007 22:52:29 +1000 (EST)
Date: Tue, 3 Apr 2007 22:28:41 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 03/17] [POWERPC] Rename get_property to of_get_property:
	arch/powerpc/mm
Message-Id: <20070403222841.a2c6af1c.sfr@canb.auug.org.au>
In-Reply-To: <20070403222641.e93cb73b.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403105401.1fcdee27.sfr@canb.auug.org.au>
	<20070403105539.7222cf2a.sfr@canb.auug.org.au>
	<20070403105650.204003b6.sfr@canb.auug.org.au>
	<20070403105748.769f156c.sfr@canb.auug.org.au>
	<20070403105852.7c7bfaa0.sfr@canb.auug.org.au>
	<20070403222406.cf39c459.sfr@canb.auug.org.au>
	<20070403222641.e93cb73b.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/mm/hash_native_64.c |    2 +-
 arch/powerpc/mm/numa.c           |   20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index 6f1016a..79aedaf 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -505,7 +505,7 @@ static inline int tlb_batching_enabled(void)
 	int enabled = 1;
 
 	if (root) {
-		const char *model = get_property(root, "model", NULL);
+		const char *model = of_get_property(root, "model", NULL);
 		if (model && !strcmp(model, "IBM,9076-N81"))
 			enabled = 0;
 		of_node_put(root);
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 683839b..b3a592b 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -74,7 +74,7 @@ static struct device_node * __cpuinit find_cpu_node(unsigned int cpu)
 
 	while ((cpu_node = of_find_node_by_type(cpu_node, "cpu")) != NULL) {
 		/* Try interrupt server first */
-		interrupt_server = get_property(cpu_node,
+		interrupt_server = of_get_property(cpu_node,
 					"ibm,ppc-interrupt-server#s", &len);
 
 		len = len / sizeof(u32);
@@ -85,7 +85,7 @@ static struct device_node * __cpuinit find_cpu_node(unsigned int cpu)
 					return cpu_node;
 			}
 		} else {
-			reg = get_property(cpu_node, "reg", &len);
+			reg = of_get_property(cpu_node, "reg", &len);
 			if (reg && (len > 0) && (reg[0] == hw_cpuid))
 				return cpu_node;
 		}
@@ -97,7 +97,7 @@ static struct device_node * __cpuinit find_cpu_node(unsigned int cpu)
 /* must hold reference to node during call */
 static const int *of_get_associativity(struct device_node *dev)
 {
-	return get_property(dev, "ibm,associativity", NULL);
+	return of_get_property(dev, "ibm,associativity", NULL);
 }
 
 /* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
@@ -179,7 +179,7 @@ static int __init find_min_common_depth(void)
 	 * configuration (should be all 0's) and the second is for a normal
 	 * NUMA configuration.
 	 */
-	ref_points = get_property(rtas_root,
+	ref_points = of_get_property(rtas_root,
 			"ibm,associativity-reference-points", &len);
 
 	if ((len >= 1) && ref_points) {
@@ -308,9 +308,9 @@ static void __init parse_drconf_memory(struct device_node *memory)
 	int nid, default_nid = 0;
 	unsigned int start, ai, flags;
 
-	lm = get_property(memory, "ibm,lmb-size", &ls);
-	dm = get_property(memory, "ibm,dynamic-memory", &ld);
-	aa = get_property(memory, "ibm,associativity-lookup-arrays", &la);
+	lm = of_get_property(memory, "ibm,lmb-size", &ls);
+	dm = of_get_property(memory, "ibm,dynamic-memory", &ld);
+	aa = of_get_property(memory, "ibm,associativity-lookup-arrays", &la);
 	if (!lm || !dm || !aa ||
 	    ls < sizeof(unsigned int) || ld < sizeof(unsigned int) ||
 	    la < 2 * sizeof(unsigned int))
@@ -404,10 +404,10 @@ static int __init parse_numa_properties(void)
 		const unsigned int *memcell_buf;
 		unsigned int len;
 
-		memcell_buf = get_property(memory,
+		memcell_buf = of_get_property(memory,
 			"linux,usable-memory", &len);
 		if (!memcell_buf || len <= 0)
-			memcell_buf = get_property(memory, "reg", &len);
+			memcell_buf = of_get_property(memory, "reg", &len);
 		if (!memcell_buf || len <= 0)
 			continue;
 
@@ -725,7 +725,7 @@ int hot_add_scn_to_nid(unsigned long scn_addr)
 		const unsigned int *memcell_buf;
 		unsigned int len;
 
-		memcell_buf = get_property(memory, "reg", &len);
+		memcell_buf = of_get_property(memory, "reg", &len);
 		if (!memcell_buf || len <= 0)
 			continue;
 
-- 
1.5.0.3
