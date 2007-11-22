Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id A4ECADDE16
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 02:45:18 +1100 (EST)
Date: Thu, 22 Nov 2007 08:45:17 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 01/10] powerpc: Set up OF properties for ppc32 kexec
Message-ID: <20071122154517.GA26340@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071122154159.GA24711@xyzzy.farnsworth.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Refactor the setting of kexec OF properties, moving the common code
from machine_kexec_64.c to machine_kexec.c where it can be used on
both ppc64 and ppc32.  This is needed for kexec to work on ppc32
platforms.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
---
 arch/powerpc/kernel/machine_kexec.c    |   63 ++++++++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c |   67 +++----------------------------
 2 files changed, 70 insertions(+), 60 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index c0c8e8c..691dba7 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -12,8 +12,11 @@
 #include <linux/kexec.h>
 #include <linux/reboot.h>
 #include <linux/threads.h>
+#include <linux/of.h>
 #include <asm/machdep.h>
 #include <asm/lmb.h>
+#include <asm/sections.h>	/* _end */
+#include <asm/prom.h>
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
@@ -115,3 +118,63 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
 {
 	return (start + size) > crashk_res.start && start <= crashk_res.end;
 }
+
+/* Values we need to export to the second kernel via the device tree. */
+static unsigned long kernel_end;
+
+static struct property kernel_end_prop = {
+	.name = "linux,kernel-end",
+	.length = sizeof(unsigned long),
+	.value = &kernel_end,
+};
+
+static struct property crashk_base_prop = {
+	.name = "linux,crashkernel-base",
+	.length = sizeof(unsigned long),
+	.value = &crashk_res.start, };
+
+static unsigned long crashk_size;
+
+static struct property crashk_size_prop = {
+	.name = "linux,crashkernel-size",
+	.length = sizeof(unsigned long),
+	.value = &crashk_size,
+};
+
+static void __init export_crashk_values(void)
+{
+	struct device_node *node;
+	struct property *prop;
+
+	node = of_find_node_by_path("/chosen");
+	if (!node)
+		return;
+
+	kernel_end = __pa(_end);
+	prom_add_property(node, &kernel_end_prop);
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
+
+	of_node_put(node);
+}
+
+static int __init kexec_setup(void)
+{
+	export_crashk_values();
+	return 0;
+}
+__initcall(kexec_setup);
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 704375b..a4bddb7 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -289,7 +289,7 @@ void default_machine_kexec(struct kimage *image)
 }
 
 /* Values we need to export to the second kernel via the device tree. */
-static unsigned long htab_base, kernel_end;
+static unsigned long htab_base;
 
 static struct property htab_base_prop = {
 	.name = "linux,htab-base",
@@ -303,81 +303,28 @@ static struct property htab_size_prop = {
 	.value = &htab_size_bytes,
 };
 
-static struct property kernel_end_prop = {
-	.name = "linux,kernel-end",
-	.length = sizeof(unsigned long),
-	.value = &kernel_end,
-};
-
 static void __init export_htab_values(void)
 {
 	struct device_node *node;
 
-	node = of_find_node_by_path("/chosen");
-	if (!node)
-		return;
-
-	kernel_end = __pa(_end);
-	prom_add_property(node, &kernel_end_prop);
-
 	/* On machines with no htab htab_address is NULL */
 	if (NULL == htab_address)
-		goto out;
-
-	htab_base = __pa(htab_address);
-	prom_add_property(node, &htab_base_prop);
-	prom_add_property(node, &htab_size_prop);
-
- out:
-	of_node_put(node);
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
+		return;
 
 	node = of_find_node_by_path("/chosen");
 	if (!node)
 		return;
 
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
+	htab_base = __pa(htab_address);
+	prom_add_property(node, &htab_base_prop);
+	prom_add_property(node, &htab_size_prop);
 
 	of_node_put(node);
 }
 
-static int __init kexec_setup(void)
+static int __init kexec_setup_64(void)
 {
 	export_htab_values();
-	export_crashk_values();
 	return 0;
 }
-__initcall(kexec_setup);
+__initcall(kexec_setup_64);
-- 
1.5.3.4
