Return-Path: <linnj@wolfgang-pc.public.xilinx.com>
Received: from SG2EHSOBE001.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 15650DDF05
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jul 2008 00:05:10 +1000 (EST)
From: John Linn <john.linn@xilinx.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [V3] powerpc: Xilinx: add 440 platform support
Date: Thu, 3 Jul 2008 07:05:04 -0700
Message-ID: <20080703140504.79D886C0046@mail17-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Support for the Xilinx Virtex5 FXT 440 is being
added.

Signed-off-by: John Linn <john.linn@xilinx.com>
---
V1 & V2
	bad mailing list address, never got to mailing list
V3
	added more help to Kconfig, requested from Josh

 arch/powerpc/platforms/44x/Kconfig  |   26 +++++++++++++++
 arch/powerpc/platforms/44x/Makefile |    1 +
 arch/powerpc/platforms/44x/virtex.c |   60 +++++++++++++++++++++++++++++++++++
 3 files changed, 87 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/44x/virtex.c

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 6abe913..429ae34 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -102,6 +102,22 @@ config YOSEMITE
 #	help
 #	  This option enables support for the IBM PPC440GX evaluation board.
 
+config XILINX_VIRTEX440_GENERIC_BOARD
+	bool "Generic Xilinx Virtex 440 board"
+	depends on 44x
+	default n
+	select XILINX_VIRTEX_5_FXT
+	help
+	  This option enables generic support for Xilinx Virtex based boards
+	  that use a 440 based processor in the Virtex 5 FXT FPGA architecture.
+
+	  The generic virtex board support matches any device tree which
+	  specifies 'xlnx,virtex440' in its compatible field.  This includes
+	  the Xilinx ML5xx reference designs using the powerpc core.
+
+	  Most Virtex 5 designs should use this unless it needs to do some
+	  special configuration at board probe time.
+
 # 44x specific CPU modules, selected based on the board above.
 config 440EP
 	bool
@@ -152,3 +168,13 @@ config 460EX
 # 44x errata/workaround config symbols, selected by the CPU models above
 config IBM440EP_ERR42
 	bool
+
+# Xilinx specific config options.
+config XILINX_VIRTEX
+	bool
+
+# Xilinx Virtex 5 FXT FPGA architecture, selected by a Xilinx board above
+config XILINX_VIRTEX_5_FXT
+	bool
+	select XILINX_VIRTEX
+
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 774165f..dbfae1d 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_RAINIER)	+= rainier.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_WARP)	+= warp-nand.o
 obj-$(CONFIG_CANYONLANDS) += canyonlands.o
+obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
diff --git a/arch/powerpc/platforms/44x/virtex.c b/arch/powerpc/platforms/44x/virtex.c
new file mode 100644
index 0000000..68637fa
--- /dev/null
+++ b/arch/powerpc/platforms/44x/virtex.c
@@ -0,0 +1,60 @@
+/*
+ * Xilinx Virtex 5FXT based board support, derived from
+ * the Xilinx Virtex (IIpro & 4FX) based board support
+ *
+ * Copyright 2007 Secret Lab Technologies Ltd.
+ * Copyright 2008 Xilinx, Inc.
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
+#include <asm/reg.h>
+#include <asm/ppc4xx.h>
+#include "44x.h"
+
+static struct of_device_id xilinx_of_bus_ids[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{ .compatible = "xlnx,plb-v46-1.00.a", },
+	{ .compatible = "xlnx,plb-v46-1.02.a", },
+	{ .compatible = "xlnx,plb-v34-1.01.a", },
+	{ .compatible = "xlnx,plb-v34-1.02.a", },
+	{ .compatible = "xlnx,opb-v20-1.10.c", },
+	{ .compatible = "xlnx,dcr-v29-1.00.a", },
+	{ .compatible = "xlnx,compound", },
+	{}
+};
+
+static int __init virtex_device_probe(void)
+{
+	of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(virtex, virtex_device_probe);
+
+static int __init virtex_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (!of_flat_dt_is_compatible(root, "xlnx,virtex440"))
+		return 0;
+
+	return 1;
+}
+
+define_machine(virtex) {
+	.name			= "Xilinx Virtex440",
+	.probe			= virtex_probe,
+	.init_IRQ		= xilinx_intc_init_tree,
+	.get_irq		= xilinx_intc_get_irq,
+	.calibrate_decr		= generic_calibrate_decr,
+	.restart		= ppc4xx_reset_system,
+};
-- 
1.5.2.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
