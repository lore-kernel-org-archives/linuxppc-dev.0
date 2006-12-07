Return-Path: <b07421@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 81CAC67CB6
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 04:35:12 +1100 (EST)
Date: Thu, 7 Dec 2006 11:30:41 -0600
From: Scott Wood <scottwood@freescale.com>
To: i2c@lm-sensors.org
Subject: [PATCH] i2c: Move i2c-mpc.c from i2c_add_adapter() to
	i2c_register_adapter().
Message-ID: <20061207173041.GA22989@ld0162-tx32.am.freescale.net>
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

Call i2c_register_adapter() in i2c-mpc.c so that scan_static_board_info()
will pick it up.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This patch depends on David Brownell's patchset at
http://lists.lm-sensors.org/pipermail/i2c/2006-November/000516.html

 drivers/i2c/busses/i2c-mpc.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 29891b6..aefbca7 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -330,7 +330,8 @@ static int fsl_i2c_probe(struct platform
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.class_dev.dev = &pdev->dev;
-	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
+	i2c->adap.nr = pdev->id;
+	if ((result = i2c_register_adapter(&i2c->adap)) < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
 	}
-- 
1.4.2.3
