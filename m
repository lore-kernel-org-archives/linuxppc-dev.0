Return-Path: <anton@ozlabs.org>
Date: Mon, 17 May 2010 16:28:35 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/3] powerpc: numa: Use ibm,architecture-vec-5 to detect
	form 1 affinity
Message-ID: <20100517062835.GA26162@kryten>
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


I've been told that the architected way to determine we are in form 1
affinity mode is by reading the ibm,architecture-vec-5 property which
mirrors the layout of the fifth vector of the ibm,client-architecture
structure.

Eventually we may want to parse the ibm,architecture-vec-5 and create
FW_FEATURE_* bits. 

Signed-off-by: Anton Blanchard <anton@samba.org>
---

v2: I said "fifth byte of the ibm,client-architecture" when I should have
said "fifth vector of the ibm,client-architecture"

Index: powerpc.git/arch/powerpc/mm/numa.c
===================================================================
--- powerpc.git.orig/arch/powerpc/mm/numa.c	2010-05-17 12:56:02.000000000 +1000
+++ powerpc.git/arch/powerpc/mm/numa.c	2010-05-17 15:01:40.345954329 +1000
@@ -271,7 +271,8 @@ static int __init find_min_common_depth(
 	const unsigned int *ref_points;
 	struct device_node *rtas_root;
 	unsigned int len;
-	struct device_node *options;
+	struct device_node *chosen;
+	const char *vec5;
 
 	rtas_root = of_find_node_by_path("/rtas");
 
@@ -289,14 +290,17 @@ static int __init find_min_common_depth(
 			"ibm,associativity-reference-points", &len);
 
 	/*
-	 * For type 1 affinity information we want the first field
+	 * For form 1 affinity information we want the first field
 	 */
-	options = of_find_node_by_path("/options");
-	if (options) {
-		const char *str;
-		str = of_get_property(options, "ibm,associativity-form", NULL);
-		if (str && !strcmp(str, "1"))
-                        index = 0;
+#define VEC5_AFFINITY_BYTE	5
+#define VEC5_AFFINITY		0x80
+	chosen = of_find_node_by_path("/chosen");
+	if (chosen) {
+		vec5 = of_get_property(chosen, "ibm,architecture-vec-5", NULL);
+		if (vec5 && (vec5[VEC5_AFFINITY_BYTE] & VEC5_AFFINITY)) {
+			dbg("Using form 1 affinity\n");
+			index = 0;
+		}
 	}
 
 	if ((len >= 2 * sizeof(unsigned int)) && ref_points) {
