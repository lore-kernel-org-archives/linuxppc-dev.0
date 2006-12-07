Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id F1E2967D83
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 04:39:59 +1100 (EST)
Date: Thu, 7 Dec 2006 11:35:24 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/4] powerpc: Add of_register_i2c_devices().
Message-ID: <20061207173524.GF22989@ld0162-tx32.am.freescale.net>
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
This patch depends on David Brownell's patchset at
http://lists.lm-sensors.org/pipermail/i2c/2006-November/000516.html

 arch/powerpc/kernel/prom_parse.c |   37 +++++++++++++++++++++++++++++++++++++
 include/asm-powerpc/prom.h       |    1 +
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/kernel/prom_parse.c b/arch/powerpc/kernel/prom_parse.c
index 346fb7b..0566d32 100644
--- a/arch/powerpc/kernel/prom_parse.c
+++ b/arch/powerpc/kernel/prom_parse.c
@@ -990,3 +990,40 @@ int of_irq_map_one(struct device_node *d
 	return res;
 }
 EXPORT_SYMBOL_GPL(of_irq_map_one);
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
+		snprintf(info.driver, KOBJ_NAME_LEN, name);
+		info.bus_num = bus_num;
+		info.platform_data = NULL;
+		info.dev_addr = *addr;
+
+		i2c_register_board_info(&info, 1);
+	}
+}
+#endif /* CONFIG_I2C */
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 0afee17..78c6829 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -348,6 +348,7 @@ static inline int of_irq_to_resource(str
 	return irq;
 }
 
+void of_register_i2c_devices(struct device_node *adap_node, int bus_num);
 
 #endif /* __KERNEL__ */
 #endif /* _POWERPC_PROM_H */
-- 
1.4.2.3
