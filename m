Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D53A81A02F5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 12:39:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH v3] powerpc/powernv: Expose OPAL firmware symbol map
Date: Thu, 11 Dec 2014 12:39:49 +1100
Message-Id: <1418261989-27033-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Newer versions of OPAL will provide this, so let's expose it to user
space so tools like perf can use it to properly decode samples in
firmware space.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/powernv/opal.c | 38 ++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

v3. Use bin_attribute->private & size. Add pr_fmt().
v2. Use memory_read_from_buffer()

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index d019b081df9d..8907ba039f1e 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -9,8 +9,9 @@
  * 2 of the License, or (at your option) any later version.
  */
 
-#undef DEBUG
+#define pr_fmt(fmt)	"opal: " fmt
 
+#include <linux/printk.h>
 #include <linux/types.h>
 #include <linux/of.h>
 #include <linux/of_fdt.h>
@@ -626,6 +627,39 @@ static int opal_sysfs_init(void)
 	return 0;
 }
 
+static ssize_t symbol_map_read(struct file *fp, struct kobject *kobj,
+			       struct bin_attribute *bin_attr,
+			       char *buf, loff_t off, size_t count)
+{
+	return memory_read_from_buffer(buf, count, &off, bin_attr->private,
+				       bin_attr->size);
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
+	/* Setup attributes */
+	bin_attr_symbol_map.private = __va(be64_to_cpu(syms[0]));
+	bin_attr_symbol_map.size = be64_to_cpu(syms[1]);
+
+	rc = sysfs_create_bin_file(opal_kobj, &bin_attr_symbol_map);
+	if (rc)
+		pr_warn("Error %d creating OPAL symbols file\n", rc);
+}
+
 static void __init opal_dump_region_init(void)
 {
 	void *addr;
@@ -693,6 +727,8 @@ static int __init opal_init(void)
 	/* Create "opal" kobject under /sys/firmware */
 	rc = opal_sysfs_init();
 	if (rc == 0) {
+		/* Export symbol map to userspace */
+		opal_export_symmap();
 		/* Setup dump region interface */
 		opal_dump_region_init();
 		/* Setup error log interface */
-- 
2.1.0
