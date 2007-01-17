Return-Path: <hs@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 7A5D0DDF08
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 02:27:04 +1100 (EST)
Subject: I2C Warning on a 405GPr based board with actual 2.6.20-rc5 Kernel
From: Heiko Schocher <hs@denx.de>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 17 Jan 2007 16:10:09 +0100
Message-Id: <1169046609.5543.73.camel@Apollo>
Mime-Version: 1.0
Reply-To: hs@denx.de
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I have a 405Gpr based Board and use the I2C Bus. Today I tried the Linux
Kernel version 2.6.20-rc5, and get the following Warning:

i2c /dev entries driver
IBM IIC driver v2.1
**WARNING** I2C adapter driver [IBM IIC] forgot to specify physical
device; fix it!
ibm-iic0: using standard (100 kHz) mode

Hmm.. I solved it with the following patch, but I don t know if this is
the right way.

diff --git a/drivers/i2c/busses/i2c-ibm_iic.c
b/drivers/i2c/busses/i2c-ibm_iic.c
index 1898e99..140d7fe 100644
--- a/drivers/i2c/busses/i2c-ibm_iic.c
+++ b/drivers/i2c/busses/i2c-ibm_iic.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/platform_device.h>
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <linux/i2c.h>
@@ -737,6 +738,9 @@ static int __devinit iic_probe(struct ocp_device
*ocp){
 	adap->timeout = 1;
 	adap->retries = 1;
 
+	if (adap->dev.parent == NULL) {
+		adap->dev.parent = &platform_bus;
+	}
 	if ((ret = i2c_add_adapter(adap)) != 0){
 		printk(KERN_CRIT "ibm-iic%d: failed to register i2c adapter\n",
 			dev->idx);

thanks
Heiko
