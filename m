Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 06DABDDE3A
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 03:30:14 +1100 (EST)
Date: Tue, 15 Jan 2008 10:40:33 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: [PATCH] [POWERPC] pasemi: Move electra-ide to pata_of_platform
Message-ID: <20080115164033.GA25328@lixom.net>
References: <20080109190852.GA18827@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080109190852.GA18827@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mundt <lethal@linux-sh.org>,
	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Move electra-ide glue over to the new pata_of_platform framework, and
add the quirks needed to that driver.
    
---

Applied with the rest of the patches to pasemi.git for-2.6.25

 arch/powerpc/platforms/pasemi/electra_ide.c |   96 ----------------------------
 b/arch/powerpc/configs/pasemi_defconfig     |    4 -
 b/arch/powerpc/platforms/pasemi/Kconfig     |    9 --
 b/arch/powerpc/platforms/pasemi/Makefile    |    1 
 b/drivers/ata/pata_of_platform.c            |   20 ++++-
5 files changed, 17 insertions(+), 113 deletions(-)


diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 9d21b08..797f0df 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.24-rc6
-# Fri Dec 28 11:01:53 2007
+# Tue Jan 15 10:26:10 2008
 #
 CONFIG_PPC64=y
 
@@ -152,7 +152,6 @@ CONFIG_PPC_PASEMI=y
 CONFIG_PPC_PASEMI_IOMMU=y
 # CONFIG_PPC_PASEMI_IOMMU_DMA_FORCE is not set
 CONFIG_PPC_PASEMI_MDIO=y
-CONFIG_ELECTRA_IDE=y
 # CONFIG_PPC_CELLEB is not set
 # CONFIG_PPC_PS3 is not set
 # CONFIG_PPC_CELL is not set
@@ -663,6 +662,7 @@ CONFIG_PATA_PCMCIA=y
 # CONFIG_PATA_VIA is not set
 # CONFIG_PATA_WINBOND is not set
 CONFIG_PATA_PLATFORM=y
+CONFIG_PATA_OF_PLATFORM=y
 CONFIG_MD=y
 CONFIG_BLK_DEV_MD=y
 CONFIG_MD_LINEAR=y
diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index b3458a1..348e061 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -37,13 +37,4 @@ config PPC_PASEMI_MDIO
 	help
 	  Driver for MDIO via GPIO on PWRficient platforms
 
-config ELECTRA_IDE
-      tristate "Electra IDE driver"
-      default y
-      depends on PPC_PASEMI && ATA
-      select PATA_PLATFORM
-      help
-	This includes driver support for the Electra on-board IDE
-	interface.
-
 endmenu
diff --git a/arch/powerpc/platforms/pasemi/Makefile b/arch/powerpc/platforms/pasemi/Makefile
index f47fcac..2cd2a4f 100644
--- a/arch/powerpc/platforms/pasemi/Makefile
+++ b/arch/powerpc/platforms/pasemi/Makefile
@@ -1,4 +1,3 @@
 obj-y	+= setup.o pci.o time.o idle.o powersave.o iommu.o
 obj-$(CONFIG_PPC_PASEMI_MDIO)	+= gpio_mdio.o
-obj-$(CONFIG_ELECTRA_IDE) += electra_ide.o
 obj-$(CONFIG_PPC_PASEMI_CPUFREQ) += cpufreq.o
diff --git a/arch/powerpc/platforms/pasemi/electra_ide.c b/arch/powerpc/platforms/pasemi/electra_ide.c
deleted file mode 100644
index 12fb0c9..0000000
--- a/arch/powerpc/platforms/pasemi/electra_ide.c
+++ /dev/null
@@ -1,96 +0,0 @@
-/*
- * Copyright (C) 2007 PA Semi, Inc
- *
- * Maintained by: Olof Johansson <olof@lixom.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- */
-
-#include <linux/platform_device.h>
-
-#include <asm/prom.h>
-#include <asm/system.h>
-
-/* The electra IDE interface is incredibly simple: Just a device on the localbus
- * with interrupts hooked up to one of the GPIOs. The device tree contains the
- * address window and interrupt mappings already, and the pata_platform driver handles
- * the rest. We just need to hook the two up.
- */
-
-#define MAX_IFS	4	/* really, we have only one */
-
-static struct platform_device *pdevs[MAX_IFS];
-
-static int __devinit electra_ide_init(void)
-{
-	struct device_node *np;
-	struct resource r[3];
-	int ret = 0;
-	int i;
-
-	np = of_find_compatible_node(NULL, "ide", "electra-ide");
-	i = 0;
-
-	while (np && i < MAX_IFS) {
-		memset(r, 0, sizeof(r));
-
-		/* pata_platform wants two address ranges: one for the base registers,
-		 * another for the control (altstatus). It's located at offset 0x3f6 in
-		 * the window, but the device tree only has one large register window
-		 * that covers both ranges. So we need to split it up by hand here:
-		 */
-
-		ret = of_address_to_resource(np, 0, &r[0]);
-		if (ret)
-			goto out;
-		ret = of_address_to_resource(np, 0, &r[1]);
-		if (ret)
-			goto out;
-
-		r[1].start += 0x3f6;
-		r[0].end = r[1].start-1;
-
-		r[2].start = irq_of_parse_and_map(np, 0);
-		r[2].end = irq_of_parse_and_map(np, 0);
-		r[2].flags = IORESOURCE_IRQ;
-
-		pr_debug("registering platform device at 0x%lx/0x%lx, irq is %ld\n",
-			 r[0].start, r[1].start, r[2].start);
-		pdevs[i] = platform_device_register_simple("pata_platform", i, r, 3);
-		if (IS_ERR(pdevs[i])) {
-			ret = PTR_ERR(pdevs[i]);
-			pdevs[i] = NULL;
-			goto out;
-		}
-		np = of_find_compatible_node(np, "ide", "electra-ide");
-	}
-out:
-	return ret;
-}
-module_init(electra_ide_init);
-
-static void __devexit electra_ide_exit(void)
-{
-	int i;
-
-	for (i = 0; i < MAX_IFS; i++)
-		if (pdevs[i])
-			platform_device_unregister(pdevs[i]);
-}
-module_exit(electra_ide_exit);
-
-
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR ("Olof Johansson <olof@lixom.net>");
-MODULE_DESCRIPTION("PA Semi Electra IDE driver");
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index b7bc4e4..938f48a 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -34,11 +34,20 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
 		return -EINVAL;
 	}
 
-	ret = of_address_to_resource(dn, 1, &ctl_res);
-	if (ret) {
-		dev_err(&ofdev->dev, "can't get CTL address from "
-			"device tree\n");
-		return -EINVAL;
+	if (of_device_is_compatible(dn, "electra-ide")) {
+		/* Altstatus is really at offset 0x3f6 from the primary window
+		 * on electra-ide. Adjust ctl_res and io_res accordingly.
+		 */
+		ctl_res = io_res;
+		ctl_res.start = ctl_res.start+0x3f6;
+		io_res.end = ctl_res.start-1;
+	} else {
+		ret = of_address_to_resource(dn, 1, &ctl_res);
+		if (ret) {
+			dev_err(&ofdev->dev, "can't get CTL address from "
+				"device tree\n");
+			return -EINVAL;
+		}
 	}
 
 	ret = of_irq_to_resource(dn, 0, &irq_res);
@@ -76,6 +85,7 @@ static int __devexit pata_of_platform_remove(struct of_device *ofdev)
 
 static struct of_device_id pata_of_platform_match[] = {
 	{ .compatible = "ata-generic", },
+	{ .compatible = "electra-ide", },
 	{},
 };
 MODULE_DEVICE_TABLE(of, pata_of_platform_match);
