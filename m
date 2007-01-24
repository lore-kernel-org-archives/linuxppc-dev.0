Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7F72CDE0FC
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 08:07:25 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l0OL7OtX029316
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:07:24 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l0OL7M8X007399
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:23 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l0OKnjNo008135
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 14:49:46 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 0ED514B926
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Jan 2007 15:07:22 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l0OL7L4m010592
	for linuxppc-dev@ozlabs.org; Wed, 24 Jan 2007 15:07:21 -0600
Date: Wed, 24 Jan 2007 15:07:21 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/18] Refactor ft_get_prop() into internal and external
	functions.
Message-ID: <20070124210721.GK10527@ld0162-tx32.am.freescale.net>
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

The property searching part of ft_get_prop is factored out into an
internal __ft_get_prop() which does not deal with phandles and does not
copy the property data.  ft_get_prop() is then a wrapper that does the
phandle translation and copying.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   53 +++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 87a4a06..f50b1b9 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -764,38 +764,53 @@ void *ft_get_parent(struct ft_cxt *cxt,
 	return NULL;
 }
 
-int ft_get_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
-		void *buf, const unsigned int buflen)
+static const void *__ft_get_prop(struct ft_cxt *cxt, void *node,
+                                 const char *propname, unsigned int *len)
 {
 	struct ft_atom atom;
-	void *node;
-	char *p;
-	int depth;
-	unsigned int size;
-
-	node = ft_node_ph2node(cxt, phandle);
-	if (node == NULL)
-		return -1;
-
-	depth = 0;
-	p = (char *)node;
+	int depth = 0;
 
-	while ((p = ft_next(cxt, p, &atom)) != NULL) {
+	while ((node = ft_next(cxt, node, &atom)) != NULL) {
 		switch (atom.tag) {
 		case OF_DT_BEGIN_NODE:
 			++depth;
 			break;
+
 		case OF_DT_PROP:
-			if ((depth != 1) || strcmp(atom.name, propname))
+			if (depth != 1 || strcmp(atom.name, propname))
 				break;
-			size = min(atom.size, buflen);
-			memcpy(buf, atom.data, size);
-			return atom.size;
+
+			if (len)
+				*len = atom.size;
+
+			return atom.data;
+
 		case OF_DT_END_NODE:
 			if (--depth <= 0)
-				return -1;
+				return NULL;
 		}
 	}
+
+	return NULL;
+}
+
+int ft_get_prop(struct ft_cxt *cxt, const void *phandle, const char *propname,
+		void *buf, const unsigned int buflen)
+{
+	const void *data;
+	unsigned int size;
+
+	void *node = ft_node_ph2node(cxt, phandle);
+	if (!node)
+		return -1;
+
+	data = __ft_get_prop(cxt, node, propname, &size);
+	if (data) {
+		unsigned int clipped_size = min(size, buflen);
+		memcpy(buf, data, clipped_size);
+		return size;
+	}
+
 	return -1;
 }
 
-- 
1.4.4
