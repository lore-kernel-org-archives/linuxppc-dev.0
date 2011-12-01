Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe006.messaging.microsoft.com [216.32.181.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id EB74BB6F68
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Dec 2011 04:33:23 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: <kumar.gala@freescale.com>, <grant.likely@secretlab.ca>,
 <linuxppc-dev@ozlabs.org>
Subject: [PATCH] i2c-mpc: use the cell-index property to enumerate the I2C
 adapters
Date: Thu, 1 Dec 2011 11:33:01 -0600
Message-ID: <1322760781-31226-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

An I2C device tree node can contain a 'cell-index' property that can be
used to enumerate the I2C devices.  If such a property exists, use it
to specify the I2C adapter number.

This feature is necessary for the Freescale PowerPC audio drivers (e.g.
on the P1022DS).  The "machine driver" needs to know the adapter number
for each I2C adapter, but it only has access to the device tree.
Previously, the I2C nodes always appeared in cell-index order, so the
dynamic numbering coincided with the cell-index property.  With commit
ab827d97 ("powerpc/85xx: Rework P1022DS device tree"), the I2C nodes are
unintentionally reversed in the device tree, and so the machine driver
guesses the wrong I2C adapter number.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 drivers/i2c/busses/i2c-mpc.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 107397a..8551c34 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -632,7 +632,19 @@ static int __devinit fsl_i2c_probe(struct platform_device *op)
 	i2c->adap.dev.parent = &op->dev;
 	i2c->adap.dev.of_node = of_node_get(op->dev.of_node);
 
-	result = i2c_add_adapter(&i2c->adap);
+	/*
+	 * If the I2C node has a "cell-index" property, use it to enumerate
+	 * the I2C adapter.
+	 */
+	prop = of_get_property(i2c->adap.dev.of_node, "cell-index", &plen);
+	if (prop && plen == sizeof(u32)) {
+		dev_dbg(i2c->dev, "using cell-index property %u", *prop);
+		i2c->adap.nr = *prop;
+		result = i2c_add_numbered_adapter(&i2c->adap);
+	} else {
+		result = i2c_add_adapter(&i2c->adap);
+	}
+
 	if (result < 0) {
 		dev_err(i2c->dev, "failed to add adapter\n");
 		goto fail_add;
-- 
1.7.3.4
