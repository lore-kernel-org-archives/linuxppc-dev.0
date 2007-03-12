Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 3AA35DE0BB
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:42:01 +1100 (EST)
Date: Mon, 12 Mar 2007 14:41:56 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 12/19] bootwrapper: Make ft_get_parent() return a phandle,
	and NULL if already top-level.
Message-ID: <20070312204156.GL28545@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
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

Most of ft_get_parent() is factored out into __ft_get_parent(), which
deals only in internal node pointers.  The ft_get_parent() wrapper
handles phandle conversion in both directions (previously,
ft_get_parent() did not convert its return value).

It also now returns NULL as the parent of the toplevel node, rather than
just returning the toplevel node again (which made it rather useless in
loops).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   21 +++++++++++++--------
 arch/powerpc/boot/flatdevtree.h |    1 +
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index b7ae463..8afb835 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -732,20 +732,15 @@ void *ft_find_descendent(struct ft_cxt *cxt, void *top, const char *srch_path)
 	return NULL;
 }
 
-void *ft_get_parent(struct ft_cxt *cxt, const void *phandle)
+void *__ft_get_parent(struct ft_cxt *cxt, void *node)
 {
-	void *node;
 	int d;
 	struct ft_atom atom;
 	char *p;
 
-	node = ft_node_ph2node(cxt, phandle);
-	if (node == NULL)
-		return NULL;
-
 	for (d = 0; cxt->genealogy[d] != NULL; ++d)
 		if (cxt->genealogy[d] == node)
-			return cxt->genealogy[d > 0 ? d - 1 : 0];
+			return d > 0 ? cxt->genealogy[d - 1] : NULL;
 
 	/* have to do it the hard way... */
 	p = ft_root_node(cxt);
@@ -757,7 +752,7 @@ void *ft_get_parent(struct ft_cxt *cxt, const void *phandle)
 			if (node == atom.data) {
 				/* found it */
 				cxt->genealogy[d + 1] = NULL;
-				return d > 0 ? cxt->genealogy[d - 1] : node;
+				return d > 0 ? cxt->genealogy[d - 1] : NULL;
 			}
 			++d;
 			break;
@@ -769,6 +764,16 @@ void *ft_get_parent(struct ft_cxt *cxt, const void *phandle)
 	return NULL;
 }
 
+void *ft_get_parent(struct ft_cxt *cxt, const void *phandle)
+{
+	void *node = ft_node_ph2node(cxt, phandle);
+	if (node == NULL)
+		return NULL;
+
+	node = __ft_get_parent(cxt, node);
+	return ft_get_phandle(cxt, node);
+}
+
 static const void *__ft_get_prop(struct ft_cxt *cxt, void *node,
                                  const char *propname, unsigned int *len)
 {
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index 1f37ca2..9500424 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -104,5 +104,6 @@ int ft_get_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		void *buf, const unsigned int buflen);
 int ft_set_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		const void *buf, const unsigned int buflen);
+void *ft_get_parent(struct ft_cxt *cxt, const void *phandle);
 
 #endif /* FLATDEVTREE_H */
-- 
1.5.0.3
