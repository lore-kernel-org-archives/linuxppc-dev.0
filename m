Return-Path: <eha@doredevelopment.dk>
Received: from zmta01.irigo.dk (zmta01.cabocomm.dk [193.200.44.52])
	by ozlabs.org (Postfix) with ESMTP id 27E31DE0E0
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 15:22:24 +1000 (EST)
Message-ID: <4A124202.4010201@doredevelopment.dk>
Date: Tue, 19 May 2009 07:22:10 +0200
From: Esben Haabendal <eha@doredevelopment.dk>
MIME-Version: 1.0
To: linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH v2] i2c-mpc: generate START condition after STOP caused by
	read i2c_msg
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
of reads. With this patch, it is possible to do an i2c_transfer() with
additional i2c_msg's following the I2C_M_RD messages.

It still needs to be resolved if it is possible to fix this issue
by removing the STOP condition after reads in a robust way.

Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>
---
  drivers/i2c/busses/i2c-mpc.c |    9 +++++++--
  1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 4af5c09..0199f9a 100644
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
+		if (i > 0 && ((pmsg - 1)->flags & I2C_M_RD))
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
1.6.3.1
