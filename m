Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 429rq32fb0zF3Rx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Sep 2018 18:07:26 +1000 (AEST)
Message-Id: <055ff141d12942ed5750cc9e803e730de0e38c93.1536778520.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] watchdog: mpc8xxx: provide boot status
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Radu Rendec <radu.rendec@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org
Date: Thu, 13 Sep 2018 08:07:21 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc8xxx watchdog driver supports the following platforms:
- mpc8xx
- mpc83xx
- mpc86xx

Those three platforms have a 32 bits register which provides the
reason of the last boot, including whether it was caused by the
watchdog.

mpc8xx: Register RSR, bit SWRS (bit 3)
mpc83xx: Register RSR, bit SWRS (bit 28)
mpc86xx: Register RSTRSCR, bit WDT_RR (bit 11)

This patch maps the register as defined in the device tree and updates
wdt.bootstatus based on the value of the watchdog related bit. Then
the information can be retrieved via the WDIOC_GETBOOTSTATUS ioctl.

Hereunder is an exemple of devicetree for mpc8xx,
the Reset Status Register being at offset 0x288:

		WDT: watchdog@0 {
			compatible = "fsl,mpc823-wdt";
			reg = <0x0 0x10 0x288 0x4>;
		};

On the mpc83xx, RSR is at offset 0x910
On the mpc86xx, RSTRSCR is at offset 0xe0094

Suggested-by: Radu Rendec <radu.rendec@gmail.com>
Tested-by: Christophe Leroy <christophe.leroy@c-s.fr> # On mpc885
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/watchdog/mpc8xxx_wdt.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index aca2d6323f8a..2951a485a6b4 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -49,10 +49,12 @@ struct mpc8xxx_wdt {
 struct mpc8xxx_wdt_type {
 	int prescaler;
 	bool hw_enabled;
+	u32 rsr_mask;
 };
 
 struct mpc8xxx_wdt_ddata {
 	struct mpc8xxx_wdt __iomem *base;
+	u32 __iomem *rsr;
 	struct watchdog_device wdd;
 	spinlock_t lock;
 	u16 swtc;
@@ -137,6 +139,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	struct mpc8xxx_wdt_ddata *ddata;
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
+	struct device *dev = &ofdev->dev;
 
 	wdt_type = of_device_get_match_data(&ofdev->dev);
 	if (!wdt_type)
@@ -160,6 +163,22 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 		return -ENODEV;
 	}
 
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
+	ddata->rsr = devm_ioremap_resource(dev, res);
+	if (IS_ERR(ddata->rsr)) {
+		dev_info(dev, "Could not map reset status register");
+	} else {
+		u32 rsr_v = in_be32(ddata->rsr);
+		bool status = rsr_v & wdt_type->rsr_mask;
+
+		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
+		 /* clear reset status bits related to watchdog time */
+		out_be32(ddata->rsr, wdt_type->rsr_mask);
+
+		dev_info(dev, "Last boot was %s by watchdog (RSR = 0x%8.8x)\n",
+			 status ? "caused" : "not caused", rsr_v);
+	}
+
 	spin_lock_init(&ddata->lock);
 
 	ddata->wdd.info = &mpc8xxx_wdt_info,
@@ -216,6 +235,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.compatible = "mpc83xx_wdt",
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
+			.rsr_mask = BIT(3), /* RSR Bit 28 */
 		},
 	},
 	{
@@ -223,6 +243,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
 			.hw_enabled = true,
+			.rsr_mask = BIT(20), /* RSTRSCR Bit 11 */
 		},
 	},
 	{
@@ -230,6 +251,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x800,
 			.hw_enabled = true,
+			.rsr_mask = BIT(28), /* RSR Bit 3 */
 		},
 	},
 	{},
-- 
2.13.3
