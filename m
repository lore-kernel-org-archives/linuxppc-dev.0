Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65990DDF91
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:21:13 +1000 (EST)
Date: Wed, 5 Sep 2007 14:21:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 03/10] bootwrapper: flatdevtree fixes
Message-ID: <20070905192104.GC32113@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905192001.GA32049@ld0162-tx32.am.freescale.net>
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
rather than as the root of the tree.  The old, absolute ft_find_device
is removed, and the relative version is renamed to ft_find_device().

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c      |   41 +++++++++++++++------------------
 arch/powerpc/boot/flatdevtree.h      |    7 ++---
 arch/powerpc/boot/flatdevtree_misc.c |    2 +-
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 13761bf..0af7291 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -354,16 +354,21 @@ static void ft_put_bin(struct ft_cxt *cxt, const void *data, unsigned int sz)
 	cxt->p += sza;
 }
 
-int ft_begin_node(struct ft_cxt *cxt, const char *name)
+char *ft_begin_node(struct ft_cxt *cxt, const char *name)
 {
 	unsigned long nlen = strlen(name) + 1;
 	unsigned long len = 8 + _ALIGN(nlen, 4);
+	char *ret;
 
 	if (!ft_make_space(cxt, &cxt->p, FT_STRUCT, len))
-		return -1;
+		return NULL;
+
+	ret = cxt->p;
+
 	ft_put_word(cxt, OF_DT_BEGIN_NODE);
 	ft_put_bin(cxt, name, strlen(name) + 1);
-	return 0;
+
+	return ret;
 }
 
 void ft_end_node(struct ft_cxt *cxt)
@@ -625,25 +630,17 @@ void ft_end_tree(struct ft_cxt *cxt)
 	bph->dt_strings_size = cpu_to_be32(ssize);
 }
 
-void *ft_find_device(struct ft_cxt *cxt, const char *srch_path)
-{
-	char *node;
-
-	/* require absolute path */
-	if (srch_path[0] != '/')
-		return NULL;
-	node = ft_find_descendent(cxt, ft_root_node(cxt), srch_path);
-	return ft_get_phandle(cxt, node);
-}
-
-void *ft_find_device_rel(struct ft_cxt *cxt, const void *top,
-                         const char *srch_path)
+void *ft_find_device(struct ft_cxt *cxt, const void *top, const char *srch_path)
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
@@ -945,7 +942,7 @@ int ft_del_prop(struct ft_cxt *cxt, const void *phandle, const char *propname)
 void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name)
 {
 	struct ft_atom atom;
-	char *p, *next;
+	char *p, *next, *ret;
 	int depth = 0;
 
 	if (parent) {
@@ -970,9 +967,9 @@ void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name)
 				break;
 			/* end of node, insert here */
 			cxt->p = p;
-			ft_begin_node(cxt, name);
+			ret = ft_begin_node(cxt, name);
 			ft_end_node(cxt);
-			return p;
+			return ft_get_phandle(cxt, ret);
 		}
 		p = next;
 	}
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index cb26325..2c1c826 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -76,7 +76,7 @@ struct ft_cxt {
 	unsigned int nodes_used;
 };
 
-int ft_begin_node(struct ft_cxt *cxt, const char *name);
+char *ft_begin_node(struct ft_cxt *cxt, const char *name);
 void ft_end_node(struct ft_cxt *cxt);
 
 void ft_begin_tree(struct ft_cxt *cxt);
@@ -96,9 +96,8 @@ int ft_add_rsvmap(struct ft_cxt *cxt, u64 physaddr, u64 size);
 
 void ft_dump_blob(const void *bphp);
 void ft_merge_blob(struct ft_cxt *cxt, void *blob);
-void *ft_find_device(struct ft_cxt *cxt, const char *srch_path);
-void *ft_find_device_rel(struct ft_cxt *cxt, const void *top,
-                         const char *srch_path);
+void *ft_find_device(struct ft_cxt *cxt, const void *top,
+                     const char *srch_path);
 void *ft_find_descendent(struct ft_cxt *cxt, void *top, const char *srch_path);
 int ft_get_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		void *buf, const unsigned int buflen);
diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index 4341e65..8d1debe 100644
--- a/arch/powerpc/boot/flatdevtree_misc.c
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -18,7 +18,7 @@ static struct ft_cxt cxt;
 
 static void *fdtm_finddevice(const char *name)
 {
-	return ft_find_device(&cxt, name);
+	return ft_find_device(&cxt, NULL, name);
 }
 
 static int fdtm_getprop(const void *phandle, const char *propname,
-- 
1.5.3
