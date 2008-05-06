Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound2-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id B2CAFDDF28
	for <linuxppc-dev@ozlabs.org>; Wed,  7 May 2008 04:29:25 +1000 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: jwboyer@linux.vnet.ibm.com, benh@kernel.crashing.org,
	grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, sfr@canb.auug.org.au
Subject: [PATCH 1/4] [v5][POWERPC] refactor dcr code
Date: Tue,  6 May 2008 11:29:17 -0700
In-Reply-To: <20080506134006.62900cce.sfr@canb.auug.org.au>
References: <20080506134006.62900cce.sfr@canb.auug.org.au>
Message-Id: <20080506182920.CA37CF50052@mail84-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Previously, dcr support was configured at compile time to either using
MMIO or native dcr instructions.  Although this works for most
platforms, it fails on FPGA platforms:

1) Systems may include more than one dcr bus.
2) Systems may be native dcr capable and still use memory mapped dcr interface.

This patch provides runtime support based on the device trees for the
case where CONFIG_PPC_DCR_MMIO and CONFIG_PPC_DCR_NATIVE are both
selected.  Previously, this was a poorly defined configuration, which
happened to provide NATIVE support.  The runtime selection is made
based on the dcr controller having a 'dcr-access-method' attribute
in the device tree.  If only one of the above options is selected,
then the code uses #defines to select only the used code in order to
avoid introducing overhead in existing usage.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

--

[v4]
Converted flags to be DCR_HOST_*
Added WARN_ON in case someone forgets to call MAP_OK()
Fixed dealing with the dcr-access-method correctly, which was still
	off in the wrong patch.
[v5]
Fixed leaked reference to the device tree.
---
 arch/powerpc/sysdev/dcr.c         |  154 +++++++++++++++++++++++++++++--------
 include/asm-powerpc/dcr-generic.h |   49 ++++++++++++
 include/asm-powerpc/dcr-mmio.h    |   20 +++--
 include/asm-powerpc/dcr-native.h  |   16 +++--
 include/asm-powerpc/dcr.h         |   39 +++++++++-
 5 files changed, 231 insertions(+), 47 deletions(-)
 create mode 100644 include/asm-powerpc/dcr-generic.h

diff --git a/arch/powerpc/sysdev/dcr.c b/arch/powerpc/sysdev/dcr.c
index 437e48d..5f39a79 100644
--- a/arch/powerpc/sysdev/dcr.c
+++ b/arch/powerpc/sysdev/dcr.c
@@ -23,6 +23,105 @@
 #include <asm/prom.h>
 #include <asm/dcr.h>
 
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
+
+#if defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO)
+
+bool dcr_map_ok_generic(dcr_host_t host)
+{
+	if (host.type == DCR_HOST_NATIVE)
+		return dcr_map_ok_native(host.host.native);
+	else if (host.type == DCR_HOST_MMIO)
+		return dcr_map_ok_mmio(host.host.mmio);
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(dcr_map_ok_generic);
+
+dcr_host_t dcr_map_generic(struct device_node *dev,
+			   unsigned int dcr_n,
+			   unsigned int dcr_c)
+{
+	dcr_host_t host;
+	struct device_node *dp;
+	const char *prop;
+
+	host.type = DCR_HOST_INVALID;
+
+	dp = find_dcr_parent(dev);
+	if (dp == NULL)
+		return host;
+
+	prop = of_get_property(dp, "dcr-access-method", NULL);
+
+	pr_debug("dcr_map_generic(dcr-access-method = %s)\n", prop);
+
+	if (!strcmp(prop, "native")) {
+		host.type = DCR_HOST_NATIVE;
+		host.host.native = dcr_map_native(dev, dcr_n, dcr_c);
+	} else if (!strcmp(prop, "mmio")) {
+		host.type = DCR_HOST_MMIO;
+		host.host.mmio = dcr_map_mmio(dev, dcr_n, dcr_c);
+	}
+
+	of_node_put(dp);
+	return host;
+}
+EXPORT_SYMBOL_GPL(dcr_map_generic);
+
+void dcr_unmap_generic(dcr_host_t host, unsigned int dcr_c)
+{
+	if (host.type == DCR_HOST_NATIVE)
+		dcr_unmap_native(host.host.native, dcr_c);
+	else if (host.type == DCR_HOST_MMIO)
+		dcr_unmap_mmio(host.host.mmio, dcr_c);
+	else /* host.type == DCR_HOST_INVALID */
+		WARN_ON(true);
+}
+EXPORT_SYMBOL_GPL(dcr_unmap_generic);
+
+u32 dcr_read_generic(dcr_host_t host, unsigned int dcr_n)
+{
+	if (host.type == DCR_HOST_NATIVE)
+		return dcr_read_native(host.host.native, dcr_n);
+	else if (host.type == DCR_HOST_MMIO)
+		return dcr_read_mmio(host.host.mmio, dcr_n);
+	else /* host.type == DCR_HOST_INVALID */
+		WARN_ON(true);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dcr_read_generic);
+
+void dcr_write_generic(dcr_host_t host, unsigned int dcr_n, u32 value)
+{
+	if (host.type == DCR_HOST_NATIVE)
+		dcr_write_native(host.host.native, dcr_n, value);
+	else if (host.type == DCR_HOST_MMIO)
+		dcr_write_mmio(host.host.mmio, dcr_n, value);
+	else /* host.type == DCR_HOST_INVALID */
+		WARN_ON(true);
+}
+EXPORT_SYMBOL_GPL(dcr_write_generic);
+
+#endif /* defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO) */
+
 unsigned int dcr_resource_start(struct device_node *np, unsigned int index)
 {
 	unsigned int ds;
@@ -47,26 +146,7 @@ unsigned int dcr_resource_len(struct device_node *np, unsigned int index)
 }
 EXPORT_SYMBOL_GPL(dcr_resource_len);
 
-#ifndef CONFIG_PPC_DCR_NATIVE
-
-static struct device_node * find_dcr_parent(struct device_node * node)
-{
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
-}
+#ifdef CONFIG_PPC_DCR_MMIO
 
 u64 of_translate_dcr_address(struct device_node *dev,
 			     unsigned int dcr_n,
@@ -75,7 +155,7 @@ u64 of_translate_dcr_address(struct device_node *dev,
 	struct device_node *dp;
 	const u32 *p;
 	unsigned int stride;
-	u64 ret;
+	u64 ret = OF_BAD_ADDR;
 
 	dp = find_dcr_parent(dev);
 	if (dp == NULL)
@@ -90,7 +170,7 @@ u64 of_translate_dcr_address(struct device_node *dev,
 	if (p == NULL)
 		p = of_get_property(dp, "dcr-mmio-space", NULL);
 	if (p == NULL)
-		return OF_BAD_ADDR;
+		goto done;
 
 	/* Maybe could do some better range checking here */
 	ret = of_translate_address(dp, p);
@@ -98,21 +178,25 @@ u64 of_translate_dcr_address(struct device_node *dev,
 		ret += (u64)(stride) * (u64)dcr_n;
 	if (out_stride)
 		*out_stride = stride;
+
+ done:
+	of_node_put(dp);
 	return ret;
 }
 
-dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
-		   unsigned int dcr_c)
+dcr_host_mmio_t dcr_map_mmio(struct device_node *dev,
+			     unsigned int dcr_n,
+			     unsigned int dcr_c)
 {
-	dcr_host_t ret = { .token = NULL, .stride = 0, .base = dcr_n };
+	dcr_host_mmio_t ret = { .token = NULL, .stride = 0, .base = dcr_n };
 	u64 addr;
 
 	pr_debug("dcr_map(%s, 0x%x, 0x%x)\n",
 		 dev->full_name, dcr_n, dcr_c);
 
 	addr = of_translate_dcr_address(dev, dcr_n, &ret.stride);
-	pr_debug("translates to addr: 0x%lx, stride: 0x%x\n",
-		 addr, ret.stride);
+	pr_debug("translates to addr: 0x%llx, stride: 0x%x\n",
+		 (unsigned long long) addr, ret.stride);
 	if (addr == OF_BAD_ADDR)
 		return ret;
 	pr_debug("mapping 0x%x bytes\n", dcr_c * ret.stride);
@@ -124,11 +208,11 @@ dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
 	ret.token -= dcr_n * ret.stride;
 	return ret;
 }
-EXPORT_SYMBOL_GPL(dcr_map);
+EXPORT_SYMBOL_GPL(dcr_map_mmio);
 
-void dcr_unmap(dcr_host_t host, unsigned int dcr_c)
+void dcr_unmap_mmio(dcr_host_mmio_t host, unsigned int dcr_c)
 {
-	dcr_host_t h = host;
+	dcr_host_mmio_t h = host;
 
 	if (h.token == NULL)
 		return;
@@ -136,7 +220,11 @@ void dcr_unmap(dcr_host_t host, unsigned int dcr_c)
 	iounmap(h.token);
 	h.token = NULL;
 }
-EXPORT_SYMBOL_GPL(dcr_unmap);
-#else	/* defined(CONFIG_PPC_DCR_NATIVE) */
+EXPORT_SYMBOL_GPL(dcr_unmap_mmio);
+
+#endif /* defined(CONFIG_PPC_DCR_MMIO) */
+
+#ifdef CONFIG_PPC_DCR_NATIVE
 DEFINE_SPINLOCK(dcr_ind_lock);
-#endif	/* !defined(CONFIG_PPC_DCR_NATIVE) */
+#endif	/* defined(CONFIG_PPC_DCR_NATIVE) */
+
diff --git a/include/asm-powerpc/dcr-generic.h b/include/asm-powerpc/dcr-generic.h
new file mode 100644
index 0000000..35b7159
--- /dev/null
+++ b/include/asm-powerpc/dcr-generic.h
@@ -0,0 +1,49 @@
+/*
+ * (c) Copyright 2006 Benjamin Herrenschmidt, IBM Corp.
+ *                    <benh@kernel.crashing.org>
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ */
+
+#ifndef _ASM_POWERPC_DCR_GENERIC_H
+#define _ASM_POWERPC_DCR_GENERIC_H
+#ifdef __KERNEL__
+#ifndef __ASSEMBLY__
+
+enum host_type_t {DCR_HOST_MMIO, DCR_HOST_NATIVE, DCR_HOST_INVALID};
+
+typedef struct {
+	enum host_type_t type;
+	union {
+		dcr_host_mmio_t mmio;
+		dcr_host_native_t native;
+	} host;
+} dcr_host_t;
+
+extern bool dcr_map_ok_generic(dcr_host_t host);
+
+extern dcr_host_t dcr_map_generic(struct device_node *dev, unsigned int dcr_n,
+			  unsigned int dcr_c);
+extern void dcr_unmap_generic(dcr_host_t host, unsigned int dcr_c);
+
+extern u32 dcr_read_generic(dcr_host_t host, unsigned int dcr_n);
+
+extern void dcr_write_generic(dcr_host_t host, unsigned int dcr_n, u32 value);
+
+#endif /* __ASSEMBLY__ */
+#endif /* __KERNEL__ */
+#endif /* _ASM_POWERPC_DCR_GENERIC_H */
+
+
diff --git a/include/asm-powerpc/dcr-mmio.h b/include/asm-powerpc/dcr-mmio.h
index 08532ff..acd491d 100644
--- a/include/asm-powerpc/dcr-mmio.h
+++ b/include/asm-powerpc/dcr-mmio.h
@@ -27,20 +27,26 @@ typedef struct {
 	void __iomem *token;
 	unsigned int stride;
 	unsigned int base;
-} dcr_host_t;
+} dcr_host_mmio_t;
 
-#define DCR_MAP_OK(host)	((host).token != NULL)
+static inline bool dcr_map_ok_mmio(dcr_host_mmio_t host)
+{
+	return host.token != NULL;
+}
 
-extern dcr_host_t dcr_map(struct device_node *dev, unsigned int dcr_n,
-			  unsigned int dcr_c);
-extern void dcr_unmap(dcr_host_t host, unsigned int dcr_c);
+extern dcr_host_mmio_t dcr_map_mmio(struct device_node *dev,
+				    unsigned int dcr_n,
+				    unsigned int dcr_c);
+extern void dcr_unmap_mmio(dcr_host_mmio_t host, unsigned int dcr_c);
 
-static inline u32 dcr_read(dcr_host_t host, unsigned int dcr_n)
+static inline u32 dcr_read_mmio(dcr_host_mmio_t host, unsigned int dcr_n)
 {
 	return in_be32(host.token + ((host.base + dcr_n) * host.stride));
 }
 
-static inline void dcr_write(dcr_host_t host, unsigned int dcr_n, u32 value)
+static inline void dcr_write_mmio(dcr_host_mmio_t host,
+				  unsigned int dcr_n,
+				  u32 value)
 {
 	out_be32(host.token + ((host.base + dcr_n) * host.stride), value);
 }
diff --git a/include/asm-powerpc/dcr-native.h b/include/asm-powerpc/dcr-native.h
index f8398ce..72d2b72 100644
--- a/include/asm-powerpc/dcr-native.h
+++ b/include/asm-powerpc/dcr-native.h
@@ -26,14 +26,18 @@
 
 typedef struct {
 	unsigned int base;
-} dcr_host_t;
+} dcr_host_native_t;
 
-#define DCR_MAP_OK(host)	(1)
+static inline bool dcr_map_ok_native(dcr_host_native_t host)
+{
+	return 1;
+}
 
-#define dcr_map(dev, dcr_n, dcr_c)	((dcr_host_t){ .base = (dcr_n) })
-#define dcr_unmap(host, dcr_c)		do {} while (0)
-#define dcr_read(host, dcr_n)		mfdcr(dcr_n + host.base)
-#define dcr_write(host, dcr_n, value)	mtdcr(dcr_n + host.base, value)
+#define dcr_map_native(dev, dcr_n, dcr_c) \
+	((dcr_host_native_t){ .base = (dcr_n) })
+#define dcr_unmap_native(host, dcr_c)		do {} while (0)
+#define dcr_read_native(host, dcr_n)		mfdcr(dcr_n + host.base)
+#define dcr_write_native(host, dcr_n, value)	mtdcr(dcr_n + host.base, value)
 
 /* Device Control Registers */
 void __mtdcr(int reg, unsigned int val);
diff --git a/include/asm-powerpc/dcr.h b/include/asm-powerpc/dcr.h
index 9338d50..53b2830 100644
--- a/include/asm-powerpc/dcr.h
+++ b/include/asm-powerpc/dcr.h
@@ -20,14 +20,50 @@
 #ifndef _ASM_POWERPC_DCR_H
 #define _ASM_POWERPC_DCR_H
 #ifdef __KERNEL__
+#ifndef __ASSEMBLY__
 #ifdef CONFIG_PPC_DCR
 
 #ifdef CONFIG_PPC_DCR_NATIVE
 #include <asm/dcr-native.h>
-#else
+#endif
+
+#ifdef CONFIG_PPC_DCR_MMIO
 #include <asm/dcr-mmio.h>
 #endif
 
+
+/* Indirection layer for providing both NATIVE and MMIO support. */
+
+#if defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO)
+
+#include <asm/dcr-generic.h>
+
+#define DCR_MAP_OK(host)	dcr_map_ok_generic(host)
+#define dcr_map(dev, dcr_n, dcr_c) dcr_map_generic(dev, dcr_n, dcr_c)
+#define dcr_unmap(host, dcr_c) dcr_unmap_generic(host, dcr_c)
+#define dcr_read(host, dcr_n) dcr_read_generic(host, dcr_n)
+#define dcr_write(host, dcr_n, value) dcr_write_generic(host, dcr_n, value)
+
+#else
+
+#ifdef CONFIG_PPC_DCR_NATIVE
+typedef dcr_host_native_t dcr_host_t;
+#define DCR_MAP_OK(host)	dcr_map_ok_native(host)
+#define dcr_map(dev, dcr_n, dcr_c) dcr_map_native(dev, dcr_n, dcr_c)
+#define dcr_unmap(host, dcr_c) dcr_unmap_native(host, dcr_c)
+#define dcr_read(host, dcr_n) dcr_read_native(host, dcr_n)
+#define dcr_write(host, dcr_n, value) dcr_write_native(host, dcr_n, value)
+#else
+typedef dcr_host_mmio_t dcr_host_t;
+#define DCR_MAP_OK(host)	dcr_map_ok_mmio(host)
+#define dcr_map(dev, dcr_n, dcr_c) dcr_map_mmio(dev, dcr_n, dcr_c)
+#define dcr_unmap(host, dcr_c) dcr_unmap_mmio(host, dcr_c)
+#define dcr_read(host, dcr_n) dcr_read_mmio(host, dcr_n)
+#define dcr_write(host, dcr_n, value) dcr_write_mmio(host, dcr_n, value)
+#endif
+
+#endif /* defined(CONFIG_PPC_DCR_NATIVE) && defined(CONFIG_PPC_DCR_MMIO) */
+
 /*
  * On CONFIG_PPC_MERGE, we have additional helpers to read the DCR
  * base from the device-tree
@@ -41,5 +77,6 @@ extern unsigned int dcr_resource_len(struct device_node *np,
 #endif /* CONFIG_PPC_MERGE */
 
 #endif /* CONFIG_PPC_DCR */
+#endif /* __ASSEMBLY__ */
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_DCR_H */
-- 
1.5.3.4
