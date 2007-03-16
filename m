Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 6A5E0DDE30
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 04:27:58 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l2GHRsVk013977
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:27:54 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l2GHRrRZ019206
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:27:54 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l2GH8CwB001303
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:08:12 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 04724AEFC9
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 12:27:53 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l2GHRqpm029794
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 12:27:52 -0500
Date: Fri, 16 Mar 2007 12:27:52 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/17] bootwrapper: Make ft_create_node() pay attention to the
	parent parameter.
Message-ID: <20070316172752.GA29784@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, ft_create_node() ignored the parent parameter, and instead
created the new node as a child of the root node.  The node is now
created as a child of "parent".

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This patch is the same as before, but with a more verbose commit message,
as requested by David.

 arch/powerpc/boot/flatdevtree.c |   17 ++++++++++++-----
 arch/powerpc/boot/flatdevtree.h |    1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 052f0cc..c6c92d8 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -948,19 +948,26 @@ int ft_del_prop(struct ft_cxt *cxt, const void *phandle, const char *propname)
 	return -1;
 }
 
-void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *path)
+void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name)
 {
 	struct ft_atom atom;
 	char *p, *next;
 	int depth = 0;
 
-	p = ft_root_node(cxt);
+	if (parent) {
+		p = ft_node_ph2node(cxt, parent);
+		if (!p)
+			return NULL;
+	} else {
+		p = ft_root_node(cxt);
+	}
+
 	while ((next = ft_next(cxt, p, &atom)) != NULL) {
 		switch (atom.tag) {
 		case OF_DT_BEGIN_NODE:
 			++depth;
-			if (depth == 1 && strcmp(atom.name, path) == 0)
-				/* duplicate node path, return error */
+			if (depth == 1 && strcmp(atom.name, name) == 0)
+				/* duplicate node name, return error */
 				return NULL;
 			break;
 		case OF_DT_END_NODE:
@@ -969,7 +976,7 @@ void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *path)
 				break;
 			/* end of node, insert here */
 			cxt->p = p;
-			ft_begin_node(cxt, path);
+			ft_begin_node(cxt, name);
 			ft_end_node(cxt);
 			return p;
 		}
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index 5279242..bd3098f 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -106,5 +106,6 @@ void *ft_get_parent(struct ft_cxt *cxt, const void *phandle);
 void *ft_find_node_by_prop_value(struct ft_cxt *cxt, const void *prev,
                                  const char *propname, const char *propval,
                                  int proplen);
+void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name);
 
 #endif /* FLATDEVTREE_H */
-- 
1.5.0.3
