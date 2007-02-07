Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 1FEC8DE136
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 10:01:46 +1100 (EST)
Date: Wed, 7 Feb 2007 17:01:34 -0600
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 12/19] bootwrapper: Refactor ft_get_prop() into internal and
	external functions.
Message-ID: <20070207230134.GL3849@ld0162-tx32.am.freescale.net>
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

The property searching part of ft_get_prop is factored out into an
internal __ft_get_prop() which does not deal with phandles and does not
copy the property data.  ft_get_prop() is then a wrapper that does the
phandle translation and copying.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c |   53 +++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index b0d27c9..b7ae463 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -769,38 +769,53 @@ void *ft_get_parent(struct ft_cxt *cxt,
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
