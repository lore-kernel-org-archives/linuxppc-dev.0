Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:6:4])
 by ozlabs.org (Postfix) with ESMTP id 1545E2C008F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Mar 2014 14:54:22 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linux-mmc@vger.kernel.org,
	chris@printf.net
Subject: [PATCH 1/5] SDHCI: Add a generic registration to the SDHCI platform
 driver
Date: Thu,  6 Mar 2014 14:52:24 +1100
Message-Id: <1394077948-8395-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1394077948-8395-1-git-send-email-alistair@popple.id.au>
References: <1394077948-8395-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a generic platform driver registration to the exiting SDHCI
platform driver using the devicetree compatibility string "generic-sdhci".

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 .../devicetree/bindings/mmc/sdhci-pltfm.txt        | 16 +++++++++++++
 drivers/mmc/host/sdhci-pltfm.c                     | 28 ++++++++++++++++++++++
 2 files changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-pltfm.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-pltfm.txt b/Documentation/devicetree/bindings/mmc/sdhci-pltfm.txt
new file mode 100644
index 0000000..3940659
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-pltfm.txt
@@ -0,0 +1,16 @@
+Generic SHDCI platform driver
+
+The generic SDHCI platform driver should support most SDHCI host
+controllers. It uses the compatible="generic-sdhci" property and
+supports the following device tree properties as described in mmc.txt.
+
+Supported properties (described in mmc.txt):
+- reg
+- interrupts
+- wp-inverted
+- broken-cd
+- no-1-8-v
+- keep-power-in-suspend
+- enable-sdio-wakeup
+- bus-width
+- clock-frequency
diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
index bef250e..696d1f6 100644
--- a/drivers/mmc/host/sdhci-pltfm.c
+++ b/drivers/mmc/host/sdhci-pltfm.c
@@ -260,6 +260,34 @@ const struct dev_pm_ops sdhci_pltfm_pmops = {
 EXPORT_SYMBOL_GPL(sdhci_pltfm_pmops);
 #endif	/* CONFIG_PM */
 
+static int sdhci_generic_probe(struct platform_device *pdev)
+{
+	return sdhci_pltfm_register(pdev, NULL, 0);
+}
+
+static int sdhci_generic_remove(struct platform_device *pdev)
+{
+	return sdhci_pltfm_unregister(pdev);
+}
+
+static const struct of_device_id sdhci_generic_of_match[] = {
+	{ .compatible = "generic-sdhci" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sdhci_generic_of_match);
+
+static struct platform_driver sdhci_generic_driver = {
+	.driver = {
+		.name = "sdhci-generic",
+		.owner = THIS_MODULE,
+		.of_match_table = sdhci_generic_of_match,
+		.pm = SDHCI_PLTFM_PMOPS,
+	},
+	.probe = sdhci_generic_probe,
+	.remove = sdhci_generic_remove,
+};
+module_platform_driver(sdhci_generic_driver);
+
 static int __init sdhci_pltfm_drv_init(void)
 {
 	pr_info("sdhci-pltfm: SDHCI platform and OF driver helper\n");
-- 
1.8.3.2
