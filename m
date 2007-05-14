Return-Path: <david-b@pacbell.net>
Received: from smtp105.sbc.mail.mud.yahoo.com (smtp105.sbc.mail.mud.yahoo.com
	[68.142.198.204]) by ozlabs.org (Postfix) with SMTP id 17616DDE24
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 03:15:17 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: rtc-linux@googlegroups.com
Subject: [patch/rft 4/4] rtc-ds1307 platform update,
	powerpc mpc834x_itx and mpc8313_rdb
Date: Mon, 14 May 2007 09:46:41 -0700
MIME-Version: 1.0
Message-Id: <200705140946.41993.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org,
	James Chapman <jchapman@katalix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update powerpc platforms to support new-style rtc-ds1307 driver:

 - Make i2c-mpc driver use numbered adapter;
 - Update boards identified by defconfig to list a ds1339 device:
    * mpc834x_itx
    * mpc8313_rdb

Didn't update the pasemi reference board; public info doesn't say
which chip it uses.

UNTESTED

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
NOTE:  cc'd the relevant powerpc maintainers lists; patches 1-3
will be archived in the rtc and i2c lists.  I'd like to see these
get tested/fixed so that the rtc-ds1307 driver can swich completely
to use the new-style I2c driver model.

 arch/powerpc/platforms/83xx/mpc8313_rdb.c |   11 +++++++++++
 arch/powerpc/platforms/83xx/mpc834x_itx.c |   12 ++++++++++++
 drivers/i2c/busses/i2c-mpc.c              |    3 ++-
 3 files changed, 25 insertions(+), 1 deletion(-)

--- at91.orig/drivers/i2c/busses/i2c-mpc.c	2007-05-10 00:48:22.000000000 -0700
+++ at91/drivers/i2c/busses/i2c-mpc.c	2007-05-13 10:56:52.000000000 -0700
@@ -280,6 +280,7 @@ static struct i2c_adapter mpc_ops = {
 	.owner = THIS_MODULE,
 	.name = "MPC adapter",
 	.id = I2C_HW_MPC107,
+	/* .nr = 0, */
 	.algo = &mpc_algo,
 	.class = I2C_CLASS_HWMON,
 	.timeout = 1,
@@ -329,7 +330,7 @@ static int fsl_i2c_probe(struct platform
 	i2c->adap = mpc_ops;
 	i2c_set_adapdata(&i2c->adap, i2c);
 	i2c->adap.dev.parent = &pdev->dev;
-	if ((result = i2c_add_adapter(&i2c->adap)) < 0) {
+	if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
 		printk(KERN_ERR "i2c-mpc - failed to add adapter\n");
 		goto fail_add;
 	}
--- at91.orig/arch/powerpc/platforms/83xx/mpc834x_itx.c	2007-05-12 23:31:24.000000000 -0700
+++ at91/arch/powerpc/platforms/83xx/mpc834x_itx.c	2007-05-13 11:22:36.000000000 -0700
@@ -23,6 +23,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/i2c.h>
 
 #include <asm/system.h>
 #include <asm/atomic.h>
@@ -48,6 +49,15 @@ unsigned long isa_mem_base = 0;
  * Setup the architecture
  *
  */
+
+static struct i2c_board_info __initdata mpc834x_itx_i2c_devices[] = {
+	{ I2C_BOARD_INFO("rtc-ds1307", 0x68),
+	  .type = "ds1339",
+	  /* REVISIT .irq = IRQ2 ... this RTC has an alarm */
+	},
+	/* REVISIT: also has an eeprom */
+};
+
 static void __init mpc834x_itx_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -63,6 +73,8 @@ static void __init mpc834x_itx_setup_arc
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
+	i2c_register_board_info(0, mpc834x_itx_i2c_devices,
+			ARRAY_SIZE(mpc834x_itx_i2c_devices));
 }
 
 static void __init mpc834x_itx_init_IRQ(void)
--- at91.orig/arch/powerpc/platforms/83xx/mpc8313_rdb.c	2007-05-13 11:20:25.000000000 -0700
+++ at91/arch/powerpc/platforms/83xx/mpc8313_rdb.c	2007-05-13 11:21:49.000000000 -0700
@@ -14,6 +14,7 @@
  */
 
 #include <linux/pci.h>
+#include <linux/i2c.h>
 
 #include <asm/time.h>
 #include <asm/ipic.h>
@@ -38,6 +39,14 @@ unsigned long isa_mem_base = 0;
  * Setup the architecture
  *
  */
+static struct i2c_board_info __initdata mpc8313_rdb_i2c_devices[] = {
+	{ I2C_BOARD_INFO("rtc-ds1307", 0x68),
+	  .type = "ds1339",
+	  /* REVISIT .irq = IRQ4 ... this RTC has an alarm */
+	},
+	/* REVISIT: also has an eeprom and lm75 */
+};
+
 static void __init mpc8313_rdb_setup_arch(void)
 {
 #ifdef CONFIG_PCI
@@ -53,6 +62,8 @@ static void __init mpc8313_rdb_setup_arc
 
 	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
 #endif
+	i2c_register_board_info(0, mpc8313_i2c_devices,
+			ARRAY_SIZE(mpc8313_i2c_devices));
 }
 
 void __init mpc8313_rdb_init_IRQ(void)
