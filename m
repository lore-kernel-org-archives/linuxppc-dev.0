Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <7e33ed902c36baf8e09f52699433c6ef6be729cd.1302504287.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Look for ibm,
	associativity-reference-points at the root
Date: Mon, 11 Apr 2011 16:42:05 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we don't find ibm,associativity-reference-points as a child of
/rtas, look for it at the root of the tree instead. We use this on
Book3E where we have no RTAS but still use the sPAPR conventions
for NUMA.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/mm/numa.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 0dc95c0..6e90986 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -311,14 +311,13 @@ EXPORT_SYMBOL_GPL(of_node_to_nid);
 static int __init find_min_common_depth(void)
 {
 	int depth;
-	struct device_node *rtas_root;
 	struct device_node *chosen;
+	struct device_node *root;
 	const char *vec5;
 
-	rtas_root = of_find_node_by_path("/rtas");
-
-	if (!rtas_root)
-		return -1;
+	root = of_find_node_by_path("/rtas");
+	if (!root)
+		root = of_find_node_by_path("/");
 
 	/*
 	 * This property is a set of 32-bit integers, each representing
@@ -332,7 +331,7 @@ static int __init find_min_common_depth(void)
 	 * NUMA boundary and the following are progressively less significant
 	 * boundaries. There can be more than one level of NUMA.
 	 */
-	distance_ref_points = of_get_property(rtas_root,
+	distance_ref_points = of_get_property(root,
 					"ibm,associativity-reference-points",
 					&distance_ref_points_depth);
 
@@ -376,11 +375,11 @@ static int __init find_min_common_depth(void)
 		distance_ref_points_depth = MAX_DISTANCE_REF_POINTS;
 	}
 
-	of_node_put(rtas_root);
+	of_node_put(root);
 	return depth;
 
 err:
-	of_node_put(rtas_root);
+	of_node_put(root);
 	return -1;
 }
 
-- 
1.7.1
