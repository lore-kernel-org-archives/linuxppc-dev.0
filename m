Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B665EDDEE6
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 01:07:45 +1000 (EST)
Date: Thu, 17 May 2007 09:59:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: i2c@lm-sensors.org
Subject: [PATCH] i2c: Convert i2c-mpc.c to use i2c_add_prenumbered_adapter().
Message-ID: <20070517145958.GB30423@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This allows platform code to preregister devices on the i2c bus.
---
 drivers/i2c/busses/i2c-mpc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index c6b6898..b7870de 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -329,7 +329,7 @@ static int fsl_i2c_probe(struct platform_device *pdev)
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
-	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
+	if ((result = i2c_add_prenumbered_adapter(&i2c->adap, pdev->id)) < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
 	}
-- 
1.5.0.3
