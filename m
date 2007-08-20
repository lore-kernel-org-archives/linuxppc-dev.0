Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8A406DDE17
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Aug 2007 03:40:16 +1000 (EST)
Date: Mon, 20 Aug 2007 12:40:05 -0500
From: Scott Wood <scottwood@freescale.com>
To: paulus@samba.org
Subject: [PATCH 15/20] bootwrapper: Add dt_get_path().
Message-ID: <20070820174005.GN30562@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
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
---
 arch/powerpc/boot/devtree.c |   29 +++++++++++++++++++++++++++++
 arch/powerpc/boot/ops.h     |    1 +
 2 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index e1b8122..a92c8fb 100644
--- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -331,3 +331,32 @@ int dt_is_compatible(void *node, const char *compat)
 
 	return 0;
 }
+
+/* Returns the start of the path within the provided buffer, or NULL on
+ * error.
+ */
+char *dt_get_path(void *node, char *buf, int len)
+{
+	char *name = (char *)prop_buf;
+	char *orig_buf = buf;
+
+	buf += len;
+	*--buf = 0;
+
+	while (node) {
+		int len = getprop(node, "name", name, MAX_PROP_LEN);
+		if (len <= 0)
+			break;
+
+		if (len + 1 > buf - orig_buf)
+			return NULL;
+
+		buf -= len + 1;
+		buf[0] = '/';
+		memcpy(buf + 1, name, len);
+
+		node = get_parent(node);
+	}
+
+	return buf;
+}
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 45c2268..5efdf26 100644
--- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -90,6 +90,7 @@ int dt_xlate_reg(void *node, int res, unsigned long *addr, unsigned long *size);
 int dt_xlate_addr(void *node, u32 *buf, int buflen, unsigned long *xlated_addr);
 int dt_is_compatible(void *node, const char *compat);
 void dt_get_reg_format(void *node, u32 *naddr, u32 *nsize);
+char *dt_get_path(void *node, char *buf, int len);
 
 static inline void *finddevice(const char *name)
 {
-- 
1.5.0.3
