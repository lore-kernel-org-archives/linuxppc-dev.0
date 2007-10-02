Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 0B023DE128
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 12:16:40 +1000 (EST)
Received: from pd2mr4so.prod.shaw.ca
	(pd2mr4so-qfe3.prod.shaw.ca [10.0.141.107]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP9003GKIA8WIF0@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:15:44 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd2mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP900M05IA7M390@pd2mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Mon, 01 Oct 2007 20:15:44 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP9004JLI9QBLB5@l-daemon> for linuxppc-dev@ozlabs.org;
	Mon, 01 Oct 2007 20:15:26 -0600 (MDT)
Date: Mon, 01 Oct 2007 20:15:29 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v3 04/12] Virtex: Add generic Xilinx Virtex board support
In-reply-to: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com
Message-id: <20071002021528.9579.86622.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071002021334.9579.68179.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Adds support for generic Xilinx Virtex boards.  Any board which specifies
"xilinx,virtex" in the compatible property will make use of this board
support.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/40x/Makefile |    1 +
 arch/powerpc/platforms/40x/virtex.c |   50 +++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/40x/Makefile b/arch/powerpc/platforms/40x/Makefile
index e6c0bbd..0a3cfe9 100644
--- a/arch/powerpc/platforms/40x/Makefile
+++ b/arch/powerpc/platforms/40x/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_WALNUT) += walnut.o
+obj-$(CONFIG_XILINX_VIRTEX_GENERIC_BOARD) += virtex.o
diff --git a/arch/powerpc/platforms/40x/virtex.c b/arch/powerpc/platforms/40x/virtex.c
new file mode 100644
index 0000000..b52aa94
--- /dev/null
+++ b/arch/powerpc/platforms/40x/virtex.c
@@ -0,0 +1,50 @@
+/*
+ * Xilinx Virtex (IIpro & 4FX) based board support
+ *
+ * Copyright 2007 Secret Lab Technologies Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/xilinx_intc.h>
+
+static int __init virtex_device_probe(void)
+{
+	if (!machine_is(virtex))
+		return 0;
+
+	of_platform_bus_probe(NULL, NULL, NULL);
+
+	return 0;
+}
+device_initcall(virtex_device_probe);
+
+static int __init virtex_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "xilinx,virtex"))
+		return 0;
+
+	return 1;
+}
+
+static void __init virtex_setup_arch(void)
+{
+}
+
+define_machine(virtex) {
+	.name			= "Xilinx Virtex",
+	.probe			= virtex_probe,
+	.setup_arch		= virtex_setup_arch,
+	.init_IRQ		= xilinx_intc_init_tree,
+	.get_irq		= xilinx_intc_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+};
