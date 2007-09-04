Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Sep 2007 10:43:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: dtc: Assume properties preced subnodes in the flattened tree
Message-ID: <20070904004303.GC20549@localhost.localdomain>
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

With kernel commit eff2ebd207af9f501af0ef667a7d14befcb36c1b, we
clarified that in the flattened tree format, a particular nodes
properties are required to precede its subdnodes.

At present however, both dtc and libfdt will process trees which don't
meet this condition.  This patch simplifies the code for
fdt_get_property() based on assuming that constraint.  dtc continues
to be able to handle such an invalid tree - on the grounds that it's
useful for dtc to be able to correct such a broken tree - but this
patch adds a warning when this condition is not met while reading a
flattened tree.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: dtc/libfdt/fdt_ro.c
===================================================================
--- dtc.orig/libfdt/fdt_ro.c	2007-08-31 15:59:38.000000000 +1000
+++ dtc/libfdt/fdt_ro.c	2007-08-31 16:23:09.000000000 +1000
@@ -197,7 +197,6 @@
 					    int nodeoffset,
 					    const char *name, int *lenp)
 {
-	int level = 0;
 	uint32_t tag;
 	const struct fdt_property *prop;
 	int namestroff;
@@ -225,17 +224,11 @@
 			goto fail;
 
 		case FDT_BEGIN_NODE:
-			level++;
-			break;
-
 		case FDT_END_NODE:
-			level--;
+		case FDT_NOP:
 			break;
 
 		case FDT_PROP:
-			if (level != 0)
-				continue;
-
 			err = -FDT_ERR_BADSTRUCTURE;
 			prop = fdt_offset_ptr_typed(fdt, offset, prop);
 			if (! prop)
@@ -256,14 +249,11 @@
 			}
 			break;
 
-		case FDT_NOP:
-			break;
-
 		default:
 			err = -FDT_ERR_BADSTRUCTURE;
 			goto fail;
 		}
-	} while (level >= 0);
+	} while ((tag != FDT_BEGIN_NODE) && (tag != FDT_END_NODE));
 
 	err = -FDT_ERR_NOTFOUND;
  fail:
Index: dtc/flattree.c
===================================================================
--- dtc.orig/flattree.c	2007-08-31 16:34:34.000000000 +1000
+++ dtc/flattree.c	2007-08-31 16:39:11.000000000 +1000
@@ -779,6 +779,9 @@
 		val = flat_read_word(dtbuf);
 		switch (val) {
 		case OF_DT_PROP:
+			if (node->children)
+				fprintf(stderr, "Warning: Flat tree input has "
+					"subnodes preceding a property.\n");
 			prop = flat_read_property(dtbuf, strbuf, flags);
 			add_property(node, prop);
 			break;

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
