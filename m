Return-Path: <wre@wolfgang-pc.public.xilinx.com>
Received: from outbound3-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id CB959DDED0
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 10:50:51 +1000 (EST)
Received: from outbound3-cpk.bigfish.com (localhost [127.0.0.1])
	by outbound3-cpk-R.bigfish.com (Postfix) with ESMTP id 558B1668078
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:50:49 +0000 (UTC)
Received: from mail8-cpk-R.bigfish.com (unknown [10.2.40.3])
	by outbound3-cpk.bigfish.com (Postfix) with ESMTP id 5381180004B
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:50:49 +0000 (UTC)
Received: from mail8-cpk (localhost.localdomain [127.0.0.1])
	by mail8-cpk-R.bigfish.com (Postfix) with ESMTP id 452E38202EA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:50:49 +0000 (UTC)
Received: from xsj-gw1 (unknown [149.199.60.83])
	by mail8-cpk.bigfish.com (Postfix) with ESMTP id 12FE46F8069
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 22 Aug 2007 00:50:49 +0000 (UTC)
Received: from unknown-38-66.xilinx.com
	([149.199.38.66] helo=xsj-smtp1.xilinx.com
	ident=[U2FsdGVkX1+cIu2bsQyvvyzJatcxXI1Ok4dszLGgons=])
	by xsj-gw1 with esmtp (Exim 4.63)
	(envelope-from <wre@wolfgang-pc.public.xilinx.com>)
	id 1INeQp-0006zY-Qx
	for linuxppc-embedded@ozlabs.org; Tue, 21 Aug 2007 17:50:47 -0700
From: wolfgang.reissnegger@xilinx.com
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 2/3] Consolidate XILINX_VIRTEX board support.
Date: Tue, 21 Aug 2007 17:53:12 -0700
In-Reply-To: <1187743993171-git-send-email-wolfgang.reissnegger@xilinx.com>
References: <1187743993171-git-send-email-wolfgang.reissnegger@xilinx.com>
Message-Id: <20070822005049.12FE46F8069@mail8-cpk.bigfish.com>
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>

Make support for Xilinx boards more generic, making it easier
to add new boards.  ML300 and ML403 now use this.  Added
CONFIG_XILINX_EMBED_CONFIG to do the consolidation, while still
allowing boards not in the tree to avoid embed_config.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
Signed-off-by: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
---
 arch/ppc/boot/simple/Makefile               |    3 +-
 arch/ppc/boot/simple/embed_config.c         |    4 +-
 arch/ppc/platforms/4xx/Kconfig              |    6 +
 arch/ppc/platforms/4xx/Makefile             |    4 +-
 arch/ppc/platforms/4xx/xilinx_generic_ppc.c |  133 +++++++++++++++++++++++++++
 arch/ppc/platforms/4xx/xilinx_ml300.c       |  118 ------------------------
 arch/ppc/platforms/4xx/xilinx_ml403.c       |  120 ------------------------
 7 files changed, 144 insertions(+), 244 deletions(-)
 create mode 100644 arch/ppc/platforms/4xx/xilinx_generic_ppc.c
 delete mode 100644 arch/ppc/platforms/4xx/xilinx_ml300.c
 delete mode 100644 arch/ppc/platforms/4xx/xilinx_ml403.c

diff --git a/arch/ppc/boot/simple/Makefile b/arch/ppc/boot/simple/Makefile
index 5b87779..8581bea 100644
--- a/arch/ppc/boot/simple/Makefile
+++ b/arch/ppc/boot/simple/Makefile
@@ -187,8 +187,7 @@ boot-$(CONFIG_REDWOOD_6)	+= embed_config.o
 boot-$(CONFIG_8xx)		+= embed_config.o
 boot-$(CONFIG_8260)		+= embed_config.o
 boot-$(CONFIG_EP405)		+= embed_config.o
-boot-$(CONFIG_XILINX_ML300)	+= embed_config.o
-boot-$(CONFIG_XILINX_ML403)	+= embed_config.o
+boot-$(CONFIG_XILINX_EMBED_CONFIG)	+= embed_config.o
 boot-$(CONFIG_BSEIP)		+= iic.o
 boot-$(CONFIG_MBX)		+= iic.o pci.o qspan_pci.o
 boot-$(CONFIG_MV64X60)		+= misc-mv64x60.o
diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
index 840bff2..b0e599b 100644
--- a/arch/ppc/boot/simple/embed_config.c
+++ b/arch/ppc/boot/simple/embed_config.c
@@ -744,7 +744,7 @@ embed_config(bd_t **bdp)
 }
 #endif /* WILLOW */
 
-#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_XILINX_ML403)
+#if defined(CONFIG_XILINX_EMBED_CONFIG)
 void
 embed_config(bd_t ** bdp)
 {
@@ -781,7 +781,7 @@ embed_config(bd_t ** bdp)
 	timebase_period_ns = 1000000000 / bd->bi_tbfreq;
 	/* see bi_tbfreq definition in arch/ppc/platforms/4xx/xilinx_ml300.h */
 }
-#endif /* CONFIG_XILINX_ML300 || CONFIG_XILINX_ML403 */
+#endif /* CONFIG_XILINX_EMBED_CONFIG */
 
 #ifdef CONFIG_IBM_OPENBIOS
 /* This could possibly work for all treeboot roms.
diff --git a/arch/ppc/platforms/4xx/Kconfig b/arch/ppc/platforms/4xx/Kconfig
index 76551b6..60fcfc1 100644
--- a/arch/ppc/platforms/4xx/Kconfig
+++ b/arch/ppc/platforms/4xx/Kconfig
@@ -57,6 +57,7 @@ config XILINX_ML300
 	bool "Xilinx-ML300"
 	select XILINX_VIRTEX_II_PRO
 	select EMBEDDEDBOOT
+	select XILINX_EMBED_CONFIG
 	help
 	  This option enables support for the Xilinx ML300 evaluation board.
 
@@ -64,8 +65,10 @@ config XILINX_ML403
 	bool "Xilinx-ML403"
 	select XILINX_VIRTEX_4_FX
 	select EMBEDDEDBOOT
+	select XILINX_EMBED_CONFIG
 	help
 	  This option enables support for the Xilinx ML403 evaluation board.
+
 endchoice
 
 choice
@@ -229,6 +232,9 @@ config XILINX_VIRTEX_4_FX
 config XILINX_VIRTEX
 	bool
 
+config XILINX_EMBED_CONFIG
+	bool
+
 config STB03xxx
 	bool
 	depends on REDWOOD_5 || REDWOOD_6
diff --git a/arch/ppc/platforms/4xx/Makefile b/arch/ppc/platforms/4xx/Makefile
index 723ad79..141f248 100644
--- a/arch/ppc/platforms/4xx/Makefile
+++ b/arch/ppc/platforms/4xx/Makefile
@@ -14,8 +14,8 @@ obj-$(CONFIG_REDWOOD_6)		+= redwood6.o
 obj-$(CONFIG_SYCAMORE)		+= sycamore.o
 obj-$(CONFIG_TAISHAN)		+= taishan.o
 obj-$(CONFIG_WALNUT)		+= walnut.o
-obj-$(CONFIG_XILINX_ML300)	+= xilinx_ml300.o
-obj-$(CONFIG_XILINX_ML403)	+= xilinx_ml403.o
+obj-$(CONFIG_XILINX_ML300)	+= xilinx_generic_ppc.o
+obj-$(CONFIG_XILINX_ML403)	+= xilinx_generic_ppc.o
 
 obj-$(CONFIG_405GP)		+= ibm405gp.o
 obj-$(CONFIG_REDWOOD_5)		+= ibmstb4.o
diff --git a/arch/ppc/platforms/4xx/xilinx_generic_ppc.c b/arch/ppc/platforms/4xx/xilinx_generic_ppc.c
new file mode 100644
index 0000000..fd8bd40
--- /dev/null
+++ b/arch/ppc/platforms/4xx/xilinx_generic_ppc.c
@@ -0,0 +1,133 @@
+/*
+ * Xilinx Generic PPC evaluation board initialization
+ *
+ * Author: MontaVista Software, Inc.
+ *         source@mvista.com
+ *
+ * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
+ * terms of the GNU General Public License version 2.  This program is licensed
+ * "as is" without any warranty of any kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/irq.h>
+#include <linux/tty.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/serial_8250.h>
+#include <linux/serialP.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+
+#include <syslib/gen550.h>
+#include <syslib/virtex_devices.h>
+#include <platforms/4xx/xparameters/xparameters.h>
+
+/*
+ * As an overview of how the following functions (platform_init,
+ * xilinx_generic_ppc_map_io, xilinx_generic_ppc_setup_arch and xilinx_generic_ppc_init_IRQ) fit into the
+ * kernel startup procedure, here's a call tree:
+ *
+ * start_here					arch/ppc/kernel/head_4xx.S
+ *  early_init					arch/ppc/kernel/setup.c
+ *  machine_init				arch/ppc/kernel/setup.c
+ *    platform_init				this file
+ *      ppc4xx_init				arch/ppc/syslib/ppc4xx_setup.c
+ *        parse_bootinfo
+ *          find_bootinfo
+ *        "setup some default ppc_md pointers"
+ *  MMU_init					arch/ppc/mm/init.c
+ *    *ppc_md.setup_io_mappings == xilinx_generic_ppc_map_io	this file
+ *      ppc4xx_map_io				arch/ppc/syslib/ppc4xx_setup.c
+ *  start_kernel				init/main.c
+ *    setup_arch				arch/ppc/kernel/setup.c
+ * #if defined(CONFIG_KGDB)
+ *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
+ * #endif
+ *      *ppc_md.setup_arch == xilinx_generic_ppc_setup_arch	this file
+ *        ppc4xx_setup_arch			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_find_bridges			arch/ppc/syslib/ppc405_pci.c
+ *    init_IRQ					arch/ppc/kernel/irq.c
+ *      *ppc_md.init_IRQ == xilinx_generic_ppc_init_IRQ	this file
+ *        ppc4xx_init_IRQ			arch/ppc/syslib/ppc4xx_setup.c
+ *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
+ */
+
+#if defined(CONFIG_XILINX_VIRTEX_II_PRO)
+#define XILINX_ARCH "Virtex-II Pro"
+#elif defined(CONFIG_XILINX_VIRTEX_4_FX)
+#define XILINX_ARCH "Virtex-4 FX"
+#else
+#error "No Xilinx Architecture recognized."
+#endif
+
+#if defined(CONFIG_XILINX_ML300)
+const char *virtex_machine_name = "Xilinx ML300";
+#elif defined(CONFIG_XILINX_XUPV2P)
+const char *virtex_machine_name = "Xilinx XUPV2P";
+#elif defined(CONFIG_XILINX_ML40x)
+const char *virtex_machine_name = "Xilinx ML40x";
+#elif defined(CONFIG_XILINX_ML41x)
+const char *virtex_machine_name = "Xilinx ML41x";
+#else
+const char *virtex_machine_name = "Unknown Xilinx with PowerPC";
+#endif
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+static void __iomem *powerdown_base =
+    (void __iomem *)XPAR_POWER_0_POWERDOWN_BASEADDR;
+
+static void xilinx_power_off(void)
+{
+	local_irq_disable();
+	out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VALUE);
+	while (1) ;
+}
+#endif
+
+void __init xilinx_generic_ppc_map_io(void)
+{
+	ppc4xx_map_io();
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+	powerdown_base = ioremap(XPAR_POWER_0_POWERDOWN_BASEADDR
+				 XPAR_POWER_0_POWERDOWN_HIGHADDR -
+				 XPAR_POWER_0_POWERDOWN_BASEADDR + 1);
+#endif
+}
+
+void __init xilinx_generic_ppc_setup_arch(void)
+{
+	virtex_early_serial_map();
+	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
+
+	/* Identify the system */
+	printk(KERN_INFO
+	       "Xilinx Generic PowerPC board support package (%s) (%s)\n",
+	       PPC4xx_MACHINE_NAME, XILINX_ARCH);
+}
+
+/* Called after board_setup_irq from ppc4xx_init_IRQ(). */
+void __init xilinx_generic_ppc_init_irq(void)
+{
+	ppc4xx_init_IRQ();
+}
+
+void __init __attribute((weak))
+platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
+	      unsigned long r6, unsigned long r7)
+{
+	ppc4xx_init(r3, r4, r5, r6, r7);
+
+	ppc_md.setup_arch = xilinx_generic_ppc_setup_arch;
+	ppc_md.setup_io_mappings = xilinx_generic_ppc_map_io;
+	ppc_md.init_IRQ = xilinx_generic_ppc_init_irq;
+
+#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
+	ppc_md.power_off = xilinx_power_off;
+#endif
+
+#ifdef CONFIG_KGDB
+	ppc_md.early_serial_map = virtex_early_serial_map;
+#endif
+}
diff --git a/arch/ppc/platforms/4xx/xilinx_ml300.c b/arch/ppc/platforms/4xx/xilinx_ml300.c
deleted file mode 100644
index 6e522fe..0000000
--- a/arch/ppc/platforms/4xx/xilinx_ml300.c
+++ /dev/null
@@ -1,118 +0,0 @@
-/*
- * Xilinx ML300 evaluation board initialization
- *
- * Author: MontaVista Software, Inc.
- *         source@mvista.com
- *
- * 2002-2004 (c) MontaVista Software, Inc.  This file is licensed under the
- * terms of the GNU General Public License version 2.  This program is licensed
- * "as is" without any warranty of any kind, whether express or implied.
- */
-
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/tty.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/serial_8250.h>
-#include <linux/serialP.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-
-#include <syslib/gen550.h>
-#include <syslib/virtex_devices.h>
-#include <platforms/4xx/xparameters/xparameters.h>
-
-/*
- * As an overview of how the following functions (platform_init,
- * ml300_map_io, ml300_setup_arch and ml300_init_IRQ) fit into the
- * kernel startup procedure, here's a call tree:
- *
- * start_here					arch/ppc/kernel/head_4xx.S
- *  early_init					arch/ppc/kernel/setup.c
- *  machine_init				arch/ppc/kernel/setup.c
- *    platform_init				this file
- *      ppc4xx_init				arch/ppc/syslib/ppc4xx_setup.c
- *        parse_bootinfo
- *          find_bootinfo
- *        "setup some default ppc_md pointers"
- *  MMU_init					arch/ppc/mm/init.c
- *    *ppc_md.setup_io_mappings == ml300_map_io	this file
- *      ppc4xx_map_io				arch/ppc/syslib/ppc4xx_setup.c
- *  start_kernel				init/main.c
- *    setup_arch				arch/ppc/kernel/setup.c
- * #if defined(CONFIG_KGDB)
- *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
- * #endif
- *      *ppc_md.setup_arch == ml300_setup_arch	this file
- *        ppc4xx_setup_arch			arch/ppc/syslib/ppc4xx_setup.c
- *          ppc4xx_find_bridges			arch/ppc/syslib/ppc405_pci.c
- *    init_IRQ					arch/ppc/kernel/irq.c
- *      *ppc_md.init_IRQ == ml300_init_IRQ	this file
- *        ppc4xx_init_IRQ			arch/ppc/syslib/ppc4xx_setup.c
- *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
- */
-
-const char* virtex_machine_name = "ML300 Reference Design";
-
-#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
-static volatile unsigned *powerdown_base =
-    (volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;
-
-static void
-xilinx_power_off(void)
-{
-	local_irq_disable();
-	out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VALUE);
-	while (1) ;
-}
-#endif
-
-void __init
-ml300_map_io(void)
-{
-	ppc4xx_map_io();
-
-#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
-	powerdown_base = ioremap((unsigned long) powerdown_base,
-				 XPAR_POWER_0_POWERDOWN_HIGHADDR -
-				 XPAR_POWER_0_POWERDOWN_BASEADDR + 1);
-#endif
-}
-
-void __init
-ml300_setup_arch(void)
-{
-	virtex_early_serial_map();
-	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
-
-	/* Identify the system */
-	printk(KERN_INFO "Xilinx ML300 Reference System (Virtex-II Pro)\n");
-}
-
-/* Called after board_setup_irq from ppc4xx_init_IRQ(). */
-void __init
-ml300_init_irq(void)
-{
-	ppc4xx_init_IRQ();
-}
-
-void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-	      unsigned long r6, unsigned long r7)
-{
-	ppc4xx_init(r3, r4, r5, r6, r7);
-
-	ppc_md.setup_arch = ml300_setup_arch;
-	ppc_md.setup_io_mappings = ml300_map_io;
-	ppc_md.init_IRQ = ml300_init_irq;
-
-#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
-	ppc_md.power_off = xilinx_power_off;
-#endif
-
-#ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = virtex_early_serial_map;
-#endif
-}
-
diff --git a/arch/ppc/platforms/4xx/xilinx_ml403.c b/arch/ppc/platforms/4xx/xilinx_ml403.c
deleted file mode 100644
index bc3ace3..0000000
--- a/arch/ppc/platforms/4xx/xilinx_ml403.c
+++ /dev/null
@@ -1,120 +0,0 @@
-/*
- * Xilinx ML403 evaluation board initialization
- *
- * Author: Grant Likely <grant.likely@secretlab.ca>
- *
- * 2005-2007 (c) Secret Lab Technologies Ltd.
- * 2002-2004 (c) MontaVista Software, Inc.
- *
- * This file is licensed under the terms of the GNU General Public License
- * version 2.  This program is licensed "as is" without any warranty of any
- * kind, whether express or implied.
- */
-
-#include <linux/init.h>
-#include <linux/irq.h>
-#include <linux/tty.h>
-#include <linux/serial.h>
-#include <linux/serial_core.h>
-#include <linux/serial_8250.h>
-#include <linux/serialP.h>
-#include <asm/io.h>
-#include <asm/machdep.h>
-
-#include <syslib/gen550.h>
-#include <syslib/virtex_devices.h>
-#include <platforms/4xx/xparameters/xparameters.h>
-
-/*
- * As an overview of how the following functions (platform_init,
- * ml403_map_io, ml403_setup_arch and ml403_init_IRQ) fit into the
- * kernel startup procedure, here's a call tree:
- *
- * start_here					arch/ppc/kernel/head_4xx.S
- *  early_init					arch/ppc/kernel/setup.c
- *  machine_init				arch/ppc/kernel/setup.c
- *    platform_init				this file
- *      ppc4xx_init				arch/ppc/syslib/ppc4xx_setup.c
- *        parse_bootinfo
- *          find_bootinfo
- *        "setup some default ppc_md pointers"
- *  MMU_init					arch/ppc/mm/init.c
- *    *ppc_md.setup_io_mappings == ml403_map_io	this file
- *      ppc4xx_map_io				arch/ppc/syslib/ppc4xx_setup.c
- *  start_kernel				init/main.c
- *    setup_arch				arch/ppc/kernel/setup.c
- * #if defined(CONFIG_KGDB)
- *      *ppc_md.kgdb_map_scc() == gen550_kgdb_map_scc
- * #endif
- *      *ppc_md.setup_arch == ml403_setup_arch	this file
- *        ppc4xx_setup_arch			arch/ppc/syslib/ppc4xx_setup.c
- *          ppc4xx_find_bridges			arch/ppc/syslib/ppc405_pci.c
- *    init_IRQ					arch/ppc/kernel/irq.c
- *      *ppc_md.init_IRQ == ml403_init_IRQ	this file
- *        ppc4xx_init_IRQ			arch/ppc/syslib/ppc4xx_setup.c
- *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
- */
-
-const char* virtex_machine_name = "ML403 Reference Design";
-
-#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
-static volatile unsigned *powerdown_base =
-    (volatile unsigned *) XPAR_POWER_0_POWERDOWN_BASEADDR;
-
-static void
-xilinx_power_off(void)
-{
-	local_irq_disable();
-	out_be32(powerdown_base, XPAR_POWER_0_POWERDOWN_VALUE);
-	while (1) ;
-}
-#endif
-
-void __init
-ml403_map_io(void)
-{
-	ppc4xx_map_io();
-
-#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
-	powerdown_base = ioremap((unsigned long) powerdown_base,
-				 XPAR_POWER_0_POWERDOWN_HIGHADDR -
-				 XPAR_POWER_0_POWERDOWN_BASEADDR + 1);
-#endif
-}
-
-void __init
-ml403_setup_arch(void)
-{
-	virtex_early_serial_map();
-	ppc4xx_setup_arch();	/* calls ppc4xx_find_bridges() */
-
-	/* Identify the system */
-	printk(KERN_INFO "Xilinx ML403 Reference System (Virtex-4 FX)\n");
-}
-
-/* Called after board_setup_irq from ppc4xx_init_IRQ(). */
-void __init
-ml403_init_irq(void)
-{
-	ppc4xx_init_IRQ();
-}
-
-void __init
-platform_init(unsigned long r3, unsigned long r4, unsigned long r5,
-	      unsigned long r6, unsigned long r7)
-{
-	ppc4xx_init(r3, r4, r5, r6, r7);
-
-	ppc_md.setup_arch = ml403_setup_arch;
-	ppc_md.setup_io_mappings = ml403_map_io;
-	ppc_md.init_IRQ = ml403_init_irq;
-
-#if defined(XPAR_POWER_0_POWERDOWN_BASEADDR)
-	ppc_md.power_off = xilinx_power_off;
-#endif
-
-#ifdef CONFIG_KGDB
-	ppc_md.early_serial_map = virtex_early_serial_map;
-#endif
-}
-
-- 
1.5.2.1
