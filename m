Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6BA9347509
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Dec 2008 07:09:07 +1100 (EST)
Date: Wed, 17 Dec 2008 23:09:06 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/7] powerpc/32: Setup OF properties for kdump
Message-ID: <20081217200906.GC4624@oksana.dev.rtsoft.ru>
References: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081217200610.GA31887@oksana.dev.rtsoft.ru>
Cc: Milton Miller <miltonm@bga.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

Refactor the setting of kexec OF properties, moving the common code
from machine_kexec_64.c to machine_kexec.c where it can be used on
both ppc64 and ppc32.  This will be needed for kdump to work on ppc32
platforms.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/kernel/machine_kexec.c    |   36 ++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c |   56 ++-----------------------------
 2 files changed, 40 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index 4f797c0..b3abebb 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -120,6 +120,7 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
 
 /* Values we need to export to the second kernel via the device tree. */
 static unsigned long kernel_end;
+static unsigned long crashk_size;
 
 static struct property kernel_end_prop = {
 	.name = "linux,kernel-end",
@@ -127,6 +128,39 @@ static struct property kernel_end_prop = {
 	.value = &kernel_end,
 };
 
+static struct property crashk_base_prop = {
+	.name = "linux,crashkernel-base",
+	.length = sizeof(unsigned long),
+	.value = &crashk_res.start,
+};
+
+static struct property crashk_size_prop = {
+	.name = "linux,crashkernel-size",
+	.length = sizeof(unsigned long),
+	.value = &crashk_size,
+};
+
+static void __init export_crashk_values(struct device_node *node)
+{
+	struct property *prop;
+
+	/* There might be existing crash kernel properties, but we can't
+	 * be sure what's in them, so remove them. */
+	prop = of_find_property(node, "linux,crashkernel-base", NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+
+	prop = of_find_property(node, "linux,crashkernel-size", NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+
+	if (crashk_res.start != 0) {
+		prom_add_property(node, &crashk_base_prop);
+		crashk_size = crashk_res.end - crashk_res.start + 1;
+		prom_add_property(node, &crashk_size_prop);
+	}
+}
+
 static int __init kexec_setup(void)
 {
 	struct device_node *node;
@@ -145,6 +179,8 @@ static int __init kexec_setup(void)
 	kernel_end = __pa(_end);
 	prom_add_property(node, &kernel_end_prop);
 
+	export_crashk_values(node);
+
 	of_node_put(node);
 	return 0;
 }
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a89bce8..49e705f 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -303,18 +303,18 @@ static struct property htab_size_prop = {
 	.value = &htab_size_bytes,
 };
 
-static void __init export_htab_values(void)
+static int __init export_htab_values(void)
 {
 	struct device_node *node;
 	struct property *prop;
 
 	/* On machines with no htab htab_address is NULL */
 	if (!htab_address)
-		return;
+		return -ENODEV;
 
 	node = of_find_node_by_path("/chosen");
 	if (!node)
-		return;
+		return -ENODEV;
 
 	/* remove any stale propertys so ours can be found */
 	prop = of_find_property(node, htab_base_prop.name, NULL);
@@ -329,54 +329,6 @@ static void __init export_htab_values(void)
 	prom_add_property(node, &htab_size_prop);
 
 	of_node_put(node);
-}
-
-static struct property crashk_base_prop = {
-	.name = "linux,crashkernel-base",
-	.length = sizeof(unsigned long),
-	.value = &crashk_res.start,
-};
-
-static unsigned long crashk_size;
-
-static struct property crashk_size_prop = {
-	.name = "linux,crashkernel-size",
-	.length = sizeof(unsigned long),
-	.value = &crashk_size,
-};
-
-static void __init export_crashk_values(void)
-{
-	struct device_node *node;
-	struct property *prop;
-
-	node = of_find_node_by_path("/chosen");
-	if (!node)
-		return;
-
-	/* There might be existing crash kernel properties, but we can't
-	 * be sure what's in them, so remove them. */
-	prop = of_find_property(node, "linux,crashkernel-base", NULL);
-	if (prop)
-		prom_remove_property(node, prop);
-
-	prop = of_find_property(node, "linux,crashkernel-size", NULL);
-	if (prop)
-		prom_remove_property(node, prop);
-
-	if (crashk_res.start != 0) {
-		prom_add_property(node, &crashk_base_prop);
-		crashk_size = crashk_res.end - crashk_res.start + 1;
-		prom_add_property(node, &crashk_size_prop);
-	}
-
-	of_node_put(node);
-}
-
-static int __init kexec_setup(void)
-{
-	export_htab_values();
-	export_crashk_values();
 	return 0;
 }
-__initcall(kexec_setup);
+late_initcall(export_htab_values);
-- 
1.5.6.5
