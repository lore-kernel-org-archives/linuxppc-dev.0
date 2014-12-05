Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC6DD1A05BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 13:36:50 +1100 (AEDT)
Message-ID: <1417746997.4741.46.camel@kernel.crashing.org>
Subject: [PATCH] powerpc/powernv: Expose OPAL firmware symbol map
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
Date: Fri, 05 Dec 2014 13:36:37 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Ellerman <michael@ellerman.id.au>,
 Anton Blanchard <anton@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Newer versions of OPAL will provide this, so let's expose it to user
space so tools like perf can use it to properly decode samples in
firmware space.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 06d9076..6427959 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -61,6 +61,8 @@ static DEFINE_SPINLOCK(opal_notifier_lock);
 static uint64_t last_notified_mask = 0x0ul;
 static atomic_t opal_notifier_hold = ATOMIC_INIT(0);
 static uint32_t opal_heartbeat;
+static void *opal_symmap;
+static uint64_t opal_symmap_size;
 
 static void opal_reinit_cores(void)
 {
@@ -604,10 +606,49 @@ static int opal_sysfs_init(void)
 		pr_warn("kobject_create_and_add opal failed\n");
 		return -ENOMEM;
 	}
-
 	return 0;
 }
 
+static ssize_t symbol_map_read(struct file *fp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buf, loff_t off, size_t count)
+{
+	ssize_t chunk;
+
+	if (off >= opal_symmap_size)
+		return 0;
+	chunk = min_t(ssize_t, opal_symmap_size - off, count);
+	memcpy(buf, opal_symmap + off, chunk);
+
+	return chunk;
+}
+
+static BIN_ATTR_RO(symbol_map, 0);
+
+static void opal_export_symmap(void)
+{
+	const __be64 *syms;
+	unsigned int size;
+	struct device_node *fw;
+	int rc;
+
+	fw = of_find_node_by_path("/ibm,opal/firmware");
+	if (!fw)
+		return;
+	syms = of_get_property(fw, "symbol-map", &size);
+	if (!syms || size != 2 * sizeof(__be64))
+		return;
+
+	opal_symmap = __va(be64_to_cpu(syms[0]));
+	opal_symmap_size = be64_to_cpu(syms[1]);
+
+	/* Setup attributes */
+	bin_attr_symbol_map.size = opal_symmap_size;
+	rc = sysfs_create_bin_file(opal_kobj, &bin_attr_symbol_map);
+	if (rc)
+		pr_warn("Error %d creating OPAL symbols file\n", rc);
+}
+
 static void __init opal_dump_region_init(void)
 {
 	void *addr;
@@ -738,6 +779,8 @@ static int __init opal_init(void)
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
 	if (rc == 0) {
+		/* Export symbol map to userspace */
+		opal_export_symmap();
 		/* Setup dump region interface */
 		opal_dump_region_init();
 		/* Setup error log interface */
