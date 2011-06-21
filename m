Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 70BFDB6F90
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Jun 2011 22:18:32 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p5LC6WqW029560
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2011 06:06:32 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p5LCIHBb204034
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2011 06:18:17 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p5L6IFme023975
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2011 00:18:16 -0600
Date: Tue, 21 Jun 2011 08:19:55 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH] hwrng: ppc4xx - add support for ppc4xx TRNG
Message-ID: <20110621121955.GB2414@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Various PowerPC 4xx SoCs contain a TRNG embedded in the Security function.
This adds a device driver for that TRNG.

Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

---
 drivers/char/hw_random/Kconfig      |   12 +++
 drivers/char/hw_random/Makefile     |    1 +
 drivers/char/hw_random/ppc4xx-rng.c |  156 +++++++++++++++++++++++++++++++++++
 3 files changed, 169 insertions(+), 0 deletions(-)
 create mode 100644 drivers/char/hw_random/ppc4xx-rng.c

diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index a60043b..1d2ebc7 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -210,3 +210,15 @@ config HW_RANDOM_PICOXCELL
 	  module will be called picoxcell-rng.
 
 	  If unsure, say Y.
+
+config HW_RANDOM_PPC4XX
+	tristate "PowerPC 4xx generic true random number generator support"
+	depends on HW_RANDOM && PPC && 4xx
+	---help---
+	 This driver provides the kernel-side support for the TRNG hardware
+	 found in the security function of some PowerPC 4xx SoCs.
+
+	 To compile this driver as a module, choose M here: the
+	 module will be called ppc4xx-rng.
+
+	 If unsure, say N.
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index 3db4eb8..c88f244 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -20,3 +20,4 @@ obj-$(CONFIG_HW_RANDOM_MXC_RNGA) += mxc-rnga.o
 obj-$(CONFIG_HW_RANDOM_OCTEON) += octeon-rng.o
 obj-$(CONFIG_HW_RANDOM_NOMADIK) += nomadik-rng.o
 obj-$(CONFIG_HW_RANDOM_PICOXCELL) += picoxcell-rng.o
+obj-$(CONFIG_HW_RANDOM_PPC4XX) += ppc4xx-rng.o
diff --git a/drivers/char/hw_random/ppc4xx-rng.c b/drivers/char/hw_random/ppc4xx-rng.c
new file mode 100644
index 0000000..b8afa6a
--- /dev/null
+++ b/drivers/char/hw_random/ppc4xx-rng.c
@@ -0,0 +1,156 @@
+/*
+ * Generic PowerPC 44x RNG driver
+ *
+ * Copyright 2011 IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2 of the License.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/hw_random.h>
+#include <linux/delay.h>
+#include <linux/of_platform.h>
+#include <asm/io.h>
+
+#define PPC4XX_TRNG_DEV_CTRL 0x60080
+
+#define PPC4XX_TRNGE 0x00020000
+#define PPC4XX_TRNG_CTRL 0x0008
+#define PPC4XX_TRNG_CTRL_DALM 0x20
+#define PPC4XX_TRNG_STAT 0x0004
+#define PPC4XX_TRNG_STAT_B 0x1
+#define PPC4XX_TRNG_DATA 0x0000
+
+#define MODULE_NAME "ppc4xx_rng"
+
+static int ppc4xx_rng_data_present(struct hwrng *rng, int wait)
+{
+	void __iomem *rng_regs = (void __iomem *) rng->priv;
+	int busy, i, present = 0;
+
+	for (i = 0; i < 20; i++) {
+		busy = (in_le32(rng_regs + PPC4XX_TRNG_STAT) & PPC4XX_TRNG_STAT_B);
+		if (!busy || !wait) {
+			present = 1;
+			break;
+		}
+		udelay(10);
+	}
+	return present;
+}
+
+static int ppc4xx_rng_data_read(struct hwrng *rng, u32 *data)
+{
+	void __iomem *rng_regs = (void __iomem *) rng->priv;
+	*data = in_le32(rng_regs + PPC4XX_TRNG_DATA);
+	return 4;
+}
+
+static int ppc4xx_rng_enable(int enable)
+{
+	struct device_node *ctrl;
+	void __iomem *ctrl_reg;
+	int err = 0;
+	u32 val;
+
+	/* Find the main crypto device node and map it to turn the TRNG on */
+	ctrl = of_find_compatible_node(NULL, NULL, "amcc,ppc4xx-crypto");
+	if (!ctrl)
+		return -ENODEV;
+
+	ctrl_reg = of_iomap(ctrl, 0);
+	if (!ctrl_reg) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	val = in_le32(ctrl_reg + PPC4XX_TRNG_DEV_CTRL);
+
+	if (enable)
+		val |= PPC4XX_TRNGE;
+	else
+		val = val & ~PPC4XX_TRNGE;
+
+	out_le32(ctrl_reg + PPC4XX_TRNG_DEV_CTRL, val);
+	iounmap(ctrl_reg);
+
+out:
+	of_node_put(ctrl);
+
+	return err;
+}
+
+static struct hwrng ppc4xx_rng = {
+	.name = MODULE_NAME,
+	.data_present = ppc4xx_rng_data_present,
+	.data_read = ppc4xx_rng_data_read,
+};
+
+static int __devinit ppc4xx_rng_probe(struct platform_device *dev)
+{
+	void __iomem *rng_regs;
+	int err = 0;
+
+	rng_regs = of_iomap(dev->dev.of_node, 0);
+	if (!rng_regs)
+		return -ENODEV;
+
+	err = ppc4xx_rng_enable(1);
+	if (err)
+		return err;
+
+	out_le32(rng_regs + PPC4XX_TRNG_CTRL, PPC4XX_TRNG_CTRL_DALM);
+	ppc4xx_rng.priv = (unsigned long) rng_regs;
+
+	err = hwrng_register(&ppc4xx_rng);
+
+	return err;
+}
+
+static int __devexit ppc4xx_rng_remove(struct platform_device *dev)
+{
+	void __iomem *rng_regs = (void __iomem *) ppc4xx_rng.priv;
+
+	hwrng_unregister(&ppc4xx_rng);
+	ppc4xx_rng_enable(0);
+	iounmap(rng_regs);
+
+	return 0;
+}
+
+static struct of_device_id ppc4xx_rng_match[] = {
+	{ .compatible = "ppc4xx-rng", },
+	{ .compatible = "amcc,ppc460ex-rng", },
+	{ .compatible = "amcc,ppc440epx-rng", },
+	{},
+};
+
+static struct platform_driver ppc4xx_rng_driver = {
+	.driver = {
+		.name = MODULE_NAME,
+		.owner = THIS_MODULE,
+		.of_match_table = ppc4xx_rng_match,
+	},
+	.probe = ppc4xx_rng_probe,
+	.remove = ppc4xx_rng_remove,
+};
+
+static int __init ppc4xx_rng_init(void)
+{
+	return platform_driver_register(&ppc4xx_rng_driver);
+}
+module_init(ppc4xx_rng_init);
+
+static void __exit ppc4xx_rng_exit(void)
+{
+	platform_driver_unregister(&ppc4xx_rng_driver);
+}
+module_exit(ppc4xx_rng_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Josh Boyer <jwboyer@linux.vnet.ibm.com>");
+MODULE_DESCRIPTION("HW RNG driver for PPC 4xx processors");
-- 
1.7.4.4
