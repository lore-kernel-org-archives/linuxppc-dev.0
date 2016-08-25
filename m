Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-pa0-x242.google.com (mail-pa0-x242.google.com
 [IPv6:2607:f8b0:400e:c03::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sKhsl4PkjzDr6Q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 21:34:35 +1000 (AEST)
Received: by mail-pa0-x242.google.com with SMTP id ez1so2977536pab.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Aug 2016 04:34:35 -0700 (PDT)
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
To: olof@lixom.net, mpm@selenic.com, herbert@gondor.apana.org.au,
 linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: prasannatsmkumar@gmail.com
Subject: [PATCH] hwrng: pasemi_rng.c: Migrate to managed API
Date: Thu, 25 Aug 2016 17:04:16 +0530
Message-Id: <1472124856-12767-1-git-send-email-prasannatsmkumar@gmail.com>
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

This patch is not tested with hardware as I don't have access to it.

Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
---
 drivers/char/hw_random/pasemi-rng.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/char/hw_random/pasemi-rng.c b/drivers/char/hw_random/pasemi-rng.c
index 699b725..0f03397 100644
--- a/drivers/char/hw_random/pasemi-rng.c
+++ b/drivers/char/hw_random/pasemi-rng.c
@@ -100,37 +100,18 @@ static int rng_probe(struct platform_device *ofdev)
 	void __iomem *rng_regs;
 	struct device_node *rng_np = ofdev->dev.of_node;
 	struct resource res;
-	int err = 0;
 
-	err = of_address_to_resource(rng_np, 0, &res);
-	if (err)
+	if (of_address_to_resource(rng_np, 0, &res))
 		return -ENODEV;
 
-	rng_regs = ioremap(res.start, 0x100);
-
+	rng_regs = devm_ioremap(&ofdev->dev, res.start, 0x100);
 	if (!rng_regs)
 		return -ENOMEM;
 
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
+	return devm_hwrng_register(&ofdev->dev, &pasemi_rng);
 }
 
 static const struct of_device_id rng_match[] = {
@@ -146,7 +127,6 @@ static struct platform_driver rng_driver = {
 		.of_match_table = rng_match,
 	},
 	.probe		= rng_probe,
-	.remove		= rng_remove,
 };
 
 module_platform_driver(rng_driver);
-- 
2.5.0
