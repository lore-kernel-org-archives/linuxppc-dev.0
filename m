Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 4FF16DDFB1
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 05:20:42 +1000 (EST)
Date: Fri, 29 Jun 2007 21:20:40 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add of_register_i2c_devices()
Message-ID: <Pine.LNX.4.60.0706292113240.4227@poirot.grange>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add of_register_i2c_devices(), which scans the children of the specified
I2C adapter node, and registers them with the I2C code.

Signed-off-by: Scott Wood <scottwood@freescale.com>
Signed-off-by: G. Liakhovetski <g.liakhovetski@gmx.de>

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 3786dcc..9caf96d 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -1067,3 +1067,49 @@ void __iomem *of_iomap(struct device_node *np, int index)
 	return ioremap(res.start, 1 + res.end - res.start);
 }
 EXPORT_SYMBOL(of_iomap);
+
+#ifdef CONFIG_I2C
+#include <linux/i2c.h>
+
+void of_register_i2c_devices(struct device_node *adap_node, int bus_num)
+{
+	struct device_node *node = NULL;
+
+	while ((node = of_get_next_child(adap_node, node))) {
+		struct i2c_board_info info;
+		const u32 *addr;
+		const char *name, *model;
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
+		name = of_get_property(node, "compatible", NULL);
+		if (!name)
+			name = node->name;
+		if (!name)
+			continue;
+
+		model = of_get_property(node, "model", NULL);
+		if (!model)
+			model = name;
+
+		/* FIXME: the i2c code should allow drivers to specify
+		 * multiple match names; board code shouldn't need to
+		 * know what driver will handle a given type.
+		 */
+
+		snprintf(info.driver_name, KOBJ_NAME_LEN, name);
+		snprintf(info.type, KOBJ_NAME_LEN, model);
+		info.platform_data = NULL;
+		info.addr = *addr;
+
+		i2c_register_board_info(bus_num, &info, 1);
+	}
+}
+#endif /* CONFIG_I2C */
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 6845af9..ed085e1 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -305,6 +305,7 @@ extern int of_irq_map_raw(struct device_node *parent, const u32 *intspec,
 			  u32 ointsize, const u32 *addr,
 			  struct of_irq *out_irq);
 
+void of_register_i2c_devices(struct device_node *adap_node, int bus_num);
 
 /**
  * of_irq_map_one - Resolve an interrupt for a device
