Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D7E97DDEDA
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 08:17:57 +1000 (EST)
Date: Wed, 18 Jul 2007 00:17:54 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
In-Reply-To: <E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0707180010330.3535@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 4 Jul 2007, Segher Boessenkool wrote:

> Your device is an rs5c372b.  So, that's what you put in
> your device tree.  Simple so far, right?
> 
> Now some OF I2C code goes looking for IIC devices in the
> device tree.  It finds this thing, and from a table or
> something it derives that it has to tell the kernel I2C
> layer this is an "rtc-rs5c372".  [It would be nicer if it
> could just instantiate the correct driver directly, but
> if that's how the Linux I2C layer works, so be it].
> 
> No change in the I2C "core" needed, just an OF "compatible"
> matching thing like is needed *everywhere else* too.

How about the patch below?

Thanks
Guennadi
---
Guennadi Liakhovetski

Scan the device tree for i2c devices, check their "compatible" property 
against a hard-coded table, and, if found, register with i2c boardinfo.

Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 9588b60..c3c7eba 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -296,6 +296,62 @@ err:
 
 arch_initcall(gfar_of_init);
 
+#ifdef CONFIG_I2C_BOARDINFO
+#include <linux/i2c.h>
+struct i2c_driver_device {
+	char	*of_device;
+	char	*i2c_driver;
+	char	*i2c_type;
+};
+
+static struct i2c_driver_device i2c_devices[] = {
+	{"rs5c372a", "rtc-rs5c372", "rs5c372a",},
+	{"rs5c372b", "rtc-rs5c372", "rs5c372b",},
+	{"rv5c386",  "rtc-rs5c372", "rv5c386",},
+	{"rv5c387a", "rtc-rs5c372", "rv5c387a",},
+};
+
+static int of_find_i2c_driver(struct device_node *node, struct i2c_board_info *info)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(i2c_devices); i++) {
+		if (!of_device_is_compatible(node, i2c_devices[i].of_device))
+			continue;
+		strncpy(info->driver_name, i2c_devices[i].i2c_driver, KOBJ_NAME_LEN);
+		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static void of_register_i2c_devices(struct device_node *adap_node, int bus_num)
+{
+	struct device_node *node = NULL;
+
+	while ((node = of_get_next_child(adap_node, node))) {
+		struct i2c_board_info info;
+		const u32 *addr;
+		int len;
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || len < sizeof(int) || *addr > 0xffff)
+			continue;
+
+		info.irq = irq_of_parse_and_map(node, 0);
+		if (info.irq == NO_IRQ)
+			info.irq = -1;
+
+		if (of_find_i2c_driver(node, &info) < 0)
+			continue;
+
+		info.platform_data = NULL;
+		info.addr = *addr;
+
+		i2c_register_board_info(bus_num, &info, 1);
+	}
+}
+
 static int __init fsl_i2c_of_init(void)
 {
 	struct device_node *np;
@@ -340,6 +396,8 @@ static int __init fsl_i2c_of_init(void)
 						    fsl_i2c_platform_data));
 		if (ret)
 			goto unreg;
+
+		of_register_i2c_devices(np, i);
 	}
 
 	return 0;
@@ -351,6 +409,7 @@ err:
 }
 
 arch_initcall(fsl_i2c_of_init);
+#endif
 
 #ifdef CONFIG_PPC_83xx
 static int __init mpc83xx_wdt_init(void)
