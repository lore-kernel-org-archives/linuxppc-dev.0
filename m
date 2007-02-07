Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id ACDD8DDFA8
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:36 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:21 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 04/19] bootwrapper: Add ft_root_node().
Message-ID: <20070207230121.GD3849@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Clean up some of the open-coded data structure references by providing a
function to return a pointer to the tree's root node.  This is only used
in high-level functions trying to access the root of the tree, not in
low-level code that is actually manipulating the data structure.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index c76c194..02823a8 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -29,6 +29,11 @@
 
 #define _ALIGN(x, al)	(((x) + (al) - 1) & ~((al) - 1))
 
+static char *ft_root_node(struct ft_cxt *cxt)
+{
+	return cxt->rgn[FT_STRUCT].start;
+}
+
 /* Routines for keeping node ptrs returned by ft_find_device current */
 /* First entry not used b/c it would return 0 and be taken as NULL/error */
 static void *ft_node_add(struct ft_cxt *cxt, char *node)
@@ -590,7 +595,7 @@ int ft_add_rsvmap(struct ft_cxt *cxt, u6
 
 void ft_begin_tree(struct ft_cxt *cxt)
 {
-	cxt->p = cxt->rgn[FT_STRUCT].start;
+	cxt->p = ft_root_node(cxt);
 }
 
 void ft_end_tree(struct ft_cxt *cxt)
@@ -636,7 +641,7 @@ void *ft_find_device(struct ft_cxt *cxt,
 	/* require absolute path */
 	if (srch_path[0] != '/')
 		return NULL;
-	node = ft_find_descendent(cxt, cxt->rgn[FT_STRUCT].start, srch_path);
+	node = ft_find_descendent(cxt, ft_root_node(cxt), srch_path);
 	return ft_node_add(cxt, node);
 }
 
@@ -717,7 +722,7 @@ void *ft_get_parent(struct ft_cxt *cxt,
 			return cxt->genealogy[d > 0 ? d - 1 : 0];
 
 	/* have to do it the hard way... */
-	p = cxt->rgn[FT_STRUCT].start;
+	p = ft_root_node(cxt);
 	d = 0;
 	while ((p = ft_next(cxt, p, &atom)) != NULL) {
 		switch (atom.tag) {
@@ -855,7 +860,7 @@ void *ft_create_node(struct ft_cxt *cxt,
 	char *p, *next;
 	int depth = 0;
 
-	p = cxt->rgn[FT_STRUCT].start;
+	p = ft_root_node(cxt);
 	while ((next = ft_next(cxt, p, &atom)) != NULL) {
 		switch (atom.tag) {
 		case OF_DT_BEGIN_NODE:
-- 
1.4.4
