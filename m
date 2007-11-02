Return-Path: <dgibson@ozlabs.org>
Date: Fri, 2 Nov 2007 16:10:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Make -Idts -Odts preserve node/property labels
Message-ID: <20071102051030.GM19839@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch changes -Odts mode output so that labels on properties,
nodes and memreserve entries in input source are preserved in the
output.

Preserving labels within property values is trickier - another patch
coming later.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/treesource.c
===================================================================
--- dtc.orig/treesource.c	2007-11-02 16:00:19.000000000 +1100
+++ dtc/treesource.c	2007-11-02 16:02:33.000000000 +1100
@@ -176,6 +176,8 @@ static void write_tree_source_node(FILE 
 	struct node *child;
 
 	write_prefix(f, level);
+	if (tree->label)
+		fprintf(f, "%s: ", tree->label);
 	if (tree->name && (*tree->name))
 		fprintf(f, "%s {\n", tree->name);
 	else
@@ -184,8 +186,10 @@ static void write_tree_source_node(FILE 
 	for_each_property(tree, prop) {
 		enum proptype type;
 
-		write_prefix(f, level);
-		fprintf(f, "\t%s", prop->name);
+		write_prefix(f, level+1);
+		if (prop->label)
+			fprintf(f, "%s: ", prop->label);
+		fprintf(f, "%s", prop->name);
 		type = guess_type(prop);
 
 		switch (type) {
@@ -220,6 +224,8 @@ void dt_to_source(FILE *f, struct boot_i
 	struct reserve_info *re;
 
 	for (re = bi->reservelist; re; re = re->next) {
+		if (re->label)
+			fprintf(f, "%s: ", re->label);
 		fprintf(f, "/memreserve/\t%016llx-%016llx;\n",
 			(unsigned long long)re->re.address,
 			(unsigned long long)(re->re.address + re->re.size - 1));

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
