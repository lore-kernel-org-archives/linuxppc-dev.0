Return-Path: <Dongsheng.Wang@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 418D11400DA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 15:56:21 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v2 2/2] fsl/corenet_generic: add t104x platform diu special
 initialization
Date: Tue, 15 Apr 2014 13:53:49 +0800
Message-ID: <1397541229-34383-2-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1397541229-34383-1-git-send-email-dongsheng.wang@freescale.com>
References: <1397541229-34383-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, haokexin@gmail.com, prabhakar@freescale.com,
 jason.jin@freescale.com, Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

T104x Platforms based on corenet_generic. The platforms DIU-block
that need a special initialization to solve some callback functions,
those functions depend on platform handle.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
This patch is *depends on* Prabhakar Kushwaha support T104x patchset.

v2: No change.
diff --git a/arch/powerpc/platforms/85xx/fix/Makefile b/arch/powerpc/platforms/85xx/fix/Makefile
index a8e8154..0530acd 100644
--- a/arch/powerpc/platforms/85xx/fix/Makefile
+++ b/arch/powerpc/platforms/85xx/fix/Makefile
@@ -1 +1,3 @@
 obj-y += fix.o
+
+obj-y += t104x_diu.o
diff --git a/arch/powerpc/platforms/85xx/fix/fix.c b/arch/powerpc/platforms/85xx/fix/fix.c
index 7b59a52..c278eb1 100644
--- a/arch/powerpc/platforms/85xx/fix/fix.c
+++ b/arch/powerpc/platforms/85xx/fix/fix.c
@@ -21,6 +21,19 @@
 
 static int fix_platform_init(void)
 {
+	u32 svr;
+
+	svr = SVR_SOC_VER(mfspr(SPRN_SVR));
+
+	switch (svr) {
+	case SVR_T1040:
+	case SVR_T1042:
+		fix_t104x_diu_init();
+		break;
+	default:
+		pr_info("Platform is not need to fix anything\n");
+	}
+
 	return 0;
 }
 early_initcall(fix_platform_init);
diff --git a/arch/powerpc/platforms/85xx/fix/fix.h b/arch/powerpc/platforms/85xx/fix/fix.h
index 5a8c80e3..d27635f 100644
--- a/arch/powerpc/platforms/85xx/fix/fix.h
+++ b/arch/powerpc/platforms/85xx/fix/fix.h
@@ -1,4 +1,6 @@
 #ifndef __CORENET_GENERIC_FIX_H__
 #define __CORENET_GENERIC_FIX_H__
 
+extern void fix_t104x_diu_init(void);
+
 #endif
diff --git a/arch/powerpc/platforms/85xx/fix/t104x_diu.c b/arch/powerpc/platforms/85xx/fix/t104x_diu.c
new file mode 100644
index 0000000..39c7242
--- /dev/null
+++ b/arch/powerpc/platforms/85xx/fix/t104x_diu.c
@@ -0,0 +1,155 @@
+/*
+ * T104x RDB Particular Setup
+ * Should apply for RDB platform of T1040 and it's personalities.
+ * viz T1040/T1042
+ *
+ * Copyright 2014 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+
+#include <asm/io.h>
+#include <sysdev/fsl_soc.h>
+
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+/*DIU Pixel ClockCR offset in scfg*/
+#define CCSR_SCFG_PIXCLKCR      0x28
+
+/* DIU Pixel Clock bits of the PIXCLKCR */
+#define PIXCLKCR_PXCKEN		0x80000000
+#define PIXCLKCR_PXCKINV	0x40000000
+#define PIXCLKCR_PXCKDLY	0x0000FF00
+#define PIXCLKCR_PXCLK_MASK	0x00FF0000
+
+/* Some CPLD register definitions */
+#define CPLD_DIUCSR		0x16
+#define CPLD_DIUCSR_DVIEN	0x80
+#define CPLD_DIUCSR_BACKLIGHT	0x0f
+
+/**
+ * t104xrdb_set_monitor_port: switch the output to a different monitor port
+ */
+static void t104xrdb_set_monitor_port(enum fsl_diu_monitor_port port)
+{
+	struct device_node *cpld_node;
+	static void __iomem *cpld_base;
+
+	cpld_node = of_find_compatible_node(NULL, NULL, "fsl,t104xrdb-cpld");
+	if (!cpld_node) {
+		pr_err("T104xRDB: missing CPLD node\n");
+		return;
+	}
+
+	cpld_base = of_iomap(cpld_node, 0);
+	if (!cpld_base) {
+		pr_err("T104xRDB: could not map cpld registers\n");
+		goto exit;
+	}
+
+	switch (port) {
+	case FSL_DIU_PORT_DVI:
+		/* Enable the DVI(HDMI) port, disable the DFP and
+		 * the backlight
+		 */
+		clrbits8(cpld_base + CPLD_DIUCSR, CPLD_DIUCSR_DVIEN);
+		break;
+	case FSL_DIU_PORT_LVDS:
+		/*
+		 * LVDS also needs backlight enabled, otherwise the display
+		 * will be blank.
+		 */
+		/* Enable the DFP port, disable the DVI*/
+		setbits8(cpld_base + CPLD_DIUCSR, 0x01 << 8);
+		setbits8(cpld_base + CPLD_DIUCSR, 0x01 << 4);
+		setbits8(cpld_base + CPLD_DIUCSR, CPLD_DIUCSR_BACKLIGHT);
+		break;
+	default:
+		pr_err("T104xRDB: unsupported monitor port %i\n", port);
+	}
+
+exit:
+	of_node_put(cpld_node);
+}
+
+/**
+ * t104xrdb_set_pixel_clock: program the DIU's clock
+ *
+ * @pixclock: the wavelength, in picoseconds, of the clock
+ */
+static void t104xrdb_set_pixel_clock(unsigned int pixclock)
+{
+	struct device_node *scfg_np = NULL;
+	void __iomem *scfg;
+	unsigned long freq;
+	u64 temp;
+	u32 pxclk;
+
+	/* Map the global utilities registers. */
+	scfg_np = of_find_compatible_node(NULL, NULL, "fsl,t1040-scfg");
+	if (!scfg_np) {
+		freq = temp;
+		pr_err("T104xRDB: missing supplemental configuration unit device node\n");
+		return;
+	}
+
+	scfg = of_iomap(scfg_np, 0);
+	of_node_put(scfg_np);
+	if (!scfg) {
+		pr_err("T104xRDB: could not map device\n");
+		return;
+	}
+
+	/* Convert pixclock from a wavelength to a frequency */
+	temp = 1000000000000ULL;
+	do_div(temp, pixclock);
+	freq = temp;
+
+	/*
+	 * 'pxclk' is the ratio of the platform clock to the pixel clock.
+	 * This number is programmed into the PIXCLKCR register, and the valid
+	 * range of values is 2-255.
+	 */
+	pxclk = DIV_ROUND_CLOSEST(fsl_get_sys_freq(), freq);
+	pxclk = clamp_t(u32, pxclk, 2, 255);
+
+	/* Disable the pixel clock, and set it to non-inverted and no delay */
+	clrbits32(scfg + CCSR_SCFG_PIXCLKCR,
+		  PIXCLKCR_PXCKEN | PIXCLKCR_PXCKDLY | PIXCLKCR_PXCLK_MASK);
+
+	/* Enable the clock and set the pxclk */
+	setbits32(scfg + CCSR_SCFG_PIXCLKCR, PIXCLKCR_PXCKEN | (pxclk << 16));
+
+	iounmap(scfg);
+}
+
+/**
+ * t104xrdb_valid_monitor_port: set the monitor port for sysfs
+ */
+static enum fsl_diu_monitor_port
+t104xrdb_valid_monitor_port(enum fsl_diu_monitor_port port)
+{
+	switch (port) {
+	case FSL_DIU_PORT_DVI:
+	case FSL_DIU_PORT_LVDS:
+		return port;
+	default:
+		return FSL_DIU_PORT_DVI; /* Dual-link LVDS is not supported */
+	}
+}
+#endif
+
+void fix_t104x_diu_init(void)
+{
+#if defined(CONFIG_FB_FSL_DIU) || defined(CONFIG_FB_FSL_DIU_MODULE)
+	diu_ops.set_monitor_port	= t104xrdb_set_monitor_port;
+	diu_ops.set_pixel_clock		= t104xrdb_set_pixel_clock;
+	diu_ops.valid_monitor_port	= t104xrdb_valid_monitor_port;
+#endif
+}
-- 
1.8.5
