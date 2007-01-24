Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id ECFB6DE141
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:27 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l0OL7Qfu020603
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:26 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l0OL7PH6002864
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:25 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnmGa008142
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:48 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id ED29F4B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:24 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7OXZ010601
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:24 -0600
Date: Wed, 24 Jan 2007 15:07:24 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 13/18] Add ft_find_prop().
Message-ID: <20070124210724.GM10527@ld0162-tx32.am.freescale.net>
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

ft_find_prop() finds nodes with the specified property/value pair.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   68 +++++++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/flatdevtree.h |    4 ++
 2 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 87e6636..0cd3f64 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -819,6 +819,74 @@ int ft_get_prop(struct ft_cxt *cxt, cons
 	return -1;
 }
 
+void *__ft_find_prop(struct ft_cxt *cxt, void *prev, const char *propname,
+                     const char *propval, unsigned int proplen)
+{
+	struct ft_atom atom;
+	char *p = ft_first_node(cxt);
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
+void *ft_find_prop(struct ft_cxt *cxt, void *prev, const char *propname,
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
+	return ft_node_add(cxt, node);
+}
+
+void *ft_find_prop_str(struct ft_cxt *cxt, void *prev,
+                       const char *propname, const char *propval)
+{
+	return ft_find_prop(cxt, prev, propname, propval, strlen(propval) + 1);
+}
+
 int ft_set_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		const void *buf, const unsigned int buflen)
 {
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index 64c5513..8a9923d 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -104,5 +104,9 @@ int ft_get_prop(struct ft_cxt *cxt, cons
 int ft_set_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
 		const void *buf, const unsigned int buflen);
 void *ft_get_parent(struct ft_cxt *cxt, const void *phandle);
+void *ft_find_prop(struct ft_cxt *cxt, void *prev, const char *propname,
+                   const char *propval, int proplen);
+void *ft_find_prop_str(struct ft_cxt *cxt, void *prev,
+                       const char *propname, const char *propval);
 
 #endif /* FLATDEVTREE_H */
-- 
1.4.4
