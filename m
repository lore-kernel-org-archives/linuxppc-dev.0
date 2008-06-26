Return-Path: <monstr@seznam.cz>
Received: from monstr.eu (238.225.broadband7.iol.cz [88.102.225.238])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 702D0DDF33
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 23:14:59 +1000 (EST)
From: monstr@seznam.cz
To: linux-kernel@vger.kernel.org
Subject: [PATCH 05/60] microblaze_v4: Open firmware files2
Date: Thu, 26 Jun 2008 14:29:34 +0200
Message-Id: <1214483429-32360-6-git-send-email-monstr@seznam.cz>
In-Reply-To: <1214483429-32360-5-git-send-email-monstr@seznam.cz>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<1214483429-32360-2-git-send-email-monstr@seznam.cz>
	<1214483429-32360-3-git-send-email-monstr@seznam.cz>
	<1214483429-32360-4-git-send-email-monstr@seznam.cz>
	<1214483429-32360-5-git-send-email-monstr@seznam.cz>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	arnd@arndb.de, matthew@wil.cx, microblaze-uclinux@itee.uq.edu.au,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, John.Linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Michal Simek <monstr@monstr.eu>


Signed-off-by: Michal Simek <monstr@monstr.eu>
---
 arch/microblaze/kernel/of_device.c  |   42 +++++++++++++++++++++++++++++++++++
 arch/microblaze/platform/platform.c |   31 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 0 deletions(-)
 create mode 100644 arch/microblaze/kernel/of_device.c
 create mode 100644 arch/microblaze/platform/platform.c

diff --git a/arch/microblaze/kernel/of_device.c b/arch/microblaze/kernel/of_device.c
new file mode 100644
index 0000000..984d066
--- /dev/null
+++ b/arch/microblaze/kernel/of_device.c
@@ -0,0 +1,42 @@
+#include <linux/string.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+
+#include <asm/errno.h>
+
+void of_device_make_bus_id(struct of_device *dev)
+{
+	static atomic_t bus_no_reg_magic;
+	struct device_node *node = dev->node;
+	char *name = dev->dev.bus_id;
+	const u32 *reg;
+	u64 addr;
+	int magic;
+
+	/*
+	 * For MMIO, get the physical address
+	 */
+	reg = of_get_property(node, "reg", NULL);
+	if (reg) {
+		addr = of_translate_address(node, reg);
+		if (addr != OF_BAD_ADDR) {
+			snprintf(name, BUS_ID_SIZE,
+				 "%llx.%s", (unsigned long long)addr,
+				 node->name);
+			return;
+		}
+	}
+
+	/*
+	 * No BusID, use the node name and add a globally incremented
+	 * counter (and pray...)
+	 */
+	magic = atomic_add_return(1, &bus_no_reg_magic);
+	snprintf(name, BUS_ID_SIZE, "%s.%d", node->name, magic - 1);
+}
+EXPORT_SYMBOL(of_device_make_bus_id);
diff --git a/arch/microblaze/platform/platform.c b/arch/microblaze/platform/platform.c
new file mode 100644
index 0000000..fa0edaf
--- /dev/null
+++ b/arch/microblaze/platform/platform.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2008 Michal Simek <monstr@monstr.eu>
+ *
+ * based on virtex.c file
+ *
+ * Copyright 2007 Secret Lab Technologies Ltd.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/of_platform.h>
+#include <asm/prom.h>
+
+static struct of_device_id xilinx_of_bus_ids[] __initdata = {
+	{ .compatible = "simple-bus", },
+	{ .compatible = "xlnx,plb-v46-1.00.a", },
+	{ .compatible = "xlnx,opb-v20-1.10.c", },
+	{ .compatible = "xlnx,opb-v20-1.10.b", },
+	{ .compatible = "xlnx,compound", },
+	{}
+};
+
+int __init microblaze_device_probe(void)
+{
+	of_platform_bus_probe(NULL, xilinx_of_bus_ids, NULL);
+	return 0;
+}
+device_initcall(microblaze_device_probe);
-- 
1.5.4.GIT
