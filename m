Return-Path: <bbaudet@lacie.com>
Received: from gr-lafayette.lacie.com (199.5-14-84.ripe.coltfrance.com
	[84.14.5.199]) by ozlabs.org (Postfix) with ESMTP id 1FB3E680AC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 Aug 2005 02:15:20 +1000 (EST)
From: Bertrand BAUDET <bbaudet@lacie.com>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 11 Aug 2005 18:03:13 +0000
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hL5+C8vQ5tQ6M4H"
Message-Id: <200508111803.13712.bbaudet@lacie.com>
Subject: [PATCH] MPC52xxx I2C: make algo use of I2C_RSTA
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_hL5+C8vQ5tQ6M4H
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

This patch makes use of I2C RESTART sequence when sending severals i2c_msg
instead of the STOP and START sequence.

Some I2C component reset there internal values when a STOP is sent.
(like the Ricoh rs5c372b I2C RTC)

Patch is against DENX linuxppc CVS

Regards,
Bertrand

--Boundary-00=_hL5+C8vQ5tQ6M4H
Content-Type: text/x-diff; charset="us-ascii"; name="mpc52xx_i2c-algo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mpc52xx_i2c-algo.patch"

--- linuxppc_2_4_devel_new/drivers/i2c/i2c-algo-mpc5xxx.c	2004-05-08 18:49:39.000000000 +0200
+++ linuxppc_2_4_devel-lacie6/drivers/i2c/i2c-algo-mpc5xxx.c	2004-12-13 15:53:37.000000000 +0100
@@ -62,6 +62,14 @@
 	return;
 }
 
+static void i2c_restart(struct i2c_algo_mpc5xxx_data *algo_data)
+{
+	struct mpc5xxx_i2c *regs = algo_data->regs;
+
+	mpc5xxx_out(&regs->mcr, MPC5xxx_I2C_RSTA, MPC5xxx_I2C_RSTA);
+
+	return;
+}
 
 static void i2c_stop(struct i2c_algo_mpc5xxx_data *algo_data)
 {
@@ -311,13 +319,14 @@
 	int				status;
 	int				i;
 
+	if (wait_for_bb(algo_data))
+		return -EREMOTEIO;
+	
+	i2c_start(algo_data);
+	
 	for (i = 0; i < num; i++) {
 		pmsg = &msgs[i];
 
-		if (wait_for_bb(algo_data))
-			return -EREMOTEIO;
-
-		i2c_start(algo_data);
   		mpc5xxx_do_address(algo_data, pmsg, adap->retries);
 
 		if (wait_for_pin(algo_data, &status)) {
@@ -332,17 +341,21 @@
 
 		if (pmsg->flags & I2C_M_RD) {
 			ret = mpc5xxx_readbytes(adap, pmsg->buf, pmsg->len);
-			if (ret != pmsg->len)
+			if (ret != pmsg->len) {
+				i2c_stop(algo_data);
 				return (ret < 0) ? ret : -EREMOTEIO;
+			}
 		} else {
 			ret = mpc5xxx_sendbytes(adap, pmsg->buf, pmsg->len);
-			if (ret != pmsg->len)
+			if (ret != pmsg->len) {
+				i2c_stop(algo_data);
 				return (ret < 0) ? ret : -EREMOTEIO;
+			}
 		}
-
-		i2c_stop(algo_data);
+		if (i+1 < num) i2c_restart(algo_data);
 	}
-
+	
+	i2c_stop(algo_data);
 	return num;
 }
 

--Boundary-00=_hL5+C8vQ5tQ6M4H--
