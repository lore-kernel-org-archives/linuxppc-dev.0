Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 172CEB7EC7
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 16:40:31 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n9E5ePSp030558
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2009 00:40:26 -0500
Subject: [Fwd: [PATCH 2/2] i2c-powermac: Log errors]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="=-76fqeOrXPD4Ojqz8K6Qu"
Date: Wed, 14 Oct 2009 16:40:24 +1100
Message-Id: <1255498824.2347.39.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-76fqeOrXPD4Ojqz8K6Qu
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-76fqeOrXPD4Ojqz8K6Qu
Content-Disposition: inline
Content-Description: Forwarded message - [PATCH 2/2] i2c-powermac: Log
 errors
Content-Type: message/rfc822

Return-Path: <khali@linux-fr.org>
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0
 tests=AWL,BAYES_00,FORGED_RCVD_HELO autolearn=ham version=3.1.9
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124]) by
 gate.crashing.org (8.14.1/8.13.8) with ESMTP id n9ACKxZb002105 for
 <benh@kernel.crashing.org>; Sat, 10 Oct 2009 07:21:00 -0500
Received: from localhost (localhost [127.0.0.1]) by poutre.nerim.net
 (Postfix) with ESMTP id 6776039DEA2; Sat, 10 Oct 2009 14:20:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from poutre.nerim.net ([127.0.0.1]) by localhost
 (poutre.nerim.net [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id
 TQy+E54IU-WM; Sat, 10 Oct 2009 14:20:26 +0200 (CEST)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
 by poutre.nerim.net (Postfix) with ESMTP id 6DC4C39DE6A; Sat, 10 Oct 2009
 14:20:26 +0200 (CEST)
Date: Sat, 10 Oct 2009 14:20:28 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 2/2] i2c-powermac: Log errors
Message-ID: <20091010142028.52f19518@hyperion.delvare>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Log errors when they happen, otherwise we have no idea what went
wrong.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
 drivers/i2c/busses/i2c-powermac.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/i2c/busses/i2c-powermac.c	2009-10-10 14:13:04.000000000 +0200
+++ linux-2.6.32-rc3/drivers/i2c/busses/i2c-powermac.c	2009-10-10 14:13:12.000000000 +0200
@@ -108,16 +108,25 @@ static s32 i2c_powermac_smbus_xfer(	stru
 	}
 
 	rc = pmac_i2c_open(bus, 0);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev, "Failed to open I2C, err %d\n", rc);
 		return rc;
+	}
 
 	rc = pmac_i2c_setmode(bus, mode);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev, "Failed to set I2C mode %d, err %d\n",
+			mode, rc);
 		goto bail;
+	}
 
 	rc = pmac_i2c_xfer(bus, addrdir, subsize, subaddr, buf, len);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev,
+			"I2C transfer at 0x%02x failed, size %d, err %d\n",
+			addrdir >> 1, size, rc);
 		goto bail;
+	}
 
 	if (size == I2C_SMBUS_WORD_DATA && read) {
 		data->word = ((u16)local[1]) << 8;
@@ -157,12 +166,21 @@ static int i2c_powermac_master_xfer(	str
 		addrdir ^= 1;
 
 	rc = pmac_i2c_open(bus, 0);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev, "Failed to open I2C, err %d\n", rc);
 		return rc;
+	}
 	rc = pmac_i2c_setmode(bus, pmac_i2c_mode_std);
-	if (rc)
+	if (rc) {
+		dev_err(&adap->dev, "Failed to set I2C mode %d, err %d\n",
+			pmac_i2c_mode_std, rc);
 		goto bail;
+	}
 	rc = pmac_i2c_xfer(bus, addrdir, 0, 0, msgs->buf, msgs->len);
+	if (rc < 0)
+		dev_err(&adap->dev, "I2C %s 0x%02x failed, err %d\n",
+			addrdir & 1 ? "read from" : "write to", addrdir >> 1,
+			rc);
  bail:
 	pmac_i2c_close(bus);
 	return rc < 0 ? rc : 1;


-- 
Jean Delvare

--=-76fqeOrXPD4Ojqz8K6Qu--
