Return-Path: <fkan@amcc.com>
Received: from sdcmail01.amcc.com (sdcmail01.amcc.com [198.137.200.72])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7FB4ADDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 07:43:17 +1000 (EST)
From: Feng Kan <fkan@amcc.com>
To: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] Added AMCC 460EX Canyonlands SATA support.
Date: Wed, 29 Apr 2009 14:42:42 -0700
Message-Id: <1241041362-19504-1-git-send-email-fkan@amcc.com>
Cc: Feng Kan <fkan@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Feng Kan <fkan@amcc.com>
---
 arch/powerpc/boot/dts/canyonlands.dts  |    8 ++
 arch/powerpc/platforms/44x/Makefile    |    4 +
 arch/powerpc/platforms/44x/amcc-sata.c |  125 ++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/platforms/44x/amcc-sata.c

diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
index 5fd1ad0..b536223 100644
--- a/arch/powerpc/boot/dts/canyonlands.dts
+++ b/arch/powerpc/boot/dts/canyonlands.dts
@@ -163,6 +163,14 @@
                         interrupts = <0x1e 4>;
                 };
 
+                SATA0: sata@bffd1000 {
+                        compatible = "amcc,sata-460ex";
+			reg = <4 0xbffd1000 0x800 4 0xbffd0800 0x400>;
+                        interrupt-parent = <&UIC3>;
+                        interrupts = <0 4       /* SATA */
+                                      5 4>;     /* AHBDMA */
+                };
+
 		POB0: opb {
 			compatible = "ibm,opb-460ex", "ibm,opb";
 			#address-cells = <1>;
diff --git a/arch/powerpc/platforms/44x/Makefile b/arch/powerpc/platforms/44x/Makefile
index 01f51da..fa0a999 100644
--- a/arch/powerpc/platforms/44x/Makefile
+++ b/arch/powerpc/platforms/44x/Makefile
@@ -4,3 +4,7 @@ obj-$(CONFIG_EBONY)	+= ebony.o
 obj-$(CONFIG_SAM440EP) 	+= sam440ep.o
 obj-$(CONFIG_WARP)	+= warp.o
 obj-$(CONFIG_XILINX_VIRTEX_5_FXT) += virtex.o
+ifeq ($(CONFIG_SATA_DWC),y)
+obj-$(CONFIG_CANYONLANDS) += amcc-sata.o
+endif
+
diff --git a/arch/powerpc/platforms/44x/amcc-sata.c b/arch/powerpc/platforms/44x/amcc-sata.c
new file mode 100644
index 0000000..fdda917
--- /dev/null
+++ b/arch/powerpc/platforms/44x/amcc-sata.c
@@ -0,0 +1,125 @@
+/*
+ * AMCC Canyonlands SATA wrapper
+ *
+ * Copyright 2008 DENX Software Engineering, Stefan Roese <sr@denx.de>
+ *
+ * Extract the resources (MEM & IRQ) from the dts file and put them
+ * into the platform-device struct for usage in the platform-device
+ * SATA driver.
+ *
+ */
+
+#include <linux/platform_device.h>
+#include <linux/of_platform.h>
+
+/*
+ * Resource template will be filled dynamically with the values
+ * extracted from the dts file
+ */
+static struct resource sata_resources[] = {
+	[0] = {
+		/* 460EX SATA registers */
+		.flags  = IORESOURCE_MEM,
+	},
+	[1] = {
+		/* 460EX AHBDMA registers */
+		.flags  = IORESOURCE_MEM,
+	},
+	[2] = {
+		/* 460EX SATA IRQ */
+		.flags  = IORESOURCE_IRQ,
+	},
+	[3] = {
+		/* 460EX AHBDMA IRQ */
+		.flags  = IORESOURCE_IRQ,
+	},
+};
+
+static u64 dma_mask = 0xffffffffULL;
+
+static struct platform_device sata_device = {
+	.name = "sata-dwc",
+	.id = 0,
+	.num_resources = ARRAY_SIZE(sata_resources),
+	.resource = sata_resources,
+	.dev = {
+		.dma_mask = &dma_mask,
+		.coherent_dma_mask = 0xffffffffULL,
+	}
+};
+
+static struct platform_device *ppc460ex_devs[] __initdata = {
+	&sata_device,
+};
+
+static int __devinit ppc460ex_sata_probe(struct of_device *ofdev,
+					 const struct of_device_id *match)
+{
+	struct device_node *np = ofdev->node;
+	struct resource res;
+	const char *val;
+
+	/*
+	 * Check if device is enabled
+	 */
+	val = of_get_property(np, "status", NULL);
+	if (val && !strcmp(val, "disabled")) {
+		printk(KERN_INFO "SATA port disabled via device-tree\n");
+		return 0;
+	}
+
+	/*
+	 * Extract register address reange from device tree and put it into
+	 * the platform device structure
+	 */
+	if (of_address_to_resource(np, 0, &res)) {
+		printk(KERN_ERR "%s: Can't get SATA register address\n",
+				__func__);
+		return -ENOMEM;
+	}
+	sata_resources[0].start = res.start;
+	sata_resources[0].end = res.end;
+
+	if (of_address_to_resource(np, 1, &res)) {
+		printk(KERN_ERR "%s: Can't get AHBDMA register address\n",
+				__func__);
+		return -ENOMEM;
+	}
+	sata_resources[1].start = res.start;
+	sata_resources[1].end = res.end;
+
+	/*
+	 * Extract IRQ number(s) from device tree and put them into
+	 * the platform device structure
+	 */
+	sata_resources[2].start = sata_resources[2].end =
+		irq_of_parse_and_map(np, 0);
+	sata_resources[3].start = sata_resources[3].end =
+		irq_of_parse_and_map(np, 1);
+
+	return platform_add_devices(ppc460ex_devs, ARRAY_SIZE(ppc460ex_devs));
+}
+
+static int __devexit ppc460ex_sata_remove(struct of_device *ofdev)
+{
+	/* Nothing to do here */
+	return 0;
+}
+
+static const struct of_device_id ppc460ex_sata_match[] = {
+	{ .compatible = "amcc,sata-460ex", },
+	{}
+};
+
+static struct of_platform_driver ppc460ex_sata_driver = {
+	.name = "sata-460ex",
+	.match_table = ppc460ex_sata_match,
+	.probe = ppc460ex_sata_probe,
+	.remove = ppc460ex_sata_remove,
+};
+
+static int __init ppc460ex_sata_init(void)
+{
+	return of_register_platform_driver(&ppc460ex_sata_driver);
+}
+device_initcall(ppc460ex_sata_init);
-- 
1.5.5
