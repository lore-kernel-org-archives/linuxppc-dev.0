Return-Path: <anton@ozlabs.org>
Date: Mon, 17 May 2010 16:22:31 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 3/3] powerpc: numa: Use form 1 affinity to setup node distance
Message-ID: <20100517062231.GB25848@kryten>
References: <20100517061956.GE13509@kryten>
 <20100517062157.GA25848@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100517062157.GA25848@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Form 1 affinity allows multiple entries in ibm,associativity-reference-points
which represent affinity domains in decreasing order of importance. The
Linux concept of a node is always the first entry, but using the other
values as an input to node_distance() allows the memory allocator to make
better decisions on which node to go first when local memory has been
exhausted.

We keep things simple and create an array indexed by NUMA node, capped at
4 entries. Each time we lookup an associativity property we initialise
the array which is overkill, but since we should only hit this path during
boot it didn't seem worth adding a per node valid bit.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.git.orig/arch/powerpc/mm/numa.c	2010-05-17 15:01:40.345954329 +1000
+++ powerpc.git/arch/powerpc/mm/numa.c	2010-05-17 15:01:43.334704959 +1000
@@ -42,6 +42,12 @@ EXPORT_SYMBOL(node_data);
 
 static int min_common_depth;
 static int n_mem_addr_cells, n_mem_size_cells;
+static int form1_affinity;
+
+#define MAX_DISTANCE_REF_POINTS 4
+static int distance_ref_points_depth;
+static const unsigned int *distance_ref_points;
+static int distance_lookup_table[MAX_NUMNODES][MAX_DISTANCE_REF_POINTS];
 
 /*
  * Allocate node_to_cpumask_map based on number of available nodes
@@ -204,6 +210,39 @@ static const u32 *of_get_usable_memory(s
 	return prop;
 }
 
+int __node_distance(int a, int b)
+{
+	int i;
+	int distance = LOCAL_DISTANCE;
+
+	if (!form1_affinity)
+		return distance;
+
+	for (i = 0; i < distance_ref_points_depth; i++) {
+		if (distance_lookup_table[a][i] == distance_lookup_table[b][i])
+			break;
+
+		/* Double the distance for each NUMA level */
+		distance *= 2;
+	}
+
+	return distance;
+}
+
+static void initialize_distance_lookup_table(int nid,
+		const unsigned int *associativity)
+{
+	int i;
+
+	if (!form1_affinity)
+		return;
+
+	for (i = 0; i < distance_ref_points_depth; i++) {
+		distance_lookup_table[nid][i] =
+			associativity[distance_ref_points[i]];
+	}
+}
+
 /* Returns nid in the range [0..MAX_NUMNODES-1], or -1 if no useful numa
  * info is found.
  */
@@ -225,6 +264,10 @@ static int of_node_to_nid_single(struct 
 	/* POWER4 LPAR uses 0xffff as invalid node */
 	if (nid == 0xffff || nid >= MAX_NUMNODES)
 		nid = -1;
+
+	if (nid > 0 && tmp[0] >= distance_ref_points_depth)
+		initialize_distance_lookup_table(nid, tmp);
+
 out:
 	return nid;
 }
@@ -251,26 +294,10 @@ int of_node_to_nid(struct device_node *d
 }
 EXPORT_SYMBOL_GPL(of_node_to_nid);
 
-/*
- * In theory, the "ibm,associativity" property may contain multiple
- * associativity lists because a resource may be multiply connected
- * into the machine.  This resource then has different associativity
- * characteristics relative to its multiple connections.  We ignore
- * this for now.  We also assume that all cpu and memory sets have
- * their distances represented at a common level.  This won't be
- * true for hierarchical NUMA.
- *
- * In any case the ibm,associativity-reference-points should give
- * the correct depth for a normal NUMA system.
- *
- * - Dave Hansen <haveblue@us.ibm.com>
- */
 static int __init find_min_common_depth(void)
 {
-	int depth, index;
-	const unsigned int *ref_points;
+	int depth;
 	struct device_node *rtas_root;
-	unsigned int len;
 	struct device_node *chosen;
 	const char *vec5;
 
@@ -280,18 +307,28 @@ static int __init find_min_common_depth(
 		return -1;
 
 	/*
-	 * this property is 2 32-bit integers, each representing a level of
-	 * depth in the associativity nodes.  The first is for an SMP
-	 * configuration (should be all 0's) and the second is for a normal
-	 * NUMA configuration.
+	 * This property is a set of 32-bit integers, each representing
+	 * an index into the ibm,associativity nodes.
+	 *
+	 * With form 0 affinity the first integer is for an SMP configuration
+	 * (should be all 0's) and the second is for a normal NUMA
+	 * configuration. We have only one level of NUMA.
+	 *
+	 * With form 1 affinity the first integer is the most significant
+	 * NUMA boundary and the following are progressively less significant
+	 * boundaries. There can be more than one level of NUMA.
 	 */
-	index = 1;
-	ref_points = of_get_property(rtas_root,
-			"ibm,associativity-reference-points", &len);
+	distance_ref_points = of_get_property(rtas_root,
+					"ibm,associativity-reference-points",
+					&distance_ref_points_depth);
+
+	if (!distance_ref_points) {
+		dbg("NUMA: ibm,associativity-reference-points not found.\n");
+		goto err;
+	}
+
+	distance_ref_points_depth /= sizeof(int);
 
-	/*
-	 * For form 1 affinity information we want the first field
-	 */
 #define VEC5_AFFINITY_BYTE	5
 #define VEC5_AFFINITY		0x80
 	chosen = of_find_node_by_path("/chosen");
@@ -299,19 +336,38 @@ static int __init find_min_common_depth(
 		vec5 = of_get_property(chosen, "ibm,architecture-vec-5", NULL);
 		if (vec5 && (vec5[VEC5_AFFINITY_BYTE] & VEC5_AFFINITY)) {
 			dbg("Using form 1 affinity\n");
-			index = 0;
+			form1_affinity = 1;
 		}
 	}
 
-	if ((len >= 2 * sizeof(unsigned int)) && ref_points) {
-		depth = ref_points[index];
+	if (form1_affinity) {
+		depth = distance_ref_points[0];
 	} else {
-		dbg("NUMA: ibm,associativity-reference-points not found.\n");
-		depth = -1;
+		if (distance_ref_points_depth < 2) {
+			printk(KERN_WARNING "NUMA: "
+				"short ibm,associativity-reference-points\n");
+			goto err;
+		}
+
+		depth = distance_ref_points[1];
 	}
-	of_node_put(rtas_root);
 
+	/*
+	 * Warn and cap if the hardware supports more than
+	 * MAX_DISTANCE_REF_POINTS domains.
+	 */
+	if (distance_ref_points_depth > MAX_DISTANCE_REF_POINTS) {
+		printk(KERN_WARNING "NUMA: distance array capped at "
+			"%d entries\n", MAX_DISTANCE_REF_POINTS);
+		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
+	}
+
+	of_node_put(rtas_root);
 	return depth;
+
+err:
+	of_node_put(rtas_root);
+	return -1;
 }
 
 static void __init get_n_mem_cells(int *n_addr_cells, int *n_size_cells)
Index: powerpc.git/arch/powerpc/include/asm/topology.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/topology.h	2010-05-17 15:01:37.514703571 +1000
+++ powerpc.git/arch/powerpc/include/asm/topology.h	2010-05-17 15:01:43.334704959 +1000
@@ -87,6 +87,9 @@ static inline int pcibus_to_node(struct 
 	.balance_interval	= 1,					\
 }
 
+extern int __node_distance(int, int);
+#define node_distance(a, b) __node_distance(a, b)
+
 extern void __init dump_numa_cpu_topology(void);
 
 extern int sysfs_add_device_to_node(struct sys_device *dev, int nid);
