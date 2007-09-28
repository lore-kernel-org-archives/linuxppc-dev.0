Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo3so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 6DC39DDE0E
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 04:16:51 +1000 (EST)
Received: from pd3mr3so.prod.shaw.ca
	(pd3mr3so-qfe3.prod.shaw.ca [10.0.141.179]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JP30033BC32M2F0@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:16:14 -0600 (MDT)
Received: from pn2ml5so.prod.shaw.ca ([10.0.121.149])
	by pd3mr3so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP300KGMC318N30@pd3mr3so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Sep 2007 12:16:13 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP3004DNC315F40@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Sep 2007 12:16:13 -0600 (MDT)
Date: Fri, 28 Sep 2007 12:16:22 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 04/18] Xilinx Virtex: Add generic virtex board support
In-reply-to: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
To: linuxppc-dev@ozlabs.org, jwboyer@linux.vnet.ibm.com, jacmet@sunsite.dk
Message-id: <20070928181613.18608.9895.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070928181421.18608.74224.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

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
index 0000000..ede982c
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
+#include <asm/machdep.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+#include <asm/xilinx_intc.h>
+#include <asm/of_platform.h>
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
