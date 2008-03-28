Return-Path: <stephenn@xilinx.com>
Received: from outbound9-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 61BE4DE47C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 03:26:49 +1100 (EST)
Received: from outbound9-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound9-dub-R.bigfish.com (Postfix) with ESMTP id 66D744C0182
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:21 +0000 (UTC)
Received: from mail170-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound9-dub.bigfish.com (Postfix) with ESMTP id 26B80139005E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:21 +0000 (UTC)
Received: from mail170-dub (localhost.localdomain [127.0.0.1])
	by mail170-dub-R.bigfish.com (Postfix) with ESMTP id 83E3C1640350
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:20 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail170-dub.bigfish.com (Postfix) with ESMTP id E9E3017A008F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 16:26:17 +0000 (UTC)
Received: from unknown-38-66.xilinx.com ([149.199.38.66]
	helo=xsj-smtp1.xilinx.com) by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <stephenn@xilinx.com>) id 1JfHPD-000093-Ro
	for linuxppc-dev@ozlabs.org; Fri, 28 Mar 2008 09:26:15 -0700
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/5] [POWERPC] explicit dcr support
Date: Fri, 28 Mar 2008 09:23:47 -0700
In-Reply-To: <1206721429-18276-2-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1206401313-1625-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1206721429-18276-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1206721429-18276-2-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080328162617.E9E3017A008F@mail170-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Added literal mapping support if no device-tree support.  Added
CONFIG_OF to guard device-tree parts, since literal support works for
arch=ppc.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 arch/powerpc/sysdev/dcr.c         |   82 ++++++++++++++++++++++++++++---------
 include/asm-powerpc/dcr-generic.h |    2 +
 include/asm-powerpc/dcr-mmio.h    |   11 +++++
 include/asm-powerpc/dcr-native.h  |    8 ++++
 include/asm-powerpc/dcr.h         |   24 +++++++++++
 5 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index d3de0ff..2ccae80 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -20,9 +20,34 @@
 #undef DEBUG
 
 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <asm/prom.h>
 #include <asm/dcr.h>
 
+#ifdef CONFIG_OF
+static struct device_node *find_dcr_parent(struct device_node *node)
+{
+	struct device_node *par, *tmp;
+	const u32 *p;
+
+	for (par = of_node_get(node); par;) {
+		if (of_get_property(par, "dcr-controller", NULL))
+			break;
+		p = of_get_property(par, "dcr-parent", NULL);
+		tmp = par;
+		if (p == NULL)
+			par = of_get_parent(par);
+		else
+			par = of_find_node_by_phandle(*p);
+		of_node_put(tmp);
+	}
+	return par;
+}
+#endif /* CONFIG_OF */
+
+
+/* Indirection layer for providing both NATIVE and MMIO support. */
+
 #if defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO)
 
 bool dcr_map_ok_generic(dcr_host_t host)
@@ -36,12 +61,24 @@ bool dcr_map_ok_generic(dcr_host_t host)
 }
 EXPORT_SYMBOL_GPL(dcr_map_ok_generic);
 
+#ifdef CONFIG_OF
 dcr_host_t dcr_map_generic(struct device_node *dev,
 			   unsigned int dcr_n,
 			   unsigned int dcr_c)
 {
 	dcr_host_t host;
-	const char *prop = of_get_property(dev, "dcr-access-method", NULL);
+	struct device_node *dp;
+
+	dp = find_dcr_parent(dev);
+	if (dp == NULL) {
+		host.type = INVALID;
+		return host;
+	}
+
+	const char *prop = of_get_property(dp, "dcr-access-method", NULL);
+
+	pr_debug("dcr_map_generic(dcr-access-method = %s)\n",
+		 prop);
 
 	if (!strcmp(prop, "native")) {
 		host.type = NATIVE;
@@ -56,6 +93,8 @@ dcr_host_t dcr_map_generic(struct device_node *dev,
 }
 EXPORT_SYMBOL_GPL(dcr_map_generic);
 
+#endif /* CONFIG_OF */
+
 void dcr_unmap_generic(dcr_host_t host, unsigned int dcr_c)
 {
 	if (host.type == NATIVE)
@@ -85,9 +124,10 @@ EXPORT_SYMBOL_GPL(dcr_write_generic);
 
 #endif /* defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO) */
 
+#ifdef CONFIG_OF
 unsigned int dcr_resource_start(struct device_node *np, unsigned int index)
 {
-	unsigned int ds;
+	int ds;
 	const u32 *dr = of_get_property(np, "dcr-reg", &ds);
 
 	if (dr == NULL || ds & 1 || index >= (ds / 8))
@@ -99,7 +139,7 @@ EXPORT_SYMBOL_GPL(dcr_resource_start);
 
 unsigned int dcr_resource_len(struct device_node *np, unsigned int index)
 {
-	unsigned int ds;
+	int ds;
 	const u32 *dr = of_get_property(np, "dcr-reg", &ds);
 
 	if (dr == NULL || ds & 1 || index >= (ds / 8))
@@ -109,26 +149,28 @@ unsigned int dcr_resource_len(struct device_node *np, unsigned int index)
 }
 EXPORT_SYMBOL_GPL(dcr_resource_len);
 
+#endif /* CONFIG_OF */
+
+
+
+/* Support for MMIO */
 #ifdef CONFIG_PPC_DCR_MMIO
 
-static struct device_node * find_dcr_parent(struct device_node * node)
+dcr_host_mmio_t dcr_map_mmio_literal_mmio(resource_size_t mmio_start,
+					  unsigned int stride,
+					  unsigned int dcr_n,
+					  unsigned int dcr_c)
 {
-	struct device_node *par, *tmp;
-	const u32 *p;
-
-	for (par = of_node_get(node); par;) {
-		if (of_get_property(par, "dcr-controller", NULL))
-			break;
-		p = of_get_property(par, "dcr-parent", NULL);
-		tmp = par;
-		if (p == NULL)
-			par = of_get_parent(par);
-		else
-			par = of_find_node_by_phandle(*p);
-		of_node_put(tmp);
-	}
-	return par;
+	dcr_host_mmio_t host;
+	host.stride = stride;
+	host.token = ioremap(mmio_start, dcr_c * stride);
+	host.token -= dcr_n * stride;
+	host.base = dcr_n;
+	return host;
 }
+EXPORT_SYMBOL_GPL(dcr_map_mmio_literal_mmio);
+
+#ifdef CONFIG_OF
 
 u64 of_translate_dcr_address(struct device_node *dev,
 			     unsigned int dcr_n,
@@ -189,6 +231,8 @@ dcr_host_mmio_t dcr_map_mmio(struct device_node *dev,
 }
 EXPORT_SYMBOL_GPL(dcr_map_mmio);
 
+#endif /* CONFIG_OF */
+
 void dcr_unmap_mmio(dcr_host_mmio_t host, unsigned int dcr_c)
 {
 	dcr_host_mmio_t h = host;
diff --git a/include/asm-powerpc/dcr-generic.h b/include/asm-powerpc/dcr-generic.h
index 0ee74fb..8032795 100644
--- a/include/asm-powerpc/dcr-generic.h
+++ b/include/asm-powerpc/dcr-generic.h
@@ -34,8 +34,10 @@ typedef struct {
 
 extern bool dcr_map_ok_generic(dcr_host_t host);
 
+#ifdef CONFIG_OF
 extern dcr_host_t dcr_map_generic(struct device_node *dev, unsigned int dcr_n,
 			  unsigned int dcr_c);
+#endif
 extern void dcr_unmap_generic(dcr_host_t host, unsigned int dcr_c);
 
 extern u32 dcr_read_generic(dcr_host_t host, unsigned int dcr_n);
diff --git a/include/asm-powerpc/dcr-mmio.h b/include/asm-powerpc/dcr-mmio.h
index acd491d..b12d291 100644
--- a/include/asm-powerpc/dcr-mmio.h
+++ b/include/asm-powerpc/dcr-mmio.h
@@ -34,9 +34,18 @@ static inline bool dcr_map_ok_mmio(dcr_host_mmio_t host)
 	return host.token != NULL;
 }
 
+extern dcr_host_mmio_t dcr_map_mmio_literal_mmio(resource_size_t mmio_start,
+						 unsigned int stride,
+						 unsigned int dcr_n,
+						 unsigned int dcr_c);
+
+
+#ifdef CONFIG_OF
 extern dcr_host_mmio_t dcr_map_mmio(struct device_node *dev,
 				    unsigned int dcr_n,
 				    unsigned int dcr_c);
+#endif
+
 extern void dcr_unmap_mmio(dcr_host_mmio_t host, unsigned int dcr_c);
 
 static inline u32 dcr_read_mmio(dcr_host_mmio_t host, unsigned int dcr_n)
@@ -51,9 +60,11 @@ static inline void dcr_write_mmio(dcr_host_mmio_t host,
 	out_be32(host.token + ((host.base + dcr_n) * host.stride), value);
 }
 
+#ifdef CONFIG_OF
 extern u64 of_translate_dcr_address(struct device_node *dev,
 				    unsigned int dcr_n,
 				    unsigned int *stride);
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DCR_MMIO_H */
diff --git a/include/asm-powerpc/dcr-native.h b/include/asm-powerpc/dcr-native.h
index 67832e5..9b3e255 100644
--- a/include/asm-powerpc/dcr-native.h
+++ b/include/asm-powerpc/dcr-native.h
@@ -33,6 +33,14 @@ static inline bool dcr_map_ok_native(dcr_host_native_t host)
 	return 1;
 }
 
+static inline
+dcr_host_native_t dcr_map_native_literal_native(unsigned int dcr_n)
+{
+	dcr_host_native_t host;
+	host.base = dcr_n;
+	return host;
+}
+
 #define dcr_map_native(dev, dcr_n, dcr_c) \
 	((dcr_host_native_t){ .base = (dcr_n) })
 #define dcr_unmap_native(host, dcr_c)		do {} while (0)
diff --git a/include/asm-powerpc/dcr.h b/include/asm-powerpc/dcr.h
index 6b86322..dfd1c24 100644
--- a/include/asm-powerpc/dcr.h
+++ b/include/asm-powerpc/dcr.h
@@ -35,6 +35,27 @@
 
 #include <asm/dcr-generic.h>
 
+static inline
+dcr_host_t dcr_map_mmio_literal(resource_size_t mmio_start,
+				unsigned int stride,
+				unsigned int dcr_n,
+				unsigned int dcr_c)
+{
+	dcr_host_t host;
+	host.type = MMIO;
+	host.host.mmio =
+		dcr_map_mmio_literal_mmio(mmio_start, stride, dcr_n, dcr_c);
+	return host;
+}
+static inline
+dcr_host_t dcr_map_native_literal(unsigned int dcr_n)
+{
+	dcr_host_t host;
+	host.type = NATIVE;
+	host.host.native = dcr_map_native_literal_native(dcr_n);
+	return host;
+}
+
 #define DCR_MAP_OK(host)	dcr_map_ok_generic(host)
 #define dcr_map(dev, dcr_n, dcr_c) dcr_map_generic(dev, dcr_n, dcr_c)
 #define dcr_unmap(host, dcr_c) dcr_unmap_generic(host, dcr_c)
@@ -45,6 +66,7 @@
 
 #ifdef CONFIG_PPC_DCR_NATIVE
 typedef dcr_host_native_t dcr_host_t;
+#define dcr_map_native_literal(dcr_n) dcr_map_native_literal_native(dcr_n)
 #define DCR_MAP_OK(host)	dcr_map_ok_native(host)
 #define dcr_map(dev, dcr_n, dcr_c) dcr_map_native(dev, dcr_n, dcr_c)
 #define dcr_unmap(host, dcr_c) dcr_unmap_native(host, dcr_c)
@@ -52,6 +74,8 @@ typedef dcr_host_native_t dcr_host_t;
 #define dcr_write(host, dcr_n, value) dcr_write_native(host, dcr_n, value)
 #else
 typedef dcr_host_mmio_t dcr_host_t;
+#define dcr_map_mmio_literal(mmio_start, stride, dcr_n, dcr_c) \
+	dcr_map_mmio_literal_mmio(mmio_start, stride, dcr_n, dcr_c)
 #define DCR_MAP_OK(host)	dcr_map_ok_mmio(host)
 #define dcr_map(dev, dcr_n, dcr_c) dcr_map_mmio(dev, dcr_n, dcr_c)
 #define dcr_unmap(host, dcr_c) dcr_unmap_mmio(host, dcr_c)
-- 
1.5.3.4-dirty
