Return-Path: <anton@ozlabs.org>
Date: Fri, 30 Apr 2010 14:34:07 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/3] powerpc: Add form 1 NUMA affinity 
Message-ID: <20100430043407.GC4622@kryten>
References: <20100430043324.GB4622@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100430043324.GB4622@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Firmware changed the way it represents memory and cpu affinity on POWER7.
Unfortunately the old method now caps the topology to work around issues
with legacy operating systems. For Linux to get the correct topology we
need to use the new form 1 affinity information.

We set the form 1 field in the client architecture, and if we see "1" in the
ibm,associativity-form property firmware supports form 1 affinity and
we should look at the first field in the ibm,associativity-reference-points
array. If not we use the second field as we always have.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6.34-rc3/arch/powerpc/kernel/prom_init.c
===================================================================
--- linux-2.6.34-rc3.orig/arch/powerpc/kernel/prom_init.c	2010-04-02 07:52:10.000000000 -0500
+++ linux-2.6.34-rc3/arch/powerpc/kernel/prom_init.c	2010-04-07 07:06:45.000000000 -0500
@@ -653,6 +653,7 @@
 #else
 #define OV5_CMO			0x00
 #endif
+#define OV5_TYPE1_AFFINITY	0x80	/* Type 1 NUMA affinity */
 
 /* Option Vector 6: IBM PAPR hints */
 #define OV6_LINUX		0x02	/* Linux is our OS */
@@ -706,7 +707,7 @@
 	OV5_DONATE_DEDICATE_CPU | OV5_MSI,
 	0,
 	OV5_CMO,
-	0,
+	OV5_TYPE1_AFFINITY,
 	0,
 	0,
 	0,
Index: linux-2.6.34-rc3/arch/powerpc/mm/numa.c
===================================================================
--- linux-2.6.34-rc3.orig/arch/powerpc/mm/numa.c	2010-04-07 07:06:32.000000000 -0500
+++ linux-2.6.34-rc3/arch/powerpc/mm/numa.c	2010-04-07 09:43:48.000000000 -0500
@@ -242,10 +243,11 @@
  */
 static int __init find_min_common_depth(void)
 {
-	int depth;
+	int depth, index;
 	const unsigned int *ref_points;
 	struct device_node *rtas_root;
 	unsigned int len;
+	struct device_node *options;
 
 	rtas_root = of_find_node_by_path("/rtas");
 
@@ -258,11 +260,23 @@
 	 * configuration (should be all 0's) and the second is for a normal
 	 * NUMA configuration.
 	 */
+	index = 1;
 	ref_points = of_get_property(rtas_root,
 			"ibm,associativity-reference-points", &len);
 
+	/*
+	 * For type 1 affinity information we want the first field
+	 */
+	options = of_find_node_by_path("/options");
+	if (options) {
+		const char *str;
+		str = of_get_property(options, "ibm,associativity-form", NULL);
+		if (str && !strcmp(str, "1"))
+                        index = 0;
+	}
+
 	if ((len >= 2 * sizeof(unsigned int)) && ref_points) {
-		depth = ref_points[1];
+		depth = ref_points[index];
 	} else {
 		dbg("NUMA: ibm,associativity-reference-points not found.\n");
 		depth = -1;
