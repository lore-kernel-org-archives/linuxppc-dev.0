Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D900DDDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 12:37:10 +1100 (EST)
Date: Mon, 20 Oct 2008 20:37:03 -0500 (CDT)
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Message-id: <kexec-stale-props-t2@bga.com>
To: linuxppc-dev@ozlabs.org
Subject: powerpc: find and destroy possible stale kernel added properties
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

64 bit powerpc requires the kexec user space tools avoid overwriting
the static kernel image and translation hash table when choosing
where to put memory image data because it copies the data into place
using the kernels virtual memory system.  Kexec userspace determines
these and other areas blocked by reading properties the kernel adds,
but does not filter these properties when creating the device tree
for the next kernel.

When the second kernel tries to add its values for these properties,
the export via /proc/device-tree is hidden by the pre-existing but
stale values from the flat tree.  Kexec userspace reads the old
property, allocates the new kernel at the old kernel's end, and
gets rejected by the overlap check.

Search and remove these stale properties before adding the new values.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
X-Patchwork-ID: 19579
tested in July, compile tested on next-20081017

While there is an override flag to tell kexec a minimum memory to use, that
is a crude and manual workaround; this should be applied to stable.


---
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
 
