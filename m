Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail1-relais-roc.national.inria.fr
 (mail1-relais-roc.national.inria.fr [192.134.164.82])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.inria.fr", Issuer "TERENA SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 433022C00D5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Aug 2012 03:41:48 +1000 (EST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Jochen Friedrich <jochen@scram.de>
Subject: [PATCH 1/6] i2c: cpm: use devm_ functions
Date: Sat, 25 Aug 2012 19:41:34 +0200
Message-Id: <1345916499-6657-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org,
 "Wolfram Sang \(embedded platforms\)" <w.sang@pengutronix.de>,
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 "Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Julia Lawall <Julia.Lawall@lip6.fr>

The various devm_ functions allocate memory that is released when a driver
detaches.  This patch uses these functions for data that is allocated in
the probe function of a platform device and is only freed in the remove
function.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
Not compiled.

 drivers/i2c/busses/i2c-cpm.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
index c1e1096..ec97415 100644
--- a/drivers/i2c/busses/i2c-cpm.c
+++ b/drivers/i2c/busses/i2c-cpm.c
@@ -640,7 +640,7 @@ static int __devinit cpm_i2c_probe(struct platform_device *ofdev)
 	struct cpm_i2c *cpm;
 	const u32 *data;
 
-	cpm = kzalloc(sizeof(struct cpm_i2c), GFP_KERNEL);
+	cpm = devm_kzalloc(&ofdev->dev, sizeof(struct cpm_i2c), GFP_KERNEL);
 	if (!cpm)
 		return -ENOMEM;
 
@@ -683,7 +683,6 @@ out_shut:
 	cpm_i2c_shutdown(cpm);
 out_free:
 	dev_set_drvdata(&ofdev->dev, NULL);
-	kfree(cpm);
 
 	return result;
 }
@@ -697,7 +696,6 @@ static int __devexit cpm_i2c_remove(struct platform_device *ofdev)
 	cpm_i2c_shutdown(cpm);
 
 	dev_set_drvdata(&ofdev->dev, NULL);
-	kfree(cpm);
 
 	return 0;
 }
