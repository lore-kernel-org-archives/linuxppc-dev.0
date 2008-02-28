Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Feb 2008 16:42:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Fix indentation of fixup_phandle_references
Message-ID: <20080228054215.GK24330@localhost.localdomain>
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

Somehow the indentation of this function is messed up - 7 spaces
instead of 1 tab (probably a bad copy paste from a patch file).  This
patch fixes it.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2008-02-28 16:40:04.000000000 +1100
+++ dtc/checks.c	2008-02-28 16:40:13.000000000 +1100
@@ -337,23 +337,23 @@
 static void fixup_phandle_references(struct check *c, struct node *dt,
 				     struct node *node, struct property *prop)
 {
-      struct marker *m = prop->val.markers;
-      struct node *refnode;
-      cell_t phandle;
-
-      for_each_marker_of_type(m, REF_PHANDLE) {
-	      assert(m->offset + sizeof(cell_t) <= prop->val.len);
-
-	      refnode = get_node_by_ref(dt, m->ref);
-	      if (! refnode) {
-		      FAIL(c, "Reference to non-existent node or label \"%s\"\n",
-			   m->ref);
-		      continue;
-	      }
-
-	      phandle = get_node_phandle(dt, refnode);
-	      *((cell_t *)(prop->val.val + m->offset)) = cpu_to_be32(phandle);
-      }
+	struct marker *m = prop->val.markers;
+	struct node *refnode;
+	cell_t phandle;
+
+	for_each_marker_of_type(m, REF_PHANDLE) {
+		assert(m->offset + sizeof(cell_t) <= prop->val.len);
+
+		refnode = get_node_by_ref(dt, m->ref);
+		if (! refnode) {
+			FAIL(c, "Reference to non-existent node or label \"%s\"\n",
+			     m->ref);
+			continue;
+		}
+
+		phandle = get_node_phandle(dt, refnode);
+		*((cell_t *)(prop->val.val + m->offset)) = cpu_to_be32(phandle);
+	}
 }
 CHECK(phandle_references, NULL, NULL, fixup_phandle_references, NULL, ERROR,
       &duplicate_node_names, &explicit_phandles);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
