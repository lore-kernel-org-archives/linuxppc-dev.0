Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sS1Fx33RwzDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 04:13:56 +1000 (AEST)
Received: by mail-pa0-x244.google.com with SMTP id hm5so3644521pac.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Sep 2016 11:13:56 -0700 (PDT)
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To: olof@lixom.net, mpm@selenic.com, herbert@gondor.apana.org.au,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 darren@stevens-zone.net, clabbe.montjoie@gmail.com
Cc: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: [PATCH v2] hwrng: pasemi_rng.c: Migrate to managed API
Date: Sun,  4 Sep 2016 23:43:08 +0530
Message-Id: <1473012788-6262-1-git-send-email-prasannatsmkumar@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use devm_ioremap and devm_hwrng_register instead of ioremap and
hwrng_register. This removes unregistering and error handling code.

Changes in v2:
Remove hardcoded resource size in ioremap, use resource struct obtained
by calling platform_get_resource.

Removing hardcoded resource size was suggested by LABBE Corentin.

CC: Darren Stevens <darren@stevens-zone.net>

Suggested-by: LABBE Corentin <clabbe.montjoie@gmail.com>
Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 drivers/char/hw_random/pasemi-rng.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index 699b725..b4e32f7 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -95,42 +95,20 @@ static struct hwrng pasemi_rng = {
 	.data_read	= pasemi_rng_data_read,
 };
 
-static int rng_probe(struct platform_device *ofdev)
+static int rng_probe(struct platform_device *pdev)
 {
 	void __iomem *rng_regs;
-	struct device_node *rng_np = ofdev->dev.of_node;
-	struct resource res;
-	int err = 0;
+	struct resource *res;
 
-	err = of_address_to_resource(rng_np, 0, &res);
-	if (err)
-		return -ENODEV;
-
-	rng_regs = ioremap(res.start, 0x100);
-
-	if (!rng_regs)
-		return -ENOMEM;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	rng_regs = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(rng_regs))
+		return PTR_ERR(rng_regs);
 
 	pasemi_rng.priv = (unsigned long)rng_regs;
 
 	pr_info("Registering PA Semi RNG\n");
-
-	err = hwrng_register(&pasemi_rng);
-
-	if (err)
-		iounmap(rng_regs);
-
-	return err;
-}
-
-static int rng_remove(struct platform_device *dev)
-{
-	void __iomem *rng_regs = (void __iomem *)pasemi_rng.priv;
-
-	hwrng_unregister(&pasemi_rng);
-	iounmap(rng_regs);
-
-	return 0;
+	return devm_hwrng_register(&pdev->dev, &pasemi_rng);
 }
 
 static const struct of_device_id rng_match[] = {
@@ -146,7 +124,6 @@ static struct platform_driver rng_driver = {
 		.of_match_table = rng_match,
 	},
 	.probe		= rng_probe,
-	.remove		= rng_remove,
 };
 
 module_platform_driver(rng_driver);
-- 
2.5.0
