Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bbz93CRBzF3XG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 23:32:05 +1000 (AEST)
Message-Id: <4381d1515addcbc5329fbc955ef4a5074ab9afef.1536931725.git.christophe.leroy@c-s.fr>
In-Reply-To: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
References: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 2/3] watchdog: mpc8xxx: provide boot status
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Radu Rendec <radu.rendec@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org
Date: Fri, 14 Sep 2018 13:32:01 +0000 (UTC)
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

Hereunder is an example of devicetree for mpc8xx,
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
 drivers/watchdog/mpc8xxx_wdt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
index 1dcf5f10cdd9..4a4700458b17 100644
--- a/drivers/watchdog/mpc8xxx_wdt.c
+++ b/drivers/watchdog/mpc8xxx_wdt.c
@@ -47,6 +47,7 @@ struct mpc8xxx_wdt {
 struct mpc8xxx_wdt_type {
 	int prescaler;
 	bool hw_enabled;
+	u32 rsr_mask;
 };
 
 struct mpc8xxx_wdt_ddata {
@@ -136,6 +137,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 	u32 freq = fsl_get_sys_freq();
 	bool enabled;
 	struct device *dev = &ofdev->dev;
+	u32 __iomem *rsr = NULL;
 
 	wdt_type = of_device_get_match_data(dev);
 	if (!wdt_type)
@@ -159,6 +161,21 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
 		return -ENODEV;
 	}
 
+	res = platform_get_resource(ofdev, IORESOURCE_MEM, 1);
+	if (res)
+		rsr = ioremap(res->start, resource_size(res));
+	if (rsr) {
+		bool status = in_be32(rsr) & wdt_type->rsr_mask;
+
+		ddata->wdd.bootstatus = status ? WDIOF_CARDRESET : 0;
+		 /* clear reset status bits related to watchdog timer */
+		out_be32(rsr, wdt_type->rsr_mask);
+		iounmap(rsr);
+
+		dev_info(dev, "Last boot was %scaused by watchdog\n",
+			 status ? "" : "not ");
+	}
+
 	spin_lock_init(&ddata->lock);
 
 	ddata->wdd.info = &mpc8xxx_wdt_info,
@@ -216,6 +233,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.compatible = "mpc83xx_wdt",
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
+			.rsr_mask = BIT(3), /* RSR Bit SWRS */
 		},
 	},
 	{
@@ -223,6 +241,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x10000,
 			.hw_enabled = true,
+			.rsr_mask = BIT(20), /* RSTRSCR Bit WDT_RR */
 		},
 	},
 	{
@@ -230,6 +249,7 @@ static const struct of_device_id mpc8xxx_wdt_match[] = {
 		.data = &(struct mpc8xxx_wdt_type) {
 			.prescaler = 0x800,
 			.hw_enabled = true,
+			.rsr_mask = BIT(28), /* RSR Bit SWRS */
 		},
 	},
 	{},
-- 
2.13.3
