Return-Path: <12o3l@tiscali.nl>
Received: from smtp-out2.tiscali.nl (smtp-out2.tiscali.nl [195.241.79.177])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EB91DE0A4
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 06:19:42 +1000 (EST)
Message-ID: <480F99D5.7070300@tiscali.nl>
Date: Wed, 23 Apr 2008 22:19:33 +0200
From: Roel Kluin <12o3l@tiscali.nl>
MIME-Version: 1.0
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] spi_mpc83xx: test below 0 on unsigned irq in
	mpc83xx_spi_probe()
Content-Type: text/plain; charset=ISO-8859-1
Cc: lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

mpc83xx_spi->irq is unsigned, so the test fails

Signed-off-by: Roel Kluin <12o3l@tiscali.nl>
---
diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index be15a62..033fd51 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -454,12 +454,12 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
 		goto put_master;
 	}
 
-	mpc83xx_spi->irq = platform_get_irq(dev, 0);
-
-	if (mpc83xx_spi->irq < 0) {
-		ret = -ENXIO;
+	ret = platform_get_irq(dev, 0);
+	if (ret < 0)
 		goto unmap_io;
-	}
+
+	mpc83xx_spi->irq = ret;
+	ret = 0;
 
 	/* Register for SPI Interrupt */
 	ret = request_irq(mpc83xx_spi->irq, mpc83xx_spi_irq,
