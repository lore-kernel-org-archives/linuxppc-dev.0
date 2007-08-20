Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CC21ADDEEF
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:39:57 +1000 (EST)
Date: Mon, 20 Aug 2007 12:39:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 05/20] bootwrapper: flatdevtree fixes
Message-ID: <20070820173949.GD30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

1. ft_create_node was returning the internal pointer rather than a phandle.
2. ft_find_device_rel was treating a "top" phandle of NULL as an error,
rather than as the root of the tree.
3. Return the node's name when getprop() is called with the "name" property.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   24 +++++++++++++++++++-----
 1 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 13761bf..61b710f 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -109,9 +109,10 @@ static char *ft_next(struct ft_cxt *cxt, char *p, struct ft_atom *ret)
 
 	switch (ret->tag) {	/* Tag */
 	case OF_DT_BEGIN_NODE:
+		ret->size = strlen(p);
 		ret->name = p;
 		ret->data = (void *)(p - 4);	/* start of node */
-		p += _ALIGN(strlen(p) + 1, 4);
+		p += _ALIGN(ret->size + 1, 4);
 		break;
 	case OF_DT_PROP:
 		ret->size = sz = be32_to_cpu(*(u32 *) p);
@@ -641,9 +642,13 @@ void *ft_find_device_rel(struct ft_cxt *cxt, const void *top,
 {
 	char *node;
 
-	node = ft_node_ph2node(cxt, top);
-	if (node == NULL)
-		return NULL;
+	if (top) {
+		node = ft_node_ph2node(cxt, top);
+		if (node == NULL)
+			return NULL;
+	} else {
+		node = ft_root_node(cxt);
+	}
 
 	node = ft_find_descendent(cxt, node, srch_path);
 	return ft_get_phandle(cxt, node);
@@ -757,10 +762,19 @@ static const void *__ft_get_prop(struct ft_cxt *cxt, void *node,
 {
 	struct ft_atom atom;
 	int depth = 0;
+	int prop_is_name = !strcmp(propname, "name");
+
 
 	while ((node = ft_next(cxt, node, &atom)) != NULL) {
 		switch (atom.tag) {
 		case OF_DT_BEGIN_NODE:
+			if (prop_is_name) {
+				if (len)
+					*len = atom.size;
+
+				return atom.name;
+			}
+
 			++depth;
 			break;
 
@@ -972,7 +986,7 @@ void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name)
 			cxt->p = p;
 			ft_begin_node(cxt, name);
 			ft_end_node(cxt);
-			return p;
+			return ft_find_device_rel(cxt, parent, name);
 		}
 		p = next;
 	}
-- 
1.5.0.3
