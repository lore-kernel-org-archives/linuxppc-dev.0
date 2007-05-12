Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C1958DDEB9
	for <linuxppc-dev@ozlabs.org>; Sun, 13 May 2007 00:48:01 +1000 (EST)
Date: Sat, 12 May 2007 09:50:41 -0500
To: paulus@samba.org
Subject: [PATCH] pasemi: electra IDE/pata_platform glue
Message-ID: <20070512145041.GA13025@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Glue code to hook up the pata_platform on the PA Semi Electra eval board.
CFE sets up device tree entries for the IDE interface, with device type
'ide' and compatible field 'electra-ide'.

We unfortunately need to modify the resources before calling the generic
platform driver, since the device tree only has one register window in
it and the driver expects two. Adding this as an of_platform driver
instead doesn't give us any benefit, it just adds one more layer of
register/probe functions.

Since CONFIG_PATA_PLATFORM depends on CONFIG_EMBEDDED, add that as a
default for PPC_PASEMI.


Signed-off-by: Olof Johansson <olof@lixom.net>


Index: 2.6.21/arch/powerpc/platforms/pasemi/Makefile
===================================================================
--- 2.6.21.orig/arch/powerpc/platforms/pasemi/Makefile
+++ 2.6.21/arch/powerpc/platforms/pasemi/Makefile
@@ -1,3 +1,4 @@
 obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o
 obj-$(CONFIG_PPC_PASEMI_MDIO)	+= gpio_mdio.o
+obj-$(CONFIG_ELECTRA_IDE) += electra_ide.o
 obj-$(CONFIG_PPC_PASEMI_CPUFREQ) += cpufreq.o
Index: 2.6.21/arch/powerpc/platforms/pasemi/electra_ide.c
===================================================================
--- /dev/null
+++ 2.6.21/arch/powerpc/platforms/pasemi/electra_ide.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright (C) 2007 PA Semi, Inc
+ *
+ * Maintained by: Olof Johansson <olof@lixom.net>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ */
+
+#include <linux/platform_device.h>
+
+#include <asm/prom.h>
+#include <asm/system.h>
+
+/* The electra IDE interface is incredibly simple: Just a device on the localbus
+ * with interrupts hooked up to one of the GPIOs. The device tree contains the
+ * address window and interrupt mappings already, and the pata_platform driver handles
+ * the rest. We just need to hook the two up.
+ */
+
+#define MAX_IFS	4	/* really, we have only one */
+
+static struct platform_device *pdevs[MAX_IFS];
+
+static int __devinit electra_ide_init(void)
+{
+	struct device_node *np;
+	struct resource r[3];
+	int ret = 0;
+	int i;
+
+	np = of_find_compatible_node(NULL, "ide", "electra-ide");
+	i = 0;
+
+	while (np && i < MAX_IFS) {
+		memset(r, 0, sizeof(r));
+
+		/* pata_platform wants two address ranges: one for the base registers,
+		 * another for the control (altstatus). It's located at offset 0x3f6 in
+		 * the window, but the device tree only has one large register window
+		 * that covers both ranges. So we need to split it up by hand here:
+		 */
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto out;
+		ret = of_address_to_resource(np, 0, &r[1]);
+		if (ret)
+			goto out;
+
+		r[1].start += 0x3f6;
+		r[0].end = r[1].start-1;
+
+		r[2].start = irq_of_parse_and_map(np, 0);
+		r[2].end = irq_of_parse_and_map(np, 0);
+		r[2].flags = IORESOURCE_IRQ;
+
+		pr_debug("registering platform device at 0x%lx/0x%lx, irq is %ld\n",
+			 r[0].start, r[1].start, r[2].start);
+		pdevs[i] = platform_device_register_simple("pata_platform", i, r, 3);
+		if (IS_ERR(pdevs[i])) {
+			ret = PTR_ERR(pdevs[i]);
+			pdevs[i] = NULL;
+			goto out;
+		}
+		np = of_find_compatible_node(np, "ide", "electra-ide");
+	}
+out:
+	return ret;
+}
+module_init(electra_ide_init);
+
+static void __devexit electra_ide_exit(void)
+{
+	int i;
+
+	for (i = 0; i < MAX_IFS; i++)
+		if (pdevs[i])
+			platform_device_unregister(pdevs[i]);
+}
+module_exit(electra_ide_exit);
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR ("Olof Johansson <olof@lixom.net>");
+MODULE_DESCRIPTION("PA Semi Electra IDE driver");
Index: 2.6.21/arch/powerpc/platforms/pasemi/Kconfig
===================================================================
--- 2.6.21.orig/arch/powerpc/platforms/pasemi/Kconfig
+++ 2.6.21/arch/powerpc/platforms/pasemi/Kconfig
@@ -6,6 +6,7 @@ config PPC_PASEMI
 	select PPC_UDBG_16550
 	select GENERIC_TBSYNC
 	select PPC_NATIVE
+	select EMBEDDED
 	help
 	  This option enables support for PA Semi's PWRficient line
 	  of SoC processors, including PA6T-1682M
@@ -26,4 +27,13 @@ config PPC_PASEMI_MDIO
 	help
 	  Driver for MDIO via GPIO on PWRficient platforms
 
+config ELECTRA_IDE
+      tristate "Electra IDE driver"
+      default y
+      depends on PPC_PASEMI && ATA
+      select PATA_PLATFORM
+      help
+	This includes driver support for the Electra on-board IDE
+	interface.
+
 endmenu
