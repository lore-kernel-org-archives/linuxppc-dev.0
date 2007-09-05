Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B9BCDDE1A4
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Sep 2007 05:21:21 +1000 (EST)
Date: Wed, 5 Sep 2007 14:21:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: galak@kernel.crashing.org
Subject: [PATCH 05/10] bootwrapper: Add get_path().
Message-ID: <20070905192112.GE32113@ld0162-tx32.am.freescale.net>
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

This will be used by the PlanetCore firmware support to construct
a linux,stdout-path from the serial node that it finds.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/flatdevtree.c      |   59 ++++++++++++++++++++++++++++++++++
 arch/powerpc/boot/flatdevtree.h      |    1 +
 arch/powerpc/boot/flatdevtree_misc.c |    6 +++
 arch/powerpc/boot/ops.h              |    9 +++++
 4 files changed, 75 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/flatdevtree.c b/arch/powerpc/boot/flatdevtree.c
index 0af7291..cf30675 100644
--- a/arch/powerpc/boot/flatdevtree.c
+++ b/arch/powerpc/boot/flatdevtree.c
@@ -975,3 +975,62 @@ void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name)
 	}
 	return NULL;
 }
+
+/* Returns the start of the path within the provided buffer, or NULL on
+ * error.
+ */
+char *ft_get_path(struct ft_cxt *cxt, const void *phandle,
+                  char *buf, int len)
+{
+	const char *path_comp[FT_MAX_DEPTH];
+	struct ft_atom atom;
+	char *p, *next, *pos;
+	int depth = 0, i;
+	void *node;
+
+	node = ft_node_ph2node(cxt, phandle);
+	if (node == NULL)
+		return NULL;
+
+	p = ft_root_node(cxt);
+
+	while ((next = ft_next(cxt, p, &atom)) != NULL) {
+		switch (atom.tag) {
+		case OF_DT_BEGIN_NODE:
+			path_comp[depth++] = atom.name;
+			if (p == node)
+				goto found;
+
+			break;
+
+		case OF_DT_END_NODE:
+			if (--depth == 0)
+				return NULL;
+		}
+
+		p = next;
+	}
+
+found:
+	pos = buf;
+	for (i = 1; i < depth; i++) {
+		int this_len;
+
+		if (len <= 1)
+			return NULL;
+
+		*pos++ = '/';
+		len--;
+
+		strncpy(pos, path_comp[i], len);
+
+		if (pos[len - 1] != 0)
+			return NULL;
+
+		this_len = strlen(pos);
+		len -= this_len;
+		pos += this_len;
+	}
+
+	return buf;
+}
diff --git a/arch/powerpc/boot/flatdevtree.h b/arch/powerpc/boot/flatdevtree.h
index 2c1c826..b0957a2 100644
--- a/arch/powerpc/boot/flatdevtree.h
+++ b/arch/powerpc/boot/flatdevtree.h
@@ -108,5 +108,6 @@ void *ft_find_node_by_prop_value(struct ft_cxt *cxt, const void *prev,
                                  const char *propname, const char *propval,
                                  int proplen);
 void *ft_create_node(struct ft_cxt *cxt, const void *parent, const char *name);
+char *ft_get_path(struct ft_cxt *cxt, const void *phandle, char *buf, int len);
 
 #endif /* FLATDEVTREE_H */
diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
index 8d1debe..b367009 100644
--- a/arch/powerpc/boot/flatdevtree_misc.c
+++ b/arch/powerpc/boot/flatdevtree_misc.c
@@ -58,6 +58,11 @@ static unsigned long fdtm_finalize(void)
 	return (unsigned long)cxt.bph;
 }
 
+static char *fdtm_get_path(const void *phandle, char *buf, int len)
+{
+	return ft_get_path(&cxt, phandle, buf, len);
+}
+
 int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device)
 {
 	dt_ops.finddevice = fdtm_finddevice;
@@ -67,6 +72,7 @@ int ft_init(void *dt_blob, unsigned int max_size, unsigned int max_find_device)
 	dt_ops.create_node = fdtm_create_node;
 	dt_ops.find_node_by_prop_value = fdtm_find_node_by_prop_value;
 	dt_ops.finalize = fdtm_finalize;
+	dt_ops.get_path = fdtm_get_path;
 
 	return ft_open(&cxt, dt_blob, max_size, max_find_device,
 			platform_ops.realloc);
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 45c2268..703255b 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -47,6 +47,7 @@ struct dt_ops {
 	                                 const char *propname,
 	                                 const char *propval, int proplen);
 	unsigned long (*finalize)(void);
+	char *(*get_path)(const void *phandle, char *buf, int len);
 };
 extern struct dt_ops dt_ops;
 
@@ -170,6 +171,14 @@ static inline void *find_node_by_linuxphandle(const u32 linuxphandle)
 			(char *)&linuxphandle, sizeof(u32));
 }
 
+static inline char *get_path(const void *phandle, char *buf, int len)
+{
+	if (dt_ops.get_path)
+		return dt_ops.get_path(phandle, buf, len);
+
+	return NULL;
+}
+
 static inline void *malloc(unsigned long size)
 {
 	return (platform_ops.malloc) ? platform_ops.malloc(size) : NULL;
-- 
1.5.3
