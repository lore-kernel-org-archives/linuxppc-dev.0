Return-Path: <wg@denx.de>
Message-Id: <20090331124035.755987848@denx.de>
Date: Tue, 31 Mar 2009 14:37:31 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/8] powerpc: i2c-mpc: preserve I2C clocking
References: <20090331123727.853787299@denx.de>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The I2c node property "fsl,preserve-clocking" allows to overtake the
clock settings from the boot loader and avoids the hard-coded setting.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/i2c/busses/i2c-mpc.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

Index: linux-2.6/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6.orig/drivers/i2c/busses/i2c-mpc.c	2009-03-31 13:25:08.000000000 +0200
+++ linux-2.6/drivers/i2c/busses/i2c-mpc.c	2009-03-31 13:28:03.000000000 +0200
@@ -318,17 +318,24 @@
 {
 	int result = 0;
 	struct mpc_i2c *i2c;
+	int set_clock;
 
 	i2c = kzalloc(sizeof(*i2c), GFP_KERNEL);
 	if (!i2c)
 		return -ENOMEM;
 
-	if (of_get_property(op->node, "dfsrr", NULL))
-		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
-
-	if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
-			of_device_is_compatible(op->node, "mpc5200-i2c"))
-		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
+	if (of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
+		set_clock = 0;
+	} else {
+		set_clock = 1;
+
+		if (of_get_property(op->node, "dfsrr", NULL))
+			i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
+
+		if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
+		    of_device_is_compatible(op->node, "mpc5200-i2c"))
+			i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
+	}
 
 	init_waitqueue_head(&i2c->queue);
 
@@ -348,8 +355,9 @@
 			goto fail_request;
 		}
 	}
-	
-	mpc_i2c_setclock(i2c);
+
+	if (set_clock)
+		mpc_i2c_setclock(i2c);
 
 	dev_set_drvdata(&op->dev, i2c);
 
