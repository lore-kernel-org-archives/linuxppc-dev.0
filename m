Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E2B58DE027
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:10 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l0OL79dR018263
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:09 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL785C013100
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:09 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnVux008112
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:31 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 047854B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:08 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL77DY010567
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:07 -0600
Date: Wed, 24 Jan 2007 15:07:07 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 05/18] Add ft_first_node().
Message-ID: <20070124210707.GE10527@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Clean up some of the open-coded data structure references by providing a
function to return a pointer to the first node in the tree.  This is only
used in high-level functions trying to access the beginning of the tree,
not in low-level code that is actually manipulating the data structure.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index c76c194..78e179f 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -29,6 +29,11 @@
 
 #define _ALIGN(x, al)	(((x) + (al) - 1) & ~((al) - 1))
 
+static char *ft_first_node(struct ft_cxt *cxt)
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
+	cxt->p = ft_first_node(cxt);
 }
 
 void ft_end_tree(struct ft_cxt *cxt)
@@ -636,7 +641,7 @@ void *ft_find_device(struct ft_cxt *cxt,
 	/* require absolute path */
 	if (srch_path[0] != '/')
 		return NULL;
-	node = ft_find_descendent(cxt, cxt->rgn[FT_STRUCT].start, srch_path);
+	node = ft_find_descendent(cxt, ft_first_node(cxt), srch_path);
 	return ft_node_add(cxt, node);
 }
 
@@ -717,7 +722,7 @@ void *ft_get_parent(struct ft_cxt *cxt,
 			return cxt->genealogy[d > 0 ? d - 1 : 0];
 
 	/* have to do it the hard way... */
-	p = cxt->rgn[FT_STRUCT].start;
+	p = ft_first_node(cxt);
 	d = 0;
 	while ((p = ft_next(cxt, p, &atom)) != NULL) {
 		switch (atom.tag) {
@@ -855,7 +860,7 @@ void *ft_create_node(struct ft_cxt *cxt,
 	char *p, *next;
 	int depth = 0;
 
-	p = cxt->rgn[FT_STRUCT].start;
+	p = ft_first_node(cxt);
 	while ((next = ft_next(cxt, p, &atom)) != NULL) {
 		switch (atom.tag) {
 		case OF_DT_BEGIN_NODE:
-- 
1.4.4
