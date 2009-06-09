Return-Path: <hsaito.ppc@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 0EF92B70C8
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 11:21:29 +1000 (EST)
Received: from densangw.densan.co.jp (densangw.densan.co.jp [218.222.200.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9AEFCDDD04
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 11:21:28 +1000 (EST)
Date: Tue, 09 Jun 2009 10:20:54 +0900 (JST)
Message-Id: <20090609.102054.125129248.saito@densan.co.jp>
To: linuxppc-dev@ozlabs.org
Subject: sensors can't be detected on i2c-mpc
From: Hide Saito <hsaito.ppc@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: saito@densan.co.jp
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

sensors can't be detected on i2c-mpc

Hi all,

The sensors can't be detected on the built-in I2C interface on the Freescale's MPC processors on linux-2.6.29.
If it is not yet fixed, I think that it is forgotten to set the following values in the class.

Signed-off-by: Hideo Saito <hsaito.ppc@gmail.com>
---
--- drivers/i2c/busses/i2c-mpc.c.org	2009-03-24 08:12:14.000000000 +0900
+++ drivers/i2c/busses/i2c-mpc.c	2009-06-04 08:50:34.000000000 +0900
@@ -304,16 +304,17 @@ static u32 mpc_functionality(struct i2c_
 
 static const struct i2c_algorithm mpc_algo = {
 	.master_xfer = mpc_xfer,
 	.functionality = mpc_functionality,
 };
 
 static struct i2c_adapter mpc_ops = {
 	.owner = THIS_MODULE,
+	.class = I2C_CLASS_HWMON | I2C_CLASS_SPD,
 	.name = "MPC adapter",
 	.algo = &mpc_algo,
 	.timeout = 1,
 };
 
 static int __devinit fsl_i2c_probe(struct of_device *op, const struct of_device_id *match)
 {
 	int result = 0;
