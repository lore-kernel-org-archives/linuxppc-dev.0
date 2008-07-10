Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D3570DE093
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:23:37 +1000 (EST)
Date: Thu, 10 Jul 2008 16:22:13 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <for-27-patch1-0@bga.com>
Message-Id: <for-27-patch6@bga.com>
Subject: powerpc: find and destroy possible stale kernel added properties
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because we copy the image using the kernels virtual memory system, we
require kexec user space to avoid overwriting the static kernel image, tce
tables, and the hash table.  Kexec userspace gets this information by
reading propertys the kernel adds, but does not filter these propertys when
starting the next kernel.

When the second kernel trys to add its propertys, the export via
/proc/device-tree is hidden by the pre-existing but stale value from the
flat tree.  Kexec userspace reads the old property, allocates the new kernel
at the old kernel's end, and gets rejected by the check

Search and remove these stale properties before adding the new values.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
While there is an override flag to tell kexec a minimum memory to use, that
is a crude workaround and this should be applied to stable.


diff --git a/arch/powerpc/kernel/machine_kexec_64.c b/arch/powerpc/kernel/machine_kexec_64.c
index a168514..4bd8b4f 100644
--- a/arch/powerpc/kernel/machine_kexec_64.c
+++ b/arch/powerpc/kernel/machine_kexec_64.c
@@ -312,11 +312,24 @@ static struct property kernel_end_prop = {
 static void __init export_htab_values(void)
 {
 	struct device_node *node;
+	struct property *prop;
 
 	node = of_find_node_by_path("/chosen");
 	if (!node)
 		return;
 
+	/* remove any stale propertys so ours can be found */
+	prop = of_find_property(node, kernel_end_prop.name, NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+	prop = of_find_property(node, htab_base_prop.name, NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+	prop = of_find_property(node, htab_size_prop.name, NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+
+	/* information needed by userspace when using default_machine_kexec */
 	kernel_end = __pa(_end);
 	prom_add_property(node, &kernel_end_prop);
 
