Return-Path: <w.sang@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 3B153DDEDD
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 04:31:58 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] Fix wrong 'no interrupt' handling in of_i2c
To: linuxppc-dev@ozlabs.org
Date: Sat, 28 Jun 2008 20:31:52 +0200
Message-ID: <20080628183141.15298.2758.stgit@octopus.labnet.pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If an I2C device node does not specify an interrupt, the .irq member of the
board_info struct was set to -1. This caused crashes on following
irq_dispose_mappings. Leave it NO_IRQ as returned from irq_of_parse_and_map.
(Suggesting -1 as 'i2c-no-irq' used to be a bug in linux/i2c.h.)

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
---

 drivers/of/of_i2c.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_i2c.c b/drivers/of/of_i2c.c
index b2ccdcb..500cb1e 100644
--- a/drivers/of/of_i2c.c
+++ b/drivers/of/of_i2c.c
@@ -90,8 +90,6 @@ void of_register_i2c_devices(struct i2c_adapter *adap,
 		}
 
 		info.irq = irq_of_parse_and_map(node, 0);
-		if (info.irq == NO_IRQ)
-			info.irq = -1;
 
 		if (of_find_i2c_driver(node, &info) < 0) {
 			irq_dispose_mapping(info.irq);
