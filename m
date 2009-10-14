Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC18CB7B75
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 14 Oct 2009 16:40:23 +1100 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n9E5eHOe030552
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2009 00:40:18 -0500
Subject: [Fwd: [PATCH 1/2] i2c-powermac: Refactor i2c_powermac_smbus_xfer]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary="=-LtT8/pyZ3oueHJQMbTtc"
Date: Wed, 14 Oct 2009 16:40:16 +1100
Message-Id: <1255498816.2347.38.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-LtT8/pyZ3oueHJQMbTtc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



--=-LtT8/pyZ3oueHJQMbTtc
Content-Disposition: inline
Content-Description: Forwarded message - [PATCH 1/2] i2c-powermac: Refactor
 i2c_powermac_smbus_xfer
Content-Type: message/rfc822

Return-Path: <khali@linux-fr.org>
X-Spam-Checker-Version: SpamAssassin 3.1.9 (2007-02-13) on gate.crashing.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0
 tests=AWL,BAYES_00,FORGED_RCVD_HELO autolearn=ham version=3.1.9
Received: from poutre.nerim.net (poutre.nerim.net [62.4.16.124]) by
 gate.crashing.org (8.14.1/8.13.8) with ESMTP id n9ACJhfi001996 for
 <benh@kernel.crashing.org>; Sat, 10 Oct 2009 07:19:54 -0500
Received: from localhost (localhost [127.0.0.1]) by poutre.nerim.net
 (Postfix) with ESMTP id C1C8A39DEA8; Sat, 10 Oct 2009 14:19:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at nerim.net
Received: from poutre.nerim.net ([127.0.0.1]) by localhost
 (poutre.nerim.net [127.0.0.1]) (amavisd-new, port 10024) with ESMTP id
 K6BAkdnl1mY0; Sat, 10 Oct 2009 14:19:07 +0200 (CEST)
Received: from hyperion.delvare (jdelvare.pck.nerim.net [62.212.121.182])
 by poutre.nerim.net (Postfix) with ESMTP id 3822139DEA2; Sat, 10 Oct 2009
 14:19:07 +0200 (CEST)
Date: Sat, 10 Oct 2009 14:19:08 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Linux I2C <linux-i2c@vger.kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] i2c-powermac: Refactor i2c_powermac_smbus_xfer
Message-ID: <20091010141908.0be884a5@hyperion.delvare>
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i586-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I wanted to add some error logging to the i2c-powermac driver, but
found that it was very difficult due to the way the
i2c_powermac_smbus_xfer function is organized. Refactor the code in
this function so that each low-level function is only called once.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
---
This needs testing! Thanks.

 drivers/i2c/busses/i2c-powermac.c |   85 +++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

--- linux-2.6.32-rc3.orig/drivers/i2c/busses/i2c-powermac.c	2009-10-10 14:08:39.000000000 +0200
+++ linux-2.6.32-rc3/drivers/i2c/busses/i2c-powermac.c	2009-10-10 14:13:04.000000000 +0200
@@ -49,48 +49,38 @@ static s32 i2c_powermac_smbus_xfer(	stru
 	int			rc = 0;
 	int			read = (read_write == I2C_SMBUS_READ);
 	int			addrdir = (addr << 1) | read;
+	int			mode, subsize, len;
+	u32			subaddr;
+	u8			*buf;
 	u8			local[2];
 
-	rc = pmac_i2c_open(bus, 0);
-	if (rc)
-		return rc;
+	if (size == I2C_SMBUS_QUICK || size == I2C_SMBUS_BYTE) {
+		mode = pmac_i2c_mode_std;
+		subsize = 0;
+		subaddr = 0;
+	} else {
+		mode = read ? pmac_i2c_mode_combined : pmac_i2c_mode_stdsub;
+		subsize = 1;
+		subaddr = command;
+	}
 
 	switch (size) {
         case I2C_SMBUS_QUICK:
-		rc = pmac_i2c_setmode(bus, pmac_i2c_mode_std);
-		if (rc)
-			goto bail;
-		rc = pmac_i2c_xfer(bus, addrdir, 0, 0, NULL, 0);
+		buf = NULL;
+		len = 0;
 	    	break;
         case I2C_SMBUS_BYTE:
-		rc = pmac_i2c_setmode(bus, pmac_i2c_mode_std);
-		if (rc)
-			goto bail;
-		rc = pmac_i2c_xfer(bus, addrdir, 0, 0, &data->byte, 1);
-	    	break;
         case I2C_SMBUS_BYTE_DATA:
-		rc = pmac_i2c_setmode(bus, read ?
-				      pmac_i2c_mode_combined :
-				      pmac_i2c_mode_stdsub);
-		if (rc)
-			goto bail;
-		rc = pmac_i2c_xfer(bus, addrdir, 1, command, &data->byte, 1);
+		buf = &data->byte;
+		len = 1;
 	    	break;
         case I2C_SMBUS_WORD_DATA:
-		rc = pmac_i2c_setmode(bus, read ?
-				      pmac_i2c_mode_combined :
-				      pmac_i2c_mode_stdsub);
-		if (rc)
-			goto bail;
 		if (!read) {
 			local[0] = data->word & 0xff;
 			local[1] = (data->word >> 8) & 0xff;
 		}
-		rc = pmac_i2c_xfer(bus, addrdir, 1, command, local, 2);
-		if (rc == 0 && read) {
-			data->word = ((u16)local[1]) << 8;
-			data->word |= local[0];
-		}
+		buf = local;
+		len = 2;
 	    	break;
 
 	/* Note that these are broken vs. the expected smbus API where
@@ -105,28 +95,35 @@ static s32 i2c_powermac_smbus_xfer(	stru
 	 * a repeat start/addr phase (but not stop in between)
 	 */
         case I2C_SMBUS_BLOCK_DATA:
-		rc = pmac_i2c_setmode(bus, read ?
-				      pmac_i2c_mode_combined :
-				      pmac_i2c_mode_stdsub);
-		if (rc)
-			goto bail;
-		rc = pmac_i2c_xfer(bus, addrdir, 1, command, data->block,
-				   data->block[0] + 1);
-
+		buf = data->block;
+		len = data->block[0] + 1;
 		break;
 	case I2C_SMBUS_I2C_BLOCK_DATA:
-		rc = pmac_i2c_setmode(bus, read ?
-				      pmac_i2c_mode_combined :
-				      pmac_i2c_mode_stdsub);
-		if (rc)
-			goto bail;
-		rc = pmac_i2c_xfer(bus, addrdir, 1, command,
-				   &data->block[1], data->block[0]);
+		buf = &data->block[1];
+		len = data->block[0];
 		break;
 
         default:
-	    	rc = -EINVAL;
+		return -EINVAL;
+	}
+
+	rc = pmac_i2c_open(bus, 0);
+	if (rc)
+		return rc;
+
+	rc = pmac_i2c_setmode(bus, mode);
+	if (rc)
+		goto bail;
+
+	rc = pmac_i2c_xfer(bus, addrdir, subsize, subaddr, buf, len);
+	if (rc)
+		goto bail;
+
+	if (size == I2C_SMBUS_WORD_DATA && read) {
+		data->word = ((u16)local[1]) << 8;
+		data->word |= local[0];
 	}
+
  bail:
 	pmac_i2c_close(bus);
 	return rc;


-- 
Jean Delvare

--=-LtT8/pyZ3oueHJQMbTtc--
