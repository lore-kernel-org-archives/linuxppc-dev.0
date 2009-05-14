Return-Path: <eha@doredevelopment.dk>
Received: from zmta01.irigo.dk (zmta01.cabocomm.dk [193.200.44.52])
	by ozlabs.org (Postfix) with ESMTP id CE254DDFE2
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 18:20:15 +1000 (EST)
Message-ID: <4A0BD1DB.4090305@doredevelopment.dk>
Date: Thu, 14 May 2009 10:10:03 +0200
From: Esben Haabendal <eha@doredevelopment.dk>
MIME-Version: 1.0
To: linux-i2c@vger.kernel.org
Subject: [PATCH] i2c-mpc: generate START condition after STOP caused by read
	i2c_msg
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This fixes MAL (arbitration lost) bug caused by illegal use of
RSTA (repeated START) after STOP condition generated after last byte
of reads.

Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
---
  drivers/i2c/busses/i2c-mpc.c |    9 +++++++--
  1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 4af5c09..9fe05d9 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -456,17 +456,22 @@ static int mpc_xfer(struct i2c_adapter *adap, 
struct i2c_msg *msgs, int num)
  	}

  	for (i = 0; ret >= 0 && i < num; i++) {
+		int restart = i;
  		pmsg = &msgs[i];
  		dev_dbg(i2c->dev,
  			"Doing %s %d bytes to 0x%02x - %d of %d messages\n",
  			pmsg->flags & I2C_M_RD ? "read" : "write",
  			pmsg->len, pmsg->addr, i + 1, num);
+		if (i > 0 && ((pmsg-1)->flags & I2C_M_RD))
+			restart = 0;
  		if (pmsg->flags & I2C_M_RD)
  			ret =
-			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+			    mpc_read(i2c, pmsg->addr, pmsg->buf, pmsg->len,
+				     restart);
  		else
  			ret =
-			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
+			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len,
+				      restart);
  	}
  	mpc_i2c_stop(i2c);
  	return (ret < 0) ? ret : num;
-- 
1.6.0.4
