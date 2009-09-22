Return-Path: <joakim.tjernlund@transmode.com>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4A1E0B7BB2
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Sep 2009 21:58:22 +1000 (EST)
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
To: linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Esben Haabendal <eha@doredevelopment.dk>
Subject: [PATCH] i2c-mpc: Do not generate STOP after read.
Date: Tue, 22 Sep 2009 13:50:42 +0200
Message-Id: <1253620242-18461-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Esben Haabendal <eha@doredevelopment.dk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The driver always ends a read with a STOP condition which
breaks subsequent I2C reads/writes in the same transaction as
these expect to do a repeated START(ReSTART).

This will also help I2C multimaster as the bus will not be released
after the first read, but when the whole transaction ends.

Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
---

This should also fix a problem reported by Esben Haabendal:

[PATCH v2] i2c-mpc: generate START condition after STOP caused by read i2c_msg

This fixes MAL (arbitration lost) bug caused by illegal use of
RSTA (repeated START) after STOP condition generated after last byte
of reads. With this patch, it is possible to do an i2c_transfer() with
additional i2c_msg's following the I2C_M_RD messages.

It still needs to be resolved if it is possible to fix this issue
by removing the STOP condition after reads in a robust way.

Signed-off-by: Esben Haabendal <eha@doredevelopment.dk>

 drivers/i2c/busses/i2c-mpc.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index cdb1858..88ae582 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -369,9 +369,6 @@ static int mpc_write(struct mpc_i2c *i2c, int target,
 	unsigned timeout = i2c->adap.timeout;
 	u32 flags = restart ? CCR_RSTA : 0;
 
-	/* Start with MEN */
-	if (!restart)
-		writeccr(i2c, CCR_MEN);
 	/* Start as master */
 	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
 	/* Write target byte */
@@ -400,9 +397,6 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 	int i, result;
 	u32 flags = restart ? CCR_RSTA : 0;
 
-	/* Start with MEN */
-	if (!restart)
-		writeccr(i2c, CCR_MEN);
 	/* Switch to read - restart */
 	writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX | flags);
 	/* Write target address byte - this time with the read flag set */
@@ -429,9 +423,9 @@ static int mpc_read(struct mpc_i2c *i2c, int target,
 		/* Generate txack on next to last byte */
 		if (i == length - 2)
 			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_TXAK);
-		/* Generate stop on last byte */
+		/* Do not generate stop on last byte */
 		if (i == length - 1)
-			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_TXAK);
+			writeccr(i2c, CCR_MIEN | CCR_MEN | CCR_MSTA | CCR_MTX);
 		data[i] = readb(i2c->base + MPC_I2C_DR);
 	}
 
-- 
1.6.4.3
