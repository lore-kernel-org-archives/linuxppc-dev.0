Return-Path: <esbenhaabendal@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by ozlabs.org (Postfix) with ESMTP id 7C562B70F8
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 22:05:02 +1000 (EST)
Received: by qwj9 with SMTP id 9so4748928qwj.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 30 Aug 2010 05:04:59 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 30 Aug 2010 14:04:59 +0200
Message-ID: <AANLkTikH+H6+sXN_hcfm_guvUwgM-NKQ83nCwgAk-23G@mail.gmail.com>
Subject: [PATCH] of_mmc_spi: add card detect irq support
From: Esben Haabendal <esbenhaabendal@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
---
 drivers/mmc/host/of_mmc_spi.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/of_mmc_spi.c b/drivers/mmc/host/of_mmc_spi.c
index 1247e5d..e872b61 100644
--- a/drivers/mmc/host/of_mmc_spi.c
+++ b/drivers/mmc/host/of_mmc_spi.c
@@ -34,6 +34,7 @@ enum {
 struct of_mmc_spi {
        int gpios[NUM_GPIOS];
        bool alow_gpios[NUM_GPIOS];
+       int detect_irq;
        struct mmc_spi_platform_data pdata;
 };

@@ -61,6 +62,20 @@ static int of_mmc_spi_get_ro(struct device *dev)
        return of_mmc_spi_read_gpio(dev, WP_GPIO);
 }

+static int of_mmc_spi_init(struct device *dev,
+                          irqreturn_t (*irqhandler)(int, void *), void *mm=
c)
+{
+       struct of_mmc_spi *oms =3D to_of_mmc_spi(dev);
+       return request_threaded_irq(
+               oms->detect_irq, NULL, irqhandler, 0, dev_name(dev), mmc);
+}
+
+static void of_mmc_spi_exit(struct device *dev, void *mmc)
+{
+       struct of_mmc_spi *oms =3D to_of_mmc_spi(dev);
+       free_irq(oms->detect_irq, mmc);
+}
+
 struct mmc_spi_platform_data *mmc_spi_get_pdata(struct spi_device *spi)
 {
        struct device *dev =3D &spi->dev;
@@ -121,8 +136,14 @@ struct mmc_spi_platform_data
*mmc_spi_get_pdata(struct spi_device *spi)
        if (gpio_is_valid(oms->gpios[WP_GPIO]))
                oms->pdata.get_ro =3D of_mmc_spi_get_ro;

-       /* We don't support interrupts yet, let's poll. */
-       oms->pdata.caps |=3D MMC_CAP_NEEDS_POLL;
+       oms->detect_irq =3D irq_of_parse_and_map(np, 0);
+       if (oms->detect_irq !=3D NO_IRQ) {
+               oms->pdata.init =3D of_mmc_spi_init;
+               oms->pdata.exit =3D of_mmc_spi_exit;
+       }
+       else {
+               oms->pdata.caps |=3D MMC_CAP_NEEDS_POLL;
+       }

        dev->platform_data =3D &oms->pdata;
        return dev->platform_data;
--=20
1.7.1.1

--=20
Esben Haabendal, Senior Software Consultant
Dor=E9Development ApS, Ved Stranden 1, 9560 Hadsund, DK-Denmark
Phone: +45 51 92 53 93, E-mail: eha@doredevelopment.dk
WWW: http://www.doredevelopment.dk
