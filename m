Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3771BDDF60
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 03:23:01 +1100 (EST)
Date: Tue, 16 Dec 2008 19:22:59 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] powerpc: Setup OF properties for ppc32 kexec
Message-ID: <20081216162259.GA21749@oksana.dev.rtsoft.ru>
References: <20081216162217.GA3885@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20081216162217.GA3885@oksana.dev.rtsoft.ru>
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
both ppc64 and ppc32.  This is needed for kexec to work on ppc32
platforms.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/kernel/machine_kexec.c    |   34 ++++++++++++++++++++++++++++++++
 arch/powerpc/kernel/machine_kexec_64.c |   24 ++++-----------------
 2 files changed, 39 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/machine_kexec.c b/arch/powerpc/kernel/machine_kexec.c
index ac2a21f..037ade7 100644
--- a/arch/powerpc/kernel/machine_kexec.c
+++ b/arch/powerpc/kernel/machine_kexec.c
@@ -13,8 +13,10 @@
 #include <linux/reboot.h>
 #include <linux/threads.h>
 #include <linux/lmb.h>
+#include <linux/of.h>
 #include <asm/machdep.h>
 #include <asm/prom.h>
+#include <asm/sections.h>
 
 void machine_crash_shutdown(struct pt_regs *regs)
 {
@@ -118,3 +120,35 @@ int overlaps_crashkernel(unsigned long start, unsigned long size)
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
+static int __init kexec_setup(void)
+{
+	struct device_node *node;
+	struct property *prop;
+
+	node = of_find_node_by_path("/chosen");
+	if (!node)
+		return -ENOENT;
+
+	/* remove any stale properties so ours can be found */
+	prop = of_find_property(node, kernel_end_prop.name, NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+
+	/* information needed by userspace when using default_machine_kexec */
+	kernel_end = __pa(_end);
+	prom_add_property(node, &kernel_end_prop);
+
+	of_node_put(node);
+	return 0;
+}
+late_initcall(kexec_setup);
diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index 3c4ca04..a89bce8 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -289,7 +289,7 @@ void default_machine_kexec(struct kimage *image)
 }
 
 /* Values we need to export to the second kernel via the device tree. */
-static unsigned long htab_base, kernel_end;
+static unsigned long htab_base;
 
 static struct property htab_base_prop = {
 	.name = "linux,htab-base",
@@ -303,25 +303,20 @@ static struct property htab_size_prop = {
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
 	struct property *prop;
 
+	/* On machines with no htab htab_address is NULL */
+	if (!htab_address)
+		return;
+
 	node = of_find_node_by_path("/chosen");
 	if (!node)
 		return;
 
 	/* remove any stale propertys so ours can be found */
-	prop = of_find_property(node, kernel_end_prop.name, NULL);
-	if (prop)
-		prom_remove_property(node, prop);
 	prop = of_find_property(node, htab_base_prop.name, NULL);
 	if (prop)
 		prom_remove_property(node, prop);
@@ -329,19 +324,10 @@ static void __init export_htab_values(void)
 	if (prop)
 		prom_remove_property(node, prop);
 
-	/* information needed by userspace when using default_machine_kexec */
-	kernel_end = __pa(_end);
-	prom_add_property(node, &kernel_end_prop);
-
-	/* On machines with no htab htab_address is NULL */
-	if (NULL == htab_address)
-		goto out;
-
 	htab_base = __pa(htab_address);
 	prom_add_property(node, &htab_base_prop);
 	prom_add_property(node, &htab_size_prop);
 
- out:
 	of_node_put(node);
 }
 
-- 
1.5.6.5
