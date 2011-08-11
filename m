Return-Path: <anton@samba.org>
Message-Id: <20110811064427.685158581@samba.org>
Date: Thu, 11 Aug 2011 16:44:23 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org,
 paulus@samba.org,
 sfr@ozlabs.org
Subject: [PATCH 3/4] [PATCH] powerpc: Coding style cleanups
References: <20110811064427.515781037@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

While converting code to use for_each_node_by_type I noticed a
number of coding style issues.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-powerpc/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/kernel/setup_64.c	2011-08-10 16:19:00.629356097 +1000
+++ linux-powerpc/arch/powerpc/kernel/setup_64.c	2011-08-10 16:21:31.642031299 +1000
@@ -281,11 +281,11 @@ static void __init initialize_cache_info
 	for_each_node_by_type(np, "cpu") {
 		num_cpus += 1;
 
-		/* We're assuming *all* of the CPUs have the same
+		/*
+		 * We're assuming *all* of the CPUs have the same
 		 * d-cache and i-cache sizes... -Peter
 		 */
-
-		if ( num_cpus == 1 ) {
+		if (num_cpus == 1) {
 			const u32 *sizep, *lsizep;
 			u32 size, lsize;
 
@@ -294,10 +294,13 @@ static void __init initialize_cache_info
 			sizep = of_get_property(np, "d-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
-			lsizep = of_get_property(np, "d-cache-block-size", NULL);
+			lsizep = of_get_property(np, "d-cache-block-size",
+						 NULL);
 			/* fallback if block size missing */
 			if (lsizep == NULL)
-				lsizep = of_get_property(np, "d-cache-line-size", NULL);
+				lsizep = of_get_property(np,
+							 "d-cache-line-size",
+							 NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
@@ -314,9 +317,12 @@ static void __init initialize_cache_info
 			sizep = of_get_property(np, "i-cache-size", NULL);
 			if (sizep != NULL)
 				size = *sizep;
-			lsizep = of_get_property(np, "i-cache-block-size", NULL);
+			lsizep = of_get_property(np, "i-cache-block-size",
+						 NULL);
 			if (lsizep == NULL)
-				lsizep = of_get_property(np, "i-cache-line-size", NULL);
+				lsizep = of_get_property(np,
+							 "i-cache-line-size",
+							 NULL);
 			if (lsizep != NULL)
 				lsize = *lsizep;
 			if (sizep == 0 || lsizep == 0)
Index: linux-powerpc/arch/powerpc/mm/numa.c
===================================================================
--- linux-powerpc.orig/arch/powerpc/mm/numa.c	2011-08-10 16:19:57.080356036 +1000
+++ linux-powerpc/arch/powerpc/mm/numa.c	2011-08-10 16:20:46.981240046 +1000
@@ -709,7 +709,6 @@ static void __init parse_drconf_memory(s
 
 static int __init parse_numa_properties(void)
 {
-	struct device_node *cpu = NULL;
 	struct device_node *memory;
 	int default_nid = 0;
 	unsigned long i;
@@ -732,6 +731,7 @@ static int __init parse_numa_properties(
 	 * each node to be onlined must have NODE_DATA etc backing it.
 	 */
 	for_each_present_cpu(i) {
+		struct device_node *cpu;
 		int nid;
 
 		cpu = of_get_cpu_node(i, NULL);
@@ -800,8 +800,9 @@ new_range:
 	}
 
 	/*
-	 * Now do the same thing for each MEMBLOCK listed in the ibm,dynamic-memory
-	 * property in the ibm,dynamic-reconfiguration-memory node.
+	 * Now do the same thing for each MEMBLOCK listed in the
+	 * ibm,dynamic-memory property in the
+	 * ibm,dynamic-reconfiguration-memory node.
 	 */
 	memory = of_find_node_by_path("/ibm,dynamic-reconfiguration-memory");
 	if (memory)
