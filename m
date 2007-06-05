Return-Path: <philippe.lachenal@hotmail.fr>
Received: from bay0-omc1-s19.bay0.hotmail.com (bay0-omc1-s19.bay0.hotmail.com
	[65.54.246.91]) by ozlabs.org (Postfix) with ESMTP id 089FFDDE00
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 01:42:09 +1000 (EST)
Message-ID: <BAY122-F18923A7AA6D3A4D96A360085200@phx.gbl>
From: "Philippe Lachenal" <philippe.lachenal@hotmail.fr>
To: sl@powerlinux.fr, linuxppc-dev@ozlabs.org
Subject: MPC8349ea Random Device Generator driver 
Date: Tue, 05 Jun 2007 17:42:08 +0200
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_6439_310b_7972"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_6439_310b_7972
Content-Type: text/plain; charset=iso-8859-1; format=flowed

Hello !

I've made a driver for the MPC8349ea Random Device Generator, and I 
therefore submit it to your impartial judgment.. ;)
thanks a lot !

Lachenal Philippe

_________________________________________________________________
Windows Live Spaces : créez votre blog à votre image ! 
http://www.windowslive.fr/spaces

------=_NextPart_000_6439_310b_7972
Content-Type: text/x-patch; name="talitos-rng.diff"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="talitos-rng.diff"

diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
old mode 100644
new mode 100755
index 40a0194..b05980b
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -48,6 +48,24 @@ unsigned long isa_mem_base = 0;
  * Setup the architecture
  *
  */
+
+static struct of_device_id mpc834x_itx[] = {
+	{ .type = "soc", },
+	{ .type ="crypto", },
+	{},
+};
+
+static int __init mpc834x_itx_declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc834x_itx)){
+		printk("__init mpc834x_itx_declare_of_platform_devices error\n");
+		return 0;
+	}
+	of_platform_bus_probe(NULL, mpc834x_itx, NULL);
+	return 0;
+}
+device_initcall(mpc834x_itx_declare_of_platform_devices);
+
 static void __init mpc834x_itx_setup_arch(void)
 {
 #ifdef CONFIG_PCI
diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
index 7cda04b..187164e 100644
--- a/drivers/char/hw_random/Kconfig
+++ b/drivers/char/hw_random/Kconfig
@@ -105,3 +105,9 @@ config HW_RANDOM_PASEMI
 
 	  If unsure, say Y.
 
+config HW_RANDOM_MPC834X
+	tristate "MPC 834x Random Number Generator support"
+	depends on HW_RANDOM && MPC834x
+	default HW_RANDOM
+	---help---
+		blah
diff --git a/drivers/char/hw_random/Makefile b/drivers/char/hw_random/Makefile
index c8b7300..4feb8ca 100644
--- a/drivers/char/hw_random/Makefile
+++ b/drivers/char/hw_random/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_HW_RANDOM_VIA) += via-rng.o
 obj-$(CONFIG_HW_RANDOM_IXP4XX) += ixp4xx-rng.o
 obj-$(CONFIG_HW_RANDOM_OMAP) += omap-rng.o
 obj-$(CONFIG_HW_RANDOM_PASEMI) += pasemi-rng.o
+obj-$(CONFIG_HW_RANDOM_MPC834X) += talitos-rng.o
--- a/drivers/char/hw_random/talitos-rng.c	2007-06-05 16:58:09.780048750 +0200
+++ b/drivers/char/hw_random/talitos-rng.c	2007-06-05 17:01:52.000000000 +0200
@@ -0,0 +1,223 @@
+/*
+ * Driver for mpc83xx Random Number Generator
+ *
+ * inspired by Pasemi RNG Driver and Talitos driver for OCF Linux
+ *
+ * Copyright (C) 2007 Philippe Lachenal, PowerLinux
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/hw_random.h>
+
+#include <asm/of_platform.h>
+#include <asm/io.h>
+
+#define TALITOS_RNGSR		0x028	/* RNG status register */
+#define TALITOS_RNGSR_HI	0x02c	/* RNG status register */
+#define TALITOS_RNGSR_HI_RD	0x1	/* RNG Reset done */
+#define TALITOS_RNGSR_HI_OFL	0xff0000/* number of dwords in RNG output FIFO*/
+#define TALITOS_RNGDSR		0x010	/* RNG data size register */
+#define TALITOS_RNGDSR_HI	0x014	/* RNG data size register */
+#define TALITOS_RNG_FIFO	0x800	/* RNG FIFO - pool of random numbers */
+#define TALITOS_RNGISR		0x030	/* RNG Interrupt status register */
+#define TALITOS_RNGISR_HI	0x034	/* RNG Interrupt status register */
+#define TALITOS_RNGRCR		0x018	/* RNG Reset control register */
+#define TALITOS_RNGRCR_HI	0x01c	/* RNG Reset control register */
+#define TALITOS_RNGRCR_HI_SR	0x1	/* RNG RNGRCR:Software Reset */
+
+#define TALITOS_RNGRCR_HI_MI	0x00000002
+
+#define TALITOS_HDR_DONE_BITS	0xff000000
+
+#define TALITOS_HAS_EU_RNG		(1<<4)
+#define TALITOS_HAS_EUS_SEC_2_01	0x7f
+
+
+
+
+
+
+static int talitos_hwrng_data_present(struct hwrng *rng)
+{
+	void __iomem *rng_regs = (void __iomem *)rng->priv;
+
+
+	/* check for things like FIFO underflow */
+	
+	u32 v;
+
+	v = in_be32(rng_regs + TALITOS_RNGISR_HI);
+	if (unlikely(v)) {
+		printk(KERN_ERR "talitos_hwrng_data_present : RNGISR_HI error %08x\n", v);
+		 return 0;
+	}
+
+	/*
+	 * OFL is number of available 64-bit words, 
+	 * shift and convert to a 32-bit word count
+	 */
+	v = in_be32(rng_regs + TALITOS_RNGSR_HI);
+
+	v = (v & TALITOS_RNGSR_HI_OFL) >> (16 - 1);
+
+	return v;
+}
+
+
+static int talitos_hwrng_data_read(struct hwrng *rng, u32 *data)
+{
+	void __iomem *rng_regs = (void __iomem *)rng->priv;
+
+	data = in_be32(rng_regs + TALITOS_RNG_FIFO);
+	data = in_be32(rng_regs + TALITOS_RNG_FIFO + sizeof(u32));
+	
+	return 4;
+}
+
+static int talitos_hwrng_init(struct hwrng *rng)
+{
+
+	void __iomem *rng_regs = (void __iomem *)rng->priv;
+	u32 v;
+
+	/* reset RNG EU */
+	setbits32(rng_regs + TALITOS_RNGRCR_HI, TALITOS_RNGRCR_HI_SR); 
+
+	while ((in_be32(rng_regs + TALITOS_RNGSR_HI) 
+		& TALITOS_RNGSR_HI_RD) == 0)
+			cpu_relax();
+	/*
+	 * we tell the RNG to start filling the RNG FIFO
+	 * by writing the RNGDSR 
+	 */
+	v = in_be32(rng_regs + TALITOS_RNGDSR_HI);
+	out_be32(rng_regs + TALITOS_RNGDSR_HI, v);
+	/*
+	 * 64 bits of data will be pushed onto the FIFO every 
+	 * 256 SEC cycles until the FIFO is full.  The RNG then 
+	 * attempts to keep the FIFO full.
+	 */
+	v = in_be32(rng_regs + TALITOS_RNGISR_HI);
+	if (v) {
+		printk(KERN_ERR "TALITOS INIT : RNGISR_HI error %08x\n", v);
+		return 1;
+	}
+	/*
+	 * n.b. we need to add a FIPS test here - if the RNG is going 
+	 * to fail, it's going to fail at reset time
+	 */
+
+	return 0;
+}
+
+static void talitos_hwrng_cleanup(struct hwrng *rng)
+{
+	void __iomem *rng_regs = (void __iomem *)rng->priv;
+	
+	/* reset RNG EU */
+	setbits32(rng_regs + TALITOS_RNGRCR_HI, TALITOS_RNGRCR_HI_SR); 
+
+}
+
+
+
+
+static struct hwrng talitos_rng = {
+	.name		= "talitos_rng",
+	.init		= talitos_hwrng_init,
+	.cleanup	= talitos_hwrng_cleanup,
+	.data_present	= talitos_hwrng_data_present,
+	.data_read	= talitos_hwrng_data_read,
+};
+
+
+
+
+
+
+
+
+static int __devinit
+talitos_probe(struct of_device *ofdev, const struct of_device_id *match)
+
+{	
+	void __iomem *rng_regs;
+	struct device_node *rng_np = ofdev->node;
+	struct resource res;
+	int err = 0;
+
+	err = of_address_to_resource(rng_np, 0, &res);
+	if (err)
+		return -ENODEV;	
+
+
+	rng_regs = ioremap(res.start, (res.end - res.start));
+
+	if (!rng_regs)
+		return -ENOMEM;
+
+	talitos_rng.priv = (unsigned long) rng_regs ;	
+
+	printk(KERN_INFO "Registering Talitos RNG\n");
+
+	err = hwrng_register(&talitos_rng);
+	if (err){
+		printk(".............. failure\n");
+		iounmap(rng_regs);
+	}
+	return err;
+}
+
+
+
+static int
+talitos_remove(struct of_device *op)
+{
+	void __iomem *rng_regs = (void __iomem *)talitos_rng.priv;
+
+	hwrng_unregister(&talitos_rng);
+	iounmap(rng_regs);
+	return 0;
+}
+
+
+
+
+
+static struct of_device_id talitos_of_match[] = {
+        { .compatible = "talitos-rng", },
+        {},
+};
+
+
+static struct of_platform_driver talitos_driver = {
+	.name		= "talitos-rng",
+        .match_table    = talitos_of_match,
+	.probe		= talitos_probe,
+	.remove		= talitos_remove,
+};
+
+
+
+
+static int __init talitos_init(void)
+{
+	return of_register_platform_driver(&talitos_driver);
+}
+module_init(talitos_init);
+
+static void __exit talitos_exit(void)
+{
+	of_unregister_platform_driver(&talitos_driver);
+}
+module_exit(talitos_exit);
+
+MODULE_DESCRIPTION(" Hardware CRYPTO driver");
+MODULE_AUTHOR("Philippe LACHENAL, PowerLinux");
+MODULE_LICENSE("GPL");


------=_NextPart_000_6439_310b_7972--
