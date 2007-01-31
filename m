Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Jan 2007 15:45:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>
Subject: [dtc] Bugfix for CHECK_HAVE_WARN_PHANDLE()
Message-ID: <20070131044525.GA25231@localhost.localdomain>
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

At present, the tree checking code in dtc will die with an assertion
failure if given a tree which has the invalid value 0 or -1 in a
property which should contain a phandle.  This patch fixes the check
to die more gracefully with an error message indicating the invalid
phandle value.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: dtc/livetree.c
===================================================================
--- dtc.orig/livetree.c	2007-01-31 15:40:34.000000000 +1100
+++ dtc/livetree.c	2007-01-31 15:41:39.000000000 +1100
@@ -427,9 +427,14 @@ static int check_structure(struct node *
 		struct node *ref; \
 		CHECK_HAVE_WARN_ONECELL((xnode), (propname)); \
 		if (prop) {\
-			ref = get_node_by_phandle((root), propval_cell(prop)); \
-			if (! ref) \
-				DO_ERR("\"%s\" property in %s refers to non-existant phandle %x\n", (propname), (xnode)->fullpath, propval_cell(prop)); \
+			cell_t phandle = propval_cell(prop); \
+			if ((phandle == 0) || (phandle == -1)) { \
+				DO_ERR("\"%s\" property in %s contains an invalid phandle %x\n", (propname), (xnode)->fullpath, phandle); \
+			} else { \
+				ref = get_node_by_phandle((root), propval_cell(prop)); \
+				if (! ref) \
+					DO_ERR("\"%s\" property in %s refers to non-existant phandle %x\n", (propname), (xnode)->fullpath, propval_cell(prop)); \
+			} \
 		} \
 	} while (0)
 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
