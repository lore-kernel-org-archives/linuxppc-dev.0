Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 0567ADE0A0
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:12:14 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0TKCDN5005482
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:12:13 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKCC9q023007
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:12 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJsM5d014780
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:54:22 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 459AD4B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:12:11 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKCBlt013546
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:12:11 -0600
Date: Mon, 29 Jan 2007 14:12:11 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 12/18] bootwrapper: Make ft_get_parent() return a phandle,
	and NULL if already top-level.
Message-ID: <20070129201211.GL13485@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ca1ac163-f732-45ce-9629-e6f4a8c3a880@ld0162-tx32.am.freescale.net>
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
index 9de267d..88b178a 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -728,20 +728,15 @@ void *ft_find_descendent(struct ft_cxt *
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
@@ -753,7 +748,7 @@ void *ft_get_parent(struct ft_cxt *cxt,
 			if (node == atom.data) {
 				/* found it */
 				cxt->genealogy[d + 1] = NULL;
-				return d > 0 ? cxt->genealogy[d - 1] : node;
+				return d > 0 ? cxt->genealogy[d - 1] : NULL;
 			}
 			++d;
 			break;
@@ -765,6 +760,16 @@ void *ft_get_parent(struct ft_cxt *cxt,
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
@@ -104,5 +104,6 @@ int ft_get_prop(struct ft_cxt *cxt, cons
 		void *buf, const unsigned int buflen);
 int ft_set_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		const void *buf, const unsigned int buflen);
+void *ft_get_parent(struct ft_cxt *cxt, const void *phandle);
 
 #endif /* FLATDEVTREE_H */
-- 
1.4.4
