Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 516D367AA1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 11:54:26 +1100 (EST)
Message-ID: <41F6EA3C.6060303@mvista.com>
Date: Tue, 25 Jan 2005 17:54:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------000704000208060508010308"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] ev64260 update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------000704000208060508010308
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello again, Andrew.

This patch updates the support for the ev64260 eval platform from Marvell.

It:
- uses the platform_notify hook to update platform_data
- fixes a bug where a window to a device is disabled instead of enabled
- does some misc fixups

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------000704000208060508010308
Content-Type: text/plain;
 name="ev64260.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ev64260.patch"

diff -Nru a/arch/ppc/boot/simple/misc-ev64260.S b/arch/ppc/boot/simple/misc-ev64260.S
--- a/arch/ppc/boot/simple/misc-ev64260.S	2005-01-25 17:50:29 -07:00
+++ b/arch/ppc/boot/simple/misc-ev64260.S	2005-01-25 17:50:29 -07:00
@@ -6,12 +6,10 @@
  *
  * Author: Mark Greer <mgreer@mvista.com>
  *
- * Copyright 2001 MontaVista Software Inc.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of the GNU General Public License as published by the
- * Free Software Foundation; either version 2 of the License, or (at your
- * option) any later version.
+ * 2001 (c) MontaVista Software, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
  */
 
 #include <asm/ppc_asm.h>
diff -Nru a/arch/ppc/platforms/ev64260.c b/arch/ppc/platforms/ev64260.c
--- a/arch/ppc/platforms/ev64260.c	2005-01-25 17:50:29 -07:00
+++ b/arch/ppc/platforms/ev64260.c	2005-01-25 17:50:29 -07:00
@@ -294,7 +294,7 @@
 
         /* Lookup PCI host bridges */
         if (mv64x60_init(&bh, &si))
-                printk("Bridge initialization failed.\n");
+                printk(KERN_ERR "Bridge initialization failed.\n");
 
 	pci_dram_offset = 0; /* System mem at same addr on PCI & cpu bus */
 	ppc_md.pci_swizzle = common_swizzle;
@@ -337,7 +337,8 @@
 #endif
 
 		if (early_serial_setup(&port) != 0)
-			printk("Early serial init of port 0 failed\n");
+			printk(KERN_WARNING "Early serial init of port 0"
+				"failed\n");
 
 		first_time = 0;
 	}
@@ -351,35 +352,6 @@
 }
 #endif
 
-static int __init
-ev64260_fixup_pd(void)
-{
-#if defined(CONFIG_SERIAL_MPSC)
-	struct list_head	*entry;
-	struct platform_device	*pd;
-	struct device		*dev;
-	struct mpsc_pd_dd	*dd;
-
-	list_for_each(entry, &platform_bus_type.devices.list) {
-		dev = container_of(entry, struct device, bus_list);
-		pd = container_of(dev, struct platform_device, dev);
-
-		if (!strncmp(pd->name, MPSC_CTLR_NAME, BUS_ID_SIZE)) {
-			dd = (struct mpsc_pd_dd *) dev_get_drvdata(&pd->dev);
-
-			dd->max_idle = 40;
-			dd->default_baud = EV64260_DEFAULT_BAUD;
-			dd->brg_clk_src = EV64260_MPSC_CLK_SRC;
-			dd->brg_clk_freq = EV64260_MPSC_CLK_FREQ;
-		}
-	}
-#endif
-
-	return 0;
-}
-
-subsys_initcall(ev64260_fixup_pd);
-
 static void __init
 ev64260_setup_arch(void)
 {
@@ -417,8 +389,8 @@
 	ev64260_early_serial_map();
 #endif
 
-	printk(BOARD_VENDOR " " BOARD_MACHINE "\n");
-	printk("EV-64260-BP port (C) 2001 MontaVista Software, Inc. (source@mvista.com)\n");
+	printk(KERN_INFO "%s %s port (C) 2001 MontaVista Software, Inc."
+		"(source@mvista.com)\n", BOARD_VENDOR, BOARD_MACHINE);
 
 	if (ppc_md.progress)
 		ppc_md.progress("ev64260_setup_arch: exit", 0);
@@ -426,6 +398,50 @@
 	return;
 }
 
+/* Platform device data fixup routines. */
+#if defined(CONFIG_SERIAL_MPSC)
+static void __init
+ev64260_fixup_mpsc_pdata(struct platform_device *pdev)
+{
+	struct mpsc_pdata *pdata;
+
+	pdata = (struct mpsc_pdata *)pdev->dev.platform_data;
+
+	pdata->max_idle = 40;
+	pdata->default_baud = EV64260_DEFAULT_BAUD;
+	pdata->brg_clk_src = EV64260_MPSC_CLK_SRC;
+	pdata->brg_clk_freq = EV64260_MPSC_CLK_FREQ;
+
+	return;
+}
+
+static int __init
+ev64260_platform_notify(struct device *dev)
+{
+	static struct {
+		char	*bus_id;
+		void	((*rtn)(struct platform_device *pdev));
+	} dev_map[] = {
+		{ MPSC_CTLR_NAME "0", ev64260_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME "1", ev64260_fixup_mpsc_pdata },
+	};
+	struct platform_device	*pdev;
+	int	i;
+
+	if (dev && dev->bus_id)
+		for (i=0; i<ARRAY_SIZE(dev_map); i++)
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id,
+				BUS_ID_SIZE)) {
+
+				pdev = container_of(dev,
+					struct platform_device, dev);
+				dev_map[i].rtn(pdev);
+			}
+
+	return 0;
+}
+#endif
+
 static void
 ev64260_reset_board(void *addr)
 {
@@ -462,7 +478,7 @@
 	/* map bootrom back in to gt @ reset defaults */
 	mv64x60_set_32bit_window(&bh, MV64x60_CPU2BOOT_WIN,
 						0xff800000, 8*1024*1024, 0);
-	bh.ci->disable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);
+	bh.ci->enable_window_32bit(&bh, MV64x60_CPU2BOOT_WIN);
 
 	/* move reg base back to default, setup default pci0 */
 	mv64x60_write(&bh, MV64x60_INTERNAL_SPACE_DECODE,
@@ -531,7 +547,7 @@
 
 	freq = ev64260_get_bus_speed()/4;
 
-	printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
 	       freq/1000000, freq%1000000);
 
 	tb_ticks_per_jiffy = freq / HZ;
@@ -625,6 +641,10 @@
 	ppc_md.early_serial_map = ev64260_early_serial_map;
 #endif	/* CONFIG_KGDB */
 
+#endif
+
+#if defined(CONFIG_SERIAL_MPSC)
+	platform_notify = ev64260_platform_notify;
 #endif
 
 	return;

--------------000704000208060508010308--
