Return-Path: <msm@freescale.com>
Received: from AM1EHSOBE001.bigfish.com (mail-am1.bigfish.com
	[213.199.180.138]) by ozlabs.org (Postfix) with ESMTP id 8DE70B6ED0
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Jul 2010 05:36:35 +1000 (EST)
Received: from mail48-am1 (localhost.localdomain [127.0.0.1])	by
	mail48-am1-R.bigfish.com (Postfix) with ESMTP id 4CBBB18F83FC	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jul 2010 19:21:16 +0000 (UTC)
Received: from am1ehsmhs011.bigfish.com (unknown [10.3.201.244])	by
	mail48-am1.bigfish.com (Postfix) with ESMTP id D3E2CF30051	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jul 2010 19:21:15 +0000 (UTC)
Received: from az33smr01.freescale.net (az33smr01.freescale.net
	[10.64.34.199])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o6DJLDOi021678	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 12:21:13 -0700 (MST)
From: Matthew McClintock <msm@freescale.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V3] powerpc:prom Export device tree physical address via proc
Date: Tue, 13 Jul 2010 14:21:24 -0500
Message-ID: <1279048884-30996-1-git-send-email-msm@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Matthew McClintock <msm@freescale.com>,
	Kumar Gala <kumar.gala@freescale.com>
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
V3: Remove unneeded cast, and fixed indentation screw up

V2: messed up changes

 arch/powerpc/kernel/prom.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 45 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index fd9359a..79c1f35 100644
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
+	prop = of_find_property(node, "linux,devietree-end", NULL);
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
