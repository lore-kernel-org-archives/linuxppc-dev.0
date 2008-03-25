Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 12136DDFDD
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 05:46:16 +1100 (EST)
Message-ID: <47E94891.6020000@scram.de>
Date: Tue, 25 Mar 2008 19:46:41 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCHv4 2.6.25] i2c: adds support for i2c bus on Freescale
	CPM1/CPM2 controllers
References: <47A1C4E9.4000003@scram.de>	<20080221130520.12b01553@hyperion.delvare>	<47BEAF00.50106@scram.de>
	<20080223134335.0f5c7d79@hyperion.delvare>
In-Reply-To: <20080223134335.0f5c7d79@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	i2c@lm-sensors.org, Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

>> What is the preferred way to do this?
> 
> I still have to think about it. I didn't have much time to work on this
> during the last 2 weeks, hopefully I will fine some time to experiment
> again soon. As I underlined before, my patch set affects no less than 5
> subsystems with different needs and expectations, it's no trivial
> change.

Sorry for the late response, but I was pretty busy the last couple of weeks.

I'm thinking about something like this (based on http://patchwork.ozlabs.org/linuxppc/patch?id=16282 to 16284):

This patch implements various helpers to support OF bindings for
the i2c API.

Signed-off-by: Jochen Friedrich <jochen@scram.de>
---
 drivers/of/Kconfig     |    6 +++
 drivers/of/Makefile    |    1 +
 drivers/of/i2c.c       |  113 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_i2c.h |   24 ++++++++++
 4 files changed, 144 insertions(+), 0 deletions(-)
 create mode 100644 drivers/of/i2c.c
 create mode 100644 include/linux/of_i2c.h

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index c03072b..3cff449 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -1,3 +1,9 @@
 config OF_DEVICE
 	def_bool y
 	depends on OF && (SPARC || PPC_OF)
+
+config OF_I2C
+	def_bool y
+	depends on OF && PPC_OF && I2C
+	help
+	  OpenFirmware I2C accessors
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index ab9be5d..655b982 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -1,2 +1,3 @@
 obj-y = base.o
 obj-$(CONFIG_OF_DEVICE) += device.o platform.o
+obj-$(CONFIG_OF_I2C)	+= i2c.o
diff --git a/drivers/of/i2c.c b/drivers/of/i2c.c
new file mode 100644
index 0000000..d3d1e9e
--- /dev/null
+++ b/drivers/of/i2c.c
@@ -0,0 +1,113 @@
+/*
+ * OF helpers for the I2C API
+ *
+ * Copyright (c) 2008 Jochen Friedrich <jochen@scram.de>
+ *
+ * Based on a previous patch from Jon Smirl <jonsmirl@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <linux/i2c.h>
+#include <asm/prom.h>
+
+struct i2c_driver_device {
+	char    *of_device;
+	char    *i2c_type;
+};
+
+static struct i2c_driver_device i2c_devices[] = {
+	{"dallas,ds1374", "rtc-ds1374",},
+};
+
+static int of_find_i2c_driver(struct device_node *node,
+			      struct i2c_board_info *info)
+{
+	int i, cplen;
+	const char *compatible;
+	const char *p;
+
+	/* 1. search for exception list entry */
+	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
+		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
+			continue;
+		if (strlcpy(info->type, i2c_devices[i].i2c_type,
+			    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
+			return -ENOMEM;
+
+		return 0;
+	}
+
+	compatible = of_get_property(node, "compatible", &cplen);
+	if (!compatible)
+		return -ENODEV;
+
+	/* 2. search for linux,<i2c-type> entry */
+	p = compatible;
+	while (cplen > 0) {
+		if (!strncmp(p, "linux,", 6)) {
+			p += 6;
+			if (strlcpy(info->type, p,
+				    I2C_NAME_SIZE) >= I2C_NAME_SIZE)
+				return -ENOMEM;
+			return 0;
+		}
+
+		i = strlen(p) + 1;
+		p += i;
+		cplen -= i;
+	}
+
+	/* 3. take fist compatible entry and strip manufacturer */
+	p = strchr(compatible, ',');
+	if (!p)
+		return -ENODEV;
+	p++;
+	if (strlcpy(info->type, p, I2C_NAME_SIZE) >= I2C_NAME_SIZE)
+		return -ENOMEM;
+	return 0;
+}
+
+void of_register_i2c_devices(struct i2c_adapter *adap,
+			     struct device_node *adap_node)
+{
+	void *result;
+	struct device_node *node = NULL;
+
+	while ((node = of_get_next_child(adap_node, node))) {
+		struct i2c_board_info info = {};
+		const u32 *addr;
+		int len;
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
+			printk(KERN_ERR
+			       "of-i2c: invalid i2c device entry\n");
+			continue;
+		}
+
+		info.irq = irq_of_parse_and_map(node, 0);
+		if (info.irq == NO_IRQ)
+			info.irq = -1;
+
+		if (of_find_i2c_driver(node, &info) < 0)
+			continue;
+
+		info.addr = *addr;
+
+		request_module(info.type);
+
+		result = i2c_new_device(adap, &info);
+		if (result == NULL) {
+			printk(KERN_ERR
+			       "of-i2c: Failed to load driver for %s\n",
+			       info.type);
+			irq_dispose_mapping(info.irq);
+			continue;
+		}
+	}
+}
+EXPORT_SYMBOL(of_register_i2c_devices);
diff --git a/include/linux/of_i2c.h b/include/linux/of_i2c.h
new file mode 100644
index 0000000..2e5a967
--- /dev/null
+++ b/include/linux/of_i2c.h
@@ -0,0 +1,24 @@
+/*
+ * Generic I2C API implementation for PowerPC.
+ *
+ * Copyright (c) 2008 Jochen Friedrich <jochen@scram.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __LINUX_OF_I2C_H
+#define __LINUX_OF_I2C_H
+
+#include <linux/i2c.h>
+
+#ifdef CONFIG_OF_I2C
+
+void of_register_i2c_devices(struct i2c_adapter *adap,
+			     struct device_node *adap_node);
+
+#endif /* CONFIG_OF_I2C */
+
+#endif /* __LINUX_OF_I2C_H */
-- 
1.5.4.4
