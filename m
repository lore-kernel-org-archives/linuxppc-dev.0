Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 262D5DDE1D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 01:07:06 +1000 (EST)
Date: Thu, 17 May 2007 09:59:12 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc: Add of_register_i2c_devices().
Message-ID: <20070517145912.GA30423@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: i2c@lm-sensors.org
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
---
Now without the i2c-mpc bit.  Sorry about that.

 arch/powerpc/kernel/prom_parse.c |   42 ++++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/prom.h       |    1 +
 2 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 3786dcc..5e80062 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -1067,3 +1067,45 @@ void __iomem *of_iomap(struct device_node *np, int index)
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
+		const char *name;
+		int len;
+
+		addr = get_property(node, "reg", &len);
+		if (!addr || len < sizeof(int) || *addr > 0xffff)
+			continue;
+
+		info.irq = irq_of_parse_and_map(node, 0);
+		if (info.irq == NO_IRQ)
+			info.irq = -1;
+
+		name = get_property(node, "compatible", NULL);
+		if (!name)
+			name = node->name;
+		if (!name)
+			continue;
+
+		/* FIXME: the i2c code should allow drivers to specify
+		 * multiple match names; board code shouldn't need to
+		 * know what driver will handle a given type.
+		 */
+
+		snprintf(info.driver_name, KOBJ_NAME_LEN, name);
+		snprintf(info.type, KOBJ_NAME_LEN, name);
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
-- 
1.5.0.3
