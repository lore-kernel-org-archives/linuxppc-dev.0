Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 41D372C032F
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2013 13:08:46 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: benh@kernel.crashing.org
Subject: =?UTF-8?q?=5BPATCH=202/8=5D=20IBM=20Akebono=3A=20Add=20a=20SDHCI=20platform=20driver?=
Date: Fri, 22 Nov 2013 13:08:30 +1100
Message-Id: <1385086116-10972-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
References: <1385086057-10884-1-git-send-email-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Chris Ball <cjb@laptop.org>,
 linux-mmc@vger.kernel.org, Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a SDHCI platform driver for the new IBM PPC476GTR SoC
which is on the Akebono board.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
Cc: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/host/Kconfig           |   12 ++++++++
 drivers/mmc/host/Makefile          |    1 +
 drivers/mmc/host/sdhci-of-476gtr.c |   60 ++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+)
 create mode 100644 drivers/mmc/host/sdhci-of-476gtr.c

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7fc5099..14210df 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -130,6 +130,18 @@ config MMC_SDHCI_OF_HLWD
 
 	  If unsure, say N.
 
+config MMC_SDHCI_OF_476GTR
+	tristate "SDHCI OF support for the IBM PPC476GTR SoC"
+	depends on MMC_SDHCI_PLTFM
+	depends on PPC_OF
+	help
+	  This selects the Secure Digital Host Controller Interface (SDHCI)
+	  found on the PPC476GTR SoC.
+
+	  If you have a controller with this interface, say Y or M here.
+
+	  If unsure, say N.
+
 config MMC_SDHCI_CNS3XXX
 	tristate "SDHCI support on the Cavium Networks CNS3xxx SoC"
 	depends on ARCH_CNS3XXX
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index c41d0c3..92beff3 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_MMC_SDHCI_DOVE)		+= sdhci-dove.o
 obj-$(CONFIG_MMC_SDHCI_TEGRA)		+= sdhci-tegra.o
 obj-$(CONFIG_MMC_SDHCI_OF_ESDHC)	+= sdhci-of-esdhc.o
 obj-$(CONFIG_MMC_SDHCI_OF_HLWD)		+= sdhci-of-hlwd.o
+obj-$(CONFIG_MMC_SDHCI_OF_476GTR)	+= sdhci-of-476gtr.o
 obj-$(CONFIG_MMC_SDHCI_BCM_KONA)	+= sdhci-bcm-kona.o
 obj-$(CONFIG_MMC_SDHCI_BCM2835)		+= sdhci-bcm2835.o
 
diff --git a/drivers/mmc/host/sdhci-of-476gtr.c b/drivers/mmc/host/sdhci-of-476gtr.c
new file mode 100644
index 0000000..1310f8c
--- /dev/null
+++ b/drivers/mmc/host/sdhci-of-476gtr.c
@@ -0,0 +1,60 @@
+/*
+ * drivers/mmc/host/sdhci-of-476gtr.c
+ *
+ * Copyright © 2013 Alistair Popple <alistair@popple.id.au> IBM Corporation
+ *
+ * Based on sdhci-of-hlwd.c
+ *
+ * Copyright (C) 2009 The GameCube Linux Team
+ * Copyright (C) 2009 Albert Herranz
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or (at
+ * your option) any later version.
+ */
+
+#include <linux/delay.h>
+#include <linux/module.h>
+#include <linux/mmc/host.h>
+#include "sdhci-pltfm.h"
+
+static const struct sdhci_ops sdhci_476gtr_ops = {
+};
+
+static const struct sdhci_pltfm_data sdhci_476gtr_pdata = {
+	.ops = &sdhci_476gtr_ops,
+};
+
+static int sdhci_476gtr_probe(struct platform_device *pdev)
+{
+	return sdhci_pltfm_register(pdev, &sdhci_476gtr_pdata, 0);
+}
+
+static int sdhci_476gtr_remove(struct platform_device *pdev)
+{
+	return sdhci_pltfm_unregister(pdev);
+}
+
+static const struct of_device_id sdhci_476gtr_of_match[] = {
+	{ .compatible = "ibm,476gtr-sdhci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_476gtr_of_match);
+
+static struct platform_driver sdhci_476gtr_driver = {
+	.driver = {
+		.name = "sdhci-476gtr",
+		.owner = THIS_MODULE,
+		.of_match_table = sdhci_476gtr_of_match,
+		.pm = SDHCI_PLTFM_PMOPS,
+	},
+	.probe = sdhci_476gtr_probe,
+	.remove = sdhci_476gtr_remove,
+};
+
+module_platform_driver(sdhci_476gtr_driver);
+
+MODULE_DESCRIPTION("PPC476GTR SDHCI OF driver");
+MODULE_AUTHOR("Alistair Popple");
+MODULE_LICENSE("GPL v2");
-- 
1.7.10.4
