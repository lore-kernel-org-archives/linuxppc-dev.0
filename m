Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 7A153DE879
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:13:09 +1100 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0TKD8tU003847
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:13:08 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKD7iT022814
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:13:07 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJtHoB014952
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:55:17 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 790FE4B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:13:06 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKD67F013567
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:13:06 -0600
Date: Mon, 29 Jan 2007 14:13:06 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 15/18] bootwrapper: Make ft_create_node() pay attention to the
	parent parameter.
Message-ID: <20070129201306.GO13485@ld0162-tx32.am.freescale.net>
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   17 ++++++++++++-----
 arch/powerpc/boot/flatdevtree.h |    1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index d405359..4f0365d 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -958,19 +958,26 @@ int ft_del_prop(struct ft_cxt *cxt, cons
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
@@ -979,7 +986,7 @@ void *ft_create_node(struct ft_cxt *cxt,
 				break;
 			/* end of node, insert here */
 			cxt->p = p;
-			ft_begin_node(cxt, path);
+			ft_begin_node(cxt, name);
 			ft_end_node(cxt);
 			return p;
 		}
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index 728e327..6741126 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -107,5 +107,6 @@ int ft_set_prop(struct ft_cxt *cxt, cons
 void *ft_get_parent(struct ft_cxt *cxt, const void *phandle);
 void *ft_find_prop(struct ft_cxt *cxt, const void *prev, const char *propname,
                    const char *propval, int proplen);
+void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name);
 
 #endif /* FLATDEVTREE_H */
-- 
1.4.4
