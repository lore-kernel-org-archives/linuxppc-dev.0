Return-Path: <wg@grandegger.com>
Message-ID: <487DD1BD.8040701@grandegger.com>
Date: Wed, 16 Jul 2008 12:47:25 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
Subject: [RFC] I2C: fsl-i2c: make device probing configurable via FDT
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Jean Delvare <khali@linux-fr.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently, the I2C buses are probed for HWMON I2C devices, which might
not be acceptable in same cases. This patch makes device probing
configurable through the property "probe" of the FDT I2C device node:

       i2c@3000 {
            ...
            compatible = "fsl-i2c";
            probe;
	    ...
        };

Assuming that systems using fsl-i2c should have proper platform data,
probing is disabled by default. Unfortunately, that's not the case and
various DTS files would require to be updated.

There have already been some discussion on this subject with Jean
under the following thread:

  http://ozlabs.org/pipermail/linuxppc-dev/2008-July/060008.html

Please comment.

Thanks,

Wolfgang.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/sysdev/fsl_soc.c |    4 ++++
 drivers/i2c/busses/i2c-mpc.c  |   17 ++++++++++++++---
 include/linux/fsl_devices.h   |    1 +
 3 files changed, 19 insertions(+), 3 deletions(-)

Index: linux-2.6-denx/drivers/i2c/busses/i2c-mpc.c
===================================================================
--- linux-2.6-denx.orig/drivers/i2c/busses/i2c-mpc.c
+++ linux-2.6-denx/drivers/i2c/busses/i2c-mpc.c
@@ -306,13 +306,21 @@ static const struct i2c_algorithm mpc_al
 	.functionality = mpc_functionality,
 };
 
-static struct i2c_adapter mpc_ops = {
+static struct i2c_adapter mpc_probe_ops = {
 	.owner = THIS_MODULE,
 	.name = "MPC adapter",
 	.id = I2C_HW_MPC107,
 	.algo = &mpc_algo,
 	.class = I2C_CLASS_HWMON,
-	.timeout = 1,
+ 	.timeout = 1,
+};
+
+static struct i2c_adapter mpc_ops = {
+	.owner = THIS_MODULE,
+	.name = "MPC adapter",
+	.id = I2C_HW_MPC107,
+	.algo = &mpc_algo,
+ 	.timeout = 1,
 };
 
 static int fsl_i2c_probe(struct platform_device *pdev)
@@ -354,7 +362,10 @@ static int fsl_i2c_probe(struct platform
 	mpc_i2c_setclock(i2c);
 	platform_set_drvdata(pdev, i2c);
 
-	i2c->adap = mpc_ops;
+	(i2c->flags & FSL_I2C_DEV_PROBE)
+		i2c->adap = mpc_probe_ops;
+	else
+		i2c->adap = mpc_ops;
 	i2c->adap.nr = pdev->id;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
Index: linux-2.6-denx/arch/powerpc/sysdev/fsl_soc.c
===================================================================
--- linux-2.6-denx.orig/arch/powerpc/sysdev/fsl_soc.c
+++ linux-2.6-denx/arch/powerpc/sysdev/fsl_soc.c
@@ -518,6 +518,10 @@ static int __init fsl_i2c_of_init(void)
 		if (flags)
 			i2c_data.device_flags |= FSL_I2C_DEV_CLOCK_5200;
 
+		flags = of_get_property(np, "probe", NULL);
+		if (flags)
+			i2c_data.device_flags |= FSL_I2C_DEV_PROBE;
+
 		ret =
 		    platform_device_add_data(i2c_dev, &i2c_data,
 					     sizeof(struct
Index: linux-2.6-denx/include/linux/fsl_devices.h
===================================================================
--- linux-2.6-denx.orig/include/linux/fsl_devices.h
+++ linux-2.6-denx/include/linux/fsl_devices.h
@@ -82,6 +82,7 @@ struct fsl_i2c_platform_data {
 /* Flags related to I2C device features */
 #define FSL_I2C_DEV_SEPARATE_DFSRR	0x00000001
 #define FSL_I2C_DEV_CLOCK_5200		0x00000002
+#define FSL_I2C_DEV_PROBE		0x00000004
 
 enum fsl_usb2_operating_modes {
 	FSL_USB2_MPH_HOST,
