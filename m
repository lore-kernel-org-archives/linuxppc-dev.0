Return-Path: <dgibson@ozlabs.org>
Date: Thu, 28 Feb 2008 20:53:00 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Strip redundant "name" properties
Message-ID: <20080228095300.GM24330@localhost.localdomain>
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

If an input device tree has "name" properties which are correct, then
they are redundant (because they can be derived from the unit name).
Therefore, extend the checking code for correctness of "name"
properties to remove them if they are correct.  dtc will still insert
name properties in the output if that's of a sufficiently old version
to require them.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/checks.c
===================================================================
--- dtc.orig/checks.c	2008-02-27 15:07:31.000000000 +1100
+++ dtc/checks.c	2008-02-27 21:00:30.000000000 +1100
@@ -316,9 +316,14 @@
 static void check_name_properties(struct check *c, struct node *root,
 				  struct node *node)
 {
-	struct property *prop;
+	struct property **pp, *prop = NULL;
+
+	for (pp = &node->proplist; *pp; pp = &((*pp)->next))
+		if (streq((*pp)->name, "name")) {
+			prop = *pp;
+			break;
+		}
 
-	prop = get_property(node, "name");
 	if (!prop)
 		return; /* No name property, that's fine */
 
@@ -326,6 +331,12 @@
 	    || (memcmp(prop->val.val, node->name, node->basenamelen) != 0))
 		FAIL(c, "\"name\" property in %s is incorrect (\"%s\" instead"
 		     " of base node name)", node->fullpath, prop->val.val);
+
+	/* The name property is correct, and therefore redundant.  Delete it */
+	*pp = prop->next;
+	free(prop->name);
+	data_free(prop->val);
+	free(prop);
 }
 CHECK_IS_STRING(name_is_string, "name", ERROR);
 NODE_CHECK(name_properties, NULL, ERROR, &name_is_string);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
