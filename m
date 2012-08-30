Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 74AB32C0040
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2012 20:40:13 +1000 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linux-i2c@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] i2c-mpc: Wait for STOP to hit the bus
Date: Thu, 30 Aug 2012 12:40:04 +0200
Message-Id: <1346323204-19210-1-git-send-email-Joakim.Tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpc_i2c_stop() only initiates STOP but does not wait for it to
hit the I2C bus. This is a problem when using I2C devices which
uses fairly long clock stretching just before STOP if you also
have an i2c-mux which may switch to another bus before STOP has
been processed.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---
 drivers/i2c/busses/i2c-mpc.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git drivers/i2c/busses/i2c-mpc.c drivers/i2c/busses/i2c-mpc.c
index 3d31879..c08f287 100644
--- drivers/i2c/busses/i2c-mpc.c
+++ drivers/i2c/busses/i2c-mpc.c
@@ -574,7 +574,23 @@ static int mpc_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
 			    mpc_write(i2c, pmsg->addr, pmsg->buf, pmsg->len, i);
 		}
 	}
-	mpc_i2c_stop(i2c);
+	mpc_i2c_stop(i2c); /* Initiate STOP */
+	orig_jiffies = jiffies;
+	/* Wait until STOP is seen, allow up to 1 s */
+	while (readb(i2c->base + MPC_I2C_SR) & CSR_MBB) {
+		if (time_after(jiffies, orig_jiffies + HZ)) {
+			u8 status = readb(i2c->base + MPC_I2C_SR);
+
+			dev_dbg(i2c->dev, "timeout\n");
+			if ((status & (CSR_MCF | CSR_MBB | CSR_RXAK)) != 0) {
+				writeb(status & ~CSR_MAL,
+				       i2c->base + MPC_I2C_SR);
+				mpc_i2c_fixup(i2c);
+			}
+			return -EIO;
+		}
+		cond_resched();
+	}
 	return (ret < 0) ? ret : num;
 }
 
-- 
1.7.8.6
