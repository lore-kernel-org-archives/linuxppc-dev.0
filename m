Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id C56F4DDF0E
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 06:26:21 +1000 (EST)
Date: Fri, 20 Jul 2007 22:26:15 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Add of_register_i2c_devices()
In-Reply-To: <719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
Message-ID: <Pine.LNX.4.60.0707202219340.3946@poirot.grange>
References: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
	<00a85f152aa3547f0f0b4acd7954468a@kernel.crashing.org>
	<Pine.LNX.4.60.0707022114020.3339@poirot.grange>
	<2055bb54b9816faaf5b2ceedc9cfa039@kernel.crashing.org>
	<Pine.LNX.4.60.0707032356270.3876@poirot.grange>
	<E0E696F1-2F9E-4D6B-A194-EB42BA826BCD@kernel.crashing.org>
	<Pine.LNX.4.60.0707180010330.3535@poirot.grange>
	<87DC7695-382B-4641-B9D9-75ACB49D41A4@kernel.crashing.org>
	<Pine.LNX.4.60.0707191932300.3365@poirot.grange>
	<719AE7E4-FE6D-4973-8887-F787EC8ABC85@kernel.crashing.org>
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

On Fri, 20 Jul 2007, Segher Boessenkool wrote:

> > +		strncpy(info->driver_name, i2c_devices[i].i2c_driver,
> > KOBJ_NAME_LEN);
> > +		strncpy(info->type, i2c_devices[i].i2c_type, I2C_NAME_SIZE);
> 
> Why not just strcpy(), btw?

Because target strings are finite length, and sources are just pointers to 
some constant strings, which one might make arbitrarily long.

> > +		addr = of_get_property(node, "reg", &len);
> > +		if (!addr || len < sizeof(int) || *addr > 0xffff)
> > +			continue;
> 
> Give a warning when the addr won't fit in 16 bits?

Ok, version 3, hopefully last, below.

Thanks
Guennadi
---
Guennadi Liakhovetski

Scan the device tree for i2c devices, check their "compatible" property
against a hard-coded table, and, if found, register with i2c boardinfo.

Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 3289fab..727453d 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -305,6 +305,64 @@ err:
 
 arch_initcall(gfar_of_init);
 
+#ifdef CONFIG_I2C_BOARDINFO
+#include <linux/i2c.h>
+struct i2c_driver_device {
+	char	*of_device;
+	char	*i2c_driver;
+	char	*i2c_type;
+};
+
+static struct i2c_driver_device i2c_devices[] __initdata = {
+	{"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
+	{"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
+	{"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
+	{"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
+};
+
+static int __init of_find_i2c_driver(struct device_node *node, struct i2c_board_info *info)
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
+static void __init of_register_i2c_devices(struct device_node *adap_node, int bus_num)
+{
+	struct device_node *node = NULL;
+
+	while ((node = of_get_next_child(adap_node, node))) {
+		struct i2c_board_info info;
+		const u32 *addr;
+		int len;
+
+		addr = of_get_property(node, "reg", &len);
+		if (!addr || len < sizeof(int) || *addr > (1 << 10) - 1) {
+			printk(KERN_WARNING "fsl_ioc.c: invalid i2c device entry\n");
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
@@ -349,6 +407,8 @@ static int __init fsl_i2c_of_init(void)
 						    fsl_i2c_platform_data));
 		if (ret)
 			goto unreg;
+
+		of_register_i2c_devices(np, i);
 	}
 
 	return 0;
@@ -360,6 +420,7 @@ err:
 }
 
 arch_initcall(fsl_i2c_of_init);
+#endif
 
 #ifdef CONFIG_PPC_83xx
 static int __init mpc83xx_wdt_init(void)
