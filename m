Return-Path: <Sergej.Stepanov@ids.de>
Received: from ares.ids.de (ares.ids.de [213.144.29.131])
	by ozlabs.org (Postfix) with ESMTP id 85814DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 17:41:13 +1000 (EST)
Received: from ares.ids.de (ares.ids.de [127.0.0.1])
	by ares.ids.de (PGP Universal) with ESMTP id AF368F490A1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Sep 2007 09:41:10 +0200 (CEST)
Subject: [PATCH] cmd_ctrl-callback is needed in plat_nand.c
From: Sergej Stepanov <Sergej.Stepanov@ids.de>
To: linuxppc-embedded@ozlabs.org, Vitaly Wool <vitalywool@gmail.com>
Date: Thu, 06 Sep 2007 09:41:10 +0200
Message-Id: <1189064470.3273.12.camel@p60635-ste.ids.de>
Mime-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

To get our board (IDS8247) to work with the driver the cmd_ctrl-callback is needed (controlling ALE/CLE/nCE).

Sigend-off-by: Sergej Stepanov <Sergej.Stepanov@ids.de>
---

diff -ruN linux-2.6.22.1-orig/drivers/mtd/nand/plat_nand.c linux-2.6.22.1_ids8247/drivers/mtd/nand/plat_nand.c
--- linux-2.6.22.1-orig/drivers/mtd/nand/plat_nand.c	2007-07-10 20:56:30.000000000 +0200
+++ linux-2.6.22.1_ids8247/drivers/mtd/nand/plat_nand.c	2007-08-02 10:54:34.000000000 +0200
@@ -66,7 +66,7 @@
 	data->chip.ecc.hwctl = pdata->ctrl.hwcontrol;
 	data->chip.ecc.layout = pdata->chip.ecclayout;
 	data->chip.ecc.mode = NAND_ECC_SOFT;
+	data->chip.cmd_ctrl = pdata->ctrl.cmd_ctrl;
 	platform_set_drvdata(pdev, data);
 
 	/* Scan to find existance of the device */
