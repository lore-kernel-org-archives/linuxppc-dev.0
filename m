Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 2B76ADDF22
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Apr 2007 22:43:41 +1000 (EST)
Date: Tue, 24 Apr 2007 22:38:12 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "David S. Miller" <davem@davemloft.net>, paulus@samba.org
Subject: [PATCH 2/6] Consolidate of_device_is_compatible
Message-Id: <20070424223812.2842f3f2.sfr@canb.auug.org.au>
In-Reply-To: <20070424223245.78f4fdfb.sfr@canb.auug.org.au>
References: <20070403105217.7b9fea08.sfr@canb.auug.org.au>
	<20070403223000.5d44b2f1.sfr@canb.auug.org.au>
	<20070403223136.6ecdabbd.sfr@canb.auug.org.au>
	<20070403223257.cb8c4d15.sfr@canb.auug.org.au>
	<20070403223535.dd6731d6.sfr@canb.auug.org.au>
	<20070403223738.03386a13.sfr@canb.auug.org.au>
	<20070403223914.35bf04e1.sfr@canb.auug.org.au>
	<20070403224039.913af749.sfr@canb.auug.org.au>
	<20070403224205.807cffe0.sfr@canb.auug.org.au>
	<20070403224340.5533abc9.sfr@canb.auug.org.au>
	<20070403224505.5d5a1495.sfr@canb.auug.org.au>
	<20070403224610.b61c7377.sfr@canb.auug.org.au>
	<20070403224937.f6a07e56.sfr@canb.auug.org.au>
	<20070403225059.e735b5e4.sfr@canb.auug.org.au>
	<20070403225222.88e92221.sfr@canb.auug.org.au>
	<20070403230505.f96ea210.sfr@canb.auug.org.au>
	<20070403232406.ab9a3c86.sfr@canb.auug.org.au>
	<20070412141905.6f30efd3.sfr@canb.auug.org.au>
	<20070412153424.bf3957f4.sfr@canb.auug.org.au>
	<20070424223245.78f4fdfb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The only difference here is that Sparc uses strncmp to match compatibility
names while PowerPC uses strncasecmp.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/prom.c |   25 -------------------------
 arch/sparc/kernel/prom.c   |   21 ---------------------
 arch/sparc64/kernel/prom.c |   21 ---------------------
 drivers/openfw/base.c      |   24 ++++++++++++++++++++++++
 include/asm-powerpc/prom.h |    2 ++
 include/asm-sparc/prom.h   |    2 ++
 include/asm-sparc64/prom.h |    2 ++
 7 files changed, 30 insertions(+), 67 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index d701e89..723df55 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -1042,31 +1042,6 @@ void __init early_init_devtree(void *params)
 
 #undef printk
 
-/** Checks if the given "compat" string matches one of the strings in
- * the device's "compatible" property
- */
-int of_device_is_compatible(const struct device_node *device,
-		const char *compat)
-{
-	const char* cp;
-	int cplen, l;
-
-	cp = of_get_property(device, "compatible", &cplen);
-	if (cp == NULL)
-		return 0;
-	while (cplen > 0) {
-		if (strncasecmp(cp, compat, strlen(compat)) == 0)
-			return 1;
-		l = strlen(cp) + 1;
-		cp += l;
-		cplen -= l;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(of_device_is_compatible);
-
-
 /**
  * Indicates whether the root node has a given value in its
  * compatible property.
diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index ac3f3c2..f2ce0d4 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -32,27 +32,6 @@ static struct device_node *allnodes;
  */
 static DEFINE_RWLOCK(devtree_lock);
 
-int of_device_is_compatible(const struct device_node *device,
-			    const char *compat)
-{
-	const char* cp;
-	int cplen, l;
-
-	cp = of_get_property(device, "compatible", &cplen);
-	if (cp == NULL)
-		return 0;
-	while (cplen > 0) {
-		if (strncmp(cp, compat, strlen(compat)) == 0)
-			return 1;
-		l = strlen(cp) + 1;
-		cp += l;
-		cplen -= l;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(of_device_is_compatible);
-
 struct device_node *of_get_parent(const struct device_node *node)
 {
 	struct device_node *np;
diff --git a/arch/sparc64/kernel/prom.c b/arch/sparc64/kernel/prom.c
index 7ef5488..d6dd972 100644
--- a/arch/sparc64/kernel/prom.c
+++ b/arch/sparc64/kernel/prom.c
@@ -36,27 +36,6 @@ static struct device_node *allnodes;
  */
 static DEFINE_RWLOCK(devtree_lock);
 
-int of_device_is_compatible(const struct device_node *device,
-			    const char *compat)
-{
-	const char* cp;
-	int cplen, l;
-
-	cp = of_get_property(device, "compatible", &cplen);
-	if (cp == NULL)
-		return 0;
-	while (cplen > 0) {
-		if (strncmp(cp, compat, strlen(compat)) == 0)
-			return 1;
-		l = strlen(cp) + 1;
-		cp += l;
-		cplen -= l;
-	}
-
-	return 0;
-}
-EXPORT_SYMBOL(of_device_is_compatible);
-
 struct device_node *of_get_parent(const struct device_node *node)
 {
 	struct device_node *np;
diff --git a/drivers/openfw/base.c b/drivers/openfw/base.c
index 04a8cc2..0751313 100644
--- a/drivers/openfw/base.c
+++ b/drivers/openfw/base.c
@@ -63,3 +63,27 @@ const void *of_get_property(const struct device_node *np, const char *name,
 	return pp ? pp->value : NULL;
 }
 EXPORT_SYMBOL(of_get_property);
+
+/** Checks if the given "compat" string matches one of the strings in
+ * the device's "compatible" property
+ */
+int of_device_is_compatible(const struct device_node *device,
+		const char *compat)
+{
+	const char* cp;
+	int cplen, l;
+
+	cp = of_get_property(device, "compatible", &cplen);
+	if (cp == NULL)
+		return 0;
+	while (cplen > 0) {
+		if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
+			return 1;
+		l = strlen(cp) + 1;
+		cp += l;
+		cplen -= l;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(of_device_is_compatible);
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 30cea54..1f3e8cd 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -24,6 +24,8 @@
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	1
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
+#define of_compat_cmp(s1, s2, l)	strncasecmp((s1), (s2), (l))
+
 /* Definitions used by the flattened device tree */
 #define OF_DT_HEADER		0xd00dfeed	/* marker */
 #define OF_DT_BEGIN_NODE	0x1		/* Start of node, full name */
diff --git a/include/asm-sparc/prom.h b/include/asm-sparc/prom.h
index 411018d..cc049fd 100644
--- a/include/asm-sparc/prom.h
+++ b/include/asm-sparc/prom.h
@@ -23,6 +23,8 @@
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
+#define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
+
 typedef u32 phandle;
 typedef u32 ihandle;
 
diff --git a/include/asm-sparc64/prom.h b/include/asm-sparc64/prom.h
index 1097e66..843f9e8 100644
--- a/include/asm-sparc64/prom.h
+++ b/include/asm-sparc64/prom.h
@@ -23,6 +23,8 @@
 #define OF_ROOT_NODE_ADDR_CELLS_DEFAULT	2
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT	1
 
+#define of_compat_cmp(s1, s2, l)	strncmp((s1), (s2), (l))
+
 typedef u32 phandle;
 typedef u32 ihandle;
 
-- 
1.5.1.2
