Return-Path: <sfalco@harris.com>
Received: from mlbe2k1.cs.myharris.net (mlbe2k1.cs.myharris.net
	[137.237.90.88]) by ozlabs.org (Postfix) with ESMTP id 300B9DDF02
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 02:03:48 +1000 (EST)
Message-ID: <48AD91E1.4080304@harris.com>
Date: Thu, 21 Aug 2008 12:03:45 -0400
From: "Steven A. Falco" <sfalco@harris.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: I2C probe not happening
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm using DENX-2.6.26, and I've enabled the I2C_IBM_IIC on a Sequoia board,
but I don't see any probes happening.

It looks like of_register_i2c_devices is never being called.  According to
cscope, it would be called in i2c-ibm_of.c, but that file is not part of
the build.

i2c-ibm_of.c would be compiled if CONFIG_I2C_IBM_OF was selected, but there
is no place in the Kconfig files that I2C_IBM_OF is mentioned.  So, I added
it like so:

diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index e9f88fe..a221b15 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -247,9 +247,16 @@ config I2C_PIIX4
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-piix4.
 
+config I2C_IBM_OF
+	tristate "IBM PPC 4xx open-firmware driver"
+	depends on 4xx
+	help
+	  Use openfirmware driver mechanism.
+
 config I2C_IBM_IIC
 	tristate "IBM PPC 4xx on-chip I2C interface"
 	depends on 4xx
+	select I2C_IBM_OF
 	help
 	  Say Y here if you want to use IIC peripheral found on
 	  embedded IBM PPC 4xx based systems.

Also, I noticed that i2c-ibm_of.c doesn't have an entry for the 440EPx, so
I added one:

diff --git a/drivers/i2c/busses/i2c-ibm_of.c b/drivers/i2c/busses/i2c-ibm_of.c
index 08440ab..df35686 100644
--- a/drivers/i2c/busses/i2c-ibm_of.c
+++ b/drivers/i2c/busses/i2c-ibm_of.c
@@ -906,6 +906,7 @@ static const struct of_device_id ibm_iic_match[] = {
 	{ .compatible = "ibm,iic-405ex", },
 	{ .compatible = "ibm,iic-405exr", },
 	{ .compatible = "ibm,iic-405gp", },
+	{ .compatible = "ibm,iic-440epx", },
 	{ .compatible = "ibm,iic-440gp", },
 	{ .compatible = "ibm,iic-440gpx", },
 	{ .compatible = "ibm,iic-440grx", },

However, the file does not compile.  I get:

linux-2.6-denx/drivers/i2c/busses/i2c-ibm_of.c:702: 
error: 'struct i2c_board_info' has no member named 'driver_name'
make[4]: *** [drivers/i2c/busses/i2c-ibm_of.o] Error 1

So perhaps it should not be part of the build.  But in that case, I see
no way for the probes to run.

I must be missing something - hints gratefully accepted.

	Steve
