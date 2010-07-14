Return-Path: <msm@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
	[216.32.180.13]) by ozlabs.org (Postfix) with ESMTP id C1322B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Jul 2010 01:18:57 +1000 (EST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V4] powerpc/prom: Export device tree physical address via proc
Date: Wed, 14 Jul 2010 10:18:53 -0500
Message-ID: <1279120733-13584-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>,
	Kumar Gala <kumar.gala@freescale.com>, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

To build a proper flat device tree for kexec we need to know which
memreserve region was used for the device tree for the currently
running kernel, so we can remove it and replace it with the new
memreserve for the kexec'ed kernel

Signed-off-by: Matthew McClintock <msm@freescale.com>
---
V4: Fixed misspelling

V3: Remove unneeded cast, and fixed indentation screw up

V2: messed up changes

 arch/powerpc/kernel/prom.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fd9359a..ff3e240 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -32,6 +32,7 @@
 #include <linux/debugfs.h>
 #include <linux/irq.h>
 #include <linux/lmb.h>
+#include <linux/bootmem.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -911,3 +912,47 @@ static int __init export_flat_device_tree(void)
 }
 __initcall(export_flat_device_tree);
 #endif
+
+#ifdef CONFIG_KEXEC
+static phys_addr_t flat_dt_start;
+static phys_addr_t flat_dt_end;
+
+static struct property flat_dt_start_prop = {
+	.name = "linux,devicetree-start",
+	.length = sizeof(phys_addr_t),
+	.value = &flat_dt_start,
+};
+
+static struct property flat_dt_end_prop = {
+	.name = "linux,devicetree-end",
+	.length = sizeof(phys_addr_t),
+	.value = &flat_dt_end,
+};
+
+static int __init export_flat_device_tree_phys_addr(void)
+{
+	struct property *prop;
+	struct device_node *node;
+
+	node = of_find_node_by_path("/chosen");
+	if (!node)
+		return -ENOENT;
+
+	prop = of_find_property(node, "linux,devicetree-start", NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+
+	prop = of_find_property(node, "linux,devicetree-end", NULL);
+	if (prop)
+		prom_remove_property(node, prop);
+
+	flat_dt_start = virt_to_phys(initial_boot_params);
+	flat_dt_end = virt_to_phys(initial_boot_params)
+				+ initial_boot_params->totalsize;
+	prom_add_property(node, &flat_dt_start_prop);
+	prom_add_property(node, &flat_dt_end_prop);
+
+	return 0;
+}
+__initcall(export_flat_device_tree_phys_addr);
+#endif
-- 
1.6.6.1
