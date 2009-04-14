Return-Path: <tiejun.china@gamil.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 78616DE0BA
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 21:54:10 +1000 (EST)
From: tiejun.china@gamil.com
To: segher@kernel.crashing.org
Subject: [v2 PATCH 1/1] Fix 64bit Maple Host Bridge 'reg' property
Date: Tue, 14 Apr 2009 18:13:41 +0800
Message-Id: <1239704021-12431-1-git-send-email-tiejun.china@gamil.com>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In the DTB tree created by firmware on some Maple 64bit targets, such as ATCA6101, 
the "reg" property of host bridge node is incorrectly encoded as if #address-cells 
and #size-cells were 1. So we have to provide one fixup function to fix that.

Signed-off-by: Tiejun Chen <tiejun.china@gmail.com>
---
 arch/powerpc/kernel/prom_init.c |   50 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 2445945..36ef9f2 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1907,14 +1907,62 @@ static void __init flatten_device_tree(void)
 }
 
 #ifdef CONFIG_PPC_MAPLE
+/* On ATCA6101 64bit target host bridge parent node has specified address and
+ * size properties to be 2. But the actual "cell" value for host bridge node 
+ * is 1 since early MOTLoad internal bug. */
+static void __init fixup_device_tree_atca6101(void)
+{
+	phandle hb;
+	u32 hb_ranges[4];
+	u32 size_cell, addr_cell;
+	struct prom_t *_prom = &RELOC(prom);
+	char *name;
+
+	name = "/hostbridge@f8000000";
+	hb = call_prom("finddevice", 1, 1, ADDR(name));
+	if (!PHANDLE_VALID(hb))
+		return;
+
+	if (prom_getproplen(hb, "reg") != 8)
+		return;
+
+	if (prom_getprop(hb, "reg", hb_ranges, (sizeof(hb_ranges))/2) 
+		== PROM_ERROR)
+		return;
+
+	prom_getprop(_prom->root, "#address-cells", &addr_cell, sizeof(addr_cell));
+	prom_getprop(_prom->root, "#size-cells", &size_cell, sizeof(size_cell));
+	
+	if ((addr_cell != 2) || (size_cell != 2) || 
+		(hb_ranges[0] != 0xf8000000))
+		return;
+
+	prom_printf("Fixing up bogus HOSTBRIDGE reg on ATCA6101...\n");
+
+	hb_ranges[3] = hb_ranges[1];
+	hb_ranges[1] = hb_ranges[0];
+	hb_ranges[0] = hb_ranges[2] = 0;
+	prom_setprop(hb, name, "reg", hb_ranges, sizeof(hb_ranges));
+}
 /* PIBS Version 1.05.0000 04/26/2005 has an incorrect /ht/isa/ranges property.
- * The values are bad, and it doesn't even have the right number of cells. */
+ * The values are bad, and it doesn't even have the right number of cells. 
+ * Additionally, the early MOTLoad generate incorrect address&size cells on 
+ * some Maple platform such as ATCA6101. */ 
 static void __init fixup_device_tree_maple(void)
 {
 	phandle isa;
 	u32 rloc = 0x01002000; /* IO space; PCI device = 4 */
 	u32 isa_ranges[6];
 	char *name;
+	u32 node;
+	char prop[64];
+	int model;
+	
+	/*  FIXME: This may be used for more Maple targets not only ATCA6101. */
+	node = call_prom("finddevice", 1, 1, ADDR("/"));
+	model = prom_getprop(node, "model", prop, sizeof(prop));
+	if (model != PROM_ERROR && (strcmp(prop, "Motorola,ATCA-6101") == 0))
+                fixup_device_tree_atca6101();
 
 	name = "/ht@0/isa@4";
 	isa = call_prom("finddevice", 1, 1, ADDR(name));
-- 
1.5.6
