Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id CAE00DDEFF
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Apr 2007 17:28:09 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org, Andrei Konovalov <akonovalov@ru.mvista.com>,
	Peter Korsgaard <jacmet@sunsite.dk>,
	Rick Moleres <Rick.Moleres@xilinx.com>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/5] [PPC] New registration for common Xilinx Virtex ppc405
	platform devices
Date: Sun, 15 Apr 2007 01:27:40 -0600
Message-Id: <1176622070387-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <11766220693636-git-send-email-grant.likely@secretlab.ca>
References: <1176622062492-git-send-email-grant.likely@secretlab.ca>
	<11766220692537-git-send-email-grant.likely@secretlab.ca>
	<11766220693636-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Currently virtex support in mainline make use of the infrastructure in
arch/ppc/syslib/ppc_sys.c for registering common devices on virtex ppc405
platforms.  The ppc_sys.c code is not well suited to the dynamic nature of
FPGA designs and makes adding new board ports more complex.  This patch
adds a new listing of common devices which does not depend on the ppc_sys.c
infrastructure.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/ppc/syslib/virtex_devices.c |  209 ++++++++++++++++++++++++++++++++++++++
 arch/ppc/syslib/virtex_devices.h |   27 +++++
 2 files changed, 236 insertions(+), 0 deletions(-)
 create mode 100644 arch/ppc/syslib/virtex_devices.c
 create mode 100644 arch/ppc/syslib/virtex_devices.h

diff --git a/arch/ppc/syslib/virtex_devices.c b/arch/ppc/syslib/virtex_devices.c
new file mode 100644
index 0000000..096fb2a
--- /dev/null
+++ b/arch/ppc/syslib/virtex_devices.c
@@ -0,0 +1,209 @@
+/*
+ * Virtex hard ppc405 core common device listing
+ *
+ * Copyright 2005-2007 Secret Lab Technologies Ltd.
+ * Copyright 2005 Freescale Semiconductor Inc.
+ * Copyright 2002-2004 MontaVista Software, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/serial_8250.h>
+#include <syslib/virtex_devices.h>
+#include <platforms/4xx/xparameters/xparameters.h>
+#include <asm/io.h>
+
+/*
+ * UARTLITE: shortcut macro for single instance
+ */
+#define XPAR_UARTLITE(num) { \
+	.name = "uartlite", \
+	.id = num, \
+	.num_resources = 2, \
+	.resource = (struct resource[]) { \
+		{ \
+			.start = XPAR_UARTLITE_##num##_BASEADDR + 3, \
+			.end = XPAR_UARTLITE_##num##_HIGHADDR, \
+			.flags = IORESOURCE_MEM, \
+		}, \
+		{ \
+			.start = XPAR_INTC_0_UARTLITE_##num##_VEC_ID, \
+			.flags = IORESOURCE_IRQ, \
+		}, \
+	}, \
+}
+
+/*
+ * Full UART: shortcut macro for single instance + platform data structure
+ */
+#define XPAR_UART(num) { \
+	.mapbase = XPAR_UARTNS550_##num##_BASEADDR + 3, \
+	.irq = XPAR_INTC_0_UARTNS550_##num##_VEC_ID, \
+	.iotype = UPIO_MEM, \
+	.uartclk = XPAR_UARTNS550_##num##_CLOCK_FREQ_HZ, \
+	.flags = UPF_BOOT_AUTOCONF, \
+	.regshift = 2, \
+}
+
+/*
+ * SystemACE: shortcut macro for single instance
+ */
+#define XPAR_SYSACE(num) { \
+	.name		= "xsysace", \
+	.id		= XPAR_SYSACE_##num##_DEVICE_ID, \
+	.num_resources	= 2, \
+	.resource = (struct resource[]) { \
+		{ \
+			.start	= XPAR_SYSACE_##num##_BASEADDR, \
+			.end	= XPAR_SYSACE_##num##_HIGHADDR, \
+			.flags	= IORESOURCE_MEM, \
+		}, \
+		{ \
+			.start	= XPAR_INTC_0_SYSACE_##num##_VEC_ID, \
+			.flags	= IORESOURCE_IRQ, \
+		}, \
+	}, \
+}
+
+
+/* UART 8250 driver platform data table */
+struct plat_serial8250_port virtex_serial_platform_data[] = {
+#if defined(XPAR_UARTNS550_0_BASEADDR)
+	XPAR_UART(0),
+#endif
+#if defined(XPAR_UARTNS550_1_BASEADDR)
+	XPAR_UART(1),
+#endif
+#if defined(XPAR_UARTNS550_2_BASEADDR)
+	XPAR_UART(2),
+#endif
+#if defined(XPAR_UARTNS550_3_BASEADDR)
+	XPAR_UART(3),
+#endif
+	{ }, /* terminated by empty record */
+};
+
+
+struct platform_device virtex_platform_devices[] = {
+	/* UARTLITE instances */
+#if defined(XPAR_UARTLITE_0_BASEADDR)
+	XPAR_UARTLITE(0),
+#endif
+#if defined(XPAR_UARTLITE_1_BASEADDR)
+	XPAR_UARTLITE(1),
+#endif
+#if defined(XPAR_UARTLITE_2_BASEADDR)
+	XPAR_UARTLITE(2),
+#endif
+#if defined(XPAR_UARTLITE_3_BASEADDR)
+	XPAR_UARTLITE(3),
+#endif
+
+	/* Full UART instances */
+#if defined(XPAR_UARTNS550_0_BASEADDR)
+	{
+		.name		= "serial8250",
+		.id		= 0,
+		.dev.platform_data = virtex_serial_platform_data,
+	},
+#endif
+
+	/* SystemACE instances */
+#if defined(XPAR_SYSACE_0_BASEADDR)
+	XPAR_SYSACE(0),
+#endif
+#if defined(XPAR_SYSACE_1_BASEADDR)
+	XPAR_SYSACE(1),
+#endif
+
+	/* ML300/403 reference design framebuffer */
+#if defined(XPAR_TFT_0_BASEADDR)
+	{
+		.name		= "xilinxfb",
+		.id		= 0,
+		.num_resources	= 1,
+		.resource = (struct resource[]) {
+			{
+				.start	= XPAR_TFT_0_BASEADDR,
+				.end	= XPAR_TFT_0_BASEADDR+7,
+				.flags	= IORESOURCE_IO,
+			},
+		},
+	},
+#endif
+};
+
+/* Early serial support functions */
+static void __init
+virtex_early_serial_init(int num, struct plat_serial8250_port *pdata)
+{
+#if defined(CONFIG_SERIAL_TEXT_DEBUG) || defined(CONFIG_KGDB)
+	struct uart_port serial_req;
+
+	memset(&serial_req, 0, sizeof(serial_req));
+	serial_req.mapbase	= pdata->mapbase;
+	serial_req.membase	= pdata->membase;
+	serial_req.irq		= pdata->irq;
+	serial_req.uartclk	= pdata->uartclk;
+	serial_req.regshift	= pdata->regshift;
+	serial_req.iotype	= pdata->iotype;
+	serial_req.flags	= pdata->flags;
+	gen550_init(num, &serial_req);
+#endif
+}
+
+void __init
+virtex_early_serial_map(void)
+{
+#ifdef CONFIG_SERIAL_8250
+	struct plat_serial8250_port *pdata;
+	int i = 0;
+
+	pdata = virtex_serial_platform_data;
+	while(pdata && pdata->flags) {
+		pdata->membase = ioremap(pdata->mapbase, 0x100);
+		virtex_early_serial_init(i, pdata);
+		pdata++;
+		i++;
+	}
+#endif /* CONFIG_SERIAL_8250 */
+}
+
+/*
+ * default fixup routine; do nothing and return success.
+ *
+ * Reimplement this routine in your custom board support file to
+ * override the default behaviour
+ */
+int __attribute__ ((weak))
+virtex_device_fixup(struct platform_device *dev)
+{
+	return 0;
+}
+
+static int __init virtex_init(void)
+{
+	struct platform_device *index = virtex_platform_devices;
+	unsigned int ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(virtex_platform_devices); i++, index++) {
+		if (virtex_device_fixup(index) != 0)
+			continue;
+
+		if (platform_device_register(index)) {
+			ret = 1;
+			printk(KERN_ERR "cannot register dev %s:%d\n",
+			       index->name, index->id);
+		}
+	}
+	return ret;
+}
+
+subsys_initcall(virtex_init);
diff --git a/arch/ppc/syslib/virtex_devices.h b/arch/ppc/syslib/virtex_devices.h
new file mode 100644
index 0000000..4a17dd3
--- /dev/null
+++ b/arch/ppc/syslib/virtex_devices.h
@@ -0,0 +1,27 @@
+/*
+ * Common support header for virtex ppc405 platforms
+ *
+ * Copyright 2007 Secret Lab Technologies Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#ifndef __ASM_VIRTEX_DEVICES_H__
+#define __ASM_VIRTEX_DEVICES_H__
+
+#include <linux/platform_device.h>
+
+void __init virtex_early_serial_map(void);
+
+/* Prototype for device fixup routine.  Implement this routine in the
+ * board specific fixup code and the generic setup code will call it for
+ * each device is the platform device list.
+ *
+ * If the hook returns a non-zero value, then the device will not get
+ * registered with the platform bus
+ */
+int virtex_device_fixup(struct platform_device *dev);
+
+#endif  /* __ASM_VIRTEX_DEVICES_H__ */
-- 
1.5.1
