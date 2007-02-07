Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 2CE2CDE21D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:59 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 16/19] bootwrapper: Make ft_create_node() pay attention to the
	parent parameter.
Message-ID: <20070207230141.GP3849@ld0162-tx32.am.freescale.net>
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

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   17 ++++++++++++-----
 arch/powerpc/boot/flatdevtree.h |    1 +
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 97698a9..8b67745 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -965,19 +965,26 @@ int ft_del_prop(struct ft_cxt *cxt, cons
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
@@ -986,7 +993,7 @@ void *ft_create_node(struct ft_cxt *cxt,
 				break;
 			/* end of node, insert here */
 			cxt->p = p;
-			ft_begin_node(cxt, path);
+			ft_begin_node(cxt, name);
 			ft_end_node(cxt);
 			return p;
 		}
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index e3e3e79..cb26325 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -108,5 +108,6 @@ void *ft_get_parent(struct ft_cxt *cxt,
 void *ft_find_node_by_prop_value(struct ft_cxt *cxt, const void *prev,
                                  const char *propname, const char *propval,
                                  int proplen);
+void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name);
 
 #endif /* FLATDEVTREE_H */
-- 
1.4.4
