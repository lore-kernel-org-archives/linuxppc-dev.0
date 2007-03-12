Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id C1267DE0D9
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:42:03 +1100 (EST)
Date: Mon, 12 Mar 2007 14:41:58 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 13/19] bootwrapper: Add ft_find_node_by_prop_value().
Message-ID: <20070312204158.GM28545@ld0162-tx32.am.freescale.net>
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

ft_find_node_by_prop_value() finds nodes with the specified
property/value pair.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   65 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/flatdevtree.h |    3 ++
 2 files changed, 68 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 8afb835..97698a9 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -824,6 +824,71 @@ int ft_get_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 	return -1;
 }
 
+void *__ft_find_node_by_prop_value(struct ft_cxt *cxt, void *prev,
+                                   const char *propname, const char *propval,
+                                   unsigned int proplen)
+{
+	struct ft_atom atom;
+	char *p = ft_root_node(cxt);
+	char *next;
+	int past_prev = prev ? 0 : 1;
+	int depth = -1;
+
+	while ((next = ft_next(cxt, p, &atom)) != NULL) {
+		const void *data;
+		unsigned int size;
+
+		switch (atom.tag) {
+		case OF_DT_BEGIN_NODE:
+			depth++;
+
+			if (prev == p) {
+				past_prev = 1;
+				break;
+			}
+
+			if (!past_prev || depth < 1)
+				break;
+
+			data = __ft_get_prop(cxt, p, propname, &size);
+			if (!data || size != proplen)
+				break;
+			if (memcmp(data, propval, size))
+				break;
+
+			return p;
+
+		case OF_DT_END_NODE:
+			if (depth-- == 0)
+				return NULL;
+
+			break;
+		}
+
+		p = next;
+	}
+
+	return NULL;
+}
+
+void *ft_find_node_by_prop_value(struct ft_cxt *cxt, const void *prev,
+                                 const char *propname, const char *propval,
+                                 int proplen)
+{
+	void *node = NULL;
+
+	if (prev) {
+		node = ft_node_ph2node(cxt, prev);
+
+		if (!node)
+			return NULL;
+	}
+
+	node = __ft_find_node_by_prop_value(cxt, node, propname,
+	                                    propval, proplen);
+	return ft_get_phandle(cxt, node);
+}
+
 int ft_set_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		const void *buf, const unsigned int buflen)
 {
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index 9500424..e3e3e79 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -105,5 +105,8 @@ int ft_get_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 int ft_set_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		const void *buf, const unsigned int buflen);
 void *ft_get_parent(struct ft_cxt *cxt, const void *phandle);
+void *ft_find_node_by_prop_value(struct ft_cxt *cxt, const void *prev,
+                                 const char *propname, const char *propval,
+                                 int proplen);
 
 #endif /* FLATDEVTREE_H */
-- 
1.5.0.3
