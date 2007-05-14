Return-Path: <dgibson@ozlabs.org>
Date: Mon, 14 May 2007 13:13:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paul Mackerras <paulus@samba.org>, "Mark A. Greer" <mgreer@mvista.com>
Subject: Fix bug adding properties with flatdevtree.c's ft_set_prop()
Message-ID: <20070514031357.GM6517@localhost.localdomain>
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

ft_set_prop() from flatdevtree.c in the zImage wrapper will either
replace an existing property in the flat device tree, or add a new
property definiion if the given property isn't present.

However, when adding properties, it adds the property definition
immediately before the node's END_NODE tag, potentially after any
subnode definitions for the node.  This confuses the kernel flat tree
parser in prom.c which assumes that all property definitions for a
node come before all subnode definitions.

This patch corrects ft_set_prop() so that it adds new properties
before the first subnode, instead of before the END_NODE tag.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Index: working-2.6/arch/powerpc/boot/flatdevtree.c
===================================================================
--- working-2.6.orig/arch/powerpc/boot/flatdevtree.c	2007-05-14 12:00:23.000000000 +1000
+++ working-2.6/arch/powerpc/boot/flatdevtree.c	2007-05-14 13:00:10.000000000 +1000
@@ -891,28 +891,27 @@ int ft_set_prop(struct ft_cxt *cxt, cons
 	struct ft_atom atom;
 	void *node;
 	char *p, *next;
-	int nextra, depth;
+	int nextra;
 
 	node = ft_node_ph2node(cxt, phandle);
 	if (node == NULL)
 		return -1;
 
-	depth = 0;
-	p = node;
+	next = ft_next(cxt, node, &atom);
+	if (atom.tag != OF_DT_BEGIN_NODE)
+		/* phandle didn't point to a node */
+		return -1;
+	p = next;
 
 	while ((next = ft_next(cxt, p, &atom)) != NULL) {
 		switch (atom.tag) {
-		case OF_DT_BEGIN_NODE:
-			++depth;
-			break;
+		case OF_DT_BEGIN_NODE: /* properties must go before subnodes */
 		case OF_DT_END_NODE:
-			if (--depth > 0)
-				break;
 			/* haven't found the property, insert here */
 			cxt->p = p;
 			return ft_prop(cxt, propname, buf, buflen);
 		case OF_DT_PROP:
-			if ((depth != 1) || strcmp(atom.name, propname))
+			if (strcmp(atom.name, propname))
 				break;
 			/* found an existing property, overwrite it */
 			nextra = _ALIGN(buflen, 4) - _ALIGN(atom.size, 4);

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
