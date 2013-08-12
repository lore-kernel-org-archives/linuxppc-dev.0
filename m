Return-Path: <B42677@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D45932C0138
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 12:33:06 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <linux-mmc@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH V3] mmc:of_spi: Update the code of getting voltage-ranges
Date: Mon, 12 Aug 2013 09:39:05 +0800
Message-ID: <1376271546-25085-3-git-send-email-Haijun.Zhang@freescale.com>
In-Reply-To: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: X.Xie@freescale.com, cbouatmailru@gmail.com, scottwood@freescale.com,
 cjb@laptop.org, Haijun Zhang <haijun.zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using function mmc_of_parse_voltage() to get voltage-ranges.

Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
---
changes for V3:
	- changes the type of ocr_mask and function mmc_of_parse_voltage

 drivers/mmc/host/of_mmc_spi.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index d720b5e..fd1928d 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -90,8 +90,7 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	struct device *dev = &spi->dev;
 	struct device_node *np = dev->of_node;
 	struct of_mmc_spi *oms;
-	const u32 *voltage_ranges;
-	int num_ranges;
+	u32 ocr_mask;
 	int i;
 	int ret = -EINVAL;
 
@@ -102,26 +101,10 @@ struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 	if (!oms)
 		return NULL;
 
-	voltage_ranges = of_get_property(np, "voltage-ranges", &num_ranges);
-	num_ranges = num_ranges / sizeof(*voltage_ranges) / 2;
-	if (!voltage_ranges || !num_ranges) {
-		dev_err(dev, "OF: voltage-ranges unspecified\n");
+	if (mmc_of_parse_voltage(np, &ocr_mask))
 		goto err_ocr;
-	}
-
-	for (i = 0; i < num_ranges; i++) {
-		const int j = i * 2;
-		u32 mask;
 
-		mask = mmc_vddrange_to_ocrmask(be32_to_cpu(voltage_ranges[j]),
-					       be32_to_cpu(voltage_ranges[j + 1]));
-		if (!mask) {
-			ret = -EINVAL;
-			dev_err(dev, "OF: voltage-range #%d is invalid\n", i);
-			goto err_ocr;
-		}
-		oms->pdata.ocr_mask |= mask;
-	}
+	oms->pdata.ocr_mask |= ocr_mask;
 
 	for (i = 0; i < ARRAY_SIZE(oms->gpios); i++) {
 		enum of_gpio_flags gpio_flags;
-- 
1.8.0
