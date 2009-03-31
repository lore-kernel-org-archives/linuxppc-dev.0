Return-Path: <wg@grandegger.com>
Message-ID: <49D2767E.4080607@grandegger.com>
Date: Tue, 31 Mar 2009 22:01:02 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH v2] powerpc: i2c-mpc: preserve I2C clocking
Content-Type: text/plain; charset=ISO-8859-1
Cc: devicetree-discuss <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The i2c node property "fsl,preserve-clocking" allows to overtake the
clock settings from the boot loader avoiding the hard-coded settings.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 Documentation/powerpc/dts-bindings/fsl/i2c.txt |    2 ++
 drivers/i2c/busses/i2c-mpc.c                   |   20 +++++++++++---------
 2 files changed, 13 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6.orig/drivers/i2c/busses/i2c-mpc.c	2009-03-31 13:25:08.000000000 +0200
+++ linux-2.6/drivers/i2c/busses/i2c-mpc.c	2009-03-31 21:29:21.615721143 +0200
@@ -323,13 +323,6 @@
 	if (!i2c)
 		return -ENOMEM;
 
-	if (of_get_property(op->node, "dfsrr", NULL))
-		i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
-
-	if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
-			of_device_is_compatible(op->node, "mpc5200-i2c"))
-		i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
-
 	init_waitqueue_head(&i2c->queue);
 
 	i2c->base = of_iomap(op->node, 0);
@@ -348,8 +341,17 @@
 			goto fail_request;
 		}
 	}
-	
-	mpc_i2c_setclock(i2c);
+
+	if (!of_get_property(op->node, "fsl,preserve-clocking", NULL)) {
+		if (of_get_property(op->node, "dfsrr", NULL))
+			i2c->flags |= FSL_I2C_DEV_SEPARATE_DFSRR;
+
+		if (of_device_is_compatible(op->node, "fsl,mpc5200-i2c") ||
+		    of_device_is_compatible(op->node, "mpc5200-i2c"))
+			i2c->flags |= FSL_I2C_DEV_CLOCK_5200;
+
+		mpc_i2c_setclock(i2c);
+	}
 
 	dev_set_drvdata(&op->dev, i2c);
 
Index: linux-2.6/Documentation/powerpc/dts-bindings/fsl/i2c.txt
===================================================================
--- linux-2.6.orig/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2009-03-17 10:28:07.000000000 +0100
+++ linux-2.6/Documentation/powerpc/dts-bindings/fsl/i2c.txt	2009-03-31 21:35:51.527901532 +0200
@@ -20,6 +20,8 @@
    a digital filter sampling rate register
  - fsl5200-clocking : boolean; if defined, indicated that this device
    uses the FSL 5200 clocking mechanism.
+ - fsl,preserve-clocking : boolean; if defined, the clock settings
+   from the bootloader are preserved (not touched).
 
 Example :
 	i2c@3000 {
