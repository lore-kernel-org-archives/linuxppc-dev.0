Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 57AE3DE821
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 07:13:06 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0TKD5br003831
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:13:05 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0TKD4IK015021
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:13:04 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0TJtEWv014938
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 13:55:14 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 3BEB34B92B
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 14:13:03 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0TKD3EY013558
	for linuxppc-dev@ozlabs.org; Mon, 29 Jan 2007 14:13:03 -0600
Date: Mon, 29 Jan 2007 14:13:03 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/18] bootwrapper: Add ft_find_prop().
Message-ID: <20070129201303.GM13485@ld0162-tx32.am.freescale.net>
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

ft_find_prop() finds nodes with the specified property/value pair.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   62 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/flatdevtree.h |    2 +
 2 files changed, 64 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 88b178a..d405359 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -820,6 +820,68 @@ int ft_get_prop(struct ft_cxt *cxt, cons
 	return -1;
 }
 
+void *__ft_find_prop(struct ft_cxt *cxt, void *prev, const char *propname,
+                     const char *propval, unsigned int proplen)
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
+void *ft_find_prop(struct ft_cxt *cxt, const void *prev, const char *propname,
+                   const char *propval, int proplen)
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
+	node = __ft_find_prop(cxt, node, propname, propval, proplen);
+	return ft_get_phandle(cxt, node);
+}
+
 int ft_set_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		const void *buf, const unsigned int buflen)
 {
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index 9500424..728e327 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -105,5 +105,7 @@ int ft_get_prop(struct ft_cxt *cxt, cons
 int ft_set_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		const void *buf, const unsigned int buflen);
 void *ft_get_parent(struct ft_cxt *cxt, const void *phandle);
+void *ft_find_prop(struct ft_cxt *cxt, const void *prev, const char *propname,
+                   const char *propval, int proplen);
 
 #endif /* FLATDEVTREE_H */
-- 
1.4.4
