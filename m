Return-Path: <geert@linux-m68k.org>
Received: from leibniz.telenet-ops.be (leibniz.telenet-ops.be
 [IPv6:2a02:1800:110:4::f00:d])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6scv4ZKczDt2L
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 22:31:11 +1100 (AEDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:14])
 by leibniz.telenet-ops.be (Postfix) with ESMTPS id 3t6scj6WcXzMqxvB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 12:31:01 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>, Simon Horman <horms@verge.net.au>,
 Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
Cc: Dirk Behme <dirk.behme@de.bosch.com>, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 7/7] soc: renesas: Identify SoC and register with the SoC
 bus
Date: Mon, 31 Oct 2016 12:30:55 +0100
Message-Id: <1477913455-5314-8-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Identify the SoC type and revision, and register this information with
the SoC bus, so it is available under /sys/devices/soc0/, and can be
checked where needed using soc_device_match().

Identification is done using the Product Register or Common Chip Code
Register, as declared in DT, or using a hardcoded fallback if missing.

Example:

    Detected Renesas r8a7791 (0x47) ES1.0
    ...
    # cat /sys/devices/soc0/{family,machine,soc_id,revision}
    Renesas
    Koelsch
    r8a7791
    ES1.0

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop SoC families and family names; use fixed "Renesas" instead,
  - Drop EMEV2, which doesn't have a chip ID register, and doesn't share
    devices with other SoCs,
  - Drop RZ/A1H and R-CAR M1A, which don't have chip ID registers (for
    M1A: not accessible from the ARM core?),
  - On arm, move "select SOC_BUS" from ARCH_RENESAS to Kconfig symbols
    for SoCs that provide a chip ID register,
  - Build renesas-soc only if SOC_BUS is enabled,
  - Use "renesas,prr" and "renesas,cccr" device nodes in DT if
    available, else fall back to hardcoded addresses for compatibility
    with existing DTBs,
  - Remove verification of product IDs; just print the ID instead,
  - Don't register the SoC bus if the chip ID register is missing,
  - Change R-Mobile APE6 fallback to use PRR instead of CCCR (it has
    both).
---
 arch/arm/mach-shmobile/Kconfig    |   3 +
 arch/arm64/Kconfig.platforms      |   1 +
 drivers/soc/renesas/Makefile      |   2 +
 drivers/soc/renesas/renesas-soc.c | 130 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 136 insertions(+)
 create mode 100644 drivers/soc/renesas/renesas-soc.c

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 6fbd9b7d2d67a18f..dd4d52dd71b4eab2 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -21,11 +21,13 @@ config ARCH_RCAR_GEN2
 	select PM
 	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
+	select SOC_BUS
 	select SYS_SUPPORTS_SH_CMT
 
 config ARCH_RMOBILE
 	bool
 	select PM_RMOBILE
+	select SOC_BUS
 	select SYS_SUPPORTS_SH_CMT
 	select SYS_SUPPORTS_SH_TMU
 
@@ -80,6 +82,7 @@ config ARCH_R8A7778
 config ARCH_R8A7779
 	bool "R-Car H1 (R8A77790)"
 	select ARCH_RCAR_GEN1
+	select SOC_BUS
 
 config ARCH_R8A7790
 	bool "R-Car H2 (R8A77900)"
diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 101794f5ce1008b7..b751c6891c6a51ed 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -143,6 +143,7 @@ config ARCH_RENESAS
 	select PM
 	select PM_GENERIC_DOMAINS
 	select RENESAS_IRQC
+	select SOC_BUS
 	help
 	  This enables support for the ARMv8 based Renesas SoCs.
 
diff --git a/drivers/soc/renesas/Makefile b/drivers/soc/renesas/Makefile
index 9e0bb329594c4fca..1652df037955e0e6 100644
--- a/drivers/soc/renesas/Makefile
+++ b/drivers/soc/renesas/Makefile
@@ -1,3 +1,5 @@
+obj-$(CONFIG_SOC_BUS)		+= renesas-soc.o
+
 obj-$(CONFIG_ARCH_R8A7743)	+= rcar-sysc.o r8a7743-sysc.o
 obj-$(CONFIG_ARCH_R8A7779)	+= rcar-sysc.o r8a7779-sysc.o
 obj-$(CONFIG_ARCH_R8A7790)	+= rcar-sysc.o r8a7790-sysc.o
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
new file mode 100644
index 0000000000000000..01104bfaefdb9f32
--- /dev/null
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -0,0 +1,130 @@
+/*
+ * Renesas SoC Identification
+ *
+ * Copyright (C) 2014-2016 Glider bvba
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; version 2 of the License.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sys_soc.h>
+
+
+#define CCCR	0xe600101c	/* Common Chip Code Register */
+#define PRR	0xff000044	/* Product Register */
+#define PRR3	0xfff00044	/* Product Register on R-Car Gen3 */
+
+static const struct of_device_id renesas_socs[] __initconst = {
+#ifdef CONFIG_ARCH_R8A73A4
+	{ .compatible = "renesas,r8a73a4",	.data = (void *)PRR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7740
+	{ .compatible = "renesas,r8a7740",	.data = (void *)CCCR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7743
+	{ .compatible = "renesas,r8a7743",	.data = (void *)PRR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7745
+	{ .compatible = "renesas,r8a7745",	.data = (void *)PRR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7779
+	{ .compatible = "renesas,r8a7779",	.data = (void *)PRR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7790
+	{ .compatible = "renesas,r8a7790",	.data = (void *)PRR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7791
+	{ .compatible = "renesas,r8a7791",	.data = (void *)PRR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7792
+	{ .compatible = "renesas,r8a7792",	.data = (void *)PRR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7793
+	{ .compatible = "renesas,r8a7793",	.data = (void *)PRR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7794
+	{ .compatible = "renesas,r8a7794",	.data = (void *)PRR, },
+#endif
+#ifdef CONFIG_ARCH_R8A7795
+	{ .compatible = "renesas,r8a7795",	.data = (void *)PRR3, },
+#endif
+#ifdef CONFIG_ARCH_R8A7796
+	{ .compatible = "renesas,r8a7796",	.data = (void *)PRR3, },
+#endif
+#ifdef CONFIG_ARCH_SH73A0
+	{ .compatible = "renesas,sh73a0",	.data = (void *)CCCR, },
+#endif
+	{ /* sentinel */ }
+};
+
+static int __init renesas_soc_init(void)
+{
+	struct soc_device_attribute *soc_dev_attr;
+	const struct of_device_id *match;
+	void __iomem *chipid = NULL;
+	struct soc_device *soc_dev;
+	struct device_node *np;
+	unsigned int product;
+
+	np = of_find_matching_node_and_match(NULL, renesas_socs, &match);
+	if (!np)
+		return -ENODEV;
+
+	of_node_put(np);
+
+	/* Try PRR first, then CCCR, then hardcoded fallback */
+	np = of_find_compatible_node(NULL, NULL, "renesas,prr");
+	if (!np)
+		np = of_find_compatible_node(NULL, NULL, "renesas,cccr");
+	if (np) {
+		chipid = of_iomap(np, 0);
+		of_node_put(np);
+	} else if (match->data) {
+		chipid = ioremap((uintptr_t)match->data, 4);
+	}
+	if (!chipid)
+		return -ENODEV;
+
+	product = readl(chipid);
+	iounmap(chipid);
+
+	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
+	if (!soc_dev_attr)
+		return -ENOMEM;
+
+	np = of_find_node_by_path("/");
+	of_property_read_string(np, "model", &soc_dev_attr->machine);
+	of_node_put(np);
+
+	soc_dev_attr->family = "Renesas";
+	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "ES%u.%u",
+					   ((product >> 4) & 0xf) + 1,
+					   product & 0xf);
+	soc_dev_attr->soc_id = kstrdup_const(strchr(match->compatible, ',') + 1,
+					     GFP_KERNEL);
+	pr_info("Detected %s %s (0x%02x) %s\n", soc_dev_attr->family,
+		soc_dev_attr->soc_id, (product >> 8) & 0xff,
+		soc_dev_attr->revision);
+
+	soc_dev = soc_device_register(soc_dev_attr);
+	if (IS_ERR(soc_dev)) {
+		kfree(soc_dev_attr->revision);
+		kfree_const(soc_dev_attr->soc_id);
+		kfree(soc_dev_attr);
+		return PTR_ERR(soc_dev);
+	}
+
+	return 0;
+}
+core_initcall(renesas_soc_init);
-- 
1.9.1
